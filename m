Return-Path: <stable+bounces-58757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF0492BC6C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3721C20A4A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E3017C203;
	Tue,  9 Jul 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="Wgqq+CvL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD3519B581
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533775; cv=none; b=i7oP2ZRJZ73N+fpHB+eKh89/1qnUhoDq+Z5CYnJ3bX/2nf/fzzA0pcTs1MNrpFSKRJpOBB9zRXgkuFnjAlwcI1ILK+6cmeWEtSrAQ0LC51u1Xj1fhe1LeknqBgRctbAEB4UQ0cEdta4LRaZcG/ZT5MOM3wtyVEnLEdr7r9biG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533775; c=relaxed/simple;
	bh=lYk3ekzkam8PnWHJocgZDp+w8y7ZITlPKgxfDCSmsLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/NO6UDlFwUla//FhAAZf6EeUhvEMt2UrG0z0H0Nn0J+Yt4aUZ4b94E/A+rRDdsVsMwmglzX1MORGKmRbnlMwyqMSL6nqX4SpfIdkBPyTu6pLq/uDiuFypBfO2yYPuIYQNpMPn588V9J9F7tNr2yUsCNsaE6uxeR0+yAG/fNJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=Wgqq+CvL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367ac08f80fso2274223f8f.1
        for <stable@vger.kernel.org>; Tue, 09 Jul 2024 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1720533772; x=1721138572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uu9OJhTofwP0VwGCWg6NqwdVMvMXhiTMagbsBjbyLLo=;
        b=Wgqq+CvLTn0SN8TfSWBlrEjbDd6VO+pqVya/JgcGnq4vPTABmVREpVmIqV+rF5HqFk
         +ddZqPQ1XmXa0lG88YGa7ii+KUpaN13NMzyjNCSoGtWYL+5yYw0hxNO/6ehYlY3ZD1ox
         4a/vn/m3kkvTGYuch8Ekju9DBTYkYD9G/DKNUvtZckurIBpBWmNzbMXZsPDVAe/LYtgW
         Lby0YRsz4RuOnunMP6CmVZYjDvC1NJUYxjncrOnncu/A2D9oFOe5+eWLVTK9g428u6CA
         VvVvSsEdVGD3J4Sys23ub7/28GgaZlSZM3X0wf6JAnQXJlfdKfny8zBwsG+IDLJeRxpw
         Fe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533772; x=1721138572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uu9OJhTofwP0VwGCWg6NqwdVMvMXhiTMagbsBjbyLLo=;
        b=MHV8Jn5SuPO1jdzqIUh6QsQSl+QJZYq7BF3QXZL0YJjx9ZZUHfRxaEWj+Mdhw9bAXn
         FxrJCxDf2PsPuTCCMHctQcxMXQJVKHt/NdmXPGQV7eIK13/aOHKQVU/WYDGusVDjoAf7
         9XcNbZbNArlbofuny7hPKKw+J8jhcawKCpRczKO64S0epVufJ+eo3V3Mb2pfhwYufgSl
         rDt9C5kLXiHrNf5SBx8wro9s/Hksvi0qflU16/ySQwc+b7B55JCa3Yu9NQnaeH+y6SBu
         I3vQfqhanyL9GDFITBCOiyyKfpAmzbB6Dj3241UdVTIHH1/sunnlm88YEAKupUoLskTC
         SnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUCxn7YPnLUOG81N6X/F2VAn74gj7vDnv81zZ4B6fJCacRXt4v6o7cMV7AXNRj0JwNjs5SDjdV7hnI/LbtAqzGY6mPQ3JH
X-Gm-Message-State: AOJu0YwGMWm+vVtEmNzrDqM66/vKoVeX3QKB6WlXWQK3FXUAM+slqDEf
	RjWqPBF0CT+281KYfkKgOq+FMJHPxr6OvNrtIemkNV3N01e4Pr/r0rJQN5DWjmI=
X-Google-Smtp-Source: AGHT+IFtT5ee2t3crvq4ZNBz+KhMcZm7i0t9xadFlUz5eVRkiHO6Bw0KLJ9RPYcYHiCfNac1dtmlnQ==
X-Received: by 2002:adf:a3d9:0:b0:367:958e:9832 with SMTP id ffacd0b85a97d-367cea46060mr1876324f8f.14.1720533772204;
        Tue, 09 Jul 2024 07:02:52 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fca8bsm209640155e9.47.2024.07.09.07.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 07:02:51 -0700 (PDT)
Message-ID: <51d17145-39bd-4ba5-a703-10725a1d3bc1@ursulin.net>
Date: Tue, 9 Jul 2024 15:02:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gt: Do not consider preemption during
 execlists_dequeue for gen8
To: Nitin Gote <nitin.r.gote@intel.com>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, andi.shyti@intel.com,
 chris.p.wilson@linux.intel.com, nirmoy.das@intel.com,
 janusz.krzysztofik@linux.intel.com, stable@vger.kernel.org
References: <20240709125302.861319-1-nitin.r.gote@intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240709125302.861319-1-nitin.r.gote@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/07/2024 13:53, Nitin Gote wrote:
> We're seeing a GPU HANG issue on a CHV platform, which was caused by
> bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for gen8").
> 
> Gen8 platform has only timeslice and doesn't support a preemption mechanism
> as engines do not have a preemption timer and doesn't send an irq if the
> preemption timeout expires. So, add a fix to not consider preemption
> during dequeuing for gen8 platforms.
> 
> Also move can_preemt() above need_preempt() function to resolve implicit
> declaration of function ‘can_preempt' error and make can_preempt()
> function param as const to resolve error: passing argument 1 of
> ‘can_preempt’ discards ‘const’ qualifier from the pointer target type.
> 
> Fixes: bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for gen8")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11396
> Suggested-by: Andi Shyti <andi.shyti@intel.com>
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> CC: <stable@vger.kernel.org> # v5.2+
> ---
>   .../drm/i915/gt/intel_execlists_submission.c  | 24 ++++++++++++-------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> index 21829439e686..30631cc690f2 100644
> --- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> +++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> @@ -294,11 +294,26 @@ static int virtual_prio(const struct intel_engine_execlists *el)
>   	return rb ? rb_entry(rb, struct ve_node, rb)->prio : INT_MIN;
>   }
>   
> +static bool can_preempt(const struct intel_engine_cs *engine)
> +{
> +	if (GRAPHICS_VER(engine->i915) > 8)
> +		return true;
> +
> +	if (IS_CHERRYVIEW(engine->i915) || IS_BROADWELL(engine->i915))
> +		return false;
> +
> +	/* GPGPU on bdw requires extra w/a; not implemented */
> +	return engine->class != RENDER_CLASS;

Aren't BDW and CHV the only Gen8 platforms, in which case this function 
can be simplifies as:

...
{
	return GRAPHICS_VER(engine->i915) > 8;
}

?

> +}
> +
>   static bool need_preempt(const struct intel_engine_cs *engine,
>   			 const struct i915_request *rq)
>   {
>   	int last_prio;
>   
> +	if ((GRAPHICS_VER(engine->i915) <= 8) && can_preempt(engine))

The GRAPHICS_VER check here looks redundant with the one inside 
can_preempt().

Regards,

Tvrtko

> +		return false;
> +
>   	if (!intel_engine_has_semaphores(engine))
>   		return false;
>   
> @@ -3313,15 +3328,6 @@ static void remove_from_engine(struct i915_request *rq)
>   	i915_request_notify_execute_cb_imm(rq);
>   }
>   
> -static bool can_preempt(struct intel_engine_cs *engine)
> -{
> -	if (GRAPHICS_VER(engine->i915) > 8)
> -		return true;
> -
> -	/* GPGPU on bdw requires extra w/a; not implemented */
> -	return engine->class != RENDER_CLASS;
> -}
> -
>   static void kick_execlists(const struct i915_request *rq, int prio)
>   {
>   	struct intel_engine_cs *engine = rq->engine;

