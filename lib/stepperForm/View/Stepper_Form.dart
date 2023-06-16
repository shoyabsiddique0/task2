import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:task2/Submitted/View/Submitted.dart';
import 'package:task2/stepperForm/controller/stepper_controller.dart';

class StepperForm extends StatelessWidget {
  StepperForm({Key? key}) : super(key: key);
  final StepperController controller = Get.put(StepperController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Stepper Form"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => Stepper(
                    stepIconBuilder: (stepIndex, stepState) {
                      return Container(
                        decoration: BoxDecoration(
                          color: stepState == StepState.complete
                              ? Colors.blue
                              : stepState == StepState.editing
                                  ? const Color.fromARGB(255, 66, 182, 240)
                                  : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          stepIndex == 0
                              ? Icons.person_2_outlined
                              : stepIndex == 1
                                  ? Icons.streetview
                                  : Icons.currency_rupee,
                        ),
                      );
                    },
                    elevation: 0,
                    currentStep: controller.currentStep.value,
                    onStepContinue: () {
                      var isLastStep = controller.currentStep.value ==
                          controller.getStep().length - 1;
                      if (isLastStep) {
                        controller.pay();
                      } else {
                        controller.currentStep.value += 1;
                      }
                    },
                    onStepCancel: () {
                      controller.currentStep.value == 0
                          ? null
                          : controller.currentStep.value -= 1;
                    },
                    onStepTapped: (step) {
                      controller.currentStep.value = step;
                    },
                    type: StepperType.horizontal,
                    steps: controller.getStep()),
              ),
            )
          ],
        ));
  }
}
