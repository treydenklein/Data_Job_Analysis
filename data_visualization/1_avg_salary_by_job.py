# Import libraries
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick  # Import ticker module
import matplotlib.patches as mpatches  # Import patches for custom legend items

# Load CSV into a DataFrame
df = pd.read_csv(
    r"C:\Users\treyd\Projects\Data_Analytics\Data_Analysis_Portfolio_Projects\Data_Job_Analysis\csv_files\avg_salary_by_job.csv"
)

# Extract job titles and average salaries
job_titles = df["job_title"]
average_salaries = df["avg_yearly_salary"]

# Calculate average salary from dataset
average_salary = average_salaries.mean()

# Median salary in the U.S.
# Note: The 2023 median salary in the U.S. was $48,060
median_us_salary = 48060

# Create bar chart
plt.style.use("dark_background")  # Set plot style to dark mode
plt.figure(figsize=(12, 8))

# Set y-axis range
plt.ylim(0, 180000)

# Plot line for median salary in the U.S.
plt.axhline(
    y=median_us_salary, color="red", linestyle="--", label="2023 Median Salary (U.S.)"
)

# Plot line for average salary from dataset
plt.axhline(
    y=average_salary, color="white", linestyle="--", label="Chart Average Salary"
)

# Determine bar color based on value compared to average line
bar_color = [
    {value < average_salary: "grey", value > average_salary: "skyblue"}[True]
    for value in average_salaries
]

# Plot data
plt.bar(job_titles, average_salaries, color=bar_color)

# Add text labels for plot lines
plt.text(
    x=9,  # x-position
    y=median_us_salary + 2500,  # y-position
    s=f"${median_us_salary:,.0f}",  # Text to display
    color="red",
    ha="center",
    fontsize=11,
)

plt.text(
    x=9,  # x-position
    y=average_salary + 2500,  # y-position
    s=f"${average_salary:,.0f}",  # Text to display
    color="white",
    ha="center",
    fontsize=11,
)

# Customize bar chart
plt.title("Avg Salary by Job")
plt.xticks(rotation=45)
plt.ylabel("Avg Salary")
plt.yticks(rotation=45)
plt.legend()  # Show chart legend

# Format x-axis ticks with dollar sign ($)
fmt = "${x:,.0f}"
tick = mtick.StrMethodFormatter(fmt)
plt.gca().yaxis.set_major_formatter(tick)

# Create custom legend items for bar colors
low_salary_patch = mpatches.Patch(color="grey", label="Below Average")
high_salary_patch = mpatches.Patch(color="skyblue", label="Above Average")

# Add custom legend items to the chart legend
plt.legend(
    handles=[
        plt.gca().get_lines()[0],
        plt.gca().get_lines()[1],
        low_salary_patch,
        high_salary_patch,
    ]
)

plt.tight_layout()  # Adjust layout to prevent overlap
plt.show()

# Note: Saved as '...\assets\avg_salary_by_job.png'
