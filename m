Return-Path: <stable+bounces-10882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9582D872
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 12:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B231B21536
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF812219E1;
	Mon, 15 Jan 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b="iVY5u3/o"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24D2C683
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33677fb38a3so8343583f8f.0
        for <stable@vger.kernel.org>; Mon, 15 Jan 2024 03:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1705318673; x=1705923473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTOdc5bDe9TOqL9Ql33LV9TRfUB/nJ9yP/VTvwM7f+8=;
        b=iVY5u3/oxqYz8yFrK7UdXVQ3xS5bcR0r+lolN/RnBB3cqbhNKHwkZiMIJtF/JWMSfN
         bOmDLDfYHnOs5VHi4u65q3mBuJoZM8uzCg5AGhNp4POQG7t36ijHOv4knnVp50vKFDZA
         cGfozJcBlvSM2NtrbsMCvJ8cPECEETzkVL1pORqeXc7T2g3aBxkAtX6RADCctptL5F9v
         iugv7oCMKd/9N1DVjrq9d4V1z0sRoXvlCzA6fAOX8s8TFEy+vkLVPToInIwzciDncad5
         F6QvDU7u8nTlSyTwAKwN+bP3020KshPSn3mD/+D2CmkBELszYH8D1pPnn6K4sO8BcueO
         M36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705318673; x=1705923473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTOdc5bDe9TOqL9Ql33LV9TRfUB/nJ9yP/VTvwM7f+8=;
        b=u5QNJzV0+OV+W2mZu5g/BLypLqaLwwyR1JqG7xs6vjyey+ZIBNOhs28ZWX/SguFwSj
         yCGNPpmTzX5z8IHt6eAZxjyQPXFO/7Z5Uddn6Xy/XOhSzFdaL4wJwJT6ryrXmBpBLkNH
         iWRoFF9B5odjzoHKdpI/IgxNvVAkjjZUZMDZSQHXyaTPg20j8dEOlfKcmgT/uMX7tvlj
         QYymcb/6AkQ0hT13IKpiTbSSZ3lxtA8CB1rR5JhAhg++3pFBhdiGV7yEUXwVkp5Vkch7
         kbxJ8TmpxcQrBi9mvg1vaJPkGUd7hGrgPs7XmDQiYR5ZSi7iwNY1MLopJT2fA08M5jYg
         12lA==
X-Gm-Message-State: AOJu0YzKEKe24qOC2QwcgVPW/sMkFQc0onc0WULxiR7rvR949YdgaFP3
	aoiCuZdU8EC9AWcBp9V8lue4jbFLvC7C0A==
X-Google-Smtp-Source: AGHT+IE24kKJ6tsPrEOCvFY+UPRRBt4V5a0xnkUBRJyD4lDsOhaSzdKeMYOrmk5xuVYr2hq5IlKoCA==
X-Received: by 2002:a05:6000:1247:b0:337:4698:5bcb with SMTP id j7-20020a056000124700b0033746985bcbmr2734185wrx.119.1705318672360;
        Mon, 15 Jan 2024 03:37:52 -0800 (PST)
Received: from [192.168.0.89] (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id h10-20020adf9cca000000b00337afd67f40sm57092wre.1.2024.01.15.03.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 03:37:52 -0800 (PST)
Message-ID: <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
Date: Mon, 15 Jan 2024 11:37:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/15/24 09:40, Christian König wrote:
> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
>> We need to bump the karma of the drm_sched job in order for the context
>> that we just recovered to get correct feedback that it is guilty of
>> hanging.
> 
> Big NAK to that approach, the karma handling is completely deprecated.
> 
> When you want to signal execution errors please use the fence error code.

The fence error code does not result in ctx's being marked as guilty, 
only the karma path does.

See drm_sched_increase_karma.

Are you proposing that we instead mark contexts as guilty with the fence 
error ourselves here?

> 
>> Without this feedback, the application may keep pushing through the soft
>> recoveries, continually hanging the system with jobs that timeout.
> 
> Well, that is intentional behavior. Marek is voting for making soft 
> recovered errors fatal as well while Michel is voting for better 
> ignoring them.
> 
> I'm not really sure what to do. If you guys think that soft recovered 
> hangs should be fatal as well then we can certainly do this.

They have to be!

As Marek and I have pointed out, applications that hang or fault will 
just hang or fault again, especially when they use things like draw 
indirect, buffer device address, descriptor buffers, etc.

The majority of apps these days have a lot of side effects and 
persistence between frames and submissions.

- Joshie 🐸✨

> 
> Regards,
> Christian.
> 
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
> 



