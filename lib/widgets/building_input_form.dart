import 'package:flutter/material.dart';
import '../models/building_data.dart';

class BuildingInputForm extends StatefulWidget {
  final BuildingData buildingData;
  final Function(BuildingData) onDataChanged;

  const BuildingInputForm({
    Key? key,
    required this.buildingData,
    required this.onDataChanged,
  }) : super(key: key);

  @override
  _BuildingInputFormState createState() => _BuildingInputFormState();
}

class _BuildingInputFormState extends State<BuildingInputForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Основные параметры'),
          _buildNumberInput('Площадь здания (м²)', widget.buildingData.area, (value) {
            widget.buildingData.area = value;
            widget.onDataChanged(widget.buildingData);
          }),
          _buildNumberInput('Количество жильцов', widget.buildingData.occupants.toDouble(), (value) {
            widget.buildingData.occupants = value.toInt();
            widget.onDataChanged(widget.buildingData);
          }),
          _buildNumberInput('Месячное потребление (кВт·ч)', widget.buildingData.monthlyEnergyConsumption, (value) {
            widget.buildingData.monthlyEnergyConsumption = value;
            widget.onDataChanged(widget.buildingData);
          }),
          _buildNumberInput('Возраст здания (лет)', widget.buildingData.buildingAge.toDouble(), (value) {
            widget.buildingData.buildingAge = value.toInt();
            widget.onDataChanged(widget.buildingData);
          }),

          _buildSectionHeader('Тип и характеристики'),
          _buildDropdown('Тип здания', widget.buildingData.buildingType, ['Квартира', 'Частный дом', 'Офис', 'Торговый центр', 'Склад'], (value) {
            widget.buildingData.buildingType = value!;
            widget.onDataChanged(widget.buildingData);
          }),
          _buildDropdown('Тип отопления', widget.buildingData.heatingType, ['Газовое', 'Электрическое', 'Твердотопливное', 'Тепловой насос'], (value) {
            widget.buildingData.heatingType = value!;
            widget.onDataChanged(widget.buildingData);
          }),
          _buildDropdown('Уровень теплоизоляции', widget.buildingData.insulationLevel, ['Низкая', 'Средняя', 'Высокая'], (value) {
            widget.buildingData.insulationLevel = value!;
            widget.onDataChanged(widget.buildingData);
          }),
          _buildDropdown('Тип окон', widget.buildingData.windowType, ['Одинарные стекла', 'Двойные стекла', 'Тройные стекла', 'Энергоэффективные'], (value) {
            widget.buildingData.windowType = value!;
            widget.onDataChanged(widget.buildingData);
          }),

          _buildSectionHeader('Дополнительные системы'),
          _buildCheckbox('Система отопления', widget.buildingData.hasHeatingSystem, (value) {
            widget.buildingData.hasHeatingSystem = value!;
            widget.onDataChanged(widget.buildingData);
          }),
          _buildCheckbox('Система кондиционирования', widget.buildingData.hasCoolingSystem, (value) {
            widget.buildingData.hasCoolingSystem = value!;
            widget.onDataChanged(widget.buildingData);
          }),
          _buildCheckbox('Солнечные панели', widget.buildingData.hasSolarPanels, (value) {
            widget.buildingData.hasSolarPanels = value!;
            widget.onDataChanged(widget.buildingData);
          }),
          _buildCheckbox('Энергетический паспорт', widget.buildingData.hasEnergyCertification, (value) {
            widget.buildingData.hasEnergyCertification = value!;
            widget.onDataChanged(widget.buildingData);
          }),

          _buildSectionHeader('Экономические параметры'),
          _buildNumberInput('Стоимость электроэнергии (₽/кВт·ч)', widget.buildingData.electricityPrice, (value) {
            widget.buildingData.electricityPrice = value;
            widget.onDataChanged(widget.buildingData);
          }),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }

  Widget _buildNumberInput(String label, double value, Function(double) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        initialValue: value.toString(),
        onChanged: (text) {
          double newValue = double.tryParse(text) ?? value;
          onChanged(newValue);
        },
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }
}