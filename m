Return-Path: <stable+bounces-109425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10FEA15B93
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 06:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C552D7A3F1B
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 05:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C0613633F;
	Sat, 18 Jan 2025 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ei/cLc6w"
X-Original-To: stable@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01olkn2081.outbound.protection.outlook.com [40.92.53.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152C2907;
	Sat, 18 Jan 2025 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737179724; cv=fail; b=Yvv7ZwQYMv3fKNm6aO1FGeloaB46BPfK/4wnXrdm6a3PT1BZcdIIPIQ9VKWFctqdDCwwFh9q1jGfv+FA7cfxZzfDc0wPOzlX8Vo+quOgQP6YjrqgoCxjJrNTQfFllnmRKAkgPcpQJbUknF6P8z61qyxxFCRzRTG1u0V51KTmmFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737179724; c=relaxed/simple;
	bh=4mXXJvdmijBRKmFhk0uVem7zTdtkWf7lka1C42TIvjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cofs4qeMPVemFzeikiK3yVg/luLWPJ2o1xR5oWciEbtJmCRLunLJetYlAe13OsdumeNJCI4FWaOp61VfvC40gm5gzqt14Rp9laA63lnlbaGjjB7UpDx6LcXpMziUZnLTVaPj8gAowS1Ff0zJXG2XrmkOmRdajMdlRY9NZwp7d4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ei/cLc6w; arc=fail smtp.client-ip=40.92.53.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwCjSdcy9bWAJAs1fyucuhr9MdmnHI99zxBtoE5hDqncbQ/9oBPZPKlWy7E0cy8K3tZMK3cQ4k+iUFPqSZsZmALApI4G8H5XW6lfZ8ZRsc7FSJZ/lElBYdK+RsQBTacoK6PCpVagmRYPqtbq/30wRY5UC+Sv1vRJZex8bKs6B4/El4lJB6I38vjhqS3WfZWlDoPa08ldCrjqfQrcV71zJ+ngB+EArmfCQQxlnCUVLgqjM+FyRn06yK6cNRWhAIQ1GQu4+c5KRvpf6POISHLYUkQ58BILFOY8CdOAJKDmuzZc1qOwH/1tec1aJQz5Apig99ZxHcdwOou91w6DsNNF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCP/6YEDo1LqbvOy8QOwmzY+t2iqaZ+3+wi9KWopTkM=;
 b=S7v9m0vhlAcuOPKZS9OcYBbnn+IZMJ7PhidhXOOMKP7nExY0TD3cX8y9GOhB6KOPkV1/nf6dWCMhwYy8g1+uVpcLP4bdChYwyMqjDjgBVm0fhsj2AikQPke9g4eCkTv3+IDnEpUlllg6DqQHPrzW8XuNZKE7LNeUoV7GORUqPv2QQK9z8+KV3iI8Wz5wAwrO6YhySeroCvFoy8pDCX6ia7fPshVqzpwdA6MUfeqzXMddVZCc7qKQqLjF6ogtmg8/nYMjnN1JV7mZMCj2+tcKGkUiVxsGTJMKznMgj0gMkgF3gFh0oF8sQQOyozugsY8/rksMjaJjJfsbiGKRJYirKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCP/6YEDo1LqbvOy8QOwmzY+t2iqaZ+3+wi9KWopTkM=;
 b=ei/cLc6wODL+GyjjAH0MmxbcG85Cc0vV0e8eLdp6y4tHshC0CSfxpM1UnEE1PvjXv2C24paqYRwas9I7gs6fYGjoXkGA/YzUIi5+eSZ9FCK/fbjLUJ5MuUcifcK2dmJCJYkklOZGuxE37M/buoEz6MWdcumNLUcyVcCFwnzxCLyiqTBf+TbvpKCvOy67gLIL8pS/HHj1noDNfJPVL6Fhkx3PGd6JE4Jr81rFOaGBTZXD1zk8GTd3VHXL8FnbrANK0L/pL6ZcJg2pepflr0pNtNTujtuV1R3nXERhPFLRKzvzJD8q8uIbcppR/NuS13AQ8NKXpnt+l6nJ8i3P3i1mBg==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by JH0PR03MB8639.apcprd03.prod.outlook.com (2603:1096:990:8e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Sat, 18 Jan
 2025 05:55:16 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 05:55:16 +0000
Message-ID:
 <TYZPR03MB8801296B664D17C219E891C2D1E52@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Sat, 18 Jan 2025 13:55:14 +0800
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
 <F6B47DBD-0350-4966-9C82-3B252A6D8224@zytor.com>
Content-Language: en-US
From: Ethan Zhao <etzhao@outlook.com>
In-Reply-To: <F6B47DBD-0350-4966-9C82-3B252A6D8224@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <dcdd5f79-6abe-48ba-bba0-3aa7ca0ce331@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|JH0PR03MB8639:EE_
X-MS-Office365-Filtering-Correlation-Id: e82d954a-df0a-496c-5193-08dd3784add4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|19110799003|6090799003|461199028|15080799006|36102599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkdzNkwrOHFIRkp3bTN5Nm1lTzUvK0pqaWdvak44eWRUUFk1MTF6Qy8zSFRn?=
 =?utf-8?B?eWhBc0NTcVV0YXRaNnJtcklXSEpIYzdTVFJ1UERiTGJyN3pSL0dpNjVCeGU2?=
 =?utf-8?B?YXRJOTZJV0d4N3JjT0FLWGY1Tzl1RU5Bb09NYTlUYXBYM09YK0xUamxidlhD?=
 =?utf-8?B?V2oxY0lZQW5XVTJ2T1M0YXRGWkwwVkxVTUsrYW5sczlHRmRnOTdtcTZIMTdt?=
 =?utf-8?B?aERsa3YrRUNyNFNzZmhmdGEwL0JSSlZ4T0lrK0VKUEVpTVZLbkVaL0E1MDZ5?=
 =?utf-8?B?SVl3SnJiSHNaY243aVRHYjA1aWRYYzlWb3AvRlNrQ3N4OWZCOFZhb245NitP?=
 =?utf-8?B?dWdYUmQrVlpXZHcyTEszVExyT1FWWUtteFpndkFEOXRDajZoemFtazFlL3BL?=
 =?utf-8?B?Q0Q5OEFEVFhvZFBTTG10RTEra0EyYnNHWnJ4bGFMVXpkQmRjeWVXWTJQOFp3?=
 =?utf-8?B?bm1CUm5SS3MweS9VNTl4dXdvRUJRRmFBWHpMSUlIVkxuZjBzOVVpWHhiNVNY?=
 =?utf-8?B?NEdIR0kwdzFrL0p0Vldpc1RSV3VvZTVzQ2s1UTFJY2xuOEVxTW93ZnlaNVNa?=
 =?utf-8?B?VkQzTHFTVTdyZE9SbU1lTXhtMi9sQ21lUWgzSXRDU0dVNFduL2poN1JGa2tU?=
 =?utf-8?B?Nm8yN3BlUXJPNWU4Vk43OHN6dVkzYnBBWXhrVUMxVGtKZmJmaitHQzA3TmFU?=
 =?utf-8?B?Rm9GOCtTd29YODlSOW0xcTBEUHk2dFUxQ0FoeTZQclliSEtyRkdSZ3N3R2lD?=
 =?utf-8?B?bGZGdkN3cllhUENUb2pVWlVYZVp2U0lreEhMOVV2SDlCMWlld2VBQm5ZNEFz?=
 =?utf-8?B?SUtpZ2VsVHZ5NTBOYWhnN3FxSDBqSGw3VG44UVNCa0JMdHdKd0orSmFRZjB6?=
 =?utf-8?B?TGtLOW4vMG9NUXUwRFB5VFlwRXpHekZMY3VHdFo3TzhuSTFRVWtqODlZdFpB?=
 =?utf-8?B?NmxhNEsvK0lyNlZBclg2dllGaEhhZzVtS3o5OWFsU0dibVJsWFdERWNRVEo3?=
 =?utf-8?B?ZXV5WkswcjByM0ROSTFXUHBkbk90VUpiSFJMc0diVEh4MTFqMGswa0IzQ0Yv?=
 =?utf-8?B?N0V1RitYYUp4SFp2NWVNcFR2OVRyOHNveW81SjJwUFppTm1kRDJhQmt4Uzhh?=
 =?utf-8?B?M0pNNmQwR3lObTQ0a2hSdUNxN1JlQlpQRE5wd0M5dzlDUkllZnlqeFdtUGs0?=
 =?utf-8?B?L0dZczZHdDEzbGl2bzRnQUFveEV5cFk0aUwrM1pOMVZnYWpGL3ZWSUIyOVdt?=
 =?utf-8?B?NE4zLzJyanlJclhCNk52WDkzdkhrd05TaVVWTVVITjdHS3JIVHJVZEhTbFRW?=
 =?utf-8?B?d05qMTZvK2pnY2RqWUVpaFd2b3BEQnM5UkRVZlJXRjhYV082Snhjc3dvK0tr?=
 =?utf-8?B?NGF4Q2VRYVUvZzFkeTJEWFdsYzRSVFRURnZGc0VzTlRXRThXN1Y1T2JvTnNh?=
 =?utf-8?B?MUhUcHF0Wkc3dHE2R01yWGV1azZod2xEUXp6ckU1cE51SXFvS2JUa2lqMDBM?=
 =?utf-8?Q?LNW/Zc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1hVbGRON2FSUEhTVnNNeXBPRitmRDc0Qmh0dVE5eDZ1STQwSHNsNVpPU2Iz?=
 =?utf-8?B?L09mNmtUQ3ByQit0aDRMT1UzS3pvNDV3L3BrVXNFT3ZpNlREei9VRk9VTkp5?=
 =?utf-8?B?SWhHVmgzNzFBSzV5V0lMUFl6VVIrVmJmYWFzQVZoY2xJVlpSZmUvQzYzb20z?=
 =?utf-8?B?RHl5d2NGeHRpR081dlJjZWJZbmZOMmVUT3pzeFdxR2g4VzhNcXlhdkNjdnNV?=
 =?utf-8?B?UjBVYUwxZDQyMzNMMTk4emQ2NFNDV2tYcjNTUTNHVDNENEZwSXZFOFc5SExW?=
 =?utf-8?B?NmNoRlVZdVpsVFpUT1ZMTEVsMFRpYU5MYjdZRWVHSURhVHFEdmR3UTB4Slc4?=
 =?utf-8?B?SkxJTWo2S1pWMWZmakI5QysyL0F1bnRGMmc4OW84bENhUExyYi9taEdZclp2?=
 =?utf-8?B?NUJkZlVRU0x6bnJPRUlhSVMzd3F6eWgvOUJQRG5WTm9LcnF0UFljVndrOEhK?=
 =?utf-8?B?aU15dlk1OHBZc28wUTg2RnN3SmNHRzN3dDhqYUZrSzNRZUFBVmIxWkVtQkE1?=
 =?utf-8?B?SVk3WGpxVmtGbGVzQWFkQWpjR2FtVTVJUjhBaEFsenRiZ0x6aFdVekVkTUEv?=
 =?utf-8?B?cklMMTRhRlN4Smc5Q0VWc0VzS1J3d3JMTjNKc0wzTENxNU5uamo4SzFBN1ZB?=
 =?utf-8?B?VW9ubFNCUit0WjZjUUNzSjVwQ0laNEdjRE1TY283NmlZUHdlVHBSanl5TWY1?=
 =?utf-8?B?eVZoVXQrU1dWMDFNL2pnaG93VWNTVlBKc2tOQ0NpWUVOYVcvNzhIRGVtcDY0?=
 =?utf-8?B?SjEwWlAzSVJTRkFHOHFaeFN1cEx2aE1tekpaNFUySmZybWtSS1JycHlFNUdh?=
 =?utf-8?B?REpYVEw0a05rbk9odDFWUmVxWCt2emVSYnJkdkZqWFRMdHFNUGhHd1ZuM0ly?=
 =?utf-8?B?MU1GQ21oTUFOdXJSbzA5ZWhwY29JZDkwV0dGTExIek9vdXVudzg0WTlJaHZS?=
 =?utf-8?B?Y3FoZHZ5eFNGNlhXcjhrcmIvY0JCWStMN1dvZTU0T1ROTmlpamtaMXFXN25N?=
 =?utf-8?B?bURoOTdtZFZGYnNvZHNOSTRaSFNPUFo4MFRZY3VGaEpyZ0dId0Y1ZUhzZlJ6?=
 =?utf-8?B?cGtmTTVBcERQOGo1U3RIY3Fta0FLWkFUNDJFKzRqcEx5U0hKb29KdjFWOGdP?=
 =?utf-8?B?SVNxVmVPRWdCdXI5a3hLckVRTVVTQndjbk9kbkdmRUg2K3Ayc2UwRUd4eW54?=
 =?utf-8?B?YjRkTzltN2d1RHE4Wmdjc1JjUHZaVkMxaXFYVDJYRXltdFFWRjRZUy93VGNB?=
 =?utf-8?B?Mkg0TEU3cndYTzh0VkFOSVR0Z3NoeWEzcThxMGdzbEQzczhwVUR3eG1aRW5E?=
 =?utf-8?B?L1Z1OVAyeHc4V0hHaEtzeEVRZThiMmEzcXJRWHJLVVc0N1ZnQyt1dm9uaGVF?=
 =?utf-8?B?QlR0Ylk4eHp6MXVyVzEybnNNYk9Yc1RMUjNQWlZndWVBNTM3eGVweHJERW41?=
 =?utf-8?B?UWFFVS9ldU1reHdCQ3hVRmY1dnJacHJyN2FoU2oyekU0WU9UaDJNTnBZRHZm?=
 =?utf-8?B?VXMySE9NSEUwS20xR1ZOMFJ3NGx5VnplNldieDF0VEEwRDhZT2tUcSs2eVlK?=
 =?utf-8?B?dDcvM3ArK0o4QitmNjJSOS9NSERXb2lLVnc5UUp4YWF2cHpTMGZNdTJ1S01T?=
 =?utf-8?Q?8lFt7IfKEsBc8q7c/vbB3IaJgSugOPIALMbUv0bpW9Eo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82d954a-df0a-496c-5193-08dd3784add4
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 05:55:15.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8639

On 1/18/2025 12:09 PM, H. Peter Anvin wrote:
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
> As I said, it is OK for an ancient compiler (gcc 8 is the oldest compiler still supported) to *not have an improvement* as long as it doesn't make it worse.

There are always surprise that some customers want new features but wouldn't throw away much older pre-ancient toolchains (gcc etc)\kernels,and they
really have justification (business system). refuse to provide service ? hmmm :(,  they wanna both "no changing" (old system) and "changing" (new feature
and performance improvement). this is the way some guys living forward by looking & working backwards. so a little sensitive for 'the last' :)

Thanks,
Ethan


