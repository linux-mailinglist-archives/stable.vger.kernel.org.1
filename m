Return-Path: <stable+bounces-109314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB6A1470E
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 01:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EE6188C1B1
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 00:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8A1FC3;
	Fri, 17 Jan 2025 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dOoyVnDf"
X-Original-To: stable@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013079.outbound.protection.outlook.com [52.103.74.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419ED4A29;
	Fri, 17 Jan 2025 00:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737074239; cv=fail; b=oICysnOXqHZvxr6yiVkCCo+xmtwFtF6gnY76BAXRAFzutT4xkgIlX1bXW76eJu4OIWOCESJBBrBfmgvwNzFzvJZuIKG9Qnlsdu+Jjo7Hp5bNGYVBxWMna7nuLrASN2SHxe2VrPC+vbjnNDauFoqeXOYFbrS9Pu0zTnZd3BfCzHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737074239; c=relaxed/simple;
	bh=BMZviHcX9YOs2dVlvRb3s12NiZTRUqgBIouooawstdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vD7OmmKMzr35AuH8DhqGfUajVmquBRJSVRJLIdbUlAibqloZuelvHxEVYaF3XmyZjXYyWoTiEsC5cx7NKXJIoiqLYUTUgyRAryxQaDAAYOo2zf5zgnoZmq60u/27723ubeWWTc7cfAMvIj99uBmcvwUrI/VNoSBtZIaq3G7Q2vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dOoyVnDf; arc=fail smtp.client-ip=52.103.74.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl2PhOyhdt7gRnj/LCNjjnXHkTBaE1MK0EaZAOw3yhtoOcm5oR/LSxCXfTHsWaVuE0dE/cpeywWYI2wn4lSrhMsp6E28YQzXTJHQIHlUgs8iaS9LeDCJ8Bj7ghr8ND7wTafRhRRsP8UzsTmVLH5ueolulkDToIb48sYWQ63F0FEQEwCk/nINUwlRwmv5Lo4fEioCKnPDHNT3CKSk0rlRPG+zCFQjXQbifnuuF0QxdNZ2IOAlP0ihb+yClj19Uehe+zxjv4h/tJfLZLPpbWjQtTALpuumA/2p9hoiuT1vwaAISwoulVFrWHi6NSVMumg3bHbDvy8uVxSzudIBNDBXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hkaS6ndYOnwI6wG+0whMgafo7YBQ7+/g101c70zMtw=;
 b=D0FzsBC8kNf+fiWL//z7u97GayBGJ3Dn4UwKmE0ByOCH8aLxydAbX4lOrqO6cP/AXLXPZkcBjU5GD6USLxk3o2GY/3qGLXRyxzK1PeSZgnKv5cYD4B580SVGOx9ScXlOh37dnMYvxtOvQR3LYsWwi5oPr0QO11CRq8SmlHoHsmRNfIjAPZ2OUHPDGsYkeGHpg4cRt7Ojrwx/ftdPmAD7eVQJz/eIkxaDDrzahElT2KWGOHG28Fwc9RamPXtYKxA/mDbg0lZ2S6oefMSkGI8rnCfTqJI/Daakg9J76jSbyiYoxTvz70YIsqgNQzMQ3QecovxBoXXXgAlXVL6p89r6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hkaS6ndYOnwI6wG+0whMgafo7YBQ7+/g101c70zMtw=;
 b=dOoyVnDfwSAHgMVrMhAXUSNXyY5xYwQK4/mbRGLUFy+HpbMpOudxOUZyjFyDgNy1OcfMi5iyn7JoZRuPydpzOUGgYmjbppxqACSFlhnCK10w6u3GUYOsmJKxyzVWltM1ZYYqgLWcEQwGPg47dI8K9LvgMYpO4Bk1AIrv90jhH/q04IxZec8oOCtG4jtsEEGwGI3XOHAztaH0SpeuaDeDw+qhLTKPcztKparpxo0wKeDh7AHfT1dXzyXEMxLGyOXjLeHNx/63eRMmSQC0oBqVN4aQ95/zOhbYId5Yjgf0C2Ol5CR8g+ld9wHCxpQnoWgN6DpqmvJhMqtQ0deDZJNQsw==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by SEYPR03MB7628.apcprd03.prod.outlook.com (2603:1096:101:13d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 00:37:14 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 00:37:13 +0000
Message-ID:
 <TYZPR03MB88013A5D71079FF9E6776E49D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Fri, 17 Jan 2025 08:37:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Xin Li <xin@zytor.com>, Ethan Zhao <haifeng.zhao@linux.intel.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
 <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
 <TYZPR03MB8801E2BF68A08887A238A32CD11A2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <05b13e99-c7e5-4db7-90bd-a89a91f4e327@zytor.com>
Content-Language: en-US
From: Ethan Zhao <etzhao@outlook.com>
In-Reply-To: <05b13e99-c7e5-4db7-90bd-a89a91f4e327@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To TYZPR03MB8801.apcprd03.prod.outlook.com
 (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <3f5786af-b311-4dda-b42a-fcde82d5e151@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|SEYPR03MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d827bb6-d116-402c-066e-08dd368f15fc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|36102599003|5072599009|8060799006|19110799003|15080799006|461199028|10035399004|440099028|4302099013|18061999006|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzA0RnZPVWdPOXVyNnJUOTZSbENxamZiTWdrRFZkcmN2OUtibGZYcU5KMlpx?=
 =?utf-8?B?S01PQjVFbG1YRDJwUFlhYmpYaHZYTjUrSW1PWlVNY3lNdm9HYTBNYW9SVUU1?=
 =?utf-8?B?WlBLUTlCOTRQTHIrZ2p6aGJQbFJOSkRmK3JjNjhpclBkU2M5VCtPRFRNQVVV?=
 =?utf-8?B?bU5kemZJNjZIUkl3ZHl1MHJpNk9nN1lUdGthVGZEcTloQ2hFTWp0Q0RtQk9R?=
 =?utf-8?B?cS9CaXplR2tlZ2VRUGxMSGVOWnRQVDJIV1lqcjFTT0hib2ZNcUhQc1BXSi9C?=
 =?utf-8?B?NnJrbjFDTXdocGVOSWFUbWV5elVEaXJPczhDRWxSZlhub3NjTVF3ZG9iQk9r?=
 =?utf-8?B?L2RzT3NKSitFcjlYbGJQUWExTDFLdHlYS2haM1krb0N1S1dLNjBNdFltZzY2?=
 =?utf-8?B?MEc2alJ2TnF6WlQyRU5oN1pGTUZDZFYxZ2RNMUZ4SUoxa3lsVDRiUndwb3Zx?=
 =?utf-8?B?cXZmT3AzYTJrV2s4N0VXU1NWMDduRXBOcWxvd3drQkhKR25aY3RKR2RnQ3c0?=
 =?utf-8?B?Ulg1MFFyYjBqSFhYQXFJN0Z4aFo3bDdPK2UxdWZiWFQ0RjY1UWxoa3BUZU5z?=
 =?utf-8?B?czlra0dVTThEcEc3UTJTejBBZEpCdmRrcnNOYUN4Z214TUJzalZPcW1zM0l5?=
 =?utf-8?B?eWozZ0hxcmVFU2s2V2h0NUt3L2ZpczhTWWt6ME8xSWhEdW5WcXYwYWFid2pz?=
 =?utf-8?B?WjYwbzRmRVZkbWVLY1grN3lBOWM2dzNLeUIxV0FFejZkNWUzZThJMmdabVVW?=
 =?utf-8?B?SElHaUVhdHQxMU5Sb3lmMnAxREF1aUxqSEt0MDNKb1VkcHRrOGlsQ1FSWExW?=
 =?utf-8?B?V29EME5PaDA0bWkyYkcyS25yR0JTWXA4Wnl6MFNuSEc2bzZUWjZ2UzBOVGZR?=
 =?utf-8?B?M3NhbERnL0tTeVN6MWRZeCt4NzdBSGU2cjZCU0o3K1dlMTMrS0NyeVh4TjlG?=
 =?utf-8?B?NnRXZVJMdW0yc1VRWTZ1aW8yd2ZnSWRUQ3d3RFE1eHAzUXJkNEd3UnppY05Z?=
 =?utf-8?B?UEV1UlpHZWxoWHExcWZPZmRKaWZkd3ZtVVdvYTlySjdMbFYrUUNDVzZwQlFZ?=
 =?utf-8?B?Qk4yVXlXQ0phQXk4aVlXSERReVlrcGdlTnN4K0dhYVVYQkwwdW95TjYyeVFO?=
 =?utf-8?B?R0VtaU1ZTGtSWGppRGNES2J2bU1aSUFHY0xvYjhYS3pHbkRUUjhkN1ZUMkZT?=
 =?utf-8?B?d1ZtUTIyYVNuZHROcTJYRVI2UFNqTUw1VjdyQW0yNGM5Q25Wb1VTRzdDVVJu?=
 =?utf-8?B?VkVuVzZHM3lqNEV6bXJqalVEcUl1WFlZTXIvVHBkMTBqQ3NEOVk1QzJpeE5Q?=
 =?utf-8?B?cVlMNk5KYkgxR2ZSM0ZRcXUrUC9Xb1NTMXpjcVZmNU9GZ0w0S0l2Q25tV2xT?=
 =?utf-8?B?TzJzSjBDc0lqNFFyZ2lld2FUQTFmSCtCSlRMckRjdXV2Ly93cTZZd2ZOVmZz?=
 =?utf-8?B?amFuejZxcjhPRmU5TlZRNEZ4aVJidjdUWjNld050TU1jR29VRW9MbHE4SytQ?=
 =?utf-8?B?RDR6ZTVRc25GNEIvN0ljaVdMT2lZTFNNeXllWTBvWjNHWTNOaUJtTC9XTnRm?=
 =?utf-8?B?eHBOZ1pVZVVGUTU4dXNvbXMxVHQ0a1dwV2NHZXRlQWVURGhObmNjSzRpN1hC?=
 =?utf-8?B?Vnh0eG1qbDRWSXlucVBsTDZFbTNta2g5YlJBSk1pTU9udElKRlUrV2h3dWxx?=
 =?utf-8?Q?cyGV9lsZ2slTninEH7ie?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THJBM3lONjQvMWFON2Y0UmIzUTJ0Wkl0dkVKdjFrUytCZWl6bzZ3Q0RNYUVt?=
 =?utf-8?B?UFgyWEVOZVhFRFZDRGV3SlljemJheE9MMWN3T1p4T0s3UkU4N081V0NKdkJw?=
 =?utf-8?B?eXRLcVN6TFJvZW9pUUZsdXlUVVgrK0E0YlcyQVhsd3cyZVhUeTc5UHpVT3FP?=
 =?utf-8?B?ZWtKYU1oRlJ6S3ZYVUhXbUFZTlRPaTlmN051K0tMa0treTI1VHBzRExod0pt?=
 =?utf-8?B?OHlPYmVGaDkyQnM0K0xXRy8yeDZyS3JMNWtUenpzV3JySENyZTZ0NzJWYUk4?=
 =?utf-8?B?d1QwcVJRczd3em1LTDJYMTRJcEtyRXF2elE5U2tha012UnFqVHBrdHByV3Na?=
 =?utf-8?B?MW96dlE5d0drQm5ybnJLdEt4VHlXUGN4TVpuMUp6SVZxZ0xkREFnUy9EMTFC?=
 =?utf-8?B?YVVQWG9OWVljMTdOMktGMlNQK2ZwTlUvUWYzZ2FzNXNxemhkZHdxaWQzczYy?=
 =?utf-8?B?YUN1YnBweEFqdGJacmxpNUU2Q1NKZ0t1K0F1THg4cnV2cXY5dWdEUkYwcEtt?=
 =?utf-8?B?MnpNSEp3T1BmRW1ocDVPaXlpWkYvRnJzeDN3U3BnLy9NcDVxY3pNNVNmRnVx?=
 =?utf-8?B?WjBWeCsvSXpiZVhMcFBxSi9yMFpMbk4rMXJBY1I4RG14bENGSDVPbHk0dU8w?=
 =?utf-8?B?cXoyNDR3N0t6WnlQNFlFVSt5WUlMdmttSVp4ZkxQY2UvMWVlcHoxMjZJNzE0?=
 =?utf-8?B?cGZtMmFLZGgwZG1oOTdIbnY5OGR1ZmdHbzV2ZjM5TmprcTlWM0EzNDJ1NGFU?=
 =?utf-8?B?SFUrQkdWamRTU1hiRWdZWENBWjROR28vbkZWUjBLNzVnWjlaZU1Ld1JzbXdj?=
 =?utf-8?B?U2tjWUtTdjJiRWFxZ20zNDdEbjF3WVpWQlVSN0dxMFhXOFBNMGdPUTBQYU0w?=
 =?utf-8?B?ZzNMNUtzVXlOenRGNHVqM0tzZGlyU2pJeFhveHZEdUk1OEUzd0ZMekI1Z0xV?=
 =?utf-8?B?ZWVhREsrRytON0tjMnFiNlRGTTZ4Ynoyak1UcXlDZzBWRTBRTlBMM28zWnhZ?=
 =?utf-8?B?SU1yM2tHRU84eTdNTHd4QlBSNnNmOVdRcDIrWkVoaXY2VU90MHBQcjZCZGIw?=
 =?utf-8?B?VmZCNVVGYkgwL3dVS1NYZXkvSldhWmJ1WWFNSFc0TEhHaFl0VWtVYmNlL0Iy?=
 =?utf-8?B?dEhQOVAranMvNlRteFM0TTExV0ozM0FkeldDeU84dEU5d2JRdlMzK3BWbFhh?=
 =?utf-8?B?Y2ttYm9tdlNBenNNd21Mdk5FTUp5R09oajg1MFdZMVNON0tmZFZ0cW1OSm9H?=
 =?utf-8?B?UkljT0JiWGhUTnFjNHA1WDVQRkh2cldMeDN6S1d2K3NJeGtVK3pQaDVqVytq?=
 =?utf-8?B?RCtGWjZlV3dtbGVzWWEwS0RxUTk4S2NsWE42STFZTjlBbVkrR2ovcDMraEdB?=
 =?utf-8?B?VFBOOVZmVklkV2pFcFJmUkg4WWV5V201QUd0aG5BOEYxdjF0aEcwdFdueERV?=
 =?utf-8?B?VGNEektjVGttaWxjTzlYTWptcU1LVG11RXZNSnFzUFNORzR1L3pGQitTM0pj?=
 =?utf-8?B?UGc2WHdMWFpidkNMZ3dRUFE4ckE2ZWNjVUFvZzA1MC9kQ2llNnluWU9BT1pi?=
 =?utf-8?B?Wkt6Z3FmNXhRS3VRQlBQTFJ1Snk5bTBFVHl4Umk0Nko3dmkzbUJRRTlPRkZn?=
 =?utf-8?Q?3Noyt/AvHGEDghorgHd7+rOywOYutfgmC53MJ8A04Ufo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d827bb6-d116-402c-066e-08dd368f15fc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 00:37:13.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7628


On 1/16/2025 9:48 PM, Xin Li wrote:
> On 1/16/2025 5:03 AM, Ethan Zhao wrote:
>> On 1/16/2025 3:27 PM, Xin Li wrote:
>>> On 1/15/2025 10:51 PM, Ethan Zhao wrote:
>>>> External interrupts (EVENT_TYPE_EXTINT) and system calls 
>>>> (EVENT_TYPE_OTHER)
>>>> occur more frequently than other events in a typical system. 
>>>> Prioritizing
>>>> these events saves CPU cycles and optimizes the efficiency of 
>>>> performance-
>>>> critical paths.
>>>
>>> We deliberately hold off sending performance improvement patches at 
>>> this
>>> point, but first of all please read:
>>> https://lore.kernel.org/lkml/87fs766o3t.ffs@tglx/
>>
>> Do you mean Thomas'point "Premature optimization is the enemy of 
>> correctness.
>> don't do it" ? Yep, I agree with it.
>
> Yes.
>
>>
>> Compared to the asm code generated by the compiler with fewer than 20 
>> cmp
>> instructions, placing a event handler jump table indexed by event- 
>> typethere is a negative optimization. That is not deliberately 'hold 
>> off', correctness goes first, definitely right.
>
> hpa suggested to introduce "switch_likely" for this kind of optimization
> on a switch statement, which is also easier to read.  I measured it with
> a user space focus test, it does improve performance a lot.  But 
> obviously there are still a lot of work to do.

Find a way to instruct compiler to pick the right hot branch meanwhile make folks
reading happy... yup, a lot of work.

Thanks,
Ethan

>
> Thanks!
>     Xin

