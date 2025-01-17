Return-Path: <stable+bounces-109335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52C0A149E5
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 07:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33CD16762E
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 06:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B881F76D5;
	Fri, 17 Jan 2025 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KQ9t0nGZ"
X-Original-To: stable@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19011026.outbound.protection.outlook.com [52.103.64.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33A1F5618;
	Fri, 17 Jan 2025 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737097119; cv=fail; b=uBSi5C7zwic3XW8bhZoUbZWkUPnt8oYpJmbHw5lUg7K8absT/MU4Bhj7w+ta5tUv1casn2ld/C+bdY49/HLeYGWRQ7RqZRlWRss1xykhWFz5qy3uCc/uM2DIWK3o56KUFjVBg1PUEThC9AG5SeLIIH3QH1Btxbna9Jp/8JtNXFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737097119; c=relaxed/simple;
	bh=E3+RaYdNWMFp5Kn2H7ec8UA2H1JP5M65l/Q+2N4MoPY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mr/FkVMU0jpOXctfPx9YcapBgRhNiW7smWYFDphHJykd5CYaPeE+yzOYSR7QZHjkoH9OahMpYoihqGnK/f9PLDczOZ1qTbBne49cYukPsvFOS722Ckq/HbCMPqRYw8cH84ywU/r02QwkBoKagKZdneGwy7r8mc4VjcV37/iHBYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KQ9t0nGZ; arc=fail smtp.client-ip=52.103.64.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEbh39QB2X9kvBlLZhkwho2Cys/S1/YAZaKxy+28eXNiDpMV4oBzSn5c36m82WMjZdNnfwbJZghpp7lsURWrjdnL8psmJ4UwXTqBtURsiWJqD9dflRyhNN8LX6WKlGr/lBQwgqRI/yTysNLHIi6Tw/YWs5GoHIrQpJ9zR50Y7IuBWKuefTLuQfHnwpu8Toe5cvx8WE9QYVbU2tGwjDlawpy/JREINfO2fnbnS2wtLkXaXwFaJRj+Y0E0QSNNnbtrqKRblqR0noPymAzgiTzvOdYLOqQVEsaqsfX7HZdsR8rCcONRGWeeV5x/bWQf30JraHeytOQTmi7w+AsYtu0P0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5TAq7IMQ3V6QxGSF32CXHxnT8ycH26WZNKcuO4pR+E=;
 b=gs0bVQ9p7ISKLyT2uBc+AIeIGKlmbF/STAgceWUT8EmsjaG6Kuafs83tHN/mersW2p36YAiHSW3FM53yZ7eF1nCBj28rGE9HkbxZFw1YY9iMexzDrGvL7RlfA1UdemFSppcHtun4oSzFzeMMUlf7d+sCsbg3hMKXVwBUnLYQ7buydMn3HcgkWuJbtGPB3DTQC9ivjaXxDQJP/365Q05HLHEZXPi94RE+MUlxIGLdUd+Bp8kBUA07Uv50j5m3SFFc9G4qVdrWxyeclKxhvAKE6PXFNPvypxoZzVDSAqo8TohVwOPD8cSHu0ojK8tCIDrtZMeA9p4cFd22VtUz8OiVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5TAq7IMQ3V6QxGSF32CXHxnT8ycH26WZNKcuO4pR+E=;
 b=KQ9t0nGZgKXVr9VltgJk/2JGSRalZNywVw/MKPI0InhoLQEkkg2+Rapl/h+OqNKzdBuHITyJ/h9kajrRXQerSKuy5g+c0ImBioUDXY+mDzZTMAiOkcGBFIN/XF2x9hM77+iq0De1yZt4BoOJ2E4iDxj5MtMzC8IqgninhzOyBF87RkE5XC7eL53bEi/pyw0FUuKodoCIAWHD1FnjGiFOvk5uI3iE3zyoCElz667bwlFuzdwb8crjzIokXqYrxBJU0s38BYMD7rtkrZlr8KFl7+2H7lXd8LQOrTRhDmKrkB622QfK1MQeRJBHSEWYAUxlmBsuhAmf+bwcUsuZLlO9tg==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by SEZPR03MB8486.apcprd03.prod.outlook.com (2603:1096:101:220::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 06:58:28 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 06:58:28 +0000
Message-ID:
 <TYZPR03MB88015F2A7F8BE1C32B57C849D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Fri, 17 Jan 2025 14:58:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Xin Li <xin@zytor.com>, Ethan Zhao <haifeng.zhao@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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
 <d96d60b9-fa17-4981-a7e9-1b8bab1a7eed@zytor.com>
Content-Language: en-US
From: Ethan Zhao <etzhao@outlook.com>
In-Reply-To: <d96d60b9-fa17-4981-a7e9-1b8bab1a7eed@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:3:18::33) To TYZPR03MB8801.apcprd03.prod.outlook.com
 (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <ec889932-b761-4a62-b82c-9aec4413a6c2@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|SEZPR03MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e85d03-7686-4863-fa81-08dd36c45867
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|36102599003|5072599009|19110799003|8060799006|15080799006|461199028|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmdqRU1Rcng3WTRDdU03a2dsbjdOVGN2VkYxY3IybW4xZXRUY0h6RURiR3l2?=
 =?utf-8?B?ZWcrUG93UFM4eGUwa2lJbTczSlF4bUhzaWdQc21tVU43S1VwQjU4SEc3akx5?=
 =?utf-8?B?d2t4bVdkREVLSXdoNXVnWS9WVTNJYlRVZUxmTzZXWmpnbXVxdkZhL25GV203?=
 =?utf-8?B?UEh5d2NaM3FPQ2x4d2I1NE1oQm1pNmFLY0QwKzhmMVZMeTdaK2NJWlRYSm1v?=
 =?utf-8?B?RjU2bTc2UTZrV0ZWb0NyeTlBWmhmclR4aHVvNG5PYzlONHkxZWU2bjFuN3lt?=
 =?utf-8?B?NzR5dzNHS3VTdU1pbFY2ejM3aXJVMzZIaEtJUmhqamEyc3lhYXg5TTVyUkY1?=
 =?utf-8?B?Zk5PdE4zVFJjWXk3NHJZWFBwelppdjF0clBDcklFYUlrOW9wblgzWEpOTDVq?=
 =?utf-8?B?OW9rWVBRMXQ2MnN0NXd3VDJYWS9xOEhYckFDTkFoNDZWS2oxNTQwQTVBTjk0?=
 =?utf-8?B?SWdMREdYRjYwcUpwVnpJalY1SUZyZlpqOEFNR2NKMUI4TFNCRUpCamhTZ05k?=
 =?utf-8?B?eXdGeU5lM1RVK3hMaWJTRy9wUXhNOEhrS3U3NjV0Q01sTHh1dVB5NExQUzlE?=
 =?utf-8?B?VDhNWWpUbnBQY09xMVJjOVEwLzdKSkhvNU9kb2VxV216S1ZQMGd5OEhyYjVL?=
 =?utf-8?B?VEF0KzZjTTZLSFVUcUJkYjgrak9vVlRaa04zU01HS2hnTzFZVDQ1K2czWHVj?=
 =?utf-8?B?aURVamZ3WGwzZFh6aU1KRTBCL3YybXRKaEpiRW5HZHd1cVFaQnBEUVhnV0Zj?=
 =?utf-8?B?UmlmMFFveTQ3eXgwK1lLN3ZmM3JiT3Q5YnMzbThjTGVvWklvRTFneGVrUk84?=
 =?utf-8?B?MW4rM284a29EUjliM0I3VEhDWkV2dXJxeUxqWW52VTc2N0xSZ0laQ05IS1F0?=
 =?utf-8?B?WWtKR3ZseXg2eXpuUWFJMTdYZlBwTXhNM0NHWE9pLzlSd0QvMWVUU2cwcEZI?=
 =?utf-8?B?SGlhNmlzUnBiQXZJalF4My9XcTEyTGE3UFd4LzdPMnVtOWVQWWgxYUExR1Jm?=
 =?utf-8?B?M0hOWXdLU3hZNmRDVlR2a1gyYzVZcFA3N0pVNnRmczFZMUsvWGh2Q2ZNTjZF?=
 =?utf-8?B?VDVjTFRHVy9lMCtOWW8veThZQUFKSW9DODFQMW5KZ1h2MVJ0cEJORHR4L0JF?=
 =?utf-8?B?MHJRTXBuSWJETVB5WGthVU5iUzVLMlJ0cmxvdEZYQitXdi9HblBEMzZiclc2?=
 =?utf-8?B?UThObmRHaXhvR0xZRlVwMVJuVU9DTU5pWndpYTVZNWU0K3o3TXhES05ZcVpH?=
 =?utf-8?B?MkR6cDlHeDdWdzRBOHp6dDFEY3ZIQlc4YksrNWhqOURXRXFrZjBZc1BiK0w2?=
 =?utf-8?B?VFNRckxzZHp1NmM1TTZhRGRWd01oOENkNWdONGRNbllmbjN0Rk9rZWMxZHpV?=
 =?utf-8?B?NjlPV0txUURrVFoxVWZVRGNrYzdkcjg3NEhhc2hmQisrSnJZbFJRYkZaNzFL?=
 =?utf-8?B?WmI5RG9UUW1QZTBNM2ZMQ0FjSkRsVlByd2VRc2xuRmhXTUxvUWRyaElFSmZm?=
 =?utf-8?B?MUs2WGRab3k5ek14eWdGSEZjaWxMNmdlU0xrMmJyQnRmVmdWM2NsV1FpYXlN?=
 =?utf-8?B?Nlkwdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2Vmb1JWNHRvTlpyakVRSFUzZmgvWW05SlBDd2d3c1VUbmJWTmZzb1JrY2Yy?=
 =?utf-8?B?alY1YlJIL2loM2lWanZSOENxdXVhZUNFTXlOR0RYT0JOMzNWbjVCK0R3dXB0?=
 =?utf-8?B?TUs5Z2ROdEhlSlQ3WGFpNUJKZ24yZFN0SExHVXJPc2E4ZkZSTHprK2dQUm03?=
 =?utf-8?B?dTE4YzlINjdTMmJiQWxZRUxUc0dZc3dRYWE2K093bE9aTkdjOVo2SHVWZGxL?=
 =?utf-8?B?dEN4b0hQMzFET2ZIU3psWXBzMjAyeDlFQTZkOUxsZHgvRm1CdHVWb20rYWo2?=
 =?utf-8?B?cGVNbXU5U3ZkRmhkWExVUzd0bHI2YWV5clZjaGI4Rk4xcW1ySGlWMEdiN1lG?=
 =?utf-8?B?UFNNbVN6YWxZRzRPZVN2bC8yWjI3N0NGUmM5cTJlZ2dONXRtK0E4dFI5Tisy?=
 =?utf-8?B?cUtUNjZ4YmtKRWFDS0hDOWdQcTdhc2luS05Fam10TXVZaGc1ZXB0QlVGYzZk?=
 =?utf-8?B?YzVjbjlVMFFHVUNIdWoyNWR4cVc2T2U2TEY2TGVvTER3aXlSY1J1OGduSklh?=
 =?utf-8?B?NDhFbm5DTThLQk1CaVVuNlBEd3hBa05rM0F3dytaWEpUQmd5ai8vdlFoOVV5?=
 =?utf-8?B?MCtIM1lVVncxeXlRVnd3SFJLV0FvazBDSFYrZ1RzUnE1cXpnbUdCWTcyRVIy?=
 =?utf-8?B?dVZpZ3VHYUlmSGVxL281YW1Ud3JJOTZ0Nm5kOFBiSHlSc3JWaS9NekcxRDJ6?=
 =?utf-8?B?SXF3amY1VDUzT2JNeWQ4STI3cTFndDE1cW0rdEZzSUJ6bklGRlR6c2tmalpO?=
 =?utf-8?B?WG0xV2kvTS9LblBIL0V1c3M3QmNOSWVXbi9EK1h4WWgydW5iL2o0ZVhEU1Vl?=
 =?utf-8?B?dHNBMlV2WGNzc3A1eFVXMnFrZFNEQlhrWDJYOUJpTFl2NUhwNU1uT3A3OFdz?=
 =?utf-8?B?U0d1d2I3QUNUT1BqVE41VnNrbnF4T1pnL09jb0cxdVZGdXBqVWJTSjkwRzgy?=
 =?utf-8?B?dk5PRXF3cXZIeDhXN21FNzE5c3RWQ1Ribkw4amZmMHNNSFIwT25vMFpwRTQ3?=
 =?utf-8?B?NzJMUXM4ejE2ZG1BQ3ZHcFQzS1RaNkV1bytYcHFWOUlyMktFakRnTE1zRjRh?=
 =?utf-8?B?NExsNzhUTG5oOEtqcGlINU1oNFRkUThmMDIvajNrYUdKUzI4c2ZpVXhRNUlv?=
 =?utf-8?B?ZjNzcnh6b3oveFF5VFBieDJPaE96cHQzQlo1aHVOcmV6MmhMTTZFUHlucWdO?=
 =?utf-8?B?NmtDSkFhREpmRVhMZml0RWszZVJ2SUZNVkF3eXpYMjRscE56WlRkL0g0WUht?=
 =?utf-8?B?eDlJR2dPVFl3cStKWmJpalRuOGVZS3Qyem0yTmhJZ3NUa1k0TndKQ2pweVB4?=
 =?utf-8?B?b28xanZzcTNYWEtGaDlMVU1BRGRteTJMcWlYZFEzem4wa2pvNFNpaTg1cEtD?=
 =?utf-8?B?dXRtZy9peUp0ZVlSdDdOZERFSTFzUERmRVdNYkk3MEFxSGFjUjVPQlBxSXps?=
 =?utf-8?B?Zm5yMktrOTYzTXhkWThZTi9TeDd6Nkh2TTFaQlZmRjBqT0lpaTlNNWtxRGY5?=
 =?utf-8?B?bXNnR0pyMVcvQXQ1djhuWFByNkNEdHV4N1pzTDJwYmNJZ01HNmVkcFB5d3hC?=
 =?utf-8?B?OXFTa1N2NlI0RkxacXQxL3NySmFJVFNjZ3dueXZ6aXFzcms3Rnk5Tzh5YlVy?=
 =?utf-8?Q?AxfrPL5zAIEPovY6WiG8FLCQSAN4zC6bZ4RHiSTpU08E=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e85d03-7686-4863-fa81-08dd36c45867
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 06:58:28.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8486


On 1/17/2025 1:54 PM, Xin Li wrote:
> On 1/16/2025 9:18 PM, Ethan Zhao wrote:
>>>
>>> Just swap the 2 arguments, and it should be:
>>> +    switch_likely (etype, EVENT_TYPE_OTHER) {
>>>
>>>
>> after swapped the parameters as following:
>> +#define switch_likely(v,l) \
>> + switch((__typeof__(v))__builtin_expect((v),(l)))
>> +
>>   __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
>>   {
>>          unsigned long error_code = regs->orig_ax;
>> +       unsigned short etype = regs->fred_ss.type & 0xf;
>>
>>          /* Invalidate orig_ax so that syscall_get_nr() works 
>> correctly */
>>          regs->orig_ax = -1;
>>
>> -       switch (regs->fred_ss.type) {
>> +       switch_likely (etype, (EVENT_TYPE_EXTINT == etype || 
>> EVENT_TYPE_OTHER == etype)) {
>
> This is not what I suggested, the (l) argument should be only one
> constant; __builtin_expect() doesn't allow 2 different constants.

That is why it couldn't be used in switch(var), while it works with if(true) else if (false).
Switch(var) needs a var returned by the __builtin_expect(), but it only could return Const.

Thanks,
Ethan


