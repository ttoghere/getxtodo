// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getxtodo/app/modules/report/report_view.dart';
import '/app/core/utils/extensions.dart';
import '/app/core/values/colors.dart';
import '/app/data/models/task.dart';
import '/app/modules/home/widgets/add_card.dart';
import '/app/modules/home/widgets/add_dialog.dart';
import '/app/modules/home/widgets/task_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                        'My List',
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
                          ...controller.tasks
                              .map(
                                (e) => LongPressDraggable(
                                  data: e,
                                  onDragStarted: () =>
                                      controller.changeDeleting(true),
                                  onDraggableCanceled: (_, __) =>
                                      controller.changeDeleting(false),
                                  onDragEnd: (_) =>
                                      controller.changeDeleting(false),
                                  feedback: Opacity(
                                    opacity: 0.8,
                                    child: TaskCard(task: e),
                                  ),
                                  child: TaskCard(
                                    task: e,
                                  ),
                                ),
                              )
                              .toList(),
                          AddCard(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ReportPage(),
            ],
          ),
        ),
        floatingActionButton: DragTarget<Task>(
          builder: (_, __, ___) {
            return Obx(
              () => FloatingActionButton(
                backgroundColor:
                    controller.deleting.value ? Colors.red[900] : blue,
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(
                      () => AddDialog(),
                      transition: Transition.downToUp,
                    );
                  } else {
                    EasyLoading.showInfo('Please Create your Task type');
                  }
                },
                child: Icon(
                  controller.deleting.value ? Icons.delete : Icons.add,
                ),
              ),
            );
          },
          onAccept: (Task task) {
            controller.deleteTask(task);
            EasyLoading.showSuccess('Delete Success');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Obx(
            () => BottomNavigationBar(
              onTap: (int index) => controller.changeTabIndex(index),
              currentIndex: controller.tabIndex.value,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: Icon(
                      Icons.apps,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Report',
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: Icon(
                      Icons.data_usage_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
