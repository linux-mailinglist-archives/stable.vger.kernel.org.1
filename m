Return-Path: <stable+bounces-27196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05160876D23
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 23:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2801F2254A
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09503D68;
	Fri,  8 Mar 2024 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b="BXE7DyKx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8D15AF
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937092; cv=none; b=XiqUC3yyKzZOXiiF4FeRGMZcEpPk8qL+Mf4NuIxCqaxULbqIz8oTfD4PrACpK0DaIQUekGcWUU/nLdtm+fOxmUW984juX/rZXypmEjuFkclDswrlP/FpB3lx9BxtZmhFHzrYLgwMKUjkMeFrNnDZDek+9aMFiSoDHp1b9iFk30o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937092; c=relaxed/simple;
	bh=6b4vHGALfYkBhdfG/cgpOssqy3UNaFC/s05+7oyVnhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFrtMk00fiMCbxSxUuJdW7HRMfBmj00APyIOGsKjmQ66aseZjgrux9hnioA8+cNizVWmxyMrCOXqZANY/Xbzuh1QR/p/tf2ykT8vTxW+DM142gj24MPpU/tZIbraHT01ubO2bhfiZlGMGPbqm3e/eCWle9Ug1IKIVpZlEFHArew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es; spf=pass smtp.mailfrom=froggi.es; dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b=BXE7DyKx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e122c8598so1424597f8f.1
        for <stable@vger.kernel.org>; Fri, 08 Mar 2024 14:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1709937089; x=1710541889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50DxsdwMyzPE9tiAQwRIN4dgJdUxFYiNcUToxZaFv74=;
        b=BXE7DyKxgqIXHY2bifowtmAeRsdCj5M+zeG14MYIw18+kKpOARktC9Jn8XKnjJA09v
         SIjLVCCXI+lmwR8rrG7b1s6xc6WGFZT2mHcGZMNIP4vb1l6Xsm70y0ogjwNdK2OHp3U2
         BUeqR7wgjrbXzfF/boI9Dvb9pVE1tfnMU8noNt0htS6BahjOLgKMSz2P8CYeIUwybqCG
         RYqqIG+MS8K89Cu3oURhgwC4a1hUaGEMBiZNPqmsACJs3EJZg0whIdEvtlZRWYisDXrX
         Lkfd7gwcQ6/ChLntxAyILVc/iJ7KBVWZlLnQ/SDvVrzhCg5Z9JaV5GRGOmviXrmPRnG3
         q7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937089; x=1710541889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50DxsdwMyzPE9tiAQwRIN4dgJdUxFYiNcUToxZaFv74=;
        b=U4hR+tPilAYzmhwCbsNrwoK3wKzgAZLUhyIF3vejN69k6b97Q2kJlPrqcV8D0uv/ch
         aYf4bjznPHeJbVOdMXz42G1Vq/j0ngDw+c4qnqDgBMkqops18GXCa5s0XKmKj925+ycj
         x+kO/FAueNjUWp6d1QWlW57C/wBjLrQOb3zBEX+Lz+6Rv8fa4YUZGJZkZ3MrYsTM6MQF
         XBSQz90tlQQgQKyGIj+X33Elj4qIEMaJ7DCyG6CebfRpoCTQWzfjCJVmWIjqQVRx2UYZ
         ZIm+hSukV/hSmxJx50dmtwcvfxd4tx3DxFA/cLEUBjwXYLFjKDvraGAMbcOJZpbK+JdT
         bhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+iIc0pQE43HBF1Yd/H9Hf9wL6j74rtnPg+xHGw6J+eXwYOCgNLPo49FWIw1he2oFrFTAA/DSmezKTItmOTwI3gZ/W1krD
X-Gm-Message-State: AOJu0YxZiAkXvNyPrdN4KkrlvJnC1P2bac99s8xfoTkJXpqiVh8pWTvv
	bXXa5aAKLGjG6EeHVkWBskZHB7LiW9FPjsTB7U7jrebWbQyG4DZT9/XAcSqAgC4=
X-Google-Smtp-Source: AGHT+IG24Sujfd+INNz2C6N7SQAudMq8/DBjI1n/dwo8d0cQncfBjaIJyhKnrG3z3pDfVDoZ13jR3w==
X-Received: by 2002:adf:eac1:0:b0:33d:701f:d179 with SMTP id o1-20020adfeac1000000b0033d701fd179mr319305wrn.19.1709937088602;
        Fri, 08 Mar 2024 14:31:28 -0800 (PST)
Received: from [192.168.0.89] (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id q18-20020adf9dd2000000b0033e422d0963sm435714wre.41.2024.03.08.14.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 14:31:28 -0800 (PST)
Message-ID: <d537a460-6e6e-4bda-895c-c687be00ac29@froggi.es>
Date: Fri, 8 Mar 2024 22:31:27 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Increase soft recovery timeout to .5s
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240307190447.33423-1-joshua@froggi.es>
 <20240307190447.33423-3-joshua@froggi.es>
 <5f70caef-7c7e-4bad-9de9-f8f61bba2584@amd.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <5f70caef-7c7e-4bad-9de9-f8f61bba2584@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It definitely takes much longer than 10-20ms in some instances.

Some of these instances can even be shown in Freidrich's hang test suite 
-- specifically when there are a lot of page faults going on.

The work (or parts of the work) could also be pending and not in any 
wave yet, just hanging out in the ring. There may be a better solution 
to that, but I don't know it.

Raising it to .5s still makes sense to me.

- Joshie 🐸✨

On 3/8/24 08:29, Christian König wrote:
> Am 07.03.24 um 20:04 schrieb Joshua Ashton:
>> Results in much more reliable soft recovery on
>> Steam Deck.
> 
> Waiting 500ms for a locked up shader is way to long I think. We could 
> increase the 10ms to something like 20ms, but I really wouldn't go much 
> over that.
> 
> This here just kills shaders which are in an endless loop, when that 
> takes longer than 10-20ms we really have a hardware problem which needs 
> a full reset to resolve.
> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>
>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: André Almeida <andrealmeid@igalia.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 57c94901ed0a..be99db0e077e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -448,7 +448,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring 
>> *ring, unsigned int vmid,
>>       spin_unlock_irqrestore(fence->lock, flags);
>>       atomic_inc(&ring->adev->gpu_reset_counter);
>> -    deadline = ktime_add_us(ktime_get(), 10000);
>> +    deadline = ktime_add_ms(ktime_get(), 500);
>>       while (!dma_fence_is_signaled(fence) &&
>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>           ring->funcs->soft_recovery(ring, vmid);
> 


