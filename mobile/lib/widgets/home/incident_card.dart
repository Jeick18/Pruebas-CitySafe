import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IncidentCard extends StatelessWidget {
  final Map<String, dynamic> incident;
  final int index;

  const IncidentCard({super.key, required this.incident, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (incident["color"] as Color).withValues(alpha: 0.2),
          child: Icon(
            incident["icon"],
            color: incident["color"],
          ),
        ),
        title: Text(
          incident["title"],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(incident["location"]),
        trailing: Text(
          incident["time"],
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 400 + (index * 50)));
  }
}
