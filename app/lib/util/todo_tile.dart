import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),

        // To have checkbox and task name on the same row
        child: Row(
          children: [
            // Checkbox
            Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
              activeColor: Colors.black,
            ),

            // Task name
            Expanded(
              // Allows the text to occupy the remaining space
              child: Text(
                taskName,
                style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
                overflow: TextOverflow.ellipsis, // This will handle overflow
              ),
            ),

            // Delete task
            IconButton(
              onPressed: () => deleteFunction
                  ?.call(context), // Call deleteFunction with context
              icon: Icon(Icons.close), // Wrap Icons.delete in an Icon widget
              tooltip: 'Delete Task', // Provide a tooltip for delete icon
            ),
          ],
        ),
      ),
    );
  }
}
