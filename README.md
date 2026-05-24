# 📊 V4 GDP per Capita Analysis Project

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![SQL](https://img.shields.io/badge/SQL-CC2927?style=flat-square&logo=microsoft-sql-server&logoColor=white)](https://en.wikipedia.org/wiki/SQL)
[![Data Analysis](https://img.shields.io/badge/Data%20Analysis-4CAF50?style=flat-square)](#)
[![Dataset Period](https://img.shields.io/badge/Dataset-2000--2020-blue?style=flat-square)](#)

---

## 📋 Overview

This project provides a comprehensive **GDP per capita comparison** between pairs of **V4 countries** (Poland, Czech Republic, Slovakia, Hungary) from **2000 to 2020**.

### 🎯 Key Features

- ✅ **Year-over-year comparison** of GDP per capita between country pairs
- ✅ **Absolute & percentage change** calculations
- ✅ **Ratio Index** for relative comparisons
- ✅ **IRC (Index of Relative Convergence)** for trend analysis
- ✅ **Growth rate analysis** for individual countries
- ✅ **Duplicate pair removal** for cleaner results

---

## 📁 Project Structure

```
V4_GDPperCapita_project/
├── V4_GDPperCapita_project.sql  # Main SQL queries and analysis
├── README.md                     # This file
└── [data files]                  # Source data
```

---

## 🔍 What the Analysis Does

### 1. **GDP Per Capita Calculation**
Extracts GDP per capita for V4 countries:
```sql
GDP per Capita = GDP / Population
```

### 2. **Pairwise Comparison**
Compares all country pairs:
- 🇵🇱 Poland ↔ 🇨🇿 Czech Republic
- 🇵🇱 Poland ↔ 🇸🇰 Slovakia
- 🇵🇱 Poland ↔ 🇭🇺 Hungary
- 🇨🇿 Czech Republic ↔ 🇸🇰 Slovakia
- 🇨🇿 Czech Republic ↔ 🇭🇺 Hungary
- 🇸🇰 Slovakia ↔ 🇭🇺 Hungary

### 3. **Difference Analysis**
Calculates:
- **Difference**: GDP per capita gap between two countries
- **Absolute Change**: How the gap changed year-over-year
- **Percentage Change**: Relative growth of the gap

### 4. **Convergence Metrics**
Includes advanced analysis:

| Metric | Description |Example|
|--------|-------------|-------------|
| **Ratio Index** | Proportion between GDP per capita values (A/B) | 1.00 = equal, >1 = country A has greater GDP per capita|
| **IRC** | Index of Relative Convergence (0-1 scale, lower = more convergent) | 0 = equal , 1 = max divergence |
| **Growth Rate** | Annual GDP per capita growth for each country | pozitive value = growth , negative value = decrease |

---

## 🚀 Query Evolution

### Initial Approach ❌
Individual queries for each country pair (repetitive, hard to maintain)

### Optimized Approach ✅
Single unified query using:
- `WITH` (Common Table Expressions)
- `LAG()` window function for year-over-year comparison
- `PARTITION BY` for proper grouping
- `UNION ALL` consolidation

### Final Improved Query ✨
Optimized with:
- Eliminated duplicate pairs (CZ,PL) and (PL,CZ)
- Added Ratio Index
- Added IRC metrics
- Added individual country growth rates
- Clean, maintainable code structure

---

## 📊 Output Columns

| Column | Description |
|--------|-------------|
| `year` | Analysis year (2001-2020) |
| `country_a` | First country in comparison |
| `country_b` | Second country in comparison |
| `gdp_pc_a` | GDP per capita for country A |
| `gdp_pc_b` | GDP per capita for country B |
| `gdp_pc_growth_a` | Annual growth rate for country A (%) |
| `gdp_pc_growth_b` | Annual growth rate for country B (%) |
| `difference` | GDP per capita gap (A - B) |
| `previous_year` | Gap from previous year |
| `clean_diff` | Change in gap (absolute) |
| `percent_diff` | Change in gap (%) |
| `ratio_index` | Ratio between GDP per capita (A/B) |
| `irc` | Convergence index (0-1, lower = more convergent) |

---

## 🛠️ Technology Stack

- **Database**: PostgreSQL
- **Language**: SQL (with Window Functions, CTEs)
- **Analysis Period**: 2000-2020 (21 years)
- **Countries**: V4 Group (Central Europe)

---

## 📈 Key Insights

This analysis helps answer questions like:
- How has the economic gap between V4 countries evolved?
- Are countries converging or diverging economically?
- Which countries are growing faster?
- What's the relative economic position of each country?

---

## 📝 Notes

- Data starts from **2001** (year > 2000)
- All monetary values rounded to **2 decimal places**
- IRC values closer to **0** indicate stronger convergence
- Ratio Index > 1 means country_a has higher GDP per capita

---

## 👨‍💻 Author

**Jakub8b**

---

## 📄 License

---

<details>
<summary><b>📚 Additional Resources</b></summary>

- [PostgreSQL Window Functions](https://www.postgresql.org/docs/current/functions-window.html)
- [V4 Countries Information](https://en.wikipedia.org/wiki/Visegrád_Group)
- [GDP per Capita Explained](https://en.wikipedia.org/wiki/Gross_domestic_product#GDP_per_capita)

</details>

---

**Last Updated**: 2026-05-24 | **Dataset Period**: 2000-2020
