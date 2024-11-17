class Collection {
  List<Data> data;
  Pagination pagination;

  Collection({
    required this.data,
    required this.pagination,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'pagination': pagination,
    };
  }

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() => "Collection(data: $data,pagination: $pagination)";

  @override
  int get hashCode => Object.hash(data, pagination);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Collection &&
          runtimeType == other.runtimeType &&
          data == other.data &&
          pagination == other.pagination;
}

class Data {
  String id;
  String name;
  int age;
  String gender;

  Data({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
    };
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
    );
  }

  @override
  String toString() => "Data(id: $id,name: $name,age: $age,gender: $gender)";

  @override
  int get hashCode => Object.hash(id, name, age, gender);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Data &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          age == other.age &&
          gender == other.gender;
}

class Pagination {
  int page;
  int limit;
  int totalRows;

  Pagination({
    required this.page,
    required this.limit,
    required this.totalRows,
  });

  Map<String, dynamic> toJson() {
    return {
      '_page': page,
      '_limit': limit,
      '_totalRows': totalRows,
    };
  }

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['_page'] as int,
      limit: json['_limit'] as int,
      totalRows: json['_totalRows'] as int,
    );
  }

  @override
  String toString() =>
      "Pagination(page: $page,limit: $limit,totalRows: $totalRows)";

  @override
  int get hashCode => Object.hash(page, limit, totalRows);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pagination &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          limit == other.limit &&
          totalRows == other.totalRows;
}
