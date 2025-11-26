import 'package:flutter/material.dart';
import '../models/energy_analysis.dart';

class RecommendationsPanel extends StatelessWidget {
  final List<Recommendation> recommendations;

  const RecommendationsPanel({Key? key, required this.recommendations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Группировка по категориям
    final categories = _groupByCategory(recommendations);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Рекомендации по оптимизации',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Найдено ${recommendations.length} рекомендаций',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            
            ...categories.entries.map((entry) {
              return _buildCategorySection(entry.key, entry.value);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Map<String, List<Recommendation>> _groupByCategory(List<Recommendation> recommendations) {
    final Map<String, List<Recommendation>> categories = {};
    
    for (var recommendation in recommendations) {
      if (!categories.containsKey(recommendation.category)) {
        categories[recommendation.category] = [];
      }
      categories[recommendation.category]!.add(recommendation);
    }
    
    return categories;
  }

  Widget _buildCategorySection(String category, List<Recommendation> categoryRecommendations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 10),
        ...categoryRecommendations.map((recommendation) {
          return _buildRecommendationCard(recommendation);
        }).toList(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildRecommendationCard(Recommendation recommendation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildPriorityIndicator(recommendation.priority),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    recommendation.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(recommendation.description),
            const SizedBox(height: 12),
            _buildFinancialInfo(recommendation),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityIndicator(String priority) {
    Color color;
    switch (priority) {
      case 'high':
        color = Colors.red;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      default:
        color = Colors.blue;
    }
    
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildFinancialInfo(Recommendation recommendation) {
    return Row(
      children: [
        _buildFinancialItem('Стоимость', '${recommendation.cost.toStringAsFixed(0)} ₽'),
        const SizedBox(width: 16),
        _buildFinancialItem('Экономия в год', '${recommendation.savings.toStringAsFixed(0)} ₽'),
        const SizedBox(width: 16),
        _buildFinancialItem('Окупаемость', '${recommendation.paybackPeriod} мес'),
      ],
    );
  }

  Widget _buildFinancialItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}