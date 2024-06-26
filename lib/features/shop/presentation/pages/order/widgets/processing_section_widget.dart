import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../data/models/order_model.dart';

class ProcessingSectionWidget extends StatelessWidget {
  const ProcessingSectionWidget({
    super.key,
    required this.order,
  });
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// 1 - Icon
        const Icon(Iconsax.ship),
        const SizedBox(width: AppSizes.spaceBtwItems / 2),
    
        /// 2 - status and date
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.orderStatusText,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(color: AppColors.primary, fontWeightDelta: 1),
              ),
              Text(order.formattedOrderDate,
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
        IconButton(
            onPressed: () {},
            icon:
                const Icon(Iconsax.arrow_right_34, size: AppSizes.iconSm))
      ],
    );
  }
}
