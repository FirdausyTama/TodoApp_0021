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
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'Task Date: \n',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                text:
                                    _selectedDate == null
                                        ? 'Select a date'
                                        : DateFormat(
                                          'dd-MM-yyyy HH:mm',
                                        ).format(_selectedDate!),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          BottomPicker.dateTime(
                            pickerTitle: const Text(
                              'Set Task Date & Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            onChange: (date) {
                              _selectedDate = date;
                              setState(() {});
                            },
                            onSubmit: (date) {
                              setState(() {
                                _selectedDate = date;
                              });
                            },
                            minDateTime: DateTime.now().subtract(
                              const Duration(days: 365),
                            ),
                            maxDateTime: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                            initialDateTime: DateTime.now(),
                            gradientColors: const [Colors.blue, Colors.blue],
                          ).show(context);
                        },
                      ),
                    ],
                  ),

                  //Eror jika tanggal belum di pilih
                  if (_isSubmited && _selectedDate == null)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Please select a date',
                      style: TextStyle(color: Colors.red, fontSize: 14)
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _taskCtr,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Task',
                            hintText: 'Masukan Kegiatan Kamu'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty){
                              return 'Harap Masukan Text !';
                            }
                            return null;
                          },
                          autovalidateMode: _isSubmited
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                        ),
                      ),
                      const SizedBox(width: 16),
                      FilledButton(
                        onPressed: (){
                          setState(() {
                            _isSubmited = true;
                          });

                          if (_formKey.currentState!.validate() && _selectedDate != null) {
                            addTask();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Task Berhasil Ditambahkan'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                ),
                            );
                          } 
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Daftar Kegiatan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: task.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            )
        ],
      ),),
    );
  }
}