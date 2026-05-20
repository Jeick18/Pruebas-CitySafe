import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IncidentCard extends StatelessWidget {
  final Map<String, dynamic> incident;
  final int index;
  final VoidCallback? onDelete; // Callback for deletion

  const IncidentCard({
    super.key,
    required this.incident,
    required this.index,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: ValueKey(incident['id'] ?? incident.hashCode),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
      onDismissed: (direction) {
        if (onDelete != null) {
          onDelete!();
        }
      },
      child: Card(
        elevation: 0,
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: (incident["color"] as Color).withValues(
              alpha: 0.2,
            ),
            child: Icon(incident["icon"], color: incident["color"]),
          ),
          title: Text(
            incident["title"],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            incident["description"] ?? 'Sin descripción',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            incident["time"],
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ).animate().fadeIn(delay: Duration(milliseconds: 400 + (index * 50))),
    );
  }
}
