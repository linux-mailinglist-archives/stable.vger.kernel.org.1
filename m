Return-Path: <stable+bounces-160162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4031EAF8D09
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 10:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB051C880DE
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 08:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02823C51A;
	Fri,  4 Jul 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A12++TEL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227F1F4631
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619144; cv=none; b=GRPk9U4bHSZKN8JtVrIMc2/Nb3eNb6aMdL2kEMvTaZaBu/qalOeairCwIzeHv9o6HdsROT/Cm+Kv1XSZKGVGfWN0EaHjju5006HozbGkKfLmJp1licDtAuOtIKsahACCs0lGvKTz8d6o1L5yvnEfsTmUPT92nSOL4gaH+BzxjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619144; c=relaxed/simple;
	bh=eDaB4H7uTImRWrHDBvRkFn8cXQ2OlGO5SiT890oT2Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFDJCe+Pe220ASIDy+FIZakNn/ul5391MA6yacuiQO+Wp9MbdXL1HzFd0K3oSHe34pfokvk4SUwAhguBzvlYoNI6vN6wQV/l+Oyz7eO9S3rqOHHcamQotvqDoNJ5VQ/Bcvq8D2Awi60m/1Cov1hVFY75TxibpcHjnw1784XY0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A12++TEL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751619142; x=1783155142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eDaB4H7uTImRWrHDBvRkFn8cXQ2OlGO5SiT890oT2Yc=;
  b=A12++TELaUCZPjEjQQjJUBcCrZuYAktSCSHp3BaJQaGv954KYE3Ji0dQ
   +UbjUZhhspDyxCC+vsT7M+/Uz6D6iZEnkRUEdY+0FhRnukPqHD+cWXU1t
   XJIkkx/AnMevkyneZgUUmz24FGpa/tcr5Sf7/ndfw6XC/MNhXEeCW9CtX
   HHwZTr8ZVka8VSpsvreTzMnYk/+4hcVkyAQyUujQjV94xuaOsR7vn4SRY
   1ec2z1fXY61mA61DtUrGpiMzQphzgIxxxOFc8Hh1lzboXmf8KDpk+mxnI
   KiMY7aG9NPW2rE41rqTtwzMrfq0p6Vql5BiZ2J5Gh/ZYgGR9r3M1Ad/+g
   Q==;
X-CSE-ConnectionGUID: Rr9769xRTPS5Bey82GExmA==
X-CSE-MsgGUID: 47mk1a3uTKSuBtkhh9BCDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="79391982"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="79391982"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 01:52:22 -0700
X-CSE-ConnectionGUID: G5wxgdf2Rzq9ri+HZ0T8fw==
X-CSE-MsgGUID: RBoYUIHbTmeF3eCB66dyMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="154722521"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.245.51]) ([10.245.245.51])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 01:52:20 -0700
Message-ID: <358045a3-c2ac-4d3c-942c-aa5473d88298@intel.com>
Date: Fri, 4 Jul 2025 09:52:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdgpu: Reset the clear flag in buddy during
 resume
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, matthew.brost@intel.com
Cc: alexander.deucher@amd.com, stable@vger.kernel.org
References: <20250701190822.5272-1-Arunpravin.PaneerSelvam@amd.com>
 <20250701190822.5272-2-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250701190822.5272-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/07/2025 20:08, Arunpravin Paneer Selvam wrote:
> - Added a handler in DRM buddy manager to reset the cleared
>    flag for the blocks in the freelist.
> 
> - This is necessary because, upon resuming, the VRAM becomes
>    cluttered with BIOS data, yet the VRAM backend manager
>    believes that everything has been cleared.
> 
> v2:
>    - Add lock before accessing drm_buddy_clear_reset_blocks()(Matthew Auld)
>    - Force merge the two dirty blocks.(Matthew Auld)
>    - Add a new unit test case for this issue.(Matthew Auld)
>    - Having this function being able to flip the state either way would be
>      good. (Matthew Brost)
> 
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: stable@vger.kernel.org
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3812
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 17 ++++
>   drivers/gpu/drm/drm_buddy.c                  | 90 +++++++++++++++++---
>   include/drm/drm_buddy.h                      |  2 +
>   5 files changed, 99 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a59f194e3360..b89e46f29b51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5193,6 +5193,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>   		dev->dev->power.disable_depth--;
>   #endif
>   	}
> +
> +	amdgpu_vram_mgr_clear_reset_blocks(adev);
>   	adev->in_suspend = false;
>   
>   	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 208b7d1d8a27..450e4bf093b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -154,6 +154,7 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
>   				  uint64_t start, uint64_t size);
>   int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
>   				      uint64_t start);
> +void amdgpu_vram_mgr_clear_reset_blocks(struct amdgpu_device *adev);
>   
>   bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
>   			    struct ttm_resource *res);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index abdc52b0895a..665656fbc948 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -782,6 +782,23 @@ uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr)
>   	return atomic64_read(&mgr->vis_usage);
>   }
>   
> +/**
> + * amdgpu_vram_mgr_clear_reset_blocks - reset clear blocks
> + *
> + * @adev: amdgpu device pointer
> + *
> + * Reset the cleared drm buddy blocks.
> + */
> +void amdgpu_vram_mgr_clear_reset_blocks(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
> +	struct drm_buddy *mm = &mgr->mm;
> +
> +	mutex_lock(&mgr->lock);
> +	drm_buddy_reset_clear_state(mm, false);
> +	mutex_unlock(&mgr->lock);
> +}
> +
>   /**
>    * amdgpu_vram_mgr_intersects - test each drm buddy block for intersection
>    *
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index a1e652b7631d..436f7e4ee202 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -12,6 +12,9 @@
>   
>   #include <drm/drm_buddy.h>
>   
> +#define FORCE_MERGE	BIT(0)
> +#define RESET_CLEAR	BIT(1)
> +
>   static struct kmem_cache *slab_blocks;
>   
>   static struct drm_buddy_block *drm_block_alloc(struct drm_buddy *mm,
> @@ -60,6 +63,16 @@ static void list_insert_sorted(struct drm_buddy *mm,
>   	__list_add(&block->link, node->link.prev, &node->link);
>   }
>   
> +static bool is_force_merge_enabled(unsigned int flags)
> +{
> +	return flags & FORCE_MERGE;
> +}
> +
> +static bool is_reset_clear_enabled(unsigned int flags)
> +{
> +	return flags & RESET_CLEAR;
> +}
> +
>   static void clear_reset(struct drm_buddy_block *block)
>   {
>   	block->header &= ~DRM_BUDDY_HEADER_CLEAR;
> @@ -122,7 +135,7 @@ __get_buddy(struct drm_buddy_block *block)
>   
>   static unsigned int __drm_buddy_free(struct drm_buddy *mm,
>   				     struct drm_buddy_block *block,
> -				     bool force_merge)
> +				     unsigned int flags)
>   {
>   	struct drm_buddy_block *parent;
>   	unsigned int order;
> @@ -135,7 +148,7 @@ static unsigned int __drm_buddy_free(struct drm_buddy *mm,
>   		if (!drm_buddy_block_is_free(buddy))
>   			break;
>   
> -		if (!force_merge) {
> +		if (!is_force_merge_enabled(flags)) {
>   			/*
>   			 * Check the block and its buddy clear state and exit
>   			 * the loop if they both have the dissimilar state.
> @@ -149,7 +162,9 @@ static unsigned int __drm_buddy_free(struct drm_buddy *mm,
>   		}
>   
>   		list_del(&buddy->link);
> -		if (force_merge && drm_buddy_block_is_clear(buddy))
> +		if (is_force_merge_enabled(flags) &&
> +		    !is_reset_clear_enabled(flags) &&
> +		    drm_buddy_block_is_clear(buddy))
>   			mm->clear_avail -= drm_buddy_block_size(mm, buddy);
>   
>   		drm_block_free(mm, block);
> @@ -167,7 +182,8 @@ static unsigned int __drm_buddy_free(struct drm_buddy *mm,
>   static int __force_merge(struct drm_buddy *mm,
>   			 u64 start,
>   			 u64 end,
> -			 unsigned int min_order)
> +			 unsigned int min_order,
> +			 unsigned int flags)
>   {
>   	unsigned int order;
>   	int i;
> @@ -178,6 +194,8 @@ static int __force_merge(struct drm_buddy *mm,
>   	if (min_order > mm->max_order)
>   		return -EINVAL;
>   
> +	flags |= FORCE_MERGE;
> +
>   	for (i = min_order - 1; i >= 0; i--) {
>   		struct drm_buddy_block *block, *prev;
>   
> @@ -198,7 +216,8 @@ static int __force_merge(struct drm_buddy *mm,
>   			if (!drm_buddy_block_is_free(buddy))
>   				continue;
>   
> -			WARN_ON(drm_buddy_block_is_clear(block) ==
> +			WARN_ON(!is_reset_clear_enabled(flags) &&
> +				drm_buddy_block_is_clear(block) ==
>   				drm_buddy_block_is_clear(buddy));
>   
>   			/*
> @@ -210,10 +229,11 @@ static int __force_merge(struct drm_buddy *mm,
>   				prev = list_prev_entry(prev, link);
>   
>   			list_del(&block->link);
> -			if (drm_buddy_block_is_clear(block))
> +			if (!is_reset_clear_enabled(flags) &&
> +			    drm_buddy_block_is_clear(block))
>   				mm->clear_avail -= drm_buddy_block_size(mm, block);
>   
> -			order = __drm_buddy_free(mm, block, true);
> +			order = __drm_buddy_free(mm, block, flags);
>   			if (order >= min_order)
>   				return 0;
>   		}
> @@ -336,7 +356,7 @@ void drm_buddy_fini(struct drm_buddy *mm)
>   	for (i = 0; i < mm->n_roots; ++i) {
>   		order = ilog2(size) - ilog2(mm->chunk_size);
>   		start = drm_buddy_block_offset(mm->roots[i]);
> -		__force_merge(mm, start, start + size, order);
> +		__force_merge(mm, start, start + size, order, 0);
>   
>   		if (WARN_ON(!drm_buddy_block_is_free(mm->roots[i])))
>   			kunit_fail_current_test("buddy_fini() root");
> @@ -405,6 +425,50 @@ drm_get_buddy(struct drm_buddy_block *block)
>   }
>   EXPORT_SYMBOL(drm_get_buddy);
>   
> +/**
> + * drm_buddy_reset_clear_state - reset blocks clear state
> + *
> + * @mm: DRM buddy manager
> + * @is_clear: blocks clear state
> + *
> + * Reset the clear state based on @clear value for each block
> + * in the freelist.
> + */
> +void drm_buddy_reset_clear_state(struct drm_buddy *mm, bool is_clear)
> +{
> +	u64 root_size, size, start;
> +	unsigned int order;
> +	int i;
> +
> +	for (i = 0; i <= mm->max_order; ++i) {
> +		struct drm_buddy_block *block;
> +
> +		list_for_each_entry_reverse(block, &mm->free_list[i], link) {
> +			if (is_clear != drm_buddy_block_is_clear(block)) {
> +				if (is_clear) {
> +					mark_cleared(block);
> +					mm->clear_avail += drm_buddy_block_size(mm, block);
> +				} else {
> +					clear_reset(block);
> +					mm->clear_avail -= drm_buddy_block_size(mm, block);
> +				}
> +			}
> +		}
> +	}

Is it not possible to do the merge step first and then go through 
whatever is left marking at clear/dirty? If we do that then we maybe 
don't need any extra changes or flags outside of reset_clear_state? Or 
am I missing something?

> +
> +	/* Force merge the two dirty or two cleared blocks */
> +	size = mm->size;
> +	for (i = 0; i < mm->n_roots; ++i) {
> +		order = ilog2(size) - ilog2(mm->chunk_size);
> +		start = drm_buddy_block_offset(mm->roots[i]);
> +		__force_merge(mm, start, start + size, order, RESET_CLEAR);
> +
> +		root_size = mm->chunk_size << order;
> +		size -= root_size;
> +	}
> +}
> +EXPORT_SYMBOL(drm_buddy_reset_clear_state);
> +
>   /**
>    * drm_buddy_free_block - free a block
>    *
> @@ -419,7 +483,7 @@ void drm_buddy_free_block(struct drm_buddy *mm,
>   	if (drm_buddy_block_is_clear(block))
>   		mm->clear_avail += drm_buddy_block_size(mm, block);
>   
> -	__drm_buddy_free(mm, block, false);
> +	__drm_buddy_free(mm, block, 0);
>   }
>   EXPORT_SYMBOL(drm_buddy_free_block);
>   
> @@ -566,7 +630,7 @@ __alloc_range_bias(struct drm_buddy *mm,
>   	if (buddy &&
>   	    (drm_buddy_block_is_free(block) &&
>   	     drm_buddy_block_is_free(buddy)))
> -		__drm_buddy_free(mm, block, false);
> +		__drm_buddy_free(mm, block, 0);
>   	return ERR_PTR(err);
>   }
>   
> @@ -684,7 +748,7 @@ alloc_from_freelist(struct drm_buddy *mm,
>   
>   err_undo:
>   	if (tmp != order)
> -		__drm_buddy_free(mm, block, false);
> +		__drm_buddy_free(mm, block, 0);
>   	return ERR_PTR(err);
>   }
>   
> @@ -770,7 +834,7 @@ static int __alloc_range(struct drm_buddy *mm,
>   	if (buddy &&
>   	    (drm_buddy_block_is_free(block) &&
>   	     drm_buddy_block_is_free(buddy)))
> -		__drm_buddy_free(mm, block, false);
> +		__drm_buddy_free(mm, block, 0);
>   
>   err_free:
>   	if (err == -ENOSPC && total_allocated_on_err) {
> @@ -1051,7 +1115,7 @@ int drm_buddy_alloc_blocks(struct drm_buddy *mm,
>   			if (order-- == min_order) {
>   				/* Try allocation through force merge method */
>   				if (mm->clear_avail &&
> -				    !__force_merge(mm, start, end, min_order)) {
> +				    !__force_merge(mm, start, end, min_order, 0)) {
>   					block = __drm_buddy_alloc_blocks(mm, start,
>   									 end,
>   									 min_order,
> diff --git a/include/drm/drm_buddy.h b/include/drm/drm_buddy.h
> index 9689a7c5dd36..8b5273d4b2d1 100644
> --- a/include/drm/drm_buddy.h
> +++ b/include/drm/drm_buddy.h
> @@ -160,6 +160,8 @@ int drm_buddy_block_trim(struct drm_buddy *mm,
>   			 u64 new_size,
>   			 struct list_head *blocks);
>   
> +void drm_buddy_reset_clear_state(struct drm_buddy *mm, bool is_clear);
> +
>   void drm_buddy_free_block(struct drm_buddy *mm, struct drm_buddy_block *block);
>   
>   void drm_buddy_free_list(struct drm_buddy *mm,


