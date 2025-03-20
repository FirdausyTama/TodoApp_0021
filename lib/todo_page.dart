import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}