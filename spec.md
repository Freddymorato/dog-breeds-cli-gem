# Specifications for the CLI Assessment

Specs:
- [X] Have a CLI for interfacing with the application
-   CLI is launched at gem start up. First it displays to the user a list of 209 dog breeds, and the user must select a dog breed to learn more about via a CLI. From that point on, the user continues to use the CLI to learn about more details on the selected dog breed.

- [X] Pull data from an external source
-   The data is scraped from the index page (http://www.dogtime.com), and then some more is scraped from each individual page of each breed.

- [X] Implement both list and detail views
-   List view contains 209 dog breeds scraped from the index page (http://www.dogtime.com). Detail views display a brief overview of a specific breed, and then allow for options of which specific topic to learn more about. These details are scraped from each breed page. 
