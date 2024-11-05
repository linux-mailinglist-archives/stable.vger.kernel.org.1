Return-Path: <stable+bounces-89845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBEA9BCFC1
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195E21F23325
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7651D47AF;
	Tue,  5 Nov 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQLEA7n4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583D45C18
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818452; cv=none; b=pGrws7Fw3wUpEryBEgZDJufXovNYLz/sP0KTM4oxPM0xM78vQW1EWJ1LXPtcb4nFpc8/ullkw+bGnnr5MXKMOguVtQOx2wcT3wIQH2C/7eq7RTC6s9vTWURgdngcbP76pdHOS3G5Bt5mykFPPx4QU+2LDlUC4Y/ltpBFhGj5eNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818452; c=relaxed/simple;
	bh=pdGTesbU0EEnFO2a2C6kJSAk3Y0imy95q4CFYCFoZz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuD+jo+J1XJ+oYwUODY48glepVUeo0Ve+v5weveqFfgyhR4t7/dL1uPqrd4LBJUVaM6PHL0/vj7l6SecdAT1HGOcGQ+YNHbsWy6n8aBPDWm6jfK4oSmvP1tvQDFrfHPZSgmTQSzci50qVsi/2O5ZiadVXqyv6YIbbzFoGbRwwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQLEA7n4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730818451; x=1762354451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pdGTesbU0EEnFO2a2C6kJSAk3Y0imy95q4CFYCFoZz4=;
  b=aQLEA7n4zw/4uSl5oggvkFOLJhmk+XH5H4BVOly+c6OKMcXwv1DGruvw
   APoKSc3XlLscmTH2Hm3qh4jGtmUJlhau9PJdxU/m7cYenVgTzVBp6nIW9
   Mm+3peKFFydBGtnNeUTm5jB0XEZy06rOGa8CrJW+y5ptz9Ivbhtj0votm
   OciVby9G0DZgQ0UTbEGSRsge4WAyqZNFh3HQehkwyit9TR7mI+I9YChqx
   kYaUQkiFp+W30moh21MkuEWUJzPEXT8Ubee4aUS0z5h0eRmZMMdqOwE9S
   zlGwztKllTUhsDxeTFworg91x+hfNk4M3UHpIErGYDAC6RRWTjr0OYIsa
   g==;
X-CSE-ConnectionGUID: nOBypZiGQ/ih72P96X+FAA==
X-CSE-MsgGUID: FllGrerSR36yPtjugSrBxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30742933"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30742933"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 06:54:10 -0800
X-CSE-ConnectionGUID: KTK0B9zET6uSgAt+7kKc6w==
X-CSE-MsgGUID: 3wusE22EQPOA5l6dpquSbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84145276"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 05 Nov 2024 06:54:07 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 05 Nov 2024 16:54:06 +0200
Date: Tue, 5 Nov 2024 16:54:06 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>
Cc: intel-xe@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/xe: improve hibernation on igpu
Message-ID: <ZyoxjhuG_unc-V8Z@intel.com>
References: <20241101170156.213490-2-matthew.auld@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101170156.213490-2-matthew.auld@intel.com>
X-Patchwork-Hint: comment

On Fri, Nov 01, 2024 at 05:01:57PM +0000, Matthew Auld wrote:
> The GGTT looks to be stored inside stolen memory on igpu which is not
> treated as normal RAM.

The GGTT lives in GSM, not DSM (which is what people normally
mean when the talk about "stolen").

> The core kernel skips this memory range when
> creating the hibernation image, therefore when coming back from
> hibernation the GGTT programming is lost. This seems to cause issues
> with broken resume where GuC FW fails to load:
> 
> [drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
> [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
> [drm] *ERROR* GT0: firmware signature verification failed
> [drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.
> 
> Current GGTT users are kernel internal and tracked as pinned, so it
> should be possible to hook into the existing save/restore logic that we
> use for dgpu, where the actual evict is skipped but on restore we
> importantly restore the GGTT programming.  This has been confirmed to
> fix hibernation on at least ADL and MTL, though likely all igpu
> platforms are affected.
> 
> This also means we have a hole in our testing, where the existing s4
> tests only really test the driver hooks, and don't go as far as actually
> rebooting and restoring from the hibernation image and in turn powering
> down RAM (and therefore losing the contents of stolen).
> 
> v2 (Brost)
>  - Remove extra newline and drop unnecessary parentheses.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_bo.c       | 37 ++++++++++++++------------------
>  drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
>  2 files changed, 16 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 8286cbc23721..549866da5cd1 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -952,7 +952,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
>  	if (WARN_ON(!xe_bo_is_pinned(bo)))
>  		return -EINVAL;
>  
> -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
> +	if (WARN_ON(xe_bo_is_vram(bo)))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
>  		return -EINVAL;
>  
>  	if (!mem_type_is_vram(place->mem_type))
> @@ -1774,6 +1777,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
>  
>  int xe_bo_pin(struct xe_bo *bo)
>  {
> +	struct ttm_place *place = &bo->placements[0];
>  	struct xe_device *xe = xe_bo_device(bo);
>  	int err;
>  
> @@ -1804,8 +1808,6 @@ int xe_bo_pin(struct xe_bo *bo)
>  	 */
>  	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
>  	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> -		struct ttm_place *place = &(bo->placements[0]);
> -
>  		if (mem_type_is_vram(place->mem_type)) {
>  			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
>  
> @@ -1813,13 +1815,12 @@ int xe_bo_pin(struct xe_bo *bo)
>  				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
>  			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
>  		}
> +	}
>  
> -		if (mem_type_is_vram(place->mem_type) ||
> -		    bo->flags & XE_BO_FLAG_GGTT) {
> -			spin_lock(&xe->pinned.lock);
> -			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
> -			spin_unlock(&xe->pinned.lock);
> -		}
> +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> +		spin_lock(&xe->pinned.lock);
> +		list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
> +		spin_unlock(&xe->pinned.lock);
>  	}
>  
>  	ttm_bo_pin(&bo->ttm);
> @@ -1867,24 +1868,18 @@ void xe_bo_unpin_external(struct xe_bo *bo)
>  
>  void xe_bo_unpin(struct xe_bo *bo)
>  {
> +	struct ttm_place *place = &bo->placements[0];
>  	struct xe_device *xe = xe_bo_device(bo);
>  
>  	xe_assert(xe, !bo->ttm.base.import_attach);
>  	xe_assert(xe, xe_bo_is_pinned(bo));
>  
> -	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
> -	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> -		struct ttm_place *place = &(bo->placements[0]);
> -
> -		if (mem_type_is_vram(place->mem_type) ||
> -		    bo->flags & XE_BO_FLAG_GGTT) {
> -			spin_lock(&xe->pinned.lock);
> -			xe_assert(xe, !list_empty(&bo->pinned_link));
> -			list_del_init(&bo->pinned_link);
> -			spin_unlock(&xe->pinned.lock);
> -		}
> +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> +		spin_lock(&xe->pinned.lock);
> +		xe_assert(xe, !list_empty(&bo->pinned_link));
> +		list_del_init(&bo->pinned_link);
> +		spin_unlock(&xe->pinned.lock);
>  	}
> -
>  	ttm_bo_unpin(&bo->ttm);
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
> index 32043e1e5a86..b01bc20eb90b 100644
> --- a/drivers/gpu/drm/xe/xe_bo_evict.c
> +++ b/drivers/gpu/drm/xe/xe_bo_evict.c
> @@ -34,9 +34,6 @@ int xe_bo_evict_all(struct xe_device *xe)
>  	u8 id;
>  	int ret;
>  
> -	if (!IS_DGFX(xe))
> -		return 0;
> -
>  	/* User memory */
>  	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
>  		struct ttm_resource_manager *man =
> @@ -125,9 +122,6 @@ int xe_bo_restore_kernel(struct xe_device *xe)
>  	struct xe_bo *bo;
>  	int ret;
>  
> -	if (!IS_DGFX(xe))
> -		return 0;
> -
>  	spin_lock(&xe->pinned.lock);
>  	for (;;) {
>  		bo = list_first_entry_or_null(&xe->pinned.evicted,
> -- 
> 2.47.0

-- 
Ville Syrjälä
Intel

