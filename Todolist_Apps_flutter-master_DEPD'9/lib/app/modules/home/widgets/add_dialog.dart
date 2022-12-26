import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_taskapp/app/core/utils/extensions.dart';
import 'package:flutter_taskapp/app/modules/home/controller.dart';
import 'package:get/get.dart';
// import 'package:flutter_taskapp/app/modules/home/widgets/autodate.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddDialog({Key? key}) : super(key: key);

  // get date => 'date';
  // final TextEditingController tanggal = TextEditingController();

  get tanggal => 'tanggal';

  get title => 'title';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeCtrl.editCtrl.clear();
                      homeCtrl.changeTask(null);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          if (homeCtrl.task.value == null) {
                            EasyLoading.showError('Please select task type');
                          } else {
                            // String _tanggal;
                            var success = homeCtrl.updateTask(
                              homeCtrl.task.value!,
                              homeCtrl.editCtrl.text,
                              homeCtrl.getFormatedDate().toString(),
                              // homeCtrl.getcalender(date).toString(),
                              // homeCtrl.dateinput(_tanggal).toString(),
                            );
                            homeCtrl.exptodo();
                            homeCtrl.exptododone();

                            // homeCtrl.getcalender(date).toString(),

                            if (success) {
                              EasyLoading.showSuccess('Todo item add success');
                              Get.back();
                              homeCtrl.changeTask(null);
                            } else {
                              EasyLoading.showError('Todo item already exist');
                              // if (durasi > DateTime.now()) {
                              //   EasyLoading.showError(
                              //       'todo list will be deleted as it is more than 12 hours old');
                              //   homeCtrl.deleteTask;
                              // } else {
                              //   EasyLoading.showError(
                              //       'Are you sure you want to delete the todo list?');
                              // }
                            }
                            homeCtrl.editCtrl.clear();
                          }
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 14.0.sp,
                        ),
                      ))
                ],
              ),
            ),
            // TextFormField(
            //   // controller: tanggal,
            //   decoration: const InputDecoration(
            //       // border: OutlineInputBorder(),
            //       // borderSide: BorderSide(color: Colors.grey[400]!),

            //       icon: Icon(Icons.calendar_today), //icon of text field
            //       labelText: "Enter Date"),
            //   readOnly: true,
            //   //    validator: (value) {
            //   //   if (value == null || value.trim().isEmpty) {
            //   //     return 'Please enter your date';
            //   //   }
            //   //   return null;
            //   // },

            //   onTap: () async {
            //     homeCtrl.getcalender(date).toString();
            //   },
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                'New Task',
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editCtrl,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                )),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5.0.wp,
                left: 5.0.wp,
                right: 5.0.wp,
                bottom: 2.0.wp,
              ),
              child: Text(
                'Add to',
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            ...homeCtrl.tasks
                .map((element) => Obx(
                      () => InkWell(
                        onTap: () => homeCtrl.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp,
                            horizontal: 5.0.wp,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(
                                      element.icon,
                                      fontFamily: 'MaterialIcons',
                                    ),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  Text(
                                    element.title,
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (homeCtrl.task.value == element)
                                const Icon(Icons.check, color: Colors.blue)
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      )),
    );
  }
}
