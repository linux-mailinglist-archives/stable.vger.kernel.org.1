Return-Path: <stable+bounces-10889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBCA82D9E7
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 14:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1651C21354
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF05168D0;
	Mon, 15 Jan 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CQx163Yr"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CED171A0
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZepMtbmfSH5ELwiXvc2aWwY19KRx1BbFbLVJJp4fVO1zwWImCiJb+TRmEJ9Ju8SK6RTt+RG/A2muwGAHROBTMT1G/P4kku067r0lGkpyBCenTieCzDiu6NYsW/6iWqhGsj6WmC5dq2/Qv3dHFtcWBQmuYEppO/+Z8LZgqeNJZeBHKhujXj5xjSaw+3O8JgHa86Otj3bzgymTXotld5rpXbtABZPh5Nm5mS9y0iRi7BqxFRZDyDEs3K/wmIHG8q/LpX1kp0nr8KLeOTskXNWrIudcO7XP6JvhamUHc9ILS6Yo0FapDXnVJZnuHDBWjTH4kyJCjqKb7EfbjFYMRaJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3AznJ8zWXccRVD6GcI246huSxJR/HqAsaLS8a/iv8g=;
 b=fiMUnqkFq8GRpTlg2gdFyeI6yxzHsaMqyZPVKS8q+X0twZoz9BqXCblvn4jDN2c5V2jxENVBpX2VHe8UPLyFxnkGBqVWaN6BjHDIRT9zLYmsL/wqRPAdAoM8afkuQ2BgI33guRdK4FPXY0ZN3W0LYL5r1KvqPAvXApUFeDJnFqPVan9QRJi0OMd6gzThfxxh6fy7Kjg+0LIri8BIdKgYm2sh4P+kfryIgX4rQlTG4rePaGqHiGtUFS2jUnE6TEkDvqYwo9fc/0pKsWEY9zIhl2pxBSct4b7zCFytjQbazWtf1yy9tCu9OflCJaJLV2oxdoPxdfJxUbpUbUFbsI5TAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3AznJ8zWXccRVD6GcI246huSxJR/HqAsaLS8a/iv8g=;
 b=CQx163YrcZuqORQO7X/X2WZ7P/ceQmHNmZlnDAS+Wq4Vc74D0B16RZ3NH3HRYVLqtxBpwVR4CaGN8zPXNayLKs0MDS0o1EZPQMK7sGrLgiUd2DEMoSKqFeS/iZTQqe6/EJ05ffwcYocWsdZfOcqaJvVofhRN/Nr1gQe69k8majc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 13:19:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 13:19:27 +0000
Message-ID: <d8039165-0d54-4a42-a46a-922c1f691c24@amd.com>
Date: Mon, 15 Jan 2024 14:19:21 +0100
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
 <c71cc2ba-72f3-4869-b804-51d5d6704f49@amd.com>
 <68936df5-3f5b-47a9-b861-eeaa4030c893@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <68936df5-3f5b-47a9-b861-eeaa4030c893@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: e38edfcc-f7e8-4c6a-ad89-08dc15cc992b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FKPqfJMXSTcLyXXuoKNotjBedmHnzdFc6EfY3VJ1HLVwo27GcTfyO/yjSkRzuIRXoyhE2fgEO9rloRtkBTKPJ2u2tCP6TiF2VaykUOGU1cW/yC+HeYkd0iJsc9d6OZgRg/vMLbMpmB8pHvBOEusUIrCSlJ/5vnzON0wVsc1nHSYmMvezHfO5+TFsD4kKMeLYlT7txzYwdMhTD6bp/opINVK5bpzLJcDxmpPdxpweLD7EjFSvYEHmTBifgxRfqTWxoG/N9zudYGXh6abFkac+9r2/ObMPvD54tCHEr9XCAysad1yMilQIIoqkT1u6sSdXOJmEDJQJCZuzYWuucAva/oBwdX746ARdU9JCswUhjksKsHNbx15uzK98t32xNsOPTrVAtgYMxAQILclXNj9tLmsA/3/lN1yfiuhKwtYadJ8czBANtI8nKU42nyHbhgwxAsTzL/X8IUgrXrsTrbQ2kMRf+0qyBW7nSUQVrSzkuJZCNBGGvxxT6BG8PNQmGc17Wk9FADswZBgaKsm3qAv7Y8oB4x5HV94bIN9s5jkYL1XDH/T0iA2lCTVABDyfRiPEr5GRXavpABOL+r6QkHeNXZI3kKmkUxIjAxw9FcgOy5OoYHGTi5MS5xTBB0MD2PDW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(38100700002)(86362001)(36756003)(31696002)(41300700001)(66574015)(4326008)(26005)(2616005)(66946007)(66476007)(6512007)(66556008)(54906003)(478600001)(6666004)(316002)(966005)(110136005)(6506007)(8676002)(31686004)(8936002)(5660300002)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clBVRzQrNXIxRFR3UkRMbEpFNm1WbGtXeGxSazM0QS9iUkhxaW5Dai9PVURw?=
 =?utf-8?B?eXV3c3N3N2treTZJZmZGRXJNMGRwSllBR2I0TnZkNEt2ZG9MdzFjNFRGYnFT?=
 =?utf-8?B?WVVLZG5jblRmTFUvTy9nRTFDUklBWnRNNU15L2dsOUozaFBqYlVwT2srd2l0?=
 =?utf-8?B?T3E4VWRmcS94NUFwQU1QZ1hGQ1JHOC9XU2VCaFFlQ1lxOUo0eVhWZGdEeTYw?=
 =?utf-8?B?dU0zVEd4NkVyQXo5Q3V0cko1c0xmSzdQYzRFVXF2U2JTR21DZ1lQYkwxYzNi?=
 =?utf-8?B?TytpMzJCVWxGaG5XYzk0dnhMWjl3NVRmMm55N001TngyTXkzZ00zalZ1N0dJ?=
 =?utf-8?B?dDB5QlgrZ1NnZkdYMnNaSzNWZFJmSnBaUm9uaUJEUFdWZ1lLd1I4dm9zRlVK?=
 =?utf-8?B?N2hKRnBqaUZUWlcwMHk2VEpSRy8rY2pxUzZUTnRiY25Mby9pQ01STEFvdHFw?=
 =?utf-8?B?SXExb0p6ckJoNVJRUENwUzRJL3NZa2daODlCa0lsTmZFcElZODA1dElVNFJu?=
 =?utf-8?B?RDdwRzdVL1JJMkhpOVJHSytKMm1IQS9qb01KUFFSY05Zeld6Tzk1TmxIc1Ns?=
 =?utf-8?B?SlBKWmVhY0lpUjB2b1Z0bHVpaTcxbWFrV0RtZVY5QU0xa3BCd2tGcG5WRU03?=
 =?utf-8?B?LzgwWGQybjF4UEZKOEIyelFEMVhsQ2tnNmlFQ1pmeUJTYVc0d2NFa0NaYVhI?=
 =?utf-8?B?M1BrQm9lTFFMUDdxdFRmNXJSQ04rQk1McWgva0xZVWQxd09vTWZiT21iYmRZ?=
 =?utf-8?B?MDd2UCtRR2tZZmliNS95SHVIK3J4eVAyMUU4endaTlhUV2hWR2dmYzl4M3BK?=
 =?utf-8?B?QWkyQ0NCbmVMMzhOcTkybThmakJiQWtnSURFOVdjaHhOM1d4NWxrL2FsQmM5?=
 =?utf-8?B?TmQxRWhOU1hyRW15VFhCY21hZkZ0dG0zM1dxQkplczBJNDF3TGtjM2FWL3dw?=
 =?utf-8?B?OUNhcTZycVB5SnpnOFh1T3N0OFlzNWRjdnA3UmNGbkZ0OXB4dldnUzVyYmJw?=
 =?utf-8?B?enpGdTdUdzNqTEVXOUlYd3JjaFk4K2hqV0ZXajJUL2JHREpFb21HWTZpc0hX?=
 =?utf-8?B?dlJlQjA2bXFiZWtzQXVNQTdvZXBBOFV3RzFQWWRpb3lZL0tUYmdkMFpxZXo2?=
 =?utf-8?B?dDdPVGFZOXN2ejd6WjZnY1RncDZVTGdiaGx5QmJDRVZwSTFzOFZHTnFYMVdH?=
 =?utf-8?B?YWhkWkZleElUOEk3NGVRQmcva1RBZ2ZVekE5bER4YnEyWENBMjhpU21MY2xh?=
 =?utf-8?B?NjlXL3hRdzFrc2hOZGFNR1Q2TVZBaC8xc2dybWRBSkNKUkhnYzR2UVNnUTQ5?=
 =?utf-8?B?dUtqNzRVZGUvRDUzczdUTGtXM1ZhMXVkODhlanJGaUovRmJpdHlPTzFZSnV0?=
 =?utf-8?B?VkhzdDAxam1nMTl2Rk5YZE1OeFNCcnBIQXRTaFdzM1Blek83aXhXWHltQmFz?=
 =?utf-8?B?S2RhUTJnOCtLbXg3dDlhVUFjMmhOanAxdE8wbm9ocU5HQTl2WnNxdlhmV1cx?=
 =?utf-8?B?aldmOFFEYktsNWQ4dHdHby9YMEdyTTl6UzFNZmNZNE4rdFd6cHRHS1lsNnUx?=
 =?utf-8?B?MGtNWlpldS9TMlR2dHZLVHVpWGhDWWhTUUM0WlR6d0RsVkFqRGxIV1BaQVBF?=
 =?utf-8?B?UXEyMWdaUFgyUDZBQk1pSDRWRFgweklTQTF1cjFRYkI1QU5kTjJBQTR4Q09N?=
 =?utf-8?B?aThWUzVZT0d3bUQzYVZwUENYUFNuS1lONEozeGhER3ZodVFXOFQwRS9oeHF2?=
 =?utf-8?B?ZWd2aHdiMEtNclc4dHF5Ull3djQ0NW9CcFJLeHRabmJyb3pjT2JVdXFNVzh2?=
 =?utf-8?B?OW4xT05FVWhOaExHcm5HTTZOVVR3OTk3Tkg3TUw2ekJGSE9yYTNHcFFpSWhR?=
 =?utf-8?B?QldsNWhrVlA0MXo0OFgxaU11QWRDbUpGTHpkdUQ4bkRqTVhhQ2h1WURFVzB0?=
 =?utf-8?B?dkd0V3FEaVZqd2ZLby95cE9PT1lWVTlOdjluYUs5V29Yb3Q5TXc4RDZPSjdE?=
 =?utf-8?B?WmZNSnJuZTNzUzdZMEhZRC9WS1dzVkcwekJxSHlmZlR1WmhPRFZaditXbk5k?=
 =?utf-8?B?SVZrb0dKVERiR0FYc3ByanIvb2lRTjBQaTJEaFJkaTAwakt0RnhheHg2VGJU?=
 =?utf-8?Q?ss6DofEyF9u5KIxJsGQbvC4BA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38edfcc-f7e8-4c6a-ad89-08dc15cc992b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 13:19:26.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+93gTlY8gT9O1AqSWzC1/aT7GCUD5w60bTBKcmGcEhGrqLIFAmdQcf8NITh45df
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134

Am 15.01.24 um 12:54 schrieb Joshua Ashton:
> [SNIP]
>>
>> The question here is really if we should handled soft recovered 
>> errors as fatal or not. Marek is in pro of that Michel is against it.
>>
>> Figure out what you want in userspace and I'm happy to implement it :)
>>
>>>
>>> (That being said, without my patches, RADV treats *any* reset from 
>>> the query as VK_ERROR_DEVICE_LOST, even if there was no VRAM lost 
>>> and it was not guilty, so any faulting/hanging application causes 
>>> every Vulkan app to die e_e. This is fixed in 
>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050 )
>>
>> That is actually intended behavior. When something disrupted the GPU 
>> execution and the application is affected it is mandatory to forward 
>> this error to the application.
>
> No. If said context was entirely unaffected, then it should be 
> completely transparent to the application.
>
> Consider the following:
>
>  - I have Counter-Strike 2 running
>  - I have Gamescope running
>
> I then go ahead and start HangApp that hangs the GPU.
>
> Soft recovery happens and that clears out all the work for the 
> specific VMID for HangApp's submissions and signals the submission fence.
>
> In this instance, the Gamescope and Counter-Strike 2 ctxs are 
> completely unaffected and don't need to report VK_ERROR_DEVICE_LOST as 
> there was no impact to their work.

Ok, that is something I totally agree on. But why would the Gamescope 
and Counter-Strike 2 app report VK_ERROR_DEVICE_LOST for a soft recovery 
in the first place?

IIRC a soft recovery doesn't increment the reset counter in any way. So 
they should never be affected.

Regards,
Christian.

>
> Even if Gamescope or Counter-Strike 2 were occupying CUs in tandem 
> with HangApp, FWIU the way that the clear-out works being vmid 
> specific means that they would be unaffected, right?
>
> - Joshie 🐸✨
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> - Joshie 🐸✨
>>>
>>>>
>>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>>>
>>>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: André Almeida <andrealmeid@igalia.com>
>>>>> Cc: stable@vger.kernel.org
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> index 25209ce54552..e87cafb5b1c3 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct 
>>>>> amdgpu_ring *ring, struct amdgpu_job *job)
>>>>>           dma_fence_set_error(fence, -ENODATA);
>>>>>       spin_unlock_irqrestore(fence->lock, flags);
>>>>> +    if (job->vm)
>>>>> +        drm_sched_increase_karma(&job->base);
>>>>> atomic_inc(&ring->adev->gpu_reset_counter);
>>>>>       while (!dma_fence_is_signaled(fence) &&
>>>>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>>
>>
>


