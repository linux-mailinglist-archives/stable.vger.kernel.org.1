Return-Path: <stable+bounces-76698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D597BE60
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 17:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFBB1C20D13
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F761C7B67;
	Wed, 18 Sep 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi1GILGD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD61C8FBA
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671945; cv=none; b=babp0emjn0IeUQague+TAC+oiRUo6cC4ZnNjrw1mmK/gt4y3QGKgWLzTXrnqho2UmFoNMFndfAzadJdvcG06Do7rrQLsRdaQnli1Din4o4x615KHsx8pyHYrqBfwygP8LSuuTjIY5SRqrehQK6bEg5OYOzAASz2oWv1nfSoyv/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671945; c=relaxed/simple;
	bh=NEbsoDGarkF9DcJ1oPB0XKgElHrM+/7uFjvxWCETW0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EI9afZxap3yWG3P5Q/vRgHvdCRjBcv2Duj4+PCQ96mfQgwdgONWseoygzrKUqo+da1RrhXEk5dAycTtVTdJ+09X5mvBV3EZdMa14XGEoJc3Aj+bX/Gi6Qnd4sAIX4qSSDJ5YTGdkmnrogrerVmDVDTsxOHkpev+vB5txMOyWsNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi1GILGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C37C4CEC2;
	Wed, 18 Sep 2024 15:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726671944;
	bh=NEbsoDGarkF9DcJ1oPB0XKgElHrM+/7uFjvxWCETW0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fi1GILGDGqdRw5CBleFgjz4TidR4S1TdejI62SRowk6vuJvj9pjXHpSAGdlPfuI1M
	 c3oeEEdj1SqjpjawyCLABhDqu1sCnDS+03+xoA9DYwRWke5QOxrKvgrb+NF/fYtMsY
	 VIFXPeamYNM2JkxHyIaU6Nil5kCJ8iYR+Iv9rNBh7BCaujHbYFPWR64ho6UDyUrYsT
	 9ckVpjAZHZVEqjv9mYDoOZXB1Xlag32yFPdhICgUt8BNTKeqYMYHlaQr17xMflUtaf
	 8/vEFafIFhm2kX5+RPV1NTouAhBw/rsvEdF4mDTTC/ita6U5rdLUV5bviZlp7H4KZO
	 KkWckROIB9C4w==
Date: Wed, 18 Sep 2024 08:05:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915/gem: fix bitwise and logical AND mixup
Message-ID: <20240918150542.GA4049109@thelio-3990X>
References: <cover.1726658138.git.jani.nikula@intel.com>
 <dec5992d78db5bc556600c64ce72aa9b19c96c77.1726658138.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dec5992d78db5bc556600c64ce72aa9b19c96c77.1726658138.git.jani.nikula@intel.com>

On Wed, Sep 18, 2024 at 02:17:44PM +0300, Jani Nikula wrote:
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND is an int, defaulting to 250. When
> the wakeref is non-zero, it's either -1 or a dynamically allocated
> pointer, depending on CONFIG_DRM_I915_DEBUG_RUNTIME_PM. It's likely that
> the code works by coincidence with the bitwise AND, but with
> CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y, there's the off chance that the
> condition evaluates to false, and intel_wakeref_auto() doesn't get
> called. Switch to the intended logical AND.
> 
> Fixes: ad74457a6b5a ("drm/i915/dgfx: Release mmap on rpm suspend")
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.1+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index 5c72462d1f57..c157ade48c39 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -1131,7 +1131,7 @@ static vm_fault_t vm_fault_ttm(struct vm_fault *vmf)
>  		GEM_WARN_ON(!i915_ttm_cpu_maps_iomem(bo->resource));
>  	}
>  
> -	if (wakeref & CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
> +	if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)

This is going to result in a clang warning:

  drivers/gpu/drm/i915/gem/i915_gem_ttm.c:1134:14: error: use of logical '&&' with constant operand [-Werror,-Wconstant-logical-operand]
   1134 |         if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
        |                     ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/i915/gem/i915_gem_ttm.c:1134:14: note: use '&' for a bitwise operation
   1134 |         if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
        |                     ^~
        |                     &
  drivers/gpu/drm/i915/gem/i915_gem_ttm.c:1134:14: note: remove constant to silence this warning
   1134 |         if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1 error generated.

Consider adding the explicit '!= 0' to make it clear this should be a
boolean expression.

Cheers,
Nathan

>  		intel_wakeref_auto(&to_i915(obj->base.dev)->runtime_pm.userfault_wakeref,
>  				   msecs_to_jiffies_timeout(CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND));
>  
> -- 
> 2.39.2
> 

