Return-Path: <stable+bounces-144597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE89AB9BE3
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA3E7ACF3C
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 12:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70BE233727;
	Fri, 16 May 2025 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnWY2+9r"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5323C505;
	Fri, 16 May 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398084; cv=none; b=J86Ct1FK9U4UuTzd6/YM+CtivK7SFx63O/IM4IpntKTKC+XRTGxrXYFpdUdIhfrACcDKc/HvROdUUpOt84az0b74qoCw3eqUuvTPLQp+OysRJfqgrsVrtTMdv3ouKhk37qO8mXRGeXYWH47Hcx6JCZBWXxre+QhHQf9RzexIXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398084; c=relaxed/simple;
	bh=KbMQWLdkhUidzB/bEjJRkq+md35Gtch4REzxgBVHyHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rg4qz9aZlhvv7tyvroCPTtHG6xBVTfdX8DCEIUqiQJajZhtrc+d/ZHLeVSpp19LhYXdUs6+Sm28G8BxXMOlTLEmbxeuO5Ss6l2DMlxWs66W7Kp7RxJXRoAXs7Ko9eBRKC1P32hkyx/ctVtsS+BoFkGPpiElCE2Dd+GuT8vmVQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnWY2+9r; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747398082; x=1778934082;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KbMQWLdkhUidzB/bEjJRkq+md35Gtch4REzxgBVHyHA=;
  b=EnWY2+9rThw2P0l/MCsYl1Ap2Tkhwi/OQ4AzHfONXd3eivbv+vK7zIEB
   WV2XCC1twhJmHzrr6FJlgtr83p/BQufqNHwAp8ZxO0kFHMdnty/90ysoo
   qBOIz7p5TvLLSSwvJszkQk+SAEihAtQd472mb5791jALqpAGyCzmIfTOa
   ND96il3JbZMXn10231OJNdIZUkaVnVUa09J9c+VDOEjBZDsuv3pqoraDz
   7W7XU+doa612ynmEFO7/zZOG2uI9WDZ7Iz8y4OkwnsF39/pWcSpxgOt/J
   j8WYrnpqFtNpJi7M47czsZoCN6nosBGwObXf9WIIbbW9TZrSh1yg0+pDm
   A==;
X-CSE-ConnectionGUID: KODQg1YiQ6KI2vjpYxindw==
X-CSE-MsgGUID: hjJWZXfYQI6cXKzSIWrLQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60710176"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="60710176"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 05:21:22 -0700
X-CSE-ConnectionGUID: kMLqN3/uSM28YvOAcz9ZYA==
X-CSE-MsgGUID: hCeQz30nT7SfLV2uwZAsDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138594781"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.133])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 05:21:18 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, gustavo.sousa@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Haoxiang Li
 <haoxiang_li2024@163.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] drm/i915/display: Add check for
 alloc_ordered_workqueue() and alloc_workqueue()
In-Reply-To: <20250424025539.3504019-1-haoxiang_li2024@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250424025539.3504019-1-haoxiang_li2024@163.com>
Date: Fri, 16 May 2025 15:21:15 +0300
Message-ID: <87cyc8wxtw.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 24 Apr 2025, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> Add check for the return value of alloc_ordered_workqueue()
> and alloc_workqueue(). Furthermore, if some allocations fail,
> cleanup works are added to avoid potential memory leak problem.
>
> Fixes: 40053823baad ("drm/i915/display: move modeset probe/remove functions to intel_display_driver.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

This patch seems to have been neglected, apologies.

I've rebased it and included it as part of a bigger series [1].

Thanks for the patch.

BR,
Jani.


[1] https://lore.kernel.org/r/cover.1747397638.git.jani.nikula@intel.com



> ---
> Changes in v2:
> - Split the compound conditional statement into separate
>   conditional statements to facilitate cleanup works.
> - Add cleanup works to destory work queues if allocations fail,
>   and modify the later goto destination to do the full excercise.
> - modify the patch description. Thanks, Jani!
> ---
>  .../drm/i915/display/intel_display_driver.c   | 30 +++++++++++++++----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
> index 31740a677dd8..ac94561715dc 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_driver.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
> @@ -241,31 +241,45 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
>  	intel_dmc_init(display);
>  
>  	display->wq.modeset = alloc_ordered_workqueue("i915_modeset", 0);
> +	if (!display->wq.modeset) {
> +		ret = -ENOMEM;
> +		goto cleanup_vga_client_pw_domain_dmc;
> +	}
> +
>  	display->wq.flip = alloc_workqueue("i915_flip", WQ_HIGHPRI |
>  						WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
> +	if (!display->wq.flip) {
> +		ret = -ENOMEM;
> +		goto cleanup_wq_modeset;
> +	}
> +
>  	display->wq.cleanup = alloc_workqueue("i915_cleanup", WQ_HIGHPRI, 0);
> +	if (!display->wq.cleanup) {
> +		ret = -ENOMEM;
> +		goto cleanup_wq_flip;
> +	}
>  
>  	intel_mode_config_init(display);
>  
>  	ret = intel_cdclk_init(display);
>  	if (ret)
> -		goto cleanup_vga_client_pw_domain_dmc;
> +		goto cleanup_wq_cleanup;
>  
>  	ret = intel_color_init(display);
>  	if (ret)
> -		goto cleanup_vga_client_pw_domain_dmc;
> +		goto cleanup_wq_cleanup;
>  
>  	ret = intel_dbuf_init(i915);
>  	if (ret)
> -		goto cleanup_vga_client_pw_domain_dmc;
> +		goto cleanup_wq_cleanup;
>  
>  	ret = intel_bw_init(i915);
>  	if (ret)
> -		goto cleanup_vga_client_pw_domain_dmc;
> +		goto cleanup_wq_cleanup;
>  
>  	ret = intel_pmdemand_init(display);
>  	if (ret)
> -		goto cleanup_vga_client_pw_domain_dmc;
> +		goto cleanup_wq_cleanup;
>  
>  	intel_init_quirks(display);
>  
> @@ -273,6 +287,12 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
>  
>  	return 0;
>  
> +cleanup_wq_cleanup:
> +	destroy_workqueue(display->wq.cleanup);
> +cleanup_wq_flip:
> +	destroy_workqueue(display->wq.flip);
> +cleanup_wq_modeset:
> +	destroy_workqueue(display->wq.modeset);
>  cleanup_vga_client_pw_domain_dmc:
>  	intel_dmc_fini(display);
>  	intel_power_domains_driver_remove(display);

-- 
Jani Nikula, Intel

