import 'package:get/get.dart';
import 'package:getxtodo/app/data/providers/task_provider.dart';
import 'package:getxtodo/app/data/storage/repository.dart';

import '../controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
