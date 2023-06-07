import 'dart:convert';
import 'dart:io';
import 'package:firebase/model/Student.dart';
import 'package:firebase/model/User.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  static const String FIREBASE_URL =
      "https://deneme-36b3a-default-rtdb.europe-west1.firebasedatabase.app/";

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse("$FIREBASE_URL/users.json"));

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        final userList = jsonModel
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<User>();
        return userList;

      default:
        return Future.error(response.statusCode);
    }
  }

  Future<List<Student>> getStudents() async {
    final response = await http.get(Uri.parse("$FIREBASE_URL/students.json"));

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;
        final studentList = <Student>[];
        jsonModel.forEach(
          (key, value) {
            Student student = Student.fromJson(value);
            student.key = key;
            studentList.add(student);
          },
        );

        return studentList;

      default:
        return Future.error(response.statusCode);
    }
  }
}
