-- Function untuk memanggil seluruh isi table dari SuperStore
SELECT * FROM SuperStore;

-- Soal Data Analysis untuk SQL Server :
--1. Top Customers by Total Spending:

SELECT
    [Customer ID],
    [Customer Name],
    (Sales * Quantity) AS [Total Spending]
FROM SuperStore
ORDER BY [Total Spending] DESC;

--2. Tulis query SQL untuk mengidentifikasi 10 pelanggan teratas berdasarkan total belanja mereka.
SELECT TOP 10
    [Customer ID],
    [Customer Name],
    (Sales * Quantity) AS [Total Spending]
FROM SuperStore
ORDER BY [Total Spending] DESC;

--3. Sertakan kolom untuk menampilkan total belanja masing-masing pelanggan.
SELECT
    [Customer ID],
    [Customer Name],
    (Sales * Quantity) AS [Total Spending]
FROM SuperStore

--Analisis Diskon per Kategori Produk:
--4. Buat query SQL yang menghitung rata-rata diskon untuk setiap kategori produk.
SELECT
    Category,
    AVG(Discount * 100) AS [Rata-rata Discount]
FROM SuperStore
GROUP BY Category;

--5. Filter hasil untuk menampilkan hanya kategori produk dengan rata-rata diskon di atas 5%.
SELECT
    Category,
    AVG(Discount * 100) AS [Rata-rata Discount]
FROM SuperStore
GROUP BY Category
HAVING AVG(Discount * 100) > 5;

-- Pertumbuhan Penjualan Tahunan:
--6. Tulis query SQL untuk menghitung pertumbuhan penjualan tahunan.
SELECT
  YEAR([Ship Date]) AS Year,
  SUM(Sales * Quantity) AS [Total Sales],
  LAG(SUM(Sales * Quantity)) OVER (ORDER BY YEAR([Ship Date])) AS Previous_Year_Sales,
  ((SUM(Sales * Quantity) - LAG(SUM(Sales * Quantity)) OVER (ORDER BY YEAR([Ship Date]))) / LAG(SUM(Sales * Quantity)) OVER (ORDER BY SUM(Sales * Quantity))) * 100 AS Sales_Growth_Percentage
FROM SuperStore
GROUP BY YEAR([Ship Date])
ORDER BY Year;



--7. Hitung persentase pertumbuhan penjualan dari tahun ke tahun.
SELECT
  YEAR([Ship Date]) AS Year,
  SUM(Sales * Quantity) AS [Total Sales],
  LAG(SUM(Sales * Quantity)) OVER (ORDER BY YEAR([Ship Date])) AS Previous_Year_Sales,
  ((SUM(Sales * Quantity) - LAG(SUM(Sales * Quantity)) OVER (ORDER BY YEAR([Ship Date]))) / LAG(SUM(Sales * Quantity)) OVER (ORDER BY SUM(Sales * Quantity))) * 100 AS Sales_Growth_Percentage
FROM SuperStore
GROUP BY YEAR([Ship Date])
ORDER BY Year;
-- Pengelompokan Pelanggan berdasarkan Kategori Produk:
--8. Buat query SQL untuk mengelompokkan pelanggan berdasarkan kategori produk yang paling sering mereka beli.
SELECT
    Category,
    COUNT(*) AS [Total Produk Dibeli]
FROM SuperStore
GROUP BY Category
ORDER BY [Total Produk Dibeli] DESC;

--9. Identifikasi kombinasi produk yang paling populer di antara pelanggan.
SELECT TOP 1
    [Product Name],
    COUNT(*) AS [Total Produk Dibeli]
FROM SuperStore
GROUP BY [Product Name]
ORDER BY [Total Produk Dibeli] DESC;

-- Analisis Hubungan antara Diskon dan Profit:
--10. Buat query SQL untuk menghitung korelasi antara besaran diskon yang diberikan dan profit.
SELECT
  SUM((Discount - AvgDiscount) * (Profit - AvgProfit)) / (COUNT(*) * STDEVP(Discount) * STDEVP(Profit)) AS Correlation
FROM (
        SELECT
            Discount,
            Profit,
            AVG(Discount) OVER () AS AvgDiscount,
            AVG(Profit) OVER () AS AvgProfit
  FROM SuperStore
) AS Subquery;

--11. Evaluasi apakah ada korelasi yang signifikan antara diskon dan profit.
-- Korelasi negatif menunjukkan bahwa ketika besaran diskon meningkat, profit cenderung menurun.

-- Pengelompokan Waktu dengan SQL:
--12. Tulis query SQL untuk mengelompokkan data penjualan berdasarkan kuartal dan tahun.
-- Fungsi untuk membuat quartal di sql server
SELECT
    DATEPART(QUARTER, [Order Date])
FROM SuperStore

SELECT
    YEAR([Order Date]) AS [Tahun],
    DATEPART(QUARTER, [Order Date]) AS [Kuartal],
    SUM(Sales * Quantity) AS [Total Penjualan]
FROM SuperStore
GROUP BY 
    YEAR([Order Date]),
    DATEPART(QUARTER, [Order Date])
ORDER BY 
    YEAR([Order Date]) ASC,
    DATEPART(QUARTER, [Order Date]) ASC;


--13. Analisis apakah terdapat perbedaan pola penjualan antar kuartal.
--Terlihat bahwa setiap penjualan mengalami pola kenaikan di setiap quartalnya.

-- Produk dengan Harga Jual Tinggi dan Rendah:
--14. Buat query SQL yang menunjukkan produk dengan harga jual tertinggi dan terendah.
-- produk dengan harga jual tertinggi
SELECT TOP 1
    [Product ID],
    [Product Name],
    Sales 
FROM SuperStore
ORDER BY Sales DESC;

-- produk dengan harga jual terendah
SELECT TOP 1
    [Product ID],
    [Product Name],
    Sales 
FROM SuperStore
ORDER BY Sales ASC;

-- Sertakan informasi tentang harga jual masing-masing produk.
-- Tertinggi : TEC-MA-10002412	Cisco TelePresence System EX90 Videoconferencing Unit	22638.48
-- Terendah  : OFF-AP-10002906	Hoover Replacement Belt for Commercial Guardsman Heavy-Duty Upright Vacuum	0.44

-- Pelanggan dengan Jumlah Produk Terbanyak:
--15. Tulis query SQL untuk mengidentifikasi pelanggan dengan jumlah produk terbanyak dalam satu transaksi.
SELECT
    [Order ID],
    [Customer ID],
    [Customer Name],
    SUM(Quantity) AS [Total Produk]
FROM SuperStore
GROUP BY 
    [Order ID],
    [Customer ID],
    [Customer Name]
ORDER BY [Total Produk] DESC;


--16. Hitung rata-rata jumlah produk per transaksi untuk pemahaman lebih lanjut.
SELECT
    [Order ID],
    [Customer ID],
    [Customer Name],
    AVG(Quantity) AS [Total Produk]
FROM SuperStore
GROUP BY 
    [Order ID],
    [Customer ID],
    [Customer Name]
ORDER BY [Total Produk] DESC;

-- Analisis Region dengan Penjualan Terbaik:
--17. Buat query SQL untuk menentukan region dengan penjualan tertinggi.
SELECT
    Region,
    SUM(Sales * Quantity) AS [Total Penjualan]
FROM SuperStore
GROUP BY Region
ORDER BY [Total Penjualan] DESC;

--18. Analisis faktor-faktor apa yang mungkin berkontribusi terhadap kesuksesan penjualan di region tersebut.
--A. Faktor tingkat pendapatan
--B. Faktor tingkat penjualan properti di suatu region
--C. Faktor tinggi atau rendahnya lapangan pekerjaan.
--D. Faktor pembukaan properti baru di suatu region

