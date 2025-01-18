Return-Path: <stable+bounces-109419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3284EA15B39
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 04:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854233A96C9
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 03:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF461EA6F;
	Sat, 18 Jan 2025 03:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l4+iNftz"
X-Original-To: stable@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013075.outbound.protection.outlook.com [52.103.74.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE013A86C;
	Sat, 18 Jan 2025 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737170985; cv=fail; b=Gco9XdXh/mcSQoaHlRVEOydU/bm6PUFTS1qHHGMrS4fJBGEgLIAqSDkW+hnhTE4D9jr0eh6D2W8c6F3ujIgFVn68iIH6Sqmc+zT3ekdCEk9RIPkMLcx48OaB82a/MaHnmb/LM7XLyliKCEJhEh7YmtEJvAex4HrJZjOhAYnkkto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737170985; c=relaxed/simple;
	bh=/e3YQ7Qwyx+yz+IXXlbiDyTjql36EFMYhMhdxrktXeM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRZXId6SwOdP0gusDheW6UxO93Pmz6z/G7uipR+UbfPs2fyMMn0acTIdZ+pHh6Mry5TpDXf45dgh3r0gGKz1VOyyl4M2One3QQYwScE8HuoORwOe1Sshdv2aTJ26mf0Mie3dETtk7Gx8fj0jJ82/Ma3Yr3A4NnIJPw6/cYvL8sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l4+iNftz; arc=fail smtp.client-ip=52.103.74.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cos9AFZl7cK24PEyk21Hi3v9247EUOi1UfrWcE9dknYnScoCDyuYpPCFO44md0+bLaYwyJq9MMLp7NtBv/cLthUjz0XchM6RgRsd27BAG6CzGT1AI4NxoVgRaJjBLJoCAqzv+/OBSsJtG9ujyBGJGTwOTTGqBV9cVqX6+LBElE3ZCcm63MVXj9t1AMN1bDP24G9AcZWABqEwll4P8ytYeSdJxyiM3kYGmAxp7zTODkSCAjd7GjY2S1AONHSatG4soCRH0qhjMB8xFuTZHhF0qiQi1kM8I+EQe1pJrsJ+vIq0jvw5qLhpkdNm3t4oS8Fmu39Kk5xgue88AYeVIHjwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuxHVj8CF1abRbVc0dvypTdCBaAOX7AuMJMBbW5tRTw=;
 b=A1p2Oe8AF+FuWdXf5qgcVJjNDkTJmVghg9hjXXZIpkktt1QcCVDifq5wXLC3Ia209pgbelVGszO/U0pgWe1lDFETFlHjkZoQBFJdgIn783f4jqKroW3MJXWBNTwyNvcQPJhmZVDH8aHhgU6Um/GYk4QNuWohHMiwejAGrynRTsa1qPIlqFJpfg31+MQgyEW+hGA+K+PdDn9ipnReqfWYmbmH1AQxuWCGrIXtjyikuE/iHgMAlgM4IiKlQkX6DW9EaJioPpiTkJGhIscJDYfIRF9bLZoeNpFBFz9TlDYGZ9YsYcKFABx3indd8y0z/8sV5Z3g2OOHJSFl3rvBilnqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuxHVj8CF1abRbVc0dvypTdCBaAOX7AuMJMBbW5tRTw=;
 b=l4+iNftz/6q0li1E13vJLX3CbNtmCzyzzp55KIBm69zDc+ycTV241DydeSIKwixUVzR8Qa4qpUjr6ovfhNiI9W0+G4U39pCv+b5tuiLzCH5kuv9KPf4ZJaLYl08sk6LiNCL5hKRv2oll1HA8Xt9ALnil1eS4FBKA6D+shSE71N2nAxYo5Yn3XBiXs1Q9pYonVl41jOgZ31UZtp7/XN2+NP3sds9VlsgTZF29x1nCLXodk4lDCJsUGQ3RaitiuId9Feqjdok/wmscSPEuymd7Ouffl8X5ZQw3Kbtd1qGmvFu0ZZwQ3Q8GMoQM3oKTEqftXi/VRmzxsK0sin5h08l0OA==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by SEZPR03MB7220.apcprd03.prod.outlook.com (2603:1096:101:ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Sat, 18 Jan
 2025 03:29:39 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 03:29:39 +0000
Message-ID:
 <TYZPR03MB880148D071B32806DBB1ACFFD1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Sat, 18 Jan 2025 11:29:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: "H. Peter Anvin" <hpa@zytor.com>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>, Xin Li <xin@zytor.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
 <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
 <TYZPR03MB8801E2BF68A08887A238A32CD11A2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <05b13e99-c7e5-4db7-90bd-a89a91f4e327@zytor.com>
 <TYZPR03MB88013A5D71079FF9E6776E49D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <d90975a0-6b01-4a2e-92c2-2af2326e1299@zytor.com>
 <56b92130-7082-422c-952c-9834ebdb7268@linux.intel.com>
 <4d485294-959b-42a6-a847-513e8e3d0070@zytor.com>
 <33b89995-b638-4a6b-a75f-8278562237c4@linux.intel.com>
 <c111ecfe-9055-46f3-8bd0-808a4dc039dd@zytor.com>
Content-Language: en-US
From: Ethan Zhao <etzhao@outlook.com>
In-Reply-To: <c111ecfe-9055-46f3-8bd0-808a4dc039dd@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <bb39e941-f5e7-44f2-ac33-71647358966a@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|SEZPR03MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 21faebc9-2308-452f-365d-08dd377055d5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|6090799003|19110799003|36102599003|15080799006|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUtSdk8wOU1KZVgwZEN3MzFlc1R6aDdhZFBadnBybkFCcmxhREJDV3dlWkpR?=
 =?utf-8?B?eDNvdUxIRXdDd3EvenBzL1VGZTRyelQ2Q0ZFaU94QUZmc3Z4YmhDMmV4TkRh?=
 =?utf-8?B?UHFaUTVlcm5mUlVjalpyUW1NdGpMc0xPUE5NOGN2VmUvT1NkUWhBY3lhcDRI?=
 =?utf-8?B?NGFlR2NzajRjQkNQOWFuZHBwdVJZbGdVUUtHR1VFTFBwVC9jMVRPZTJhYjIr?=
 =?utf-8?B?K0dYUmMrZUU5QTEvQ2hZeTJxY2FyczYvNFBwN0E5aXVnUUpUbFE3OTNtREdr?=
 =?utf-8?B?N2lPWG5Tb2xPdUdzOHU4akdUOUZheXJuTFU1aWVndHZzSlpqRUtsUEtacG5v?=
 =?utf-8?B?U2FrVzRGUTNib0kvMHhzVnBFdlZ3d1l5VWE5TnpoRnlEcEtQZGtyNjFQSE5L?=
 =?utf-8?B?VjZsSEVRcDB6MnBNY3VteWxFZFJwdXVub2NQMHFOV244Z1FXYUxya3o0MlB6?=
 =?utf-8?B?QkhrQlc4clg5QzhERVRtWWREeFJpaXE0NFkzcWpvYnB4RW90M1FGbVJEWHBZ?=
 =?utf-8?B?VW92MDB1dE9Od3F1c1laVlkvQjVDWmhMTlhTMXEvQUZ5cDMyT2dUeW9hbEIr?=
 =?utf-8?B?bEp1WmVwN3laRDcyNDFwandDaGttWXVaOTZiMjdBS09hVGxJMzJ0d01DcGJ0?=
 =?utf-8?B?L202b0hnVEIrenI3dkw2UVZRL1AwVE1NajBNVFhwQmQzdkQ5anBBMnoxWVFm?=
 =?utf-8?B?VDFqdnBKRCtoSzMxQTUyajBtNW1iaVR3MUZLYWZQei9KWXNubU1aR2RiTHoz?=
 =?utf-8?B?VndPZXRxOENuVFRzUHU5WWEyakZUUHNYWEFvK2VSbE1vcTd1SXpBZ0RmdnNM?=
 =?utf-8?B?NHQ3RWVDejNyS0llaFNaMWV0UzdrWWZINHhPaEpGYml4U2VZaEo0TmVsZjBD?=
 =?utf-8?B?alpBZm51NzkrNENaUnlzWE92bTYwYTJvWWFXOGkwSU9ZWXJqa0JCaFVZVEJN?=
 =?utf-8?B?M3Y2ZEF2TGhwNWgydlQrRER1MDFnQnFYSzdqTWYxdFhMclpjaWFEcnR0Rm1u?=
 =?utf-8?B?TVE1djBpWHhvQ1hMRVpFNHBRK2M3STV3alFQV1lkLzF6YkpucEdZTjFyd1du?=
 =?utf-8?B?L05QZnpVK3NvbjEzc3gyakZjdTBkL01QREpqSlJBNkQxQnFHN3VRcmVQaklM?=
 =?utf-8?B?cnRLK1NYOGUwSElzSXVCSjlFdW91UmtBSXhmbEQyTE1sV1FRUEVuZGhZc1R4?=
 =?utf-8?B?ZFBnVFRZYnU1WWs5eFVIc1hydEJlZEtlcGY5KzFsaHBLWm1KZGs0WWtpcEJQ?=
 =?utf-8?B?UHA1anIraHFZbG1lZ2h4UkRvbTV4b2wvVTdFNkxqZ3U1WnpnZnFhWS9tRjdv?=
 =?utf-8?B?WDlMRDdqWmVHNWViTUhrRmp6bmlzeWQ1cW91T0dmV3F3bWpCZVF1NzRPQVJB?=
 =?utf-8?B?c2F2dXh6VUNQRDFmK05BczljeXFTODljZVVMOTBZNUJOaFhNaWVtQTVXUjF4?=
 =?utf-8?B?dXl3Q0F2Q2dEcnlwYW15eWFwV1pTN3AydHNDSnhTYnU5RE15RGljOTFsSkFW?=
 =?utf-8?Q?32yp4k=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVM5Wm05aENUZFpManFVaXNOcWtNQkU2ek1GbnN3QjRXRFJLNW1PeE44SlJ0?=
 =?utf-8?B?aXlKTWpwNit3NEhDT1BCQzZGandpTkI2L2hycHIrOHBLL040alZNVi9oNDNh?=
 =?utf-8?B?QUJEMWEwdnMzd2VPVkFoOGU2cVVscGFCc0VEaHBKdzFxNzFyQVdTWHRVVDNt?=
 =?utf-8?B?UmJ1ZlA1VS91c2hXOGxLR3ZpNklpd2czQnZOL1psazl0YnZ5dVZpZG9oeitR?=
 =?utf-8?B?QnNHTFljYkxxK3Y4U2RPUnRZdmJMQlQrSmhwTWJaTVJDWDlpRi93d2JBLzE5?=
 =?utf-8?B?RmpnZVo1UnlSeUtVNy90d0IvSUsrcTlKdnRSVDRaVnJsTVhtWHRiTXVabzVK?=
 =?utf-8?B?bTBXK1Nia1BlQVc5SzRkYkZrZzFxUUhyTWNlTlIwWVR5VER4cmN5YlI3Z0or?=
 =?utf-8?B?VFdoa2dKcUJsRi85S0svUzNUOWpTQ1BFZDNXOGQ4KzVyZlFmVmJ3bzJvMG12?=
 =?utf-8?B?anFHcjl5Y3B4WVBQUHdPUVVIWFVBVk85c2s1ZmZiOWplN0RteHp5TmRoeTUw?=
 =?utf-8?B?MjVBdGQ3Y2JCVWpxVVVOdys2WVhlMlJ3OTdPMzdTZFZoZk9mZm0wRE5kU2Qv?=
 =?utf-8?B?MlBsRWxDSlVMbERhZ09hclJMUjFvNGVLWDMxZWFaQ2lMdVNHS2NEK2I5WUZl?=
 =?utf-8?B?enM3UWQ4NWYzRFI4M1pwRDN1SlE2YzFsbG9icHo1OTBwSldYQVN4MDcwQTVz?=
 =?utf-8?B?cDNtYkwxWEl4LytwN0xJMjZZamkrOUdNczJkdFFMU2lGbW1VOFhDeWhUQjVH?=
 =?utf-8?B?SDQ5SDFyR211SU1ENEpiUHE1L29aMVAzWm5mUEFPeEIyVmhpTDNSNkUxZDFk?=
 =?utf-8?B?QUpNb3hpcTEwYlJhSGNVZWdzam9QemhkNEdRYkdaV3hzMW9kYmNxS2o2Siti?=
 =?utf-8?B?SHBlNVZCR3Z5NFplRWw5LzRnajI2dHY4YmdYOEFQRjNLNEhCOVViaEUzSnJT?=
 =?utf-8?B?aXZhcUpJQ2s5YXRUMStWUkJmclNkdHo2V1VSZW1IYUtheE5VYXgxNWdrSUxR?=
 =?utf-8?B?dU5hdXpOYkVOY0ZjZzE0ODZyVzYzWTZGQm1aMUhoNUo5QWJZdTFodUdTUnQ1?=
 =?utf-8?B?LzdZTE5NTXU2Nmh0b2JYTTIzVEpvYTFOK3IrZWU5V2ZHcTRWSE5XMWIzTmRt?=
 =?utf-8?B?ZTRCQkNna2UyWHFMSHRIWWFvRkcxbUVaVXcrWW5jUkdWUzhVdys4RFdJcjNy?=
 =?utf-8?B?MG1GdmxTem1oRUlSZ3J0MGdrYndrMDMyNUtOVXp2Ym1yeVBKQm56VFNkU2Va?=
 =?utf-8?B?VGhCN2ZDQ3YzVk5rZE5mSUxpVWdoWUZZQ3M0VEdYZi94UENXV3BySWpvbExV?=
 =?utf-8?B?MVpHbzVIS0FlZ3dRdk5Wd3RrOEwxc2dwNHpzWUhJaWc5Z2piSmlsb3dXM2lQ?=
 =?utf-8?B?MVJFNmwwNGlvL3oyeGlRektBYWpXQ0h3YXN4Z1JtQkZKeG92a291K3QzSTdV?=
 =?utf-8?B?ZjllY29IQzZoTGxxdEpJa3ZkM2ZqY1p1Z3J2N0llUTMwZEllYmNnYVoxTWJy?=
 =?utf-8?B?UjFhbzVzV3BQbzZpNldIaGVyZHYvendFd2IrajhsWDJiZ0FYZURwTVB5dGxq?=
 =?utf-8?B?Nm1UQ0FyZjIzWll3K0dtd2JUWm9EUXZkN3ovYmZQSCtEdDY4d2VybWZGSHFB?=
 =?utf-8?Q?vnH/qrVNdHZJsT96wZJI1zZxhmTnAMJpejMa22OlEc0g=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21faebc9-2308-452f-365d-08dd377055d5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 03:29:37.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7220


On 1/18/2025 12:24 AM, H. Peter Anvin wrote:
>>
>> In short, seems that __builtin_expect not work with switch(), at 
>> least for
>>   gcc version 8.5.0 20210514(RHEL).
>>
>
> For forward-facing optimizations, please don't use an ancient version 
> of gcc as the benchmark.

Even there is a latest Gcc built-in feature could work for this case, it 
is highly unlikely that Linus would adopt such trick into upstream 
kernel (only works for specific ver compiler). the same resultto those 
downstream vendors/LTS kernels. thus, making an optimization with latest 
only Gcc would construct an impractical benchmark-only performance 
barrier. As to the __builtin_expect(), my understanding, it was designed 
to only work for if(bool value) {
}
else if(bool value) {
} The value of the condition expression returned by __builtin_expect() 
is a bool const. while switch(variable) expects a variable. so it is 
normal for Gcc that it doesn't work with it.

If I got something wrong, please let me know.

Thanks,
Ethan

>
>     -hpa
>

