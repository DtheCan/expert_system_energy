import '../models/building_data.dart';
import '../models/energy_analysis.dart';

class ExpertSystemService {
  static EnergyAnalysis analyzeBuilding(BuildingData data) {
    // Расчет удельного энергопотребления
    double specificConsumption = data.monthlyEnergyConsumption / data.area;
    
    // Определение класса энергоэффективности
    String efficiencyClass = _calculateEfficiencyClass(specificConsumption);
    
    // Расчет выбросов CO2 (примерные значения)
    double co2Emissions = data.monthlyEnergyConsumption * 0.5;
    
    // Годовые затраты
    double annualCost = data.monthlyEnergyConsumption * 12 * data.electricityPrice;
    
    // Генерация рекомендаций
    List<Recommendation> recommendations = _generateRecommendations(data, specificConsumption);
    
    // Потенциальная экономия
    double potentialSavings = recommendations.fold(0, (sum, rec) => sum + rec.savings);
    
    // Приоритет улучшений
    String improvementPriority = _calculateImprovementPriority(recommendations);

    return EnergyAnalysis(
      specificConsumption: specificConsumption,
      efficiencyClass: efficiencyClass,
      co2Emissions: co2Emissions,
      annualCost: annualCost,
      potentialSavings: potentialSavings,
      improvementPriority: improvementPriority,
      recommendations: recommendations,
    );
  }

  static String _calculateEfficiencyClass(double specificConsumption) {
    if (specificConsumption < 3) return 'A++ (Выдающаяся)';
    if (specificConsumption < 5) return 'A+ (Отличная)';
    if (specificConsumption < 8) return 'A (Очень хорошая)';
    if (specificConsumption < 12) return 'B (Хорошая)';
    if (specificConsumption < 18) return 'C (Средняя)';
    if (specificConsumption < 25) return 'D (Ниже средней)';
    if (specificConsumption < 35) return 'E (Низкая)';
    return 'F (Очень низкая)';
  }

  static List<Recommendation> _generateRecommendations(BuildingData data, double specificConsumption) {
    List<Recommendation> recommendations = [];

    // Рекомендации по теплоизоляции
    if (data.insulationLevel == 'Низкая' || specificConsumption > 15) {
      recommendations.add(Recommendation(
        title: 'Утепление стен и чердака',
        description: 'Дополнительное утепление минеральной ватой или пенополистиролом',
        cost: 150000,
        savings: 25000,
        paybackPeriod: 72,
        priority: 'high',
        category: 'Теплоизоляция',
      ));
    }

    // Рекомендации по окнам
    if (data.windowType == 'Одинарные стекла') {
      recommendations.add(Recommendation(
        title: 'Замена окон на энергоэффективные',
        description: 'Установка стеклопакетов с низкоэмиссионным покрытием',
        cost: 80000,
        savings: 15000,
        paybackPeriod: 64,
        priority: 'high',
        category: 'Окна',
      ));
    }

    // Рекомендации по отоплению
    if (data.heatingType == 'Электрическое' && data.electricityPrice > 0.12) {
      recommendations.add(Recommendation(
        title: 'Установка теплового насоса',
        description: 'Воздушный тепловой насос для отопления и охлаждения',
        cost: 300000,
        savings: 40000,
        paybackPeriod: 90,
        priority: 'medium',
        category: 'Отопление',
      ));
    }

    // Солнечные панели
    if (!data.hasSolarPanels && data.area > 80) {
      recommendations.add(Recommendation(
        title: 'Установка солнечных панелей',
        description: 'Фотоэлектрическая система 3 кВт для генерации электроэнергии',
        cost: 180000,
        savings: 20000,
        paybackPeriod: 108,
        priority: 'medium',
        category: 'Возобновляемая энергия',
      ));
    }

    // Умные системы
    recommendations.add(Recommendation(
      title: 'Умный термостат',
      description: 'Программируемый термостат с удаленным управлением',
      cost: 15000,
      savings: 8000,
      paybackPeriod: 23,
      priority: 'low',
      category: 'Автоматизация',
    ));

    // LED освещение
    if (specificConsumption > 10) {
      recommendations.add(Recommendation(
        title: 'Замена на LED освещение',
        description: 'Замена всех ламп накаливания на светодиодные',
        cost: 10000,
        savings: 5000,
        paybackPeriod: 24,
        priority: 'low',
        category: 'Освещение',
      ));
    }

    // Водосбережение
    recommendations.add(Recommendation(
      title: 'Экономичные смесители',
      description: 'Аэраторы и сенсорные смесители для экономии воды',
      cost: 8000,
      savings: 3000,
      paybackPeriod: 32,
      priority: 'low',
      category: 'Водоснабжение',
    ));

    // Система рекуперации
    if (data.area > 100) {
      recommendations.add(Recommendation(
        title: 'Система рекуперации тепла',
        description: 'Вентиляция с рекуперацией тепла для сохранения энергии',
        cost: 120000,
        savings: 18000,
        paybackPeriod: 80,
        priority: 'medium',
        category: 'Вентиляция',
      ));
    }

    return recommendations;
  }

  static String _calculateImprovementPriority(List<Recommendation> recommendations) {
    int highPriority = recommendations.where((r) => r.priority == 'high').length;
    if (highPriority > 2) return 'Критический';
    if (highPriority > 0) return 'Высокий';
    return 'Средний';
  }
}