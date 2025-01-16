Return-Path: <stable+bounces-109266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A20AA13A5E
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBD01882657
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 13:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696851DE88A;
	Thu, 16 Jan 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fDgU9jYV"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2093.outbound.protection.outlook.com [40.92.107.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41B1DBB3A;
	Thu, 16 Jan 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032624; cv=fail; b=THrETvcmKXtWZpP0bOqe0XxNa6h5GqcCC5NeeKdiQ0Cg/1HnI3ZF1cZQfwWQUAQ39fcKwnZbcW7CFqK5hWvFUqbg8WO4bYLWLkytAnYSGKdwWobGW7xeRebhc7Z5lRjXmwtrK1PsvOdWjo1QG9WI8MskP6oFji81USazyzyop3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032624; c=relaxed/simple;
	bh=D/VMYZkETJrXAsQaIZHM7pxseKA17UTvXOWnqUjV9YI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d7vmhfjkd+mxQ/3Zqdpu+QUDXiTi1tLmu/OwZ1Vq5e87gJ1YY0du8ngJeBdHzk/wg5nulbPodhYTnDh27xj5D0bPjAIxi0t10Yal6z74fqFi3T8BgzfNFVU/3JbB5Zks2EmUi1eK0SfeZ7Kv541uEMs19TFPU9spZkR5+R1kxh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fDgU9jYV; arc=fail smtp.client-ip=40.92.107.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZba3A3eajOJ3IbDHyN1up2of3YMWX1omYleVvJ0zlRh8+wk7OCDQ1CEBFw5ajzCVgBDkXiq8/NE0ODbsjSUhB+i246llNcJZ2aQr2gDF+QlD4+9VkjtluDu8dc1D07tH00qHLsLoWvQGLCYXfIlJ8IyP4MQVVHVmrCcvkdtDueXMOlQPrX1/ApekpRlkTzIMK1y32fiGgHbw6Q5m1DFyMdJkpKeF5cF4D4+qYSUs2Kfom+1Pf5xnaAysn6g4V6X8BH0d0psUCLYCfI2yxyBdRdQON8MTsAfm6Q4W3sia9M2RanFc4nexXT3jVSYArCPCUxZ27HsUNUFImWQINYXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRprQTJquD4RZ8ZXdnoVUvQFEC+/UiUV03SXICYQc4w=;
 b=b/awSFx7/luYdDXLEEm6NY9Rj8+XACYgLfeI2z9PvD5Nogmc51IwnQuO2NMEgiSG43vD5j7as2cH9iG84vxyuXJpHz7v0XXm8Menuc6mJ2IgMrWMBbV2IWTDgaMhg+yXdwDiuhxzuvw43NNvGc+bhIMwdrf7dZHhRAv2mEs/7uj0ieXZ1qIU0/5bVtfT/kbwXC6JhQfQe0KLG3knlqWiedzpMEpzECctu5n8qBPLruAdO1H7sSlIbjDxWPXEFfjcwXKk3XJW6iBdKF7EHjjiwYYxWBBOFgPIza+HAG2JewyJ+PX5NHFmPE9BbFeRDR1mkUxBPT5HjqQGjLhBVqjicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRprQTJquD4RZ8ZXdnoVUvQFEC+/UiUV03SXICYQc4w=;
 b=fDgU9jYV+cTecDYV5Es6sOfu5P5KKySLWikIpgIH3D8ZHbpfRkcJ1R+c7Cfzylf89euuOMvSVPdCmq6f7SBHjdmSt5Olx4sTeVg55DFrL+5173SHXowHrpzicvM6SAOZ6O6b4yNl9ONtGs35lmZKyUO01q/jvf8kpOMa7XnrNW6wxHgqgLTyzx9yGalXUZpmn/AbN6e5wO67B3Y4t2NpaN4GCe2U8jDEDQRkrgrCcWnAXeho3qaqoGwOPEND93MerCTTMts1lQFUUaAFWTw8FkxDEGDC9Ku7fLN5Wk/211QVxbGgNBF7NYST8U5uL/weJAtmXX6IYAs+nLOrd10uQg==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by KL1PR03MB6976.apcprd03.prod.outlook.com (2603:1096:820:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 13:03:36 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 13:03:36 +0000
Message-ID:
 <TYZPR03MB8801E2BF68A08887A238A32CD11A2@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Thu, 16 Jan 2025 21:03:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Xin Li <xin@zytor.com>, Ethan Zhao <haifeng.zhao@linux.intel.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
 <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
From: Ethan Zhao <etzhao@outlook.com>
In-Reply-To: <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <81c28a5f-6930-40ed-a225-e027b86520a9@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|KL1PR03MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe4df36-2566-4c61-bc77-08dd362e2f04
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|15080799006|8060799006|6090799003|36102599003|461199028|10035399004|18061999003|440099028|4302099013|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG43TnZzSE5vQmdqM0JsU0N4Ym5kQzNlV2N0VXNKS3I2Y3padUkzMHJ2bnF4?=
 =?utf-8?B?cFlYbWk4VUZMTGZiakJWdmcyamxGQ0JSMHd5Y0Y4MDU3T0NDUSt4TlVvellV?=
 =?utf-8?B?WXdYUUFHZmpLMldqbDRZSmZvd3FmeGV1b1BFOGFOdCtPZkQxQ2FEa3J6MUYw?=
 =?utf-8?B?Z2pSRERHZVlwdjR5WGphOENzTVBZWDFKTFBqZi9tdEFGNTZ1SGt3d0wxYVdX?=
 =?utf-8?B?U0wwbjR2TmxlcmswNEVRV0luSysvRXZKWC9UbkIrcDlIV0V1elhvM1YzaWF6?=
 =?utf-8?B?a0FXOFFXV2dCbHhCdFpEeCtBdzdScWRBakhxQ2RVajVVdkRvZGN3dkRQZ05N?=
 =?utf-8?B?aG1kRThyQ1M5YnViQU5PWU93VXlvWDMyc09UOVZKVkloNkh5M09DSkFETG9n?=
 =?utf-8?B?aDljVXhEWGd0UENUNTV5ZkhwQ0xKTHk2aHRVL1RhME16aHROdGZrdW9yclJk?=
 =?utf-8?B?MkQ2ZTF4bEJZNjUxNVVZdW9PbEV6WFh1UlV1ME9HS2NQaFoxSTduc2YwbGMr?=
 =?utf-8?B?M0pSMUdBSzRXemExQVlvMXAyTGgyQ0JnQ2Qyd0NvWHMrQUtxdEYwQ0ZrZlVK?=
 =?utf-8?B?TDFHRFFmaXpzcWN5QXVjSlNXNWhZcXZid2RkN3V2ZVJEUHppbGJVU2FtRXlh?=
 =?utf-8?B?UW1TWHVnVlJmSWxNWTdhTkJDVnAzb3c5WENUK21UeGUwMkdRRWp6NXNjbU1I?=
 =?utf-8?B?MnN5TWdieW9QbG1PaGVESUs0QTlyRVFEYy9pTld3M2lhdG1meGFrU2haQzU1?=
 =?utf-8?B?QWhVTUdGZzNLQW9YNWNDSUpLRzdmWGJ3M2VrZ0w3REZJUHU4SjdwT1hBTFFF?=
 =?utf-8?B?b056L1hBVEJlMDRRRlBNRU9mdU9mMEdKMDMvVkhKM21sR0tpekN2eWVqSk9y?=
 =?utf-8?B?L1ZkaVliRzZkdDloVjhDZHE3Vm44UElzeTZwenVTS0kyVVA5bllkSnp6a1JQ?=
 =?utf-8?B?dTNYenVsY1hGYVlkNHprQ2x2UFZnbXFSK1I4eThleGlnUmYxMnpJVTFBcm9S?=
 =?utf-8?B?Q2xHVUlCQS9jNEJaeTRYNWRoUVBRUmQ0dEFONGs3SDdiWDUrVlg4WjhId0xp?=
 =?utf-8?B?b2JXQktLMnQyd3hYMVlNL1RZQnRtT3ZTUGx0cGhLTHpEc2tvejBtek5CVFE3?=
 =?utf-8?B?WmZwRVhaM2FVZk84L1R2TVlJaVR5Nm1DbVE1N1RmSi9FeDlqMElRM04rQlFZ?=
 =?utf-8?B?TW9vVkJ5Tkd3aHY1RmEyNDNwUEtuUjlra3E5YitJSTB4TXh6cytZUE54VTYy?=
 =?utf-8?B?NkRqczFDazl3RXRaOEF4d2NETC9RdVRkcURuWUZqQmpoU0pyNENBaDRBQjBp?=
 =?utf-8?B?TjlqZzhLZHd1LzVIVXIvaUVTRjIyVDVXaG5vSkZQRVVhYmxmQUkvWit6SGFK?=
 =?utf-8?B?dENDS2k2dWgxOHV6bE56elBXNzE1SWZxWnlGclZ6UDVwa0NjbVRCVDVLZFd5?=
 =?utf-8?B?ZmFLdk1vM3Q5QVBDdGZmbXFBdnlQazMxeFp3WVZZTERyQmFPQjFuU2dJeHVC?=
 =?utf-8?B?YW10Zk83YlBQVTMxTEdmN2hpYnFEQ2tMSkFPSytoOWpvMnBYdHB4NkFmejA3?=
 =?utf-8?B?bFdvMG02Uk1XUUxKN0RjdTdyZWVBTTUyZmMvN1NhRGlYS0JLSCt2M21xS2k4?=
 =?utf-8?B?WnBhUG1tTnlyYk9NVDFhNTFWYUoxOTZnUzFuMEp3T05XYjlSMWlzTncxTnBH?=
 =?utf-8?Q?kRSxHHnwHDQ1NAEFzg3I?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmJnTTdXdlNLR3ZNcWs1djRoK0ZYbVJES3pPL2w4WnpHUFl2bllNWDYzQjVC?=
 =?utf-8?B?alUzN1M0ZG8yZUlSSm16cEdKSGF4Mko3b0pMaG1wcCthb2Z3Z0IxTVd6TWxY?=
 =?utf-8?B?MnZjeEJtdzIrOXpqbjE4VXpxdzQwcE85Uk94Ny9qMUoycmM3VjAzTUhuS1pT?=
 =?utf-8?B?N282aW5oMXBQZWxJSm5OZWkxczNOaXpMOFJERjJRK1IyenR1dzk5WGVpa3NK?=
 =?utf-8?B?Z3JtMm53Nk1ha3VWUkc2NmFiRTNQd28ralJkMi9aNDNleklmbklsVytlWVVD?=
 =?utf-8?B?QXhRWFlmNUg2ejMwVnBlQkRiaDBNOXRtcjErK1RDZklCUEJaWGJvWkp5WUpT?=
 =?utf-8?B?aE1RNVRFSCs1TWRPRUhoMGFzMjFnOEljNkVMNmxpcXdSMkZIT25QYkJsWHI4?=
 =?utf-8?B?V0kvK0lGWVVEUHBOZVNocFFLS1ZERXBzZ04vZWx4MzhmaG1BT1pPZ3c2cTQv?=
 =?utf-8?B?dldwNUJ5ZUV0dm5PcmVQRHdvcm8wOStyVHRwUnEwNUxNeDI3YkpLVkZZcXN6?=
 =?utf-8?B?QUlaUE5CdDdON0VrZ3ByNUpWcjYwaDBnbk1URWJrNGRqVWc0cC9EektTVWJj?=
 =?utf-8?B?Wm1UWjRsbi9Yb20zci8vNmVyZHdmYVRmaGRzcXM5NzR4UkNVbk5oSy91MkF0?=
 =?utf-8?B?cUIxU21aMysyNEhCMUw3YkcxM1l5a21MbmZPSm5rZmlGOHJwYjdTL0k2a2Q0?=
 =?utf-8?B?YjNkaXpYZW9WMUdMVmpVSk85ZFNvYVJJVGZPOEFDZ01DYnd1Njl2T1pCUzl5?=
 =?utf-8?B?SVlLdUsweVEraDNROXdxUFg4TmhwcE55MWJtdmdCblRZVzl1VXBwWHVXcWpa?=
 =?utf-8?B?RlkwUmhtY1o5TElrRlBHaVZldjBSUW8vck9jVWtIdkRvVVo0cWpQTWhrQ0V6?=
 =?utf-8?B?NllSV05kYlNtUmpkaGZ6a1I2bEVSeVk3YzZXSnY0TldybmFKN28xVDU4eGpq?=
 =?utf-8?B?d0ZxQ0dsaENKd3lrbUlMM3NwNnJKS3IzMFM0OG8wd3duK0pLelhOZEp1eTdi?=
 =?utf-8?B?OWwvU1JyQTNVK2E2dVZteElYaVhDVzFQTjV6T0JOZ0x5Yml4Mit3d0FvcU5E?=
 =?utf-8?B?QnJCL1o4VE5VTEpPRUV1R3lRT0h0d3QySDBaSlkxM05qd2JBYkc3M0IrV3ZB?=
 =?utf-8?B?ZHk1QzJYRlZQcy9PTzdLamtoWEI0eU9UVDdYR2lsdC9YbU5LZmh6eWFJUEl5?=
 =?utf-8?B?bTRHWmxzRDI4Nnk2UVd3UmtEb1NOY3NkM3g4bm9GQlRZMmgwUTFyWDFSQVdF?=
 =?utf-8?B?TnRPZU00YzNNZmZQYjBSZ0xFREpRRStQNDJCY1BHNFlYZGROQmgwT2VpTGlY?=
 =?utf-8?B?VnQydERuR1JMdHVabEd1VzVja1lXWlRSNEVlLzVWOEdaVFRlb3hCbXF2UFh2?=
 =?utf-8?B?L0xzL2lmOWh3TGRMVjdIcG1oSVVOQkpEb01ReTNDWndvYnMxRGhJZllNSHNo?=
 =?utf-8?B?bmJNYnA3dXJCMmpuYTFnNFE2Y2czSHl6RmlFaWRxcW9lTXlxMEtWR0JDai9R?=
 =?utf-8?B?bnNaekZOaDM3MjE0WnNmVE10ZlVMWHlVZlBTK2VVc0tuNXdvdXdhMVE4TWFs?=
 =?utf-8?B?a1ZoMzhkLzNDVjdzdk5HeTRFWkowUnFxSEZRbzlhS1lwZ2ltNGN4a0RyOUl2?=
 =?utf-8?Q?zRvr1E/gFnP2B818iiEwA+fGowEXHx1h+iaLpWT+WXpU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe4df36-2566-4c61-bc77-08dd362e2f04
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 13:03:36.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6976


On 1/16/2025 3:27 PM, Xin Li wrote:
> On 1/15/2025 10:51 PM, Ethan Zhao wrote:
>> External interrupts (EVENT_TYPE_EXTINT) and system calls 
>> (EVENT_TYPE_OTHER)
>> occur more frequently than other events in a typical system. 
>> Prioritizing
>> these events saves CPU cycles and optimizes the efficiency of 
>> performance-
>> critical paths.
>
> We deliberately hold off sending performance improvement patches at this
> point, but first of all please read:
>     https://lore.kernel.org/lkml/87fs766o3t.ffs@tglx/

Do you mean Thomas'point "Premature optimization is the enemy of correctness.
don't do it" ? Yep, I agree with it.

Compared to the asm code generated by the compiler with fewer than 20 cmp
instructions, placing a event handler jump table indexed by 
event-typethere is a negative optimization. That is not deliberately 'hold off', correctness goes first, definitely right.

Thanks,

Ethan

> Thanks!
>     Xin
>
>>
>> When examining the compiler-generated assembly code for event 
>> dispatching
>> in the functions fred_entry_from_user() and fred_entry_from_kernel(), it
>> was observed that the compiler intelligently uses a binary search to 
>> match
>> all event type values (0-7) and perform dispatching. As a result, 
>> even if
>> the following cases:
>>
>>     case EVENT_TYPE_EXTINT:
>>         return fred_extint(regs);
>>     case EVENT_TYPE_OTHER:
>>         return fred_other(regs);
>>
>> are placed at the beginning of the switch() statement, the generated
>> assembly code would remain the same, and the expected prioritization 
>> would
>> not be achieved.
>>
>> Command line to check the assembly code generated by the compiler for
>> fred_entry_from_user():
>>
>> $objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'
>>
>> 00000000000015a0 <fred_entry_from_user>:
>> 15a0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
>> 15a7:       48 8b 77 78             mov    0x78(%rdi),%rsi
>> 15ab:       55                      push   %rbp
>> 15ac:       48 c7 47 78 ff ff ff    movq $0xffffffffffffffff,0x78(%rdi)
>> 15b3:       ff
>> 15b4:       83 e0 0f                and    $0xf,%eax
>> 15b7:       48 89 e5                mov    %rsp,%rbp
>> 15ba:       3c 04                   cmp    $0x4,%al
>> -->>                        /* match 4(EVENT_TYPE_SWINT) first */
>> 15bc:       74 78                   je     1636 
>> <fred_entry_from_user+0x96>
>> 15be:       77 15                   ja     15d5 
>> <fred_entry_from_user+0x35>
>> 15c0:       3c 02                   cmp    $0x2,%al
>> 15c2:       74 53                   je     1617 
>> <fred_entry_from_user+0x77>
>> 15c4:       77 65                   ja     162b 
>> <fred_entry_from_user+0x8b>
>> 15c6:       84 c0                   test   %al,%al
>> 15c8:       75 42                   jne    160c 
>> <fred_entry_from_user+0x6c>
>> 15ca:       e8 71 fc ff ff          callq  1240 <fred_extint>
>> 15cf:       5d                      pop    %rbp
>> 15d0:       e9 00 00 00 00          jmpq   15d5 
>> <fred_entry_from_user+0x35>
>> 15d5:       3c 06                   cmp    $0x6,%al
>> 15d7:       74 7c                   je     1655 
>> <fred_entry_from_user+0xb5>
>> 15d9:       72 66                   jb     1641 
>> <fred_entry_from_user+0xa1>
>> 15db:       3c 07                   cmp    $0x7,%al
>> 15dd:       75 2d                   jne    160c 
>> <fred_entry_from_user+0x6c>
>> 15df:       8b 87 a4 00 00 00       mov    0xa4(%rdi),%eax
>> 15e5:       25 ff 00 00 02          and    $0x20000ff,%eax
>> 15ea:       3d 01 00 00 02          cmp    $0x2000001,%eax
>> 15ef:       75 6f                   jne    1660 
>> <fred_entry_from_user+0xc0>
>> 15f1:       48 8b 77 50             mov    0x50(%rdi),%rsi
>> 15f5:       48 c7 47 50 da ff ff    movq $0xffffffffffffffda,0x50(%rdi)
>> ... ...
>>
>> Command line to check the assembly code generated by the compiler for
>> fred_entry_from_kernel():
>>
>> $objdump -d vmlinux.o | awk '/<fred_entry_from_kernel>:/{c=65} c&&c--'
>>
>> 00000000000016b0 <fred_entry_from_kernel>:
>> 16b0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
>> 16b7:       48 8b 77 78             mov    0x78(%rdi),%rsi
>> 16bb:       55                      push   %rbp
>> 16bc:       48 c7 47 78 ff ff ff    movq $0xffffffffffffffff,0x78(%rdi)
>> 16c3:       ff
>> 16c4:       83 e0 0f                and    $0xf,%eax
>> 16c7:       48 89 e5                mov    %rsp,%rbp
>> 16ca:       3c 03                   cmp    $0x3,%al
>> -->>                                /* match 3(EVENT_TYPE_HWEXC) 
>> first */
>> 16cc:       74 3c                 je     170a 
>> <fred_entry_from_kernel+0x5a>
>> 16ce:       76 13                 jbe    16e3 
>> <fred_entry_from_kernel+0x33>
>> 16d0:       3c 05                 cmp    $0x5,%al
>> 16d2:       74 41                 je     1715 
>> <fred_entry_from_kernel+0x65>
>> 16d4:       3c 06                 cmp    $0x6,%al
>> 16d6:       75 27                 jne    16ff 
>> <fred_entry_from_kernel+0x4f>
>> 16d8:       e8 73 fe ff ff        callq  1550 <fred_swexc.isra.3>
>> 16dd:       5d                    pop    %rbp
>> ... ...
>>
>> Therefore, it is necessary to handle EVENT_TYPE_EXTINT and 
>> EVENT_TYPE_OTHER
>> before the switch statement using if-else syntax to ensure the compiler
>> generates the desired code. After applying the patch, the verification
>> results are as follows:
>>
>> $objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'
>>
>> 00000000000015a0 <fred_entry_from_user>:
>> 15a0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
>> 15a7:       48 8b 77 78             mov    0x78(%rdi),%rsi
>> 15ab:       55                      push   %rbp
>> 15ac:       48 c7 47 78 ff ff ff    movq $0xffffffffffffffff,0x78(%rdi)
>> 15b3:       ff
>> 15b4:       48 89 e5                mov    %rsp,%rbp
>> 15b7:       83 e0 0f                and    $0xf,%eax
>> 15ba:       74 34                   je     15f0 
>> <fred_entry_from_user+0x50>
>> -->>                    /* match 0(EVENT_TYPE_EXTINT) first */
>> 15bc:       3c 07                   cmp    $0x7,%al
>> -->>                                /* match 7(EVENT_TYPE_OTHER) 
>> second *
>> 15be:       74 6e                   je     162e 
>> <fred_entry_from_user+0x8e>
>> 15c0:       3c 04                   cmp    $0x4,%al
>> 15c2:       0f 84 93 00 00 00       je     165b 
>> <fred_entry_from_user+0xbb>
>> 15c8:       76 13                   jbe    15dd 
>> <fred_entry_from_user+0x3d>
>> 15ca:       3c 05                   cmp    $0x5,%al
>> 15cc:       74 41                   je     160f 
>> <fred_entry_from_user+0x6f>
>> 15ce:       3c 06                   cmp    $0x6,%al
>> 15d0:       75 51                   jne    1623 
>> <fred_entry_from_user+0x83>
>> 15d2:       e8 79 ff ff ff          callq  1550 <fred_swexc.isra.3>
>> 15d7:       5d                      pop    %rbp
>> 15d8:       e9 00 00 00 00          jmpq   15dd 
>> <fred_entry_from_user+0x3d>
>> 15dd:       3c 02                   cmp    $0x2,%al
>> 15df:       74 1a                   je     15fb 
>> <fred_entry_from_user+0x5b>
>> 15e1:       3c 03                   cmp    $0x3,%al
>> 15e3:       75 3e                   jne    1623 
>> <fred_entry_from_user+0x83>
>> ... ...
>>
>> The same desired code in fred_entry_from_kernel is no longer repeated.
>>
>> While the C code with if-else placed before switch() may appear ugly, it
>> works. Additionally, using a jump table is not advisable; even if the 
>> jump
>> table resides in the L1 cache, the cost of loading it is over 10 
>> times the
>> latency of a cmp instruction.
>>
>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> ---
>> base commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
>> ---
>>   arch/x86/entry/entry_fred.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
>> index f004a4dc74c2..591f47771ecf 100644
>> --- a/arch/x86/entry/entry_fred.c
>> +++ b/arch/x86/entry/entry_fred.c
>> @@ -228,9 +228,18 @@ __visible noinstr void 
>> fred_entry_from_user(struct pt_regs *regs)
>>       /* Invalidate orig_ax so that syscall_get_nr() works correctly */
>>       regs->orig_ax = -1;
>>   -    switch (regs->fred_ss.type) {
>> -    case EVENT_TYPE_EXTINT:
>> +    if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
>>           return fred_extint(regs);
>> +    else if (regs->fred_ss.type == EVENT_TYPE_OTHER)
>> +        return fred_other(regs);
>> +
>> +    /*
>> +     * Dispatch EVENT_TYPE_EXTINT and EVENT_TYPE_OTHER(syscall) type 
>> events
>> +     * first due to their high probability and let the compiler 
>> create binary search
>> +     * dispatching for the remaining events
>> +     */
>> +
>> +    switch (regs->fred_ss.type) {
>>       case EVENT_TYPE_NMI:
>>           if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
>>               return fred_exc_nmi(regs);
>> @@ -245,8 +254,6 @@ __visible noinstr void 
>> fred_entry_from_user(struct pt_regs *regs)
>>           break;
>>       case EVENT_TYPE_SWEXC:
>>           return fred_swexc(regs, error_code);
>> -    case EVENT_TYPE_OTHER:
>> -        return fred_other(regs);
>>       default: break;
>>       }
>>   @@ -260,9 +267,15 @@ __visible noinstr void 
>> fred_entry_from_kernel(struct pt_regs *regs)
>>       /* Invalidate orig_ax so that syscall_get_nr() works correctly */
>>       regs->orig_ax = -1;
>>   -    switch (regs->fred_ss.type) {
>> -    case EVENT_TYPE_EXTINT:
>> +    if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
>>           return fred_extint(regs);
>> +
>> +    /*
>> +     * Dispatch EVENT_TYPE_EXTINT type event first due to its high 
>> probability
>> +     * and let the compiler do binary search dispatching for the 
>> other events
>> +     */
>> +
>> +    switch (regs->fred_ss.type) {
>>       case EVENT_TYPE_NMI:
>>           if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
>>               return fred_exc_nmi(regs);
>

