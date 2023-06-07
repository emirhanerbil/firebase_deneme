import 'package:firebase/core/services/firebase_service.dart';
import 'package:firebase/model/Student.dart';
import 'package:flutter/material.dart';

import '../../model/User.dart';

class FireHomeView extends StatefulWidget {
  const FireHomeView({super.key});

  @override
  State<FireHomeView> createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<FireHomeView> {
  late FirebaseService service;
  @override
  void initState() {
    super.initState();
    service = FirebaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: getStudentFutureBuilder);
  }

  Widget get getStudentFutureBuilder => FutureBuilder<List<Student>>(
      future: service.getStudents(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              return _listStudent(snapshot.data!);
            } else {
              return _notFountWidget;
            }

          default:
            return _waitingWidget;
        }
      });

  Widget _listUser(List<User> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => _userCard(list[index]));
  }

  Widget _listStudent(List<Student> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => _studentCard(list[index]));
  }

  Widget _userCard(User user) {
    return Card(child: ListTile(title: Text(user.name!)));
  }

  Widget _studentCard(Student student) {
    return Card(
        child: ListTile(
      title: Text(student.name!),
      subtitle: Text(student.number.toString()),
    ));
  }

  Widget get _notFountWidget => Center(child: Text("not found"));
  Widget get _waitingWidget => Center(child: CircularProgressIndicator());
}
