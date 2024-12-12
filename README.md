# Tracking-User-Engagement-Project

## Overview
- This project evaluates the impact of new platform features—including new courses, exams, and career tracks—on student engagement. By analyzing real-world data, we aim to determine whether these additions successfully enhanced user activity and retention.
- Hypothesis: We hypothesized that the first half of 2022 would prove profitable due to the release of several new features on our website. These features include the ability to enroll in career tracks, test knowledge through practice, course, and career track exams, and an expanded course library. Our aim was to increase user engagement and grow the platform's audience by covering a broader range of topics. To measure the effectiveness of these new features and overall user engagement, we compare various metrics.
## Objectives
- Assess whether platform additions in late 2021 increased user engagement.

- Compare engagement metrics (e.g., time watched, certificates issued) between Q2 2021 and Q2 2022.

- Validate the hypothesis that the first half of 2022 was more profitable due to these changes.

## Data Transformation and Preprocessing
Aggregate metrics using SQL:
- Calculates the total number of minutes of video watched by each student in a specific year.
- Calculate the effective end date of student subscription plans
- Provides a comprehensive summary of student engagement by combining two key metrics (Video Engagement, Certificates Achievement)
- Creates a database view to summarize student subscription details. It includes data about subscription start and end dates and adds flags to indicate whether a subscription was active during specific quarters (Q2 2021 and Q2 2022).
* All queries are in file SQL_Project
Remove outliers using Python:
- Distribution of minutes watched before removing outliers:
![image](https://github.com/user-attachments/assets/5eec8a97-d350-4abf-b0b7-5baac28e53fc)

- Distribution of minutes watched after removing outliers:
![image](https://github.com/user-attachments/assets/13b7e500-7b51-4e59-8165-a8d120d6ec55)

## Statistics and Hypothesis Testing in Excel
### Statistics
<img width="700" alt="image" src="https://github.com/user-attachments/assets/12233e14-a630-476d-91fe-d812614d4b16" />

### Conclusion:
- For Free-Plan Students: The platform successfully increased engagement among free-plan users. Efforts to convert these users into paying customers could be explored.
- For Paying Students: Engagement has declined, which is concerning. Additional investigation is needed to understand the causes, such as:
* Content alignment with paying users' needs.
* Perceived value of paid features.
* Competition from alternative platforms.

### Hypothesis Testing
![image](https://github.com/user-attachments/assets/375e8241-0901-4497-93d3-197e519f0eba)

1. Free-Plan Students:
- Alternative Hypothesis (H1): The engagement (minutes watched) in Q2 2021 is lower than in Q2 2022 (μ1 < μ2).
- Test Results:
* T-Statistic = -3.951 (absolute value is greater than the critical value 1.645).
* P-value (one-tailed) = 3.9E-05 (very small, less than the significance level of 0.05).
Conclusion: Reject the null hypothesis (H0). This indicates that the engagement of Free-Plan Students in Q2 2021 was indeed lower than in Q2 2022.
2. Paying Students:
- Alternative Hypothesis (H1): The engagement (minutes watched) in Q2 2021 is higher than in Q2 2022 (μ1 > μ2).
- Test Results:
* T-Statistic = 5.161 (greater than the critical value 1.645).
* P-value (one-tailed) = 1.3E-07 (very small, less than the significance level of 0.05).
=> Conclusion: Reject the null hypothesis (H0). This indicates that the engagement of Paying Students in Q2 2021 was indeed higher than in Q2 2022.

### Test for Variance
<img width="578" alt="image" src="https://github.com/user-attachments/assets/9822c758-e3f2-4a19-a5c6-d11b3e9eeff2" />

1. Free-Plan Students
- F-Test Results:
* F-value = 0.977665.
* P(F ≤ f) one-tail = 0.196838.
* F Critical one-tail = 0.957379.
- Conclusion:
* Since 𝑃(𝐹≤𝑓) = 0.196838 > 𝛼 = 0.05, we fail to reject the null hypothesis that the variances are equal.
* Implication: Variances for the two groups (2021 and 2022) can be assumed equal.

2. Paying Students
- F-Test Results:
* F-value = 1.497332.
* P(F ≤ f) one-tail = 1.5 × 10^(−23) (extremely small).
* F Critical one-tail = 1.069218.
- Conclusion:
* Since 𝑃(𝐹≤𝑓) = 1.5 × 10^(−23) < 𝛼 = 0.05, we reject the null hypothesis that the variances are equal.
* Implication: Variances for the two groups (2021 and 2022) cannot be assumed equal.

### Summary
- For Free-Plan Students, engagement increased from Q2 2021 to Q2 2022, indicating that the new platform features effectively attracted free-plan users. For Paying Students, engagement decreased
### General Recommendation:
- Focus on retaining paying customers while leveraging the increased engagement of free-plan users to expand the platform's audience and potentially increase conversions.

## Power BI Dashboard
![image](https://github.com/user-attachments/assets/b074f42b-643f-4762-b0ef-7a0b3610b3d0)

### Summary:
1. Minutes Watched by Paid in 2021, 2022
- 2021: Paying students watched 1.15M minutes.
- 2022: Paying students watched 0.17M minutes.
- Non-paying students show significantly lower engagement.

2. Top 5 Students by Certificates Issued
- Student 14700 has the highest number of certificates (35).
- Other students earned between 15 and 21 certificates.

3. Certificates vs Minutes
- A positive correlation can be observed, where higher minutes watched tend to result in more certificates.
- However, outliers exist (students with many minutes watched but fewer certificates).

4. Average of Minutes Watched by Certificates
- There is a noticeable increase in engagement (minutes watched) up to ~20 certificates.
- After 20 certificates, average minutes watched fluctuates, possibly indicating diminishing returns.

### Insight
* Engagement Trends: Paying students watched significantly more minutes compared to non-paying students in both 2021 and 2022. Engagement (minutes watched) decreased in 2022 compared to 2021, indicating potential changes in platform usage or user interest.
* Top Performers: A small subset of students contributes disproportionately to certificate earning, with Student 14700 being a clear standout.
* Certificates and Engagement: Higher engagement (minutes watched) correlates with more certificates earned, but the relationship is not strictly linear. Students with many certificates may represent outliers with exceptionally high engagement.
* Opportunity Areas: Non-paying students show minimal engagement, highlighting potential areas for improvement, such as incentivizing engagement through free or trial access. Efforts to sustain or increase engagement in 2022 could be revisited, given the decline from 2021.

## Prediction for Achivement
- Plot for our prediction by Linear Regression Model:
![image](https://github.com/user-attachments/assets/abaf3b6e-786b-42e6-bfa9-7c49315935c8)
R-Square Score: 0.305

## Conclusion
Our analysis yielded valuable insights into user engagement, offering a comprehensive understanding of the impact of recent platform enhancements. Key findings and conclusions are available in the project results.


## License
- This project is an open source, licensed under the MIT License and 365datascience
