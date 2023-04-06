class LikedUsers {
  final String uid;
  final String phone;
  final String profile;
  final DateTime createdAt;
  final String name;

  LikedUsers(
      {required this.uid,
      required this.phone,
      required this.profile,
      required this.name,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'profile': profile,
      'createAt': createdAt.millisecondsSinceEpoch,
      'name': name,
    };
  }

  factory LikedUsers.fromMap(Map<String, dynamic> map) {
    return LikedUsers(
      uid: map['uid'] ?? '',
      phone: map['phone'] ?? '',
      profile: map['profile'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createAt']),
      name: map['name'] ?? '',
    );
  }
}
