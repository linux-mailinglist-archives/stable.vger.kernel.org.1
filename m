Return-Path: <stable+bounces-109471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A3A15F63
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 01:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E8077A32F7
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 00:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956978F4A;
	Sun, 19 Jan 2025 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Zri2I9TK"
X-Original-To: stable@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19011025.outbound.protection.outlook.com [52.103.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549456FC3;
	Sun, 19 Jan 2025 00:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737247361; cv=fail; b=M6aY3kgbmoVYJbeffOMSraWrLY1iPTWAkoKAEEzvAwhZW++Ew8TUQnX+unTnP1rAZvxM6h/8XdoWkQ46Ba3/HLdfB+T1oxpB0idYaBCW3jEYhiC/J6JfdgxgI6RjeYzgbkGJyIHjpiyMwvxSfsLwhOR/v729AtDVl0rYgwdWf5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737247361; c=relaxed/simple;
	bh=Kua8NYerQEsQpeTJqQO9YLnplJrEKQnS63zx/eQVxlk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C3DqSUMKrf5xpjJJvoNvpBes+OTB4ahgm+SHousQK/l47m1Cez/eBDSjNZJziC6pc/2nH3Re7DGoGNlR/F1xN9fcHidnswY5jaId9d3Ebpuemx18rxNGt/Ud3+QoRemD6a9IS+M52y9gOn3shq1IVZnfc444CWwNCXF+eZOKVgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Zri2I9TK; arc=fail smtp.client-ip=52.103.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFQnQfnLmTtUZvvM1fxCSjMNdXjM5x7+MBItH4EUxS+lRwaLRB2dxU69uPgvdswiYlNzQHUBldLCVqhnK+uxLE93LAJeqaSywpNaOYzltfW2K8Al7PmL6HoARX9eEhPVhUTWinBrGS8uUfjveR5APuIriT75BEPYRqCoFBZEOE9819g6t5mXhmLKQHm2Ei+cOGlKSoyUHKiSKp4p+ADuAYkfu0fYOoFkFYuc7Zjpjidf5km77k6WkUQZwR6yaGSymCZQ7PMcsaKhc0QtP4+SrZnniw+vtoXW6hMsa7gMBZjBYtILC4MzyZLfK3mDoiEUCsZ2rUpzCej6Jpd94klqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxBNqVUImOiMXMh/wyRpRYfayhidTjsiHLinQB/oQts=;
 b=tjmWzUVcBshkz6MTKGXcTix6DtuIutQnybdCVM8aaOK0pR0AMWYLxzpxAhxaOiY1EXqJeJz9nIYd5h3yG+/DxkdO/KczKrNqqZ0wFsc4xl2+nI13JtqQvuB/GfiA0iKfL87buZZSbvcaWz7eBuAbwXduKL7G531pa9RNeMyVwTIwn524n8Au8fXc7IBq413bIE6rraLY8VZyGn6sV3PoErcIYNP/hM+hvEZ52xHZzurZ3bLjhJBymSgY3lIBixXUpw/n6rgKxzYG+Y/PDM4sz3OpH9mk/geUcEfupDT2GRrgX3kfjV4HUZq6yln2ucI/W/TIMfe27ITEPtjhWngfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxBNqVUImOiMXMh/wyRpRYfayhidTjsiHLinQB/oQts=;
 b=Zri2I9TKHcw/qwmiVdFBqE3wosGeuYXWht0a1Cg/VUJhrqbARpZ5CMwKDK4f3x4nu1KBbjPJJzoDiCUHgRNILKlsWfhA0OE48TdrxLXrfgXYkcRjUbWOVIl/Wz2054s4duChdewVoSLnOLXogt/K6UkuvAphSthVxQrPnCKlzmWM1Plseu0QL9lwgR+NsFQm2UnymvlWXxp8uMSr2WHqi3JZE9Fq+bWvxDvSIFg3cgGHQe81ztMmpkJs3NbyXyePUbiVA7brJ7993r99PGKWTw1sbNNIa4CLybHF3AVJGy+K0uj6ioc1q4fRsaSU/b96TI2iwAvC+QeIFraOuu9/Jg==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by SI2PR03MB6663.apcprd03.prod.outlook.com (2603:1096:4:1ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Sun, 19 Jan
 2025 00:42:34 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.014; Sun, 19 Jan 2025
 00:42:34 +0000
Message-ID:
 <TYZPR03MB8801CA715C617955A87B202AD1E42@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Sun, 19 Jan 2025 08:42:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: BUG ? exc_page_fault() was optimized out of fred_hwexc() by gcc
 with default kernel build option (-O2).
To: Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@linux.intel.com, tglx@linutronix.de, stable@vger.kernel.org,
 Ethan Zhao <haifeng.zhao@linux.intel.com>
References: <TYZPR03MB88013AABBBC2B40F7B955825D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <ff96c2db-2424-4d11-bfbd-e5b131a5d025@zytor.com>
Content-Language: en-US
From: Ethan Zhao <etzhao@outlook.com>
In-Reply-To: <ff96c2db-2424-4d11-bfbd-e5b131a5d025@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <29e52df8-8809-4a26-8dff-4e3d9fb2ee48@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|SI2PR03MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff85a12-af2a-4f63-82b5-08dd382229fc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|15080799006|36102599003|461199028|6090799003|19110799003|5072599009|41001999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkdJblpPRWo3SXV1R1NFRmYyQktjd3VjTXJ6WWRDcitVL3VjUmNjOG9FdUNW?=
 =?utf-8?B?Q21GOStQYStrdmtxK3N1aXhoeHQ1Qkhlb3NRMWhDREFwQVNUMElVZ3ErVDVR?=
 =?utf-8?B?MFV5bWlqWTFiVVhObWMvbUxZWTQ0UE93SkdGK3pBMHNpYmlLRTVJVkkyT0pa?=
 =?utf-8?B?N3dKcURWL0I0UW5pdk01b0hxS0NZNHJxaWFWT3JEalhOU3ZYN2tOWC91V3JR?=
 =?utf-8?B?TTAwKzZyb0pEcWl0RVc3NHRHd21xS0xJVVcxQmYvTm1WSnpNQ3JsYkdvNEJS?=
 =?utf-8?B?WkRNbWE4R0paRlV4TWh1SXkzWDVjSXMwOFY1NkdnMDlaK05kQ0g5bFFueGdm?=
 =?utf-8?B?eFZ1Qk1tcU5kWmtyZktIaG51d1kwZHhxejg1ZVI4V2hkZFpXTDN6MDcyb1Zq?=
 =?utf-8?B?UVh5ZTBQSlUzWkd4eGQxNUVYdFBWRkgrblZpaHgyMEM5U0xVYnkxT1h1SkNl?=
 =?utf-8?B?Qmk4SUVtZGlWNTVQZXVZeks0UXhkTkFsV2lqdDdRUy9iV296NTdZNjhPOUFo?=
 =?utf-8?B?UVB1REdqM1JVNXdSL0xlcVRYY2wvUjNaTFBmbUZvOGtyT1BWZFBBNkVHMlZv?=
 =?utf-8?B?dksrL2srcitJMEFYZ0FNODBTMWhmdUl1bUxpUDIvbGNKL1c2L1VvM2V4Vi9a?=
 =?utf-8?B?VHFWenVwYWxHWitPWmdHcDhqbjcxTWs3OGxaQWNtbnAvM2szWmdjSXpiVDlV?=
 =?utf-8?B?eVNhNUhQVDF6WENvZzBiUnMyZk1lMkxwaWV6OE0xamZoNG50clVKWlg5REZo?=
 =?utf-8?B?MGpGZ0pzT2tUVkJPaXdwanRaMFp5QkMxaFJ1c0tyU2gzNWdoamxhd0oxb1Fz?=
 =?utf-8?B?eDAxNk1vb0JsdzE3bi83SGIvaDVBczV4QW9NSUFUU2F5eHlBOXo2eWwyRy9Q?=
 =?utf-8?B?UVlYWGc1bUlDRFRCSER0UmJzeFUzMUVpbXJoaFE5eXdJZXJ4bGtKWnpmeUNr?=
 =?utf-8?B?clpMVS9WKzlrWDBkRHk3MGdqSXlIRHB4N0RtbE5DNWp0VStwMUl3T2V5bkxn?=
 =?utf-8?B?bTVocDVMdksrWFArcE5PQmYzMFVNdStaOG82NmN4clNMak04ZmZFNjh1Y3p0?=
 =?utf-8?B?aGdKT3htL2JLS01ub0R2cFlsZDZlU1Y2aFpxWHNGZ2Z1SHlTTzNXbTQ1SHVD?=
 =?utf-8?B?RS94K3FMUjJONlVWcDR5K3pTY01JdC9PSWtJQkFtNmlHMjBkVU9HM21vdjFx?=
 =?utf-8?B?TS9Jb3ZkUUJ3QW0ybnR6QURvcHBYd0pKbDhHZDV2clN4aG1SM3hjd1pzclJw?=
 =?utf-8?B?aUtJUm9jTFBtL3dTMnNBcXV4Z2dBYTM4NllXUTViRU5UTWVhR1JzWVNUMkpt?=
 =?utf-8?B?Rk9KOTFKZkhHR3ZDdGhLWUs4WmpiQXZwV1hla2VUY21pUmZVVlpSQWNXOU9H?=
 =?utf-8?B?SlVMbDFtR2lpWS80bnZrVFhCS3JMd0lCZy9SRVFCclBpTUlORmNxSWd1TFU2?=
 =?utf-8?B?RGdDeGVPdWxYTFZuSXlzMGp1WmExTnFUb3FLUGRzWWFNVXgxNHlad2ozTlZQ?=
 =?utf-8?B?S3M3WXdqYmFlSnhvNW9nVExFRURIT2RXKzQyL2cwZTRGTEozcUJmNGlURzJ6?=
 =?utf-8?B?dFNOQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjB2VHBya3dGTUVTWXVoRVp3M3pNUkV3R3hnZ09Sd3gvdU1uQlE2Q0EvOW9G?=
 =?utf-8?B?dDdxZHliT091TDc5bHpOM1hHZS9kSkk3QkZDTkZsRlVJejBXenlPT1E2Mys4?=
 =?utf-8?B?UGJYbjNXR0lOcm9nWWhWMjZFc0Z1WitycGdOQ3BHQkdCNWljMEgxZERFWU1x?=
 =?utf-8?B?TWplVzl0S2xoR0Y3WThodER4WTBMMnBGaGJPYlN5YS9qTER1TkVoYXl1MnhG?=
 =?utf-8?B?TkZHY3NHL3ROYTVYeHZVZVd1MjRhREJFMFB0RnlrL0xBSFpCNnN6SkVrLzl4?=
 =?utf-8?B?bVRoSlZRb25YSnRPZDl4Rm40aHdGRVlBcHlVQTlLSS9tQzM1N3RSZmZPalBQ?=
 =?utf-8?B?S3B5THBlUnNwSWZ3bThWNU9KR3gwc0tucGk1a0V2Z2hTQUZTUnZqQlhpck55?=
 =?utf-8?B?Rmc0MXhnMHphN1dCaTFNWTJiV3Eya1dFQzlHU1hVT2svd29QTmtIQVNMZVF3?=
 =?utf-8?B?ZXdOdkVYbXUybFF1cmVzRHdHTmlzaDg1cGVFK1dyNWIveHRQeEw1b1htcFh4?=
 =?utf-8?B?UWxIOTNIUGY5RTdQcU0zVUg4ZUZVMGlsRnB4Mi84N1JpN3VOREpCdm1oMVE3?=
 =?utf-8?B?S2cwWGhCZEVhUC8zc1NMbVlxbXE2YmFnWFRUdndkQitYS0xMU2dKaFBtV2Vh?=
 =?utf-8?B?Q0VzMDJrdzM5cHNXZnVjMTQ0RjYydk5sM25GVDVNZjlyVzNmdmZFcExXZ205?=
 =?utf-8?B?MVM2YW45dWp2Z2tWVWkwN2UvZW1kZkFhUzcxRlZuWjVtYm9ZWkp3VnY1VE9K?=
 =?utf-8?B?NVVWcnRTWldNaTRzeDl2MjV2Y08xYU9ob1ptNnhuZ2dkMG5ra0xUNG5tcTJE?=
 =?utf-8?B?NCsvQzI3Y09ma3FBVGlTYXNoOHhYU0tNbU8rOHJFVFhXSExUSXdOSldZZ3I5?=
 =?utf-8?B?WXI2eVcxQm1VcytkSGxwSEdxYWVVSHkrV1FPN2ZpNlR3SUJKZ3Y3NGxCb0pa?=
 =?utf-8?B?UWVsUmM3RmQ5K0k4cGswQjVTQ2JwMVk2TWF3ajQrVDZwbVRSMVI0T3J2dEdJ?=
 =?utf-8?B?cUE0S2VLcnVHWUZMQkw4LzBnSlo0ME9LWXN0VVdFTFJiTmhPMTJKell6eDhI?=
 =?utf-8?B?cjk5MCtoaWgrRHNFbU1LVGt4Y3hZM29yTGF1MHBSSGY2Y1cvSVllUDBqVXJB?=
 =?utf-8?B?R1hUZURzV1pRdG1ERTUzbDdUZkZVVlBnVVNuVlI4ZThIb1VLZkJ0VWRITC90?=
 =?utf-8?B?MHozK1FZK1hsV1JRRE52bnRlc1VBZWJ1alZISVZuakE0MmNaSENGK1JtenJn?=
 =?utf-8?B?VUJucFQzVFhBYWt4VjRjcmdWa2k0UmVtVXZ5YlI4WUVvcUxBZEtsSjFIRyth?=
 =?utf-8?B?eDNWbEJ0WG9oUzhUaTdYU1ZqMG9mY0V6a3REcGNOK0lNYUZ0d3Y3bTNyMktO?=
 =?utf-8?B?MlZQVmFkaC9teHhrcHBTZUFFSHZVQnViZ1FhcDRZM2pJZlBodnFuZnVpT1lk?=
 =?utf-8?B?Z3FWUE9sbE1GU2JJZThyRnE4akdPSHF6SzJ5VHVaRXk2NTk5cldBSFVBTXcy?=
 =?utf-8?B?TjRyV05Pc1ozQzVDb1dTdDA2anV1SExQaHFYWEtxQUtDZDI1U1ViTkRvN25Q?=
 =?utf-8?B?dVFGQ2xOZUZSbk55NmppZTAyL21sYnNkaHdnUzVUOTVvT3g2K3c1aVNrY3hh?=
 =?utf-8?Q?XR99/It9N934Ak4oreExmGMv4EFOBQZSxUSNjxLX5G5M=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff85a12-af2a-4f63-82b5-08dd382229fc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 00:42:34.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6663

On 1/19/2025 2:34 AM, Xin Li wrote:
> On 1/18/2025 5:50 AM, Ethan Zhao wrote:
>> Hi, Xin, Peter
>>
>>    While checking the asm code of arch/x86/entry/entry_fred.o about 
>> function fred_hwexc(),
>> found the code was generated as following :
>>
>> 0000000000000200 <fred_hwexc.constprop.0>:
>>   200:   0f b6 87 a4 00 00 00    movzbl 0xa4(%rdi),%eax
>>   207:   3c 0e                   cmp    $0xe,%al /* match X86_TRAP_PF */
>>   209:   75 05                   jne    210 
>> <fred_hwexc.constprop.0+0x10>
>>   20b:   e9 00 00 00 00          jmp    210 
>> <fred_hwexc.constprop.0+0x10>
>>   210:   3c 0b                   cmp    $0xb,%al
>>   212:   74 6a                   je     27e 
>> <fred_hwexc.constprop.0+0x7e>
>>   214:   77 17                   ja     22d 
>> <fred_hwexc.constprop.0+0x2d>
>>   216:   3c 06                   cmp    $0x6,%al
>>   218:   0f 84 83 00 00 00       je     2a1 
>> <fred_hwexc.constprop.0+0xa1>
>>   21e:   76 29                   jbe    249 
>> <fred_hwexc.constprop.0+0x49>
>>   220:   3c 08                   cmp    $0x8,%al
>>   222:   74 78                   je     29c 
>> <fred_hwexc.constprop.0+0x9c>
>>   224:   3c 0a                   cmp    $0xa,%al
>>   226:   75 18                   jne    240 
>> <fred_hwexc.constprop.0+0x40>
>>   228:   e9 00 00 00 00          jmp    22d 
>> <fred_hwexc.constprop.0+0x2d>
>>   22d:   3c 11                   cmp    $0x11,%al
>>   22f:   74 66                   je     297 
>> <fred_hwexc.constprop.0+0x97>
>>   231:   76 2c                   jbe    25f 
>> <fred_hwexc.constprop.0+0x5f>
>>   233:   3c 13                   cmp    $0x13,%al
>>   235:   74 5b                   je     292 
>> <fred_hwexc.constprop.0+0x92>
>>   237:   3c 15                   cmp    $0x15,%al
>>   239:   75 1b                   jne    256 
>> <fred_hwexc.constprop.0+0x56>
>>   23b:   e9 00 00 00 00          jmp    240 
>> <fred_hwexc.constprop.0+0x40>
>>   240:   3c 07                   cmp    $0x7,%al
>>   242:   75 49                   jne    28d 
>> <fred_hwexc.constprop.0+0x8d>
>>   244:   e9 00 00 00 00          jmp    249 
>> <fred_hwexc.constprop.0+0x49>
>>   249:   3c 01                   cmp    $0x1,%al
>>   24b:   74 3b                   je     288 
>> <fred_hwexc.constprop.0+0x88>
>>   24d:   3c 05                   cmp    $0x5,%al
>>   24f:   75 1b                   jne    26c 
>> <fred_hwexc.constprop.0+0x6c>
>>   251:   e9 00 00 00 00          jmp    256 
>> <fred_hwexc.constprop.0+0x56>
>>   256:   3c 12                   cmp    $0x12,%al
>>   258:   75 33                   jne    28d 
>> <fred_hwexc.constprop.0+0x8d>
>>   25a:   e9 00 00 00 00          jmp    25f 
>> <fred_hwexc.constprop.0+0x5f>
>>
>> seems the following calling to exc_page_fault() was optimized out 
>> from fred_hwexc() by gcc,
>>
>> if(likely(regs->fred_ss.vector==X86_TRAP_PF))
>> returnexc_page_fault(regs,error_code);
>>
>> gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
>>
>> GNU objdump (GNU Binutils) 2.43
>>
>>
>> default kernel config.
>> .config:CONFIG_X86_FRED=y
>>
>> my understanding, -O2 is the default kernel KBUILD_CFLAGS
>> So, Are there any workaround needed to make the kernel works with 
>> default build ?
>> or just as Peter said in another loop, manually loading some event 
>> bits to make the
>> over-smart gcc behave normally ？or fall back to -O(ption)0 ?
>>
>> Any idea, much appreciated !
>
> This is an optimization done in the original code:
>
> static noinstr void fred_hwexc(struct pt_regs *regs, unsigned long 
> error_code)
> {
>         /* Optimize for #PF. That's the only exception which matters 
> performance wise */
>         if (likely(regs->fred_ss.vector == X86_TRAP_PF))

The following line code was lost in the asm code after compiling !

Thanks,

Ethan

> return exc_page_fault(regs, error_code);
>
>         switch (regs->fred_ss.vector) {
>

