import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodo/app/modules/home/controllers/home_controller.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Obx(() {
        var createdTasks = homeCtrl.getTotalTasks();
        var completedTasks = homeCtrl.getTotalDoneTask();
        var liveTasks = createdTasks - completedTasks;
        var precent = (completedTasks / createdTasks * 100).toString();
        return ListView(
          children: [
            
          ],
        );
      }),
    ));
  }
}
