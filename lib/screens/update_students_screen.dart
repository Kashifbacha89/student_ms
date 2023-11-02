import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_ms/db/database_helper.dart';
import 'package:student_ms/screens/students_list_screen.dart';

import '../models/sutednts_model.dart';

class UpdateStudentsScreen extends StatefulWidget {
  Students students;
   UpdateStudentsScreen({Key? key,required this.students}) : super(key: key);

  @override
  State<UpdateStudentsScreen> createState() => _UpdateStudentsScreenState();
}

class _UpdateStudentsScreenState extends State<UpdateStudentsScreen> {
  var formKey=GlobalKey<FormState>();
  late  String name, regNo,course,mobile,totalFee,feePaid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Screen'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade200, Colors.pink.shade900],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: widget.students.name,
                    decoration: InputDecoration(
                        hintText: 'Name',
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter your name';
                      }
                      name=text;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: widget.students.regNo,
                    decoration: InputDecoration(
                        hintText: 'Reg Number',
                        labelText: 'Reg Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter your RegNumber';
                      }
                      regNo=text;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: widget.students.course,
                    decoration: InputDecoration(
                        hintText: 'Course',
                        labelText: 'Course',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter your course';
                      }
                      course=text;

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: widget.students.mobile,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Mobile',
                        labelText: 'Mobile',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter your Mobile Number';
                      }
                      mobile=text;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: widget.students.totalFee.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Total Fee',
                        labelText: 'Total Fee',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter Total fee';
                      }
                      totalFee=text;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: widget.students.feePaid.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Fee paid',
                        labelText: 'Fee paid',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter Fee paid';
                      }
                      feePaid=text;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        color: Colors.indigo[300],
                        borderRadius: BorderRadius.circular(16),

                      ),
                      child: TextButton(onPressed: ()async{
                        if(formKey.currentState!.validate()){
                          //update record in student database
                          Students s=Students(
                            id: widget.students.id,
                              name: name,
                              regNo: regNo,
                              course: course,
                              mobile: mobile,
                              totalFee: int.parse(totalFee),
                              feePaid: int.parse(feePaid));
                          int result=await  DatabaseHelper.instance.updateStudentRecord(s);
                          if(result>0){
                            Fluttertoast.showToast(msg: 'RECORD UPDATED',backgroundColor: Colors.green);
                            Navigator.of(context).pop('done');
                          }else{
                            Fluttertoast.showToast(msg: 'UPDATING FAILED',backgroundColor: Colors.red);
                          }
                        }
                      },child: const Text('Update'),),
                    ),
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
