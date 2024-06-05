import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class Todo {
  final String name;
  final int number;

  Todo({
    required this.name,
    required this.number,
  });
}

class TodoApp extends StatefulWidget {
  @override
  State<TodoApp> createState() => _TodoAppState();

}

class _TodoAppState extends State<TodoApp> {
  final List<Todo> todos = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contact List'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Number'),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      final name = nameController.text;
                      final number = int.tryParse(numberController.text) ?? 0;
                      setState(() {
                        todos.add(Todo(name: name, number: number));
                      });
                      nameController.clear();
                      numberController.clear();
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Text(todo.name),
                    subtitle: Text('Number: ${todo.number}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}