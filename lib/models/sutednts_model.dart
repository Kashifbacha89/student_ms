class Students {
  int? id;
  String? name;
  String? regNo;
  String? course;
  String? mobile;
  int? totalFee;
  int? feePaid;

  Students(
      { this.id,
      required this.name,
      required this.regNo,
      required this.course,
      required this.mobile,
      required this.totalFee,
      required this.feePaid});

  //function to convert object to Map
  Map<String, dynamic> toMap() {
    Map<String,dynamic> map={};
    map['id']= id;
    map['name']=name;
    map['regNo']=regNo;
    map['course']=course;
    map['mobile']=mobile;
    map['totalFee']=totalFee;
    map['feePaid']=feePaid;



    return map;
  }
  //Function to convert map into object
  //Named constructor
  Students.fromMap(Map<String,dynamic> map){
    id=map['id'];
    name=map['name'];
    regNo=map['regNo'];
    course=map['course'];
    mobile=map['mobile'];
    totalFee=map['totalFee'];
    feePaid=map['feePaid'];
  }

}
