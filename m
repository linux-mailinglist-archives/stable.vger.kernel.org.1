Return-Path: <stable+bounces-196972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F4C8868E
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 08:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEF0334F227
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069525CC6C;
	Wed, 26 Nov 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q9RueSkx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BIGA78Ve"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13934288520;
	Wed, 26 Nov 2025 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141917; cv=fail; b=Wt/RiqyPgck1zU7+yCF5kxE/C4uSSnQLNot1EdcoeygiolPN+UqidwQxI0tGlOWgy45ih96CpUNadLB2jkJ5kZVNeOFCJrG5fApSfdEWKuKGw5IfBSRfZR1cqrhnVH4APodZtkg6uVRAMayWaCGq/BbAddCaVVaGMEcF68w8WPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141917; c=relaxed/simple;
	bh=kPXB9lWXVBD4WkU20Q7Y4nUZl16Q3qh+AdM5/2uZNVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QwN/+zPeHZqL76h+peFWYDC3QbH9VXvJxXJiNrrbwuHZQPGu/6KWWVZVPk6KSo3ZF1VaFctF3nu9nmMiOO4M3MGNNjuyaRYbAiie7QXmP37nlAVrf9N/yzWOke+EJbg8Kvu2jtegxXjNTsF1244IhzxQKgLdop0DA7KBLJGEn30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q9RueSkx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BIGA78Ve; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQ5uvpD1518764;
	Wed, 26 Nov 2025 07:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kPXB9lWXVBD4WkU20Q7Y4nUZl16Q3qh+AdM5/2uZNVo=; b=
	Q9RueSkxkVOLEdxbdeOgpVYCWrx1AOd5t4MaolTNpBWr2dOgFjQBqFAR+V0Y7oO1
	zfKwLaUiWL4i+uju94B5zOApTpl9SxwnOP3oS9e78u9XvpOABEiEgwBVTw/k6hzr
	0oXUxhBhzWm43dakiVl57zoeyRDScslokwzEVk2FgJJ31cE41PLJ4dz8xS1LUIRf
	+W2rqlIjh+d37PLusS+XjTB2n0tD0grgT1bYO61rETpkYr1J3N+VcQ1rdf68roBG
	OP6NRnG9/1oseAxWSYVlpJTR1GadMFncz74l4Ysfo2ULcxMzHkjG98Um9azBUGBa
	ynQWV70JApqSO2RAejkf9g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yhtqjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 07:25:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ7PASd032704;
	Wed, 26 Nov 2025 07:25:11 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mampej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 07:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1wSwx8IWhcVYVSKyUJN2XkkQh7hXDGVmXd/yXCrfMwulyz58TWtc8JCsrdQY8lnMBDwblmbZYq213XjP+/o2hmrspOE07f0gtkJjAymxySU5LJJGMYcPmxwFjQcSC2oZJxUEsJPgaQO2aHwf0IO9GTjMQeuudM1GG3eGHWDY9qsoJ6kY43ffz0mojV9/ngrACSoCErjwVrOe+3/soKPV5VRKKZ4hPsqYUgW1pnRpsASIeIm2vO+uPaOpqiMRU+JkBOsJCqkYFGnFZEiOdN5ysKfNLP9xB7YwQZlT+PJi17r75RuCY8hz/+gmVHwW0rK+qU8D+M/BxWxWLwOrp9MKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPXB9lWXVBD4WkU20Q7Y4nUZl16Q3qh+AdM5/2uZNVo=;
 b=MJB0FRXcJl66IkfvjzVrC8S1LhLi/2rwyfFHTyRxUCwz+wBErCofl2LHffi/vLYBrYeOqGnxG/9NAZVYQrQZ7segeoO9xiooJtlWBxjGi5hG1o7cKbu30TzHUDt+ZlDCV8KdNl3f5IvEPKuIuxw/I+hNz4bLDou8Mbkgipl8D7ZTF7HtFT1KQu6NPH6wj3AjPtgLFiKdDNHgfOkfgcD0TJPlv5Lp+Bb5tY5z/AhKX3c0j3CxUS1a4UX8wNGcYAxcEzGDizxEM4llQzIHIK5r9E2iD7h3+mi+cpQKvujUMwkGTl2M55GXluA19LjZr+H46MbPd9tmyMILpi1BwGliEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPXB9lWXVBD4WkU20Q7Y4nUZl16Q3qh+AdM5/2uZNVo=;
 b=BIGA78VevF0to/M2yVpj9BV8GiCPRyK6jetQZhz0cJGN54Uwe7hj/GIYXYU9/5awBo+TOtdcOEzm4P4d9Qu9sg1Ca5hXCDUeFXjFBHkjG52HP5yLSyxmUcFvIF0TZnAJE8zAT+CCSh2KnUhtXpVuXnrzKSD7C8faiSK98DSCmEU=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by DM6PR10MB4283.namprd10.prod.outlook.com (2603:10b6:5:219::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 07:25:08 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::6ac8:536a:b517:9364]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::6ac8:536a:b517:9364%3]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 07:25:08 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 5.15.y 2/2] Revert "block: don't add or resize partition
 on the disk with GENHD_FL_NO_PART"
Thread-Topic: [PATCH 5.15.y 2/2] Revert "block: don't add or resize partition
 on the disk with GENHD_FL_NO_PART"
Thread-Index: AQHcXqS4oI6D9A8+50yBcNT054I23rUEjedg
Date: Wed, 26 Nov 2025 07:25:08 +0000
Message-ID:
 <IA1PR10MB7240FF5F015F21FDDC8E591898DEA@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20251126065901.243156-1-gulam.mohamed@oracle.com>
 <20251126065901.243156-2-gulam.mohamed@oracle.com>
 <2025112659-oxidize-turkey-c005@gregkh>
In-Reply-To: <2025112659-oxidize-turkey-c005@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Enabled=True;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_SetDate=2025-11-26T07:23:43.0000000Z;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Name=ORCL-Internal;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_ContentBits=3;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|DM6PR10MB4283:EE_
x-ms-office365-filtering-correlation-id: b89ca4bd-904d-40d6-f588-08de2cbceda6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-7?B?Ky1RTjBIdERzYnl1Q1Ryb0I0VlcvQ0thbHhNVWxsb2srLWljU1VXNUdtdy9Q?=
 =?utf-7?B?bXlXTjBzMjVZRXJNZkZ6eTNDVGFYSVZuaHdqai9YS0hTV1VjQ3VqbU51OTJR?=
 =?utf-7?B?bldLYTFUYmVUci9lVTVVM2NWUystbGlGMExReElpaTJmZHkzSWpjMistbjM5?=
 =?utf-7?B?NDcyRlk5cEJBbzJBcmZQRGtueFpaZDBIODVqRWFUWWtiMEVhQUpIVUc2bXhN?=
 =?utf-7?B?YlRkVlEyT0p1eGdYY3pHdXNlRDg1YXNCelBFN0J6RlFURVY5YWxYSkpnZTFs?=
 =?utf-7?B?TjIxcUVaSXQxajNiYVpkcmt0Q1VtQklySkVQKy0wTDNSWTlrYlNhNlY0UVpB?=
 =?utf-7?B?Y0FLRDU4bVRrazU3NG1seHRsQWc1TFlpMWZtVnN4SXhYQzYzamU0Mk5MVDAy?=
 =?utf-7?B?RmVMcXFsb2FJTmlpSXAvcGh6dUlSemkzeUp6NGhtT2NFeU95bG9ONFdmMEJi?=
 =?utf-7?B?ZGJabWJxcktSbWtKLzZBb0YwVGQ0bnlmOGFvNFFoVU9iZ1piN0NBcS8zdzVT?=
 =?utf-7?B?dnZVcy9pb3JwdjJLOCstckRhNzRiLzNFbHMwWDZhdEczSFgzOVBEUTEzWWha?=
 =?utf-7?B?V00rLVByOGJwT3BNSG4wUzR6QTdmRjRpNThKOEM2WXNqdllpRnN3b1JJNm50?=
 =?utf-7?B?NE5TNXpYKy1wQlNRcG51MWE2QTE0UVNCNHNGTE0xYXZlVDIzUXpVbm0ybEsw?=
 =?utf-7?B?VFllUGNJWWhka1pxSDVEVzhETVpNeFdzVnhMMm0vMFBSa3NGVGI4TTVHcE8=?=
 =?utf-7?B?Ky1oZFVZaERValp6Y1U2ZmZhZm1qRVFTOW96UkNxMkMvSFBoRDMrLWFHTXFN?=
 =?utf-7?B?R0hycG9ldmNYM0RxeG9CS1NnRDAzN2hib0RzKy1wZWFwMEs5VElyM0haczRL?=
 =?utf-7?B?Um53ektFZTM4VTFIQzlvdGM0Z3cydnovclV0VTEwMGFyMktGdks5NlJzeFgz?=
 =?utf-7?B?dmtUU1FtVkJYR0UrLWtGVzNtOVZWekJPeGFmTFFwZHROT0E1bmFkNzVhaE1R?=
 =?utf-7?B?RVJDZGc4N1puMUJWKy0wM2g5NWlKMTkvTGlJUjU2aU5kOVFXQlk5bXhIKy1l?=
 =?utf-7?B?NE9nTlI0Y005ekZRSFZGdDVJZ1dwa2JFdzRTcSstalFRMmFqOVFac2w5aXRy?=
 =?utf-7?B?WHQ1SkZFUkdmTUFNMmcrLUpLMUFiakF3WmxNVkxlKy05S0tXNTY4MzJEcnZx?=
 =?utf-7?B?ZmQybDk5bkdldlBpUWJOWVNIbWdyNlZDY0ZxWkRacm9wckttd1hGV3pCTWNj?=
 =?utf-7?B?UCstalNIN1R3d3ZkTG5YSThVczVkejUxWistZUhnVm1KRkZ4bVpXaFMvWkdB?=
 =?utf-7?B?emRkams0a2FXVzNTSGw4SFowNm1Eckk3c1E3VWY4ZlVrN3VRM3RyajNUVVNq?=
 =?utf-7?B?N0pvLzFURlFHRTJQQmU2V29GSmZJemVJelF0elVjLzdLdW9LcHFwbExCSmZ2?=
 =?utf-7?B?WFdNWjlYLy96TE5vbmpUeVd5SmozUzBLT2hneXRMMkt3eXY3T0ZoVFhUVDY3?=
 =?utf-7?B?QkZSREtnZjhudEtVZjBDczBNOTFJMUx1Y0doNjdFMVYrLXJ1dVlHQ3Q4RXNv?=
 =?utf-7?B?cXEzTzg3MFZacEtqRkVWWWtlMkMvWjMyL0RKdHljSSsta21IR1d3dTBnelNx?=
 =?utf-7?B?ZDY3RkdONExXZEd1MDhxSXUzZ0FkWkdkSXNzYlo0dkFvVkZ6TXlZWVJNQnBT?=
 =?utf-7?B?MGdNRzh5MmF1RjJneGV6dU9JZ2l4dlNqamhsTExlWXdUZ3FJMkwwOXVuTE9V?=
 =?utf-7?B?L1M3TU5QcEdGV3N6MnIxVUZRWHk5MlJETWI0Rm5ya3lsZENkOVVZZDNOOS90?=
 =?utf-7?B?UkZLUDNjS2FSUE5yNVMvclZpcUlrNjl6alJPR1h5U2dLRXE0bGVYanhGcnRD?=
 =?utf-7?B?Z0NTbEdNd2xRKy1ZcGRqZURNSDlNKy1Demw3MmlHZGxPLzV3dlptZzlKQWFT?=
 =?utf-7?B?QlhiZUJLT21xL3hRZDZldFY4RTlScEh1cDVLblMzN0ZuRWxlNnpMRUtLd1Nt?=
 =?utf-7?B?cVQrLXlpdmtQUDlYL3RaeE1VQU9tWXdwOXZ4SmlSN2toaUtFRVFlWXBwOHlL?=
 =?utf-7?B?Z1MxMVFRZHVUKy1ZRC85RmljcmVMaVdKd1M3NEM2Ry8=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?UGJVKy1uREp5V1hnSnQ4b2hhd2xJdlk0RkprVlM5dUwzUmNqMi90RVNzVy9H?=
 =?utf-7?B?UjQwUkYwQk9RbDBRVHZsWFlPVystUWRGc0F2ZG5JbzA0am4wVFFMcnBaVm9I?=
 =?utf-7?B?T3FSV1lpS3JVVFR0NXdmVEFENGdRY0kwOW9jZWtNMG9ETnhHeGVFeW40WWY3?=
 =?utf-7?B?SWEyUEc5ekVGZkJhNDlJZWxtaFNKbystOERxRkg1d0pQdTVGVVZVOWs2MG80?=
 =?utf-7?B?YkN2ejFyVGI1NkNoQ2dNU1ZaTjk1YnVTME9SWllCL0ZnQ2FlS0FyU1c2NjFJ?=
 =?utf-7?B?NVVwU0Vzc3lkZmtkUjVzUUhXV0Z4VjFxTSstd1BYKy1nMVpMdnRrZnpTaW54?=
 =?utf-7?B?SzNOaXpxQmdFUnR3dDR2Z2VZUVdjcmVrZnNpdFFjNDdTajBscDUwYmltYktm?=
 =?utf-7?B?TEJDVWNrTDhkc2RyeGEzVFpDWFFRcUI3ZU1QT0kwYllFT1BpMU8xV09aYnFh?=
 =?utf-7?B?VzVmQkhGbXhOaTNncHlzU0pYRFpKZkgyUlNod2tKRXF3eWRsbXdISFloTGFi?=
 =?utf-7?B?clU4cjdJTWpLdm5HKy0vc0d0MlZxMDJ4VldhbVYyWThCdVRMdEVuYUVXWWxR?=
 =?utf-7?B?Sll1Ym4vODUwbjN0aWh6aW5oejAzckZ0c2RzTzgySU5zVlFYVVFaeE5IRWw1?=
 =?utf-7?B?OWNFcnpVeE1qdnE2UzFGaklSN29NQmpieXJZN1l2SVhRYmtOczBvU29yN1hT?=
 =?utf-7?B?RGdtMUVsKy1nWjh3cHkxRVVlZ3ZqbUhKL1BJMkduajdQT0NyQ05rSm9BV0sw?=
 =?utf-7?B?YURmMGlWZ3FhTThROENFNzUwMSsteHhxZFpqNTFDVistUFNmaHVoWDEyVEZK?=
 =?utf-7?B?OE1vdzlqeWZCNTFDTUVIQUNUM1BkeSstL0ZLLzV3WUZwdnVTazZnOGVycFZ2?=
 =?utf-7?B?cEtING10MTYxYk0xZHJ5NEpHdUlVQXpJRTk0MWVqZUZXbFVqdkJrZjJKS2h4?=
 =?utf-7?B?UW1EL1FpOFBLYUNMUWhaa3BFR2VNTnZuV0NrZU9YTW9IeXd3V0JNai9qcWdm?=
 =?utf-7?B?SlhZTDJFKy00eXRZRnhWUVNZUzJRZC82NUVRSG0xRms3WkVndXJWblpQWm5V?=
 =?utf-7?B?dHJjMmVGY0VsUjJVTjI2TTBjenBHWW14Ym5UWDVQUGk2TXFHTGViT2p5Q1ZR?=
 =?utf-7?B?akpVMVlHWlBGTmV0YS8wKy1IdU1TaGJzbUJjQmIrLW1FRnBMQnFrWUhNUGZC?=
 =?utf-7?B?aWkyUlNwV3lXdEFkYW1QS3BwclJ5YjliNlZzeFJMTDB5bHovclpRNlJ2Y01N?=
 =?utf-7?B?REoyY2VYMDY0SHZjZEs4RTZ3Qk85ZUFLNWNDSk1OWFFuSTdCY3Q0d2VXcTZs?=
 =?utf-7?B?L3dleWdvOFJncUdWVi9TZngzNnFJOHA2ZDJVN0doMnM5dmltMXRPeVB6aDFy?=
 =?utf-7?B?TnVyUGdCRURrQWZZcFFiQW12VWpJVVlndystVzZ3dVlzU1pOZ21QdUZnYkZR?=
 =?utf-7?B?b0dQT0prOWc1Qy9DeW5VN1hrcmNiLzkwQVNXM01sczRITGJvTzE0V0xCSEhQ?=
 =?utf-7?B?ckN3U1NWS2R2T0ZiSjVURFlsd0ZXQXY3dnNJalNrb3RWeHZXUVVDcXYyUXhK?=
 =?utf-7?B?cDVXemptY3BKQ2IyQUVtSEx0NDFqZlpVbVJFWFZOUWlxbE1MTG9RaFBTMWFN?=
 =?utf-7?B?L3RNKy1BVzV5cHF1ZGlZTDQzKy1PcWZvWXBvSWZNaENPc2thUWwxVGluYTRU?=
 =?utf-7?B?ZkxSbystem9mVjY4STc3cjRBKy1NVnhReDU2RFVEN0JXSm4xYzI4aVZIUFk4?=
 =?utf-7?B?UlpBbFA3dVU3OXd1YUYrLVVSUTVFMDJHSlBLa0lhUzlxL3YwbkRqbURESmg4?=
 =?utf-7?B?RzRxaXBURTBtTEpZemh3TSstZ3RseWxuRUtKNVF0MUZ1RU5Vd3RBUDg0MlN4?=
 =?utf-7?B?Q1RCZjJON2FlNDZYQXVMam9SaGNuSTR0MzBsNDlMbXh1Nm84ZEJkMkZKcDhG?=
 =?utf-7?B?QWxOeGlCczdrYzd4RGVKMzFZMUcwVmxYakJESmtGZ2tla25SVTM0bnlVV0hl?=
 =?utf-7?B?ZlRodENjTzVYTXIyZ0lRdk8xdG44UE5odHNwaGJTN3RIaEdoMGt2Lzh6RFE4?=
 =?utf-7?B?aVh2TUxJWXorLVhTendvczFCUEF1UkNZdVhqSkhrWWZGb3h1L0ZuYW92UGVJ?=
 =?utf-7?B?SS9Tb2gxTFVEODFBTFZYak5NME5QQ0k2b0VpTnlFWW9KcjFPdHg1bUJ6TFFI?=
 =?utf-7?B?Ky0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uHyxDECtwaBQcyfXvz7ebO403NDIJGSq5NzWtG22vl50bahz5r4j9/OyXrhlixwwKKvVfBlKtbW++TbY62eeoxwfqkpBpvAyQsyJR2U0ge14wcDU7giA83i5HmExKiodP1e7tm8OtfJMycPN2hmflBITtYS3lPi6enAQbczsG2klMpqUJnvaUkgib1QHhJBwxCD3i7An8tNzMQHV/2yTPvojzgQt7QJH5dIcoUKugnnJHPKBqTW5QqjU2XWjkJYYhnz8sP9j8lqS4wsWw0ZPLouDTi77z4exHZehEmCGZLerJwwQ5zqqSWFUJrvpsTqCDbt98hw2f/LfxxJ+UAH7IHwK3afJQyb7YVQjKCYt/W1KnNCfEpiAlACq/cdTOgPLZfG/KOlKsKzq+2vpWAPaMd30Cft9kmPKVb7HC2BhkLI+O6+nPOArOUu32X9NtTGY9y5nkcal2mhF+hGK8SCYlGjroOyzjHZfu1J7v49WO2QCH6jBz3DkCYeoClcVUMIZoJwnfMZhMAWWeYqjpOFELnSLa7yotYdsswve8qBrm/mzSa9fyf9NduULjkRnW6en7a9YKGRIcTlhJxZoWSJVQCPiyVRCbIdLLChFLjx+MK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89ca4bd-904d-40d6-f588-08de2cbceda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 07:25:08.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwTs+OuIPhsx5o0rG8Cb51UBBItDOwOUUsFY+U7DKUSLd636An/r8HmS9sGi/BJAViq6VzgdL22tQtI/5UBRrDp+0SGcCx5NyywU1xsZFuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=910 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511260059
X-Authority-Analysis: v=2.4 cv=L6AQguT8 c=1 sm=1 tr=0 ts=6926ab57 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=WJJPNcJBAAAA:8 a=mQvHCebiAAAA:8 a=hg5frX6Z25JUM5YtiqgA:9
 a=avxi3fN6y70A:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=Orvq6HXzVWGNNdQUjdZg:22
 a=wsrb8zZI_WQ3QAEBCXTy:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA1OSBTYWx0ZWRfX9A9s0kM1hlCT
 cImLyR38OBr8k6S+asOUABOu92NgKJEu+j2Vs2bvfidYhDk2TAxL4thOH+XvotHLpMFVJ3qOqUr
 prKgYnHixGmX8skDeOnhVQJ/G8spzHJ+k64xgsa9OQzb3O01fsxdgjKLTwVYwRAptaW4ccvJakm
 LoRso6ECTAT64GnyNEyFzl5bBQvbEQ9kBBlKJ+A8F1DpX0/t3ul36CLBnwGEhIvqZ8vhW2m3KBh
 4yS86VI2s45daJHL4doAvzr/p0srU6HveGZSKUJluCUYfvyVgseTHIPC7yxfpVN8HkWQUMyq3ms
 /OevZZrT63sTDQcGHOHKQSKTWwf/CjmQ3QmdApOoR3tXtOijSdwiU2bGJrQyjCqE0Dw5b5I4Tz8
 NuJplK1uiKu6kj5mvpvXJdU9Ps7pIg==
X-Proofpoint-ORIG-GUID: QXMJfZwx4j6cigU_epnJ6YKQ-HjVqnjZ
X-Proofpoint-GUID: QXMJfZwx4j6cigU_epnJ6YKQ-HjVqnjZ




Confidential- Oracle Internal
+AD4- -----Original Message-----
+AD4- From: Greg KH +ADw-gregkh+AEA-linuxfoundation.org+AD4-
+AD4- Sent: Wednesday, November 26, 2025 12:47 PM
+AD4- To: Gulam Mohamed +ADw-gulam.mohamed+AEA-oracle.com+AD4-
+AD4- Cc: linux-kernel+AEA-vger.kernel.org+ADs- hch+AEA-lst.de+ADs- stable+=
AEA-vger.kernel.org
+AD4- Subject: Re: +AFs-PATCH 5.15.y 2/2+AF0- Revert +ACI-block: don't add =
or resize partition on
+AD4- the disk with GENHD+AF8-FL+AF8-NO+AF8-PART+ACI-
+AD4-
+AD4- On Wed, Nov 26, 2025 at 06:59:01AM +-0000, Gulam Mohamed wrote:
+AD4- +AD4- This reverts commit 1a721de8489fa559ff4471f73c58bb74ac5580d3.
+AD4- +AD4-
+AD4-
+AD4- No reason is given, which is not ok :(
Greg, Thanks for your review.
Actually, as I said earlier, the reason was mentioned in the first patch. B=
ut I have included the same reason in the second patch also and resent it a=
gain.
Can you please take a look and let us know?

Regards,
Gulam Mohamed.

