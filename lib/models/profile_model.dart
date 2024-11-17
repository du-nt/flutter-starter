class Profile {
  String username;
  String city;
  String email;

  Profile({
    required this.username,
    required this.city,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'city': city,
      'email': email,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'] as String,
      city: json['city'] as String,
      email: json['email'] as String,
    );
  }

  @override
  String toString() => "Profile(username: $username,city: $city,email: $email)";

  @override
  int get hashCode => Object.hash(username, city, email);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          city == other.city &&
          email == other.email;
}
