# Nashville Housing Data Cleaning

This repository contains SQL scripts to **clean, standardize, and prepare the Nashville housing dataset** for analysis. The dataset includes property sales information such as parcel identifiers, property and owner addresses, sale dates, sale prices, legal references, and property characteristics like land and building values.

The SQL scripts demonstrate practical data cleaning techniques in PostgreSQL, making the dataset consistent, complete, and ready for analysis.

---

## Dataset Overview

The Nashville housing dataset includes columns such as:

* **UniqueID** – unique identifier for each record
* **ParcelID** – parcel identifier
* **PropertyAddress** – full property address
* **OwnerAddress** – full owner address
* **SaleDate** – date of the sale
* **SalePrice** – sale price of the property
* **SoldAsVacant** – whether the property was sold as vacant
* **LegalReference** – legal sale reference
* Additional columns include land value, building value, total value, year built, and number of bedrooms/baths

---

## Data Cleaning Steps

1. **Inspect the database and dataset**

   * Check the current database
   * Preview sample rows
   * Review data types for all columns
     <img width="439" height="817" alt="image" src="https://github.com/user-attachments/assets/76ab0f1d-ede7-4169-8c03-e3dee9eaf7ef" />


2. **Standardize `SaleDate`**

   * Convert the `SaleDate` column to `DATE` type

3. **Populate missing `PropertyAddress` values**

   * Identify rows with `NULL` property addresses
   * Fill missing values by joining on `ParcelID`

4. **Split property and owner addresses**

   * Separate `PropertyAddress` into `Street` and `City` columns
   * Separate `OwnerAddress` into `Street`, `City`, and `State` columns using `split_part()` and `trim()`

5. **Standardize `SoldAsVacant`**

   * Convert `'Y'` → `'Yes'` and `'N'` → `'No'`

6. **Remove duplicate rows**

   * Identify duplicates based on `ParcelID`, `PropertyAddress`, `SalePrice`, `SaleDate`, and `LegalReference`
   * Use `ROW_NUMBER()` and CTEs to delete duplicates while keeping the first occurrence

7. **Drop unused columns**

   * Remove original `PropertyAddress`, `OwnerAddress`, and `TaxDistrict` columns after splitting

---

## SQL Techniques Used

* **Window functions**: `ROW_NUMBER()` for identifying duplicates
* **String functions**: `split_part()` and `trim()` for parsing addresses
* **CASE statements**: Standardizing categorical data
* **CTEs (Common Table Expressions)**: For safely deleting duplicates
* **ALTER TABLE**: Adding, dropping, and modifying columns
* **JOINs**: Updating missing data from existing rows

---


## Result

After running the scripts:

* Missing property addresses are populated
* Property and owner addresses are split into street, city, and state columns
* `SoldAsVacant` values are standardized to `'Yes'` / `'No'`
* Duplicate rows are removed
* Unused columns are dropped
* The dataset is clean, consistent, and analysis-ready


