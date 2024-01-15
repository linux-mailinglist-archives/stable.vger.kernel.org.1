Return-Path: <stable+bounces-10865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2377382D64E
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 10:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C713B21266
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F41D308;
	Mon, 15 Jan 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aub10Ahc"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE9E541
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mccDeOMNND94U4UCWUxchQZCBaBWd/maH4Vy6fTnMuqQ/S5JUIDN4bG30lOvAUJewWT9RUti0tmog+I3PnDDFn06raikdv/K0ZhvQXIGs+6AxRKzem6ek9aRyW2RPKj7KQ+7elXIP+kIVYaXliD2KK82i/1NFOYRtCWNS5bhO19KzlmwmmaXPg3vnLK4bb5vOQ5ucto3/xL/NgGUQ3EhVRugnVNy2m2lXqUNO65V37o8W2P+si+2/Nfel94jiM4LMbFewud+IWUe6pyfdhD7H67hGSwTHcMm+Yulw3oEB4ONpset6WEXruGMkrfUQ6K4OCD0jOqIm0LG2q+f7F0KCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1LKj2Rw0gm/ZbwX+c6RgdOvD3RQcQGrf4HwHQweIJM=;
 b=ES8ZbJeU11cje6wJB3Wh0MAAfacR3Cw1Di/qlktLWuoPg6ejrKqpDTpx+2R941fSB8IZdQku1NVsxW8dKLx1CiU1oREKSEPbsZAtM9unqsvGmIanIuZOceCBgFvxRCa/ZzB1PAc+S2gVjGDPeoAvep7sZkudw71IJKu98vZMqlDs8xk5hU/3qO0rYKAN/eGUmmz/KtZ45x82Q/m/rZh7qDlc1VI+ZoAHmygF6lFNeYpTW3KYKVQ1o+9ScH1sE6iD5cJ5I6ns6/1CeHdsGevz4Wo9Zec6XLc7g01LynLG7SHOWfScO8ApMFFGTCcPWHFCZLooUP4r6Wnbe2CKcQYBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1LKj2Rw0gm/ZbwX+c6RgdOvD3RQcQGrf4HwHQweIJM=;
 b=aub10AhcJsD5WC3xTQjEbhb0lPuLukSteuRtiLv/NHBNbjxz3YC3z/F7PzeqybiSgt9cFUfSJo06ZrY06iJXgrT2ubPWXChuR92gkGFfb6SPtfh0GfxCtTw0mW8krRCdzamhT9UdCfDigVXOuHCaOxpd2VPy+71Qdmn6PMosF5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 09:47:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 09:47:46 +0000
Message-ID: <c71cc2ba-72f3-4869-b804-51d5d6704f49@amd.com>
Date: Mon, 15 Jan 2024 10:47:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <66f8848f-13c8-4293-a207-012eadbc9018@igalia.com>
 <a88f1d5f-c13c-4b46-9bba-f96d43bd4e1a@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a88f1d5f-c13c-4b46-9bba-f96d43bd4e1a@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b9f953-cf85-489a-95c8-08dc15af0708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yD8UDZe0BnMX4oIeYmTo1U13MSlZ/8x+ob1+Ee6i0iRE8gHRqf8um20yUGVhAXrhew88oepIK062nVESRWq5cwQV82ELY3GOz+24QZJi/IzULn2c874Tjm6duo03Z9RErKLcSeF7ricd+hEbbvGa5HzFKTbATyuKhfawFMenN/FyGYqAGeD3+sg925rSHyuNrrUlYfEQlTLDx2hr2ttAwDfmJPeJ9FvyGFPmWe2FaglfBer7EoU+EXnCZlsLFiI51+prNJgpkyBDpvbXxxwBipxhzr5+PDsl5vN/Zxx6cn3bOHgOWF3cdD+6y5hRFo+oMhpeYA8lU8lffC00rc6WUtImkH+nQw3wiCC5d8RtZAYT4CMt5spXRmSjIodKKr++Dfne4R4QSXPwEq96fx1og9djtm43MJqAbAzXMapxR+7cAbTZ7kE2fAMGRHH5sev0yDNAFsofIsQXxmMF2qgkLSzmadm+kQ7ay/jOrAskZB2fzIm2TZldiet8Ug1knlQJ2JjeC++ypyRrUlhKoe0qEuoBcRD4rEoOH2tXXDWN4ve9ck1wvNnQ2LbvysR8wN/P4yvGDcejh4tV4fjRa8wtdHC/xoXpFSo4hFJJe3uBz9CEOiabQHCcFO6DrYPutNqcVQD/+X3t+1WpxVgk1jDedSXWqIxUlIu0+q6hTel7hk0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6506007)(6666004)(6512007)(478600001)(53546011)(26005)(2616005)(66574015)(316002)(36756003)(8936002)(8676002)(6486002)(966005)(66946007)(66556008)(66476007)(54906003)(110136005)(4326008)(38100700002)(83380400001)(86362001)(31696002)(5660300002)(2906002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1JHeGhOb25tRnpDZ0pOZi8rV1JqQWpoY2dkZnBURzJqamxyMi8vMFA1MHd3?=
 =?utf-8?B?eDBzaVRNUkxRK2hPRFo5bEE1VS9YaUhwUGxONXVjMmtRU0lMWDBnTE0xMVlR?=
 =?utf-8?B?MGROK1ExbXE5clF2a1VwZ2ZobHhmVnZ5TTZtS2dnVmNqOHdqQ0hCMjJmaWFm?=
 =?utf-8?B?ZEpnNk93bWx5bFBOT3dnZFNPelJBbFY1VWRSVXYzaGFJaU1iQnYzUG9HQ0R6?=
 =?utf-8?B?UXkwN2lOTTRiRkxRbGpxZS92bVRkVVV3RHJzeGlhVGdYTER5STRnOUxBMVZi?=
 =?utf-8?B?bjk3WUZMM0d4dDdoeG9KYnB5c1BYR3ArMmZpRnpTM29FN3hMb3ZHdHlITTVH?=
 =?utf-8?B?aEkwYTlPR3RHWHYyMFBOUk5oR2JUT3FIV2g3TkVMQ3BFSWs4RnlHUnhsekZV?=
 =?utf-8?B?ZWlvNmtJQkNxRkI3MnBIUUxuRzdiaU4vTzByeklVK0syUnFZbVFoMU44UlhJ?=
 =?utf-8?B?M3ROVG92S1NqM1VDUU1ocVJVVjZRTFZsekNZSWpRZzkxVnIwbEpvd0VvUjFK?=
 =?utf-8?B?OFYwSUdYcVhrZzdmditaL0paUmszSFl2WUJFVEhBYk00V0p1UVRLQldJcVo5?=
 =?utf-8?B?TnlDUXNrUkVybFVRVHdlb05uWWkyanZvWFExbzg5cWRkeDdhU2hNd3dreHNu?=
 =?utf-8?B?R0FjU2hTRTJJSU0rcFU0OTZyT0pzWU93WTU2NDZJanIzWXdJRzB4Z3FhY3ZD?=
 =?utf-8?B?OEgyb1I2K1kxRmhIcmtjVGxZejRObW9CMVRUeXNWWVdzZFE5S2dZc0x0THRV?=
 =?utf-8?B?aTFtWUJDZ3lrdmVpVG44VWFZYjBkaVRTa0JKTkljblA0Rk9xV0JxODNkNmlG?=
 =?utf-8?B?L0xXTW5BNmlBcUxUS28wZXRRZkY4R2txbEM4RXppSDU4bkVDbmZTYjVtamZD?=
 =?utf-8?B?VTZwRjlxeXFWZ2ZWSGxwMm40c1N6K3loWkh0K0ZNdUc4Si9PMHhReWs3SUxD?=
 =?utf-8?B?bkplT1J6cS9uQ2I4N1gwdWZhS2EzZ2ZUa3Ayb3czY3BNQUhZS1VDNHc5YmFQ?=
 =?utf-8?B?MExtNkJnZGZJSVBoeldxeGVrSlV6OUFTS1NNK2N5VW5QNTQwTXM2aDBYS2ox?=
 =?utf-8?B?aFZYc3JDY0RmRTdjRWx4Q09jVzE1NWg3OUowK1RqSGRUVFRHQjZ3RmNwUGtF?=
 =?utf-8?B?OVJVbTN2czNlU1VyYmtQUVpYOGFSUGxUN1dPdkx5TkFUQUROZjR6NTRSdjNi?=
 =?utf-8?B?ME94akpRcmM0ejVuTDRwTWhwRmRYenRMVnJmNlRoczhqdEhRakNkRElHNk1W?=
 =?utf-8?B?S2E5aXh2Nzc3MEVwWGc4eGdXOVlwWlBsUlNEMUtVYVI1dDRCMUlaYWxtcUFC?=
 =?utf-8?B?bVVJQXBpL3dPM3ZVVWtmelhGbzhtb0hrNHg3QmJjZUFUOXhrOCsrRk1kdGU3?=
 =?utf-8?B?TmNybXNzeXQ5VW01dEpzQlV6SWl2NGxXQytkNmVtV2lZS1IwREJRdWlXcHYy?=
 =?utf-8?B?TFUvV1kzM1hySzJlZUNUdHNrWnNsc293Nk4wZTNxQXo2Z1prTGRnb20xK3hU?=
 =?utf-8?B?ZDl0dEJHblVjVXdScXRva0RYVTJxd08rcDV1dWZRWnVRa3VXMVM4d0ZSVElo?=
 =?utf-8?B?TlMzQkE0QVhDQjhodFhVRk9Vazd0YlZ3WVZaSG9Lbm01TjdwTEMrc3F4aXN6?=
 =?utf-8?B?cXRtQkRMdXFwdE1LR2tzclNpQkY5UGR6K2RhY3VzakhGNlVVdGxzSk1IOHYz?=
 =?utf-8?B?cnFBRkh0VFo0ODU0eVBLT2JaYmNyL3YzbHV6ckVMQVdndStOdll3ZmhvVDN0?=
 =?utf-8?B?S2dGSURrajJVazNnUDVwYWljamRZNGhvTEV2R2FGb3RRaVJnTng1ZjBJMUhv?=
 =?utf-8?B?L1ZTSEYrMzg3UU9UeWZrbTJxZG1TbVdDU2pBNlFMZVhuRnZhOHcvREFyNlc0?=
 =?utf-8?B?QmNpZmRtak11a1Y0aGpKRVN1eGVUbWFjU1lLbG82TVhCMTRBM2tKSlZleTJD?=
 =?utf-8?B?WTdydk5jVXpmYnpiblJhMFFzeERyd2tUd0czSzhPQVNPc3J6ZThQM0xnZzNK?=
 =?utf-8?B?VUhhNHVUeWdOM0gyMnk4L3ZnaUdmZkVhLy9yU0pCRzk3bm5qdUdLT1NqKy93?=
 =?utf-8?B?VTRuaFV0SU5IRGNVSTRmSCtYbTNlWkNZajhoblBRcmp4K2x2Z200Sml2cER3?=
 =?utf-8?Q?p1syIMZy4JAZJE0Fi4LCaUnOU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b9f953-cf85-489a-95c8-08dc15af0708
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:47:46.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIwV3mZ5tn25B0bVAOWDQ1wm1knlSFPayjzSWJy2UvGDeFzn134yWMLpf69k1M7u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846

Am 13.01.24 um 23:55 schrieb Joshua Ashton:
> +Marek
>
> On 1/13/24 21:35, André Almeida wrote:
>> Hi Joshua,
>>
>> Em 13/01/2024 11:02, Joshua Ashton escreveu:
>>> We need to bump the karma of the drm_sched job in order for the context
>>> that we just recovered to get correct feedback that it is guilty of
>>> hanging.
>>>
>>> Without this feedback, the application may keep pushing through the 
>>> soft
>>> recoveries, continually hanging the system with jobs that timeout.
>>>
>>> There is an accompanying Mesa/RADV patch here
>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
>>> to properly handle device loss state when VRAM is not lost.
>>>
>>> With these, I was able to run Counter-Strike 2 and launch an 
>>> application
>>> which can fault the GPU in a variety of ways, and still have Steam +
>>> Counter-Strike 2 + Gamescope (compositor) stay up and continue
>>> functioning on Steam Deck.
>>>
>>
>> I sent a similar patch in the past, maybe you find the discussion 
>> interesting:
>>
>> https://lore.kernel.org/lkml/20230424014324.218531-1-andrealmeid@igalia.com/ 
>>
>
> Thanks, I had a peruse through that old thread.
>
> Marek definitely had the right idea here, given he mentions:
> "That supposedly depends on the compositor. There may be compositors for
> very specific cases (e.g. Steam Deck)"
>
> Given that is what I work on and also wrote this patch for that does 
> basically the same thing as was proposed. :-)
>
> For context though, I am less interested in Gamescope (the Steam Deck 
> compositor) hanging (we don't have code that hangs, if we go down, 
> it's likely Steam/CEF died with us anyway atm, can solve that battle 
> some other day) and more about the applications run under it.
>
> Marek is very right when he says applications that fault/hang will 
> submit one IB after another that also fault/hang -- especially if they 
> write to descriptors from the GPU (descriptor buffers), or use draw 
> indirect or anything bindless or...
> That's basically functionally equivalent to DOSing a system if it is 
> not prevented.
>
> And that's exactly what I see even in a simple test app doing a fault 
> -> hang every frame.
>
> Right now, given that soft recovery never marks a context as guilty, 
> it means that every app I tested is never stopped from submitting 
> garbage That holds true for basically any app that GPU hangs and makes 
> soft recovery totally useless in my testing without this.

Yeah, the problem is that your patch wouldn't help with that. A testing 
app can still re-create the context for each submission and so crash the 
system over and over again.

The question here is really if we should handled soft recovered errors 
as fatal or not. Marek is in pro of that Michel is against it.

Figure out what you want in userspace and I'm happy to implement it :)

>
> (That being said, without my patches, RADV treats *any* reset from the 
> query as VK_ERROR_DEVICE_LOST, even if there was no VRAM lost and it 
> was not guilty, so any faulting/hanging application causes every 
> Vulkan app to die e_e. This is fixed in 
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050 )

That is actually intended behavior. When something disrupted the GPU 
execution and the application is affected it is mandatory to forward 
this error to the application.

Regards,
Christian.

>
> - Joshie 🐸✨
>
>>
>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>
>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: André Almeida <andrealmeid@igalia.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 25209ce54552..e87cafb5b1c3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct 
>>> amdgpu_ring *ring, struct amdgpu_job *job)
>>>           dma_fence_set_error(fence, -ENODATA);
>>>       spin_unlock_irqrestore(fence->lock, flags);
>>> +    if (job->vm)
>>> +        drm_sched_increase_karma(&job->base);
>>>       atomic_inc(&ring->adev->gpu_reset_counter);
>>>       while (!dma_fence_is_signaled(fence) &&
>>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>


