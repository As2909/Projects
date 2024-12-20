## Nashville Housing Data Cleaning Project
#### Description

This SQL script performs data cleaning operations on the Nashville Housing dataset. The dataset contains information about housing properties in Nashville, including sale dates, property addresses, and owner addresses. The script standardizes the date format, populates missing property addresses, breaks out addresses into individual columns (address, city, state), converts 'Y' and 'N' values to 'Yes' and 'No' in the 'SoldAsVacant' field, removes duplicate records, and deletes unused columns.z

You can see the raw data [here.](https://github.com/As2909/Projects/blob/main/SQL%20-%20Data%20Cleaning/Files/Nashville%20Housing%20Data%20for%20Data%20Cleaning%201.csv)

![alt text](https://github.com/As2909/Projects/blob/main/SQL%20-%20Data%20Cleaning/Files/Raw%20Data.png)

#### Steps:
- 1.Standardize Date Format: Converts the SaleDate column to a standard date format.

- 2.Populate Property Address Data: Populates missing property addresses by matching ParcelID values and using non-null addresses from other records.

- 3.Break Out Address into Individual Columns: Splits the PropertyAddress column into separate Address, City, and State columns.

- 4.Convert 'Y' and 'N' to 'Yes' and 'No': Converts 'Y' and 'N' values in the SoldAsVacant field to 'Yes' and 'No'.

- 5.Remove Duplicates: Removes duplicate records based on ParcelID, PropertyAddress, SalePrice, SaleDate, and LegalReference.

- 6.Delete Unused Columns: Deletes the OwnerAddress, TaxDistrict, PropertyAddress, and SaleDate columns.

You can see all SQL queries [HERE.](https://github.com/As2909/Projects/blob/main/SQL%20-%20Data%20Cleaning/Files/Data%20Cleaning.sql)

#### Final data :
![alt text](https://github.com/As2909/Projects/blob/main/SQL%20-%20Data%20Cleaning/Files/Final_table.png)
