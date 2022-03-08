import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getxtodo/app/modules/detail/widgets/doing_list.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../data/models/task.dart';
import '/app/core/utils/extensions.dart';
import '/app/modules/home/controllers/home_controller.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeCtrl.updateTodos();
                      homeCtrl.changeTask(null);
                      homeCtrl.editCtrl.clear();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0.wp,
              ),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: color,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Obx(() {
              var totalTodos =
                  homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.0.wp,
                  top: 3.0.wp,
                  right: 16.0.wp,
                ),
                child: Row(
                  children: [
                    Text(
                      'Total tasks: $totalTodos',
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: homeCtrl.doneTodos.length,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                          colors: [color.withOpacity(0.5), color],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        unselectedGradientColor: LinearGradient(
                          colors: [Colors.grey[300]!, Colors.grey[300]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 2.0.wp,
                horizontal: 5.0.wp,
              ),
              child: TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.done,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          var success =
                              homeCtrl.addTodo(homeCtrl.editCtrl.text);
                          if (success) {
                            EasyLoading.showSuccess('List got a new task');
                          } else {
                            EasyLoading.showError('Todo item already exists');
                          }
                          homeCtrl.editCtrl.clear();
                        }
                      },
                    )),
                controller: homeCtrl.editCtrl,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Provide a task value';
                  }
                },
              ),
            ),
            DoingList(),
          ],
        ),
      ),
    );
  }
}
