import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_taskapp/app/core/value/colors.dart';
import 'package:flutter_taskapp/app/data/models/task.dart';
import 'package:flutter_taskapp/app/modules/home/controller.dart';
import 'package:flutter_taskapp/app/modules/home/widgets/add_card.dart';
import 'package:flutter_taskapp/app/modules/home/widgets/add_dialog.dart';
import 'package:flutter_taskapp/app/modules/home/widgets/task_card.dart';
import 'package:flutter_taskapp/app/modules/report/view.dart';
import 'package:get/get.dart';
import 'package:flutter_taskapp/app/core/utils/extensions.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 0)).then((_) {
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 400,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('GUIDE DEPD9 TO-DO LIST APPS'),
                    const Text(''),
                    const Text(
                        '1. Buat Group Untuk Mengkategorikan Task/Jadwal'),
                    const Text('2. Pilih Group Kemudian Buat Task'),
                    const Text(
                        '3. Task Akan Dibuat Berdasarkan Tanggal Sekarang'),
                    const Text('4. Klik Checkbox Jika Task Terselesaikan'),
                    const Text(
                        '5. Geser Kekiri Untuk Menghapus Task Yang Telah Selesai'),
                    const Text(
                        '6. Klik Refresh Untuk Menghapus Task Yang Tidak Sesuai Tanggal Sekarang'),
                    const Text(
                        '7. Jika Ingin Mengetahui report Task perbulan Maka Jangan Klik Refresh Dari Hari Pertama Input Task'),
                    const Text(
                        '8. Report Task Untuk Mengetahui Seberapa Efisien Task yang Berhasil Kita Selesaikan'),
                    const Text(
                        '9. Efisiensi Dihitung Dari Seberapa Banyak Task Yang Terselesaikan'),
                    const Text(''),
                    ElevatedButton(
                      child: const Text('GET STARTED'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            );
          });
    });

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Text(
                      'My Tasks',
                      style: TextStyle(
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        // TaskCard(
                        //   task: Task(
                        //     title: 'title',
                        //     icon: 0xe59,
                        //     color: '#FF2B60E6'),
                        // ),
                        ...controller.tasks
                            .map((element) => LongPressDraggable(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (_, __) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (_) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(task: element),
                                ),
                                child: TaskCard(task: element)))
                            .toList(),
                        AddCard()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ReportPage()
          ],
        ),
      ),
      // floatingActionButton: DragTarget<Task>(
      //   builder: (_, __, ___) {

      //     return Obx(
      //       () => FloatingActionButton(
      //         backgroundColor: controller.deleting.value ? Colors.red : blue,
      //         onPressed: () {
      //           if (controller.tasks.isNotEmpty) {
      //             Get.to(() => AddDialog(), transition: Transition.downToUp);
      //           } else {
      //             EasyLoading.showInfo('Please create your task type');
      //           }
      //         },
      //         child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
      //       ),
      //     );
      //   },
      //   onAccept: (task) {
      //     controller.deleteTask(task);
      //     EasyLoading.showSuccess('Delete Sucess');
      //   },
      // ),

      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          backgroundColor:
          controller.deleting.value ? Colors.red : blue;
          return Obx(
            () => Icon(controller.deleting.value ? Icons.delete : Icons.delete),
          );
        },
        onAccept: (task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Sucess');
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Padding(
                  padding: EdgeInsets.only(right: 15.0.wp),
                  child: const Icon(Icons.apps),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Report',
                icon: Padding(
                  padding: EdgeInsets.only(left: 15.0.wp),
                  child: const Icon(Icons.data_usage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
