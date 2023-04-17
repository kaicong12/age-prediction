# Predicting Biological Age from Cognitive Function Test Scores

This repository contains the code and data for our study on predicting biological age from cognitive function test scores.

## Table of Contents

- [Introduction](#introduction)
- [Data](#data)
- [Methods](#methods)
    - [Baseline Model](#baseline-model)
    - [Data Imputation](#data-imputation)
    - [Hyperparameter Tuning](#hyperparameter-tuning)
- [Results](#results)
- [Conclusion](#conclusion)

## Introduction

This study aims to predict biological age from cognitive function test scores, addressing gaps in the existing literature. We focus on using cognitive test scores without relying on neuroimaging data, making the approach more accessible and cost-effective. We investigate the potential of using domain-specific cognitive test scores to predict biological age, which could aid in developing targeted interventions for individuals at risk of cognitive decline.

## Data

We used a dataset containing 103,951 participants with various cognitive function test scores. The dataset includes tests that assess memory, processing speed, and executive functions. The study population characteristics are presented in the data folder.

## Methods

### Baseline Model

We first established a baseline model using four machine learning algorithms: Linear Regression, Decision Tree, Random Forest, and XGBoost. We also implemented a Deep Neural Network (DNN) as a baseline model. The data was pre-processed, and cross-validation was performed to ensure generalizability.

### Data Imputation

We used the Multiple Imputation by Chained Equations (MICE) package to handle missing values in the dataset. The imputed datasets were then used to train the models and compare their performance with the baseline models.

### Hyperparameter Tuning

We employed hyperparameter tuning for the Decision Tree, Random Forest, and XGBoost models to optimize their configurations, improving their performance.

## Results

The final performance of the models after hyperparameter tuning is presented in the table below:

| Model           | RMSE Before Tuning (years) | RMSE After Tuning (years) | Percentage Change |
|-----------------|----------------------------|---------------------------|-------------------|
| Decision Tree   | 9.96                       | 7.40                      | -25.70%           |
| Random Forest   | 7.38                       | 7.12                      | -3.52%            |
| XGBoost         | 6.99                       | 6.96                      | -0.43%            |
| DNN Network     | 5.81                       | 5.79                      | -0.34%            |

## Conclusion

Our study successfully demonstrates the potential of using cognitive function test scores to predict biological age. The Deep Neural Network (DNN) model achieved the best performance with the lowest RMSE, indicating its effectiveness in predicting biological age from cognitive test scores. The results provide a foundation for further research in developing targeted interventions for individuals at risk of cognitive decline.
