Return-Path: <stable+bounces-144604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8A5AB9E26
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 16:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE92A20560
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697801F956;
	Fri, 16 May 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laDUhfed"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572DFC1D
	for <stable@vger.kernel.org>; Fri, 16 May 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404303; cv=none; b=NifNRDaDL9yC4sfVtGHZ9wtuNopQgh9eOUB0pODbmydpKlF3MlrYOs4EIJvJGQ97+C8LsWGzU1kyyiXcdj7QX9Bbtvw64suzdu33dLTR9MGmFBlkHiBxuNXK4VXjZl79DiUgI20CcVd15fTX+4RGp/OJbsNOxJA0p5y8nSLN7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404303; c=relaxed/simple;
	bh=AARtyQQn4x3pnO3w+0Flli0MLpF+OLmxeanXecRDEkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOHJpBIoIv5F8s1z4L7SRr97OWX53LHdjJl4WC4QoDK4o94nPphAmlYn7/4SPt4fxAdOLiEQZpunDEvzO3y504VNTR5/rEedtPEGVljBl1p6v4x0ZncnYhTZ49mz3tA//L8T+fy5ltzbHfRV6JP5m3PzTcZjV3XEfRwllga10eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laDUhfed; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747404302; x=1778940302;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AARtyQQn4x3pnO3w+0Flli0MLpF+OLmxeanXecRDEkM=;
  b=laDUhfedz534qVNH0EJ/srZFvKo+6aFozjrRyaIuL4mlqp8VLsMv+9uq
   HwYmL4yhhz7SD7sREAxQnCan/RoXB6EmU/1INcTYeJLScgKVUMWFTG9WN
   RvcUm0nyqPijdQdl7FUseozEFlnngDyW/rZucHvfh+QR/HXhjCck19m0B
   2XQsAgKumKYTtFk04Y1MdJL0DuMGxB/qA8ydWAtxzRgtOonkO2NESsv0s
   JjRcYO8ISAfPAdw59GAAYSMQLu7Hh6N3DBzgqv+OHFhiFsTjlhNomEkFc
   KeyS0vLb7B3Ewo50bBhQ2q9s19YbCzjjY20U9jOkqmosGrN2B9aH8a725
   A==;
X-CSE-ConnectionGUID: P9FjNnZLTkePb3r+4+UczA==
X-CSE-MsgGUID: I3ojBQ/8R5itgaFAodju/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49533463"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="49533463"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 07:05:01 -0700
X-CSE-ConnectionGUID: 468EPgi6QFabP7q5fiJGZA==
X-CSE-MsgGUID: 56MrHrFWQnmA1jJlusy6gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="142706963"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.176]) ([10.245.245.176])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 07:04:59 -0700
Message-ID: <8c1002cd-e5bf-4d1b-880c-5e7ac7d08f70@intel.com>
Date: Fri, 16 May 2025 15:04:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/i915/display: Add check for
 alloc_ordered_workqueue() and alloc_workqueue()
To: Jani Nikula <jani.nikula@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>, stable@vger.kernel.org
References: <cover.1747397638.git.jani.nikula@intel.com>
 <20d3d096c6a4907636f8a1389b3b4dd753ca356e.1747397638.git.jani.nikula@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20d3d096c6a4907636f8a1389b3b4dd753ca356e.1747397638.git.jani.nikula@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/05/2025 13:16, Jani Nikula wrote:
> From: Haoxiang Li <haoxiang_li2024@163.com>
> 
> Add check for the return value of alloc_ordered_workqueue()
> and alloc_workqueue(). Furthermore, if some allocations fail,
> cleanup works are added to avoid potential memory leak problem.
> 
> Fixes: 40053823baad ("drm/i915/display: move modeset probe/remove functions to intel_display_driver.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   .../drm/i915/display/intel_display_driver.c   | 30 +++++++++++++++----
>   1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
> index 5c74ab5fd1aa..411fe7b918a7 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_driver.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
> @@ -244,31 +244,45 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
>   	intel_dmc_init(display);
>   
>   	display->wq.modeset = alloc_ordered_workqueue("i915_modeset", 0);
> +	if (!display->wq.modeset) {
> +		ret = -ENOMEM;
> +		goto cleanup_vga_client_pw_domain_dmc;
> +	}
> +
>   	display->wq.flip = alloc_workqueue("i915_flip", WQ_HIGHPRI |
>   						WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
> +	if (!display->wq.flip) {
> +		ret = -ENOMEM;
> +		goto cleanup_wq_modeset;
> +	}
> +
>   	display->wq.cleanup = alloc_workqueue("i915_cleanup", WQ_HIGHPRI, 0);
> +	if (!display->wq.cleanup) {
> +		ret = -ENOMEM;
> +		goto cleanup_wq_flip;
> +	}
>   
>   	intel_mode_config_init(display);
>   
>   	ret = intel_cdclk_init(display);
>   	if (ret)
> -		goto cleanup_vga_client_pw_domain_dmc;
> +		goto cleanup_wq_cleanup;
>   
>   	ret = intel_color_init(display);
>   	if (ret)
> -		goto cleanup_vga_client_pw_domain_dmc;
> +		goto cleanup_wq_cleanup;
>   
>   	ret = intel_dbuf_init(display);
>   	if (ret)
> -		goto cleanup_vga_client_pw_domain_dmc;
> +		goto cleanup_wq_cleanup;
>   
>   	ret = intel_bw_init(display);
>   	if (ret)
> -		goto cleanup_vga_client_pw_domain_dmc;
> +		goto cleanup_wq_cleanup;
>   
>   	ret = intel_pmdemand_init(display);
>   	if (ret)
> -		goto cleanup_vga_client_pw_domain_dmc;
> +		goto cleanup_wq_cleanup;
>   
>   	intel_init_quirks(display);
>   
> @@ -276,6 +290,12 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
>   
>   	return 0;
>   
> +cleanup_wq_cleanup:
> +	destroy_workqueue(display->wq.cleanup);
> +cleanup_wq_flip:
> +	destroy_workqueue(display->wq.flip);
> +cleanup_wq_modeset:
> +	destroy_workqueue(display->wq.modeset);
>   cleanup_vga_client_pw_domain_dmc:
>   	intel_dmc_fini(display);
>   	intel_power_domains_driver_remove(display);


