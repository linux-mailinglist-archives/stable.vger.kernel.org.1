Return-Path: <stable+bounces-11311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B082E9D6
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 08:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30951F2376A
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 07:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940B410A21;
	Tue, 16 Jan 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm4K5LbC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34BF10A1E
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e800461baso9572065e9.3
        for <stable@vger.kernel.org>; Mon, 15 Jan 2024 23:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705389466; x=1705994266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BW+W+dIv4lN7r4SC9Umj94UHkB8iKRe5wxYPF0vpeL0=;
        b=Nm4K5LbColdCApidhrlmrTGnhfniQNKEvgmKT+nNsq/+X6KVZdxDdxmA7Nv3+Qglkl
         H12qXrhMW6gZfjPf4S1WoSf1VuHz/Cfyinn0n1B8uMQ/TGwAX6ejlAmcsO3OHJsqSXJf
         zqFhAeCe9S0BLckvC4yYhd0IFzYTBj3ltojMPELIMr3TCe5eeOpJMb7X8S8tzj98eNar
         upxp/+BJkoX0pa06anqBoWjq58wr/qQHS2pZsXtQEAAtlQsHsqnJMzCzziUJTpcU4U/K
         9ck4NYIGsbSM6KSV3ir6cKlCKhR1xjiDY8LkWaz72SUreL8G/A2UQe0dROE8oZSWkNU7
         uw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705389466; x=1705994266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BW+W+dIv4lN7r4SC9Umj94UHkB8iKRe5wxYPF0vpeL0=;
        b=sNUH9iEFppXPK7+LlpPkeSlxKuvSC07F/+P146aJEd/odw8OMzFRDv1gOpGTOT+4CP
         dqY4iNGNm6wUirAsdFyoo/L4fy3PEYgvS1uPwpT6/STpraSeeV1VSapQQ8Mb418wK7Y8
         aFx3ZwzwfUXPW5aagaZVZKGZFgKaNWapuXDWxNDDjpiJAuP+LL9eTKyjU1YGWBMPcHxe
         A2+nrHVGPX1K2bX8ofAytVYZW3fskWAo/lgrcJD+rkoVsfHp29y2hmdHLq2JXiLE1IDl
         D1RWUsSXdvgx3u+BZIPG7cIRcOpt5yxlE7vthILfxG3QnREtQpYoGhfPwaV+rKG8Uw7i
         pCpA==
X-Gm-Message-State: AOJu0Yw705rfHJqk6R7UXLal26UkGB/c7ZttPU+K3Y5pZ1EdG+beAvOv
	UdNy0QeynP9X1s3P3niVMMLdLRXpeW9oEg==
X-Google-Smtp-Source: AGHT+IEFTD9mOGuy4O+1A27ae4lkNbmqjc8773lZH0WP+R2mfsYFBKQ9T5aqV8so5vOj3q10koJtkQ==
X-Received: by 2002:a05:600c:4314:b0:40e:43dd:1e47 with SMTP id p20-20020a05600c431400b0040e43dd1e47mr2015713wme.261.1705389465598;
        Mon, 15 Jan 2024 23:17:45 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040d8ff79fd8sm18255442wmb.7.2024.01.15.23.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 23:17:45 -0800 (PST)
Message-ID: <3df101b7-8df6-44a0-8c53-aaec480a1907@gmail.com>
Date: Tue, 16 Jan 2024 08:17:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Process fences on IH overflow
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Joshua Ashton
 <joshua@froggi.es>, stable@vger.kernel.org
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <20240114130008.868941-2-friedrich.vock@gmx.de>
 <ef01b29e-8529-43d2-befc-a3e3d8eaccf9@gmail.com>
 <8e81fd02-c5e3-4c0c-bb8f-b81217863ce2@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <8e81fd02-c5e3-4c0c-bb8f-b81217863ce2@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.01.24 um 12:19 schrieb Friedrich Vock:
> On 15.01.24 11:26, Christian König wrote:
>> Am 14.01.24 um 14:00 schrieb Friedrich Vock:
>>> If the IH ring buffer overflows, it's possible that fence signal events
>>> were lost. Check each ring for progress to prevent job timeouts/GPU
>>> hangs due to the fences staying unsignaled despite the work being done.
>>
>> That's completely unnecessary and in some cases even harmful.
> How is it harmful? The only effect it can have is prevent unnecessary
> GPU hangs, no? It's not like it hides any legitimate errors that you'd
> otherwise see.

We have no guarantee that all ring buffers are actually fully 
initialized to allow fence processing.

Apart from that fence processing is the least of your problems when an 
IV overflow occurs. Other interrupt source which are not repeated are 
usually for more worse.

>>
>> We already have a timeout handler for that and overflows point to
>> severe system problem so they should never occur in a production system.
>
> IH ring buffer overflows are pretty reliably reproducible if you trigger
> a lot of page faults, at least on Deck. Why shouldn't enough page faults
> in quick succession be able to overflow the IH ring buffer?

At least not on recent hw generations. Since gfx9 we have a rate limit 
on the number of page faults generated.

What could maybe do as well is to change the default of vm_fault_stop, 
but for your case that would be even worse in production.

>
> The fence fallback timer as it is now is useless for this because it
> only gets triggered once after 0.5s. I guess an alternative approach
> would be to make a timer trigger for each work item in flight every
> 0.5s, but why should that be better than just handling overflow errors
> as they occur?

That is intentional. As I said an IH overflow just points out that there 
is something massively wrong in the HW programming.

After gfx9 the IH should never produce overflow any more, otherwise 
either the ratelimit doesn't work or isn't enabled for some reason or 
the IH ring buffer is just to small.

Regards,
Christian.

>
> Regards,
> Friedrich
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Cc: Joshua Ashton <joshua@froggi.es>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: stable@vger.kernel.org
>>>
>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> index f3b0aaf3ebc6..2a246db1d3a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> @@ -209,6 +209,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev,
>>> struct amdgpu_ih_ring *ih)
>>>   {
>>>       unsigned int count;
>>>       u32 wptr;
>>> +    int i;
>>>
>>>       if (!ih->enabled || adev->shutdown)
>>>           return IRQ_NONE;
>>> @@ -227,6 +228,20 @@ int amdgpu_ih_process(struct amdgpu_device
>>> *adev, struct amdgpu_ih_ring *ih)
>>>           ih->rptr &= ih->ptr_mask;
>>>       }
>>>
>>> +    /* If the ring buffer overflowed, we might have lost some fence
>>> +     * signal interrupts. Check if there was any activity so the 
>>> signal
>>> +     * doesn't get lost.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>> +            struct amdgpu_ring *ring = adev->rings[i];
>>> +
>>> +            if (!ring || !ring->fence_drv.initialized)
>>> +                continue;
>>> +            amdgpu_fence_process(ring);
>>> +        }
>>> +    }
>>> +
>>>       amdgpu_ih_set_rptr(adev, ih);
>>>       wake_up_all(&ih->wait_process);
>>>
>>> -- 
>>> 2.43.0
>>>
>>


