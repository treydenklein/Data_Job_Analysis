# Import libraries
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load CSV file into pandas DataFrame
df = pd.read_csv(
    r"C:\Users\treyd\Projects\Data_Analytics\Data_Analysis_Portfolio_Projects\Data_Job_Analysis\csv_files\job_skill_demand.csv"
)

# Group data by job_title
grouped = df.groupby("job_title")

# Create colormap going from dark to light
colors = plt.cm.Blues(np.linspace(0.2, 1, 5))
colors = colors[::-1]  # Reverse the order of colors

# Create bar plot for each job title
for job_title, group_data in grouped:
    plt.style.use("dark_background")
    plt.figure(figsize=(10, 6))
    plt.barh(group_data["skills"], group_data["demand_count"], color=colors)
    plt.title(f"Top 5 Skills for {job_title}")
    plt.xlabel("Frequency")
    plt.xticks(rotation=45)
    plt.gca().invert_yaxis()  # Invert y-axis to display highest demand at the top
    plt.tight_layout()  # Adjust layout to prevent overlap
    plt.show()

# Note: All saved as '...\assets\top_5_skills_for_[job title].png'
