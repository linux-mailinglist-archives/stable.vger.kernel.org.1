Return-Path: <stable+bounces-59092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4637C92E416
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575D4B21859
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA0158A3D;
	Thu, 11 Jul 2024 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="J37gNT+g"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5EC157E93
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692177; cv=none; b=geE5zjjH3w9mba7HoLeO8VH0yCukl1dIxyhGRwSnztZrPxRVwFWr0saC5rJ+SY0yWOze9tDPdVDwqDu+gjOVDmWi3oPBrCSlUNlrtcr8uUdBN1hii0wrKx9Uko4DSSnI/VvvjzmhYZ2Kj9p4BKWtUbEzrGaIR9aHkjZ5CR2AFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692177; c=relaxed/simple;
	bh=6iMIKUwfaoFpnyORoBBxjZOn8Pe3XbHMRh9GzyD1Qn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hR644YcNlWTpvaIe3c39yNt0ShOTkK00rNEigHLbZlokD3TqPmbEa7/hWxBLnB3YjVlApw7rUgiyaTjYhZ61YwlD2TRN5yb+RwL6a212ht2vgPbfjQ+XNbLIVzs2WzFZGkATno6sFpASMw4COGA5Nb6uTcEPkcouJWTMKrRhLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=J37gNT+g; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-426636ef8c9so4329435e9.2
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1720692173; x=1721296973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boL5i9jzaSfhn+e79C+qpFuft543zvabd4ejo3BmRUY=;
        b=J37gNT+ghgefCOGEvaxy8MP7va4f4wwpY3PDBH1M1gGFG2a7E9zM9ZGpbCU4bqodBa
         JvcEELsjpk2QNZy/1KG+voFLpZjzerpYHvhWy7tSZioptvRN4ASQfwauRySbg5TOLmwU
         SN5bS9z3N+8A8A0DAxMrZM7CynRb6ZRAA65KPWDL7oAipoaG3oBTzoVOnErPSE+Q2fwD
         1fl4QCHoUGsrWbIVpkrp6sitxcef/qQJEC1OS7ySY7051fy0CfEZGZFOnLRJGowUwha6
         mTPEnSuGBIK5DvcF9F6dyeDXgHSVPn/A9DRxt6juiloRMPqdg4RKN/qppVTzPrL3BxUI
         /TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720692173; x=1721296973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boL5i9jzaSfhn+e79C+qpFuft543zvabd4ejo3BmRUY=;
        b=NpzWaxWObciLF6hAYxOI6nHAfdzllQ52FVh26fMcEnyhzfN3SEXGczgF0utCPGKgU8
         psp3BJmUtc0MQlFTWnFG8D3aEs/r7uxrUQSI/lIwsNCUxN+hQnQUx7k96wqKEMr7+PD3
         uK5ZEmCZXHV3dflvowwyE+PodewYq/X2w0sfQRtEpbK0Nz0AbZthsm0FvSzZcdXHhH8H
         VpWWUcypF16d1RZw8wdXnog1uTJ3LKkGO3rsavMEi4/2v6zi/Mo1HZRnE7TuBoeYg0AO
         GVS8VzBGPKeLKSq7Jh2efdSKJj9wmilZN0QLbiOa0tEUM1ojrzmxKr1UOZWHVwj+hPCb
         IEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZYHWpieTqrjAVPjHMNDCnwOwckYuapYK0ra+CU2NqtK+bt+IOfr+BE6FbSeF/fzKNbLi8JCpS5kdHd91Gjh6+UwJ94Xzf
X-Gm-Message-State: AOJu0YwoDyZ0E8rQjazy7VUQRY/K2/LeUi2EsT/fZngaivZlQOZX0Xh4
	YSGHGQW1S6021TNPyhVc+iZ5AB2nMlhoCyN6Rxps+GOw8UPOv5ktFud7IlqLEiY=
X-Google-Smtp-Source: AGHT+IG5OcW90S+EQ49B/6sG+OFx8XqDMkqaKPG9VOzfnAyynEgdVQ3iZF/lUSXhhCqiXx6+cRr6Mg==
X-Received: by 2002:a5d:47a9:0:b0:367:8f84:ee1d with SMTP id ffacd0b85a97d-367cea4622cmr7264113f8f.8.1720692173512;
        Thu, 11 Jul 2024 03:02:53 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0650sm7360031f8f.69.2024.07.11.03.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 03:02:53 -0700 (PDT)
Message-ID: <89dd0130-562a-4025-968d-d758a26399ec@ursulin.net>
Date: Thu, 11 Jul 2024 11:02:52 +0100
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
References: <20240711051215.1143127-1-nitin.r.gote@intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240711051215.1143127-1-nitin.r.gote@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/07/2024 06:12, Nitin Gote wrote:
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
> v2: Simplify can_preemt() function (Tvrtko Ursulin)

Yeah sorry for that yesterday when I thought gen8 emit bb was dead code, 
somehow I thought there was a gen9 emit_bb flavour. Looks like I 
confused it with something else.

> 
> Fixes: bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for gen8")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11396
> Suggested-by: Andi Shyti <andi.shyti@intel.com>
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> CC: <stable@vger.kernel.org> # v5.2+
> ---
>   .../drm/i915/gt/intel_execlists_submission.c    | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> index 21829439e686..59885d7721e4 100644
> --- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> +++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> @@ -294,11 +294,19 @@ static int virtual_prio(const struct intel_engine_execlists *el)
>   	return rb ? rb_entry(rb, struct ve_node, rb)->prio : INT_MIN;
>   }
>   
> +static bool can_preempt(const struct intel_engine_cs *engine)
> +{
> +	return GRAPHICS_VER(engine->i915) > 8;
> +}
> +
>   static bool need_preempt(const struct intel_engine_cs *engine,
>   			 const struct i915_request *rq)
>   {
>   	int last_prio;
>   
> +	if (!can_preempt(engine))
> +		return false;
> +
>   	if (!intel_engine_has_semaphores(engine))

Patch looks clean now. Hmmm one new observation is whether the "has 
semaphores" check is now redundant? Looks preemption depends on 
semaphore support in logical_ring_default_vfuncs().

Regards,

Tvrtko

>   		return false;
>   
> @@ -3313,15 +3321,6 @@ static void remove_from_engine(struct i915_request *rq)
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

