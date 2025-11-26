class BuildingData {
  double area; // m²
  int occupants;
  double monthlyEnergyConsumption; // kWh
  String buildingType;
  int buildingAge; // years
  bool hasHeatingSystem;
  bool hasCoolingSystem;
  bool hasEnergyCertification;
  String heatingType;
  String insulationLevel;
  String windowType;
  bool hasSolarPanels;
  String climateZone;
  double electricityPrice; // per kWh

  BuildingData({
    this.area = 100.0,
    this.occupants = 4,
    this.monthlyEnergyConsumption = 500.0,
    this.buildingType = 'Квартира',
    this.buildingAge = 10,
    this.hasHeatingSystem = true,
    this.hasCoolingSystem = false,
    this.hasEnergyCertification = false,
    this.heatingType = 'Газовое',
    this.insulationLevel = 'Средняя',
    this.windowType = 'Двойные стекла',
    this.hasSolarPanels = false,
    this.climateZone = 'Умеренный',
    this.electricityPrice = 0.15,
  });
}