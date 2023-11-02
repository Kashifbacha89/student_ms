import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_ms/db/database_helper.dart';
import 'package:student_ms/models/sutednts_model.dart';
import 'package:student_ms/screens/bulb_test_sharedprefrences.dart';
import 'package:student_ms/screens/students_list_screen.dart';

class AddStudentsScreen extends StatefulWidget {
  const AddStudentsScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentsScreen> createState() => _AddStudentsScreenState();
}

class _AddStudentsScreenState extends State<AddStudentsScreen> {
  var formKey = GlobalKey<FormState>();
  late String name, regNo, course, mobile, totalFee, feePaid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Students'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const BulbTest()));
          }, icon: const Icon(Icons.light_mode_outlined))
        ],
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
                      name = text;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
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
                      regNo = text;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
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
                      course = text;

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
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
                      mobile = text;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
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
                      totalFee = text;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
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
                      feePaid = text;
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          shadowColor: Colors.white,
                        ),
                        onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            //save record to DB
                            //create a student objects
                            Students s = Students(
                              
                              name: name,
                              regNo: regNo,
                              course: course,
                              mobile: mobile,
                              totalFee: int.parse(totalFee),
                              feePaid: int.parse(feePaid),
                            );
                            int result= await DatabaseHelper.instance.insertStudent(s);
                            formKey.currentState!.reset();
                            if (kDebugMode) {
                              print('*******************************************8');
                            }
                            if(result>0){
                              Fluttertoast.showToast(msg: 'Record Saved Successfully',backgroundColor: Colors.cyanAccent);

                            }else{
                              Fluttertoast.showToast(msg: 'Record failed',backgroundColor: Colors.red);
                            }
                          }
                        },
                        child: const Text('Save')),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            shadowColor: Colors.white),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const StudentListScreen()));
                        },
                        child: const Text('View All')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
