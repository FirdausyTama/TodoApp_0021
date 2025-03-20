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
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}