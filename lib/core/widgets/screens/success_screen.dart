import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/models/success_items_model.dart';
import '../../utils/styles/spacing_styles.dart';

class SuccessScreen extends StatelessWidget {
  final SuccessItemsModel itemsModel;
  const SuccessScreen({
    super.key,
    required this.itemsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding: AppSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              // Image
              Lottie.asset(itemsModel.image,
                  width: AppHelperFunctions.screenWidth(context) * 0.6),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // title and subtitle
              Text(itemsModel.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.spaceBtwItems),

              Text(itemsModel.subtitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.spaceBtwSections),
              // button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed(itemsModel.routeName),
                  child: const Text(AppTexts.tContinue),
                ),
              ),
            ],
          )),
    ));
  }
}
