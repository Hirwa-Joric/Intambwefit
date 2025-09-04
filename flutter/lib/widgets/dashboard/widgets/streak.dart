import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wger/helpers/date.dart';
import 'package:wger/l10n/generated/app_localizations.dart';
import 'package:wger/providers/routines.dart';
import 'package:wger/theme/theme.dart';

class DashboardStreakWidget extends StatelessWidget {
  const DashboardStreakWidget({super.key});

  int _computeCurrentStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    dates.sort((a, b) => b.compareTo(a));

    // Use today if worked out today; otherwise allow yesterday as a start point
    DateTime cursor = DateTime.now();
    if (!dates.any((d) => d.isSameDayAs(cursor))) {
      cursor = cursor.subtract(const Duration(days: 1));
      if (!dates.any((d) => d.isSameDayAs(cursor))) return 0;
    }

    int streak = 0;
    while (true) {
      if (dates.any((d) => d.isSameDayAs(cursor))) {
        streak += 1;
        cursor = cursor.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }

  int _computeBestStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    dates.sort();
    int best = 0;
    int current = 1;
    for (int i = 1; i < dates.length; i++) {
      final prev = dates[i - 1];
      final today = dates[i];
      final diff = today.difference(prev).inDays;
      if (diff == 1) {
        current += 1;
      } else if (diff == 0) {
        // same calendar day, ignore
        continue;
      } else {
        if (current > best) best = current;
        current = 1;
      }
    }
    if (current > best) best = current;
    return best;
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    final provider = context.watch<RoutinesProvider>();
    final sessions = provider
        .getPlans()
        .expand((r) => r.sessions.map((s) => s.session.date))
        .toList();

    final current = _computeCurrentStreak(sessions);
    final best = _computeBestStreak(sessions);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [wgerPrimaryButtonColor, wgerPrimaryColor],
                ),
              ),
              child: const Icon(Icons.local_fire_department, color: Colors.white, size: 34),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(i18n.dayStreakLabel, style: Theme.of(context).textTheme.titleMedium),
                  Text('$current',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text('${i18n.bestLabel}: $best', style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
