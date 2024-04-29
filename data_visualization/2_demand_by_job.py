# Import libraries
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load CSV into a DataFrame
df = pd.read_csv(
    r"C:\Users\treyd\Projects\Data_Analytics\Data_Analysis_Portfolio_Projects\Job_Market_Analysis\csv_files\demand_by_job.csv"
)

# Extract job titles and number of job postings
job_titles = df["job_title"]
job_counts = df["job_count"]

# Create colormap going from dark to light
colors = plt.cm.Blues(np.linspace(0.2, 1, len(job_titles)))
colors = colors[::-1]  # Reverse the order of colors

# Create bar chart
plt.style.use("dark_background")  # Set plot style to dark mode
plt.figure(figsize=(10, 6))
plt.barh(job_titles, job_counts, color=colors)
plt.title("Demand by Job")
plt.xlabel("Frequency")
plt.gca().invert_yaxis()  # Invert y-axis to display highest demand at the top

plt.tight_layout()  # Adjust layout to prevent overlap
plt.show()

# Note: Saved as '...\assets\demand_by_job.png'
