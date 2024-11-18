Return-Path: <stable+bounces-93789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720E39D0FCF
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 12:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3225E282F3B
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 11:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC98E198A08;
	Mon, 18 Nov 2024 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hx6wlRjF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1E3BBF2
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929681; cv=none; b=ab+rR+nxFLOWTeZkxcIrXO1BrHpTYM/08tWZvjUN+fye+wOBSHTw1iR+/1G856yAOX6g8A7ABHCMAyp1nuuftnEPpdb87rTJaRWXkqAcAI7CxWDnR+VbKXlXBuXs6ju2YDSzQyXnqDfjs5NsRtR04LG6piJWtt7/eAx6f23dzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929681; c=relaxed/simple;
	bh=6CI2Irl3ptKnzek8C32y4cQN8SFTEB0WLZYpjK29lhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NGPVVE6ptZ2uKhrNp+t+DmfhBRXgj/bx99XS9I6mr9zMopOn8HXQIaHVRabde/6At+J5zP4xIKO/+ZV8T52tJdFCn6bmzXorqWl5eECnPBeQRBTbx3qDuf825SEYqCzg1UJCoft2b7q3K+0cpJzOHnCKcqsFXlGrFXp2b/zYMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hx6wlRjF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731929679; x=1763465679;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6CI2Irl3ptKnzek8C32y4cQN8SFTEB0WLZYpjK29lhc=;
  b=Hx6wlRjFAGvQAuYbrf759gh4RKW76PLNzy00hhQ4MGVwqDXAYsJvwuq1
   EaScFlDCCh54/9cJ+YtQdoDqXXX1R2w8TxCI/0R0ewdvXEmWxTmGlZTR6
   w0LWJtDQqdjsSe4iKg6U5a/hJQmRbm4EEhuFW606Q3pbizU3GPBQJhDQH
   Jh6PY7vwL+4zNERGycofPvY7nXau1V9UJFglJLuYyZB+0DqfTzNsgZWj2
   1nvx5C1onw1KCJ+uDPHAhIxmRGdYchjDEvCXzJ+Wlad/Isqu0+VZ3E9e3
   vqPwHoNU2+cmyAY3sopePV+5uw/IodUnc2+I2WIlCzUKxmB7ZpCXErPiw
   g==;
X-CSE-ConnectionGUID: dOC7VzrxSXu9l666gP6Eyw==
X-CSE-MsgGUID: H5vzUWo8Rh+UZherWiRzmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="49314628"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="49314628"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 03:34:38 -0800
X-CSE-ConnectionGUID: l6n/YGXoSPqlFIRtLTyMyA==
X-CSE-MsgGUID: CRJtErUcTKiG9Z/0M7qKXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="126740544"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.170]) ([10.245.245.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 03:34:37 -0800
Message-ID: <90c3c1ad-2791-49d7-8afc-a12a55859ca2@intel.com>
Date: Mon, 18 Nov 2024 11:34:35 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] drm/xe: improve hibernation on igpu"
 failed to apply to 6.11-stable tree
To: gregkh@linuxfoundation.org, lucas.demarchi@intel.com,
 matthew.brost@intel.com, stable@vger.kernel.org
References: <2024111758-jumbo-neon-1b3c@gregkh>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <2024111758-jumbo-neon-1b3c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2024 20:36, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.11-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
> git checkout FETCH_HEAD
> git cherry-pick -x 46f1f4b0f3c2a2dff9887de7c66ccc7ef482bd83
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111758-jumbo-neon-1b3c@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..
> 
> Possible dependencies:

There is a dependency with:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=dd886a63d6e2ce5c16e662c07547c067ad7d91f5

I guess we need to get that patch into linux-6.11.y branch also? I think 
we also need both patches for "drm/xe: handle flat ccs during 
hibernation on igpu" to work, even if it applies without.

> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
>  From 46f1f4b0f3c2a2dff9887de7c66ccc7ef482bd83 Mon Sep 17 00:00:00 2001
> From: Matthew Auld <matthew.auld@intel.com>
> Date: Fri, 1 Nov 2024 17:01:57 +0000
> Subject: [PATCH] drm/xe: improve hibernation on igpu
> 
> The GGTT looks to be stored inside stolen memory on igpu which is not
> treated as normal RAM.  The core kernel skips this memory range when
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
>   - Remove extra newline and drop unnecessary parentheses.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20241101170156.213490-2-matthew.auld@intel.com
> (cherry picked from commit f2a6b8e396666d97ada8e8759dfb6a69d8df6380)
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 74f68289f74c..2a093540354e 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -948,7 +948,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
>   	if (WARN_ON(!xe_bo_is_pinned(bo)))
>   		return -EINVAL;
>   
> -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
> +	if (WARN_ON(xe_bo_is_vram(bo)))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
>   		return -EINVAL;
>   
>   	if (!mem_type_is_vram(place->mem_type))
> @@ -1723,6 +1726,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
>   
>   int xe_bo_pin(struct xe_bo *bo)
>   {
> +	struct ttm_place *place = &bo->placements[0];
>   	struct xe_device *xe = xe_bo_device(bo);
>   	int err;
>   
> @@ -1753,8 +1757,6 @@ int xe_bo_pin(struct xe_bo *bo)
>   	 */
>   	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
>   	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
> -		struct ttm_place *place = &(bo->placements[0]);
> -
>   		if (mem_type_is_vram(place->mem_type)) {
>   			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
>   
> @@ -1762,13 +1764,12 @@ int xe_bo_pin(struct xe_bo *bo)
>   				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
>   			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
>   		}
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
>   	}
>   
>   	ttm_bo_pin(&bo->ttm);
> @@ -1816,24 +1817,18 @@ void xe_bo_unpin_external(struct xe_bo *bo)
>   
>   void xe_bo_unpin(struct xe_bo *bo)
>   {
> +	struct ttm_place *place = &bo->placements[0];
>   	struct xe_device *xe = xe_bo_device(bo);
>   
>   	xe_assert(xe, !bo->ttm.base.import_attach);
>   	xe_assert(xe, xe_bo_is_pinned(bo));
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
>   	}
> -
>   	ttm_bo_unpin(&bo->ttm);
>   }
>   
> diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
> index 32043e1e5a86..b01bc20eb90b 100644
> --- a/drivers/gpu/drm/xe/xe_bo_evict.c
> +++ b/drivers/gpu/drm/xe/xe_bo_evict.c
> @@ -34,9 +34,6 @@ int xe_bo_evict_all(struct xe_device *xe)
>   	u8 id;
>   	int ret;
>   
> -	if (!IS_DGFX(xe))
> -		return 0;
> -
>   	/* User memory */
>   	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
>   		struct ttm_resource_manager *man =
> @@ -125,9 +122,6 @@ int xe_bo_restore_kernel(struct xe_device *xe)
>   	struct xe_bo *bo;
>   	int ret;
>   
> -	if (!IS_DGFX(xe))
> -		return 0;
> -
>   	spin_lock(&xe->pinned.lock);
>   	for (;;) {
>   		bo = list_first_entry_or_null(&xe->pinned.evicted,
> 


