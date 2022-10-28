# Sentiment-Analysis-for-Drug-Utilization-Review

In this project, we examined the reviews regarding various drugs and medicines and their conditions and analyzed the sentiments and emotions in those reviews. This process is called Drug Utilization Review (DUR) and it involves a comprehensive review of patients' prescription and medication data before, during and after dispensing to ensure appropriate medication decision-making and positive patient outcomes.

We first did some Exploratory Data Analysis to analyze the overall dataset. We created intuitive visualizations, including barplots, scatterplots and even 3D graphs to plot various categorical and numerical variables. We then analyze the 'Review' column, which are the comments posted by patients taking the drugs. We first preprocess it, form the Term Document Matrix, create Bigrams, Trigrams and even a word cloud of the most common terms used. 

Next, we create a Sentiment Analysis model, using 2 of R's libraries: sentimentr and syuzhet. The sentimentr package calculates text polarity sentiment at the sentence level. Whereas the syuzhet package is used for the extraction of sentiment and sentiment-based plot arcs from text. They also provide 8 emotions like trust, anger, sadness, etc, and 2 sentiments, positive and negative.

Every review has a final score associated with it. a negative score indicates that the drug has negative effects. A score between 0-2 indicates a neutral mood whereas scores above 2 correspond with positive behaviors.
