import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = []; // Create an empty list

  // Reference the box
  final _myBox = Hive.box('mybox');

  // Create initial data - run this method if this is the first time ever the user opening this app
  void createInitialData() {
    toDoList = [];
  }

  // Load the data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // Update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }

    // Get the total count of tasks
  int getTotalTasks() {
    return toDoList.length;
  }

  // Get the count of tasks that are not completed
  int getRemainingTasks() {
    int remaining = toDoList.where((task) => task[1] == false).length;
    return remaining;
  }
}
