Return-Path: <stable+bounces-200448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45BCAF6DA
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 10:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A21304D0ED
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9423B609;
	Tue,  9 Dec 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tvVpN8sb"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD31991CB
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271914; cv=fail; b=XscuwIR1cWUftrWitCNaChNHf0VuFZUmpKir9t3vOW+uS5lTCq7HLiVkbCG4VCU0M5EReAeofR8wFJO1NoVy4vCX4umZYo4/WL7q4iIa/y2hmrIQSHj9YaRTLXujY1PZYjktTQXHxZj1kN1SkQkmbHigrRUeZDEyoo3TllD1hxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271914; c=relaxed/simple;
	bh=6IEWVrfXO2nuIl/ExUN9SG8KvneghoEvOelbbynG3GY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GyjOJo2AP4OmFC1JdH+7+XYhzLWd6WUkFyL0cVrwyxgw3nNLu2TZKb+/gXgEPAVQeyeTnnLo+tf5wafV24NkVsISSLuMjKy2+TJ8L62oLoDeXRJGzUaQ4Hipske8bUyVknL0GecRaUOkOzMpA8M7CdjQdAXDRd/2Ew8b652+PX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tvVpN8sb; arc=fail smtp.client-ip=40.93.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayZ5WEqOjl54mWorHweHl12JgpSD09eGuAG24kRiEmSfol39+QAcpDHV+QsARdOibx2x8k001TrkKRmd1aWouUPJ8ajwqWp4aNlUX/a6jVfyUV56tD5WOX/WwHUK89Kb39ar1xlOYJY3DKf+f5VKhvneTG2YuZDzaxVVgFYX8OObCJMnqMtB8OsX4ixEm7a4hIteoDwJ2tlRLApQRjnrdVrvK5lCrl4W+QWi9G6Ks7auHktRAeUD9AL6h9L13NKdH2PP2QrYeB2GPbUzrnnA/5QVX+fWS22PpmAWftLNgo5lhMuaAighSk2tlqNv5+RAJGtyxsWZVwOvbya6tTmHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/xHEDHAGX3MHnPWk1XSJCnokNAwCggsV6N1VSVJtX8=;
 b=YN2qO5TFCiQ+c2SGOIOtjmgI3mG4IkYrDN5QYybGqvNqrt4/EQph7ByW6eIvSmhT4Vfp6pHNDA70/fpHrGSuy1E96EMg8ky07OG6qLo0RtP6tt6SnDdMvniOwXr0gN183V82ejTBIYLevCu6I6TLhhN7Afnk6DwKNv6UxSz37uqg31X5dUR68ansoFelvFneCRh7uvk2O5rz5jMc2Spib21WOu0KiHfjlTrH+o992lAbTf2PrqGEqgwcCnsNMNVqsXw4QAv5KKvLAFmmao8YhLQrH6irlpviOiwTcs2JvexvI8gGJoaXeRJVUSP36UXc+Au56Kkduw57ihaNxigykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/xHEDHAGX3MHnPWk1XSJCnokNAwCggsV6N1VSVJtX8=;
 b=tvVpN8sb+vI3SP+55SZicBjPlj/egBQDUBxksoFeMCoAvg71bA02JJxVahLN49ojAvlbg77dppi2RvatpY6S5DaenFaHOCPq5/L4DXm4LScBC8f/7Nkn1DgdvrMtSD/mzb4xPwKN6HLf8u9tM2FP+SWcUcOtqweWotUot6yXhAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 09:18:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 09:18:29 +0000
Message-ID: <2e6ac0e4-8919-4ca3-a6d2-125ef329fbe8@amd.com>
Date: Tue, 9 Dec 2025 10:18:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] drm/amdgpu: Fix gfx9 update PTE mtype flag
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, stable@vger.kernel.org
References: <20251209012538.3882774-1-Philip.Yang@amd.com>
 <20251209012538.3882774-2-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251209012538.3882774-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 6567684c-b2b6-4d08-6413-08de3703eaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3o2ZGtmSXJ3NWZUZWYrdHNJWWRvb20xd2JHM2UyUkJKU0NVM2FXeGtpdlBo?=
 =?utf-8?B?S09LalY3aURERnc3UFQ1TFBSQW94cUhlMFpYcGZoZFRPcHhUQkU5ZmdkRmh4?=
 =?utf-8?B?VmM5U2ZESlFDaFVWZktCU01TYnZpTjBhVStBcEpLUVY2d1BHYVVpYUF4d29l?=
 =?utf-8?B?NlZZWW1vN1ZLcWRpK2xGeGNqcHI0VWJ4UkJsUUFlSnVqZTBnejVnUXhibTUz?=
 =?utf-8?B?ODVjTHhiUWpNMlRKUkVVdlBocVU2RkRUT3h1dlM0b1JDUjR5dWRKcmN5WUsw?=
 =?utf-8?B?SzVFSEg0d1JZSU44RUxURkYra2VteHVSUENXY2RaSlFTNUl0UlNoT1pJQjhu?=
 =?utf-8?B?ZUEwSHJReFBTR0ZDRDBJeTNjRkgzRHFoOXkyUmpTYnlLL0oyeko0QUt0dXRW?=
 =?utf-8?B?TU15R0lxcFlXZ1pWOUpSeWhZbjNQTmZydGtlZm5lUk1hWXNIN2syV1haNmUw?=
 =?utf-8?B?VTNiRXVmNmt3WUVxNU9wN2FPLzBLYXNaVkJDZWVPVlBtMmhBNWpSdHNzTm5m?=
 =?utf-8?B?UEZkMHFyYkVNNWdWZDNyZDFCMERMcU5Zc1FBZlJaM0F0TWJCSjF1d1ArRUZw?=
 =?utf-8?B?Wnd5aGtrOUhLS1ZrbkxUTXBJamlFdFlTVC9CMHd6WDNrRmVQYkdiNkJkSmZO?=
 =?utf-8?B?VjRyRTJRUjNaeVdudGFCRUlNS3RvZ1dETjFxcWxycjg2L0NmOG01TjVtUVli?=
 =?utf-8?B?a05idzZLZk0wbTJnR2N5R05JTnZtS0ZtNTVYSm5idjZSbU5LY282NThuSW1D?=
 =?utf-8?B?ZGZjOHpWL1dCcjNkVW1VL0EvVFRLaWhTdmdMd2w3b1dqRjc1VUROZkdPK0J3?=
 =?utf-8?B?YkRwUHFKZ1RFQnZIU0NZbnNmM0NmRWVuTnZ6aExyUWI3cDdSQmxTS1o2VEY2?=
 =?utf-8?B?cUxvU21tb09rWmVHaVNuN2dNdHZEVWcwaVJZN3BpcnpCWGJiLzI4RTBIR2dF?=
 =?utf-8?B?MmJCNkw2QkZEb3QzUWxSbTJEdUJEZ3ZuaTBGWXpvSkFDYjJhS1hXL0hTZUpq?=
 =?utf-8?B?NXB2aUQ4QnF6VjBLZ1QxaFpMTUNsSm5rOTRMRkFIKzhSR29YeTVTSExrYWxB?=
 =?utf-8?B?dDZoVnNSajZockxQWjZDSWg1blFhMVVpYnZzaXRjbkNlYXkwQkY3YVQ1WHpN?=
 =?utf-8?B?OUdBVTg2SDlnZ3BqRGwxMk9iS1VxcWR1cndWZXRsc2lmUUNhaStCd3lvdlRo?=
 =?utf-8?B?WXNLcVhXRkdOWmRxSkt0aG44cUdyekg5ZmJWSStSUnJVSkhxWksySGdPdU16?=
 =?utf-8?B?eE5MWm1HQ3oxR1FEQ0szRExGR21ZS1ZlckMzOEc2UnJ0bkFDMG1JaUkydHJV?=
 =?utf-8?B?QkZWSkR6UnZkY1pQbk9tNHVDeExHVDZBR0RGNUdDbFBoVzZWYW8rRXpoc1R0?=
 =?utf-8?B?V2Qzd0Z3Q3EvY1Foc2c2SmlUZHoyZmNOTlh6TXdMcDNwT25lUzllSU5neVR2?=
 =?utf-8?B?L1BYQmJPZXBJcG9HWU5jZmh3TEpUNVJtQ3BscWUwdEF5aG8vanh4aXJJeXVF?=
 =?utf-8?B?bDArMFlIV3lOMHlaL05NczJqcDhkNXVaOVB1UWd2bDd4YzAvTWJEUi9tbGR1?=
 =?utf-8?B?RXM4NWg0dUxEZXoySkdOVGNGZmtMV0ZTdGhFN1k5enNJSThaM0N6YWErcFJO?=
 =?utf-8?B?SmNScWZvU1l5WnJWUzJ2cVNrL3dPL3Z4U3lXUFhFcElWNit4VnFjQzdWVXhC?=
 =?utf-8?B?NE1semVaUHBsSlllRUhYSmtIOXFQNDNsZm1hY2JXb3FIUUJDQ3RwSmNSVWhW?=
 =?utf-8?B?ZUNIMW53RTlIRVR4cS8vOER3T3NQN3pra21TaE9va1hGQWEwS2JlWEN6STJh?=
 =?utf-8?B?Si9wVDRXRUN4bkRDb0MrbjZPbmdqNm5XZXNBZGsyK0pwQkJQcG5MQTlKZEUv?=
 =?utf-8?B?ZytWT0ViYi83eXhIRklCKzRSOGxaUWhULzZnSWJHRFllTlU0RW9EZWdleTl0?=
 =?utf-8?Q?XcVKH41VY3x6FOoyC0edBW134iJ5/F26?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0FkVE9XYTNYSDR3d1VUT3NPbVpzRytBMnZ3bGxvSFlJRzZPT3NYc3ZBZ1hN?=
 =?utf-8?B?TU9ZbVdibnFvV2N6V0h0QUVkTm9iRHdxSmJUR0RmdSsrZEJFTnZ5eldTKzJ5?=
 =?utf-8?B?eVZLQmlZbStNUUZPMEhFNFgvMSs4ZEdrZ0pWUW5LOTNJZitmQzNvM045NjZC?=
 =?utf-8?B?Vi9meEJ2RUNTeWdvd05MWlVQUVFTREVIRnVvbHFYZFZydDNYSW5YdVhZRGQ5?=
 =?utf-8?B?Ti9Edi9RYm9Lbi9CaGdrNFVvYjA5QUg0NElNejArWFQ0ZEZyRU9PSXU1NzBZ?=
 =?utf-8?B?WDNMZzBGaHM2czBLVzYxY01IR0M4WEdXbE5uc1pHZS9La1lwRTFkQjdwc2ky?=
 =?utf-8?B?aUFKYkFCbkRhTXZXSUhEaGJHNDFEc0lvY3cvTW85MWlYVHk3OEdjTW1yZTk0?=
 =?utf-8?B?UnBuSWdjS1IvT09wLzE5QVk0bWZqekNlK3BRc1NyU0tCT0tOQnJJcXE5Wm04?=
 =?utf-8?B?cWt5bjFtL0ZJS3VNMXVidmZ3QW5OWnN4RXhHbUlwT1pWME9VOXB5cUhhWUln?=
 =?utf-8?B?bi9aVDVXTDRvS1NIT2pjV01DZjc1dmd6NTJPUFF5VC92OWVBc1orS1g4dUxn?=
 =?utf-8?B?c0cwcTRaMk5YaUNCaVhkSmRDMUtPSVhWc2x5NGRiekhwdlBpYjdZYjhrQkNW?=
 =?utf-8?B?UnAzMlpiZ3pyYTBILzBZdFRDTW80djZ4UGZrRVVzbk9GbzBGOHJrUFk0WDI2?=
 =?utf-8?B?d0M2Qk13WHVaOS8yUDkwMHFFM2J4NzR2MzFDNGtUMndITkpYa2lXNng5bysy?=
 =?utf-8?B?MENFNWR5T1hWNGNjM2hBRDN4TE9OMUVOcEdzVnMrS2prb3VGZTVaeWtLUHVR?=
 =?utf-8?B?YkMzc25haG56VVd3WnNyV3NiKytqTSt0cnA5aTVPcHFLTUtieDdXS2IzT3ln?=
 =?utf-8?B?U3VLU1NObGd2K2V6VnVnMXRFczdJaFFoWmFwOEprRTJxQ3d6aU1pQXlhbnU4?=
 =?utf-8?B?Um9lVVkrRHBLd1ozaXFmQVI4YzBWVks3VWJoSStBbFpobUJJMXNUc1dMTFE5?=
 =?utf-8?B?ejRHUjducUZBZzZDeWc3M3k4SUhtcEl0eUF5bzdFd0ZtMmsycTBnNVhUblhI?=
 =?utf-8?B?TittcnN0eU1aQ3BLQW91U1BKTXJxcERxdy9jbDZYQXAxK0NBeFFUTExBNVpx?=
 =?utf-8?B?SXMwcDRKaldFUFkrT25QRVFDMkRsSFJPY2JrWTh4c21sMCtCbDF2OWxjTmpk?=
 =?utf-8?B?QS8zMWg2REhVWGFiV3VqVUZJbkxhWVFWcWZKcTlWV3gySXkzMTZCTzZLZTBj?=
 =?utf-8?B?RGxNc1JuSk1TN1EzZkFFNzdJSXFBd0ljNWZUT2U3WUdVQVVYTVlZcDk3WHly?=
 =?utf-8?B?YXJZZVNFVGxmemh2RVlHa2ROeEltM0RWRXZET1NnNmZYa3p6T2VjendwRERk?=
 =?utf-8?B?WHJQRGdjaUs5eFdVcGRHV0N2bCszbEVJRWNWUW5EVEMzT1RwejhkYlF0Yy9B?=
 =?utf-8?B?elVTajJWZmxEcW96OGlaZVZwalBQVEI5clZ3VW1JZFY3SDJNVzBCYUk4Z050?=
 =?utf-8?B?SEw0MFZuYjR4Z29QdU1PcHM0Q1V3RDYzalQ4MFRuRmsza0JNTVlDYXM4bXgv?=
 =?utf-8?B?MkZpWmFPZlFuclBwZ1IrM3lyUXVUNU4vK3Fkb295YTZNL2VMTXRPZFF1YnEr?=
 =?utf-8?B?TFVKcFZFQ3pSNHB0OTA4dlNrQXYzbWN2MW1SaEdYQ2JkZTQraWIvdTh4a2pK?=
 =?utf-8?B?bFV0VHBwc0UxLzhTN1ArVGNNbStlbmJLNWp1aXMwQ0s5TW13bzZEUWk1cGVH?=
 =?utf-8?B?dHAxc0tFM1AvYWtWb3p5Um14WUFaT3RENjhBWWhtWk92cnc0TWZWWkpnN2Zo?=
 =?utf-8?B?bkFMUjJ5NWZuMVhrTHhVUTdnZmpaWXpjTjJNMVVVMXAyZElUeUtXLzl4L3Mw?=
 =?utf-8?B?SXgySGs2MDVtS0RlU1piOWlqZE9oeTVlNTY4RjRGZ09IMG9XMGxRZ2lUUGRx?=
 =?utf-8?B?UTRNa1QvNGk2UTRScm9uOFdyZkkzRnlnVUt6R0xaaFRZRVpDbXR1VnpRN1Ry?=
 =?utf-8?B?bHdBZFNqN3NsRi9sZW91VU11YXYzWnhvZTN0STRzV2tETDhOZ0puRXdVUGZs?=
 =?utf-8?B?em1MWThKcHN1cFVkd3BBUHhaT1BZM3NSNTRkcEN4SUhBdjc1MTBXbUZUeEQz?=
 =?utf-8?Q?a6rg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6567684c-b2b6-4d08-6413-08de3703eaaf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:18:29.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqYJV9eCpb8E9vSn3eRk4wfHZHRTTsXgM0SQ1YfSqDzPR0qFEq4WEl0w2Lki8Phg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415

On 12/9/25 02:25, Philip Yang wrote:
> With this bug MTYPE_UC 0x3 can not be updated to MTYPE_RW 0x1.
> 

We need a bit more text here. E.g. something like "Fix copy&paste error, that should have been an assignment instead of an or."

> CC stables.
> 
> cc: stable@vger.kernel.org
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

With the commit message updated:

Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 97a04e3171f2..205c34eb8d11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1204,16 +1204,16 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>  		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_NC);
>  		break;
>  	case AMDGPU_VM_MTYPE_WC:
> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
>  		break;
>  	case AMDGPU_VM_MTYPE_RW:
> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
>  		break;
>  	case AMDGPU_VM_MTYPE_CC:
> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
>  		break;
>  	case AMDGPU_VM_MTYPE_UC:
> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
>  		break;
>  	}
>  


