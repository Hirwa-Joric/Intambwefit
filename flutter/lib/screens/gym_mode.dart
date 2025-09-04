/*
 * This file is part of wger Workout Manager <https://github.com/wger-project>.
 * Copyright (C) 2020, 2021 wger Team
 *
 * wger Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wger/providers/routines.dart';
import 'package:wger/widgets/routines/gym_mode/gym_mode.dart';

class GymModeArguments {
  final int routineId;
  final int dayId;
  final int iteration;

  const GymModeArguments(this.routineId, this.dayId, this.iteration);
}

class GymModeScreen extends StatelessWidget {
  const GymModeScreen();

  static const routeName = '/gym-mode';

  @override
  Widget build(BuildContext context) {
    final maybeArgs = ModalRoute.of(context)!.settings.arguments;
    if (maybeArgs is! GymModeArguments) {
      return _missingSelectionScaffold(context);
    }
    final args = maybeArgs as GymModeArguments;

    final routinesProvider = context.read<RoutinesProvider>();
    final routine = routinesProvider.findById(args.routineId);
    if (routine == null) {
      return _missingSelectionScaffold(context);
    }

    final dayDataDisplayCandidates = routine.dayData.where(
      (e) => e.iteration == args.iteration && e.day?.id == args.dayId,
    );
    final dayDataGymCandidates = routine.dayDataGym.where(
      (e) => e.iteration == args.iteration && e.day?.id == args.dayId,
    );
    if (dayDataDisplayCandidates.isEmpty || dayDataGymCandidates.isEmpty) {
      return _missingSelectionScaffold(context);
    }
    final dayDataDisplay = dayDataDisplayCandidates.first;
    final dayDataGym = dayDataGymCandidates.first;

    return Scaffold(
      body: SafeArea(
        child: Consumer<RoutinesProvider>(
          builder: (context, value, child) => GymMode(dayDataGym, dayDataDisplay, args.iteration),
        ),
      ),
    );
  }

  Widget _missingSelectionScaffold(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('No routine/day selected for Gym Mode.'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/workout-plans-list'),
                child: const Text('Choose a routine'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
