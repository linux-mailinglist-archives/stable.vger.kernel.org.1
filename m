Return-Path: <stable+bounces-160470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279C1AFC671
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 11:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F0518933E0
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1829E11F;
	Tue,  8 Jul 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BS1l/Q+A"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9656221554
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965222; cv=none; b=K+hq26mVb7U/yvW289/LrG5UuAobxHmoiOzeh8f/8Da/ktEUkkZhrUx5sdmpyWq8fkuKNWk8BnuGhY9PS4u3uRTc9b/22JGcEz8jRrbLaYcuv9KOhbaXDCN24rPFEaLj+atfihfYVrlxQDGrXeL2TFYhDK0WR0iL3T+fBrHojvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965222; c=relaxed/simple;
	bh=oT3rdEuHI+Q9zpqSzlynFnMBHIYbzjNLa3frXjecsNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwSKbBaEwMwqYkAhF7p5Ab0iQHywGB9VIFtTqCPSgOJEDUibGIaLpIJ6YOmnwDobfml3iwPj/hGFovW6ozD0wUd0onhhmvI2zdPYjX33gXlS/zoYDmd80GwG5GL3VZifJVNepDkFY1qwSSk7P6fj3qYTXQAtPT6Uy4tmjU3N7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BS1l/Q+A; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751965221; x=1783501221;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oT3rdEuHI+Q9zpqSzlynFnMBHIYbzjNLa3frXjecsNQ=;
  b=BS1l/Q+AedIS88AFbkER3OwtL6EZ+5yYUI72qEe2/iGySIR6u2IFTRJg
   ZjjoTqC54uzaZT5IY+0yh3vJwby676Qt+Dpevy3IfrJOX/lDvfgAtjngE
   1LjNPd/NNYW4agR6x+BJCAue8mjfrLJVhujbcA41n4YJbNDD1q4qe1nfO
   MmFiN60Usp+uB9xMQnBsL0DnWlDXT0t46g6OLGL6JZ8xNzkz6uQw23mkM
   qoM05v+LYLo5qUaGDjAX6CvjaZbzqx0roHG53QiL6ZiZ8vdc5rjyHrjYA
   e67lBqc8FAPSoezuNnbWzcoJw3C9I4DgDqpee77s0rj5eusAcX94hQPgN
   Q==;
X-CSE-ConnectionGUID: eej56NjDSvaJ0KNeAon40Q==
X-CSE-MsgGUID: pGwW4Jn3Qh6scDH4OB5B5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65258356"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="65258356"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 02:00:18 -0700
X-CSE-ConnectionGUID: HNMl4sViT3iVwerUS22gUQ==
X-CSE-MsgGUID: CHKd0QWmTLe7pYJe0rQLlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="156187514"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.245.6]) ([10.245.245.6])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 02:00:16 -0700
Message-ID: <f5386d20-326f-40ba-834f-953a0d7d18e1@intel.com>
Date: Tue, 8 Jul 2025 10:00:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Reset the clear flag in buddy during
 resume
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, matthew.brost@intel.com
Cc: alexander.deucher@amd.com, stable@vger.kernel.org
References: <20250708065404.4185-1-Arunpravin.PaneerSelvam@amd.com>
 <20250708065404.4185-2-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250708065404.4185-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/07/2025 07:54, Arunpravin Paneer Selvam wrote:
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
> v3(Matthew Auld):
>    - Do merge step first to avoid the use of extra reset flag.
> 
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: stable@vger.kernel.org
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3812

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 17 ++++++++
>   drivers/gpu/drm/drm_buddy.c                  | 43 ++++++++++++++++++++
>   include/drm/drm_buddy.h                      |  2 +
>   5 files changed, 65 insertions(+)
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
> index abdc52b0895a..07c936e90d8e 100644
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
> +	drm_buddy_reset_clear(mm, false);
> +	mutex_unlock(&mgr->lock);
> +}
> +
>   /**
>    * amdgpu_vram_mgr_intersects - test each drm buddy block for intersection
>    *
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index a1e652b7631d..a94061f373de 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -405,6 +405,49 @@ drm_get_buddy(struct drm_buddy_block *block)
>   }
>   EXPORT_SYMBOL(drm_get_buddy);
>   
> +/**
> + * drm_buddy_reset_clear - reset blocks clear state
> + *
> + * @mm: DRM buddy manager
> + * @is_clear: blocks clear state
> + *
> + * Reset the clear state based on @is_clear value for each block
> + * in the freelist.
> + */
> +void drm_buddy_reset_clear(struct drm_buddy *mm, bool is_clear)
> +{
> +	u64 root_size, size, start;
> +	unsigned int order;
> +	int i;
> +
> +	size = mm->size;
> +	for (i = 0; i < mm->n_roots; ++i) {
> +		order = ilog2(size) - ilog2(mm->chunk_size);
> +		start = drm_buddy_block_offset(mm->roots[i]);
> +		__force_merge(mm, start, start + size, order);
> +
> +		root_size = mm->chunk_size << order;
> +		size -= root_size;
> +	}
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
> +}
> +EXPORT_SYMBOL(drm_buddy_reset_clear);
> +
>   /**
>    * drm_buddy_free_block - free a block
>    *
> diff --git a/include/drm/drm_buddy.h b/include/drm/drm_buddy.h
> index 9689a7c5dd36..513837632b7d 100644
> --- a/include/drm/drm_buddy.h
> +++ b/include/drm/drm_buddy.h
> @@ -160,6 +160,8 @@ int drm_buddy_block_trim(struct drm_buddy *mm,
>   			 u64 new_size,
>   			 struct list_head *blocks);
>   
> +void drm_buddy_reset_clear(struct drm_buddy *mm, bool is_clear);
> +
>   void drm_buddy_free_block(struct drm_buddy *mm, struct drm_buddy_block *block);
>   
>   void drm_buddy_free_list(struct drm_buddy *mm,


