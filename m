Return-Path: <stable+bounces-27229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D6877B09
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 07:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A52822D6
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 06:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06893F4E7;
	Mon, 11 Mar 2024 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNs3w59q"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEC847B
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710139565; cv=none; b=DR6HsszetycL5h9P/xjj4qCrto6yRNDKUx2zNAq99i8J8hh+nE6cNXN19IzN0eEadePFP6+PS1F9WcoDy8CBosmGjEayQaiNViQtUFYdjFx28cMBClEtu+EPhS+sDoiR51Ss8x8B5YKpOYJ90jcVrFZhLm5wUcJETEDzjzxARns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710139565; c=relaxed/simple;
	bh=KGKD9sMwS585C+x8vbvBvu7un2Du98T7hid9Nz804Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAsQHgMzRZMLK/JJyfOSIbibHLaglz+IELtndfswIHnaVFZ0b51KKwp9pe5rFQ6ftEVFVwP/Ubhim9Ytkadbq7L06sYnqhB04hrHuytea9URiClrlUWVBv+SLk4M9WA/sIdp+hOpBZ9mr9Rga+EA/nNaJJ466DqVgFWRLyEBGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNs3w59q; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5139d80f8b6so1621619e87.1
        for <stable@vger.kernel.org>; Sun, 10 Mar 2024 23:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710139560; x=1710744360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qll/LXCj9io37xmVDKRD/JmJOJFmsP9Qd8oxeZeNLK0=;
        b=LNs3w59qTAxVqCYQZSKxtXt7dszgl43/bmqiqbtZLKwAYBYK9GzVV0pjYABC1YoVYr
         HQt7GEXCqxxeHewIldmyijIhOQf3sSAKcIaOS5B34N+oahplpuSYwHi5jRcCzSBBgVqO
         riqSfz21fR2dX2TaXD7i91U3l1ApQZI9iX4AE/JHI0vAHr3N6E293OJDf3E/P6WmDkIK
         M3GDfnKFnYDE4ZEiit/6Xh3Hy62eeu7gLck2QyvQ8jGU/KG2DLDiPLkPP4b5SSd51p9s
         y6KUGePn419b3PHO6YJBiuw0ef70xDmWpdnUVk+QKfdp6RqAoMPt+LyQSwC9RZOISkbx
         T8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710139560; x=1710744360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qll/LXCj9io37xmVDKRD/JmJOJFmsP9Qd8oxeZeNLK0=;
        b=avDue9z0JbVunYBc29BcaphiZEWwd/QvbAVIOgAi+Yz7E42aMSRBAXsZQFYXhuITcr
         xwHhKKFo8/bz348VEIeWZhVAseqvKW4Jj0G4wGx2TjPytyckD4BfG3NUDkCJ1Fr0WS9b
         oreuxFCgFDgGm7t8yab6MkR+XDPlQLUV47aeL0hjgUGJCteJBlA7BZggrtsyh5UQEq6N
         7fwLEaPltzs0RSD4kLnh1RkcybTpMnzIxsn711/dfy3RW8VnB+wc49GYAeCCeTl0BVBH
         7/GmOI+dTooybTwzfbJ1+0JoVquxzEdTlu3hCWaFchCXgem7cpTkjaPrjk8PfVnof2Lq
         YgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF0m5jnmbBJBo/i+pv2IqQnQJ6kZafC4iJUfEt9D91sIpGzfouicHM44kixJSiTjZMIUYKMwEL4fw0/70gLFISKj3IcM+6
X-Gm-Message-State: AOJu0YxCNodY4Clh50CL2felVFchL3tRHX3ekKlVfclL4CsMQMh9S83q
	cU3Ymm/K2OQPjKOIeR3TJU8Gp2rUvDmeNthvZu8PqmqRW31dk7UEyQA45ac76pE=
X-Google-Smtp-Source: AGHT+IFmvuglqGER74qi1M1YFUvf342Xos8X0iV57Box7xhAC8x2KwIhhEtZm8PvRD1wW5OWc5TJgA==
X-Received: by 2002:a19:911d:0:b0:513:994e:ace0 with SMTP id t29-20020a19911d000000b00513994eace0mr3576225lfd.15.1710139559803;
        Sun, 10 Mar 2024 23:45:59 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c450f00b0041329a43941sm2643812wmo.19.2024.03.10.23.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 23:45:59 -0700 (PDT)
Message-ID: <c1f80459-bf9c-439f-bdba-e08f13aea272@gmail.com>
Date: Mon, 11 Mar 2024 07:46:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Increase soft recovery timeout to .5s
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240307190447.33423-1-joshua@froggi.es>
 <20240307190447.33423-3-joshua@froggi.es>
 <5f70caef-7c7e-4bad-9de9-f8f61bba2584@amd.com>
 <d537a460-6e6e-4bda-895c-c687be00ac29@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <d537a460-6e6e-4bda-895c-c687be00ac29@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.03.24 um 23:31 schrieb Joshua Ashton:
> It definitely takes much longer than 10-20ms in some instances.
>
> Some of these instances can even be shown in Freidrich's hang test 
> suite -- specifically when there are a lot of page faults going on.

Exactly that's the part I want to avoid. The context based recovery is 
to break out of shaders with endless loops.

When there are page faults going on I would rather recommend a hard 
reset of the GPU.

>
> The work (or parts of the work) could also be pending and not in any 
> wave yet, just hanging out in the ring. There may be a better solution 
> to that, but I don't know it.

Yeah, but killing anything of that should never take longer than what 
the original submission supposed to take.

In other words when we assume that we should have at least 20fps then we 
should never go over 50ms. And even at this point we have already waited 
much longer than that for the shader to complete.

If you really want to raise that this high I would rather say to make it 
configurable.

Regards,
Christian.

>
> Raising it to .5s still makes sense to me.
>
> - Joshie 🐸✨
>
> On 3/8/24 08:29, Christian König wrote:
>> Am 07.03.24 um 20:04 schrieb Joshua Ashton:
>>> Results in much more reliable soft recovery on
>>> Steam Deck.
>>
>> Waiting 500ms for a locked up shader is way to long I think. We could 
>> increase the 10ms to something like 20ms, but I really wouldn't go 
>> much over that.
>>
>> This here just kills shaders which are in an endless loop, when that 
>> takes longer than 10-20ms we really have a hardware problem which 
>> needs a full reset to resolve.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>
>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: André Almeida <andrealmeid@igalia.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 57c94901ed0a..be99db0e077e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -448,7 +448,7 @@ bool amdgpu_ring_soft_recovery(struct 
>>> amdgpu_ring *ring, unsigned int vmid,
>>>       spin_unlock_irqrestore(fence->lock, flags);
>>>       atomic_inc(&ring->adev->gpu_reset_counter);
>>> -    deadline = ktime_add_us(ktime_get(), 10000);
>>> +    deadline = ktime_add_ms(ktime_get(), 500);
>>>       while (!dma_fence_is_signaled(fence) &&
>>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>>           ring->funcs->soft_recovery(ring, vmid);
>>
>


