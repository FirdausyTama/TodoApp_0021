import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController _taskCtr = TextEditingController(); 
  final _formKey = GlobalKey<FormState>();
  final List<String> task = [];
  final List<bool> _isChecked = [];
  final List<String> taskDate = [];
  bool _isSubmited = false;
  final ScrollController _scrollController = ScrollController();
  DateTime? _selectedDate;

  // Moved method inside the class
  void addTask() {
    setState(() {
      task.add(_taskCtr.text);
      taskDate.add(
        DateFormat('dd-MM-yyyy HH:mm').format(_selectedDate!),
      );
      _isChecked.add(false);
      _isSubmited = false;
      _selectedDate = null;
      _taskCtr.clear();
    });

     Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

   @override
  void dispose() {
    // Hapus controller untuk mencegah memory leak
    _taskCtr.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('From Page'),
        centerTitle: true,
      ),
      body: Padding(padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),),
    );
  }
}