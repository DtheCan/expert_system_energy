class ElectricityQuestionnaire {
  final String id;
  final String question;
  final String category;
  final List<ElectricityAnswer> answers;
  final String? imageAsset;

  ElectricityQuestionnaire({
    required this.id,
    required this.question,
    required this.category,
    required this.answers,
    this.imageAsset,
  });
}

class ElectricityAnswer {
  final String text;
  final int score;
  final double? powerConsumption; // кВт·ч/месяц
  final String? nextQuestionId;
  final String recommendationKey;
  final String? icon;

  ElectricityAnswer({
    required this.text,
    required this.score,
    this.powerConsumption,
    this.nextQuestionId,
    required this.recommendationKey,
    this.icon,
  });
}

class ElectricityQuestionnaireResult {
  final Map<String, int> categoryScores;
  final Map<String, List<String>> recommendations;
  final double estimatedMonthlyConsumption;
  final double estimatedAnnualCost;
  final String efficiencyLevel;
  final double potentialSavings;

  ElectricityQuestionnaireResult({
    required this.categoryScores,
    required this.recommendations,
    required this.estimatedMonthlyConsumption,
    required this.estimatedAnnualCost,
    required this.efficiencyLevel,
    required this.potentialSavings,
  });
}