Return-Path: <stable+bounces-45696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1198CD36D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D840B21B66
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70114A4F1;
	Thu, 23 May 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="DrKS/ow0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26913D2BD
	for <stable@vger.kernel.org>; Thu, 23 May 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470101; cv=none; b=OwixjgijPAX4MqHYdAUV4EwQ7SRlViGkCENFhESe+Q946RJv6Ha0nQKj2zszMJxRdIRL2sGY3P/+OoaVl0LVRWduoP/vIZ42vS34eOn+7cssCa5mx9wn9qRfI4TBQQar8MgyMz3wXsS/HLR0uYYmY0ySwvN7RRahYFMgC79GEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470101; c=relaxed/simple;
	bh=YNahbxZKNjJaKRpmIbUfz/5DPG5k7qPMgt82jZRq5AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph6HGejEBIoQJ46Wnw4BT9ogVWBqrw3gdUw/dC4j/qO6ALilT3J1vq7B4Jaa9olV7KtwpsKfqOgZUlZ+udxUHaKx6yBt4b2imCgBTThWfngWx5t+/Rxb46nsxZP4Jtdmv7fM1FHbXtNQptkU0ul+mm7bhws5PvWsoATsnyq36A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=DrKS/ow0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-420180b59b7so18450395e9.0
        for <stable@vger.kernel.org>; Thu, 23 May 2024 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1716470097; x=1717074897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElmXxnz32RpQCAO/NAAwTiLr8wz0mgoU3tNFVcIdneo=;
        b=DrKS/ow061pelP93t95nhrVB7XH5VKu1hnCVMHJmSZlf5P4IS/2txW9BCfa+7dL9G+
         hSACHcA4MtwLAhjO052eVAKkNcluZxdYfrQyV5Rr3lIoXeynEAwtG3Q8ArI78KMQmqQZ
         lL5J6SSjsVTK75HR1+z1Y3nSFeXMfbqirZnw7wnz6sInZXwmzLMnLQhq2pDbOKLoxKz6
         Jks19CYg+hjYdIfhvPgdMIeLO5pnH0A7FsCKdkZTi3HXEprrlwGHvLUGJIs/U61F2DT+
         9uS3ThA3hfHQ/r8DbN0lbwgpcqyKd4tgFB2+F1hzXEwa4vgn99xJjomgd1B4OKpmYyeF
         994Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716470097; x=1717074897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElmXxnz32RpQCAO/NAAwTiLr8wz0mgoU3tNFVcIdneo=;
        b=l3Co9UOabCpCB61ipvS/8A1KJaIDkHHh7f2xrllgSU5R6/JnQFV3OJAjjkRwYBNER1
         V6JiTHq9TwqJRhN4rkyoPKmGhKgR8jKyRQ+WKS/eBDskMRDOAi3VEWZ3nG5xo9iLgALq
         1h5zZs3TsEX0PowfmuKdHrUK4fw3XAZWcT88wg1gEzahbl7de3uBkyzbwG0lEn6ZFpMe
         +cF8+x+al7Pd+7xht9+aycQ+wxTgcvZ76nsiKHywyIgPtVijCK/SOohbXWaZRSnS53UL
         rfg4404tZNyhU6aBTDzFvj5GuuvGj3i5IsK5V7hUTG2CE+WbSOGjktKvdtj/N02JAPaa
         rOTg==
X-Forwarded-Encrypted: i=1; AJvYcCVuSXBs04JMZxmnT6fT9PJPARIqj5zpmZ+ILDibvSm4784QJIXtllZTIJCQnSKCJllef9cWsUXkWz7WJezNYX6WA5aOwXbO
X-Gm-Message-State: AOJu0YxVGBQ4gKN8YJv0xYoWLSo5lsbkhYdXd9Vlf/EgxY7Vpd8D4dH6
	Dn7V4Gjcco/YW5TOJ7iP7eFmOg3k5T66oPUbPLcdNJnP03t7q4/ysWD9d1grDb0=
X-Google-Smtp-Source: AGHT+IGMZ8pk3znmuF66zoIYGQdLwGoVs7oLIhbyi+fIHlZWEzfthamohI7z5rgTKtbguNe8v+EKTQ==
X-Received: by 2002:a05:600c:295:b0:41f:e10f:889a with SMTP id 5b1f17b1804b1-420fd2f1504mr36811355e9.7.1716470097510;
        Thu, 23 May 2024 06:14:57 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f5d189sm25591595e9.24.2024.05.23.06.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 06:14:57 -0700 (PDT)
Message-ID: <44eefd9c-4086-45a9-b555-d5d201d27a57@ursulin.net>
Date: Thu, 23 May 2024 14:14:56 +0100
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
 <0f459a5b-4926-40ea-820e-ab0e5516a821@ursulin.net>
 <Zk81eDBUlz_axOn4@intel.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <Zk81eDBUlz_axOn4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 23/05/2024 13:24, Ville Syrjälä wrote:
> On Thu, May 23, 2024 at 01:07:24PM +0100, Tvrtko Ursulin wrote:
>>
>> On 23/05/2024 12:19, Ville Syrjälä wrote:
>>> On Thu, May 23, 2024 at 09:25:45AM +0100, Tvrtko Ursulin wrote:
>>>>
>>>> On 22/05/2024 16:29, Vidya Srinivas wrote:
>>>>> In some scenarios, the DPT object gets shrunk but
>>>>> the actual framebuffer did not and thus its still
>>>>> there on the DPT's vm->bound_list. Then it tries to
>>>>> rewrite the PTEs via a stale CPU mapping. This causes panic.
>>>>>
>>>>> Suggested-by: Ville Syrjala <ville.syrjala@linux.intel.com>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 0dc987b699ce ("drm/i915/display: Add smem fallback allocation for dpt")
>>>>> Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
>>>>> ---
>>>>>     drivers/gpu/drm/i915/gem/i915_gem_object.h | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
>>>>> index 3560a062d287..e6b485fc54d4 100644
>>>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
>>>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
>>>>> @@ -284,7 +284,8 @@ bool i915_gem_object_has_iomem(const struct drm_i915_gem_object *obj);
>>>>>     static inline bool
>>>>>     i915_gem_object_is_shrinkable(const struct drm_i915_gem_object *obj)
>>>>>     {
>>>>> -	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE);
>>>>> +	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE) &&
>>>>> +		!obj->is_dpt;
>>>>
>>>> Is there a reason i915_gem_object_make_unshrinkable() cannot be used to
>>>> mark the object at a suitable place?
>>>
>>> Do you have a suitable place in mind?
>>> i915_gem_object_make_unshrinkable() contains some magic
>>> ingredients so doesn't look like it can be called willy
>>> nilly.
>>
>> After it is created in intel_dpt_create?
>>
>> I don't see that helper couldn't be called. It is called from madvise
>> and tiling for instance without any apparent special considerations.
> 
> Did you actually read through i915_gem_object_make_unshrinkable()?

Briefly, and also looked around how it is used. I don't immediately 
understand which part concerns you and it is also quite possible I am 
missing something.

But see for example how it is used in intel_context.c+intel_lrc.c to 
protect the context state object from the shrinker while it is in use by 
the GPU. It does not appear any black magic is required.

Question also is does that kind of lifetime aligns with the DPT use case.

>> Also, there is no mention of this angle in the commit message so I
>> assumed it wasn't considered. If it was, then it should have been
>> mentioned why hacky solution was chosen instead...
> 
> I suppose.
> 
>>
>>> Anyways, looks like I forgot to reply that I already pushed this
>>> with this extra comment added:
>>> /* TODO: make DPT shrinkable when it has no bound vmas */
>>
>> ... becuase IMO the special case is quite ugly and out of place. :(
> 
> Yeah, not the nicest. But there's already a is_dpt check in the
> i915_gem_object_is_framebuffer() right next door, so it's not
> *that* out of place.

I also see who added that one! ;)

> Another option maybe could be to manually clear
> I915_GEM_OBJECT_IS_SHRINKABLE but I don't think that is
> supposed to be mutable, so might also have other issues.
> So a more proper solution with that approach would perhaps
> need some kind of gem_create_shmem_unshrinkable() function.
> 
>>
>> I don't remember from the top of my head how DPT magic works but if
>> shrinker protection needs to be tied with VMAs there is also
>> i915_make_make(un)shrinkable to try.
> 
> I presume you mistyped something there.

Oops - i915_vma_make_(un)shrinkable.

Anyway, I think it is worth giving it a try if the DPT lifetimes makes 
it possible.

Regards,

Tvrtko

