Return-Path: <stable+bounces-76702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E991A97BF9B
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 19:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7196E1F22620
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF81C8FB9;
	Wed, 18 Sep 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jELCJFXB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2513C3C
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680370; cv=none; b=n8sYu1nheHeVhySbzCNKxFPOkXwAIZRj2F03GjnedceWWaUS0ruB91z8z/t8A7VqPJdx4QR+ge5YswcATz+oEAhUmnTEFWd8GvzhYXBlgKljaV7YeCw/gqV/WJbONsDc3jxFntfcT0WdKlVwIX7vtxkqECY/jQaa1z9LHttLSaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680370; c=relaxed/simple;
	bh=oAzU6jacWPSFfbD7N2+YNUm86tr4pswV9w5y/WuPw04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UZoQbb0NDnTVWHAR07omEk1Nxe1GEH9bT2J9fSF2Ut+Ec6v8taoerFProrOhWdaI8owX3/21PCamIsVhVeLeXQ2Uj7UTT9InTrkbsFyo4iif5O9kTlIjgVSYMCrZzesFEw5et34JeSZbu9U0xnLa2XiFfNYHhynMD3WI/Akv67E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jELCJFXB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726680368; x=1758216368;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=oAzU6jacWPSFfbD7N2+YNUm86tr4pswV9w5y/WuPw04=;
  b=jELCJFXB+HJq2ua+tX6pultv86dfm/yajLHdn5p2z1tnenV/+O+9EQGy
   PFR1dONivsgD6KsG3u9uHTr0k+5LE3Lk8mc3N2p0tWHlfirCd/qsSxtD3
   2XOgQMIUDsRWLFvaTNteaQpYYdoDpCNphLQDx71MaSu0OPVxfxqQkKXzT
   PD1Mn91mwdXNdNtNxyhj3EAy5D/GRDoxocuKzQD1qGIsV7gEMU7g08iv/
   dOffFiFb8zaaDa/xcM5Q1LGtvTWvfF2y74T4QAS7Nme7KHCxMin+vaasE
   sKZ6JGArc3uSCsnU6DaDKUeAOLvYy+UM52DyQ57jUzvxVswQxuv8/iBn3
   w==;
X-CSE-ConnectionGUID: rkopnQkfRYa3IiFL+x7SOw==
X-CSE-MsgGUID: oUjcADe6RoSA5Y5WoKC0tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25730821"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="25730821"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 10:26:07 -0700
X-CSE-ConnectionGUID: 7nytcQ0mRrG/sdJj2C9WIQ==
X-CSE-MsgGUID: pBAnT4nZQ9mzoEO9Bww4iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="74444114"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 10:26:04 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Matthew
 Auld <matthew.auld@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Anshuman Gupta <anshuman.gupta@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915/gem: fix bitwise and logical AND mixup
In-Reply-To: <20240918150542.GA4049109@thelio-3990X>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1726658138.git.jani.nikula@intel.com>
 <dec5992d78db5bc556600c64ce72aa9b19c96c77.1726658138.git.jani.nikula@intel.com>
 <20240918150542.GA4049109@thelio-3990X>
Date: Wed, 18 Sep 2024 20:26:00 +0300
Message-ID: <87v7ysan6f.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 18 Sep 2024, Nathan Chancellor <nathan@kernel.org> wrote:
> On Wed, Sep 18, 2024 at 02:17:44PM +0300, Jani Nikula wrote:
>> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND is an int, defaulting to 250. When
>> the wakeref is non-zero, it's either -1 or a dynamically allocated
>> pointer, depending on CONFIG_DRM_I915_DEBUG_RUNTIME_PM. It's likely that
>> the code works by coincidence with the bitwise AND, but with
>> CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y, there's the off chance that the
>> condition evaluates to false, and intel_wakeref_auto() doesn't get
>> called. Switch to the intended logical AND.
>> 
>> Fixes: ad74457a6b5a ("drm/i915/dgfx: Release mmap on rpm suspend")
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
>> Cc: Andi Shyti <andi.shyti@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # v6.1+
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> index 5c72462d1f57..c157ade48c39 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
>> @@ -1131,7 +1131,7 @@ static vm_fault_t vm_fault_ttm(struct vm_fault *vmf)
>>  		GEM_WARN_ON(!i915_ttm_cpu_maps_iomem(bo->resource));
>>  	}
>>  
>> -	if (wakeref & CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
>> +	if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
>
> This is going to result in a clang warning:
>
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c:1134:14: error: use of logical '&&' with constant operand [-Werror,-Wconstant-logical-operand]
>    1134 |         if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
>         |                     ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c:1134:14: note: use '&' for a bitwise operation
>    1134 |         if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
>         |                     ^~
>         |                     &
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c:1134:14: note: remove constant to silence this warning
>    1134 |         if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
>         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
>
> Consider adding the explicit '!= 0' to make it clear this should be a
> boolean expression.

Thanks, will be fixed in v2.

BR,
Jani.


>
> Cheers,
> Nathan
>
>>  		intel_wakeref_auto(&to_i915(obj->base.dev)->runtime_pm.userfault_wakeref,
>>  				   msecs_to_jiffies_timeout(CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND));
>>  
>> -- 
>> 2.39.2
>> 

-- 
Jani Nikula, Intel

