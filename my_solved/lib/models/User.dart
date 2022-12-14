class User {
  final String? handle;
  final String? bio;
  final List<dynamic> organizations;
  final dynamic badge;
  final dynamic background;
  final String? profileImageUrl;
  final int solvedCount;
  final int voteCount;
  final int userClass;
  final String? classDecoration;
  final int tier;
  final int rating;
  final int ratingByProblemsSum;
  final int ratingByClass;
  final int ratingBySolvedCount;
  final int ratingByVoteCount;
  final int exp;
  final int rivalCount;
  final int reverseRivalCount;
  final int maxStreak;
  final dynamic proUntil;
  final int rank;

  const User({
    required this.handle,
    required this.bio,
    required this.organizations,
    required this.badge,
    required this.background,
    required this.profileImageUrl,
    required this.solvedCount,
    required this.voteCount,
    required this.userClass,
    required this.classDecoration,
    required this.tier,
    required this.rating,
    required this.ratingByProblemsSum,
    required this.ratingByClass,
    required this.ratingBySolvedCount,
    required this.ratingByVoteCount,
    required this.exp,
    required this.rivalCount,
    required this.reverseRivalCount,
    required this.maxStreak,
    required this.proUntil,
    required this.rank,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      handle: json['handle'],
      bio: json['bio'],
      organizations: json['organizations'],
      badge: json['badge'],
      background: json['background'],
      profileImageUrl: json['profileImageUrl'],
      solvedCount: json['solvedCount'],
      voteCount: json['voteCount'],
      userClass: json['class'],
      classDecoration: json['classDecoration'],
      tier: json['tier'],
      rating: json['rating'],
      ratingByProblemsSum: json['ratingByProblemsSum'],
      ratingByClass: json['ratingByClass'],
      ratingBySolvedCount: json['ratingBySolvedCount'],
      ratingByVoteCount: json['ratingByVoteCount'],
      exp: json['exp'],
      rivalCount: json['rivalCount'],
      reverseRivalCount: json['reverseRivalCount'],
      maxStreak: json['maxStreak'],
      proUntil: json['proUntil'],
      rank: json['rank'],
    );
  }
}
