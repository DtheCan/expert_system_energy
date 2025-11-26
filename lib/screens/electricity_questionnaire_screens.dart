import 'package:flutter/material.dart';
import '../models/electricity_questionnaire.dart';
import '../services/electricity_questionnaire_service.dart';

class ElectricityQuestionnaireScreen extends StatefulWidget {
  final double electricityPrice;

  const ElectricityQuestionnaireScreen({Key? key, this.electricityPrice = 0.15})
    : super(key: key);

  @override
  _ElectricityQuestionnaireScreenState createState() =>
      _ElectricityQuestionnaireScreenState();
}

class _ElectricityQuestionnaireScreenState
    extends State<ElectricityQuestionnaireScreen> {
  final List<ElectricityQuestionnaire> _questions =
      ElectricityQuestionnaireService.getElectricityQuestions();
  final Map<String, ElectricityAnswer> _userAnswers = {};
  String _currentQuestionId = 'eq1';
  int _currentQuestionIndex = 0;
  final PageController _pageController = PageController();

  ElectricityQuestionnaire? get _currentQuestion {
    return _questions.firstWhere((q) => q.id == _currentQuestionId);
  }

  void _answerQuestion(ElectricityAnswer answer) {
    setState(() {
      _userAnswers[_currentQuestionId] = answer;

      if (answer.nextQuestionId != null) {
        _currentQuestionId = answer.nextQuestionId!;
        _currentQuestionIndex = _questions.indexWhere(
          (q) => q.id == _currentQuestionId,
        );
      } else {
        _moveToNextCategory();
      }

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _moveToNextCategory() {
    int currentIndex = _questions.indexWhere((q) => q.id == _currentQuestionId);
    String currentCategory = _currentQuestion?.category ?? '';

    for (int i = currentIndex + 1; i < _questions.length; i++) {
      if (_questions[i].category != currentCategory) {
        setState(() {
          _currentQuestionId = _questions[i].id;
          _currentQuestionIndex = i;
        });
        return;
      }
    }

    _showElectricityResults();
  }

  void _showElectricityResults() {
    final result = ElectricityQuestionnaireService.calculateElectricityResult(
      _userAnswers,
      widget.electricityPrice,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Анализ электропотребления'),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildResultCard(
                    'Расчетное месячное потребление',
                    '${result.estimatedMonthlyConsumption.toStringAsFixed(0)} кВт·ч',
                    Colors.blue,
                  ),

                  _buildResultCard(
                    'Годовые затраты на электроэнергию',
                    '${result.estimatedAnnualCost.toStringAsFixed(0)} ₽',
                    Colors.orange,
                  ),

                  _buildResultCard(
                    'Уровень энергоэффективности',
                    result.efficiencyLevel,
                    _getEfficiencyColor(result.efficiencyLevel),
                  ),

                  _buildResultCard(
                    'Потенциальная годовая экономия',
                    '${result.potentialSavings.toStringAsFixed(0)} ₽',
                    Colors.green,
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    'Рекомендации по оптимизации:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),

                  ...result.recommendations.entries.map((entry) {
                    return _buildRecommendationsSection(entry.key, entry.value);
                  }).toList(),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuestionnaire();
              },
              child: const Text('Пройти заново'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Применить рекомендации'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultCard(String title, String value, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
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
    );
  }

  Widget _buildRecommendationsSection(
    String category,
    List<String> recommendations,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        ...recommendations
            .map(
              (rec) => Padding(
                padding: const EdgeInsets.only(top: 6, left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(rec, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        const SizedBox(height: 12),
      ],
    );
  }

  Color _getEfficiencyColor(String level) {
    switch (level) {
      case 'Отличная':
        return Colors.green;
      case 'Очень хорошая':
        return Colors.lightGreen;
      case 'Хорошая':
        return Colors.orange;
      case 'Средняя':
        return Colors.deepOrange;
      default:
        return Colors.red;
    }
  }

  void _resetQuestionnaire() {
    setState(() {
      _userAnswers.clear();
      _currentQuestionId = 'eq1';
      _currentQuestionIndex = 0;
      _pageController.jumpToPage(0);
    });
  }

  double get _progress {
    return (_currentQuestionIndex + 1) / _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экспертный анализ электропотребления'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Прогресс бар
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border(bottom: BorderSide(color: Colors.blue.shade100)),
            ),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Вопрос ${_currentQuestionIndex + 1} из ${_questions.length}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    if (_currentQuestion != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _currentQuestion!.category,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Вопросы
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return _buildQuestionPage(_currentQuestion!);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionPage(ElectricityQuestionnaire question) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Вопрос
          Text(
            question.question,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          // Варианты ответов
          Expanded(
            child: ListView.builder(
              itemCount: question.answers.length,
              itemBuilder: (context, index) {
                final answer = question.answers[index];
                return _buildAnswerButton(answer);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton(ElectricityAnswer answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: answer.icon != null
            ? Text(answer.icon!, style: const TextStyle(fontSize: 24))
            : null,
        title: Text(
          answer.text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Баллы эффективности: ${answer.score}/10'),
            if (answer.powerConsumption != null)
              Text(
                'Примерное потребление: ~${answer.powerConsumption} кВт·ч/мес',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
        onTap: () => _answerQuestion(answer),
      ),
    );
  }
}
