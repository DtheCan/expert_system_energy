import '../models/electricity_questionnaire.dart';

class ElectricityQuestionnaireService {
  static List<ElectricityQuestionnaire> getElectricityQuestions() {
    return [
      // Категория: Освещение
      ElectricityQuestionnaire(
        id: 'eq1',
        category: 'Освещение',
        question: 'Какие типы ламп преобладают в вашем доме/офисе?',
        answers: [
          ElectricityAnswer(
            text: '100% светодиодные (LED)',
            score: 10,
            powerConsumption: 20,
            recommendationKey: 'lighting_led_optimal',
            icon: '💡',
          ),
          ElectricityAnswer(
            text: 'В основном LED, несколько энергосберегающих',
            score: 8,
            powerConsumption: 35,
            recommendationKey: 'lighting_led_good',
            icon: '👍',
          ),
          ElectricityAnswer(
            text: 'Энергосберегающие и некоторые лампы накаливания',
            score: 5,
            powerConsumption: 80,
            nextQuestionId: 'eq2',
            recommendationKey: 'lighting_mixed_medium',
            icon: '⚠️',
          ),
          ElectricityAnswer(
            text: 'В основном лампы накаливания',
            score: 2,
            powerConsumption: 150,
            nextQuestionId: 'eq2',
            recommendationKey: 'lighting_incandescent_critical',
            icon: '🔴',
          ),
        ],
      ),

      ElectricityQuestionnaire(
        id: 'eq2',
        category: 'Освещение',
        question: 'Как часто используются осветительные приборы?',
        answers: [
          ElectricityAnswer(
            text: 'Только при необходимости, с датчиками движения',
            score: 10,
            powerConsumption: 5,
            recommendationKey: 'lighting_smart_control',
            icon: '📱',
          ),
          ElectricityAnswer(
            text: 'Экономно, выключаем когда не нужны',
            score: 7,
            powerConsumption: 15,
            recommendationKey: 'lighting_efficient_use',
            icon: '✅',
          ),
          ElectricityAnswer(
            text: 'Часто оставляем включенными',
            score: 3,
            powerConsumption: 30,
            recommendationKey: 'lighting_habit_improvement',
            icon: '💡',
          ),
        ],
      ),

      // Категория: Бытовая техника
      ElectricityQuestionnaire(
        id: 'eq3',
        category: 'Бытовая техника',
        question: 'Какой класс энергоэффективности у основной техники?',
        answers: [
          ElectricityAnswer(
            text: 'A+++ и A++',
            score: 10,
            powerConsumption: 120,
            recommendationKey: 'appliances_optimal',
            icon: '🏆',
          ),
          ElectricityAnswer(
            text: 'В основном A и A+',
            score: 8,
            powerConsumption: 180,
            recommendationKey: 'appliances_good',
            icon: '👍',
          ),
          ElectricityAnswer(
            text: 'Смешанные классы B/C и некоторые A',
            score: 5,
            powerConsumption: 250,
            nextQuestionId: 'eq4',
            recommendationKey: 'appliances_medium',
            icon: '➖',
          ),
          ElectricityAnswer(
            text: 'Старая техника классов D/G',
            score: 2,
            powerConsumption: 400,
            nextQuestionId: 'eq4',
            recommendationKey: 'appliances_old_critical',
            icon: '🔴',
          ),
        ],
      ),

      ElectricityQuestionnaire(
        id: 'eq4',
        category: 'Бытовая техника',
        question: 'Используете ли вы режимы ожидания у техники?',
        answers: [
          ElectricityAnswer(
            text: 'Выключаем полностью из розеток',
            score: 10,
            powerConsumption: 5,
            recommendationKey: 'standby_optimal',
            icon: '🔌',
          ),
          ElectricityAnswer(
            text: 'Используем умные розетки с таймерами',
            score: 8,
            powerConsumption: 10,
            recommendationKey: 'standby_smart',
            icon: '⏰',
          ),
          ElectricityAnswer(
            text: 'Оставляем в режиме ожидания',
            score: 4,
            powerConsumption: 40,
            recommendationKey: 'standby_improvement',
            icon: '⚡',
          ),
          ElectricityAnswer(
            text: 'Не обращаем внимание на режим ожидания',
            score: 1,
            powerConsumption: 80,
            recommendationKey: 'standby_critical',
            icon: '🔴',
          ),
        ],
      ),

      // Категория: Отопление и охлаждение
      ElectricityQuestionnaire(
        id: 'eq5',
        category: 'Климатизация',
        question: 'Какая система кондиционирования используется?',
        answers: [
          ElectricityAnswer(
            text: 'Инверторный кондиционер класса A+++',
            score: 10,
            powerConsumption: 150,
            recommendationKey: 'ac_inverter_optimal',
            icon: '❄️',
          ),
          ElectricityAnswer(
            text: 'Обычный кондиционер класса A',
            score: 7,
            powerConsumption: 220,
            recommendationKey: 'ac_standard_good',
            icon: '✅',
          ),
          ElectricityAnswer(
            text: 'Старый кондиционер низкого класса',
            score: 3,
            powerConsumption: 350,
            nextQuestionId: 'eq6',
            recommendationKey: 'ac_old_inefficient',
            icon: '⚠️',
          ),
          ElectricityAnswer(
            text: 'Нет кондиционера, используем вентиляторы',
            score: 8,
            powerConsumption: 30,
            recommendationKey: 'fans_efficient',
            icon: '💨',
          ),
        ],
      ),

      ElectricityQuestionnaire(
        id: 'eq6',
        category: 'Климатизация',
        question: 'Как часто используется кондиционер?',
        answers: [
          ElectricityAnswer(
            text: 'Только в самые жаркие дни, экономно',
            score: 9,
            powerConsumption: 50,
            recommendationKey: 'ac_minimal_use',
            icon: '🌡️',
          ),
          ElectricityAnswer(
            text: 'Регулярно, но с оптимальной температурой',
            score: 7,
            powerConsumption: 120,
            recommendationKey: 'ac_moderate_use',
            icon: '✅',
          ),
          ElectricityAnswer(
            text: 'Постоянно в сезон охлаждения/нагрева',
            score: 4,
            powerConsumption: 280,
            recommendationKey: 'ac_heavy_use',
            icon: '⚡',
          ),
        ],
      ),

      // Категория: Водонагревание
      ElectricityQuestionnaire(
        id: 'eq7',
        category: 'Водонагревание',
        question: 'Как нагревается вода?',
        answers: [
          ElectricityAnswer(
            text: 'Газовый или тепловой насос для воды',
            score: 10,
            powerConsumption: 20,
            recommendationKey: 'water_heating_efficient',
            icon: '🔥',
          ),
          ElectricityAnswer(
            text: 'Электрический бойлер с хорошей изоляцией',
            score: 6,
            powerConsumption: 180,
            recommendationKey: 'water_heating_electric_good',
            icon: '✅',
          ),
          ElectricityAnswer(
            text: 'Проточный электрический нагреватель',
            score: 4,
            powerConsumption: 250,
            nextQuestionId: 'eq8',
            recommendationKey: 'water_heating_instant',
            icon: '⚠️',
          ),
          ElectricityAnswer(
            text: 'Старый электрический бойлер',
            score: 2,
            powerConsumption: 320,
            nextQuestionId: 'eq8',
            recommendationKey: 'water_heating_old',
            icon: '🔴',
          ),
        ],
      ),

      ElectricityQuestionnaire(
        id: 'eq8',
        category: 'Водонагревание',
        question: 'Какой объем горячей воды используете ежедневно?',
        answers: [
          ElectricityAnswer(
            text: 'Экономно, до 50 литров на человека',
            score: 9,
            powerConsumption: 30,
            recommendationKey: 'water_usage_low',
            icon: '💧',
          ),
          ElectricityAnswer(
            text: 'Умеренно, 50-100 литров на человека',
            score: 6,
            powerConsumption: 80,
            recommendationKey: 'water_usage_medium',
            icon: '✅',
          ),
          ElectricityAnswer(
            text: 'Много, более 100 литров на человека',
            score: 3,
            powerConsumption: 150,
            recommendationKey: 'water_usage_high',
            icon: '🌊',
          ),
        ],
      ),

      // Категория: Кухонная техника
      ElectricityQuestionnaire(
        id: 'eq9',
        category: 'Кухонная техника',
        question: 'Какая у вас плита и духовка?',
        answers: [
          ElectricityAnswer(
            text: 'Индукционная плита, конвекционная духовка A++',
            score: 10,
            powerConsumption: 45,
            recommendationKey: 'cooking_induction_optimal',
            icon: '👨‍🍳',
          ),
          ElectricityAnswer(
            text: 'Стеклокерамическая плита, обычная духовка A',
            score: 7,
            powerConsumption: 80,
            recommendationKey: 'cooking_ceramic_good',
            icon: '✅',
          ),
          ElectricityAnswer(
            text: 'Электрические спирали, старая духовка',
            score: 3,
            powerConsumption: 150,
            recommendationKey: 'cooking_coils_inefficient',
            icon: '⚠️',
          ),
          ElectricityAnswer(
            text: 'Газовая плита (минимальное электричество)',
            score: 9,
            powerConsumption: 5,
            recommendationKey: 'cooking_gas_efficient',
            icon: '🔥',
          ),
        ],
      ),

      // Категория: Электроника
      ElectricityQuestionnaire(
        id: 'eq10',
        category: 'Электроника',
        question: 'Какое количество электроники постоянно работает?',
        answers: [
          ElectricityAnswer(
            text: 'Минимум, только необходимое',
            score: 10,
            powerConsumption: 25,
            recommendationKey: 'electronics_minimal',
            icon: '📱',
          ),
          ElectricityAnswer(
            text: 'Умеренное количество с умным управлением',
            score: 8,
            powerConsumption: 60,
            recommendationKey: 'electronics_managed',
            icon: '💻',
          ),
          ElectricityAnswer(
            text: 'Много устройств, некоторые постоянно включены',
            score: 5,
            powerConsumption: 120,
            nextQuestionId: 'eq11',
            recommendationKey: 'electronics_many',
            icon: '⚠️',
          ),
          ElectricityAnswer(
            text: 'Офис или развлекательный центр с множеством устройств',
            score: 3,
            powerConsumption: 250,
            nextQuestionId: 'eq11',
            recommendationKey: 'electronics_office',
            icon: '🔴',
          ),
        ],
      ),

      ElectricityQuestionnaire(
        id: 'eq11',
        category: 'Электроника',
        question: 'Используете ли вы игровые консоли, мощные ПК?',
        answers: [
          ElectricityAnswer(
            text: 'Нет игрового оборудования',
            score: 10,
            powerConsumption: 10,
            recommendationKey: 'gaming_none',
            icon: '✅',
          ),
          ElectricityAnswer(
            text: 'Игровая консоль, используется умеренно',
            score: 6,
            powerConsumption: 40,
            recommendationKey: 'gaming_console_moderate',
            icon: '🎮',
          ),
          ElectricityAnswer(
            text: 'Мощный игровой ПК, используется часто',
            score: 3,
            powerConsumption: 100,
            recommendationKey: 'gaming_pc_heavy',
            icon: '⚡',
          ),
        ],
      ),
    ];
  }

  static Map<String, String> getElectricityRecommendations() {
    return {
      'lighting_incandescent_critical': 'ЗАМЕНА ЛАМП НАКАЛИВАНИЯ: Замена на LED сэкономит 80-90% электроэнергии на освещении. Окупаемость: 6-12 месяцев.',
      'lighting_mixed_medium': 'ОПТИМИЗАЦИЯ ОСВЕЩЕНИЯ: Замените оставшиеся лампы накаливания на LED. Используйте датчики движения в редко используемых помещениях.',
      'lighting_smart_control': 'УМНОЕ ОСВЕЩЕНИЕ: Отличный подход! Рекомендуем добавить умные лампы с регулировкой яркости для дополнительной экономии.',
      
      'appliances_old_critical': 'ЗАМЕНА СТАРОЙ ТЕХНИКИ: Старая техника потребляет в 2-3 раза больше. При замене выбирайте класс A+++. Экономия: 150-300 кВт·ч/год на устройство.',
      'appliances_medium': 'ПЛАНИРУЙТЕ ЗАМЕНУ: При следующей покупке техники выбирайте класс A++ или выше. Начните с наиболее используемых приборов.',
      
      'standby_critical': 'РЕЖИМ ОЖИДАНИЯ: "Фантомное" потребление может составлять до 10% счета. Используйте умные розетки с таймерами.',
      'standby_improvement': 'УМНЫЕ РОЗЕТКИ: Установите умные розетки для полного отключения техники в нерабочее время.',
      
      'ac_old_inefficient': 'КОНДИЦИОНЕР: Старый кондиционер потребляет на 40-60% больше. Рассмотрите замену на инверторную модель класса A+++.',
      'ac_heavy_use': 'ОПТИМИЗАЦИЯ КОНДИЦИОНЕРА: Установите температуру на 24-25°C. Используйте таймеры. Регулярно чистите фильтры.',
      
      'water_heating_old': 'ВОДОНАГРЕВАТЕЛЬ: Старый бойлер теряет много тепла. Утеплите бак или замените на современную модель.',
      'water_heating_instant': 'ПРОТОЧНЫЙ НАГРЕВАТЕЛЬ: Установите температуру оптимально. Используйте только при необходимости.',
      'water_usage_high': 'СНИЖЕНИЕ РАСХОДА ВОДЫ: Установите экономичные душевые головки. Принимайте душ вместо ванны.',
      
      'cooking_coils_inefficient': 'ПЛИТА: Электрические спирали имеют КПД 60%. Индукционные плиты - 90%. Рассмотрите замену.',
      'cooking_induction_optimal': 'ИНДУКЦИОННАЯ ПЛИТА: Отличный выбор! Используйте крышки при готовке для дополнительной экономии.',
      
      'electronics_office': 'ОФИСНАЯ ТЕХНИКА: Настройте спящий режим. Используйте сетевые фильтры с выключателем. Выключайте на ночь.',
      'gaming_pc_heavy': 'ИГРОВОЕ ОБОРУДОВАНИЕ: Настройте энергосберегающий режим. Используйте таймеры автоматического выключения.',
      
      // Общие рекомендации
      'general_solar': 'СОЛНЕЧНЫЕ ПАНЕЛИ: Рассмотрите установку солнечных батарей. Снижение счета на 30-70%.',
      'general_tariff': 'МНОГОТАРИФНЫЙ УЧЕТ: Перейдите на многотарифный учет. Используйте энергоемкие приборы ночью.',
      'general_audit': 'ЭНЕРГОАУДИТ: Проведите профессиональный энергоаудит для выявления скрытых потерь.',
    };
  }

  static ElectricityQuestionnaireResult calculateElectricityResult(
      Map<String, ElectricityAnswer> userAnswers, double electricityPrice) {
    
    Map<String, int> categoryScores = {};
    Map<String, List<String>> recommendations = {};
    double totalMonthlyConsumption = 0;

    // Считаем баллы и потребление
    for (var answer in userAnswers.values) {
      String category = _getCategoryFromQuestionId(answer.recommendationKey);
      
      // Баллы по категориям
      categoryScores.update(
        category,
        (value) => value + answer.score,
        ifAbsent: () => answer.score,
      );

      // Потребление
      if (answer.powerConsumption != null) {
        totalMonthlyConsumption += answer.powerConsumption!;
      }

      // Рекомендации
      String recommendationText = getElectricityRecommendations()[answer.recommendationKey] ?? '';
      if (recommendationText.isNotEmpty) {
        if (!recommendations.containsKey(category)) {
          recommendations[category] = [];
        }
        if (!recommendations[category]!.contains(recommendationText)) {
          recommendations[category]!.add(recommendationText);
        }
      }
    }

    // Добавляем общие рекомендации
    _addGeneralRecommendations(recommendations, totalMonthlyConsumption);

    // Расчеты
    double annualCost = totalMonthlyConsumption * 12 * electricityPrice;
    double potentialSavings = _calculatePotentialSavings(recommendations, annualCost);
    String efficiencyLevel = _calculateEfficiencyLevel(totalMonthlyConsumption);

    return ElectricityQuestionnaireResult(
      categoryScores: categoryScores,
      recommendations: recommendations,
      estimatedMonthlyConsumption: totalMonthlyConsumption,
      estimatedAnnualCost: annualCost,
      efficiencyLevel: efficiencyLevel,
      potentialSavings: potentialSavings,
    );
  }

  static void _addGeneralRecommendations(Map<String, List<String>> recommendations, double consumption) {
    if (consumption > 300) {
      recommendations.putIfAbsent('Общие рекомендации', () => []);
      recommendations['Общие рекомендации']!.add(
        getElectricityRecommendations()['general_solar']!
      );
    }
    
    if (consumption > 200) {
      recommendations.putIfAbsent('Общие рекомендации', () => []);
      recommendations['Общие рекомендации']!.add(
        getElectricityRecommendations()['general_tariff']!
      );
    }
    
    recommendations.putIfAbsent('Общие рекомендации', () => []);
    recommendations['Общие рекомендации']!.add(
      getElectricityRecommendations()['general_audit']!
    );
  }

  static double _calculatePotentialSavings(Map<String, List<String>> recommendations, double annualCost) {
    double savingsPercent = 0.0;
    
    if (recommendations.values.any((list) => list.any((item) => item.contains('КРИТИЧЕСКИ')))) {
      savingsPercent += 0.35;
    }
    if (recommendations.values.any((list) => list.any((item) => item.contains('ЗАМЕНА')))) {
      savingsPercent += 0.25;
    }
    if (recommendations.values.any((list) => list.any((item) => item.contains('УМНЫЕ')))) {
      savingsPercent += 0.15;
    }
    
    return annualCost * savingsPercent;
  }

  static String _calculateEfficiencyLevel(double monthlyConsumption) {
    if (monthlyConsumption < 150) return 'Отличная';
    if (monthlyConsumption < 250) return 'Очень хорошая';
    if (monthlyConsumption < 400) return 'Хорошая';
    if (monthlyConsumption < 600) return 'Средняя';
    if (monthlyConsumption < 800) return 'Ниже средней';
    return 'Низкая';
  }

  static String _getCategoryFromQuestionId(String recommendationKey) {
    if (recommendationKey.contains('lighting')) return 'Освещение';
    if (recommendationKey.contains('appliances') || recommendationKey.contains('standby')) return 'Бытовая техника';
    if (recommendationKey.contains('ac') || recommendationKey.contains('fans')) return 'Климатизация';
    if (recommendationKey.contains('water')) return 'Водонагревание';
    if (recommendationKey.contains('cooking')) return 'Кухонная техника';
    if (recommendationKey.contains('electronics') || recommendationKey.contains('gaming')) return 'Электроника';
    return 'Общее';
  }
}