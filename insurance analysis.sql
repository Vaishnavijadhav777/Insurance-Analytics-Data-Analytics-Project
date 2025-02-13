
SELECT COUNT(*) AS TotalPolicies
FROM Policies;

SELECT COUNT(DISTINCT CustomerID) AS TotalCustomers
FROM Policies;


SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END AS AgeBucket,
    COUNT(*) AS PolicyCount
FROM Customers c
JOIN Policies p ON c.CustomerID = p.CustomerID
GROUP BY AgeBucket;


SELECT Gender, COUNT(*) AS PolicyCount
FROM Customers c
JOIN Policies p ON c.CustomerID = p.CustomerID
GROUP BY Gender;

SELECT PolicyType, COUNT(*) AS PolicyCount
FROM Policies
GROUP BY PolicyType;


SELECT COUNT(*) AS ExpiringPolicies
FROM Policies
WHERE YEAR(ExpirationDate) = YEAR(CURDATE());


SELECT 
    YEAR(PaymentDate) AS Year,
    ((SUM(CASE WHEN YEAR(PaymentDate) = YEAR(CURDATE()) THEN PremiumAmount ELSE 0 END) - 
      SUM(CASE WHEN YEAR(PaymentDate) = YEAR(CURDATE()) - 1 THEN PremiumAmount ELSE 0 END)) /
      SUM(CASE WHEN YEAR(PaymentDate) = YEAR(CURDATE()) - 1 THEN PremiumAmount ELSE 0 END)) * 100 AS GrowthRate
FROM Policies
GROUP BY Year;


SELECT ClaimStatus, COUNT(*) AS PolicyCount
FROM Claims
GROUP BY ClaimStatus;

SELECT PaymentStatus, COUNT(*) AS PolicyCount
FROM Payments
GROUP BY PaymentStatus;


SELECT SUM(ClaimAmount) AS TotalClaimAmount
FROM Claims;


SELECT AccountExecID, COUNT(*) AS InvoiceCount
FROM Invoices
GROUP BY AccountExecID;


SELECT YEAR(MeetingDate) AS Year, COUNT(*) AS MeetingCount
FROM Meetings
GROUP BY YEAR(MeetingDate);


SELECT 
    SalesType, 
    COUNT(*) AS TargetAchieved,
    SUM(CASE WHEN Status = 'New' THEN 1 ELSE 0 END) AS NewTargets
FROM Sales
GROUP BY SalesType;


SELECT Stage, SUM(Revenue) AS TotalRevenue
FROM Opportunities
GROUP BY Stage;

SELECT AccountExecID, COUNT(*) AS MeetingCount
FROM Meetings
GROUP BY AccountExecID;

SELECT OpportunityID, OpportunityName, Revenue
FROM Opportunities
WHERE Status = 'Open'
ORDER BY Revenue DESC
LIMIT 5;
