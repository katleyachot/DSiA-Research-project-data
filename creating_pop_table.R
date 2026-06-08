#creating a population table, population counts from https://worldpopulationreview.com/us-cities/oregon/springfield

population <- data.frame(
  city = c(
    "Eugene", "Eugene", "Eugene","Eugene", "Eugene", "Eugene","Eugene", "Eugene", "Eugene","Eugene", "Eugene",
    "Springfield", "Springfield", "Springfield", "Springfield", "Springfield", "Springfield","Springfield", "Springfield", "Springfield", "Springfield", "Springfield" 
  ),
  
  year = c(
    2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 
    2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025
  ),
  
  population = c(
    163400, 165885, 167780, 169695, 171210, 176654,174854, 176248, 176993, 177155, 179352,
    60500, 61600, 62400, 62800, 63300, 61900, 61900, 61300, 61100, 61200, 61000
  )
) 
write.csv(population, "population.csv", row.names = TRUE)

