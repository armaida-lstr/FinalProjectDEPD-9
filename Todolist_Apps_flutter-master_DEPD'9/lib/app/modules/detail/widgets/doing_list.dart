// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taskapp/app/core/utils/extensions.dart';
import 'package:flutter_taskapp/app/modules/home/controller.dart';
import 'package:get/get.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoingList({Key? key}) : super(key: key);

  get _tanggal => 'tanggal';

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? Column(
            children: [
              Image.asset(
                'assets/images/task.png',
                fit: BoxFit.cover,
                width: 85.0.wp,
              ),
              Text(
                'Add Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp,
                ),
              )
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeCtrl.doingTodos
                  .map((element) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp,
                          horizontal: 9.0.wp,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey),
                                value: element['done'],
                                onChanged: (value) {
                                  homeCtrl.doneTodo(
                                      element['title'], element['tanggal']);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                element['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            //   child: Text(
                            //     homeCtrl.dateinput(_tanggal).toString(),

                            //     // overflow: TextOverflow.ellipsis,
                            //   ),
                            // )
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                element['tanggal'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            //   child: Text(
                            //     homeCtrl.getFormatedDate().toString(),
                            //     // homeCtrl.getcalender(_date).toString(),

                            //     // overflow: TextOverflow.ellipsis,
                            //   ),
                            // )
                          ],
                        ),
                      ))
                  .toList(),
              if (homeCtrl.doingTodos.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: const Divider(thickness: 2),
                ),
              ElevatedButton(
                //  style: raisedButtonStyle,
                onPressed: () {
                  homeCtrl.exptodo();
                  homeCtrl.exptododone();
                },
                child: Text('Refresh'),
              ),
            ],
          ));
  }
}
