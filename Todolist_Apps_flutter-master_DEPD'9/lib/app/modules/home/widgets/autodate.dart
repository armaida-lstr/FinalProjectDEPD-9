// import 'package:flutter/material.dart';
// import 'package:flutter_taskapp/app/modules/home/controller.dart';
// import 'package:intl/intl.dart';




// void main() {
//  runApp(TabBarDemo());
// }

// class TabBarDemo extends StatelessWidget {
//  @override
// Widget build(BuildContext context) {
// DateTime now = DateTime.now();
// String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
// return MaterialApp(
//   home: DefaultTabController(
//     length: 3,
//     child: Scaffold(
//       appBar: AppBar(
//         bottom: TabBar(
//           tabs: [
//             Tab(icon: Icon(Icons.calendar_today),text: "calender",),
//           ],
//         ),
//         title: Text('Tabs Demo'),backgroundColor: Colors.black,
//       ),
//       body: TabBarView(
//         children: [
//           Icon(Icons.access_alarm),
//           Center(child: Text(formattedDate,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),)),
//           Icon(Icons.timer),
//         ],
//       ),
//     ),
//   ),
// );
// }
// }