import 'package:flutter/material.dart';
import '../widgets/on_boarding_next_button_widget.dart';
import '../widgets/smooth_page_indicator_widget.dart';

import '../../../../core/utils/constants/sizes.dart';
import '../widgets/on_boarding_page_view_items.dart';
import '../widgets/on_boarding_skip_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController onboardController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const OnBoardingSkipWidget(),
            Expanded(
              child: PageView.builder(
                controller: onboardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    OnBoardingPageViewItems.introPages[index],
                onPageChanged: (index) {
                  if (index == OnBoardingPageViewItems.introPages.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemCount: OnBoardingPageViewItems.introPages.length,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SmoothPageIndicatorWidget(
                  onboardController: onboardController,
                ),
                const Spacer(),
                OnBoardingNextButtonWidget(
                  isLast: isLast,
                  onboardController: onboardController,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}