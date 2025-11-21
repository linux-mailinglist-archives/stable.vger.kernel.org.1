Return-Path: <stable+bounces-195443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F7C76F0E
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 03:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AD1D344386
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 02:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602D913FEE;
	Fri, 21 Nov 2025 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5lrr61/z"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F321BCA1C;
	Fri, 21 Nov 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690405; cv=fail; b=AIZvIhfiQ/vKzMISLPcTIAnj02fDCbfyHc/NBKxal9ODeCcVApbnUPzIacCAnVsVFO+JsrplKVavZEVr8wxRhDClmMG24jrqYnz0bOTjF51C09gpn5qbD7g91m72cqkAtwGMRR2UeKB9sadjFcMUjA2Ve1da2pFGpibKcY10LIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690405; c=relaxed/simple;
	bh=wyCL4DF1Z8SR9HgE++BnuOaGMAyyOQDnziOc7vh8rV8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I/0s94PJ0jbOLhGL6JBaYF9e+6RT03+dUylsNkVQhUxOn016VFIiyf8qgWPGvkM8/cgIBXzAmopGvq65XuKce/cUab1KtKdX/77TjMSPaLYXbTXL/IN9ZwL51Jql2LrrtBPmYZnEDWlIeHEiOqiQQVlGXaN+NEX7bYTUuALYfzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5lrr61/z; arc=fail smtp.client-ip=52.101.46.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO7u5XAu/hm5YLRdZouwibC8vYG0EEdkdFlF27TTSYIPJWksCS2IyFEE04+i/3DllSfhoJTSPXEhNovQdJaqs2C239wIlyVQyg/y1Kt84+kcjN0szggtKvpUJ1rDAJLL+fMpFLEpOysHussiLzq+TpiJkBEaNlyMhXXcUHe4NYeWFZ/GicGcNJLblZ9eBYiYyLoPPOVaOSZXbPDkARUszO5LIwYnfaZM+FR4zKLdnVYUMEwraq3HpU8pkISr31EHhrAnWLxVJ5/ISR7GbDEhYdde5xJHDOiFUKlHM6YcPf7gRoZayrHu/Sqqr/tUnLwTH2vmp7zjfp8xYT9UwvERVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3VV6Gj/N8ys+wY5MXpgCeXpwCnKdfCFJm294E7J5bk=;
 b=unpmzNu7/tPsmJ/uPScz2ZR81XjtZonLt0G+e7KEZiLxpGevfnJBqSBNOLRVdGpvXezTaLV/JQIxrr7ZScGBiU2Plq5aVuh396W6W3XeHcf5VImLbNQsIrw218RxoaJonIN8/9jKoNwia0rxD1lcz/GrYtm0qWrrB9ZAPvzo4CxhCjG1t0YE2Bih6VywfxmOQaWnagZizP5Gb5iXdrwTvGt6ZcSd6+TIL+Av4Vjx3GS79IvC2WbG+AtESev9832fbbA1yuy5PBKOmZzPZjOgEZrvziO8iOYRLT9T4K1DzB4tvtnJHFznuF18OWe3OUuQfjUoCj8cOcxDfXLGRj/Afg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3VV6Gj/N8ys+wY5MXpgCeXpwCnKdfCFJm294E7J5bk=;
 b=5lrr61/z7GfCZkA5mv9eFnHj7T0yritBkmI9ODZbWaMX1U94h7BywoxKLlJEd25P12SvUOG9e1gyC8YxjuFHFJlvSicZxNy/VCw50lSGNIJ5fWT+vIGq+qNUUSERISRJM/KXI39d8wP8Wd/PZe2BnKMZx9fXCHmb741+WWCm/C4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10)
 by BL4PR12MB9721.namprd12.prod.outlook.com (2603:10b6:208:4ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 02:00:00 +0000
Received: from CY3PR12MB9680.namprd12.prod.outlook.com
 ([fe80::1614:533a:8d3:b479]) by CY3PR12MB9680.namprd12.prod.outlook.com
 ([fe80::1614:533a:8d3:b479%5]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 01:59:59 +0000
Message-ID: <161a0863-7cda-42aa-a462-c327276b3e26@amd.com>
Date: Thu, 20 Nov 2025 19:59:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce: Handle AMD threshold interrupt storms
To: Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org,
 linux-kernel@vger.kernel.org,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>
References: <20251120214139.1721338-1-avadhut.naik@amd.com>
 <20251120215305.GDaR-NwYmw4XkOd57L@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20251120215305.GDaR-NwYmw4XkOd57L@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0111.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::8) To CY3PR12MB9680.namprd12.prod.outlook.com
 (2603:10b6:930:100::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9680:EE_|BL4PR12MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf87d39-f7ee-46f8-d049-08de28a1ad50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUx4WTdkQ2hmanduY2xDQnlsZ2JQQW5wRFI3UFZaeFNTbUZKWUZOR3l4eFh0?=
 =?utf-8?B?alFNNXBqU2ZsNGRRK1ZqQmRxUnVIcVBUREZRZnlYeHUyY2d4czYyejZreEFh?=
 =?utf-8?B?OENwdEt5dXE4Q0IyalZ4S2NYZU93K2NrZlhFSmhibVNKV3JoRlNya0l0M2pH?=
 =?utf-8?B?QjIrSkxpcXYrSUQzZDVTc3F5b21pbkZ6K21zcXJPVy9vKzVYZ3FVR3ZXbTF5?=
 =?utf-8?B?cmgzS0sxbkdYc3NNS2FBQis2cGRsM0pFL3dWT0hlWnNPK1dkZHNGZ242SUZY?=
 =?utf-8?B?QlU0TFJyOUgyekpTR3NNTlRwb0hrT1YzenVjWTZrbGpaVVM5VVBnSEE1TEh4?=
 =?utf-8?B?NEp2TE9sQTU4UjJQbndrZUI3YjlLVytDNmp0ZHZqZCtHNVFVN0RnNjgyUS9X?=
 =?utf-8?B?U0JBczlwakh0SkFxL3lWcm9SWkdSZ0oyNTJqZnh6dFFGUHR2NDI5aWUyNXYw?=
 =?utf-8?B?blZYRjZsVDJFamlKTkN6VWhrVmM3akEybno2S2NmV0xpbkJWTG9sR2U3citO?=
 =?utf-8?B?RmhJZTZDOVRHRlIvdmI2bVpuNkxqeXF3OWc0bGF4Sk4rU1Q3NkdPeURFZFNn?=
 =?utf-8?B?RVJMOTRJcHBSMHdoMVlDNEs4aUl5UTBST1lsdU1teFlabHQ1cTNkZmJZWW5r?=
 =?utf-8?B?bm4yR3l3dTZOZUFDU3E4WTZyZnRIUlkrNUQ5K01VRlNGM0NkaEtROVErbU9E?=
 =?utf-8?B?UDBzVjMvL0l2Z3NZVlpIa21JeXpiSjMxV2lUVng1Nkd0MkxLa05vNTlBUkRy?=
 =?utf-8?B?aUxmK1BUT2xRQkNkcHU1aXh5c0hNMXZsbkV2K0tzRS8rWGVBYXZOcjVzVU1a?=
 =?utf-8?B?d1lUQy9UQXZXbXZaNFQwUXczQVZHYnlYeFpHdWFMNFVTUjMvZHNRVnZaanov?=
 =?utf-8?B?dWd3WS85L29HcFpZYkFocURTUXNNL3JmKzVsOTAxT09Zcmp3aks0M3padjVJ?=
 =?utf-8?B?K1dMTUZsK1dwTTFnNXJrWFhjaTVRbEgzNklKSUZjN2swV3hxK2NydVBtWDN5?=
 =?utf-8?B?WjEyUm9NNWd4QUNhbHkwN0JzbDVhSDMxNkw0K1pBN1VGSDl4aU5iSGJEZlYr?=
 =?utf-8?B?K2pweWJkbWRvblh6OU5jUm5uTHBWb1h6cXhaV1Uzc013czRqKzJneDdmKy9i?=
 =?utf-8?B?K1JBbmtpZEE3VnBsK1lDVFR2U2c1V2xhZ2dLbUEyMCsyZ3Y0WDBoQUtkcHk2?=
 =?utf-8?B?dG0ybkVhWnA1a3hPL2pnVHdoR2xuV2psenVjK1k5aTZoMEJ1U1kvUjRxaUY5?=
 =?utf-8?B?QWVKRVhwdzVhN2c1V1pQcGhYOVliNU5rZTVxdzNsa216UWtmUHhEMGtScDll?=
 =?utf-8?B?dW1Mb3ZWZmlxTnhFeVJxRmgxNTJwVUllblZTb0JyVCtsbW82Unpsdkd6ajUr?=
 =?utf-8?B?MHdZMDRzRFZrY3Z1QkZWb2FsZTNtYjZmSkNQMEJDQXliZmQvSHhMZkNmWlZZ?=
 =?utf-8?B?Zm92YWx6NzljSFhUUVI4VDlQVm1pYnh3WUZwcndCZ1Z0RGJuNEhUUGt0QzZI?=
 =?utf-8?B?Q1BvbHc3ZmxZOXZzSVBFWHFMdmNGYThFb1ZHQVB1V1gvcFliTnhyTjFVQ2dy?=
 =?utf-8?B?d3MwVUR1UGRFWHBCNkkzSHc5eXNQeE5QZUdEUFE4QXJMd2pxc05XTjI4Z3Fn?=
 =?utf-8?B?aUdWRjVjQWM5a3haQXBYdHMrZW92NlYxT1AwbXh6V1JwazJ5T3JQL3BicFBY?=
 =?utf-8?B?VVdKdXZDNWx1S2liUks3NmlwSWY2QmpXVUxxUWEwcy9LcWpUdjVTU1R3RHJk?=
 =?utf-8?B?MUJyT0RwZGxpOW94L0h1SXhvbEVjNEdmWVFoT2pZVlRQemF0M0dTU01XQVJx?=
 =?utf-8?B?QW9DNEs1OHVpOS9aRnBnMVlWTjF3V3p0K0xhRWRCZ0lDQldlU2kzbXo2QTZE?=
 =?utf-8?B?TDNCNGFIbWNQK2pBempINzNzS1FUMndRcHRic1N5UmhlNXhwMGk4aEVvVkRw?=
 =?utf-8?Q?Fe5OSUef7CCk1p173gQl0DWpQJSRUtnZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9680.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmZPNjNxSmdOcmRNZmMwSExDRlF3RjhpanJYR1VtazA1ejkvSXZDM2I1UEJ0?=
 =?utf-8?B?bDBLcllZRHRGQjRSSXFrTXliUTYzQkhPRGJydEVYM0ZGL3VKQjI3T2RSUUg1?=
 =?utf-8?B?ZlhucXJLc0lTZGIwS3pvZC9rczR2Qlg4SWd0aVRnK2dZV0tYWFFGUTMxQUNx?=
 =?utf-8?B?Wno4OTZpRnd3VWwvODF0VmRsVmRUWjJ1dE4ybEhmOG9UcjJFdnpka1JoYi9W?=
 =?utf-8?B?YUZpcUdMbzZNWm0wYVRQZnlsUTcwNzZ6YkU0dXlCanV2ZXIyanJYTGVSQ0Q2?=
 =?utf-8?B?c1NNZWZmM3RsRXJEbGhyVDlFM3RxeTVxbSt4UlpxNlJPTVZJQTREYnpXNm5w?=
 =?utf-8?B?TC96QWVIK1BlUGxSbzJiSDZvUDVVa3ZSVzJUeFdOYlZTMVF3SHVYYUM3bVBG?=
 =?utf-8?B?UUQvVndMTzlDVWpmREYwMnJ0SHJlQzQ1enJQcVQyVUZVU04wZDZ1VUllT3Vn?=
 =?utf-8?B?VFhYb3UxTGIxOU84NzdWanVTM0l1Zkk4Rm5CQVFCVm9Lbzl1MWo1a3ZRNTZs?=
 =?utf-8?B?bWVBVjE2S0MrOTRlMWR0ajVGa1M1VGpOSkx6YUNsaDhrWnplRytJZ3l2WlQw?=
 =?utf-8?B?QWVWQXZtY0ExbVJiUzNXY1pvTCt3UnNVUFhuWEk3SFdsVldXeHB2Qyt3YXJv?=
 =?utf-8?B?WmJ6L2hrdTk2Tk05Rm5KQ05OaGYyRzc4aUo4RytQS0hJdjdaRlN3TkVxdElR?=
 =?utf-8?B?Y2VtZThEdkcveWJtckkwMFhzZ3RnTVc5ZU82ZDN3azllYjBpZVk3RnRobVZY?=
 =?utf-8?B?cDE0YlRadVRXSmJQSkxyMlFEamwyQTlUZFU2blZHN2FuNkIvSXVQTXVoTnNv?=
 =?utf-8?B?cHdQbVQ3SDFOSmxlczJPM0daN241OXdYN0h5RzNRVUdhWmptQ05xYkxBQktB?=
 =?utf-8?B?dGluNlpjOFFNbWdmN3BwMUZCc3ExWGZjdkc3YWZSMFZMMDUyUndlQjZnbnZo?=
 =?utf-8?B?OTRya1NnQjR1YTg4ZzJkVFNjbkFsdnV2ZTlSYXMzcElaellIRU5uMU80NUV5?=
 =?utf-8?B?Q0tCMXlsZXRDdEZ1VHhZMklnRmZGSytqS3hxVkRMUkd5QTE1aE95UTRjOHBS?=
 =?utf-8?B?WmZrWU9aamJWVTRQaHBhRlZUU0dRZWd4VzdObVZaaCs4a0tRS1pTMXo1a0x1?=
 =?utf-8?B?L3NoejhheHhpbSttSCtFRkZyN0xHNG0vY2NMcTVSRTJTb3kxYUlZNmdjSCt0?=
 =?utf-8?B?RUlwdXR2OUhIUHIrL2trbEpLYS92enFza3J5KzdwbzFqNlVnT3BEYkRKdTgz?=
 =?utf-8?B?TkV5RjdDaUhBZ1hmckZsSjBBNDRpT2pzc0tLemNsdEpscXplYVdhNGYrWGVQ?=
 =?utf-8?B?US9OMFplb24wQTBzMHNRMWhjVVQ4b0F0QWRySUtKcU5nR3p1TElGRlNFOXFC?=
 =?utf-8?B?L3FtVXVEZkYxMHo0SGc3bG1HK1J0UWt5KzVWenVNbk1LMnNRdjRMY2NSdnFS?=
 =?utf-8?B?RXdOQ0V6RGtTYzYzZHl4VyswaXVzdk9JUmZQcUEwQjgyU1Vzemg2V01OQ0RY?=
 =?utf-8?B?LzZpR3Bydm5qeDkvZ3J4Rk1jS1VobDZwWG4yYTFsV0hSU09GQWZpOXdZY0Fo?=
 =?utf-8?B?NVY4WTluMG5yUU8yeENxMHJrNnhYRHUxMVFuQjRrSE1nNVFxcDV3aXFNM2tW?=
 =?utf-8?B?WFhnL0M4VUpFQXZRTjU2ekM3akxKSTlMSkhjQSt0N0NCSGdJWEF1Wks4bm1J?=
 =?utf-8?B?NnZSM0JWRFR0dkE2d3BjYkZvSnpIQUo5dzdXRFd5TjRPVWNwK1piMlJkWWNM?=
 =?utf-8?B?blJacmY3VENSZlNGaWdITEF2ZUt2aUZUeEtQdmo5Yml1MjlkTHZ0K25rT2pC?=
 =?utf-8?B?MzdqWUs5MTdhOXE5cWRyaWVBWkZzWVlTL0VlOFNZR1JaZGRlVk92K2QvMzIy?=
 =?utf-8?B?Yi95QTdpZkRhRWs4VkZmYmhDVmZPWkpCVzlQQkNvNS9mM2NtNlk1V2lDNVRp?=
 =?utf-8?B?VHFvSEYvQlV0a0MvL0V6c0NhN0lISTh5c3B0SWMxNXZ6WWRUZlBYQkgwNGZD?=
 =?utf-8?B?SnpDRytKejlURTdtT2dsODB6UHFkd3BVTGd4L0xHbnFOblR3clc3Uy9VSVlU?=
 =?utf-8?B?ZGh3M3lzOFBiaHNJMis0UDAzNW9sQUtBZzlRckI3TTFQZ0NqMmJKaXUzNXo1?=
 =?utf-8?Q?6OXd0g2Rl+RzXSHRBTKEoyiRx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf87d39-f7ee-46f8-d049-08de28a1ad50
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 01:59:59.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fv/DCzsmllgZq6cuPrw+pTB4gydNPChJyCnDVLhsT70cWJqK8Wp+uZogGFZdanTp8yA7xTk74UtFd8XEfkk/sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9721



On 11/20/2025 15:53, Borislav Petkov wrote:
> On Thu, Nov 20, 2025 at 09:41:24PM +0000, Avadhut Naik wrote:
>> From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> You need to put here
> 
> "Commit <sha1> upstream."
> 
Will add that.

Also, does this need to have a Fixes tag?

Didn't add one here as the original patch committed to tip didn't have one.

>> Extend the logic of handling CMCI storms to AMD threshold interrupts.
> 
> ...
> 
> 

-- 
Thanks,
Avadhut Naik


