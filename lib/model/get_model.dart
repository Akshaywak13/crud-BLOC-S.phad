
class GetModel {
    int? createdAt;
    String? name;
    dynamic avatar;
    String? id;
    int? creatAt;
    int? create;

    GetModel({
        this.createdAt,
        this.name,
        this.avatar,
        this.id,
        this.creatAt,
        this.create,
    });

    factory GetModel.fromJson(Map<String, dynamic> json) => GetModel(
        createdAt: json["createdAt"],
        name: json["name"],
        avatar: json["avatar"],
        id: json["id"],
        creatAt: json["creatAt"],
        create: json["create"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "name": name,
        "avatar": avatar,
        "id": id,
        "creatAt": creatAt,
        "create": create,
    };
}
