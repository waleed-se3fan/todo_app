import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
  String title;
  String description;
  bool? isDone = false;

  Task({required this.title, this.description = ''});

  Task.fromStorage(
      {required this.title, required this.description, required this.isDone});

  void edit({required String newTitle, required String newDescription}) {
    title = newTitle;
    description = newDescription;
  }
}

class TaskList {
  final List<Task> _contents = [];
  UnmodifiableListView<Task> get contents => UnmodifiableListView(_contents);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void addTask({String title = '', String description = ''}) {
    _contents.add(Task(title: title, description: description));
  }

  void loadTask(
      {String title = '', String description = '', required bool isDone}) {
    _contents.add(Task.fromStorage(
        title: title, description: description, isDone: isDone));
  }

  void edit(
      {required task,
      required String newTitle,
      required String newDescription}) {
    task.title = newTitle;
    task.description = newDescription;
  }

  void removeTask(Task task) => _contents.remove(task);

  void clear() => _contents.clear();

  Future<bool> loadFromPrefs() async {

    final prefs = await _prefs;
    final List<String>? cachedTitles = prefs.getStringList('list_titles');
    final List<String>? cachedDescriptions =
        prefs.getStringList('list_descriptions');
    final List<String>? cachedStatuses = prefs.getStringList('list_statuses');

    if (cachedTitles != null) {
      for (int i = 0; i < cachedTitles.length; i++) {
        loadTask(
            title: cachedTitles[i],
            description: cachedDescriptions?[i] ?? '',
            isDone: cachedStatuses?[i] == 'true' ? true : false);
      }
      return true;
    }
    return false;
  }

  Future<bool> saveToPrefs() async {
    final prefs = await _prefs;
    List<String> titles = [];
    List<String> descriptions = [];
    List<String> statuses = [];
    for (var i = 0; i < contents.length; i++) {
      titles.add(contents[i].title.toString());
      descriptions.add(contents[i].description.toString());
      statuses.add(contents[i].isDone.toString());
    }
    final status = (await prefs.setStringList('list_titles', titles) &&
        await prefs.setStringList('list_descriptions', descriptions) &&
        await prefs.setStringList('list_statuses', statuses));
    return status;
  }
}
