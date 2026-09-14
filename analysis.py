"""
Мир Косметика - Savdo dinamikasi tahlili (2025-2026)
Google Colab / Python: pandas + matplotlib
"""
import pandas as pd
import matplotlib.pyplot as plt

# ---------- 1. Ma'lumotni yuklash ----------
df = pd.read_csv('data.csv', dtype={'sana': str})

# ---------- 2. Yil/oy ajratish va Jami ustuni ----------
df['Jami'] = df['Shahar'] + df['Bozor'] + df['Rayon']

# ---------- 3. Yillik jamlanma ----------
yillik_jami = df.groupby('yil')['Jami'].sum()
print("=== Yillik jami ===")
print(yillik_jami)

# ---------- 4. Yillik o'sish foizi ----------
osish_foizi = (yillik_jami['2026'] - yillik_jami['2025']) / yillik_jami['2025'] * 100
print(f"\n2026-yil 2025-yilga nisbatan {osish_foizi:.1f}% ga o'zgardi")

# ---------- 5. Kanal darajasidagi jamlanma ----------
kategoriyalar_jami = df.groupby('yil')[['Shahar', 'Bozor', 'Rayon']].sum()
print("\n=== Kanal bo'yicha yillik jami ===")
print(kategoriyalar_jami)

kategoriya_osish = (kategoriyalar_jami.loc['2026'] - kategoriyalar_jami.loc['2025']) / kategoriyalar_jami.loc['2025'] * 100
print("\n=== Kanal bo'yicha o'sish foizi ===")
print(kategoriya_osish.round(1))

# ---------- 6. Grafik 1: Oylik dinamika ----------
plt.figure(figsize=(10, 5))
for yil, group in df.groupby('yil'):
    plt.plot(group['oy'], group['Jami'], marker='o', label=str(yil))
plt.xlabel('Oy')
plt.ylabel('Jami savdo')
plt.title('Oylik jami savdo: 2025 vs 2026')
plt.legend()
plt.grid(True, alpha=0.3)
plt.savefig('chart_monthly_trend.png', dpi=150, bbox_inches='tight')
plt.show()

# ---------- 7. Grafik 2: Kanallar bo'yicha ustunli ----------
plt.figure(figsize=(8, 5))
kategoriyalar_jami.T.plot(kind='bar')
plt.ylabel('Jami savdo')
plt.title("Kanal bo'yicha: 2025 vs 2026")
plt.xticks(rotation=0)
plt.savefig('chart_categories.png', dpi=150, bbox_inches='tight')
plt.show()

# ---------- 8. Grafik 3: Kanallar ulushi (pie) ----------
umumiy_kategoriya = df[['Shahar', 'Bozor', 'Rayon']].sum()
plt.figure(figsize=(6, 6))
plt.pie(umumiy_kategoriya, labels=umumiy_kategoriya.index, autopct='%1.1f%%', startangle=90)
plt.title("Kanallar ulushi (2025-2026 jami)")
plt.savefig('chart_share_pie.png', dpi=150, bbox_inches='tight')
plt.show()

# ---------- 9. Excel eksport ----------
with pd.ExcelWriter('mir_kosmetika_tahlil.xlsx') as writer:
    df.to_excel(writer, sheet_name='Xom malumot', index=False)
    kategoriyalar_jami.to_excel(writer, sheet_name='Yillik jami')
    kategoriya_osish.to_excel(writer, sheet_name="O'sish foizi")

print("\nTahlil yakunlandi. Grafiklar va Excel fayli saqlandi.")
