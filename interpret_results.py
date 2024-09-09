#to use sum, just replace mean with sum
import pandas as pd

# Read the CSV file
df = pd.read_csv("timings.csv", sep='|')

# Filter and group by day and q, then calculate the mean for the 'time' column
df2 = df[df['day'] == '2012-11-29'].groupby('q', sort=False)['time'].mean()
print("batch 2012-11-29")
print(df2)
print("")

df3 = df[df['day'] == '2012-11-30'].groupby('q', sort=False)['time'].mean()
print("batch 2012-11-30")
print(df3)
print("")

df4 = df[df['day'] == '2012-12-01'].groupby('q', sort=False)['time'].mean()
print("batch 2012-12-01")
print(df4)
print("")
