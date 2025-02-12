import pandas as pd

# Caricamento e preprocessamento dei dati
df = pd.read_csv("laptop_price.csv", encoding="latin-1")

# Rimozione della colonna "Product" che non è utile
df = df.drop("Product", axis=1)

# Encoding delle variabili categoriche
df = df.join(pd.get_dummies(df.Company).astype(int))
df = df.drop("Company", axis=1)
df = df.join(pd.get_dummies(df.TypeName).astype(int))
df = df.drop("TypeName", axis=1)

# Estrazione delle risoluzioni dello schermo
df["ScreenResolution"] = df.ScreenResolution.str.split(" ").apply(lambda x: x[-1])
df["Screen Width"] = df.ScreenResolution.str.split("x").apply(lambda x: x[0])
df["Screen Height"] = df.ScreenResolution.str.split("x").apply(lambda x: x[1])
df = df.drop("ScreenResolution", axis=1)

# Estrazione delle informazioni sulla CPU
df["CPU Brand"] = df.Cpu.str.split(" ").apply(lambda x: x[0])
df["CPU Frequency"] = df.Cpu.str.split(" ").apply(lambda x: x[-1])
df = df.drop("Cpu", axis=1)
df["CPU Frequency"] = df["CPU Frequency"].str[:-3]  # Rimozione dei GHz
df["CPU Frequency"] = df["CPU Frequency"].astype("float")

# Conversione di RAM e dimensioni dello schermo in formato numerico
df["Ram"] = df["Ram"].str[:-2].astype("int")
df["Screen Width"] = df["Screen Width"].astype("int")
df["Screen Height"] = df["Screen Height"].astype("int")

# Estrazione delle informazioni sulla memoria
df["Memory Amount"] = df.Memory.str.split(" ").apply(lambda x: x[0])
df["Memory Type"] = df.Memory.str.split(" ").apply(lambda x: x[1])

def turn_memory_into_MB(value):
    if "GB" in value:
        return float(value[:value.find("GB")]) * 1000
    elif "TB" in value:
        return float(value[:value.find("TB")]) * 1000000

df["Memory Amount"] = df["Memory Amount"].apply(turn_memory_into_MB)

# Encoding delle variabili sulla memoria
memory_categories = pd.get_dummies(df["Memory Type"], prefix="Memory")
df = df.join(memory_categories.astype(int))
df = df.drop("Memory Type", axis=1)
df = df.drop("Memory", axis=1)

# Conversione del peso in formato numerico
df["Weight"] = df["Weight"].str[:-2].astype("float")

# Estrazione delle informazioni sulla GPU
df["GPU Brand"] = df.Gpu.str.split(" ").apply(lambda x: x[0])
df = df.drop("Gpu", axis=1)

# Encoding del sistema operativo
df = df.join(pd.get_dummies(df.OpSys).astype(int))
df = df.drop("OpSys", axis=1)

# Encoding della CPU e della GPU
cpu_categories = pd.get_dummies(df["CPU Brand"])
cpu_categories.columns = [col + "_CPU" for col in cpu_categories]
df = df.join(cpu_categories.astype(int))
df = df.drop("CPU Brand", axis=1)

gpu_categories = pd.get_dummies(df["GPU Brand"])
gpu_categories.columns = [col + "_GPU" for col in gpu_categories]
df = df.join(gpu_categories.astype(int))
df = df.drop("GPU Brand", axis=1)

# Salvataggio del dataset preprocessato
df.to_csv("laptop_price_prova.csv", index=False)
print("✅ Dataset preprocessato e salvato come 'laptop_price_cleaned.csv'")
