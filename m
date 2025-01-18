Return-Path: <stable+bounces-109427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51870A15B97
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 07:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF81188A9C7
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392A01547CC;
	Sat, 18 Jan 2025 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tQEKRLb4"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2052.outbound.protection.outlook.com [40.92.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8814A088;
	Sat, 18 Jan 2025 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737180143; cv=fail; b=nQTev1dO0ThQ4xu2OveUjiWW+c6Oq3G4SH5clK6nzQLCI3Fku7FmLs8vhuSuepcLQaEc7GF8MFa2kxHTYtitHSoKNXF7H5rSWvJG9CB43A3brxL3BWntvOEz69/UeVIXJDvqdPEJQYPNMzYneBf/n2HOUxHoCIZJ21yt02mPh/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737180143; c=relaxed/simple;
	bh=G9I6TFVa5+gXTH0GKzp3D8paJf9STulDA140IlynWEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iSn8J0vXeNgALB8lEQNCIP/HX6Aj2Frhr1BqGXrovt0Yk36MU6GucZ3unig6hdUcOBh4FKAls5niNr8kc7/mT3Svd3Ee1zLkNX8dEG8dp7Va7McEPqglL/0Dtp4PEME6p4ZlUwYdaXZmoV93YnIaGIfzEZ/H//Zxb0KO9fAjq6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tQEKRLb4; arc=fail smtp.client-ip=40.92.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPTTyEp5ffYL3qrOK10GkXkWdBpUUS1kZL9zDMIkTKfKCYUKzX4nqiB4SvZ8Bs9GKEmpRNCCmcvHYA+F/ywmHDfAbO8LNYCfNL734sA4oMEOnVwOf9b/87r1fLbqu1hPx7dj0sgyWavZdkS60GyAo1AsLySzE1L4TFsB+1Qk8qomTcDvqrQfFjzda1YI+oWyRgRz2hW92YmHcI1smdZ1bj8iNgSQoyt2sixHATCOdwFwMMFd2Of2Wde7V8vLTfDkKT8C2t2ugZ2woWeOfyCP08aENTKMcB+LEqVTbc6fgLw/AtHswsNqGSppywRBDjEFUQxD//fBehAAbLbSRkzsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgAXADvKKQ10frr8wTTSa5doV3Hip97igbFSxMiwKgQ=;
 b=cHSCh2P/5ILq7TnMpuWcizTp+4S21jS72pS5bl/9XhljXy1AZRNrr34koUNL+PJ+IZD55cFZHJeiIaA2EgYKFyfWdA3djhty9shebnR91/GjvU8C8ZQbNSyLyNUdhEeCAyo3x9hpMpuY99cOdJrT7blWxjFNgb17bDdniH3H0KGiKRS8MeFLeFBxlAXtap0l7a/Egk7/A5oq9g97AA5Z4cdb070SK23B54qkPIWrWco4cxN1kClNzdkDH8h434MTOd3v/FcyUUQjVzEpWMm9Ee2NPNGsfQO3kkR46+bK1WPa4naFcvvmKvKV5Hc9fYhiQFGGJ1peUstUkZc5kJcwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgAXADvKKQ10frr8wTTSa5doV3Hip97igbFSxMiwKgQ=;
 b=tQEKRLb4HOAnx6mfctjpLGmSjmfZSoPDwHgCYJqudv6da7nRfdcGras2kjKoQC1GohuXZmr4psqm0Q7sPQ6NykQjvZLFV9SEEbQb2jrneIEntaT286q4DvgpF2mDUIJ7IqTM2WJtMQaBn/VBNVKVWrKWEgbvSR6Zhaag8eQKLfvT3tjnPMBOnKChGs65iIx75Ae9PJYhKZrUBPx9e3VXmOcAAP5//A6IF12NCRY7aq13SIGlO3euGIm36nr5GEesd7tgED4IQK6wLGVvhapkAYLQoKf3T1L1OR4aWOLl8E136eVsNqBjpk/CgHNzxIvjy3zkmBLJ5Tng97sbh7xHYw==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by SEYPR03MB7684.apcprd03.prod.outlook.com (2603:1096:101:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Sat, 18 Jan
 2025 06:02:17 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 06:02:16 +0000
Message-ID:
 <TYZPR03MB8801069F4F0FA06AB346C69ED1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Sat, 18 Jan 2025 14:02:15 +0800
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
 <TYZPR03MB880148D071B32806DBB1ACFFD1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <C3BA43FA-06BA-416A-B8C2-0E56F2638D80@zytor.com>
 <TYZPR03MB88015FA45675DD73D8570834D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <228DA62B-BB59-4DDD-8658-67862366C1A2@zytor.com>
Content-Language: en-US
From: Ethan Zhao <etzhao@outlook.com>
In-Reply-To: <228DA62B-BB59-4DDD-8658-67862366C1A2@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To TYZPR03MB8801.apcprd03.prod.outlook.com
 (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <9b2ea080-7fe3-4e74-9994-c789fabf517a@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|SEYPR03MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 51be4e03-647f-47b0-d203-08dd3785a908
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|36102599003|8060799006|19110799003|5072599009|15080799006|6090799003|56899033|12091999003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmQ2R0R6VGpRczdnSUZERW5IN0NibGpNL3RaYitzYnFHR2tFbEdJeEFVb1FL?=
 =?utf-8?B?YjkwK0RtdnByZXkrcXRWQ2VLV2ZXWUtmT0Y0QU9nSmhucTdlajNOUVduWmhw?=
 =?utf-8?B?M3RXVnJGM1ZIYXlNVlU1ckdlNVZ4NGNkRFV6dDR1WDNteDVVQzVuUUFvZkVr?=
 =?utf-8?B?c01wUnpvTjBUVzBHWmVQQnVkeHhBK3E3RWlaZVRWSHJ3TWFpc2JPOUYvNThM?=
 =?utf-8?B?WEU4bGFlVVk2TjhTUnVKSnZWa25OdEprbGpVNW4xLzlvZFJQRzJIZDgwRnpO?=
 =?utf-8?B?Q3Q0Q0wwc3c3bWtEOGczUXhJNXZDajZoTlE2U3NmU0tRQ2h1bU1oRVZFc2Vo?=
 =?utf-8?B?TXV5NWQ5cllnWlhmYVJzMzNIblV2anZtT1orYW5MbEhZUExZRlFrSjVXeEo1?=
 =?utf-8?B?ZVRtOGhsbXhsTW5OMlRsanB1YWhST1BGZWpqbHM3QU41NzVWUFg4ZXhpR3VG?=
 =?utf-8?B?clZRVTQxZW8ybVUvSnBvWldNbkZ3MS9Bam5wc0IwSERxQktUVnNmellZM3A1?=
 =?utf-8?B?VjdiZXJzeW1wZndJOVBRK2xLbXBPallwdXdRWXFBSFJXbzc4dUZTSnpVeXlK?=
 =?utf-8?B?Y3hjTDhCRDhJbHV3czMrU2lPQXNHbEpWR2J0WXJSVXU3T3hXV25YZGtkc3pk?=
 =?utf-8?B?cmVQNlBhUG5wSVMxZ0VBMExtMFRNMnc3ODFlcHkyUDdqbXV3RU9TaTFzdFFz?=
 =?utf-8?B?YmZjem1PaUhKNWVTek44VGxGV2tQZTVqdGp1Vnh2RDRQRnJTNmpxWGJ2NmRj?=
 =?utf-8?B?VThoRlE0R25pNHU1Y0xZdWhpcGtIU2E3aml6WkxvRXBSeGw3SGlJZDFPb2kz?=
 =?utf-8?B?QUZEWGZYYXUxRlhOWkVmNDZ6TlFsbGJJTEtrUEMwelQ4d0V3ZEkrajRsR3p3?=
 =?utf-8?B?bXorRzRENjQrSk15MXNGREY1cW1BWXlFUmkzWjAwOVRGUERMeUhuQUJKdGVO?=
 =?utf-8?B?YWxmUlU4V2xGbXJNYTkzUHlIdTBYNHY4RDZJU2REUy9vVXZhK05xTVpNTmRE?=
 =?utf-8?B?d0pGbmR3WGdKdzczaTN3bXloYTRlbnJ2U2Rxb2dGMHkwNlljazljYzJTRWtu?=
 =?utf-8?B?TDdxTTYzMEorWThtZngzemVNZFB6eVE0L0JhU1V6dnZrY04wUGNaODlZdGs5?=
 =?utf-8?B?MExQak5WWlJVK3FYSTc2eEZYbk84aEVxMGIySG5vZEw0eFlyemJ3VXJTQU0r?=
 =?utf-8?B?VVdYRkd1OThQa1ZmcXZhQXE4ak02S0NYZEtPbWZMS1ZRSSt5LzJ5b0QxWE9G?=
 =?utf-8?B?OTJMNE9JSzBWMzlsN3NuNHRPdVM3dGhMakl3U1MrRUNsRGdvbUdWT3ZPQThi?=
 =?utf-8?B?b0V4NzRKbGI1RTlnM0pYUXFZc0JzM2llWDNPQ0FRcU1abHJWOUVrM1o5bWNv?=
 =?utf-8?B?eTJMZDlaQzY2MEtMQ0UySzhnOW42Mis3NGdhTDhZNk9hNy8wZHdFRlZzVTk0?=
 =?utf-8?B?bzJWM3pKUVhkNkIzTlN1OTd2ZjQvN1pnQzI1bXBhNE5lVldqWFVxWWg0R290?=
 =?utf-8?B?WjZCQW40RzJnajE1cmYzOHlKK2V0cDh6R3BZdjRFZlhrSW9EckdqSFJEbGsw?=
 =?utf-8?B?Zit3UT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWNSNmVYZGJjTHdxcno1MW1jbEJpR3IzOWdaK2l0K3Q4TkNNSW5UeHREQmo1?=
 =?utf-8?B?dWNUUENnUXE3cDl0ZDBlT3VyNXJ1SldzbThsUDZhYXg2YndqMGVKd0RGeFI1?=
 =?utf-8?B?SzBDMjBvT2w5VnNIa1FLV2RQcWkxWjNIWnEyUTNrUk1Qb2dzdHM4N2k5N1NZ?=
 =?utf-8?B?WjlNNnhQM2thNk04aUEzYnFDY3hOWHZkbktCQjJaNkJyQVFCczRYWmhqa2VI?=
 =?utf-8?B?dXR3dHp6b0NDSUI5U3NHS09vMFdqZGp4Q0ZJZldpWmhsdlhaU0JwQURseXQ0?=
 =?utf-8?B?d0dBY1lUSG03cGhmY2Y5c24wdnJ2eVgxOXpocUphcnFqN2hGV2t0NnJqRXU3?=
 =?utf-8?B?cEZHNnJuM0creFI3cFRqeFd4UVN4UHhZa3U4d0Raak1CV1F1aWNLbkRJODl6?=
 =?utf-8?B?Sit6eDNtbjRQQ2JGT3pYNjl5cEs3L3NFMVR0NEZ3OEpBTnJzVjVjcVNlVVd5?=
 =?utf-8?B?SE1EYTZ2WE52Tm5rT1A4UElsN0oyVmNMZG5tUmVrdkhiT2FxcTRTTWRSRG1N?=
 =?utf-8?B?RXVBWXdJclpNQ3NzajJNM3NReDU3VE1ySC9BclVYS2FUMm9xc0NlQXhwaGJy?=
 =?utf-8?B?Nk1ZZDk1VXpyclhjRVRianpiL1BUNFN3S3JlVGRUYURpeFQrWlcxQWRJWVBS?=
 =?utf-8?B?UEFKd2YxRHJhaHg0cllNM3VDdjh0VFk4dC9yd0FwRDgzN3k5N25RWDJXRjhI?=
 =?utf-8?B?QjB2dk9oaEt0NmxBQVlTd2JXdU5jdjhXWDZOK0ZKalFvb1lIMVJqMzlHS29w?=
 =?utf-8?B?NzZ4bGt5Rk55VlE2QnB6MnJwQUlwbk1XU2hzSG5MN005OE1HQ3hqb2ZmSTZD?=
 =?utf-8?B?ZG1XRG0rL3RCdTNwU09tTjMwdytPSktremdjSlhRSnNqRjhJQk0yTW5XZ3Q4?=
 =?utf-8?B?UGpXUEhCRk42N1FONVo5eFhQcldlNXMvRDZyZmU0QXUvWlpjVVlRRHRmb3F2?=
 =?utf-8?B?VUEvbVpUZnRkOTZIQzhGTlVIK2xlMlpuQ3pzTW1oZUtpL3NpSmpOd3J3emhp?=
 =?utf-8?B?bE91UTgyVVBTWFllR2lkdEJxNktZeS9WMWJ1S3YzMjV5cTh0djNjK2R6QVdM?=
 =?utf-8?B?RlVNQWxxVjBrckwvY21yaFBIRnl2NHYxUkhhYk5PeFZTQzR5WTF0V1JGbFk0?=
 =?utf-8?B?VHBuTWtJN3dzTHRBcVNEbVZtTHhhYUNjdWJDR2Y2RUlsVVlDZUFqbnVHcnkw?=
 =?utf-8?B?bUZDM3Y2SzF4SGVNMXNmdXhkazZtQklwcHA4RWJ6WGovVFVBczFkN2ZhNEJ1?=
 =?utf-8?B?amNPNmxZdXNhR2RKQjRmNkxaVjZhSkFSTUZHWmFaRFJKOW1uaEhEeXZ4WThH?=
 =?utf-8?B?WkgxLzVXT1lGcW5YRC9XYld3TjRJWTVNako2bnNxaG5iMWVZbnRsaVpPRGI3?=
 =?utf-8?B?YncyUWFYTzFMK1BKODE5V1lIdXQ5dWFyOVppeExrd0RqZ3J6ak5rUjcwS1hi?=
 =?utf-8?B?cjFlUHZzVEwyTU4wVklMOVovdnc1K2V0ckwrb3M4b2dYa0dvbXNlZDcxM3Zt?=
 =?utf-8?B?KzY2VnZnaStFMkpRSS9pTktzWXIrYVY1bW9rOTZHbGd0ZndNckwyT0k3czNu?=
 =?utf-8?B?bmpFcUFHMXVtYlROYmcvMnFob3h6RElTWmw1RXNmK3RmYmN6NFNXMk05ckdE?=
 =?utf-8?Q?Zng3GKlBURcPT+lmAnPKnfsocp27jFKPK+9y5YhR9JrQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51be4e03-647f-47b0-d203-08dd3785a908
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 06:02:16.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7684

On 1/18/2025 12:14 PM, H. Peter Anvin wrote:
> On January 17, 2025 8:06:27 PM PST, Ethan Zhao <etzhao@outlook.com> wrote:
>> On 1/18/2025 11:41 AM, H. Peter Anvin wrote:
>>> On January 17, 2025 7:29:36 PM PST, Ethan Zhao <etzhao@outlook.com> wrote:
>>>> On 1/18/2025 12:24 AM, H. Peter Anvin wrote:
>>>>>> In short, seems that __builtin_expect not work with switch(), at least for
>>>>>>     gcc version 8.5.0 20210514(RHEL).
>>>>>>
>>>>> For forward-facing optimizations, please don't use an ancient version of gcc as the benchmark.
>>>> Even there is a latest Gcc built-in feature could work for this case, it is highly unlikely that Linus would adopt such trick into upstream kernel (only works for specific ver compiler). the same resultto those downstream vendors/LTS kernels. thus, making an optimization with latest only Gcc would construct an impractical benchmark-only performance barrier. As to the __builtin_expect(), my understanding, it was designed to only work for if(bool value) {
>>>> }
>>>> else if(bool value) {
>>>> } The value of the condition expression returned by __builtin_expect() is a bool const. while switch(variable) expects a variable. so it is normal for Gcc that it doesn't work with it.
>>>>
>>>> If I got something wrong, please let me know.
>>>>
>>>> Thanks,
>>>> Ethan
>>>>
>>>>>       -hpa
>>>>>
>>> That is not true at all; we do that pretty much *all the time*. The reason is that the new compiler versions will become mainstream on a much shorter time scale than the lifespan of kernel code.
>> Yup, time walks forward...
>> But it is very painful to backporting like jobs to make those things in position for eager/no-waiting customers.
>>
>> Thanks,
>> Ethan
>>
>>> We do care about not making the code for the current mainstream compilers *worse* in the process, and we care about not *breaking* the backrev compilers.
> Keep in mind we're not even talking about feature enablement here, but a microoptimization. The latter we really need to be syntactically lightweight and abstracted enough to deal with, for example, compiler changes.

Fully agree. we are looking at 'micro optimization', not feature level, system level optimization, need to be abstracted to micro lightweight method to
verify or think about its pros-cons.

Thanks,
Ethan


