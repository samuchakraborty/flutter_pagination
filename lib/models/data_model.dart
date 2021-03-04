// class DataModel {
//   int totalRecords;
//   List<Radio> data;
//
//   DataModel({
//     this.totalRecords,
//     this.data,
//   });
//
//   factory DataModel.fromJson(Map<String, dynamic> json) {
//     return DataModel(
//       totalRecords: int.parse(json['Message']),
//       data: (json["Data"] as List).map((i) => Radio.fromJson(i)).toList()
//     );
//   }
// }
//
// class Radio {
//   final int id;
//   final String radioName;
//
//   Radio({
//     this.id,
//     this.radioName,
//   });
//
//   factory Radio.fromJson(Map<String, dynamic> json) {
//     return Radio(
//       id: json["ID"],
//       radioName: json['RadioName'],
//     );
//   }
// }

class LoadDataPagination {
  LoadDataPagination({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  ItemListData data;

  factory LoadDataPagination.fromJson(Map<String, dynamic> json) => LoadDataPagination(
    status: json["status"],
    message: json["message"],
    data: ItemListData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class ItemListData {
  ItemListData({
    this.currentPage,
    this.products,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Product> products;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory ItemListData.fromJson(Map<String, dynamic> json) => ItemListData(
    currentPage: json["current_page"],
    products:
    List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(products.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Product {
  Product(
      {this.name,
        this.slug,
        this.deliveryCharge,
        this.featureImage,
        this.warrantyPeriod,
        this.warrantyPolicy,
        this.highlights,
        this.description,
        this.featureImageResized,
        this.thumbFeatureImage,
        this.shortDescription,
        this.additionalDeliveryCharge,
        this.status,
        this.deliverySizeId,
        this.rating,
        this.maxOrderableQty,
        this.bestSeller,
        this.digitalSheba,
        this.isWishlisted,
        this.originalPrice,
        //  this.variants,
        this.qty = 1});
  int qty;
  String name;
  String slug;
  int deliveryCharge;
  String featureImage;
  dynamic warrantyPeriod;
  dynamic warrantyPolicy;
  dynamic highlights;
  String description;
  String featureImageResized;
  String thumbFeatureImage;
  String shortDescription;
  dynamic additionalDeliveryCharge;
  int status;
  int deliverySizeId;
  int rating;
  int maxOrderableQty;
  int bestSeller;
  int digitalSheba;
  bool isWishlisted;
  int originalPrice;
//  List<Variant> variants;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["name"],
    slug: json["slug"],
    deliveryCharge: json["delivery_charge"],
    featureImage: json["feature_image"],
    warrantyPeriod: json["warranty_period"],
    warrantyPolicy: json["warranty_policy"],
    highlights: json["highlights"],
    description: json["description"],
    featureImageResized: json["feature_image_resized"],
    thumbFeatureImage: json["thumb_feature_image"],
    shortDescription: json["short_description"],
    additionalDeliveryCharge: json["additional_delivery_charge"],
    status: json["status"],
    deliverySizeId: json["delivery_size_id"],
    rating: json["rating"],
    maxOrderableQty: json["max_orderable_qty"],
    bestSeller: json["best_seller"],
    digitalSheba: json["digital_sheba"],
    isWishlisted: json["isWishlisted"],
    originalPrice: json["original_price"],
    // variants: List<Variant>.from(
    //     json["variants"].map((x) => Variant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "delivery_charge": deliveryCharge,
    "feature_image": featureImage,
    "warranty_period": warrantyPeriod,
    "warranty_policy": warrantyPolicy,
    "highlights": highlights,
    "description": description,
    "feature_image_resized": featureImageResized,
    "thumb_feature_image": thumbFeatureImage,
    "short_description": shortDescription,
    "additional_delivery_charge": additionalDeliveryCharge,
    "status": status,
    "delivery_size_id": deliverySizeId,
    "rating": rating,
    "max_orderable_qty": maxOrderableQty,
    "best_seller": bestSeller,
    "digital_sheba": digitalSheba,
    "isWishlisted": isWishlisted,
    "original_price": originalPrice,
    // "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
  };
}