import 'package:flutter/material.dart';
import 'package:shoe_spotter/core/utils/constants/colors.dart';
import 'package:shoe_spotter/core/utils/constants/sizes.dart';
import 'package:shoe_spotter/core/widgets/circular_container_widget.dart';
import 'package:shoe_spotter/core/widgets/curved_edge_widget.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  final Widget child;
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: AppSizes.circularContainerHeight,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: CircularContainerWidget(
                  backgroundColor: AppColors.textWhite.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: CircularContainerWidget(
                    backgroundColor: AppColors.textWhite.withOpacity(0.1)),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
