Return-Path: <stable+bounces-72827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D78B969C88
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 13:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF31FB2356B
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550551C9858;
	Tue,  3 Sep 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U0cASj1p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nfp9eSvg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A22D1C9853;
	Tue,  3 Sep 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364586; cv=fail; b=FvZXuVJqXShTfjqc+huxcFQoIlNdsp2nQNhrmOnokTd1sNPEWwgD/Dr1fzIO9K5rGHwcDynp/z7LaYY4RpNZDed0NNeMuJAwqx/ifVpJHEaIIn6p5gTlELXqsSHfsX2O2B0HAFK2giLWJHJo51H5pRu8XvtqJpa/fivdAN/Qe10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364586; c=relaxed/simple;
	bh=QC4SMjIrSPNFQ2dIS/amM3qeOx/niBGqiEVxF8DF9wQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=Fi6NKj1AobwySVci5IL/eoacvYeyUmOgjDC6B+DblO6qYIR7LdGGHVy3a2HxVvg/M/1pe7VaScnVH4VWisxQSgnHxm6TIZN6DxSZGVQdyT6tk0fmllkHifNwknmZu9rt9H2uodsOtd9bQGPJbz6pLKE7Sa3dP8I2IosQ+OvwkPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U0cASj1p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nfp9eSvg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4837fh2U009164;
	Tue, 3 Sep 2024 11:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:content-type
	:mime-version; s=corp-2023-11-20; bh=RtPmHdRYmvjNkooWIxgCF5gk39o
	9hZBWkAdxdU8CF4o=; b=U0cASj1p1oQ8fvrNaYng2duRJpG+vVProyjHHeJWjt1
	R/NYIuzzwkivrzreuLKcI/zFlXgV9Ve9EeAlMW0vdBAZOYzHjeaK7N8/OwCnf0wo
	y1npSU3DQ3i2b0cNRCQyvRIuITH5n3IRjyfXPDkAUmPKfLjNQ2siDK+ZaA+Gi5WM
	edxik8LTtKVF2aLYwHm8dOxD6vD3Ai1PUYlP4yQ5c4gLfG1PGgTrX0+Bub6aULg+
	H1qhH6Hx5uXSFmQkNr3Wvi72uf0jwt+1GwuTC9Z3bfBTslnon3MLZQxt8f4G1CA7
	iF1T7dA5jwK1vIB8GXqyoPd9AM2q1j+r/Wj/VfMLvLA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duw7rq1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 11:56:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483BNB0E032650;
	Tue, 3 Sep 2024 11:56:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm8rw6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 11:56:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5ZY8VwBeY5dqxzqEx14XMZXb0b/E+5ZpsVuU0apcfNjh+r6vdrF1oaDQ1VVuj44tXqUWosuhe46qTELH17HL+UEXVuKILJBcNiwkCjHM2NrqGBSDBwEc3WkdoGw1An1PE9SZOTsHOLpkFtWZE61u7n71FYxX4m/xDZBWYKHNSxe2Ww4paN2WaRbD2Vv6HWd1rpxFfTCbD7idoI1ZKtbkKMJNiToq1pWy5AuuncMY9riZu0qNb/ZAImjzQ9wH1ntMBDRenmSERCdSTC8cmbupY9aWby+uHJ7XhfvTK25s6aFWCmVIPRFtCfUsY811fYLTcWLUCrLbG9JOGYFMB8QCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtPmHdRYmvjNkooWIxgCF5gk39o9hZBWkAdxdU8CF4o=;
 b=Zckh1qf7Aiuk0LT4/N/bWE/uykO3BjxMbfvxNyunslJ6Sca9/fU/AwIvg/LYzZJKNr3trWyNtfZNunG2JPhqAFkNDi9byL8ZhNxjpJP194KXlj1UPcNhFK5+Qng7wz/TW20ZRmqxSctro892iGzcVj9TiNh6rSe5Nfz8Y1MMvv/kTGiG0feivjvA2ZthD8tzGuNNcQ7D9IQBvQ5g4yYmeBlL59q54RHnLo2fa6cuvi4oinFleLyMntMpnC1NTi16XYMbUftKPCr8xV9bOHsIPo19lYDsLOQPfFAVtVIfn2M5Ja3IZ5P20O9npw+3Imcij6Lf02deBJjmfb4XNj2E4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtPmHdRYmvjNkooWIxgCF5gk39o9hZBWkAdxdU8CF4o=;
 b=nfp9eSvgT+6tFyhnatOKnvIq2gBxKd1XbwN5mXt0onLRExqKbqq4gtWd8C0wxg1WftWQuSGmSE3rIlrOdsUJQvilrWsMqAQrv+kSbZzUZFB2Hf53ByxViVulv4lfwLA7SkqXfu/YaaIIwww+G0roVuODfsBmNQYdglG/4jDrUFk=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by BN0PR10MB4855.namprd10.prod.outlook.com (2603:10b6:408:122::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Tue, 3 Sep
 2024 11:56:17 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.7939.010; Tue, 3 Sep 2024
 11:56:17 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in
 udp_lib_get_port().
Thread-Topic: CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in
 udp_lib_get_port().
Thread-Index: AQHa/fhI0gbVTRlQ3kG6Pkm54NsdRw==
Date: Tue, 3 Sep 2024 11:56:17 +0000
Message-ID: <0ab22253fec2b0e65a95a22ceff799f39a2eaa0a.camel@oracle.com>
In-Reply-To: <2024072924-CVE-2024-41041-ae0c@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|BN0PR10MB4855:EE_
x-ms-office365-filtering-correlation-id: 4418da39-f517-426d-8272-08dccc0f6b67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WjdaVURZL0NSNWhkYm5Gc3dMQWZVNGVZY3E0bmYvNU8vQWNlUjJKYVIrdHlD?=
 =?utf-8?B?Z1BRZ3J2ei9jRnNpNGdkdDQ0bTY0MG1RZUVMdmxoRGwxcjVJYkQ2WEJSOVBj?=
 =?utf-8?B?VXE4ZnVCZzZPWkFVT0NGU2hIN0FGQ0hPYWNOZ2RTYzUwTkJwS1R3ZnhiN1JS?=
 =?utf-8?B?VDhZclQ2TTk0a3pFR3c3anhKdGhQVmEzMU12VFdWTGViMnJsZ0NVNlZhcWNv?=
 =?utf-8?B?YVVqZkgrVWxJeWRtZXZmTkxneWdzSUd3OUo2Um4ycUNrVXFWQlVSeGZrRGRl?=
 =?utf-8?B?YXFPVDQ1YVgwck0xeUxOUzRpb1JVZE1BR1l4ZzFzRmZWWUt0a0c2NFRjM3Ba?=
 =?utf-8?B?VEZGeXRRZ1FRWHc2S3lKd3ZweE1OTU9GVVdhYW1RQXVTUHZzRlh6RHo5SW1S?=
 =?utf-8?B?YmRadWtJb3g3MkZDUEFuSFIyNlNUOHAxQ1ZFV0pHai9COTVvMDE1S2U2alFL?=
 =?utf-8?B?bHlCVi9UY09OaUlQWHU2TW1MZjZCaWJRL1BsQ0c0K3R4NWNvUXRZRGRKYVVJ?=
 =?utf-8?B?a0VsL1F4UU9zYi9QYjQ5MytsSGRhVjV0RjVzYWtWTGpEaVRQa1ZHUHROekVS?=
 =?utf-8?B?V3FTbjFnZXIyQkE3NHVERGdneDU0bzA2d2hFSzBRVUg5UHJsTlhtVEF6MDRE?=
 =?utf-8?B?WFBOOUVWU24yODU5bUtzdnFNQSs0OUZia3Z2SXh3TnducXg1MDJ2Z05uUUtI?=
 =?utf-8?B?TmV6VXBzbW1ZNVh2aFcyMXVLajBCdEIwNzFLU21mcHB2WmhDS2xlcDJORFdJ?=
 =?utf-8?B?ZkthNlowRllWUk1OVVcvRmwvWHJJU2ZETUZlZEVEQ0xuUWN4WWVTYUlTeXZ6?=
 =?utf-8?B?QmE0WHVEc3VGMXhxOFoxZ0Z0TXF0NXRZY25jKzkrdHI2YVB2V1ZMcnZRejRn?=
 =?utf-8?B?bzVDb1hkVE45SjNCK1pGMVJkdWlZb2tFanBJQUZURFhkL1ZTUDAyNjZjUWIv?=
 =?utf-8?B?bGg3T29GVFhzcUZLVXNCbzNESkt0ZVF6VnlGTmdDVHNIbnkzV1JXTHhQQXpI?=
 =?utf-8?B?MkdyVExzdmhYQmdRWTZETWNjWlZrUjU2NmgxWGZ3aVlYZ3ZybnJVR0ZUM3N1?=
 =?utf-8?B?S1lTaTllSEhFd0RyME5KSVovUVdCdWRobDBwamhHSmExZTRJMWFVSVVHc2Jq?=
 =?utf-8?B?RVhiZk51MmJHU1cvRlpOcmZDSjdoRTdmeDRrNHJMRndxbDdXL0JlRHNVbzBn?=
 =?utf-8?B?ZDFzelM5WjhEME40b0NHZ0tzcU4wRVZIa3RPcHZjaUJPazUvelBxTmdxcndp?=
 =?utf-8?B?Y1htdmNid1RBQnlHTFBHMERkSG96d0tOK1NRbEFscmRiR29PbUNCUi9ONW5h?=
 =?utf-8?B?M3R6SEQyVDZnUWNuRll1SmY2VVFNRzMzS1hvQVRvR3o3TDB3eFFvMXZxdEdH?=
 =?utf-8?B?U3pPWHJXb0ZDQ3RqdTljQ1JhbTNKb1h0NnovVUlxNDA5VlBJNFhNS1NySDFF?=
 =?utf-8?B?cjlnT3JUbnNnRGlQSVN5bTdDKzZ1dGtJem1QMlFWMWxNcEcrMXV0SHpWdHQv?=
 =?utf-8?B?VTZITFJ2dFRVTkdKTVlUREQvMTZCVWduMW9xTDFmZTlXcXRMSFVsdmU0eEFL?=
 =?utf-8?B?cWdMYkwrZmlJSldGZHZUdVplRnR1N1dFRThBS1hIM2lDbStHeGtFU09qcGtW?=
 =?utf-8?B?VnNId2N6Ky9HakNkclNLK21QMWxOZHl2R0FFdk41ajg1ZVJBdWNHaUFzVVor?=
 =?utf-8?B?NElFYkdJdkRqSDBrWTRSL3c3dU10OEpYcFNiRGJDTWdYMmNsQ0VIRElFS3dl?=
 =?utf-8?B?N1E5L09acFNLK1lnc2NYWUgwTUF4R0JWTjhqRHJYeXhUZUhXTTlBbkNGZm5Y?=
 =?utf-8?B?NXlacG9hWWpnQ0VYOHpOdE5ST1VLbzJuU1VjVVdjSGhUVHlwNVNFeUs5TjJ1?=
 =?utf-8?B?ckh0ejg5WUxPUDVEU09kbDNUblFZMkdnVm5mZkgzTzE0d0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUVOUGNUcGpHLzVkemdkRDE5YTlkL25RdDl4VmFnQW5XNGRCR1NlakxlQjE5?=
 =?utf-8?B?ZVJOQ2FsVkJpUUtvMUNLSEVlMkFDN0pSMjUwYm5RS2VMU1htaFU2blkyemJR?=
 =?utf-8?B?M1RnZy9pamFQY3JkbXZxUlIxd2RBY3dyRWlIODFqNEhVeGltbjF1eW5yMDdr?=
 =?utf-8?B?Sm9qSWpuR0Q0ZnhPSVFmb2Rzc1g0TUkyWnVWWWFNTUUrK0QzU1ZjbkhmaW9K?=
 =?utf-8?B?V1lSUXl4ZlZTK2JJR0RLYWVZbW1NS1U5ZGVLMTE4TFdSTnB4WEJKTERYZ2wy?=
 =?utf-8?B?REoza3RlOHV2aXBTbk5CenB5c1RETjFVVVlyK3NjeC9USDZsalcxK3BVWlMx?=
 =?utf-8?B?dWxUcmtLUmg2bGlXa3hFZXFpYy9PdnAwTkE2d2h2cXVNMitOZTMrWnZwME9U?=
 =?utf-8?B?UnE4RkdnLzRzRElwV3poejlsaXZldGtoWXFtdTJQQW5NMFpaYVY4NVRrU2po?=
 =?utf-8?B?bFpxSm5GeGRmazhVZGNGaUJKcjlhVEwzRXU2a3FKbjRzWTRWeHlkTzBZTmtv?=
 =?utf-8?B?VGNHSDJETXlsdVM5UU5SNVB6Qlh3REhDL2VuYkhjOVJxY05qdDl3cThobnJ2?=
 =?utf-8?B?NVpPSGJoWDdjYVRCRGRMM296aVdCZUdhUG81aURCbVB2M1NTM2Nrb2N2SWYz?=
 =?utf-8?B?YnVwdUNudTlnRU51clZIZm5rY3ppWXFVZERxZWNmTjNlalFDeUhHbXVuZnVw?=
 =?utf-8?B?N0FmK2VJaG1HcmZVVlNSUVYrSWdocVJ2eXh1TEk0dVlFWm80OFRzUUFaeGg2?=
 =?utf-8?B?eGQrMzNnK2swQXhMS1dqNzgrYUpUTTMwUXpSMlhZWEZWYVRXSTZHdU1rajVz?=
 =?utf-8?B?Sms5S29zNkh1SS9ud0dlS3RmRVNBbVVMYllXQTZCMXNnTFJOMkN3MkxHVkVJ?=
 =?utf-8?B?UVYva1JlcTV6Q2QxWXFpRUVta0RHS09UQ3dWdFRyV01CWkNxT09Tcm5ybThy?=
 =?utf-8?B?dEpzVHVFdXhvOUNObmtFTmErdDJHUFQ4QTZub3I2M3M2TzRxSDR1cHk0OFFC?=
 =?utf-8?B?eWR5WFBOOFJlUTJRMzE0MnhhL1UxQ2djWmZPeElxVzMweHRtdXZYT1Fwa3RH?=
 =?utf-8?B?NXBUOTViWDNTT0lqYWJXQ0ZTeC84MUY5ZmJsRVpXSzJtL2t6SXBpVFg0SGQw?=
 =?utf-8?B?RlJld2l6NzdTbmdhNXlBSzN3RHdoL21wQVNmNCtLczB6WXdtdG0wZzJJSFVy?=
 =?utf-8?B?T3pZVnA1MjhhME5LUm5oWXplYmNxemg1bmRUVHIrZVFpNGUxZWl2b0tFSkxG?=
 =?utf-8?B?bkdZMUhHaWpYWjJ3MXp4UGdJRElmSXVMOWNoYjFuY0dRT1VsV0Y5RDZlQmhk?=
 =?utf-8?B?NnV2RExHRDM4bGV4dVBuRDNxditZaVVlUG4vTnEwUkcyL0FvbzNqb2VnSWVi?=
 =?utf-8?B?RWx6clB1QW5MRjIwalZlcEZBTEpJK3ltWWZHcyt0QlQ2emJud0d4YVMwc0Ix?=
 =?utf-8?B?ME1iWWRnOVNQU1hmbmtiWUxzbGE3NHovZTlYc29vN3JpTFFxZXJhRVlnMVR0?=
 =?utf-8?B?aWZCR0hwd0xsVlVyb2JXa3R1czlvZHJIYm8wZUREbXRNZUtieDdzUllGSUph?=
 =?utf-8?B?aHR2VmhkK1g2ampzTUZvcTRzSStHQzZSNzRMZTlEZEdodWVqUVo5TlZQdVhG?=
 =?utf-8?B?L09FYVJxZVNJYUV0THJ5TEx4K3RrNWpIUGtVUk1uOEcyREhJMlR4SnBDQmFM?=
 =?utf-8?B?UURyUzZnTFBOM3g1SmRQMTRNMkg4b3cyUW1HVmN0OFRqaUd6ZWxwL2tIWERk?=
 =?utf-8?B?M3ZRWTl0cVBBRjdSRGpEMlZJNVUzeHorN3pRdi9EakVoVzMvVHI1czU5eWEy?=
 =?utf-8?B?eFo2K2VYRDRvQ0grbHZWampQK1NNRnp0WjA3NzVYSUZ4TnFvenQxL1JTV2ds?=
 =?utf-8?B?clFDK3lPRVhlN2FDeS91Z2hUZXN2czZxMTZpYktZUUN1SElLRW9GOUh1bnc5?=
 =?utf-8?B?dGRSQ2I2TkNvYld4RW5nL2M1OWJjME9CRmVGS3dkcUQ1ZERMcEJHcGtUbk5j?=
 =?utf-8?B?UmdsUElIZEExcGZoTERYa0dvVUE1MGVNb215L3hiZUdvZ0lkYnhmNmF6V3Bx?=
 =?utf-8?B?ZklwSklkSHNFcjJCTHdPd1daYXJXY0hadXNob3lQaUFDV3l6K0hYeEl2Ti8v?=
 =?utf-8?B?a1VoOFN5RWZZN0dpdFZCUlhDQmE1RUJaSFpUWlJMVjFsMXJHUGluWkxxSHBB?=
 =?utf-8?Q?9W18mHjCj5sz796+NTajJPOIMhA8E0J744LLYhhcHAXh?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Hr2YRQ6916y2vnbjmYPE"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8+t7MlBwiII6pWEZ8hIAvY175/YbBIq3ojqH3Oj46uQ53oUK1az3WYvdBdAxqrqeuWSqkzGjvFBfZvRLlPEgdG3dTZ9dWkNexRHgWb+s/G9wxzhjVnCgpOC8E3CpQagYYyEnVU2OjdLWy1OiyRPHRO2Hu3ZvIyxGRv3P7D+NQO4wT+xbJoWhz00kePFIkwvw6zFx6U2VufopzErvpTamUcHO235VPnVHkfZwdF2WGm9M2VUgvLsHu9AAMQU6aB+57tiAQcqx4sPaN3IGJ3rc6W19gshQqbsbIfh0iEaZvHBoKga+YIfYjoq0DVrlfelRMpbZdxwrcB2u5JO1bFJrhI/7SJIpjMAS1vuapfPW7catbJ6tCWvv+wcjn5owAs+QB6jCylNy4JYf1/HaVtowlL68q59PluRmg+npGE6/b9YDxQe8JmdVse6OxBMgQZRDx1LGtPvdcxfTH7jfiFGWdGTAQN16uTGuY8wteYTazWMJI1dnrju0kf1HEDopU8gBi4gl1/V9PfOl3N5c42R5sLvXEOkNf50UayI/cdTDW2H8Gkz1xKo+D8hTvfp2voYF5l9qd4W2CBIPa5AkB9GXJUk1gqfoE7MIFPtfrCsOKHI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4418da39-f517-426d-8272-08dccc0f6b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 11:56:17.7800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTFjY2toqsJY6o58aE5nuvLnrDU7IFmkl1rCGIJT3u8uHVSm/I+bIBObLEm7BkLvRXQeUjWwPIY9N/z/48C+ZrNZMMz5GCavn1K17qtCiiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409030096
X-Proofpoint-GUID: PBcsrd1bvctLQarplsfaV0zWI6xOXgfG
X-Proofpoint-ORIG-GUID: PBcsrd1bvctLQarplsfaV0zWI6xOXgfG

--=-Hr2YRQ6916y2vnbjmYPE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jul 2024 16:32:36 +0200, Greg Kroah-Hartman wrote:
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
>=20
> [...]
>=20
> We had the same bug in TCP and fixed it in commit 871019b22d1b ("net:
> set SOCK_RCU_FREE before inserting socket into hashtable").
>=20
> Let's apply the same fix for UDP.
>=20
> [...]
>=20
> The Linux kernel CVE team has assigned CVE-2024-41041 to this issue.
>=20
>=20
> Affected and fixed versions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>=20
> 	Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.4.280 w=
ith commit 7a67c4e47626
> 	Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.10.222 =
with commit 9f965684c57c

These versions don't have the TCP fix backported. Please do so.

Thanks,
Siddh

--=-Hr2YRQ6916y2vnbjmYPE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmbW+VcACgkQBwq/MEwk
8ip4Vw//VrCgo+xWejnzBuBhAT+na6JLyy+MklZVa7oxCT/902M7e570SRDhq94k
nkQ0njAq+Pobe9FDNlHRBiygmLY3YObnnjDDDFZD4RNBtbfqPbGjnWn+6CyuXTAX
YyywsTb0bDU9Y3ZTd9VPEGmO2D9GGM72SGn+vXnrHw3+CoR3Rfn79HAh2pX+QAZE
kKwthCCp+RIZ3yj3Nie2kNswTVpu4P7vYlAgdwLQnK5NIg677mjLtMIO940w7wWy
ULixUP01xxSANEe9oLRNyjeX8KuBfSSqxbfcRn9HkMNFWH+insGK5Wso/C5BfoS2
cor2BCbNlCBF+fpi2OveOCoFaVHeyTys8sNGL/iYjUkr0YBsh+0UhOiLX9QRIG8p
96sCFYzqPTdnWyM4RhbrZ4dNDi4c0f+EbTynHBV/B0PAr4bEl+qZvof6C4rh3twI
ZC2Nfkr9ykLFEPJxSSpEiIiuATP7Pg195T3txB0N0KHyEw3qI3mzsSWX8fE+pxwq
Yi9Lj0I5WDg5Ibii/73eWOC5oYOBGfA41e2ZC2ixUNAboHMnDF789jEI3AvJ9K55
pM3fjAGglHWh54EDf0fw11mm/PRzS9h2YMv9RTHJj/OaNSwMfBXkjrI2pZeL0C0+
DSK3qbTraA9/1etv1i5oPfYc5vLI+V5TcESLPLjwMfrCpBywAXk=
=qsRd
-----END PGP SIGNATURE-----

--=-Hr2YRQ6916y2vnbjmYPE--

