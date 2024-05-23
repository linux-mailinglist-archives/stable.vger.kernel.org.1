Return-Path: <stable+bounces-45671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFA28CD1CF
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEB2844A7
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9413C668;
	Thu, 23 May 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="FDjT/0L8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931213BC0A
	for <stable@vger.kernel.org>; Thu, 23 May 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466049; cv=none; b=DwboQpqCA0CzorCAr9SzZc1zp58r1k0Qb0nzFv1FE0WVJAzTFQxH0aD9EKM8ZyLdJ+wCqEtC2rRJ9mOhT387zza60wxozfGvL3Ajz/0pfEyuaneAQa68BOHKye9FtMn4GVL9pf6DUQ/tHFJT3A3YjF0yutGNqh//lYn/YhKvrdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466049; c=relaxed/simple;
	bh=L81zqqoxhRbdQcbke+hNepMI6aO1hosD2JxTCLJQuyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IP+MaZ4FIqavyXmDam7i0hSPIvhT84e6cqqY00kjO8ejGEXcV3z5sOGa+p6T3SSTM9VXS/+V72SNRf5faywh/TNgRJMWCf7pvjyEOTp4wtlSmT7LSYcZ21x87/NiwwMh1ChLW7w474hgAuT+dmz8jdfU123CTADdaQret+LWMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=FDjT/0L8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35502a992c9so127633f8f.3
        for <stable@vger.kernel.org>; Thu, 23 May 2024 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1716466046; x=1717070846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eNHeNryBK8p7xTgnO1zIJAEL4hJ5+B2FVSnyYQrZ9M=;
        b=FDjT/0L8ibfemkrtpv0p8qLOGFStItTTfUwlxRcjvVaVk5Dy83uu/ZTn6+o6xaNKCg
         EuY3jKu3Yl8CukRmGVw6VwyDOd/Od2jgliG6d++F3ExbdqlbK9AH8tZIYY2fO5RHdG+p
         h5unhipiF69QCWa3xledfTWQ3W9+OYYCFl7PAvFVdLdjrCGhZ4OvacfnxJkyiY4CUQge
         YrVElnS8zD9hYiMIoG68KhuTIxeNQt5fOBIUiGJ4V45WGTu9ixMZCrQyFoK2b7Ua1cpu
         FfZCcKwnapt0FVely54dcvHJ7lJObxcTXUmm4nAP+Od+r5zTZW8HBU6npqObPDOkGtS9
         rfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716466046; x=1717070846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eNHeNryBK8p7xTgnO1zIJAEL4hJ5+B2FVSnyYQrZ9M=;
        b=su58Sloa4APHYPG9BoTW5Qk45j5pZY+zeYKYeDhIuxNGIuzRyj8Nt/T0aO+qSkywzL
         KlLdwEKF5WecM5lQeTlvPhNuBEBWtM4cXssC06ie+kPef+81s734drpjddy+uDvKFf74
         +cy/IzWnfZe3Sm+CYxPAG0RZ/z8z4332mWYOU0ylZ8v65xjbDff02AzVRVCGv2tQCjAr
         HOJGwrb7KiEbmsq82QR0MXX9iZcX4fQU3pClXJsygNZCRlrHGLuE7cI5FNz3VWB+YkPJ
         j5mUWgtTWlRLU4P8ilY+isUJqhPWYkn40HCjYs1fqsstTXdfG7fFweqT8Lcire+4Urt4
         Gpkw==
X-Forwarded-Encrypted: i=1; AJvYcCWf14tcmoo0FqMI3NIvacD+cyRQ38p/Yzl42TmuUURY7FIhckxMmVBUVz/UOCBxCMGx0/IIna1fc3JJTD1Kv5RqnsDtnj+E
X-Gm-Message-State: AOJu0YxzFMXKwdEk2KTDNnNwJNUTCrSuXbdMa/YRSHcavEiHQ1aqYZg+
	4hI2fIzjfQyHtEZqeS3abpnGL1E3v/73IG1kEssm+YhnS50+pQx7edITlO+d44Y=
X-Google-Smtp-Source: AGHT+IELmGdsUzvYFgU56NQigjF6vuQEjjnXTJgyqhD5TiZb4O2YPbv5NJxZ2TnZBCgqYfN7OCz/UA==
X-Received: by 2002:a5d:6446:0:b0:34f:c7c8:5a12 with SMTP id ffacd0b85a97d-354d8ce454dmr5009741f8f.40.1716466045651;
        Thu, 23 May 2024 05:07:25 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbff7sm36449649f8f.101.2024.05.23.05.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 05:07:25 -0700 (PDT)
Message-ID: <0f459a5b-4926-40ea-820e-ab0e5516a821@ursulin.net>
Date: Thu, 23 May 2024 13:07:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
Content-Language: en-GB
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Vidya Srinivas <vidya.srinivas@intel.com>,
 intel-gfx@lists.freedesktop.org, shawn.c.lee@intel.com,
 stable@vger.kernel.org
References: <20240520165634.1162470-1-vidya.srinivas@intel.com>
 <20240522152916.1702614-1-vidya.srinivas@intel.com>
 <5e5660ac-e14b-4759-a6f6-38cc55d37246@ursulin.net>
 <Zk8mM0bh5QMGcSGL@intel.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <Zk8mM0bh5QMGcSGL@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 23/05/2024 12:19, Ville Syrjälä wrote:
> On Thu, May 23, 2024 at 09:25:45AM +0100, Tvrtko Ursulin wrote:
>>
>> On 22/05/2024 16:29, Vidya Srinivas wrote:
>>> In some scenarios, the DPT object gets shrunk but
>>> the actual framebuffer did not and thus its still
>>> there on the DPT's vm->bound_list. Then it tries to
>>> rewrite the PTEs via a stale CPU mapping. This causes panic.
>>>
>>> Suggested-by: Ville Syrjala <ville.syrjala@linux.intel.com>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 0dc987b699ce ("drm/i915/display: Add smem fallback allocation for dpt")
>>> Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
>>> ---
>>>    drivers/gpu/drm/i915/gem/i915_gem_object.h | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
>>> index 3560a062d287..e6b485fc54d4 100644
>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
>>> @@ -284,7 +284,8 @@ bool i915_gem_object_has_iomem(const struct drm_i915_gem_object *obj);
>>>    static inline bool
>>>    i915_gem_object_is_shrinkable(const struct drm_i915_gem_object *obj)
>>>    {
>>> -	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE);
>>> +	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE) &&
>>> +		!obj->is_dpt;
>>
>> Is there a reason i915_gem_object_make_unshrinkable() cannot be used to
>> mark the object at a suitable place?
> 
> Do you have a suitable place in mind?
> i915_gem_object_make_unshrinkable() contains some magic
> ingredients so doesn't look like it can be called willy
> nilly.

After it is created in intel_dpt_create?

I don't see that helper couldn't be called. It is called from madvise 
and tiling for instance without any apparent special considerations.

Also, there is no mention of this angle in the commit message so I 
assumed it wasn't considered. If it was, then it should have been 
mentioned why hacky solution was chosen instead...

> Anyways, looks like I forgot to reply that I already pushed this
> with this extra comment added:
> /* TODO: make DPT shrinkable when it has no bound vmas */

... becuase IMO the special case is quite ugly and out of place. :(

I don't remember from the top of my head how DPT magic works but if 
shrinker protection needs to be tied with VMAs there is also 
i915_make_make(un)shrinkable to try.

Regards,

Tvrtko

