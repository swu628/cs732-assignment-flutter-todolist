import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final String? dueDate;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    this.dueDate, // This allows the user to not set a due date
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.yellow,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // To have checkbox and task name on the same row
            Row(
              children: [
                // Checkbox
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),

                // Task name
                // Allows the text to occupy the remaining space
                Expanded(
                  child: Text(
                    taskName,
                    style: TextStyle(
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                    overflow: TextOverflow.ellipsis, // Handle overflow
                  ),
                ),

                // Delete task
                IconButton(
                  onPressed: () => deleteFunction?.call(context),
                  icon: Icon(Icons.close),
                  tooltip: 'Delete task', // Provide a tooltip for delete icon
                ),
              ],
            ),

            // Display due date below the checkbox, taskname and delete icon
            // Due date is only displayed when the user have set a due date
            if (dueDate!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Due date: " + dueDate!,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
