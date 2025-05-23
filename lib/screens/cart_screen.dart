import 'package:action_slider/action_slider.dart' show ActionSlider;
import 'package:bike_shop/core/controller/main_controller.dart';
import 'package:bike_shop/core/model/bike_model.dart';
import 'package:bike_shop/core/utils/format.dart';
import 'package:bike_shop/core/widgets/entry_list_item.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';

import '../core/constants/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: Dimens.verticalBlockSize * 8),
            child: SingleChildScrollView(
              child: Column(
                children: [_cartItem(), _couponCode(), _checkOut()],
              ),
            ),
          ),
          _appBar(),
        ],
      ),
    );
  }

  Widget _cartItem() {
    return SizedBox(
      height: Dimens.verticalBlockSize * 65,
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.only(top: Dimens.verticalBlockSize * 17),
          shrinkWrap: true,
          itemCount: MainController.to.cart.length,
          separatorBuilder: (c, sI) {
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: Dimens.verticalBlockSize * 2,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white10),
              ),
            );
          },
          itemBuilder: (c, i) {
            BikeModel cart = MainController.to.cart[i];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.s_15()),
              child: EntryListItem(
                index: i,
                child: Row(
                  children: [
                    Container(
                      height: Dimens.verticalBlockSize * 12,
                      width: Dimens.horizontalBlockSize * 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImagesAsset.cartRec),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(Dimens.s_8()),
                        child: Image.asset(cart.img),
                      ),
                    ),
                    SizedBox(width: Dimens.s_10()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cart.name,
                          textAlign: TextAlign.left,
                          style: AppTextStyle.bodyRegular[15]?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: Dimens.verticalBlockSize * 3),
                        SizedBox(
                          width: Dimens.horizontalBlockSize * 55,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  StringFormat.priceFormat(
                                    cart.price * cart.piece,
                                  ),
                                  textAlign: TextAlign.left,
                                  style: AppTextStyle.bodyRegular[13]?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blueSky,
                                  ),
                                ),
                              ),

                              ClayContainer(
                                emboss: true,
                                borderRadius: 10,
                                spread: 1,
                                color: Color(0xff323B4F),
                                surfaceColor: Color(0xff242C3B),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimens.verticalBlockSize * 0.4,
                                    horizontal: Dimens.s_6(),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Plus button
                                      _buildButton(
                                        icon: Icons.add,
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF4CC4F0),
                                            Color(0xFF3A4CFE),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        onTap: () {
                                          if (cart.piece < 5) {
                                            cart.piece++;
                                            MainController.to.cart.refresh();
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: Dimens.s_35(),
                                        child: Center(
                                          child: Text(
                                            '${cart.piece}',
                                            style: TextStyle(
                                              color: Colors.grey[300],
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Minus button
                                      _buildButton(
                                        icon: Icons.remove,
                                        color: Color(0xFF2B2E3F),
                                        onTap: () {
                                          if (cart.piece > 1) {
                                            cart.piece--;
                                          }
                                          MainController.to.cart.refresh();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _couponCode() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.s_20(),
        vertical: Dimens.verticalBlockSize * 2,
      ),
      child: EntryListItem(
        index: 3,
        child: ClayContainer(
          emboss: true,
          borderRadius: 10,
          spread: 3,
          color: Color(0xff323B4F),
          surfaceColor: Color(0xff242C3B),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  cursorColor: AppColors.sky,
                  style: AppTextStyle.bodyRegular[14]?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintStyle: AppTextStyle.bodyRegular[14]?.copyWith(
                      color: AppColors.greyScale[10]!,
                      fontWeight: FontWeight.w600,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: Dimens.s_15(),
                      vertical: Dimens.verticalBlockSize * 2,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Bounceable(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: AppColors.linearGradient,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(4, 4),
                        blurRadius: 8,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        offset: const Offset(-4, -4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimens.s_35(),
                    vertical: Dimens.verticalBlockSize * 2,
                  ),
                  child: Text(
                    'Apply',
                    style: AppTextStyle.bodyRegular[13]?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _checkOut() {
    return EntryListItem(
      index: 4,
      child: EntryListItem(
        index: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Dimens.verticalBlockSize * 3),
          child: ActionSlider.standard(
            width: Dimens.horizontalBlockSize * 60,
            height: Dimens.verticalBlockSize * 7,
            backgroundColor: AppColors.bg,
            customBackgroundBuilder: (c, a, w) {
              return ClayContainer(
                emboss: true,
                borderRadius: 10,
                spread: 3,
                color: Color(0xff323B4F),
                surfaceColor: Color(0xff242C3B),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimens.s_30()),
                    child: Text(
                      'Checkout',
                      style: AppTextStyle.bodyRegular[15]?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
              );
            },
            customForegroundBuilder: (c, a, w) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: AppColors.linearGradient,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      offset: const Offset(-4, -4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              );
            },
            action: (controller) async {
              controller.loading(); //starts loading animation
              await Future.delayed(const Duration(seconds: 3));
              controller.success(); //starts success animation
            },
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: EdgeInsets.only(top: Dimens.verticalBlockSize * 2),
      child: Align(
        alignment: Alignment.topCenter,
        child: EntryListItem(
          index: 0,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  MainController.to.left.value = -1.5;
                  MainController.to.selIn.value = 0;
                },
                child: Image.asset(IconsAsset.back, scale: 4),
              ),
              SizedBox(width: Dimens.s_15()),
              Text(
                'My Shopping Cart',
                textAlign: TextAlign.left,
                style: AppTextStyle.bodyRegular[20]?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    VoidCallback? onTap,
    Color? color,
    Gradient? gradient,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Dimens.s_25(),
        height: Dimens.s_25(),
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: Offset(2, 2),
              blurRadius: 6,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.05),
              offset: Offset(-2, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
