Return-Path: <stable+bounces-10884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFA82D89F
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 12:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E73282043
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 11:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3AB2C6B0;
	Mon, 15 Jan 2024 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b="LR/XbS1D"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CEE2C857
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3368ac0f74dso6311120f8f.0
        for <stable@vger.kernel.org>; Mon, 15 Jan 2024 03:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1705319693; x=1705924493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkLXbsRUWuYFmYzD3U2wk60gzs3ljmE+1uQWIZpO9KU=;
        b=LR/XbS1DmURJ8yrdAcWTzc3izqp3iec5jFLPEsPf8a2Tqs5lo50pQcCORc++A5XlfP
         bZKW+huiQ/art+vXp9m+k33CZX4ld5zV8YA2AP3Ky5KXPtrFlqti5DFMep6AtAFtDFtU
         brfTXgnuqr7ep2ti8Ey9ITb6AsGE06tB0L8U5Y9G5bF+OtY0CZp6bssBCRcNfj8U8o3B
         WYdIGa2YQZ07Ys99M0jpD7s8kkgh8kCykUbP3qj14aWT30SdwZBLKH+c0842Ha6LiGuL
         tcUJIZxlTdRs2icd5YXiZ8lUi+eWstTVIQgG8AKy+iV4Lp6AUxiL9tNb2W2EbHCxbT72
         m4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705319693; x=1705924493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkLXbsRUWuYFmYzD3U2wk60gzs3ljmE+1uQWIZpO9KU=;
        b=sGNVjygPPyr3+WrKM/V0x8cbEhm6FBAVLPJ6qN2eSUH8lrDpbuip/HcSQ/iyLaGouO
         KO5SI+0z+I+sK0VgWc6nWCY59lqndEWK2pRemQtUHke7NE5E8gmHF0iu+mbe+xVJh1c+
         F76M5ALjYHj2CX1flhFQwSKUvELZZHD/G97xWCeMINSksvXnaSLSesvMTenx+TskcVzF
         H5kZUkQDgcLCocQ8FJZch4SNZpnYrYyAqG6nWDUtQGaA/5WJk5/kOhCQliKa3yG/ANgM
         P7x+sE5nvVIOywag2g2EsnZ3XpDglQ+ovEiykTaL3nxgC7tszewUUqYElQefbdP2GAxh
         7WfQ==
X-Gm-Message-State: AOJu0Yy7C0+iH+74ynbFX5Jk1W7USwOP5r07gDPgYlS3aq7RuOG+QB38
	gx5YYnH80CZRpn+6b9wnZniZnPYq5ROV/A==
X-Google-Smtp-Source: AGHT+IGmoPhLP6IQVJFJML5BZ2sTZWz7ZyKX5C8maESZPYJ1OgUbC9rBbji0eEA4HD9tPpqXskHoQg==
X-Received: by 2002:a05:6000:14d:b0:336:83cd:ef4c with SMTP id r13-20020a056000014d00b0033683cdef4cmr3307616wrx.86.1705319693196;
        Mon, 15 Jan 2024 03:54:53 -0800 (PST)
Received: from [192.168.0.89] (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe9c5000000b0033673ddd81csm11643161wrn.112.2024.01.15.03.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 03:54:52 -0800 (PST)
Message-ID: <68936df5-3f5b-47a9-b861-eeaa4030c893@froggi.es>
Date: Mon, 15 Jan 2024 11:54:52 +0000
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
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <c71cc2ba-72f3-4869-b804-51d5d6704f49@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/15/24 09:47, Christian König wrote:
> Am 13.01.24 um 23:55 schrieb Joshua Ashton:
>> +Marek
>>
>> On 1/13/24 21:35, André Almeida wrote:
>>> Hi Joshua,
>>>
>>> Em 13/01/2024 11:02, Joshua Ashton escreveu:
>>>> We need to bump the karma of the drm_sched job in order for the context
>>>> that we just recovered to get correct feedback that it is guilty of
>>>> hanging.
>>>>
>>>> Without this feedback, the application may keep pushing through the 
>>>> soft
>>>> recoveries, continually hanging the system with jobs that timeout.
>>>>
>>>> There is an accompanying Mesa/RADV patch here
>>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
>>>> to properly handle device loss state when VRAM is not lost.
>>>>
>>>> With these, I was able to run Counter-Strike 2 and launch an 
>>>> application
>>>> which can fault the GPU in a variety of ways, and still have Steam +
>>>> Counter-Strike 2 + Gamescope (compositor) stay up and continue
>>>> functioning on Steam Deck.
>>>>
>>>
>>> I sent a similar patch in the past, maybe you find the discussion 
>>> interesting:
>>>
>>> https://lore.kernel.org/lkml/20230424014324.218531-1-andrealmeid@igalia.com/
>>
>> Thanks, I had a peruse through that old thread.
>>
>> Marek definitely had the right idea here, given he mentions:
>> "That supposedly depends on the compositor. There may be compositors for
>> very specific cases (e.g. Steam Deck)"
>>
>> Given that is what I work on and also wrote this patch for that does 
>> basically the same thing as was proposed. :-)
>>
>> For context though, I am less interested in Gamescope (the Steam Deck 
>> compositor) hanging (we don't have code that hangs, if we go down, 
>> it's likely Steam/CEF died with us anyway atm, can solve that battle 
>> some other day) and more about the applications run under it.
>>
>> Marek is very right when he says applications that fault/hang will 
>> submit one IB after another that also fault/hang -- especially if they 
>> write to descriptors from the GPU (descriptor buffers), or use draw 
>> indirect or anything bindless or...
>> That's basically functionally equivalent to DOSing a system if it is 
>> not prevented.
>>
>> And that's exactly what I see even in a simple test app doing a fault 
>> -> hang every frame.
>>
>> Right now, given that soft recovery never marks a context as guilty, 
>> it means that every app I tested is never stopped from submitting 
>> garbage That holds true for basically any app that GPU hangs and makes 
>> soft recovery totally useless in my testing without this.
> 
> Yeah, the problem is that your patch wouldn't help with that. A testing 
> app can still re-create the context for each submission and so crash the 
> system over and over again.

It is still definitely possible for an application to do re-create its 
context and hang yet again -- however that is not the problem I am 
trying to solve here.

The problem I am trying to solve is that applications do not even get 
marked guilty when triggering soft recovery right now.

The patch does help with that on SteamOS, as the type of applications we 
deal with that hang, just abort on VK_ERROR_DEVICE_LOST.

If a UI toolkit that handles DEVICE_LOST keeps doing this, then yes it 
would not help, but this patch is also a necessary step towards fixing 
that someday. (Eg. some policy where processes are killed for hanging 
too many times, etc)

> 
> The question here is really if we should handled soft recovered errors 
> as fatal or not. Marek is in pro of that Michel is against it.
> 
> Figure out what you want in userspace and I'm happy to implement it :)
> 
>>
>> (That being said, without my patches, RADV treats *any* reset from the 
>> query as VK_ERROR_DEVICE_LOST, even if there was no VRAM lost and it 
>> was not guilty, so any faulting/hanging application causes every 
>> Vulkan app to die e_e. This is fixed in 
>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050 )
> 
> That is actually intended behavior. When something disrupted the GPU 
> execution and the application is affected it is mandatory to forward 
> this error to the application.

No. If said context was entirely unaffected, then it should be 
completely transparent to the application.

Consider the following:

  - I have Counter-Strike 2 running
  - I have Gamescope running

I then go ahead and start HangApp that hangs the GPU.

Soft recovery happens and that clears out all the work for the specific 
VMID for HangApp's submissions and signals the submission fence.

In this instance, the Gamescope and Counter-Strike 2 ctxs are completely 
unaffected and don't need to report VK_ERROR_DEVICE_LOST as there was no 
impact to their work.

Even if Gamescope or Counter-Strike 2 were occupying CUs in tandem with 
HangApp, FWIU the way that the clear-out works being vmid specific means 
that they would be unaffected, right?

- Joshie 🐸✨

> 
> Regards,
> Christian.
> 
>>
>> - Joshie 🐸✨
>>
>>>
>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>>
>>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: André Almeida <andrealmeid@igalia.com>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> index 25209ce54552..e87cafb5b1c3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct 
>>>> amdgpu_ring *ring, struct amdgpu_job *job)
>>>>           dma_fence_set_error(fence, -ENODATA);
>>>>       spin_unlock_irqrestore(fence->lock, flags);
>>>> +    if (job->vm)
>>>> +        drm_sched_increase_karma(&job->base);
>>>>       atomic_inc(&ring->adev->gpu_reset_counter);
>>>>       while (!dma_fence_is_signaled(fence) &&
>>>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>
> 


