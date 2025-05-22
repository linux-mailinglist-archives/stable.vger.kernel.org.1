Return-Path: <stable+bounces-146045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F2AAC060C
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800091BA091D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 07:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F49C2236F0;
	Thu, 22 May 2025 07:47:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B962236FA
	for <stable@vger.kernel.org>; Thu, 22 May 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900074; cv=fail; b=DTnzSzQtzhzZoXHFO3JIsHzZ9z7w5Co1zuCOgnnsLM1BPmirOl60fRl/1cTj8XdXVpPIU96nuGyZf0emtc3wXfr+wpvNe9SG0nNO3YvIYLXfHsjWXyGZsWtTldH/4ngcX1zDVGlh82ObhXo9gXpBCC5trXMfNkVn4Iv19k0/rLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900074; c=relaxed/simple;
	bh=aKr7rFUF7Madg2MCLKjXJhHPhzW+1dzqUp+omBrFYko=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UpcV34K08cQncDsSWyfVz+s9DyStISzm6LnVw7Ux3ti4B+YbkNogVeuCp9aL3At+fEb7v0PFmnoXxVJfJlAo/RFI7tflTIcd89wIU8rxOP4NOdEwDz9R+XkoyJRcZuY3Lh604OrjsXHzY9BblridYhNRN9eNj0LF0GN+yct2UPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M4vPqP001003;
	Thu, 22 May 2025 07:47:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfx29dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 07:47:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLT8wA9qyi+cV1qo6ylluU2LJaHv1PokSE6wYB0ZtIFiK1xMjLiMyeEj0VX2bGWQwZO4Ccj5PZvWx1LrKE7Dtx62qOB+Xc4Ai3z6H4g+uDb3yNHckPFHiS8INdlF9/pMU4CYBxwOOUlm0QeRr1LwIKsK/pk4ksb+YJNWdTv1ZcE63+qQyy+i0F7Q6GuRziQhjF2opZvsVCzj4l/Hti7Lj0HBl2CzZ9TbNtF2mEF68KRSmjxsvJUrdTN58ma7AQEhiMq/pp/BDmfUPiPNnegGscBoUFfv3+LahIioN4Cc/2Yh18NE9VeKlsZCdd+fq5uTOZTZVjj676cV/T3GsqJBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuqFSt8raOorCmkg4E7lANW1S/drbkDS8fpT9jI8kkU=;
 b=qvyYUQXee5JTxeMsOvfcPx8+p91q5PGLPrqZIgMGBiDzgw//vQnxlg6lQjJMDgwY7GFwTwREf2vvHHDlgJheYITLPB6MueBRerZDtBRLam1R9aSPrHdQY5Da7WsqOavYO3MDMB/YLNHWJB2aeunN0zjXBM3uctWsxH/dfAqdlSyItLvIrRM/sSiRpA0pe4PZ1Z64rFNvI4ZQIMYuDNjMLG+pln4zZUoXqKS9sSgAAMoKFGEqpeNfRKgZi4gdrhrCgFH/KV/FD0YCs2TVbwPCRLMRx2qyTMBtGMzUbOePtSr7re2uhuFHLFkXV8m4v9wvMrcuZf0GGzNxrxRTESZgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Thu, 22 May
 2025 07:47:39 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%3]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 07:47:39 +0000
Message-ID: <12aa9d7d-1ff5-4f68-af8f-adb4eef50519@windriver.com>
Date: Thu, 22 May 2025 15:44:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y/5.15.y] ELF: fix kernel.randomize_va_space double
 read
From: He Zhe <zhe.he@windriver.com>
To: Greg KH <gregkh@linuxfoundation.org>, Feng Liu <Feng.Liu3@windriver.com>
Cc: adobriyan@gmail.com, kees@kernel.org, sashal@kernel.org,
        stable@vger.kernel.org
References: <20250509061415.435740-1-Feng.Liu3@windriver.com>
 <2025052021-freebee-clever-8fef@gregkh>
 <fc8f61c6-eb98-4102-bf81-a924df303efb@windriver.com>
Content-Language: en-US
In-Reply-To: <fc8f61c6-eb98-4102-bf81-a924df303efb@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0320.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::16) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|BN9PR11MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abc0585-ed62-4390-cfa0-08dd9904ed22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEw0SFVjeEhiSWdEaldMZmVoNHd0VEJGc3dTSFg1cWVsMTRSQlpLM0J0N0xK?=
 =?utf-8?B?RTlhbVBIUHFGUkFPSGNBV0FLV3ZpdmJVQklRaEpjendmaXNjOUNtRUd3OHFH?=
 =?utf-8?B?cnhDUExybk9HektBc3FsT2RkT1ZKRi9MTmpEc05YSXNvYVBxOXlBeE53UHhm?=
 =?utf-8?B?YWZTU1Rnc3VBNURacXo5Q0ZhemtjRzRYdldybFBmY2ViMnhsM1pwOXZWUWgz?=
 =?utf-8?B?QngycWJmcTQzZWUyZ0R0SllTdDBTem94NUJDSVd1WlRUYlMzbCtuaEVsUk01?=
 =?utf-8?B?a0dkakJrb2Y3L0RtQzJpb1ltTEU1MjRjLzBJc2lmM2pyWWRUSGtTSUpqemdR?=
 =?utf-8?B?N3k3VUdEQlV3SDluM3NxejlWNml1TWxIVXVTRFZSL3lmT1ZQQ2xYMVoyUHAy?=
 =?utf-8?B?SVJoY09uYjRmT1k0OU92TGM2MGVvZ0JCY0dVNnd1RlpOdjVzZ2tRLzJENWND?=
 =?utf-8?B?MUNwZUxFQnFaNC84YTlxR28zdUdkOFFHUDZyUFl0cjhVQjdaZGFqank5S2Nv?=
 =?utf-8?B?OU5IcFlDaEFDMTlKTWNNQ1pNMVR5YnU2VE55MG5wTk1OSWUyVDRic1c0a0ZY?=
 =?utf-8?B?c3lHTnRRdzdOWmF2c1dHSC9EQlQzUTZ6by90NlJFQzZ1eG5aeHozdllqVVRT?=
 =?utf-8?B?cEFncVljaDE5b1dCMTNiYWlQcFREUTlyUkFWUDE0bDNPODBZemdjYy9jTzYr?=
 =?utf-8?B?eXcwTzU4N2F3MkdVQlZPNStlNzJ1c2Q4WHBYR0RQbWthNmxMUGlHR0lLbURW?=
 =?utf-8?B?bmpmOW8ybWJSUlY3dTdjT2I5RGdTSkxPYlVKUEJCM0RmcFNXUTl1bzdoTE9v?=
 =?utf-8?B?MFVPUy8zQ1c5VWRGbnE0OTB4OGsrM2hlQnBnQkxHTWxRamZKSHRUMEpEdit6?=
 =?utf-8?B?OStXM3RDaU9iNS8vZG9qSGkxcVJZN3dINFhzTzlpRG9rZHZLOXVrUFZOV25y?=
 =?utf-8?B?bkFTWG5vSWhBc1dETE9YazVpTlVDQWIyTlZORmYvdmxseW5xc0dBZ2ZxejQz?=
 =?utf-8?B?RWc2WVBQRUhrQ2dBV0VmK0VtdWl5S0RMUzBZWi9NTm41VWptaHpvYWlnS2Rm?=
 =?utf-8?B?NklKMGgwUk1aU1crdE5icS91ckF2OUtNbWxGKzBWbGEwZWFzRnY0TENKTGtV?=
 =?utf-8?B?QjlyaTd6aU13dVh5UXgrNjVNMHNKUWFoUnA1UTZJWkZ4eVRHQ21hOS8yMUF5?=
 =?utf-8?B?WVpoNkwyOVZ3OTlLVTZ4bEpzeW9KM2hxQ1Y1SmRhUk5PWkJtYWVNanJ3SE5Z?=
 =?utf-8?B?Nm9vNm44ZGRrNVR3SFQ2SE82TGYreWZVR3lULzdyU2dpa2xsN0VuZk81SUJq?=
 =?utf-8?B?bDduT0JPYkdhdUNWZmR4Q2RMSlZ2Z3lrSGxNc1FnQldUUFBMcGN2M3hLUUZw?=
 =?utf-8?B?SVdjZGxaQzhTSkY4WE1reDF6b0QxNk1zVmFDUzYzVnpYWDg2NEh4d2FZYTFW?=
 =?utf-8?B?SEpIL0RLYngzbUNGdDErcVUrRzJkVWxpeVZ4RXpsZ3J5dFN1NDNHKyt0T3JI?=
 =?utf-8?B?QUJvRFE1bVZMUWJtREdISm1WZkxqcTlzWnovckZhSllhK2FTbTVqWlo5Znlr?=
 =?utf-8?B?ZDRlQ1V5VkNsaVphSmFQeGg2WFlMYTZacm1rZlNZT0RiZEZNK3hqRTg3bHJI?=
 =?utf-8?B?S3IvMVg0YWl2VUdJRWgvSXBuR2lhbHhibkUvY2lvamRqdTE0WWJQRGJqYkxy?=
 =?utf-8?B?MWp2cC9wRUYzS1lvUXp3ME15Q0xldytPSTlLZ25McWJEQWlZVURhTGk4V0Yz?=
 =?utf-8?B?K1RBWFdKRVlhOFlWeW5zb1JtMzZneXRBOUEzZDZrVERvcUpSWTdiTmROdGRS?=
 =?utf-8?B?SGtvVGo0WXIvQS9LR2o2cUw3UWVUTjlMQWtZOFdnelhXR1pXUFZuR3BFK1ZY?=
 =?utf-8?Q?id0r3TFX1E+fC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dy9hYlVSQ0FEclNHTkFTN040QnBJenljcGs2Q2p3dUMxSkxCZGZ0MEo2eHlv?=
 =?utf-8?B?SSsvWVFBK2ZKSk5LbDlqcDVKbXRsQWY3SndLUFJKUEFwMk02OVYzWVE0VEZ6?=
 =?utf-8?B?dWxEZzBNV20xLzhQVlFTTElkVUhNZFdqMFdGV2VkeWh0S3lSODAwMEI4ZlBO?=
 =?utf-8?B?ZGpCemd5bUdQNytnVUNhc1VPNnpUczU2OE9wZ2NVU0cwZUlVTWVUOTlGVlFX?=
 =?utf-8?B?UjBDbFdXWUMxdVdFams4M3NZNnV3SUF6N2hzTlRoUldTN0k1Sk8yeWlDTXlq?=
 =?utf-8?B?K3hvdDZLWUZHcFduZ3lFclIxNjdnKzB6a2NqNnZOK1BSOThiWXB1aktXRXRC?=
 =?utf-8?B?WmZiK0hJQ1A5NXJhcklRUVdLNmx4Y25oY1VuZ0lDb2JkdDFIWGRhbkx4R3FW?=
 =?utf-8?B?OEhlRVFoclpVczJXT3p2bnVSczUxd3pFbmdqak43QjVLbGxNQ0lxd1dWSkZV?=
 =?utf-8?B?MStZR1cwSEtlNWxYUXVUMUZHTUhITXJlUHlHc0wvbkE1SXZUNnVQUXhFZTRx?=
 =?utf-8?B?RnRCeVhhRW1MUXJOeEVicVFWNlRtRGlyMWJ3aDZYRnhacXVJajdNWjVkVnFV?=
 =?utf-8?B?ZXh5ekxLS3RYQm0vVTd5VFFpa0VHL2VsL29RdFhmckpiU3JIZ0llbkoyZTRx?=
 =?utf-8?B?dTl1bkRKYlNhcXhpMDBUYVVQQTdDV0d1bU0wUGRBaGJvOXpUMkVyUE5KVUNL?=
 =?utf-8?B?RkNRL3J0V0JKdTdmN0QzM3BLQWRYMUFPVWFuZmF1VmtCZEJDak1kM3N6UFR3?=
 =?utf-8?B?OTExZk1IYWJ4cW5wWElYdmh4TGtINjZoOXdSck16SXlIVWEvUk1RMnUvNE9y?=
 =?utf-8?B?THdHQ0JkY21zNm5SYlBvNGsyd3JocThVdXlHSnV0R0RybXR6N2tGeGlkdUVD?=
 =?utf-8?B?eXM2TG10cVRDQXdRMzE3b20zK0lSZWM0dHRCWkdKL1NOVnBET2l2UTFYdGIw?=
 =?utf-8?B?SU5CZkFXSi96eGlEYkdEaWM3L1JlQUE1c1VxVy9VTVdZWk1xWnB2U2owaXNQ?=
 =?utf-8?B?RUE3a2VnbXlwanFvWlJ1aHFhVVBueTdvK2crTm5aZ25HQW9qSTNZRE5JZ3ZQ?=
 =?utf-8?B?RE9URHNZMkFyWnRJTFlUVWpPRThKOXFkTVEzc09nRVd1cXlZbll2MXlOYTQ4?=
 =?utf-8?B?L0dyRU84OXhzbUhyZWlVV0o2YzF1RkZnR2U2L3B0OGpJQUkrdFJ4MDdxMzUw?=
 =?utf-8?B?MjZod1pGL1R4MU9SOWtveEdIZnNpREk3UVhKeGRGdjFRYkJlWGRBcjlMZ2pj?=
 =?utf-8?B?a1FWb0h6N2dnNWxCckZWYStMM25YRUw0QklrdGhnOEZraVEyU0dYUW5IZUtZ?=
 =?utf-8?B?UDlIcXRuaEs4VGh1Ym9Pc29DcW03NWxuVEhwbkw5cXB1NHVPV0YvVjBhcXFr?=
 =?utf-8?B?RmhYZEVVaFBOZk83K1JvTHJTdzlrQjRqWkJQR0lGcmVOQzFyMTlPQnRKUDRn?=
 =?utf-8?B?MnNIZFdXMW5TdlJuL3ZidU9CdWNESnhxc3E2WXBRMGhlZ2QxRlFpRElMUjNU?=
 =?utf-8?B?cHJ6NHU1NVNuNFMvaGdZbTBpZllYWVNhdTVNWTFsQXd3eTQ0V3FYK09zaU5o?=
 =?utf-8?B?S01Ed1U2WlJTb3lKQ3Q3MzFwbVlWVmNSZmVJZlREajl4NTk0NVVmbS9LaTdY?=
 =?utf-8?B?UW9hajF0MmZiRm1nRlpFUlljOGhQdVRZeStZMWZaSlhvWDZSS253ZkllRHJX?=
 =?utf-8?B?cTQ2WUxSQVpSd09URGlPUWhGdS9oQmxGcjROUmZJSjhSZy9aZ0tLSGNxOGt4?=
 =?utf-8?B?SGM3Rzl5U1RXVkhFeGM2TkdhZXdCK3pUQjlTZ0NLb3AxTVlTc2JESkF6dUlv?=
 =?utf-8?B?Y3VMRVFaTlI2N3lBOStJNG9kMDUydURNVlFEQmxjeTVpSlpMYXBDM1BseHBJ?=
 =?utf-8?B?Q2ZmN0FEMWp0c3B2RThJTXRwVW51aE11UmRSZVpNYkJZd2U4OUtYcmRsTFFS?=
 =?utf-8?B?bEprQ0pPRlBEb3dPWU5VbzZJUk1rNURyc1BkN3FFc3hEeUloNU9CalNVdCty?=
 =?utf-8?B?dkd3N2s3RnVIWHNkekM2cmVpYUw0UVY2V2NWR1h1UDBxR1JGWUt0UVZIaU9M?=
 =?utf-8?B?OUZMSnR4bisrWmFmMlNRd2wyYnExTitKb0FvcnA4ME9qQTlNUTZQVzc3T28r?=
 =?utf-8?Q?H6GPyqsSsQ+f4SxKFpRWu1VHN?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abc0585-ed62-4390-cfa0-08dd9904ed22
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:47:39.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Vx3ZuKl1Gef5UpxgIqwLS1EDuFRaue9/8NQOiTWEJ+/1Z4i4zp6qbPSiTKSs5GLjY7YHHW98lWw9tvbHmh5Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-Authority-Analysis: v=2.4 cv=ObSYDgTY c=1 sm=1 tr=0 ts=682ed69e cx=c_pps a=+kc2f53xTGsvuL7uaCOpcA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=5KvsnA81VrHTjm-qQ4wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA3NyBTYWx0ZWRfX4X7RhOJHMJAX Dtyr3fUtD2sfuQVfLsNJv1IkcE+c0EU79mMOYEJgqI/y1WtqKuXhcKl5VaUa5lQlpwH+FF91sj0 RQgxJPPIqYzvfvBxLGQkN/kRtG6ITAiDZAss6AtjjtGsIOvVv3p9aZW0amDnBg4tMFARN7KQFtu
 +qug2pq3xthn+1cQBrr3CIVvHapJc9DXI1SBWCAmG3RFeS3aj2LrqyON3QBAXVR3QAUYtPl0m55 4SCXtL+DjJF0jvopuS363s0Xt4jt7QY2GyIhnirffRBb6nIcvjJfTj6sQ4QF5AiHAwb2Oi6QSFs YJ/F+IBU1MnElCq8NaplZGhVe2WtPGVIk2VJVHWQonZo/3XTB7ado631hBXCLTyA2ofiuDmm/Ln
 RmWSmpbi/aaVb28caBh+lJ+wjYMtkUZQssnsQtHd86lPN6ExNoIi5672+DmAcfn6eKoXl4Hx
X-Proofpoint-GUID: 6-q75FVPclLT7MTmg-ej4KGtS1IxLEd6
X-Proofpoint-ORIG-GUID: 6-q75FVPclLT7MTmg-ej4KGtS1IxLEd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505220077



On 2025/5/22 15:40, He Zhe wrote:
>
> On 2025/5/20 19:25, Greg KH wrote:
>> On Fri, May 09, 2025 at 02:14:15PM +0800, Feng Liu wrote:
>>> From: Alexey Dobriyan <adobriyan@gmail.com>
>>>
>>> [ Upstream commit 2a97388a807b6ab5538aa8f8537b2463c6988bd2 ]
>>>
>>> ELF loader uses "randomize_va_space" twice. It is sysctl and can change
>>> at any moment, so 2 loads could see 2 different values in theory with
>>> unpredictable consequences.
>>>
>>> Issue exactly one load for consistent value across one exec.
>>>
>>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>>> Link: https://lore.kernel.org/r/3329905c-7eb8-400a-8f0a-d87cff979b5b@p183
>>> Signed-off-by: Kees Cook <kees@kernel.org>
>>> Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
>>> Signed-off-by: He Zhe <Zhe.He@windriver.com>
>>> ---
>>> Verified the build test.
>> No you did not!  This breaks the build.
>>
>> This is really really annoying as it breaks the workflow on our side
>> when you submit code that does not work at all.
>>
>> Please go and retest all of the outstanding commits that you all have
>> submitted and fix them up and resend them.  I'm dropping all of the rest
>> of them from my pending queue as this shows a total lack of testing
>> happening which implies that I can't trust any of these at all.
>>
>> And I want you all to prove that you have actually tested the code, not
>> just this bland "Verified the build test" which is a _very_ low bar,
>> that is not even happening here at all :(
> Sorry for any inconvenience.
>
> We did do some build test on Ubuntu22.04 with the default GCC 11.4.0 and
> defconfig on an x86_64 machine against the latest linux-stable before sending
> the patch out. And we just redid the build test and caught below warning that
> we missed before:
>
> ../fs/binfmt_elf.c: In function ‘load_elf_binary’:
> ../fs/binfmt_elf.c:1011:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>  1011 |         const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
>       |   
>
> Just to be clear, is this the issue that breaks the build from your side?
>
> We just used the default config and didn't manually enable -WERROR which is
> disabled by default for 5.10 and 5.15. After searching around we feel that
> we should have enabled it as suggested by
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b9080ba4a6ec56447f263082825a4fddb873316b
> even for 5.10 and 5.15, so that such case wouldn't go unnoticed.

BTW, such case is also missed by our backport helper bot
https://lore.kernel.org/all/20250511221746-17a0e7ea300c9d83@stable.kernel.org/

Regards,
Zhe

>
> And as you mentioned in another thread, we will definitely enlarge the test
> coverage and provide more details, for example:
>
> Machine: x86_64
> OS: Ubuntu24.04, Ubuntu22.04, ...
> GCC: 11.04, ...
> Tree: https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/,
> Branch: linux-6.12.y, ...
> Commands: make allyesconfig, make bzImage, ...
>
> for the first step and then introduce some automation and provide public link
> containing more details.
>
>
> Thanks,
> Zhe
>
>> greg k-h


