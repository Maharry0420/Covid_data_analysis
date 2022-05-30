-- Cleaning data in SQL queries --

Select *
From Covid_Portfolio.dbo.NashvilleHousing

--Changing the SaleDate to make it cleaner --
Select NewSaleDate, CONVERT(Date, SaleDate)
From Covid_Portfolio.dbo.NashvilleHousing

Update Covid_Portfolio.dbo.NashvilleHousing
Set SaleDate = Convert(Date, SaleDate) -- didn't work for me --

ALTER TABLE NashvilleHousing
Add NewSaleDate Date;

Update NashvilleHousing
Set NewSaleDate = Convert(date,SaleDate);

--Populate property address data--

Select *
From Covid_Portfolio.dbo.NashvilleHousing
--Where PropertyAddress is NULL
Order by ParcelID

Select Parcel.ParcelID, Parcel.PropertyAddress, Addy.ParcelID, Addy.PropertyAddress, ISNULL(Parcel.PropertyAddress, Addy.PropertyAddress)
From Covid_Portfolio.dbo.NashvilleHousing Parcel
Join Covid_Portfolio.dbo.NashvilleHousing Addy ON
	 Parcel.ParcelID = Addy.ParcelID AND
	 Parcel.[UniqueID ] <> Addy.[UniqueID ]
Where Parcel.PropertyAddress is NULL 

Update Parcel
SET PropertyAddress = ISNULL(Parcel.PropertyAddress, Addy.PropertyAddress)
From Covid_Portfolio.dbo.NashvilleHousing Parcel
Join Covid_Portfolio.dbo.NashvilleHousing Addy ON
	 Parcel.ParcelID = Addy.ParcelID AND
	 Parcel.[UniqueID ] <> Addy.[UniqueID ]
Where Parcel.PropertyAddress is NULL 

-- Breaking the address into 2 different columns Property Address--

Select PropertyAddress
From Covid_Portfolio.dbo.NashvilleHousing

Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as City
From Covid_Portfolio.dbo.NashvilleHousing

ALTER TABLE Covid_Portfolio.dbo.NashvilleHousing
Add PropertySplitAddress NVarchar(255);

Update Covid_Portfolio.dbo.NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1);

ALTER TABLE Covid_Portfolio.dbo.NashvilleHousing
Add PropertySplitCity NVarchar(255);

Update Covid_Portfolio.dbo.NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress));

Select *
From Covid_Portfolio.dbo.NashvilleHousing

-- Breaking the address into 3 different columns Owner Address--

Select OwnerAddress
From Covid_Portfolio.dbo.NashvilleHousing

Select 
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
From Covid_Portfolio.dbo.NashvilleHousing

ALTER TABLE Covid_Portfolio.dbo.NashvilleHousing
Add OwnerSplitAddress NVarchar(255);

Update Covid_Portfolio.dbo.NashvilleHousing
Set OwnerSplitAddress = (PARSENAME(REPLACE(OwnerAddress,',','.'),3));

ALTER TABLE Covid_Portfolio.dbo.NashvilleHousing
Add OwnerSplitCity NVarchar(255);

Update Covid_Portfolio.dbo.NashvilleHousing
Set OwnerSplitCity = (PARSENAME(REPLACE(OwnerAddress,',','.'),2));

ALTER TABLE Covid_Portfolio.dbo.NashvilleHousing
Add OwnerSplitState NVarchar(255);

Update Covid_Portfolio.dbo.NashvilleHousing
Set OwnerSplitState = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1);

Select *
From Covid_Portfolio.dbo.NashvilleHousing

-- Change the Y and N in SoldAsVacant to Yes and No --

Select SoldAsVacant
From Covid_Portfolio.dbo.NashvilleHousing
Where SoldAsVacant NOT in ('Yes','No')

Select SoldAsVacant,
	CASE When SoldAsVacant = 'Y' then 'Yes'
		 When SoldAsVacant = 'N' then 'No'
		 Else SoldAsVacant
		 END
From Covid_Portfolio.dbo.NashvilleHousing


Update Covid_Portfolio.dbo.NashvilleHousing
Set SoldAsVacant =
	CASE When SoldAsVacant = 'Y' then 'Yes'
		 When SoldAsVacant = 'N' then 'No'
		 Else SoldAsVacant
		 END

-- Remove duplicates --
With Row_Num_CTE as(
Select *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 SalePrice,
				 LegalReference
				 Order By UniqueID) Row_num

From Covid_Portfolio.dbo.NashvilleHousing)
DELETE 
From Row_Num_CTE
Where Row_num > 1


With Row_Num_CTE as(
Select *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 SalePrice,
				 LegalReference
				 Order By UniqueID) Row_num

From Covid_Portfolio.dbo.NashvilleHousing)
SELECT *
From Row_Num_CTE
Where Row_num > 1
Order by ParcelID

-- Delete unused columns --

Select * 
From Covid_Portfolio.dbo.NashvilleHousing

Alter Table Covid_Portfolio.dbo.NashvilleHousing
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict, SaleDate
