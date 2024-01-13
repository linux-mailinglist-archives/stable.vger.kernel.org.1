Return-Path: <stable+bounces-10832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26AD82CEFF
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 23:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFC282D38
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 22:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A9DD297;
	Sat, 13 Jan 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b="NVdwZ+gJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A61802B
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3368ac0f74dso5391926f8f.0
        for <stable@vger.kernel.org>; Sat, 13 Jan 2024 14:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1705186540; x=1705791340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTM9dIGhg8HppSDbR++W5wyv6Uhch5Dm3NQVyrhOK78=;
        b=NVdwZ+gJK7VhWrskM6EMPa/3o7hVqMwd6+2SG7Ws6Hqhs+4UuoGxH0/BSsMV+lSdi5
         gteDqq58vKWW7KYvVGseTF0Z4oNnzhd+J0kYo/lFQnZoidgX2BEBNxpafNDavadqYW+h
         qEhAv8RA0tDOCMiTBiW+RQUjWhHqnkpDWwZVyXVuAafGkuEWQgH3JcH7g9UqIPE/264W
         /6JMvTu0gxUUBZ2SJCEzaXihmUYFNcSjz/9XTCItNEsU2Tz6kv2pIY8jABg0XT3y80/C
         v5bNmSpBJiQGYXJ8ObtjnX7F1wd64uNJ0mPZ0wQ3l4YBkaGnuciMUW2blq69EgVJCuiH
         1TIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705186540; x=1705791340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTM9dIGhg8HppSDbR++W5wyv6Uhch5Dm3NQVyrhOK78=;
        b=Svka5+GFHpFhYiSKOB4wIhf/XDZhXbsmcFs/ZsFnG/HKlARvt4TOWTe8nqsNFFBD9X
         yx9OqmS3Zb4Ws5FXx6MMKHpIxOKF7Xwg8mMmB7++qCwNsc/1lcnQbZ3cfZwbmG+YNURy
         O4S7rd/BpBhgr94v/IAjGQ7oOWql270nAP6KjaCLi5QqCQOIoaUy6dBl7Uzh4Hs2jtcz
         +eemUeSe1AtgEmJ9DDMl0iMteB3zFbsJvMj4vVxZxh202Em3a5JPK/I6ftRL5ukN1kbf
         1eKvukbdFpnpEzEFtbxmB3+5N6oyZ6Ic6IF4DRdqwuv2t4nUNYieCxl5mIG/iq0cTrxd
         6cJQ==
X-Gm-Message-State: AOJu0Yxjh0JXbcET7YOm7ClWVMLTpx3QaANRr/k94DL1Jd9IR8vtftbq
	ZzfkJYyPe73gw+vpi4mgXY4Cf1mVzS9BQw==
X-Google-Smtp-Source: AGHT+IG8ZY1qk1V1JAnqlGec7V3oUZ+ty3RypeJfghnR2SZyqgJBtll3AxF4Ol6z39eHoLmDmfmpPg==
X-Received: by 2002:adf:db48:0:b0:333:a28:bfc5 with SMTP id f8-20020adfdb48000000b003330a28bfc5mr2072386wrj.70.1705186540467;
        Sat, 13 Jan 2024 14:55:40 -0800 (PST)
Received: from [192.168.0.89] (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id q15-20020adfea0f000000b00336e6014263sm7701518wrm.98.2024.01.13.14.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 14:55:40 -0800 (PST)
Message-ID: <a88f1d5f-c13c-4b46-9bba-f96d43bd4e1a@froggi.es>
Date: Sat, 13 Jan 2024 22:55:39 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <66f8848f-13c8-4293-a207-012eadbc9018@igalia.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <66f8848f-13c8-4293-a207-012eadbc9018@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+Marek

On 1/13/24 21:35, André Almeida wrote:
> Hi Joshua,
> 
> Em 13/01/2024 11:02, Joshua Ashton escreveu:
>> We need to bump the karma of the drm_sched job in order for the context
>> that we just recovered to get correct feedback that it is guilty of
>> hanging.
>>
>> Without this feedback, the application may keep pushing through the soft
>> recoveries, continually hanging the system with jobs that timeout.
>>
>> There is an accompanying Mesa/RADV patch here
>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
>> to properly handle device loss state when VRAM is not lost.
>>
>> With these, I was able to run Counter-Strike 2 and launch an application
>> which can fault the GPU in a variety of ways, and still have Steam +
>> Counter-Strike 2 + Gamescope (compositor) stay up and continue
>> functioning on Steam Deck.
>>
> 
> I sent a similar patch in the past, maybe you find the discussion 
> interesting:
> 
> https://lore.kernel.org/lkml/20230424014324.218531-1-andrealmeid@igalia.com/

Thanks, I had a peruse through that old thread.

Marek definitely had the right idea here, given he mentions:
"That supposedly depends on the compositor. There may be compositors for
very specific cases (e.g. Steam Deck)"

Given that is what I work on and also wrote this patch for that does 
basically the same thing as was proposed. :-)

For context though, I am less interested in Gamescope (the Steam Deck 
compositor) hanging (we don't have code that hangs, if we go down, it's 
likely Steam/CEF died with us anyway atm, can solve that battle some 
other day) and more about the applications run under it.

Marek is very right when he says applications that fault/hang will 
submit one IB after another that also fault/hang -- especially if they 
write to descriptors from the GPU (descriptor buffers), or use draw 
indirect or anything bindless or...
That's basically functionally equivalent to DOSing a system if it is not 
prevented.

And that's exactly what I see even in a simple test app doing a fault -> 
hang every frame.

Right now, given that soft recovery never marks a context as guilty, it 
means that every app I tested is never stopped from submitting garbage 
That holds true for basically any app that GPU hangs and makes soft 
recovery totally useless in my testing without this.

(That being said, without my patches, RADV treats *any* reset from the 
query as VK_ERROR_DEVICE_LOST, even if there was no VRAM lost and it was 
not guilty, so any faulting/hanging application causes every Vulkan app 
to die e_e. This is fixed in 
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050 )

- Joshie 🐸✨

> 
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>
>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: André Almeida <andrealmeid@igalia.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 25209ce54552..e87cafb5b1c3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring 
>> *ring, struct amdgpu_job *job)
>>           dma_fence_set_error(fence, -ENODATA);
>>       spin_unlock_irqrestore(fence->lock, flags);
>> +    if (job->vm)
>> +        drm_sched_increase_karma(&job->base);
>>       atomic_inc(&ring->adev->gpu_reset_counter);
>>       while (!dma_fence_is_signaled(fence) &&
>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)


