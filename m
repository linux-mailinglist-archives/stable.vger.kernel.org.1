Return-Path: <stable+bounces-10891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B632A82DAD6
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 15:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D709282A89
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9517577;
	Mon, 15 Jan 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b="FI9Hk836"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB617981
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336c9acec03so7316127f8f.2
        for <stable@vger.kernel.org>; Mon, 15 Jan 2024 06:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1705327247; x=1705932047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFgMWqZZzeVfJ0BqRYToYGxFbh3mG9YLb2S6nyGM1xo=;
        b=FI9Hk836VosMIxOwSG1xwVwNy7qjs2TOoRuEv+YD7lFukVskHIebXIEi20mvL+eK9t
         52SEdG1VsjUP2hoLxkJh2YxvPBtcJWQvwLyQp0HGE82677FtJSOHTACtW0W0ILGDIbeL
         mzx8JkXqPCfPs5XU03eEVUMAVMxJ900OACTc5QVqVlprZEjraAB1HPrY9PTF6JjvzlVq
         YTg4rekFyR31QbIPrR9zTiIqmoLFfuTGJ1jUiqvTtDnZccddozLiNV5C5b2ddaf5WwpE
         e3sweISY22/jWK3MG/TuFcRcGmlPRCqKNgcK9ey6n/YZJVaeu9Zxjd/jvzIxOeHNGGvm
         bT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705327247; x=1705932047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFgMWqZZzeVfJ0BqRYToYGxFbh3mG9YLb2S6nyGM1xo=;
        b=diG0L0lWQfiAxsdrsd5uipzZ2bj1jhf0QLEt+m4doytOkqfDkl/3s6P88vqW91pBZz
         yK1O2rKCXH3xunHmKKlBWwCXfiE8zOCvGyfOxf9loOlqufCKb73ZC6khMrKkSSt5CCJ7
         CySzD28ccGVB66Mpw1NdE2uKaSgZmQ3EqkUIcH0p0dfmn/5EkLtwbfHI2MjHj+FYVmvC
         3EZjIVNS8xNfJ3BJRUJY69/qyRwuZyrJLt1YB/wa7QZejLFBTK+LbPMWGQId53h+Id2h
         FqsI3cxZeye//GlXqFJRqyyDJO8/aUFyJ7CsqX7H1/hYup7aQSRoRtmE1ew43YAjTDQg
         7nKA==
X-Gm-Message-State: AOJu0Yyphs/OshQDQCUqHd8JpHV5UFSKfh9625ChpdocacZfLr9wejRM
	3nx0dnnW29coRnOsR5+lHthstuslD+zFmoWq7gSF4G3P0/c=
X-Google-Smtp-Source: AGHT+IF+MoSyWSLAxyW59bSmFQq1rcoH06DfOJ6Dzssc/D8jgh/2zUTQeal28MoWVbCZP+8OxsLdPw==
X-Received: by 2002:adf:a306:0:b0:337:6f4e:3833 with SMTP id c6-20020adfa306000000b003376f4e3833mr3329645wrb.12.1705327247030;
        Mon, 15 Jan 2024 06:00:47 -0800 (PST)
Received: from [192.168.0.89] (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id d15-20020adf9c8f000000b00336c43b366fsm12011870wre.12.2024.01.15.06.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 06:00:46 -0800 (PST)
Message-ID: <4dc0c6c6-6f6e-4b04-b611-78b181e4d7a6@froggi.es>
Date: Mon, 15 Jan 2024 14:00:46 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
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
 <d8039165-0d54-4a42-a46a-922c1f691c24@amd.com>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <d8039165-0d54-4a42-a46a-922c1f691c24@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/15/24 13:19, Christian König wrote:
> Am 15.01.24 um 12:54 schrieb Joshua Ashton:
>> [SNIP]
>>>
>>> The question here is really if we should handled soft recovered 
>>> errors as fatal or not. Marek is in pro of that Michel is against it.
>>>
>>> Figure out what you want in userspace and I'm happy to implement it :)
>>>
>>>>
>>>> (That being said, without my patches, RADV treats *any* reset from 
>>>> the query as VK_ERROR_DEVICE_LOST, even if there was no VRAM lost 
>>>> and it was not guilty, so any faulting/hanging application causes 
>>>> every Vulkan app to die e_e. This is fixed in 
>>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050 )
>>>
>>> That is actually intended behavior. When something disrupted the GPU 
>>> execution and the application is affected it is mandatory to forward 
>>> this error to the application.
>>
>> No. If said context was entirely unaffected, then it should be 
>> completely transparent to the application.
>>
>> Consider the following:
>>
>>  - I have Counter-Strike 2 running
>>  - I have Gamescope running
>>
>> I then go ahead and start HangApp that hangs the GPU.
>>
>> Soft recovery happens and that clears out all the work for the 
>> specific VMID for HangApp's submissions and signals the submission fence.
>>
>> In this instance, the Gamescope and Counter-Strike 2 ctxs are 
>> completely unaffected and don't need to report VK_ERROR_DEVICE_LOST as 
>> there was no impact to their work.
> 
> Ok, that is something I totally agree on. But why would the Gamescope 
> and Counter-Strike 2 app report VK_ERROR_DEVICE_LOST for a soft recovery 
> in the first place?
> 
> IIRC a soft recovery doesn't increment the reset counter in any way. So 
> they should never be affected.

It does, and without assigning any guilt, amdgpu_ring_soft_recovery 
calls atomic_inc(&ring->adev->gpu_reset_counter).


> 
> Regards,
> Christian.
> 
>>
>> Even if Gamescope or Counter-Strike 2 were occupying CUs in tandem 
>> with HangApp, FWIU the way that the clear-out works being vmid 
>> specific means that they would be unaffected, right?
>>
>> - Joshie 🐸✨
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> - Joshie 🐸✨
>>>>
>>>>>
>>>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>>>>
>>>>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>>>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>> Cc: André Almeida <andrealmeid@igalia.com>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>>>>>>   1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>> index 25209ce54552..e87cafb5b1c3 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct 
>>>>>> amdgpu_ring *ring, struct amdgpu_job *job)
>>>>>>           dma_fence_set_error(fence, -ENODATA);
>>>>>>       spin_unlock_irqrestore(fence->lock, flags);
>>>>>> +    if (job->vm)
>>>>>> +        drm_sched_increase_karma(&job->base);
>>>>>> atomic_inc(&ring->adev->gpu_reset_counter);
>>>>>>       while (!dma_fence_is_signaled(fence) &&
>>>>>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>>>
>>>
>>
> 

- Joshie 🐸✨

