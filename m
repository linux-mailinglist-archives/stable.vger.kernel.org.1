Return-Path: <stable+bounces-109442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8451FA15D3A
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 14:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95124166FC9
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3103B18CBF2;
	Sat, 18 Jan 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dl/T4MZ5"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2051.outbound.protection.outlook.com [40.92.52.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A22F50;
	Sat, 18 Jan 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737208266; cv=fail; b=XiGr9X0/dAcGOgLmWwkCwWTYWHUykM5WcKBPPF9lCrcWwYP/iStWnF23z6AxHMdC06HWd0VPFJ3OV7vhL2JoTNrLe42hdw80kQBjC6RKocDqRNaJ/wcZCnjfxQmv09IGLYCxUtDtJ3XzAeatlWXpKHuAhKj0ck+6+QhcTDGc2bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737208266; c=relaxed/simple;
	bh=x3yYj1WoDPiip/aWdj8cyrqQdwvLBtADGsNeqPkZ2Ds=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=U3X9loKGMAQQHBI5WeSQMAKKx/z0/rkBr3BamQLqVh/+2Q208QeSWv0oNcVY4uKQCwfHGni+xJwKzbGf5sYYL1ywYiKniLAiW2VMALgcmebVieYZ1mLTnOhTDp/RwARpcz+OG5qaer+0WTPGWsnZr9WXj6xg5Ye4aGoMxQCCRwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dl/T4MZ5; arc=fail smtp.client-ip=40.92.52.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPx3JNzXRQhQDh+onpxMKuPHYn+50beN0Wdn+rtSsLOERx3V5TUgwDr58SlOg0V2MrmpYWKRBv1zBIjGvd1tNEtreW6Ymmq5yNs2Xaj4wMqWn9/1UHhmwfNp9JefiDCs853jwIFqKm41owkmAhLnzlAIbVw7wkgF8DGFimFC7j1zfclAM0PJDY5d1orW3fR4FEoiqm2BhFV/Qs+/MGKR1U3aBd4PUeSqcUdpQJx68FllnBbCBQO67p9GyGUx3eAJUtahHOOHQ8GxIsF1fpG96xwmtrjH8qXpxsFnLToTvumvIQFCbW5Y10z20vwcxc0K0m7XDUsAkhggW5CFw9+Ckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5yB4Cdg07LCRNQumy9Wko9tAFDQHyvzlxv3SHBGf1A=;
 b=hoXh9MkWF5hvC7yzrmd9YjeGMkdEYqUyZOxM382gGbbUC8gGur0p3bENKTbq6vWKo+TJrWue61xIBRw6pCpgo0bhSxuVXDZC0pl/C1YQ/NOtYWjsua9ItRzyEKDFpohdgDeTs+8hOIYfSQYxjzic6d+iJt+W2V1+tNzze1MBgQ0thN0xLrOeEHOfD2cm0PIBer/8vUXi6cZLo6EpN3ggudFAQm7w/oQ3qcvisDd/lEwP/0vEtt8DmOQfXcAdTJFALdwk80iXyMLMZZ/1Imaw2Fh+pPh7cz+YgxyTzXJ7pBF3/XgZ5mLB4ouLsrydJSTk3BZ730U2RFGPvRCF7r6PdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5yB4Cdg07LCRNQumy9Wko9tAFDQHyvzlxv3SHBGf1A=;
 b=dl/T4MZ5OPJYXmvWESWkwAoOKdWxBdbXaCsQSN1tvM2TvdSOwI3s/YjywTVz02AVatQ62BcIB2mZwvt+KrB1jccHhTOapAJIx3yZzLZWptIryViIZZaD98RKzSD1EDSlq5cl61U3jPtg/Kcj/7b9hUME9cXK/9nDLfCwEnQBxdp6uRVcBkvFU8XjnAL3QexZmElv5co3gD4l1INEaXz9PkqGGF6b4umozzbERuhlVRlPVPG66AYoP8G4iYk330KnJWW0HguXxRuI97541PIqdo0p/kvRrdrIRYcuoXQAF39hO7iqyygfHl3iKqAD1iY2B1lEbDoMlY/C5Yb/imkajg==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by PUZPR03MB7063.apcprd03.prod.outlook.com (2603:1096:301:114::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.19; Sat, 18 Jan
 2025 13:51:00 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 13:50:59 +0000
Message-ID:
 <TYZPR03MB88013AABBBC2B40F7B955825D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Sat, 18 Jan 2025 21:50:55 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@linux.intel.com, tglx@linutronix.de, stable@vger.kernel.org,
 Ethan Zhao <haifeng.zhao@linux.intel.com>
From: Ethan Zhao <etzhao@outlook.com>
Subject: BUG ? exc_page_fault() was optimized out of fred_hwexc() by gcc with
 default kernel build option (-O2).
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <561d4d03-37d2-45de-96e6-6d43317a4a75@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|PUZPR03MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: b585cfdb-20f9-4ea5-a833-08dd37c723a7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|5072599009|15080799006|36102599003|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFdVeE1aSnFhZGM0M2xwTU10ZEdzOVVBUnlGcDMwcThFUWdBc1JYNHVNZmtZ?=
 =?utf-8?B?LzlUNmMzL2drV2dPOS9CcUJYMTY5QmJpZzh5ME5xUTdiYzVBdU5SSUpkN0RH?=
 =?utf-8?B?NHJhTDBUNkEwZGRBdVlYMDQxeFM0VjdGZThhempPQnNjdHhQbTltWDh0VHFP?=
 =?utf-8?B?Q2FYbGlEaDdEQk9LTVlWRUI4SzdGQjhxQjYwNllUNkVSWDdxWXJWZXdtOHF3?=
 =?utf-8?B?cUZiOXAzekdMTkdKSExPYzBPbzZ6b3krWS9lL2oyQzVqRDZmSkhUNHRJU2di?=
 =?utf-8?B?dmxvdHpPbXZUWkQ0UFpDVDdxUFZra25LRnhNQUFPT1drYmVDb24zWXZ3Y25T?=
 =?utf-8?B?S1c3dzhwSG9FandLcllsZlNCdGhhY0ExcXVybDBhQmhLZnMvZFNBU25yRjQv?=
 =?utf-8?B?bHRwYVVGNE95M25SdVBmWkswRGY2UVdLeUcrSTRDV0tqZTJxN05NTDR4TzZj?=
 =?utf-8?B?engrK2pyeDlCR2ovU3RNNUhwdnpMN0JUUUkxMUYzQVlvRm01eCt5ZjkvQWtv?=
 =?utf-8?B?L3ZER3NIWFFvT1A5OEZWSWU1b1Bka3Q0dGZmd3BPWld6bWNRNFpTazliYWli?=
 =?utf-8?B?NVRPejBVRzJRUmhlK1lWTTVzcnNucE01eHZZQktYTS8rTHVZWFZTOHFrUGpD?=
 =?utf-8?B?M3NKcVpldVl6czloRlFVNVgrVVUxKytCUkMxQVpSd2dnMVBTa05OMmYyaWZI?=
 =?utf-8?B?SmltUEI3d01CSGN3eGJ2MVF6UlhncnR2Mkg1dmF5SWJQMG9iVmpqVERKY3FN?=
 =?utf-8?B?MjY3alBVN1dRSVpFRTNjNGJiVTgxNFhSRWtrU2VnT0lXYlZMeVo5VTlkZTVN?=
 =?utf-8?B?MjV4d21KUWIvcUlMTThWd1U3S2FBN01Ja1RDc1RjSzlxaGpGbGN1VGVpbHBG?=
 =?utf-8?B?OUN3a0dLMmFtNDhVSFkrdzFMYXJhN25tT3ZHZ3NVbkkvQndwYmR2S1pMLzRZ?=
 =?utf-8?B?VzdvdDJDb3dTbWp4ZGhJeldCOUpxYytsZlA5alN4aDhKMHVvcWk2aDRSYzdt?=
 =?utf-8?B?UWh6RThDNDUzcVd5WFlUOEtLVlBGVWtpTXpqL25BSnRLVkgxL29iTzRnNHNE?=
 =?utf-8?B?MklRMmN1RTNUdnlVTkxjZzNZaFUyc3BMbXR0UlEwelU0bWl4c2FVa0U2NGN0?=
 =?utf-8?B?dVNFSXJhL0Fqd0dlY2ZMVlhKeUUxVUp1MmNCY0hNdjg0SXBIRzk2Z2FDZWhv?=
 =?utf-8?B?TUhHRE5DU084Y0Yzem1mY3FMVFZTQnFtZnd1SVFLWGo5cFIxdnYrOVU0amp2?=
 =?utf-8?B?TWJPSmVvSnRWWlZjR3JXc3JyZFdkQmp5Mlo1ZDQ1ZFBLckhxOHZpdm1zWncv?=
 =?utf-8?B?dWVYK1E2eFJMekozUjFXM3VsREpUTXZZNzVxWkZYTEZCdDJuajRBVVJhTmkx?=
 =?utf-8?B?QjJYbWdNTWxlWjNaMmRxYzNobmdKV08xaFNKYXoxSmxxRUxrcTVjZG94c1pG?=
 =?utf-8?B?ZTVYUEFqUXV1dDRvY241NEI1cCtQUXpCK1ErSnJxVkdVWCtvZStsanA4UGJy?=
 =?utf-8?Q?X+HqnY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0NoSzY2MDBRN2hoT0gyVDFhSWVqSWxJMEh4R1RCNU12ZktvcTJYVHhSRXBO?=
 =?utf-8?B?SFRieHpYWmc1MVhXUTQ0UDByMnFaamhKMGxYbFNVSFg1M2FPN2MweXc2YnVT?=
 =?utf-8?B?TE01QkRIRHRQS0hnYWp4QmlBUUxjZzNQaUt2dUFFcnJpVEdkOVNFNnhpcVox?=
 =?utf-8?B?eGhwQzZzTFF4VFp6bGNGcWN4amVOWFB2VE8rM1d0dHVwOHk5VHRsRXJuYWNW?=
 =?utf-8?B?aWVCQkZiRndpWGJVSE41ODJxZzVlUG5rL1kvN0lvQzhRNTNGOVBVS2diQ1Qz?=
 =?utf-8?B?WElJeFhSSjVZNnBoZTU5eFZ3b1FqQXZna3FUY3JoMGJOME5ZV2kxdlNVbHNa?=
 =?utf-8?B?eXhuQmtZUHJRSmR0ZWRBUElhSENmaFgrNjhtdDBZNlAwQ2l1b0tvZ3pIazRy?=
 =?utf-8?B?cEFpRkZoRzZ3bXgwR1JYN0lKL3NnMWhCQUU1cHFGeEE5YjExdksvNWRlejU0?=
 =?utf-8?B?OW9TOUhaelBXZ0NIdHUyYlYvT2lIRkVEcHc1NEl1RllaaTZsc3U1dVNkV2Zl?=
 =?utf-8?B?N3krc0EyQWRVczl6T3YwS0NVckRoTXU1YU1rdXNtUXVIVVVpWmU3NlFHOUNO?=
 =?utf-8?B?L2tQbExzQlJRdGRBWStRVy9mVnM0M2lyL3RWcitZZjVhVWdLc2FDa0tXS3Zl?=
 =?utf-8?B?SmJERjZVYXZsWFJHcWtKd3A0TmxpWDVOZ2o5SjY2M0lTcktBVzVrdi8yM1J3?=
 =?utf-8?B?VkRqWnl1WnRYK1ZIMGpYNlRmN1BhQTg5V3VhaTJOUVM3WGRsdTRXaDArLzFK?=
 =?utf-8?B?MEx1aW5CZlErNkoycFBqTXAwZ1FRajVLQXNpTllPSG1yNkRkT3BxdEdwd2F4?=
 =?utf-8?B?ZWhHczBuSWNRV0F5MGhnd2l0YjkwcHFvU1kyUmI5VTIraFltTDE3d0VSOE10?=
 =?utf-8?B?bi8rSy9XdlhNTjI0M3g0UmlGNGJnZittWUc2Yk42Mk1aZnJjNjREcnluZVNE?=
 =?utf-8?B?dFhkZTJDVG1JNUxzTWJCeExlN2xGWTNONWNXbkhEclpXSjVvek9YbllSWG14?=
 =?utf-8?B?OHZFQlZBanN4MDY2VTY3Y05iYk9YR0FsSTJXOHIrVG5HcmFPdlRqY0p2YUpj?=
 =?utf-8?B?dzA1NjRxakl2aUZHMmRmOTFoN0xVZWl2SFFlQW5xSzdwUDdreW1pU2cvNlpH?=
 =?utf-8?B?YzkzZnZsNmUxME9vbWtXNXRkZWNDejMrcUtUOXdTU0xKMU4rUG05NzJJb3Ev?=
 =?utf-8?B?T0ZlRW1xZGRtZm10dDFQcTdER0dMTklRaXRzZ2tpVUNmSGs2UVhHYWhwYml3?=
 =?utf-8?B?dkFjTHRwM1RoK20zcEM2dXhmU1FpSkxFU3RJZmhLaE44dHpzMlR4Rm5pcW54?=
 =?utf-8?B?SzBnR2NzTC9BcHRjVi9FN1REeWdEL3JPV01pUmVYS2dhZFYyRmxFRVVQSlZB?=
 =?utf-8?B?eGpkckxIdzdTcDc2cm5KMjl4ak5TQmI0cEhjNkd5dDZWdVRxOGdvSTlic1dS?=
 =?utf-8?B?QStzTmVvUlNJdHJReXppMWc2UlpiL3Y0WWRaUG5wdVZNU3FzaEdBQTRsbW0x?=
 =?utf-8?B?dlFRbEVsdkprOU9XYjVobkR0TTUvSDA2TjE1Q3pjTElBOEUyL2p1TjBndXRa?=
 =?utf-8?B?ckpyM1dBOFVtemJjWkQ1dDVvZkd5d3BRaEFodTNPZWlrV2RiNW4yZnI4Q0FN?=
 =?utf-8?Q?6wXO0jmIDFhxKGXZmk0fuMgfk2LVgnf0AFmXdGbKHNAw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b585cfdb-20f9-4ea5-a833-08dd37c723a7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 13:50:59.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7063

Hi, Xin, Peter

   While checking the asm code of arch/x86/entry/entry_fred.o about function fred_hwexc(),
found the code was generated as following :

0000000000000200 <fred_hwexc.constprop.0>:
  200:   0f b6 87 a4 00 00 00    movzbl 0xa4(%rdi),%eax
  207:   3c 0e                   cmp    $0xe,%al /* match X86_TRAP_PF */
  209:   75 05                   jne    210 <fred_hwexc.constprop.0+0x10>
  20b:   e9 00 00 00 00          jmp    210 <fred_hwexc.constprop.0+0x10>
  210:   3c 0b                   cmp    $0xb,%al
  212:   74 6a                   je     27e <fred_hwexc.constprop.0+0x7e>
  214:   77 17                   ja     22d <fred_hwexc.constprop.0+0x2d>
  216:   3c 06                   cmp    $0x6,%al
  218:   0f 84 83 00 00 00       je     2a1 <fred_hwexc.constprop.0+0xa1>
  21e:   76 29                   jbe    249 <fred_hwexc.constprop.0+0x49>
  220:   3c 08                   cmp    $0x8,%al
  222:   74 78                   je     29c <fred_hwexc.constprop.0+0x9c>
  224:   3c 0a                   cmp    $0xa,%al
  226:   75 18                   jne    240 <fred_hwexc.constprop.0+0x40>
  228:   e9 00 00 00 00          jmp    22d <fred_hwexc.constprop.0+0x2d>
  22d:   3c 11                   cmp    $0x11,%al
  22f:   74 66                   je     297 <fred_hwexc.constprop.0+0x97>
  231:   76 2c                   jbe    25f <fred_hwexc.constprop.0+0x5f>
  233:   3c 13                   cmp    $0x13,%al
  235:   74 5b                   je     292 <fred_hwexc.constprop.0+0x92>
  237:   3c 15                   cmp    $0x15,%al
  239:   75 1b                   jne    256 <fred_hwexc.constprop.0+0x56>
  23b:   e9 00 00 00 00          jmp    240 <fred_hwexc.constprop.0+0x40>
  240:   3c 07                   cmp    $0x7,%al
  242:   75 49                   jne    28d <fred_hwexc.constprop.0+0x8d>
  244:   e9 00 00 00 00          jmp    249 <fred_hwexc.constprop.0+0x49>
  249:   3c 01                   cmp    $0x1,%al
  24b:   74 3b                   je     288 <fred_hwexc.constprop.0+0x88>
  24d:   3c 05                   cmp    $0x5,%al
  24f:   75 1b                   jne    26c <fred_hwexc.constprop.0+0x6c>
  251:   e9 00 00 00 00          jmp    256 <fred_hwexc.constprop.0+0x56>
  256:   3c 12                   cmp    $0x12,%al
  258:   75 33                   jne    28d <fred_hwexc.constprop.0+0x8d>
  25a:   e9 00 00 00 00          jmp    25f <fred_hwexc.constprop.0+0x5f>

seems the following calling to exc_page_fault() was optimized out from fred_hwexc() by gcc,

if(likely(regs->fred_ss.vector==X86_TRAP_PF))
returnexc_page_fault(regs,error_code);

gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)

GNU objdump (GNU Binutils) 2.43


default kernel config.
.config:CONFIG_X86_FRED=y

my understanding, -O2 is the default kernel KBUILD_CFLAGS
So, Are there any workaround needed to make the kernel works with default build ?
or just as Peter said in another loop, manually loading some event bits to make the
over-smart gcc behave normally ？or fall back to -O(ption)0 ?

Any idea, much appreciated !


Thanks,
Ethan




