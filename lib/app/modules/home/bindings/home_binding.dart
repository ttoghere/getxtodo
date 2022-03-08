import 'package:get/get.dart';
import '/app/data/providers/task_provider.dart';
import '/app/data/storage/repository.dart';

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
