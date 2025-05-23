import 'package:bike_shop/core/constants/constants.dart';
import 'package:bike_shop/core/controller/main_controller.dart';
import 'package:bike_shop/core/model/bike_model.dart';
import 'package:bike_shop/core/utils/format.dart';
import 'package:bike_shop/core/widgets/entry_list_item.dart';
import 'package:bike_shop/screens/description_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int idx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              _appBar(),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(ImagesAsset.background),
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.s_20()),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _offerCard(),
                            Stack(children: [_menuCard(), _itemList()]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          MainController.to.category.map((e) {
            int idx = MainController.to.category.indexOf(e);
            return Padding(
              padding: EdgeInsets.only(bottom: idx == 0 ? 10 : ((idx * 20))),
              child: EntryListItem(index: idx, child: Image.asset(e, scale: 4)),
            );
          }).toList(),
    );
  }

  Widget _itemList() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: (MainController.to.bike.length / 2).round(),
        padding: EdgeInsets.symmetric(vertical: Dimens.verticalBlockSize * 10),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (c, i) {
          int idx = 0;
          int idx1 = 0;
          if (i != 0) {
            idx = i + i;
          }
          idx1 = idx + 1;
          BikeModel bike = MainController.to.bike[idx];
          BikeModel bike2 = MainController.to.bike[idx1];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => DescriptionScreen(bike: bike));
                },
                child: _boxView(bike, i),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => DescriptionScreen(bike: bike2));
                  },
                  child: _boxView(bike2, i),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _offerCard() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: Dimens.verticalBlockSize * 28,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesAsset.rec_1),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Column(
          children: [
            EntryListItem(
              index: 2,
              child: Image.asset(MainController.to.bike[2].img, scale: 4),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.s_45()),
                child: EntryListItem(
                  index: 3,
                  child: Text(
                    '30% Off',
                    textAlign: TextAlign.left,
                    style: AppTextStyle.bodyRegular[25]?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white60,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _appBar() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.s_20()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EntryListItem(
              index: 0,
              child: Text(
                'Choose Your Bike',
                style: AppTextStyle.bodyRegular[20]?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            EntryListItem(
              index: 1,
              child: Image.asset(IconsAsset.search, scale: 3.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxView(BikeModel bike, int i) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimens.verticalBlockSize * 3,
        horizontal: Dimens.s_15(),
      ),
      height: Dimens.verticalBlockSize * 26,
      width: Dimens.horizontalBlockSize * 42,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(ImagesAsset.rec_2),
          fit: BoxFit.fill,
        ),
      ),
      child: EntryListItem(index: i, child: _itemView(bike)),
    );
  }

  Widget _itemView(BikeModel bike) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(
              bike.img,
              height: Dimens.horizontalBlockSize * 24,
              width: Dimens.horizontalBlockSize * 28,
              fit: BoxFit.fill,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Transform.translate(
                offset: Offset(2.0, -8.0),
                child: InkWell(
                  onTap: () {
                    bike.isLike = !bike.isLike;
                    MainController.to.bike.refresh();
                  },
                  child: Image.asset(
                    bike.isLike ? IconsAsset.fillHeart : IconsAsset.heart,
                    scale: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        Text(
          bike.title,
          textAlign: TextAlign.left,
          style: AppTextStyle.bodyRegular[13]?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.white60,
          ),
        ),
        Text(
          bike.name,
          textAlign: TextAlign.left,
          style: AppTextStyle.bodyRegular[15]?.copyWith(
            height: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          StringFormat.priceFormat(bike.price),
          textAlign: TextAlign.left,
          style: AppTextStyle.bodyRegular[13]?.copyWith(
            height: 1.2,
            fontWeight: FontWeight.w500,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}
