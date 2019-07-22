import 'package:intl/intl.dart';

class GithubIssue {
  final String title;
  final String state;
  final DateTime createdAt;

  String get createdAtFormatted =>
      DateFormat.yMMMd().add_Hm().format(createdAt);

  GithubIssue.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        state = json['state'],
        createdAt = DateTime.parse(json['created_at']);
}
