import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '/app/core/utils/extensions.dart';
import '/app/core/values/colors.dart';
import '/app/data/models/task.dart';
import '/app/modules/home/controllers/home_controller.dart';
import '/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  AddCard({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      decoration: BoxDecoration(),
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(
              vertical: 5.0.wp,
            ),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: homeCtrl.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0.wp),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      controller: homeCtrl.editCtrl,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons
                          .map((e) => Obx(() {
                                final index = icons.indexOf(e);
                                return ChoiceChip(
                                  selectedColor: Colors.grey[200],
                                  pressElevation: 0,
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  label: e,
                                  selected: homeCtrl.chipIndex.value == index,
                                  onSelected: (bool selected) {
                                    homeCtrl.chipIndex.value =
                                        selected ? index : 0;
                                  },
                                );
                              }))
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          int icon =
                              icons[homeCtrl.chipIndex.value].icon!.codePoint;
                          String color =
                              icons[homeCtrl.chipIndex.value].color!.toHex();
                          var task = Task(
                            color: color,
                            icon: icon,
                            title: homeCtrl.editCtrl.text,
                          );
                          Get.back();
                          homeCtrl.addTask(task)
                              ? EasyLoading.showSuccess('Task Created')
                              : EasyLoading.showError('Task is not created');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(150, 40),
                      ),
                      child: Text('Add')),
                ],
              ),
            ),
          );
          homeCtrl.editCtrl.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
