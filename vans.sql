SELECT		
	DISTINCT sr.name AS "Van Name",	
	COUNT(ar.id) AS "Appt Ct",	
	TO_CHAR(DATE_TRUNC('week',CONVERT_TIMEZONE('UTC', oh.timezone,sa.schedstarttime)), 'YYYY-MM-DD') AS "Fiscal Week",	
	sr.Resource_Subtype__c	
FROM		
	sd_salesforce2_fieldservice.assignedresource ar	
		
	INNER JOIN 	
		sd_salesforce2_fieldservice.serviceresource sr ON ar.serviceresourceid = sr.id
	INNER JOIN	
		sd_salesforce2_fieldservice.serviceappointment sa ON ar.serviceappointmentid = sa.id
	INNER JOIN 	
		sd_salesforce2_fieldservice.serviceterritory st ON sa.serviceterritoryid = st.id
	INNER JOIN 	
		sd_salesforce2_fieldservice.operatinghours oh ON st.operatinghoursid = oh.id
WHERE		
	CONVERT_TIMEZONE('UTC', oh.timezone,sa.schedstarttime) >= (timestamp '2020-07-01') 	
	AND	
	CONVERT_TIMEZONE('UTC', oh.timezone,sa.schedstarttime) < (timestamp '2021-07-01')	
		
	AND	
		sa.countrycode IN ('US','CA')
	AND	
		sr.Resource_Subtype__c IN ('Bike Delivery','Tread Delivery','Service')
GROUP BY		
	3,4,1	
ORDER BY		
	2 ASC	
