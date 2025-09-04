import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wger/providers/routines.dart';
import 'package:wger/theme/theme.dart';

class DashboardPlanRingWidget extends StatelessWidget {
  const DashboardPlanRingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final routines = context.watch<RoutinesProvider>();
    final routine = routines.activeRoutine;

    int total = 0;
    int completed = 0;
    if (routine != null) {
      final iterationDays = routine.dayDataCurrentIteration
          .where((d) => d.day != null && !(d.day!.isRest))
          .toList();
      total = iterationDays.length;
      completed = iterationDays.where((d) => !d.date.isAfter(DateTime.now())).length;
    }

    final progress = (total > 0) ? completed / total : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 10,
                    value: progress,
                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                    valueColor: const AlwaysStoppedAnimation<Color>(wgerPrimaryColor),
                  ),
                  Text('${(progress * 100).round()}%',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PLAN', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('${routine?.name ?? 'No active plan'}',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('$completed of $total trainings',
                      style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

