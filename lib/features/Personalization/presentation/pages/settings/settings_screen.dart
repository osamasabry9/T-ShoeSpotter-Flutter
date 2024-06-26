import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/sizes.dart';
import '../../../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../../../core/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../../core/widgets/list_tiles/user_profile_tile.dart';
import '../../controllers/user/user_controller.dart';
import 'widgets/account_settings_section.dart';
import 'widgets/app_settings_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// header
            PrimaryHeaderContainer(
              child: Column(children: [
                /// app bar
                CustomAppBar(
                  title: Text("Account",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: AppColors.white)),
                ),

                /// user profile card
                const UserProfileTile(),
                const SizedBox(height: AppSizes.spaceBtwSections),
              ]),
            ),

            /// body
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                children: [
                  const AccountSettingsSection(),
                  const AppSettingsSection(),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  /// logout button
                  SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () =>
                              Get.find<UserController>().logoutUser(),
                          child: const Text("Logout"))),
                  const SizedBox(height: AppSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
