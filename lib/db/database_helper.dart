import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_ms/models/sutednts_model.dart';

class DatabaseHelper {
  //CREATE DATABASE
  //database creation almost same for every database
  DatabaseHelper._privateConstructor(); //Named constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
//getter method for _database
  Future<Database> get database async {
    _database ??= await initializedDatabase();

    return _database!;
  }

//initialized  database for the first time
  Future<Database> initializedDatabase() async {
    //get the directory path of both android & ios
    //to store  data in database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/students.db';

    //open/create database at given path
    var studentDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return studentDatabase;
  }

//CREATE TABLE
// creation of table are almost same in every database
  void _createDb(Database db, int newVersion) async {
    await db.execute(''' Create TABLE tbl_student(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  regNo TEXT,
  course Text,
  mobile Text,
  totalFee INTEGER,
  feePaid INTEGER
  
  )''');
  }

  //INSERT
  Future<int> insertStudent(Students s) async {
    //add students record to  Database table
    Database db = await instance.database;
    //int result=await db.rawInsert('INSERT INTO tbl_student(name,course,regNo,mobile,totalFee,feePaid) VALUES(?,?,?,?,?,?)',[s.name,s.course,s.regNo,s.mobile,s.totalFee,s.feePaid]);
    int result = await db.insert('tbl_student', s.toMap());

    return result;
  }
  //READ
//read data from firebase
Future<List<Students>> getAllStudentsRecord()async{
    var students=<Students>[];
    //read data from table
    Database db= await instance.database;
    //db.query('tbl_student');
    //query for read data from database table
    List<Map<String,dynamic>>  listMap= await db.rawQuery('SELECT * from tbl_student ');
    for(var studentMap in listMap){
      //pass the Student data in the form of map into the list
      Students s= Students.fromMap(studentMap);
      students.add(s);

    }
    await Future.delayed(const Duration(seconds: 2));




    return students;
}

  //UPDATE
  Future<int> updateStudentRecord(Students s)async{
    Database db=await instance.database;
   /*int result= await db.rawUpdate('UPDATE tbl_student set name=?,regNo=?,course=?,mobile=?,totalFee=?,feePaid=? where id=? ',
        [s.name,s.regNo,s.course,s.course,s.mobile,s.totalFee,s.feePaid,s.id]);
   return result;*/
    //second method
    int result= await db.update('tbl_student', s.toMap(),where: 'id=?',whereArgs: [s.id]);
    return result;
    
  }

  //DELETE

Future<int> deleteStudentRecords(int id)async{
    Database db=await instance.database;
    int result= await db.delete('tbl_student',where: 'id=?',whereArgs: [id]);
    //2nd method
   //int result= await db.rawDelete('DELETE from tbl_student where id=?',[id]);
  return result;
    
    
}
}
