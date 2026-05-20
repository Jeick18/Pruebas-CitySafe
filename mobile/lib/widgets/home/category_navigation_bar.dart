import 'package:flutter/material.dart';

class CategoryNavigationBar extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;

  const CategoryNavigationBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: categories.map((cat) {
            final isSelected = selectedCategory == cat['name'];
            return InkWell(
              onTap: () {
                onCategorySelected(isSelected ? null : cat['name']);
              },
              borderRadius: BorderRadius.circular(16),
              hoverColor: theme.colorScheme.primaryContainer.withValues(
                alpha: 0.3,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 20 : 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      cat['icon'],
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onPrimaryContainer,
                      size: 26,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      Text(
                        cat['name'],
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
