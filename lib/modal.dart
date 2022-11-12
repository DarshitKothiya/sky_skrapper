class CoronaCase {
  String country;
  String flag;
  int coronaCase;
  int death;
  int recovered;
  int activeCase;
  int criticalCase;
  int tests;
  int casesPerOneMillion;
  int deathsPerOneMillion;
  int population;
  String continent;

  CoronaCase({
    required this.country,
    required this.flag,
    required this.coronaCase,
    required this.death,
    required this.recovered,
    required this.activeCase,
    required this.criticalCase,
    required this.tests,
    required this.casesPerOneMillion,
    required this.deathsPerOneMillion,
    required this.population,
    required this.continent,
  });

  factory CoronaCase.fromMap({required Map Data}) {
    return CoronaCase(
        country: Data["country"],
        flag: Data["countryInfo"]["flag"],
        coronaCase: Data["cases"],
        death: Data["deaths"],
        recovered: Data["recovered"],
        activeCase: Data["active"],
        criticalCase: Data["critical"],
        tests: Data["tests"],
        casesPerOneMillion: Data["casesPerOneMillion"],
        deathsPerOneMillion: Data["deathsPerOneMillion"],
        population: Data["population"],
        continent: Data["continent"],
    );
  }
}
