# Import libraries
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick  # Import ticker module

# Read CSV file into pandas DataFrame
df = pd.read_csv(
    r"C:\Users\treyd\Projects\Data_Analytics\Data_Analysis_Portfolio_Projects\Data_Job_Analysis\csv_files\most_optimal_skills_to_learn.csv"
)

# Extract skills, demand counts, and average salaries
skills = df["skills"]
demand_counts = df["demand_count"]
avg_salaries = df["avg_salary"]

# Create figure to display bar charts
plt.style.use("dark_background")  # Set plot style to dark mode
plt.figure(figsize=(12, 6))

# Plot demand by skill
plt.subplot(2, 1, 1)  # 2 rows, 1 column, plot 1
plt.bar(skills, demand_counts, color="skyblue")
plt.title("Demand by Skill")
plt.ylabel("Demand")

# Plot average salaries by skill
plt.subplot(2, 1, 2)  # 2 rows, 1 column, plot 2
plt.bar(skills, avg_salaries, color="salmon")
plt.title("Average Salary by Skill")
plt.ylabel("Avg Salary")

# Format y-axis ticks with dollar sign ($)
fmt = "${x:,.0f}"
tick = mtick.StrMethodFormatter(fmt)
plt.gca().yaxis.set_major_formatter(tick)

plt.tight_layout()  # Adjust layout to prevent overlap
plt.show()

# Note: Saved as '...\assets\most_optimal_skills_to_learn.png'
