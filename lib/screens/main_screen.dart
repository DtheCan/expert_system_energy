import 'package:expert_system_energy/screens/electricity_questionnaire_screens.dart';
import 'package:flutter/material.dart';
import '../models/building_data.dart';
import '../models/energy_analysis.dart';
import '../services/expert_system_service.dart';
import '../widgets/building_input_form.dart';
import '../widgets/analysis_results.dart';
import '../widgets/recommendations_panel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final BuildingData _buildingData = BuildingData();
  EnergyAnalysis? _analysisResults;
  bool _isAnalyzing = false;

  void _analyzeEnergyConsumption() {
    setState(() {
      _isAnalyzing = true;
    });

    // Имитация задержки анализа
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _analysisResults = ExpertSystemService.analyzeBuilding(_buildingData);
        _isAnalyzing = false;
      });
    });
  }

  void _onBuildingDataChanged(BuildingData newData) {
    setState(() {
      _buildingData
        ..area = newData.area
        ..occupants = newData.occupants
        ..monthlyEnergyConsumption = newData.monthlyEnergyConsumption
        ..buildingType = newData.buildingType
        ..buildingAge = newData.buildingAge
        ..hasHeatingSystem = newData.hasHeatingSystem
        ..hasCoolingSystem = newData.hasCoolingSystem
        ..hasEnergyCertification = newData.hasEnergyCertification
        ..heatingType = newData.heatingType
        ..insulationLevel = newData.insulationLevel
        ..windowType = newData.windowType
        ..hasSolarPanels = newData.hasSolarPanels
        ..climateZone = newData.climateZone
        ..electricityPrice = newData.electricityPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профессиональная система анализа энергопотребления'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: _isAnalyzing
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Форма ввода данных
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Ввод данных о здании',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          BuildingInputForm(
                            buildingData: _buildingData,
                            onDataChanged: _onBuildingDataChanged,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Результаты анализа
                  if (_analysisResults != null) ...[
                    AnalysisResults(analysis: _analysisResults!),
                    const SizedBox(height: 20),
                    RecommendationsPanel(
                      recommendations: _analysisResults!.recommendations,
                    ),
                  ],
                ],
              ),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Первая кнопка - Анализ электропотребления
          FloatingActionButton.extended(
            onPressed: _openElectricityQuestionnaire,
            icon: const Icon(Icons.electrical_services),
            label: const Text('Электроанализ'),
            backgroundColor: Colors.blue,
            heroTag:
                'electricity_analysis', // Уникальный heroTag для каждой кнопки
          ),
          const SizedBox(width: 16), // Отступ между кнопками
          // Вторая кнопка - Основной анализ
          FloatingActionButton.extended(
            onPressed: _analyzeEnergyConsumption,
            icon: const Icon(Icons.energy_savings_leaf),
            label: const Text('Анализ'),
            backgroundColor: Colors.green,
            heroTag: 'energy_analysis', // Уникальный heroTag для каждой кнопки
          ),
        ],
      ),
    );
  }

  void _openElectricityQuestionnaire() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ElectricityQuestionnaireScreen(
          electricityPrice: _buildingData.electricityPrice,
        ),
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Справка по системе'),
          content: const SingleChildScrollView(
            child: Text(
              'Эта экспертная система анализирует энергопотребление зданий и предоставляет рекомендации по оптимизации.\n\n'
              'Система учитывает:\n'
              '• Основные параметры здания\n'
              '• Тип и возраст конструкций\n'
              '• Используемые системы\n'
              '• Экономические показатели\n\n'
              'Рекомендации включают оценку стоимости, экономии и сроков окупаемости.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }
}
