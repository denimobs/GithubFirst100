import 'github_user.dart';

class GithubRepository {
  GithubRepository({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.description,
    this.htmlUrl,
    this.owner,
  });

  int id;
  String nodeId;
  String name;
  String fullName;
  String description;
  String htmlUrl;
  GithubUser owner;

  factory GithubRepository.fromMap(Map<String, dynamic> json) =>
      GithubRepository(
        id: json["id"],
        nodeId: json["node_id"],
        name: json["name"],
        fullName: json["full_name"],
        description: json['description'],
        htmlUrl: json['html_url'],
        owner: GithubUser.fromMap(json["owner"]),
      );
}
