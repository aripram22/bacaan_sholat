import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Todo {
  final String id;
  final String title;
  final String completed;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TodoAPI _todoAPI = TodoAPI();
  late Future<List<Todo>> _todos;

  @override
  void initState() {
    super.initState();
    _todos = _todoAPI.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Center(
        child: FutureBuilder<List<Todo>>(
          future: _todos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Todo>? todos = snapshot.data;
              return ListView.builder(
                itemCount: todos!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index].title),
                    subtitle: Text('hafalan: ${todos[index].completed.toString()}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editTaskDialog(context, todos[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteTask(todos[index].id);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      _editTaskDialog(context, todos[index]);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _editTaskDialog(BuildContext context, Todo todo) async {
    TextEditingController _titleController =
        TextEditingController(text: todo.title);
    TextEditingController _completedController =
        TextEditingController(text: todo.completed);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: _completedController,
                decoration: InputDecoration(labelText: "Hafalan"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _updateTask(
                  todo.id,
                  _titleController.text,
                  _completedController.text,
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTask(String taskId) async {
    await _todoAPI.deleteTask(taskId).then((_) {
      setState(() {
        _todos = _todoAPI.fetchTasks();
      });
    }).catchError((error) {
      print('Error deleting task: $error');
    });
    return;
  }

  void _updateTask(String taskId, String newTitle, String newCompleted) {
    _todoAPI.updateTask(taskId, {
      'title': newTitle,
      'completed': newCompleted,
    }).then((_) {
      setState(() {
        _todos = _todoAPI.fetchTasks();
      });
    }).catchError((error) {
      print('Error updating task: $error');
    });
  }

  Future<void> _addTaskDialog(BuildContext context) async {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _completedController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: _completedController,
                decoration: InputDecoration(labelText: "Hafalan"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addTask(
                  _titleController.text,
                  _completedController.text,
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _addTask(String taskTitle, String completed) {
    _todoAPI.addTask({
      'title': taskTitle,
      'completed': completed,
    }).then((_) {
      setState(() {
        _todos = _todoAPI.fetchTasks();
      });
    }).catchError((error) {
      print('Error adding task: $error');
    });
  }
}

class TodoAPI {
  final String baseUrl = 'https://65622890dcd355c083249e79.mockapi.io/todo'; // Ganti dengan URL API Anda

  Future<List<Todo>> fetchTasks() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((task) => Todo.fromJson(task)).toList();
    } else {
      throw Exception('Gagal memuat daftar tugas');
    }
  }

  Future<void> deleteTask(String taskId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$taskId'));
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus tugas');
    }
  }

  Future<void> updateTask(String taskId, Map<String, String> updatedTaskData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$taskId'),
      body: json.encode(updatedTaskData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui tugas');
    }
  }

  Future<void> addTask(Map<String, Object> taskData) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode(taskData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan tugas');
    }
  }
}
