-- Get call details from Cisco Call Database Records for all calls to a certain extension within a date range
-- Cisco Table inside the CDR database is called dbo.calldetails in this case.
-- Additionally, there is a custom table called dbo.deviceUserTable with columns 'destDeviceName', 'userName', and 'extension'
-- destDeviceName is the Cisco phone identifier, usually starting with 'SEP00' or CiscoUM1-VI1 (for voicemail)
-- username is the name of the person to whom the phone is assigned
-- extension is the internal extension of that phone
-- Each of those columns in that custom table must be manually edited/updated

SELECT		DATEADD(s, CallDetails.dateTimeOrigination - 18000, '1/1/1970') AS Day, ROUND(CONVERT(float,CallDetails.duration)/60,1) AS Length, CallDetails.originalCalledPartyNumber, CallDetails.finalCalledPartyNumber, CallDetails.destDeviceName, deviceUserTable.userName, callingPartyNumber

FROM        CallDetails

LEFT JOIN deviceUserTable ON CallDetails.destDeviceName = deviceUserTable.destDeviceName

WHERE      (CallDetails.originalCalledPartyNumber = '1111')
AND (DATEADD(s, CallDetails.dateTimeOrigination - 18000, '1/1/1970') BETWEEN @StartDate AND @EndDate+1)

ORDER BY Day;
