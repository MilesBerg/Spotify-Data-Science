df_genre=pd.read_csv('C:/Users/Miles/Downloads/SpotifyFeatures.csv/SpotifyFeatures')

df_genre.head()

# Duration of song in genres
plt.title("Duration of the Songs in Different Genres")
sns.color_palette("rocket", as_cmap= True)
sns.barplot(y='genre', x='duration_ms', data=df_genre)
plt.xlabel("Duration in milliseconds")
plt.ylabel("Genres")

# Top 5 genres
sns.set_style(style= "darkgrid")
plt.figure(figsize=(10,5))
famous = df_genre.sort_values("popularity", ascending=False).head(10)
sns.barplot(y='genre', x='popularity', data = famous).set(title= "Top 5 Genres by Popularity")
