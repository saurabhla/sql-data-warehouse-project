# SQL Data Warehouse & Analytics Project  

## 📘 Overview  
This project demonstrates the **design and implementation of a modern SQL-based Data Warehouse** and Analytics solution.  
It integrates **ERP, CRM, and Excel data sources** into a centralized **data warehouse** through an **ETL pipeline**, enabling clean, structured, and business-ready data for **reporting and analytics**.

---

## 🚀 Epics & Tasks  

### **Epic 1: Analyze Requirements**  
- Collaborated with stakeholders to gather data and reporting needs.  
- Planned and implemented a **modern Data Warehouse** using **SQL Server**.

### **Epic 2: Design Data Architecture**  
- Evaluated four modern architectures:  
  - **Data Warehouse**, **Data Lake**, **Data Lakehouse**, and **Data Mesh**.  
- Selected **Medallion Architecture** for simplicity and scalability:  
  - **Bronze Layer** → Raw source data (traceability & debugging).  
  - **Silver Layer** → Cleaned & standardized data (ready for analytics).  
  - **Gold Layer** → Business-ready views for reporting & BI.

---

## 🧱 Architecture Layers  

| Layer | Description | Target Users |
|-------|--------------|--------------|
| **Bronze** | Raw, unprocessed data directly from source. No transformation. | Data Engineers |
| **Silver** | Cleaned, standardized, and enriched data. | Data Engineers, Analysts |
| **Gold** | Aggregated, business-ready views for dashboards & analytics. | Analysts, Business Users |

---

## 🧩 Design Highlights  
- **ETL Pipelines**: Load, clean, and transform data from ERP, CRM, and Excel.  
- **Data Modeling**: Implemented **Star Schema** in Gold Layer.  
- **Naming Conventions**:  
  - Use lowercase & English words.  
  - Bronze/Silver tables: `src_<system>_<table>`  
  - Gold layer: business-oriented names like `fact_sales`, `agg_customers`.  
- **Tools Used**: SQL Server, Azure Data Factory, Databricks, Power BI, Git.  

---
## 📂 Repository Structure  
├── /etl_scripts
├── /sql
│ ├── bronze
│ ├── silver
│ └── gold
├── /architecture_diagrams
├── /docs
└── README.md
---

## 📊 Outcome  
A complete **SQL Data Warehouse and Analytics solution** that supports data ingestion, transformation, and visualization — enabling data-driven decision-making across the organization.

