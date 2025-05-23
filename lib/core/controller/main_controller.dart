import 'package:bike_shop/core/constants/assets.dart';
import 'package:bike_shop/core/model/bike_model.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  RxList<BikeModel> cart = <BikeModel>[].obs;
  List<String> category = [
    IconsAsset.cate_1,
    IconsAsset.cate_2,
    IconsAsset.cate_3,
    IconsAsset.cate_4,
    IconsAsset.cate_5,
  ];
  RxDouble left = (-1.5).obs;
  RxDouble bottom = 0.0.obs;
  RxInt selIn = 0.obs;
  RxList<String> iconList =
      [
        IconsAsset.bicycle,
        IconsAsset.map,
        IconsAsset.cart,
        IconsAsset.person,
        IconsAsset.docTxt,
      ].obs;
  RxList<BikeModel> bike =
      <BikeModel>[
        BikeModel(
          title: 'Road Bike',
          name: 'PEUGEOT-LR01',
          img: ImagesAsset.by_1,
          price: 1999.99,
        ),
        BikeModel(
          title: 'Road Helmet',
          name: 'SMITH-Trade',
          img: ImagesAsset.by_2,
          price: 500.00,
        ),
        BikeModel(
          title: 'Road Bike',
          name: 'PEUGEOT-LR01',
          img: ImagesAsset.by_3,
          price: 900.00,
        ),
        BikeModel(
          title: 'Road Bike',
          name: 'PEUGEOT-LR01',
          img: ImagesAsset.by_4,
          price: 1777.00,
        ),
        BikeModel(
          title: 'Road Bike',
          name: 'PEUGEOT-LR01',
          img: ImagesAsset.by_5,
          price: 800.00,
        ),
        BikeModel(
          title: 'Road Bike',
          name: 'PEUGEOT-LR01',
          img: ImagesAsset.by_6,
          price: 600.00,
        ),
      ].obs;
  List<String> plantsCategory = [
    'Plants',
    'Flowers',
    'Cacti',
    'Herbs',
    'Bonsai',
  ];
  RxInt selCate = 0.obs;
}
