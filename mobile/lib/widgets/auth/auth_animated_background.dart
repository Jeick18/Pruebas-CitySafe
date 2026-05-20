import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthAnimatedBackground extends StatelessWidget {
  const AuthAnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          top: -size.width * 0.2,
          right: -size.width * 0.2,
          child: M3EShape(
            Shapes.circle,
            width: size.width * 0.8,
            height: size.width * 0.8,
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .moveY(begin: -15, end: 15, duration: 4.seconds, curve: Curves.easeInOutSine)
          .animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutCubic),
        ),
        Positioned(
          bottom: -size.width * 0.2,
          left: -size.width * 0.2,
          child: M3EShape(
            Shapes.slanted,
            width: size.width * 0.9,
            height: size.width * 0.9,
            color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.4),
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .moveX(begin: -20, end: 20, duration: 5.seconds, curve: Curves.easeInOutSine)
          .animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutCubic),
        ),
      ],
    );
  }
}
