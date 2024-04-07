import 'package:app/data/database.dart';
import 'package:app/util/dialog_box.dart';
import 'package:app/util/task_counter.dart';
import 'package:app/util/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // If this is the first time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // Text controller
  final _taskController = TextEditingController();
  final _dateController = TextEditingController();

  // This function is called when the checkbox is tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    // Update the database when the user tapped on the checkbox of a task
    db.updateDatabase();
  }

  void saveNewTask() {
    if (_taskController.text.trim().isEmpty) {
      // Show an alert dialog or a Snackbar if the task name is empty

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                // Change the header and button color to red theme
                primary: Colors.red,
              ),
            ),
            child: AlertDialog(
              title: Text('Error'),
              content: Container(
                // Make the size responsive, 80% of screen width, 0.06% of screen height
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Text('Task name cannot be empty.'),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ),
          );
        },
      );
      return; // Return early to prevent saving an empty task
    }

    setState(() {
      db.toDoList.add([_taskController.text, false, _dateController.text]);
      _taskController.clear();
      _dateController.clear();
    });
    Navigator.of(context).pop(); // Close the dialog
    db.updateDatabase(); // Update the database when the user added a task
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            taskController: _taskController,
            dateController: _dateController,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(), // Close the dialog
          );
        });
  }

// This function will delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase(); // Update the database when the user deletes a task
  }

  @override
  Widget build(BuildContext context) {
    int totalTasks = db.getTotalTasks();
    int remainingTasks = db.getRemainingTasks();

    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text('To Do'),
          backgroundColor: Colors.yellow,
        ),
        // Below is the add new task feature
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Below display total and remaining tasks
            TaskCounter(
              totalTasks: totalTasks,
              remainingTasks: remainingTasks,
            ),
            // Below display list of tasks
            Expanded(
              child: ListView.builder(
                itemCount: db.toDoList.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                    taskName: db.toDoList[index][0],
                    taskCompleted: db.toDoList[index][1],
                    dueDate: db.toDoList[index][2],
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFunction: (context) => deleteTask(index),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
