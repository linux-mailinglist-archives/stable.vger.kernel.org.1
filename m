Return-Path: <stable+bounces-58990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151DC92CFDF
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 12:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E8828C31D
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327F18FA26;
	Wed, 10 Jul 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="ejfo1xqF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130113AD07
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608749; cv=none; b=PWNGuMeF+O4lHhJpUfZT2yXjF7GweQC4DS8zq3t/bQQR7sdvdFSOSZhGNtb7fQFfiif7t7dk2aM7pOgjzjRohfgISZ3awye44Bt33NVBOB8pWPdegQd6IU54bp7hFt7aGhp1y1KCgJO8WyyRCMh7WaSoEDrybejz9Qv76Xh1XDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608749; c=relaxed/simple;
	bh=IbKQz1gOjFbT8y0AXg+tGEsziBcaEd5+iUXhzzWaxm4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=negvPLJlioqxBPIjTjuiWJ4RDLcqpYJuvVYHNnbIGJHSDeJbVA+GEbvcue4jpi3j6gRiSxlL/fgWx8Cip3j8hiWRO52Ayx2Ketl4GANLev4LUshuEhK2+pLWAMjuX5e9QRncif9VpTWZBZ3yLXXK463NipXC7viR0I9H288R/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=ejfo1xqF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266edee10cso14939485e9.2
        for <stable@vger.kernel.org>; Wed, 10 Jul 2024 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1720608745; x=1721213545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7OTwFD+y8BLpQUOHFtOxwqpYjiL54IPOC+Fv6GtnwNA=;
        b=ejfo1xqFqIzck0M/TiHJmttLHYRrtu7FZ4DcYyRQGteGUmvuH3HA7n1klGGGizgIV3
         RdMWUU6AZfVE95Q47j9qxMp1d5rz8TYZKKZrbiQ9Cjgg8+YqajxQVey9C5bjQ0MZ3kpl
         pxOfNuDB22GWDv+Z/w0JkFw6Vc980a6Kgbs2Ao8Mf5926hnuKCZa9Z8QlWx4WlCSDsGn
         OtD1ODsC3LIbrOrO9zixtFB+Fb3sl4/aY6520GbFQrooiWn1dFVA/fyaYV0EClvY+z2z
         L/nV58YF4ac0ePfcD6TenVuetdg6YiA5QhC1oSyuLitxI4Hu5M2+arRtrRX+I5x0kzwp
         NXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720608745; x=1721213545;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OTwFD+y8BLpQUOHFtOxwqpYjiL54IPOC+Fv6GtnwNA=;
        b=MS9NbC1eohzBRtifoQamJV1nFZcA/ql8jFxbsdd6PlhR+lrMs1khCmqcCYgFxSRzYu
         gYBl+rftwc8JkTBnJwQhPbRi1EJs7O7BmeTEL5HKU2E6FXyh3J99l4LkMoqp9E4hIxUy
         WtFm65wrcX+cksfLaQ0yvX9nUV/VxO5/eDzr37FifUylhUC6PG5KbIQsj8mjVTRBt42N
         SGqxxABDEPUQd8SVwGod8WzzDUVjwWqwV4oZ7fC1x+gSalKEonE9d4bju86TFkbo37Xl
         0wKeQ0aR6l7ed5KD2xIZBpAoFFO5a1eq9mj0xYsMQ9HYs1qVFPJ+K7E3ER5kOKGH3Tk9
         7CWA==
X-Forwarded-Encrypted: i=1; AJvYcCWC76A+mLgh0tQ7BtVntRP2/kCwXo0hvW+7B+vxFPnM4DNN7mdZZcUxb7D9vryIMECBK5hb3NcctiwJl5L+KbJwijTielPz
X-Gm-Message-State: AOJu0YzsbwzC3FtO5wVGPIlMVdxw9/Ck1pvP1dEzLB/WMCwodpiKkdel
	WxYGLGyV+k3xKkKrVvDcukkMmLMwnVboTUubJcLRRRTEckr4UUzKqhW3tD3Q7h0=
X-Google-Smtp-Source: AGHT+IHLdpVm8qLCHnMBImFFXSR3vZfYQOMKFUuVgSNrJAzj9CMoxZNTowxhQqOFT4crIo5haRW+Bw==
X-Received: by 2002:a05:600c:22cb:b0:426:6220:cb57 with SMTP id 5b1f17b1804b1-426708f1ef6mr35241465e9.25.1720608745401;
        Wed, 10 Jul 2024 03:52:25 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc9desm247799075e9.45.2024.07.10.03.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 03:52:25 -0700 (PDT)
Message-ID: <c0f5c187-38d9-40ce-b5b7-ae466584d24a@ursulin.net>
Date: Wed, 10 Jul 2024 11:52:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gt: Do not consider preemption during
 execlists_dequeue for gen8
From: Tvrtko Ursulin <tursulin@ursulin.net>
To: Nitin Gote <nitin.r.gote@intel.com>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, andi.shyti@intel.com,
 chris.p.wilson@linux.intel.com, nirmoy.das@intel.com,
 janusz.krzysztofik@linux.intel.com, stable@vger.kernel.org
References: <20240709125302.861319-1-nitin.r.gote@intel.com>
 <51d17145-39bd-4ba5-a703-10725a1d3bc1@ursulin.net>
Content-Language: en-GB
In-Reply-To: <51d17145-39bd-4ba5-a703-10725a1d3bc1@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/07/2024 15:02, Tvrtko Ursulin wrote:
> 
> On 09/07/2024 13:53, Nitin Gote wrote:
>> We're seeing a GPU HANG issue on a CHV platform, which was caused by
>> bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries 
>> for gen8").
>>
>> Gen8 platform has only timeslice and doesn't support a preemption 
>> mechanism
>> as engines do not have a preemption timer and doesn't send an irq if the
>> preemption timeout expires. So, add a fix to not consider preemption
>> during dequeuing for gen8 platforms.
>>
>> Also move can_preemt() above need_preempt() function to resolve implicit
>> declaration of function ‘can_preempt' error and make can_preempt()
>> function param as const to resolve error: passing argument 1 of
>> ‘can_preempt’ discards ‘const’ qualifier from the pointer target type.
>>
>> Fixes: bac24f59f454 ("drm/i915/execlists: Enable coarse preemption 
>> boundaries for gen8")
>> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11396
>> Suggested-by: Andi Shyti <andi.shyti@intel.com>
>> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
>> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
>> CC: <stable@vger.kernel.org> # v5.2+
>> ---
>>   .../drm/i915/gt/intel_execlists_submission.c  | 24 ++++++++++++-------
>>   1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c 
>> b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
>> index 21829439e686..30631cc690f2 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
>> @@ -294,11 +294,26 @@ static int virtual_prio(const struct 
>> intel_engine_execlists *el)
>>       return rb ? rb_entry(rb, struct ve_node, rb)->prio : INT_MIN;
>>   }
>> +static bool can_preempt(const struct intel_engine_cs *engine)
>> +{
>> +    if (GRAPHICS_VER(engine->i915) > 8)
>> +        return true;
>> +
>> +    if (IS_CHERRYVIEW(engine->i915) || IS_BROADWELL(engine->i915))
>> +        return false;
>> +
>> +    /* GPGPU on bdw requires extra w/a; not implemented */
>> +    return engine->class != RENDER_CLASS;
> 
> Aren't BDW and CHV the only Gen8 platforms, in which case this function 
> can be simplifies as:
> 
> ...
> {
>      return GRAPHICS_VER(engine->i915) > 8;
> }
> 
> ?
> 
>> +}
>> +
>>   static bool need_preempt(const struct intel_engine_cs *engine,
>>                const struct i915_request *rq)
>>   {
>>       int last_prio;
>> +    if ((GRAPHICS_VER(engine->i915) <= 8) && can_preempt(engine))
> 
> The GRAPHICS_VER check here looks redundant with the one inside 
> can_preempt().

One more thing - I think gen8_emit_bb_start() becomes dead code after 
this and can be removed.

Regards,

Tvrtko

>> +        return false;
>> +
>>       if (!intel_engine_has_semaphores(engine))
>>           return false;
>> @@ -3313,15 +3328,6 @@ static void remove_from_engine(struct 
>> i915_request *rq)
>>       i915_request_notify_execute_cb_imm(rq);
>>   }
>> -static bool can_preempt(struct intel_engine_cs *engine)
>> -{
>> -    if (GRAPHICS_VER(engine->i915) > 8)
>> -        return true;
>> -
>> -    /* GPGPU on bdw requires extra w/a; not implemented */
>> -    return engine->class != RENDER_CLASS;
>> -}
>> -
>>   static void kick_execlists(const struct i915_request *rq, int prio)
>>   {
>>       struct intel_engine_cs *engine = rq->engine;

