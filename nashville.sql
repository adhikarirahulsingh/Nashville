-- Checking the database
Select current_database();

-- Checking the dataset
select *
from nashville
limit 10;

-- Checking the data type for each column
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'nashville'
  AND table_schema = 'public'
ORDER BY ordinal_position;

-- Changing the data type for SaleDate
select "SaleDate"
from nashville;

Alter table nashville
alter column "SaleDate" type date
using "SaleDate"::Date;

-- Populating the null values of Property Address
select *
from nashville
where "PropertyAddress" is Null;

SELECT 
    a."UniqueID " AS record_to_update,
    a."ParcelID",
    a."PropertyAddress" AS current_address,
    b."PropertyAddress" AS address_to_fill
FROM nashville a
JOIN nashville b
  ON a."ParcelID" = b."ParcelID"
WHERE a."PropertyAddress" IS NULL
  AND b."PropertyAddress" IS NOT NULL;

UPDATE nashville a
SET "PropertyAddress" = b."PropertyAddress"
FROM nashville b
WHERE a."ParcelID" = b."ParcelID"
  AND a."PropertyAddress" IS NULL
  AND b."PropertyAddress" IS NOT NULL;

-- Spliting PropertyAddress
Select "PropertyAddress"
from nashville
limit 10;

alter table nashville
add column "PropertyAddressStreet" text,
add column "PropertyAddressCity" text;

update nashville
set
	"PropertyAddressStreet" = split_part("PropertyAddress", ',', 1),
	"PropertyAddressCity" = trim(split_part("PropertyAddress", ',', 2));

-- Spliting OwnerAddress
Select "OwnerAddress"
from nashville
limit 10;

alter table nashville
add column "OwnerAddressStreet" text,
add column "OwnerAddressCity" text,
add column "OwnerAddressState" text;

update nashville
set
	"OwnerAddressStreet" = split_part("OwnerAddress", ',', 1),
	"OwnerAddressCity" = trim(split_part("OwnerAddress", ',', 2)),
	"OwnerAddressState" = trim(split_part("OwnerAddress", ',', 3));

-- Updating SoldAsVacant
Select "SoldAsVacant", count("SoldAsVacant")
from nashville
group by "SoldAsVacant"
order by 2;

update nashville
set "SoldAsVacant" = Case
	when "SoldAsVacant" = 'Y' Then 'Yes'
	when "SoldAsVacant" = 'N' Then 'No'
	else "SoldAsVacant"
	end;


-- Remove Duplicates
with Row_Table as (
select 
	row_number() over (
		partition by "ParcelID",
				"PropertyAddress",
				"SalePrice",
				"SaleDate",
				"LegalReference"
				Order by "UniqueID "
	) row_num, *
from nashville
order by "ParcelID")

Delete
from nashville a
using row_table b
where a."UniqueID " = b."UniqueID "
and b.row_num > 1;

-- Droping Unused Columns
Alter table nashville
drop column "PropertyAddress",
drop column "OwnerAddress",
drop column "TaxDistrict";

select *
from nashville;