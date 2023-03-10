import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df_tracks = pd.read_csv('C:/Users/Miles/Downloads/Spotify datasets/tracks.csv')
df_tracks.head()




# null values

pd.isnull(df_tracks).sum()


df_tracks.info()

sorted_df = df_tracks.sort_values('popularity', ascending=True).head(10)

df_tracks.describe().transpose()

most_popular = df_tracks.query('popularity>90', inplace=False).sort_values('popularity', ascending=False)
most_popular[:10]


df_tracks.set_index("release_date", inplace=True)
df_tracks.index = pd.to_datetime(df_tracks.index)
df_tracks.head()

df_tracks[["artists"]].iloc[18]

df_tracks["duration"] = df_tracks["duration_ms"].apply(lambda x: round(x/1000))
df_tracks.drop("duration_ms", inplace=True, axis=1)

df_tracks.duration.head()


corr_df = df_tracks.drop(["key", "mode", "explicit"], axis=1).corr(method="pearson")
plt.figure(figsize=(14, 6))
heatmap = sns.heatmap(corr_df, annot=True, fmt=".1g", vmin=-1, center=0, cmap="inferno", linewidths=1, linecolor="Black")
heatmap.set_title("Correlation HeatMap Between Variable")
heatmap.set_xticklabels(heatmap.get_xticklabels(), rotation=90)


sample_df = df_tracks.sample(int(0.004*len(df_tracks)))
print(len(sample_df))

# energy vs loudness correlation graph
plt.figure(figsize=(10, 6))
sns.regplot(data=sample_df, y="loudness", x="energy", color="c").set(title="Loudness vs Energy Correlation")


df_tracks['dates'] = df_tracks.index.get_level_values('release_date')
df_tracks.dates = pd.to_datetime(df_tracks.dates)
years = df_tracks.dates.dt.year

# Number of songs released each year
sns.displot(years,discrete=True, aspect=2, height=5, kind="hist").set(title="Number of songs per year")

# Year vs Duration average bar plot
total_dr = df_tracks.duration
fig_dims = (18, 7)
fig, ax = plt.subplots(figsize=fig_dims)
fig = sns.barplot(x=years, y=total_dr, ax=ax, errwidth=False).set(title="Year vs Duration")
plt.xticks(rotation=90)


# Year vs Duration line plot
total_dr = df_tracks.duration
sns.set_style(style="white-grid")
fig_dims = (10, 5)
fig, ax = plt.subplots(figsize=fig_dims)
fig=sns.lineplot(x=years, y=total_dr, ax=ax).set(title="Year vs Duration")
plt.xticks(rotation=60)

