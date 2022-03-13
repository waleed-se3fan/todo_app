import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Widget? child;
  final Function()? onPressed;
  final Function()? onLongPress;
  const RoundButton({
    Key? key,
    this.size = 40.0,
    this.backgroundColor = const Color(0xFF4C4F5E),
    this.child,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: size, height: size),
      shape: const CircleBorder(),
      elevation: 0,
      fillColor: backgroundColor,
      child: child,
      onPressed: onPressed,
      onLongPress: onLongPress,
    );
  }
}
