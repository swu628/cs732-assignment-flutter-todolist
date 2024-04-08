import 'package:app/data/database.dart';
import 'package:app/util/dialog_box.dart';
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
  void checkBoxChanged(bool? value, int index, bool allTasks,
      {bool remainingTasks = true}) {
    setState(() {
      if (allTasks) {
        // Directly update the task since it's from the "Total" list
        db.toDoList[index][1] = value;
      } else {
        List filteredList;
        if (remainingTasks) {
          // Work with remaining tasks if it's from the "Remaining" tab
          filteredList = db.toDoList.where((task) => !task[1]).toList();
        } else {
          // Work with completed tasks if it's from the "Completed" tab
          filteredList = db.toDoList.where((task) => task[1]).toList();
        }

        // Find the actual task in the main list using a unique identifier
        var actualTask = filteredList[index];
        int actualIndex = db.toDoList.indexOf(actualTask);
        db.toDoList[actualIndex][1] = value;
      }
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text('To Do Tasks'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Total'),
              Tab(text: 'Remaining'),
              Tab(text: 'Completed'), // New tab for completed tasks
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTaskListView(allTasks: true),
            _buildTaskListView(allTasks: false, remainingTasks: true),
            _buildTaskListView(
                allTasks: false,
                remainingTasks: false), // View for completed tasks
          ],
        ),
        // Below is the add new task feature
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }

  Widget _buildTaskListView(
      {required bool allTasks, bool remainingTasks = true}) {
    List tasks;
    if (allTasks) {
      tasks = db.toDoList;
    } else if (remainingTasks) {
      // Filter for remaining tasks
      tasks = db.toDoList.where((task) => !task[1]).toList();
    } else {
      // Filter for completed tasks
      tasks = db.toDoList.where((task) => task[1]).toList();
    }
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ToDoTile(
          taskName: tasks[index][0],
          taskCompleted: tasks[index][1],
          dueDate: tasks[index][2],
          onChanged: (value) => checkBoxChanged(value, index, allTasks,
              remainingTasks: remainingTasks),
          deleteFunction: (context) => deleteTask(index),
        );
      },
    );
  }
}
