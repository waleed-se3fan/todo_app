import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/task_list.dart';
import '../widgets/round_button.dart';
import '../widgets/task_tile.dart';


class MainPageMobile extends StatefulWidget {
  const MainPageMobile({Key? key}) : super(key: key);

  @override
  _MainPageMobileState createState() => _MainPageMobileState();
}

class _MainPageMobileState extends State<MainPageMobile> {
  final listController = TaskList();
  final scrollController = ScrollController();

  void initialLoad() async {
    //This implementation is really poor but I don't know how a json-type format could be used,
    //or whether prefs even allows this anymore
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cachedTitles = prefs.getStringList('list_titles');
    final List<String>? cachedDescriptions =
        prefs.getStringList('list_descriptions');
    final List<String>? cachedStatuses = prefs.getStringList('list_statuses');

    if (cachedTitles != null) {
      setState(() {
        for (int i = 0; i < cachedTitles.length; i++) {
          listController.loadTask(
              title: cachedTitles[i],
              description: cachedDescriptions![i],
              isDone: cachedStatuses![i] == 'true' ? true : false);
        }
      });
    }
  }

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 104,
      duration: const Duration(seconds: 1, milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('ToDo App'),
        actions: [
          //Button to delete all counters.
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              if (listController.contents.isNotEmpty) {
                final result = await showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Take Care',
                    ),
                    content: const Text(
                      'Do you want to delete all tasks',
                    ),
                    actions: [
                      //"No" button
                      TextButton(
                        child: Text(
                          'no',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                        onPressed: () => Navigator.pop(context, 'No'),
                      ),
                      TextButton(
                        child: Text(
                          'yes',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                        onPressed: () {
                          Navigator.pop(context, 'Yes');
                        },
                      ),
                    ],
                  ),
                );
                if (result == 'Yes') {
                  setState(() => listController.clear());
                  listController.saveToPrefs();
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('You havn,t any tasks')));
              }
            },
          ),
        ],
      ),
      floatingActionButton: RoundButton(
        size: 48,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          String title = '';
          String description = '';
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: const Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      autofocus: true,
                      cursorColor: Theme.of(context).colorScheme.primary,
                      decoration: const InputDecoration(
                        hintText: 'Task',
                      ),
                      onChanged: (value) {
                        setState(() => title = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      cursorColor: Theme.of(context).colorScheme.primary,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                      onChanged: (value) => description = value,
                    ),
                  ],
                ),
                actions: <TextButton>[
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                  ),
                  TextButton(
                    child: Text(
                      'Add',
                      style: title != ''
                          ? Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary)
                          : Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface),
                    ),
                    onPressed:
                        title != '' ? () => Navigator.pop(context, 'OK') : null,
                  ),
                ],
              ),
            ),
          );
          if (result == 'OK') {
            setState(() => listController.addTask(
                title: title, description: description));
            listController.saveToPrefs();
            _scrollDown();
          }
        },
      ),
      //ListView that generates all the tiles for the counters.
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80, top: 8),
        shrinkWrap: true,
        itemCount: listController.contents.length,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) => TaskTile(
          task: listController.contents[index],
          updateCallback: () {
            setState(() {
              listController.saveToPrefs();
            });
          },
          deleteCallback: (task) {
            setState(() => listController.removeTask(task));
            listController.saveToPrefs();
          }
        ),
      ),
    );
  }
}
