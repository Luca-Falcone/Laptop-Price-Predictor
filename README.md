# Laptop Price Predictor

**Hybrid AI system combining Prolog Knowledge Base with Random Forest Regression for accurate laptop price estimation**

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![Prolog](https://img.shields.io/badge/Prolog-SWIPL-yellowgreen)

## Overview

A hybrid AI solution that integrates symbolic reasoning (Prolog Knowledge Base) with machine learning (Random Forest Regression) to predict laptop prices based on hardware specifications. Designed to assist both consumers and retailers in making informed purchasing decisions.

## Key Features

- **Hybrid AI Architecture**:
  - Prolog Knowledge Base for logical feature engineering
  - Random Forest Regressor for price prediction
- **Semantic Feature Extraction**:
  - `is_low_cost_warning`: Flags budget laptops (<€400, HDD, ≤4GB RAM)
  - `is_mid_range`: Identifies mid-tier laptops (€400-€1500)
  - `budget_score`: Quality-price ratio score (RAM/CPU/Storage)
- **Enhanced Predictive Performance**:
  - 11.4% improvement in R² score
  - 56% reduction in Mean Absolute Error (MAE)
  


## Technical Stack

### Machine Learning
- **Algorithm**: Random Forest Regressor
- **Validation**: 10-Fold Cross Validation
- **Libraries**: scikit-learn, pandas, NumPy

### Knowledge Engineering
- **Language**: Prolog
- **Integration**: pyswip (Python-Prolog bridge)
- **Rules Engine**: Feature derivation through logical inference

### Data Processing
- **Dataset**: [Kaggle Laptop Prices](https://www.kaggle.com/datasets/mrsimple07/laptoppriceprediction) (preprocessed)
- **Techniques**:
  - One-Hot Encoding
  - Feature Scaling
  - Anomaly Detection

## Getting Started

### Prerequisites
- Python 3.8+
- SWI-Prolog
- [Poetry](https://python-poetry.org/) (recommended)

### Installation
```bash
git clone https://github.com/Luca-Falcone/Laptop-Price-Predictor
cd Laptop-Price-Predictor

# Install dependencies
poetry install

# Activate virtual environment
poetry shell
