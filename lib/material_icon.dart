import 'package:flutter/material.dart';

class MaterialIcon extends StatelessWidget {
  const MaterialIcon(
      this.icon, {
        Key? key,
        this.size = 24,
        this.color,
      }) : super(key: key);

  final IconData icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}