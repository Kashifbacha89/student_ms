import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BulbTest extends StatefulWidget {
  const BulbTest({Key? key}) : super(key: key);

  @override
  State<BulbTest> createState() => _BulbTestState();
}

class _BulbTestState extends State<BulbTest> {
  bool switchStatus = false;
  bool bulbStatus = false;
  var nameC = TextEditingController();
  var name = 'StoredName';
  @override
  void initState() {
    // TODO: implement initState
    getStoredName();
    getBulbStatus();
    super.initState();
  }
  Future getBulbStatus()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? status=sp.getBool('BULB_STATUS');
    if(status!=null){
      setState(() {
        bulbStatus=status;
      });
    }



  }

  Future getStoredName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? name = sp.getString('NAME');
    if (name != null) {
      setState(() {
        this.name = name;
      });
    } else {
      setState(() {
        this.name = 'Not Saved Yet!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulb Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('You are :'),
                  Text(switchStatus ? 'ONLINE' : 'OFFLINE'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Status'),
                  Switch(
                      value: switchStatus,
                      onChanged: (bool isChecked) {
                        setState(() {
                          switchStatus = isChecked!;
                        });
                      }),
                ],
              ),
              Container(
                  width: 400,
                  height: 300,
                  child: Image.asset(bulbStatus
                      ? 'assets/images/bulbOn.jpg'
                      : 'assets/images/bulbOff.png')),
              Switch(
                  value: bulbStatus,
                  onChanged: (bool isChecked) async {
                    SharedPreferences sp = await SharedPreferences.getInstance();
                    sp.setBool('BULB_STATUS', bulbStatus);
                    setState(() {
                      bulbStatus = isChecked!;
                    });
                  }),
              TextField(
                controller: nameC,
                decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
              ),
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences sp = await SharedPreferences.getInstance();
                    sp.setString('NAME', nameC.text.trim());
                    nameC.clear();
                    getStoredName();
                  },
                  child: const Text('Save')),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
