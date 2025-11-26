class EnergyAnalysis {
  final double specificConsumption;
  final String efficiencyClass;
  final double co2Emissions; // kg CO2/month
  final double annualCost;
  final double potentialSavings;
  final String improvementPriority;
  final List<Recommendation> recommendations;

  EnergyAnalysis({
    required this.specificConsumption,
    required this.efficiencyClass,
    required this.co2Emissions,
    required this.annualCost,
    required this.potentialSavings,
    required this.improvementPriority,
    required this.recommendations,
  });
}

class Recommendation {
  final String title;
  final String description;
  final double cost; // approximate cost
  final double savings; // annual savings
  final int paybackPeriod; // months
  final String priority; // high, medium, low
  final String category;

  Recommendation({
    required this.title,
    required this.description,
    required this.cost,
    required this.savings,
    required this.paybackPeriod,
    required this.priority,
    required this.category,
  });
}