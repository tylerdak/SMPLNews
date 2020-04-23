# SMPL News
SMPL News is an open-source, SwiftUI based News app built with simplicity in mind.
It uses the [NewsAPI](https://newsapi.org) to retrieve news and will have basic features such as search and country specification implemented. 

## Requirements
You will need to register an API key at https://newsapi.org and then either replace the String interpolation in NetworkManager.swift or create a variable under the name "apiKey" that will contain your API key. (There are certainly other ways to do this, but these two are probably going to be the most common method.)

---
I plan on providing further documentation on this application. However, my focus is on my academics and so the release of that documentation will depend on that. 

This code is decently trivial, especially the NetworkManager and main ContentView, however I would like to mention that the majority of the code in each of those two mentioned files have been refactored from the London App Brewery's iOS 13 App Development Course, Section 17: SwiftUI and Declarative Programming. 