class TokenBulk {
  String accessToken;
  String refreshToken;

  TokenBulk({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory TokenBulk.fromJson(Map<String, dynamic> json) {
    return TokenBulk(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  @override
  String toString() =>
      "TokenBulk(accessToken: $accessToken,refreshToken: $refreshToken)";

  @override
  int get hashCode => Object.hash(accessToken, refreshToken);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenBulk &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          refreshToken == other.refreshToken;
}
