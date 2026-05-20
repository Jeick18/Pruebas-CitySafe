import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthLogo extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const AuthLogo({
    super.key,
    this.title = 'City Safe',
    this.subtitle = 'Tu seguridad en un solo lugar',
    this.icon = Icons.shield,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Icon(icon, size: 64, color: theme.colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          title,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900, 
            color: theme.colorScheme.primary,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2, curve: Curves.easeOutCubic);
  }
}
