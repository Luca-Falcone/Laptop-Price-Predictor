from pyswip import Prolog
import pandas as pd

print("🔵 Avvio del codice")

# Inizializza Prolog
prolog = Prolog()
try:
    prolog.consult("main.pl")  # Carica la KB
    print("✅ Prolog KB caricata correttamente")
except Exception as e:
    print(f"❌ Errore nel caricamento di Prolog: {e}")

# Funzione per estrarre le feature booleane (binario 0/1) dalla KB
def get_prolog_feature(query):
    try:
        results = list(prolog.query(query))
        unique_results = set(r["ID"] for r in results)  # Rimuove duplicati
        print(f"🔍 Query: {query} → {len(unique_results)} risultati unici")
        return {ID: 1 for ID in unique_results}
    except Exception as e:
        print(f"❌ Errore nella query {query}: {e}")
        return {}

# Funzione per estrarre feature numeriche dalla KB
def get_prolog_numeric_feature(query, value_name):
    try:
        results = {int(r["ID"]): r[value_name] for r in prolog.query(query)}
        print(f"🔍 Query numerica: {query} → {len(results)} risultati totali")
        return results
    except Exception as e:
        print(f"❌ Errore nella query {query}: {e}")
        return {}

# Estrarre le feature booleane dalla KB
features = {
    "is_low_cost_warning": get_prolog_feature("is_low_cost_warning(ID)."),
    "is_mid_range": get_prolog_feature("is_mid_range(ID).")
}

# Carica il dataset pulito
try:
    df = pd.read_csv("laptop_price_cleaned.csv")
    print("✅ Dataset pulito caricato")
except Exception as e:
    print(f"❌ Errore nel caricamento del dataset: {e}")


df.index = df.index + 1  # Per allinearlo con Prolog

# Estrarre feature numeriche dalla KB
budget_scores = get_prolog_numeric_feature("budget_score(ID, Score).", "Score")

# Funzione per aggiungere feature al dataframe
def add_features_to_dataframe(df, features_dict):
    for feature_name, feature_data in features_dict.items():
        print(f"📌 Aggiungendo feature: {feature_name} ({len(feature_data)} valori)")
        df[feature_name] = df.index.map(lambda x: feature_data.get(x, 0))
    return df

# Aggiunge le feature booleane
df = add_features_to_dataframe(df, features)

# Aggiunge feature numeriche e tronca i valori
df["budget_score"] = df.index.map(lambda x: round(budget_scores.get(x, None), 3) if x in budget_scores else None)

# Controlla il dataset prima di salvarlo
print("✅ Dataset finale con KB Feature:")
print(df.head())

# Salva il dataset aggiornato
output_file = "laptop_price_with_KB2.csv"
df.to_csv(output_file, index=False)
print(f"🎉 Dataset aggiornato con feature KB salvato con successo! ({output_file})")
