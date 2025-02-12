import numpy as np
from sklearn.model_selection import KFold, cross_val_score, cross_val_predict
from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
from sklearn.ensemble import RandomForestRegressor
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import make_pipeline
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

# Caricamento del dataset preprocessato
df = pd.read_csv("laptop_price_with_KB.csv")

# Calcolo della correlazione con il target "Price_euros"
target_correlations = df.corr()["Price_euros"].apply(abs).sort_values()

# Selezione delle 20 feature più correlate (inclusa Price_euros)
selected_features = target_correlations[-21:].index.tolist()

# Definizione delle feature e del target
X = df[selected_features].drop("Price_euros", axis=1)
y = df["Price_euros"]

# Creazione della pipeline con scaler e modello
pipeline = make_pipeline(
    StandardScaler(),  # Lo scaler verrà applicato separatamente in ogni fold
    RandomForestRegressor(random_state=42)
)

# Creazione della K-Fold Cross-Validation
kfold = KFold(n_splits=10, shuffle=True, random_state=42)

# Eseguiamo la cross-validation correttamente (senza data leakage)
cv_r2_scores = cross_val_score(pipeline, X, y, cv=kfold, scoring='r2')
cv_mse_scores = -cross_val_score(pipeline, X, y, cv=kfold, scoring='neg_mean_squared_error')
cv_mae_scores = -cross_val_score(pipeline, X, y, cv=kfold, scoring='neg_mean_absolute_error')

# Creiamo le predizioni con cross-validation
y_pred_cv = cross_val_predict(pipeline, X, y, cv=kfold)

# Stampa delle metriche di valutazione
print("\n📊 Valutazione del modello con Cross-Validation:")
print(f"Mean R²: {cv_r2_scores.mean():.4f}")
print(f"Mean MSE: {cv_mse_scores.mean():.2f}")
print(f"Mean MAE: {cv_mae_scores.mean():.2f}")

# Scatter plot tra valori reali e predetti
plt.figure(figsize=(10, 8))
sns.scatterplot(x=y, y=y_pred_cv, color="darkviolet", label="Predictions (Cross-Validation)")
plt.plot([min(y), max(y)], [min(y), max(y)], color="darkgreen", linestyle="--", linewidth=2, label="Perfect Fit")
plt.title("Scatter Plot: True vs Predicted Values (Cross-Validation)")
plt.xlabel("True Values")
plt.ylabel("Predicted Values")
plt.legend()
plt.show()

# Predizione su un NUOVO esempio (mai visto prima)
# Creiamo un nuovo laptop con specifiche diverse dai dati di training
X_new = pd.DataFrame([{
    "Ram": 16,
    "Memory Amount": 512000.0,
    "Intel_CPU": "1",
    "Intel_GPU": "1",
    "Screen Width": 1920,
    "Screen Height": 1080
}], columns=X.columns)  # Assicurarsi che le colonne siano le stesse

# Addestriamo la pipeline su tutto il dataset per predire il nuovo esempio (solo per produzione)
pipeline.fit(X, y)
new_prediction = pipeline.predict(X_new)

print("\n🔮 Predizione per un nuovo laptop (mai visto nel dataset):")
print(f"Predicted Price: {new_prediction[0]:.2f} Euro")
