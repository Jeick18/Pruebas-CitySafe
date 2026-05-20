import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../screens/login_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'City Safe',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onPrimaryContainer,
                  letterSpacing: -0.5,
                ),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
              Text(
                'Tu ciudad segura',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer
                      .withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            customBorder: const CircleBorder(),
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.surface,
              child: Icon(
                Icons.person_rounded,
                color: theme.colorScheme.primary,
              ),
            ),
          ).animate().scale(delay: 300.ms, curve: Curves.easeOutBack),
        ],
      ),
    );
  }
}
