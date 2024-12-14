Return-Path: <stable+bounces-104199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1209F2033
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 18:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824E3165E1C
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 17:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A168B195985;
	Sat, 14 Dec 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fuSucegI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r1ky7qTo"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7261E502
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734199034; cv=fail; b=ZJzSgnx1/P+ySPNfWOUbkncY6EAHGTQ+Dk7bCZFc3aiXiLU/jmw/sO9rQGchB/DZSMk4aUSsHdfSbnFWd5SN4xoQoM4swvJcY4lHhRkxAjxKd/AZucKMg8vvrmuai03M/H7pfEO1fWttX5/Dw0XRIeWVu72f/+8Ga79hDGGNeWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734199034; c=relaxed/simple;
	bh=ssXaIpHn5waGA9b1cbxGcwZXtG/TXklWmJINcPaYfBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2s2VN/ZMT8I4aUNIhLTNdwL3Zp36lq3RaiX9d65hw3sFiyqpFFmdYcciqBsWOLRsY5P6wAlGgJ1maPyN6gmOpHgrxVPS8tAlPn6n9bfr09ChcyHnBUccza5oqXLu1C28CVddpAKLgGhVnpqhkUYqCdRDc3MHZpTDAr14WFSQTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fuSucegI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r1ky7qTo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEBbICN021285;
	Sat, 14 Dec 2024 17:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ssXaIpHn5waGA9b1cbxGcwZXtG/TXklWmJINcPaYfBQ=; b=
	fuSucegIj1kuGQtDUSI//iHy6jP/pCyS9PvSvSwZyOY2jLYcwRSr2tNHDMcwCHE4
	6EOi2u/e4c+5Fdy0wO7rDQ26lCf/QddRonoqGF62p0dNWe7sPsrhgx2MjsOSt6ok
	+SE8CcFSbH+9wryFNm3+O8o07rptww8YxGSwK4ibBk00tHwWyaU/gvPqTeXw2if2
	AGhez2DKt55Iiy78dYqV8lefxdZ6bjA49AAUYqxrc/leNsZUaIcs3Yr6MgEHzVbd
	mNxZOuFAcaH2RgZ9LjJupNnb63uv03cO6cMYSGKe7/JmpwvDzDHS7FbJS47UhfUM
	hgR/cUqM7SpwR3UPN1IQYg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m00mpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 17:57:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEEuiWT018362;
	Sat, 14 Dec 2024 17:57:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f5x6ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 17:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nq9HZyCEsfTxkRTbrcLvwNvhPBAJKHDkuDI3ckudNiLV7QjsooAX2a2jJXEsQ2f4s1l55luGCVyfku4Zwrys1PL1dEbXsJzrc2EfieuaKJ+vLe8d4g6QV31MD3R5OE4kqHExN3WIt+hMMSMEaKC2bc2ag+xCgpbNuluUkSVmSu+dCSZ9dyxb2rC7mAHEPcaZ7jVtxVDUvKSA/uHc5n6mGx+/EsNNd9bZ22gDSw1gMq4ntO2GHWj7h+H7r3whMvZYi1Pz+6TJog/5dteIjIwWMyHpZCmAhAPX+0rnYlJNy6JI3eJ78cd/BWeSRmYtoV9c5+8rtp8aGI8eIm1bmEW+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssXaIpHn5waGA9b1cbxGcwZXtG/TXklWmJINcPaYfBQ=;
 b=gRFpJ9ww94eF4K+giiZoGRrFuTNYV9mLhN9yBeeoAZAMyVb+HIgxt2phHIij7axQ7mXI62i1zx+sIgLB4uPMuCq1usG3Sgcddp+g6MexodQU2nCL7KxcjixTFTcO4CExDtS/xxbFD4i+9dH0NkwC21A+k0qMF4CwMV3VmKH2QPJ1N4D0LNmRXshXxc0RQffAQZuS/EQHl+ThnRyTBT22+CCqV2BY5zyeLzU1xKf+Fcx+py4QzlfUGSfMkVJ6+Tf//qUBX9cmgCro4viFtwVc+kKQoScIr35fsHfvcYW8TEpDS8n3BcPt/tkfchl+ssGg8PDUh77TIlxYZ7PCzTDWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssXaIpHn5waGA9b1cbxGcwZXtG/TXklWmJINcPaYfBQ=;
 b=r1ky7qTo2LEzGiHadEZ6HYQkPLYmyna9UX/iHU9CHaYN5Eq9+7+EWg4vnKNjzoHrj0f5qjJk2R5+c4C17iF/n2URTUspzmQ0mLCcVm/b3hcNGVzSBnS5J1oLMTeqq9qdhg4km4aetU09jwMuRpQwfI5/t1+nKo+T1SD5tsdIMAE=
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6)
 by BN0PR10MB4933.namprd10.prod.outlook.com (2603:10b6:408:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Sat, 14 Dec
 2024 17:57:01 +0000
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb]) by SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb%5]) with mapi id 15.20.8230.016; Sat, 14 Dec 2024
 17:57:01 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: Sasha Levin <sashal@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15.y, 5.10.y] exfat: fix potential deadlock on
 __exfat_get_dentry_set
Thread-Topic: [PATCH 5.15.y, 5.10.y] exfat: fix potential deadlock on
 __exfat_get_dentry_set
Thread-Index: AQHbTbq8m+a8McrJ+Eyh7pha6scOJLLlzN0AgAA6xwA=
Date: Sat, 14 Dec 2024 17:57:01 +0000
Message-ID: <CE0C9579-A635-4702-B8B3-896E3F035044@oracle.com>
References: <20241214091651-0af6196918c18d20@stable.kernel.org>
In-Reply-To: <20241214091651-0af6196918c18d20@stable.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7082:EE_|BN0PR10MB4933:EE_
x-ms-office365-filtering-correlation-id: 3ef4c764-2c28-4835-f7e5-08dd1c68b5ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzc1MWU2UzV2NForKzdFeGF6WThxcEg2U2FMVWNML3g0cXF0b1IwTVFEeFVS?=
 =?utf-8?B?Y3N5RytkRS9PdmwzOWxCRWU5d3pEV2FPUEIzNkQzRDltaTRvdEh6OFlIZXdY?=
 =?utf-8?B?WURtMDVzSFo3amxaVU04bXViNmhpam5ic2svZk8xdVpTT09FM2xQRlozbksw?=
 =?utf-8?B?QjlvUzZ6cXRJbklEb1RrZy9DMitOalUveTlhSllhOXJOYm5jUllIK3hWWlYr?=
 =?utf-8?B?K3B2bDdZS3FTNWZwSlAxVFl4VjduR0hSUmxEQ1pzWVVMeFZVVVY3VmhNSEhZ?=
 =?utf-8?B?bzA2QkdGQ1NUMkJKTTYrdWVwYlUxZklaWWNOb242Z2x0eUVoRDFpcjg3c3RW?=
 =?utf-8?B?QjRNWitmUG9PeGxOVmd1WTh2Yk5lZ0o1NWpMZWZ2WGRZdy92b0VkUXUwc1Nm?=
 =?utf-8?B?TlpXMmwyTDlSRndMQWk2YVJGT1pMMDhiT2xnaEpVWnk4cEhTSmdqMENxaWdI?=
 =?utf-8?B?R0M5cmRJK3Z5YURxcVpqejg0K2JQbUNYTThoelJJNDZzaXBMRi9Oa1B1WWsv?=
 =?utf-8?B?aFNtTTZGRHMvOTV2NUNvZHhiTE43RTF1REJoVVIzdTJpWllnTGwvV1ZuRFZ1?=
 =?utf-8?B?d0c0RUdNYUxlK2ZPRm1ZQUI3bU1JMHJLQXNCd3NoeThOamRxVTYrYVdPUy9S?=
 =?utf-8?B?OTdQUzZSd3ZIQ3YwMER0azdRSlBxaks1YThGaU52MFRnVjVjci9tby9FaDVz?=
 =?utf-8?B?eXJOUTFqL0NrcGt2NTBQNHAzdFk5WFpwdXhRaUdrVEFZL21kMG5iQWtMeG5m?=
 =?utf-8?B?NHo5b2duZGM3UVZkN3lLaUlOVGxSSE9kK01zTGsxWlpZbEs3NnlDN0puT2FE?=
 =?utf-8?B?TkxpVHRjWmJnZUpCQnM1UWU5RHFnZVd2YUpZSHZpT1VHNlhSMWZabTBSOGI3?=
 =?utf-8?B?ek5rNmNGdkRyUmtmMTJUZXU4Rzhwakt0aVNOU1ZGd3o5OHY3cUV6MnphRCtn?=
 =?utf-8?B?SEROamxRTHA4a1RGdlhUZjlrMVhpZk9udmNuc1J2c2lOdkxadVdHRzRWeTMy?=
 =?utf-8?B?QUxMVy9iTUVwbTQ5a2cveFBNWWdYNXUxZUNmNXNhOXBib2dnYk50WE9oWjZq?=
 =?utf-8?B?dUsyTk5KWnV0aCtvQzlEUWw2dlZtbk96cnJHQUIrWFNLcGUydmJISlVoakFv?=
 =?utf-8?B?bGsxMHpYMEtlclcyK2dycEV0VjBQcElXVHVrTC91Kzd1ek1BVEtESXBqTlRM?=
 =?utf-8?B?TUVVSm9rVmc1TXo3VDIwaTJFcER5YkZiQlNVaCtwQkh0YW1HZkl4dUdyVzVF?=
 =?utf-8?B?TWo0RHo1MEU5b2RFWnZ5UlQyT2RYSVUvaDYzbUl1RGdML1dkTE1FT1VLZnA0?=
 =?utf-8?B?T3MvTHUxNU5JOGdDMDRGblVqb1dFaTlLTVdBZ1FaREtJUjNSNG9lcFlBNXdM?=
 =?utf-8?B?bnZJWW5JUjJlMjMwWlM3Q2QwcmNiWmgrT3YxQUhQL2JKek5EbkF0Sk9VR2Yr?=
 =?utf-8?B?azRSOXV6a1pkSGdjQUVXZzVVVjdLRzRVVUt3UkViMnA2NkN4OG5Dcng1ckFk?=
 =?utf-8?B?UjkvUXNFSkF1M29BYmMrUDdydTdkRGtYNndyL0lvVkwzME13OTJtdzlmZkhu?=
 =?utf-8?B?cnNwMGIvaGdkTmpMQ2x5SkprNitzT1R0VVVvVlJUMEZwYmp0Rzl3bVVzd0Vz?=
 =?utf-8?B?QUZZZGdLZGZCZU5mV3RIQk9PRU51MFBWQWs1U3pjTTE3ZFgxK2tXTEVadTM2?=
 =?utf-8?B?VURzYWNXWnk5WmhpRHBvMWhORkVxbXQyT1VYeEc1TUUzR2MvWC9lVml4anpM?=
 =?utf-8?B?NE9jVUxlK256Ukk5eWp0c3BMKzlKY2Q3TUYyR0s5OFErSzd2UXNROUNKN1NX?=
 =?utf-8?B?NmFPYUtzVnF4c29OT3MxeHFnVENLMkNUaE9ZNkhoZStlaDUvaXVzS0d6Wlk4?=
 =?utf-8?B?UGhHbk41WDQ1bTlPa0pEa01KaXBLTWhwNzcraGJxZ2VadnlhQ3VLTkpBK3lm?=
 =?utf-8?Q?7LbuQon+W3ufB7FSSYb0TnJwsuU92Tid?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7082.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1V0QmRvYjNjVm4rTXUwckx5ckg4RFNqWFhoOEdhN2dnRFk4MUI1dUhheDVU?=
 =?utf-8?B?U01zTlhleEoxL0ZmV1dQVExienZsNEl4RlVxeWpqUEdodlFQNHVyU0NvWmVq?=
 =?utf-8?B?NHhLVXpoSi9YSUJMUUtMNzFrTlpCNGhvSGFiM3l6dnU4Y2VBalRqNHhLdC9V?=
 =?utf-8?B?ZFQwYVdlNXdZNUFhUlhMcDUvTWFTTkVCSkJQTFdIWnowQkZ5Zy90T2RrNGEz?=
 =?utf-8?B?VnIxNlJ0RzRoaWN3cUhWc2hYdExNVkFHN01lV3ZTTk9xSXcwQjBjTlRudHBB?=
 =?utf-8?B?cys5bnZsQWE2bVc3a2laRmFpKytHeEtwRzA5bEowRTR2ZnNZcWI2dUZwOFJ2?=
 =?utf-8?B?YkplN2dTaVFjTjVsNU9zencwYW5QKzNPL2lHWGRkOWtBZHQvZG5vdXJDYmgy?=
 =?utf-8?B?bWdNMEtzUHFzRm1VVjBrc0k5TEY5dEdpelcyclgrcEhwcWl2TjJoS2YwOEJr?=
 =?utf-8?B?bmJQZDRWczhtOUZwSXgrYnVPL2paTDAyblkxaXA5UkY2VlJwc3RiRDMxSk9z?=
 =?utf-8?B?aEhnZUJ2aStVZVhCVkFvUVdCS0hFNld3QjJWRVlWRVprd084NjJtNVA0UEJO?=
 =?utf-8?B?QnZRWlBtdHRKNStJSEM5bmZIOHhNMmhvWFRJbGxLYStkZHFmZnZhV3l1aDhR?=
 =?utf-8?B?MHk3NTkybE15ZG44bFVMMlBhN1JSQi8wT1VSd2JOWTViK2d0K2Y1UGdzZW5u?=
 =?utf-8?B?RVlKVjVXNENZN3B4bVlLbGZDMjJUQWtFbGlOd1VDWWkveHRMZkVTcnNOSXpU?=
 =?utf-8?B?cWZvS1hvM1dtMmpDVFM2M3YvVzJmdTgvYVZ2dTk3ckJENHkxOUR6TUVqNS96?=
 =?utf-8?B?OE01Tjd5VGRDT05ha0wrTkNmM3Z4L2hCeWdEYm8xbHliZGtMd0g3dGVvRExj?=
 =?utf-8?B?ZU1RN1gxS0RNMmI5Z2lGa04vQ292a2NOOGZNbFNhVkNpTCtQUHpxOVNRRHBn?=
 =?utf-8?B?eEZJRWRvOHp1VnByRTVqYWJYbWZLaXliNVc5T2pTUWNsSkY3WW9KWXRjam92?=
 =?utf-8?B?Q0FZT1lIV0ZtODZKdldWMmFnT3M5SmpPZGhyaXFURjg4dXJMcmYveGJ2UnVt?=
 =?utf-8?B?bjlrbmZ4TkxubFJRQytQSWZlQ3dKTVJJaDA3c2FUYm9QODZBcTFvcXF0UVNM?=
 =?utf-8?B?ajE2dExZS0NVSm83UVhySFl1MmcxZFFWajhwdUNVNmRzMWZEdVdELzhTOGpQ?=
 =?utf-8?B?Y0F1eGFjRUVweVdzSmhVTzJOS1h0QmFGMmw2M1lDSlRXMC9OSTlHbmhiNmNj?=
 =?utf-8?B?Yi9LWHAxUVlLOEhmTUxQUjV6NTVYbWFIT3U1cmF5QW1GMnQ4cWRsZU1NdlJT?=
 =?utf-8?B?aVowOEFHR3ZLdWF2akZlN2IwSExaY3E5alRRdTllRXNXa3BTWTdJNTlRcm9o?=
 =?utf-8?B?K2IrYmVkcWZGdXpKeUEvWVJJZGtydi9ralIweENNbC8vczF5OERuWU1wMElj?=
 =?utf-8?B?KzNZK2NRbTBQZEZWNnVUVGp3V3JQYy9wQ1BlRDBvVmdHUTNLV1BTcHQ4SXNj?=
 =?utf-8?B?M0Jaa3pLSzR5L2JUUGJrZWNjMm4xRjZScm5CN016Q0JWZWhFY0d1MUJENjM2?=
 =?utf-8?B?c0VxcFZQaHk5SmNFMy9ubm5BWExvSWdXaFZnRHZmOHcwU21IQjhCMFh0a2pI?=
 =?utf-8?B?emEzckk5OU1wdjlEb1M5eCtUcVdDV0QxTDVtbEhWV0J1RDFOSGRHUE9oeGdW?=
 =?utf-8?B?Wi93cFIwODRpMXJmMFNlVW1zVzZpTDJnTG5JRHVrdU4vUmdpNnNTY1FwL0FB?=
 =?utf-8?B?NW9vTlB1MVJ0Ym1aOTFCSEJQY2ZTOVQ2N1NQenYzRHBvWC9NTTVzMmFwTUh1?=
 =?utf-8?B?VTQySE1yR2ZDZkhCZnRSdzdZTS9kQWJzZ0FRMFRtdU1HdlhzVlY1UkVjY2k4?=
 =?utf-8?B?WlVXSktiV3ZFWXhIM2pyVytoZFh2c1dmQkVkNnlHZ0NDV1l1ZWJrNkMyYkFC?=
 =?utf-8?B?dHJZUm53NFRJRkJtZGlsY0hnQVR1N2VpY0lTcm85cWQ2MGJaYWh0REhBZjBj?=
 =?utf-8?B?U0NwNWZTQ0FVamkwVWV4aWdxVWVHd1VPYkJGb3FuTlVNdkd6c0pSNGRVc203?=
 =?utf-8?B?OE9ncmlIVzVCTkNPL1lCbVhhWU9uWnorNGJWR0MxSEM2MUFvQTlMMHFURGRC?=
 =?utf-8?B?NG5iRW1QRW5Cc2J0bURFQmU3dVAwWmR5S3k5b2xwVzRId1V0dEMzTVhreisz?=
 =?utf-8?Q?6jRPojWE40U7VLyYCv0UKvo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <350ADE4016ED2345B85DFEFF150B7CB1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iDKWLxg3Gn4zqvjr7nLlRKq12C1pq6APXXCTEZfOmd99zDe53xcC2YWgicGOWZrhAvKYSJtcRq2ESKenhMu2R0r4srXdzfSICQPcoBXvufcKn7VtiIh5CqxDj0UnLs+ibE/MDcuLIejB+W+NkggRdFKDgvs0+TdGpgbsdlD5zr1pyxZSLWsw8lOYP4/wD4OeE5pB9NjruheZ9xlRcPFuNePjdb2VnFun/cjFsyxnntvRFTr27x38RVL+g+gQCTNPOaLsuUMc2QTOfAS3q5feVojOG82MVkf8RbiKdzO6aOdnZz4WK7TUiA90M7vw+EbWR4o0Zh5b/FDfxMMoBVD+DuFo/GCljzjf58Y2paXCcFfO8FekSxbMEc1YVyOpXtpy7JFDGBWeuRdxEf+1wHTWBNDi9QR5rDkQtTRFcPoSms0hwU/Onnltl760HbJi0ECdOpt1t2UeIfCkiXCZCdCUENOmtHIvCfJ4hwm49C0Cit4vBtF0oAHP2E4Nic06CMMqTcPGaYwoXq5iBX0bb2KPoaSoa7QdsZc4Dv7DszhQXHzTpxjuUNQZp+7qF72fqLhpo0Xtz2otztx49459bC6QO68/BKxzOt7MrOo9wxzXkmY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7082.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef4c764-2c28-4835-f7e5-08dd1c68b5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2024 17:57:01.0796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+sqwEynmVplj98xsRfuYqUgJQDEWTCEmZz6wnSqliA3z9ggE5pvuCDdOQ4/6gwJBEc6ZKZYCzJ3OO49yzm6qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_08,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412140147
X-Proofpoint-GUID: 4nIAxKDtb-di4vS2mXuyArEWJTwp8tTX
X-Proofpoint-ORIG-GUID: 4nIAxKDtb-di4vS2mXuyArEWJTwp8tTX

SGksIA0KDQo+IE9uIERlYyAxNCwgMjAyNCwgYXQgNjoyNuKAr0FNLCBTYXNoYSBMZXZpbiA8c2Fz
aGFsQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gWyBTYXNoYSdzIGJhY2twb3J0IGhlbHBlciBi
b3QgXQ0KPiANCj4gSGksDQo+IA0KPiBUaGUgdXBzdHJlYW0gY29tbWl0IFNIQTEgcHJvdmlkZWQg
aXMgY29ycmVjdDogODlmYzU0ODc2N2EyMTU1MjMxMTI4Y2I5ODcyNmQ2ZDJlYTEyNTZjOQ0KPiAN
Cj4gV0FSTklORzogQXV0aG9yIG1pc21hdGNoIGJldHdlZW4gcGF0Y2ggYW5kIHVwc3RyZWFtIGNv
bW1pdDoNCj4gQmFja3BvcnQgYXV0aG9yOiBTaGVycnkgWWFuZyA8c2hlcnJ5LnlhbmdAb3JhY2xl
LmNvbT4NCj4gQ29tbWl0IGF1dGhvcjogU3VuZ2pvbmcgU2VvIDxzajE1NTcuc2VvQHNhbXN1bmcu
Y29tPg0KPiANCj4gDQo+IFN0YXR1cyBpbiBuZXdlciBrZXJuZWwgdHJlZXM6DQo+IDYuMTIueSB8
IFByZXNlbnQgKGV4YWN0IFNIQTEpDQo+IDYuNi55IHwgUHJlc2VudCAoZGlmZmVyZW50IFNIQTE6
IGE3YWMxOThmOGRiYSkNCj4gNi4xLnkgfCBOb3QgZm91bmQNCj4gNS4xNS55IHwgTm90IGZvdW5k
DQoNCkkgZGlkbuKAmXQgYmFja3BvcnQgdGhlIGNvbW1pdCB0byBsaW51eC1zdGFibGUtNi4xLnks
IGJlY2F1c2UgNi4xLnkgZGlkbuKAmXQgYmFja3BvcnQgdGhlIGN1bHByaXQgY29tbWl0IA0KYTNm
ZjI5YTk1ZmRlICgiZXhmYXQ6IHN1cHBvcnQgZHluYW1pYyBhbGxvY2F0ZSBiaCBmb3IgZXhmYXRf
ZW50cnlfc2V0X2NhY2hl4oCdKSwgc28gbm90IGluZmx1ZW5jZWQuDQoNCkhvd2V2ZXIsIGJvdGgg
bGludXgtc3RhYmxlLTUuMTUueSBhbmQgbGludXgtc3RhYmxlLTUuMTAueSBhY3R1YWxseSBiYWNr
cG9ydGVkIHRoZSBjdWxwcml0IGNvbW1pdC4gU28gSeKAmW0gdHJ5aW5nIHRvIGZpeCBpdCBvbiA1
LjE1LnkgYW5kIDUuMTAueS4NCg0KTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgbW9yZSBxdWVzdGlv
bnMgYWJvdXQgaXQuDQoNClRoYW5rcywNClNoZXJyeQ0KDQo+IA0KPiBOb3RlOiBUaGUgcGF0Y2gg
ZGlmZmVycyBmcm9tIHRoZSB1cHN0cmVhbSBjb21taXQ6DQo+IC0tLQ0KPiAxOiAgODlmYzU0ODc2
N2EyIDwgLTogIC0tLS0tLS0tLS0tLSBleGZhdDogZml4IHBvdGVudGlhbCBkZWFkbG9jayBvbiBf
X2V4ZmF0X2dldF9kZW50cnlfc2V0DQo+IC06ICAtLS0tLS0tLS0tLS0gPiAxOiAgOWI0ZmM2OTI5
OTBmIGV4ZmF0OiBmaXggcG90ZW50aWFsIGRlYWRsb2NrIG9uIF9fZXhmYXRfZ2V0X2RlbnRyeV9z
ZXQNCj4gLS0tDQo+IA0KPiBSZXN1bHRzIG9mIHRlc3Rpbmcgb24gdmFyaW91cyBicmFuY2hlczoN
Cj4gDQo+IHwgQnJhbmNoICAgICAgICAgICAgICAgICAgICB8IFBhdGNoIEFwcGx5IHwgQnVpbGQg
VGVzdCB8DQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLXwtLS0t
LS0tLS0tLS18DQo+IHwgc3RhYmxlL2xpbnV4LTUuMTUueSAgICAgICB8ICBTdWNjZXNzICAgIHwg
IEZhaWxlZCAgICB8DQo+IHwgc3RhYmxlL2xpbnV4LTUuMTAueSAgICAgICB8ICBTdWNjZXNzICAg
IHwgIEZhaWxlZCAgICB8DQo+IA0KPiBCdWlsZCBFcnJvcnM6DQo+IEJ1aWxkIGVycm9yIGZvciBz
dGFibGUvbGludXgtNS4xNS55Og0KPiANCj4gDQo+IEJ1aWxkIGVycm9yIGZvciBzdGFibGUvbGlu
dXgtNS4xMC55Og0KPiAgICBtYWtlOiAqKiogTm8gcnVsZSB0byBtYWtlIHRhcmdldCAnYWxsbW9k
Y29uZmlnJy4gIFN0b3AuDQo+ICAgIG1ha2U6ICoqKiBObyB0YXJnZXRzIHNwZWNpZmllZCBhbmQg
bm8gbWFrZWZpbGUgZm91bmQuICBTdG9wLg0KDQo=

