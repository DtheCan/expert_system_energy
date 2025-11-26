import 'package:flutter/material.dart';
import '../models/energy_analysis.dart';

class AnalysisResults extends StatelessWidget {
  final EnergyAnalysis analysis;

  const AnalysisResults({Key? key, required this.analysis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Результаты анализа энергоэффективности',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            
            _buildMetricCard(
              'Удельное энергопотребление',
              '${analysis.specificConsumption.toStringAsFixed(2)} кВт·ч/м²',
              _getConsumptionColor(analysis.specificConsumption),
              Icons.speed,
            ),
            
            const SizedBox(height: 12),
            
            _buildMetricCard(
              'Класс энергоэффективности',
              analysis.efficiencyClass,
              _getEfficiencyColor(analysis.efficiencyClass),
              Icons.energy_savings_leaf,
            ),
            
            const SizedBox(height: 12),
            
            _buildMetricCard(
              'Годовые затраты на энергию',
              '${analysis.annualCost.toStringAsFixed(0)} ₽',
              Colors.orange.shade700,
              Icons.attach_money,
            ),
            
            const SizedBox(height: 12),
            
            _buildMetricCard(
              'Выбросы CO₂ в месяц',
              '${analysis.co2Emissions.toStringAsFixed(0)} кг',
              Colors.blueGrey.shade700,
              Icons.eco,
            ),
            
            const SizedBox(height: 12),
            
            _buildMetricCard(
              'Потенциальная годовая экономия',
              '${analysis.potentialSavings.toStringAsFixed(0)} ₽',
              Colors.green.shade700,
              Icons.savings,
            ),
            
            const SizedBox(height: 12),
            
            _buildMetricCard(
              'Приоритет улучшений',
              analysis.improvementPriority,
              _getPriorityColor(analysis.improvementPriority),
              Icons.warning_amber_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getConsumptionColor(double consumption) {
    if (consumption < 8) return Colors.green.shade700;
    if (consumption < 12) return Colors.lightGreen.shade700;
    if (consumption < 18) return Colors.orange.shade700;
    if (consumption < 25) return Colors.deepOrange.shade700;
    return Colors.red.shade700;
  }

  Color _getEfficiencyColor(String efficiencyClass) {
    if (efficiencyClass.contains('A++')) return Colors.green.shade900;
    if (efficiencyClass.contains('A+')) return Colors.green.shade800;
    if (efficiencyClass.contains('A')) return Colors.green.shade700;
    if (efficiencyClass.contains('B')) return Colors.lightGreen.shade700;
    if (efficiencyClass.contains('C')) return Colors.orange.shade700;
    if (efficiencyClass.contains('D')) return Colors.deepOrange.shade700;
    if (efficiencyClass.contains('E')) return Colors.red.shade700;
    return Colors.red.shade900;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Критический':
        return Colors.red.shade700;
      case 'Высокий':
        return Colors.orange.shade700;
      case 'Средний':
        return Colors.blue.shade700;
      default:
        return Colors.green.shade700;
    }
  }
}