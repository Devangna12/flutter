import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int students = 42;
  int attendance = 87;

  List<Map<String, String>> studentList = [
    {"name": "Rahul", "status": "Present"},
    {"name": "Aman", "status": "Absent"},
    {"name": "Neha", "status": "Present"},
  ];

  //  Add Student
  void addStudent() {
    setState(() {
      students++;
      studentList.add({
        "name": "New Student $students",
        "status": "Present"
      });
    });
  }

  // Increase Attendance
  void increaseAttendance() {
    setState(() {
      if (attendance < 100) attendance++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text("class Dashboard")),

      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 20),

            // 🔹 Info Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infoCard("Students", "$students", Icons.people, Colors.blue),
                infoCard("Attendance", "$attendance%", Icons.check, Colors.green),
              ],
            ),

            SizedBox(height: 20),

            // Network Image (Web Style Banner)
            Container(
              margin: EdgeInsets.all(16),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "https://www.google.com/imgres?q=animated%20college%20student&imgurl=https%3A%2F%2Fmedia.gettyimages.com%2Fid%2F484225802%2Fvector%2Fcollege-campus-friends.jpg%3Fs%3D612x612%26w%3Dgi%26k%3D20%26c%3DkDueN9Xhb3ExBVMqYsN5Juf4tyCM7oWOc7yTfTaX7J4%3D&imgrefurl=https%3A%2F%2Fwww.gettyimages.com%2Fphotos%2Fstudent-campus-university-cartoon&docid=r2Xo6w2tfpY1tM&tbnid=pyG9P5Y0xrdLnM&vet=12ahUKEwjov6LNoriTAxW0U2wGHYJFDfoQnPAOegQIcBAB..i&w=612&h=480&hcb=2&ved=2ahUKEwjov6LNoriTAxW0U2wGHYJFDfoQnPAOegQIcBAB",
                  fit: BoxFit.cover,

                  // errorBuilder (important from your sheet)
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      child: Center(child: Icon(Icons.error)),
                    );
                  },
                ),
              ),
            ),

            // Buttons Panel
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [

                  Text("Manage Data",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),

                  SizedBox(height: 15),

                  // Add Student Button
                  GestureDetector(
                    onTap: addStudent,
                    child: buttonUI("Add Student", Icons.person_add, Colors.blue),
                  ),

                  SizedBox(height: 10),

                  // Attendance Button
                  GestureDetector(
                    onTap: increaseAttendance,
                    child: buttonUI("Increase Attendance",
                        Icons.trending_up, Colors.green),
                  ),
                ],
              ),
            ),

            // Student List (with Key)
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                children: [

                  Text("Student Records",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),

                  SizedBox(height: 10),

                  Column(
                    children: studentList.map((student) {
                      return rowData(
                        key: ValueKey(student["name"]), //  KEY USED
                        name: student["name"]!,
                        status: student["status"]!,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Info Card
  Widget infoCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(height: 10),
          Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  //Button
  Widget buttonUI(String text, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

// Row Widget with KEY
class rowData extends StatelessWidget {
  final String name;
  final String status;

  const rowData({
    Key? key,
    required this.name,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(
            status,
            style: TextStyle(
              color: status == "Present" ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}