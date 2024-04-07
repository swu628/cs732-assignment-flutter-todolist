import 'package:app/util/my_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogBox extends StatelessWidget {
  final taskController;
  final dateController;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.taskController,
    required this.dateController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: Container(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Get user input for task name
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: "Add a new task",
              ),
            ),

            // Get user input for due date
            TextField(
              controller: dateController,
              decoration:
                  InputDecoration(hintText: "Select due date (optional)"),
              readOnly: true, // Prevent keyboard from showing
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    pickedDate = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                  }
                  dateController.text =
                      DateFormat('yyyy-MM-dd – HH:mm').format(pickedDate);
                }
              },
            ),

            // Save and cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "Save", onPressed: onSave),
                const SizedBox(width: 8),
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
