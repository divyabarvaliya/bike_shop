import 'package:bike_shop/core/controller/main_controller.dart';
import 'package:bike_shop/core/model/bike_model.dart';
import 'package:bike_shop/core/utils/debouncer.dart';
import 'package:bike_shop/core/utils/format.dart';
import 'package:bike_shop/core/utils/snackbar.dart';
import 'package:bike_shop/core/widgets/entry_list_item.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';

import '../core/constants/constants.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key, required this.bike});

  final BikeModel bike;

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  RxDouble bikePos = (-Dimens.horizontalBlockSize * 120).obs;
  RxDouble bottomPos = 0.0.obs;
  double _previousExtent = 0.0;
  double minBottom = 0; // Minimum limit
  double maxBottom = 300; // Set based on your layout constraints
  RxBool emboss = false.obs;
  final deBouncer = DeBouncer(milliSecond: 300);

  @override
  void initState() {
    // TODO: implement initState
    changePosition();
    super.initState();
  }

  Future<void> changePosition() async {
    await Future.delayed(Duration(milliseconds: 200));
    bikePos.value = Dimens.horizontalBlockSize * 5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        alignment: Alignment.center,
        children: [_bgView(), _animatedImg(), _appBar(), _dragSheet()],
      ),
    );
  }

  Widget _animatedImg() {
    return Obx(
      () => AnimatedPositioned(
        left: bikePos.value,
        bottom: bottomPos.value,
        top: 0,
        duration: Duration(milliseconds: 900),
        child: Image.asset(
          widget.bike.img,
          height: Dimens.horizontalBlockSize * 90,
          width: Dimens.horizontalBlockSize * 90,
        ),
      ),
    );
  }

  Widget _bgView() {
    return Align(
      alignment: Alignment.centerRight,
      child: Image.asset(ImagesAsset.bg_2),
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
                  Get.back();
                },
                child: Image.asset(IconsAsset.back, scale: 4),
              ),
              SizedBox(width: Dimens.s_15()),
              Text(
                widget.bike.name,
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

  Widget _dragSheet() {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        final currentExtent = notification.extent;
        if (currentExtent > _previousExtent) {
          // Dragging Up
          bottomPos.value = (bottomPos.value + 100).clamp(minBottom, maxBottom);
        } else if (currentExtent < _previousExtent) {
          // Dragging Down
          bottomPos.value = (bottomPos.value - 100).clamp(minBottom, maxBottom);
        }
        _previousExtent = currentExtent;
        return true;
      },
      child: EntryListItem(
        index: 1,
        child: DraggableScrollableSheet(
          initialChildSize: 0.13,
          minChildSize: 0.13,
          maxChildSize: 0.5,
          builder: (context, scrollController) {
            scrollController.addListener(() {
              debugPrint(
                "Scroll position: ${scrollController.position.pixels}",
              ); // You can also access extent or other values
            });
            return Container(
              decoration: BoxDecoration(
                color: Color(0xff323B4F),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_buttonView(), _title(), _des(), _addToCart()],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buttonView() {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimens.verticalBlockSize * 4,
        bottom: Dimens.verticalBlockSize * 4,
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bounceable(
              onTap: () {
                if (emboss.value) {
                  emboss.value = !emboss.value;
                }
              },
              child: ClayContainer(
                emboss: emboss.value,
                borderRadius: 10,
                spread: 3,
                color: Color(0xff323B4F),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimens.s_20(),
                    vertical: Dimens.verticalBlockSize * 1.8,
                  ),
                  child:
                      !emboss.value
                          ? ShaderMask(
                            shaderCallback:
                                (bounds) => LinearGradient(
                                  colors: [
                                    !emboss.value
                                        ? Color(0xFF50B7FF)
                                        : Colors.transparent,
                                    !emboss.value
                                        ? Color(0xFF3D8BFF)
                                        : Colors.transparent,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                            blendMode: BlendMode.srcIn,
                            child: Text(
                              'Description',
                              style: AppTextStyle.bodyRegular[15]?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                          : Text(
                            'Description',
                            style: AppTextStyle.bodyRegular[15]?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.white60,
                            ),
                          ),
                ),
              ),
            ),
            SizedBox(width: Dimens.s_30()),
            Bounceable(
              onTap: () {
                if (!emboss.value) {
                  emboss.value = !emboss.value;
                }
              },
              child: ClayContainer(
                emboss: !emboss.value,
                borderRadius: 10,
                spread: 3,
                color: Color(0xff323B4F),
                surfaceColor: Color(0xff28303F),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimens.s_20(),
                    vertical: Dimens.verticalBlockSize * 1.8,
                  ),
                  child:
                      emboss.value
                          ? ShaderMask(
                            shaderCallback:
                                (bounds) => LinearGradient(
                                  colors: [
                                    Color(0xFF50B7FF),
                                    Color(0xFF3D8BFF),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                            blendMode: BlendMode.srcIn,
                            child: Text(
                              'Specification',
                              style: AppTextStyle.bodyRegular[15]?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                          : Text(
                            'Specification',
                            style: AppTextStyle.bodyRegular[15]?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.white60,
                            ),
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.s_20()),
      child: Text(
        widget.bike.name,
        style: AppTextStyle.bodyRegular[17]?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _des() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.s_20(),
        vertical: Dimens.verticalBlockSize * 2,
      ),
      child: Text(
        '''The LR01 uses the same design as the most iconic bikes from PEUGEOT Cycles' 130-year history and combines it with agile, dynamic performance that's perfectly suited to navigating today's cities. As well as a lugged steel frame and iconic PEUGEOT black-and-white chequer design, this city bike also features a 16-speed Shimano Claris drivetrain.''',
        style: AppTextStyle.bodyRegular[15]?.copyWith(
          fontWeight: FontWeight.w400,
          color: Colors.white60,
        ),
      ),
    );
  }

  Widget _addToCart() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.s_30()),
      height: Dimens.verticalBlockSize * 12,
      decoration: BoxDecoration(
        border: const Border(
          left: BorderSide(color: Color(0xff2D3748), width: 3),
          right: BorderSide(color: Color(0xff2D3748), width: 3),
          top: BorderSide(color: Color(0xff2D3748), width: 3),
        ),
        color: Color(0xff262E3D),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringFormat.priceFormat(widget.bike.price),
            style: AppTextStyle.bodyRegular[24]?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.blueSky,
            ),
          ),
          Bounceable(
            onTap: () {
              deBouncer.run(() {
                bool isExist = MainController.to.cart.any((item) {
                  if (item.img == widget.bike.img) {
                    return true;
                  }
                  return false;
                });
                if (!isExist) {
                  MainController.to.cart.add(widget.bike);
                  SnackBarUtil.showToasts(
                    message: '${widget.bike.title} successfully Added',
                  );
                } else {
                  SnackBarUtil.showToasts(
                    message: '${widget.bike.title} already in cart',
                  );
                }
              });
            },
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
                horizontal: Dimens.s_25(),
                vertical: Dimens.verticalBlockSize * 2,
              ),
              child: Text(
                'Add to Cart',
                style: AppTextStyle.bodyRegular[15]?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
