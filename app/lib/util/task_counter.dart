import 'package:flutter/material.dart';

class TaskCounter extends StatelessWidget {
  final int totalTasks;
  final int remainingTasks;

  const TaskCounter({
    super.key,
    required this.totalTasks,
    required this.remainingTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Tasks: $totalTasks',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            'Remaining: $remainingTasks',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
