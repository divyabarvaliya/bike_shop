class BikeModel {
  String img;
  String title;
  String name;
  double price;
  int piece;
  bool isLike;

  BikeModel({
    required this.img,
    required this.title,
    required this.name,
    required this.price,
    this.isLike = false,
    this.piece = 1,
  });

  BikeModel copyWith({
    String? img,
    String? title,
    String? name,
    double? price,
    bool? isLike,
    int? piece,
  }) {
    return BikeModel(
      img: img ?? this.img,
      title: title ?? this.title,
      name: name ?? this.name,
      price: price ?? this.price,
      piece: piece ?? this.piece,
      isLike: isLike ?? this.isLike,
    );
  }
}
