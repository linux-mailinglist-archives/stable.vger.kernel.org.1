Return-Path: <stable+bounces-54695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D090FFDA
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 11:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5727F1C203D9
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364D67C6C9;
	Thu, 20 Jun 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWFA8CPs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E816A29
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874201; cv=none; b=tmyJO8rSWDZCNN2T/Ze4NJKw/5A0jdzWYaNqBnVEX0vgKPfGpCPZpePkMDqwOK45C/mx/yRzYUMajaaqzPAm8S9KV9PuGmdoI0Ck9jJq4ENvZ5BOLQ/biZtzmau7U07TiMJ5ZX3odyCcoIr4bnZygMHTJplEmgTvHSrZzRNAPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874201; c=relaxed/simple;
	bh=JBJ0kif22VOua/vcGMoja/RHLHRSb1837rekyymq218=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7FPJxkJUGSfyFnVMTn/tq4EoTFtvV2ko7Jw6V0qGhcs9FhEQuArtQ4Yz1rU+bmK5tjTfebotCf2rd5HnBiOEXXyvrRbHDAdXXwCI/bA7OJFkTfINeaRQGTJ9KvseA0uck8nmG2ELksgady6uDHm8GJVhcTa6RvnDy1YD0dEYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWFA8CPs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718874199; x=1750410199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JBJ0kif22VOua/vcGMoja/RHLHRSb1837rekyymq218=;
  b=bWFA8CPsRGJmdfBRoxWUNrlXSRRRj32txHzO+thaO2VYAq6fDCFV9U8J
   ZwCYAc1mzf5aQBC4/3MKggja3gx3mli9LWzvZt5jHwjQxCzVvQDC82Hv2
   WsCXUDCqC769H7GY+lQuPEEKNTUB3xcGm8aKkc8Gxl3jbERAzea8GruVR
   NHZhOB30A/JoF1RlpeyL28H4k3YEnehEo7bXlKCoVGJIu+eg7mcjYL+xs
   xvrCxiW+HfmYy4ia1dAa8at9RCojJcGtpvK+4AKFFdanMCFPW9xAzA6pn
   Nxc5CYO0y0pZiU4yN/Jz4sFqlNC0H2ynHREyv0OhYEn6Aj9ylDYpfUIgk
   A==;
X-CSE-ConnectionGUID: o8vQ/JOzTxu4j6avjK9/vw==
X-CSE-MsgGUID: Aok7cTqZR2GKvKiA3+EcMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15667860"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15667860"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 02:03:18 -0700
X-CSE-ConnectionGUID: RVA/Jx1ISrehm74wFhpZMw==
X-CSE-MsgGUID: WIefCMAZQseGNa70An1YDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="47332163"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.245.229]) ([10.245.245.229])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 02:03:15 -0700
Message-ID: <f9b59d8b-edea-453e-a8be-ef0caba9237a@intel.com>
Date: Thu, 20 Jun 2024 10:03:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Use write-back caching mode for system memory on
 DGFX
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Pallavi Mishra <pallavi.mishra@intel.com>,
 dri-devel@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Effie Yu <effie.yu@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jose Souza <jose.souza@intel.com>, Michal Mrozek <michal.mrozek@intel.com>,
 stable@vger.kernel.org
References: <20240619163904.2935-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20240619163904.2935-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/06/2024 17:39, Thomas Hellström wrote:
> The caching mode for buffer objects with VRAM as a possible
> placement was forced to write-combined, regardless of placement.
> 
> However, write-combined system memory is expensive to allocate and
> even though it is pooled, the pool is expensive to shrink, since
> it involves global CPU TLB flushes.
> 
> Moreover write-combined system memory from TTM is only reliably
> available on x86 and DGFX doesn't have an x86 restriction.
> 
> So regardless of the cpu caching mode selected for a bo,
> internally use write-back caching mode for system memory on DGFX.
> 
> Coherency is maintained, but user-space clients may perceive a
> difference in cpu access speeds.
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Fixes: 622f709ca629 ("drm/xe/uapi: Add support for CPU caching mode")
> Cc: Pallavi Mishra <pallavi.mishra@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Effie Yu <effie.yu@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Jose Souza <jose.souza@intel.com>
> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
Acked-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_bo.c       | 47 +++++++++++++++++++-------------
>   drivers/gpu/drm/xe/xe_bo_types.h |  3 +-
>   include/uapi/drm/xe_drm.h        |  8 +++++-
>   3 files changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 65c696966e96..31192d983d9e 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -343,7 +343,7 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
>   	struct xe_device *xe = xe_bo_device(bo);
>   	struct xe_ttm_tt *tt;
>   	unsigned long extra_pages;
> -	enum ttm_caching caching;
> +	enum ttm_caching caching = ttm_cached;
>   	int err;
>   
>   	tt = kzalloc(sizeof(*tt), GFP_KERNEL);
> @@ -357,26 +357,35 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
>   		extra_pages = DIV_ROUND_UP(xe_device_ccs_bytes(xe, bo->size),
>   					   PAGE_SIZE);
>   
> -	switch (bo->cpu_caching) {
> -	case DRM_XE_GEM_CPU_CACHING_WC:
> -		caching = ttm_write_combined;
> -		break;
> -	default:
> -		caching = ttm_cached;
> -		break;
> -	}
> -
> -	WARN_ON((bo->flags & XE_BO_FLAG_USER) && !bo->cpu_caching);
> -
>   	/*
> -	 * Display scanout is always non-coherent with the CPU cache.
> -	 *
> -	 * For Xe_LPG and beyond, PPGTT PTE lookups are also non-coherent and
> -	 * require a CPU:WC mapping.
> +	 * DGFX system memory is always WB / ttm_cached, since
> +	 * other caching modes are only supported on x86. DGFX
> +	 * GPU system memory accesses are always coherent with the
> +	 * CPU.
>   	 */
> -	if ((!bo->cpu_caching && bo->flags & XE_BO_FLAG_SCANOUT) ||
> -	    (xe->info.graphics_verx100 >= 1270 && bo->flags & XE_BO_FLAG_PAGETABLE))
> -		caching = ttm_write_combined;
> +	if (!IS_DGFX(xe)) {
> +		switch (bo->cpu_caching) {
> +		case DRM_XE_GEM_CPU_CACHING_WC:
> +			caching = ttm_write_combined;
> +			break;
> +		default:
> +			caching = ttm_cached;
> +			break;
> +		}
> +
> +		WARN_ON((bo->flags & XE_BO_FLAG_USER) && !bo->cpu_caching);
> +
> +		/*
> +		 * Display scanout is always non-coherent with the CPU cache.
> +		 *
> +		 * For Xe_LPG and beyond, PPGTT PTE lookups are also
> +		 * non-coherent and require a CPU:WC mapping.
> +		 */
> +		if ((!bo->cpu_caching && bo->flags & XE_BO_FLAG_SCANOUT) ||
> +		    (xe->info.graphics_verx100 >= 1270 &&
> +		     bo->flags & XE_BO_FLAG_PAGETABLE))
> +			caching = ttm_write_combined;
> +	}
>   
>   	if (bo->flags & XE_BO_FLAG_NEEDS_UC) {
>   		/*
> diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
> index 86422e113d39..10450f1fbbde 100644
> --- a/drivers/gpu/drm/xe/xe_bo_types.h
> +++ b/drivers/gpu/drm/xe/xe_bo_types.h
> @@ -66,7 +66,8 @@ struct xe_bo {
>   
>   	/**
>   	 * @cpu_caching: CPU caching mode. Currently only used for userspace
> -	 * objects.
> +	 * objects. Exceptions are system memory on DGFX, which is always
> +	 * WB.
>   	 */
>   	u16 cpu_caching;
>   
> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 93e00be44b2d..1189b3044723 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -783,7 +783,13 @@ struct drm_xe_gem_create {
>   #define DRM_XE_GEM_CPU_CACHING_WC                      2
>   	/**
>   	 * @cpu_caching: The CPU caching mode to select for this object. If
> -	 * mmaping the object the mode selected here will also be used.
> +	 * mmaping the object the mode selected here will also be used. The
> +	 * exception is when mapping system memory (including evicted
> +	 * system memory) on discrete GPUs. The caching mode selected will
> +	 * then be overridden to DRM_XE_GEM_CPU_CACHING_WB, and coherency
> +	 * between GPU- and CPU is guaranteed. The caching mode of
> +	 * existing CPU-mappings will be updated transparently to
> +	 * user-space clients.
>   	 */
>   	__u16 cpu_caching;
>   	/** @pad: MBZ */

