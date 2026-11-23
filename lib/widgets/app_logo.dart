import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double radius;
  final IconData icon;

  const AppLogo({
    super.key,
    this.radius = 36,
    this.icon = Icons.person_add_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return CircleAvatar(
      radius: radius,
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, size: radius, color: color),
    );
  }
}
