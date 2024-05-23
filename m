Return-Path: <stable+bounces-45639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A08CCE2B
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 10:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A5F1F21DEA
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 08:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD30913CABE;
	Thu, 23 May 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="f0mymda3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF351016
	for <stable@vger.kernel.org>; Thu, 23 May 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452750; cv=none; b=uLRVJ8bLeYc05rMoF9NhY9QP2AK303fPGpg66gZkpvmzwzR7mnUODyOaLG4IlYj0I7/5T3r1LXzWz8NWeRWpSsqQB1zjvaXAn5j9upFf4Zp1fVGMTaoV0NjGi8OWEysPYnRr4ZhD1h6YIKCSDQ/lyDy23yAw++2mAaHRsgI9wf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452750; c=relaxed/simple;
	bh=fdq7SJk9W8lhdYNGRDaqT5uRNpH/TcfUiwvQRulOh8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bm/Qt172RCit5haVpIUJXUUB3/I4Z5Jw/o886ZmNSXfAg1Hyx3pENj2x4rL9k0ovX8wgw2HnpEivLVe0hUaL9Xnmv1YalMQLKW1HiIrPe++rOA68Ru97Xzuyv7QpfkoEq9muB+qBhSRtuF4kvLJWYhAhfHJm4VLuVgLOWsFHzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=f0mymda3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354fb2d9026so292630f8f.1
        for <stable@vger.kernel.org>; Thu, 23 May 2024 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1716452747; x=1717057547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWlpsrgTdFMlKdZeJj09DQy7ogfZ63oLDX7W+N9MC7U=;
        b=f0mymda3BT9OCovougyxJEQHPTnZ+ZOld+vQCTcHkHHav93fe+XqQTO7LhWIRoMJBQ
         sqCBqEewhIkZFktNsfq+3sOLMU0iik3co3f9Ul9IUmlAHMlssA4WKkCpyq6ugCnWSK/D
         GzlPXesEIAmuNGU7c7Hg9BQBhC0Ohy0+UYYeEL+OBJX/T8GsCsXgjNn9K+lEM12ixwlr
         Pdn+AZTpZ7GJfAl+bvgd6+FFgkqCZr/bHyFd0DaRRa4sEDNAEwyZZeNK+DFEmVYDEe65
         UPllEq93yQjQhiD33W9wAV04A7PoCXcLZ8as5OvhFvwypTAUcz8ggqBmUBUV7d6VSlUQ
         F6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716452747; x=1717057547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWlpsrgTdFMlKdZeJj09DQy7ogfZ63oLDX7W+N9MC7U=;
        b=DyH/2suEpQW0KvWAEmngiGyRmGrvxzMVvLVAFSs/svxwzPWd1PlW3kD7ePqJD201UB
         CoQhopesI/I7LloQkYnBGn5mpMSSiTWAVDU/UfTKHcLud4WgzvdR+621m/yb9b3mvBZk
         tOwGBGfDuBjL6PPY3kJC5jkFYRfeTlrdAOuSCNV4HdWMx5+oTQmKM+CAzUXKbgBDDUrq
         p2GL5uZKsiB7pjUov4WESIztVhaHkrGxq/2dSx/4OIUEUFVSkHQvQakk36m5Lst6rUog
         SFOdqXkSZIEzvB+Yz0UguDTzVIUTVu/eCx1gO6UXC8CspIqxvJd6OxUoAwCr8vsLKd0B
         G8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnxbpe8TixLKxcU8J7u/a5oBSmneMJLaCIm58IeKg5SHwp4/FA0vyy4prbsuLlV7xayHvWyBpjm6ZRYp9d7EgFxSiM7Rpw
X-Gm-Message-State: AOJu0YxVl4jsmZM63LK4Rt2rTCmk6zgCaBDfXp1kmlRbvz0/1SLjKrEJ
	Zr7VJqwSixflWhbSL/aNvVQk69MrPBNqBxXZVMGb92sblz+5ec6sCn/DCGiN/Sg=
X-Google-Smtp-Source: AGHT+IHLjYW8dANbGfdTBG8MKS5bT5zzCt6MMnjUCO5bG7X7RdBxmhG7mM8qviAApDqwzNJ3eLr4OQ==
X-Received: by 2002:a05:6000:178e:b0:355:189:dd1a with SMTP id ffacd0b85a97d-3550189e239mr235651f8f.64.1716452746875;
        Thu, 23 May 2024 01:25:46 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354f29f69a1sm2311426f8f.0.2024.05.23.01.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 01:25:46 -0700 (PDT)
Message-ID: <5e5660ac-e14b-4759-a6f6-38cc55d37246@ursulin.net>
Date: Thu, 23 May 2024 09:25:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
Content-Language: en-GB
To: Vidya Srinivas <vidya.srinivas@intel.com>, intel-gfx@lists.freedesktop.org
Cc: shawn.c.lee@intel.com, Ville Syrjala <ville.syrjala@linux.intel.com>,
 stable@vger.kernel.org
References: <20240520165634.1162470-1-vidya.srinivas@intel.com>
 <20240522152916.1702614-1-vidya.srinivas@intel.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240522152916.1702614-1-vidya.srinivas@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 22/05/2024 16:29, Vidya Srinivas wrote:
> In some scenarios, the DPT object gets shrunk but
> the actual framebuffer did not and thus its still
> there on the DPT's vm->bound_list. Then it tries to
> rewrite the PTEs via a stale CPU mapping. This causes panic.
> 
> Suggested-by: Ville Syrjala <ville.syrjala@linux.intel.com>
> Cc: stable@vger.kernel.org
> Fixes: 0dc987b699ce ("drm/i915/display: Add smem fallback allocation for dpt")
> Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_object.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> index 3560a062d287..e6b485fc54d4 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> @@ -284,7 +284,8 @@ bool i915_gem_object_has_iomem(const struct drm_i915_gem_object *obj);
>   static inline bool
>   i915_gem_object_is_shrinkable(const struct drm_i915_gem_object *obj)
>   {
> -	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE);
> +	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE) &&
> +		!obj->is_dpt;

Is there a reason i915_gem_object_make_unshrinkable() cannot be used to 
mark the object at a suitable place?

Regards,

Tvrtko

>   }
>   
>   static inline bool

