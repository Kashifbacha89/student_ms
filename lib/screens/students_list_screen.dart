import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_ms/db/database_helper.dart';
import 'package:student_ms/models/sutednts_model.dart';
import 'package:student_ms/screens/update_students_screen.dart';
class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List Screen '),
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(

          gradient: LinearGradient(
            colors: [Colors.pink.shade200, Colors.pink.shade900],
          ),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(10),
          child:  FutureBuilder<List<Students>>(
              future: DatabaseHelper.instance.getAllStudentsRecord(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator());
                }
                 else if(snapshot.data!.isEmpty){
                   return const Center(child: Text('No Record Found'),);

                }else{
                   List<Students> students=snapshot.data!;
                   return ListView.builder(
                       itemCount: students.length,
                       itemBuilder: (context,index){
                         Students s= students[index];
                         return Card(
                           color: Colors.indigo,
                           shadowColor: Colors.black,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(16.0),
                         ),
                           child: Container(
                             margin: const EdgeInsets.only(bottom: 6),
                             padding: const EdgeInsets.all(16.0),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(16),
                               color: Colors.blueAccent[200],
                             ),
                             child: Column(
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text('Student Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),

                                      Text(s.name!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text('Registration No',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),

                                     Text(s.regNo!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text('Course',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),

                                     Text(s.course!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text('Contact No:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),

                                     Text(s.mobile!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text('Total Fee',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),

                                     Text(s.totalFee.toString()!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text('Paid Fee:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),

                                     Text(s.feePaid.toString()!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     ElevatedButton(
                                         style: ElevatedButton.styleFrom(
                                           backgroundColor: Colors.amber,
                                           shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(16)
                                           )
                                         ),
                                         onPressed: ()async{
                                           String result= await Navigator.of(context).push(MaterialPageRoute(builder: (_)=>UpdateStudentsScreen(students: s,)));
                                           if(result=='done'){
                                             setState(() {

                                             });
                                           }
                                         }, child: const Text('Update')),
                                     ElevatedButton(
                                         style: ElevatedButton.styleFrom(
                                           backgroundColor: Colors.red,
                                           shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(16),
                                           )
                                         ),

                                         onPressed: (){
                                           showDialog(
                                               barrierDismissible: false,
                                               context: context, builder: (context){
                                             return AlertDialog(


                                               title: const Text('Confirmation!!'),
                                               content: const Text('Are you sure to delete?'),
                                               actions: [
                                                 TextButton(onPressed: (){
                                                   Navigator.of(context).pop();
                                                 }, child: const Text('No')),
                                                 TextButton(onPressed: ()async{
                                                   //Delete record
                                                   int result=await DatabaseHelper.instance.deleteStudentRecords(s.id!);
                                                   Navigator.of(context).pop();
                                                   if(result>0){
                                                     Fluttertoast.showToast(msg: 'RECORD DELETED');
                                                     setState(() {

                                                     });
                                                   }
                                                 }, child: const Text('Yes')),
                                               ],
                                             );
                                           });
                                         }, child: const Text('Delete'))
                                   ],
                                 )


                               ],
                             )
                           ),
                         );

                   });

                }

          }),
        ),
      ),
    );
  }
}
