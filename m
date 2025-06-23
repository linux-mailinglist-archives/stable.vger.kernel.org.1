Return-Path: <stable+bounces-155361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663CAAE40AE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 14:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28445164B2B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8338123F409;
	Mon, 23 Jun 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSRtIGfd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34789248F40
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682263; cv=none; b=L8QsRfBBLZBRTgyTjcrKS9BxGG0bHNuwGJ+F6sOgXA2xAATDLv+sLDCc+LM/Y8+mmgTsT4R3FGs5GI8mmuwo8a/xfZRprWFpq2E53TzRkcQfBasfmI4VnGpLI6zqkUlDhG1IAqI7rroklgd0nqi2Yiqe4rvaKd/aEmEMotjf7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682263; c=relaxed/simple;
	bh=jOOtIzg+qfOmHQceAyeLn4PiLd1Wxl/+vF70O4jTiQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXdXEWDI+pmaIfyuOw3pNLcabRKHx7PjPMEk96PSFVh3yDfpKuqMuJ2LlaIp7sg2pb1hAYD2w+RgsUzFRnAyXP46zU/4RjaKBL6NXHKIeHaofBsAxmN1K3vvNpa791NBWFzZcWpCi2Zq4xBUUuhrrkB9V43vYpKnfWnCsqcbEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSRtIGfd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750682261; x=1782218261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jOOtIzg+qfOmHQceAyeLn4PiLd1Wxl/+vF70O4jTiQU=;
  b=FSRtIGfd5Xmu+91rLV3/ppEQDc+3iAXuKKO4v9dObst1R4x03wFK9Aj6
   1CFi+iN2MQ2saRVeW1ti095KUoyFCNv2/jn1epTSNCkQ4DHfvmCX2jfWT
   1XyYo4xLYtOlJ0MDxfKBd0Oj2cMWPmZc2HIthXCrPxbXlO/AMnK9LUpEP
   td7J6WM2JM7KjspkzC8au3fFJ01HqSOeAb3vCjmd4BxEPQQS6Yz8xnOm+
   arnzhqv+ogLswPmfXFh6yoBhJ20//Tk971tOkcg9WwtgT7k0Kw6dnPbkv
   PzQ5U4h8lcbeIeTTWk/D7fnxgEpf8W69CFViP+e+EPHrG5YnoJjFAIXAA
   A==;
X-CSE-ConnectionGUID: WrCHE5CjTgKCnY9b+iWBiw==
X-CSE-MsgGUID: JSdTJmfASpyPEgknmct+Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56666222"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="56666222"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 05:37:40 -0700
X-CSE-ConnectionGUID: b10mhB7hRcuT8k5vRF0Wlw==
X-CSE-MsgGUID: cUrA/9NyTFOzEIuyKS2A5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="175204491"
Received: from dprybysh-mobl.ger.corp.intel.com (HELO [10.245.244.101]) ([10.245.244.101])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 05:37:38 -0700
Message-ID: <2250a163-76ee-4da0-8804-9157d269c84b@intel.com>
Date: Mon, 23 Jun 2025 13:37:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Reset the clear flag in buddy during
 resume
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 stable@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
References: <20250623055253.56630-1-Arunpravin.PaneerSelvam@amd.com>
 <20250623055253.56630-2-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250623055253.56630-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+Matt B who is adding clear-on-free support in xe. I'm not sure if we 
might also see something like this.

On 23/06/2025 06:52, Arunpravin Paneer Selvam wrote:
> - Added a handler in DRM buddy manager to reset the cleared
>    flag for the blocks in the freelist.
> 
> - This is necessary because, upon resuming, the VRAM becomes
>    cluttered with BIOS data, yet the VRAM backend manager
>    believes that everything has been cleared.
> 
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: stable@vger.kernel.org
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3812
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |  5 ++++
>   drivers/gpu/drm/drm_buddy.c                  | 24 ++++++++++++++++++++
>   include/drm/drm_buddy.h                      |  2 ++
>   4 files changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a59f194e3360..eb67d6c97392 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5193,6 +5193,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>   		dev->dev->power.disable_depth--;
>   #endif
>   	}
> +
> +	amdgpu_vram_mgr_clear_reset_blocks(&adev->mman.vram_mgr.mm);
>   	adev->in_suspend = false;
>   
>   	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> index 1019c5806ec7..e9e2928fa4d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> @@ -58,6 +58,11 @@ static inline bool amdgpu_vram_mgr_is_cleared(struct drm_buddy_block *block)
>   	return drm_buddy_block_is_clear(block);
>   }
>   
> +static inline void amdgpu_vram_mgr_clear_reset_blocks(struct drm_buddy *mm)
> +{
> +	drm_buddy_clear_reset_blocks(mm);

No lock needed?

> +}
> +
>   static inline struct amdgpu_vram_mgr_resource *
>   to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
>   {
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index a1e652b7631d..b5e44867adf2 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -405,6 +405,30 @@ drm_get_buddy(struct drm_buddy_block *block)
>   }
>   EXPORT_SYMBOL(drm_get_buddy);
>   
> +/**
> + * drm_buddy_clear_reset_blocks - reset cleared blocks
> + *
> + * @mm: DRM buddy manager
> + *
> + * Reset all the cleared blocks in the freelist.
> + */
> +void drm_buddy_clear_reset_blocks(struct drm_buddy *mm)
> +{
> +	unsigned int i;
> +

This might be a good spot to also force merge freed blocks back 
together, for the ones that have the clear vs dirty mismatch. Otherwise 
with the below loop we can have two buddies that are now dirty but don't 
get merged back together? Fairly sure fini() can chuck a warning 
otherwise. Also a simple kunit test for this would be good.

> +	for (i = 0; i <= mm->max_order; ++i) {
> +		struct drm_buddy_block *block;
> +
> +		list_for_each_entry_reverse(block, &mm->free_list[i], link) {
> +			if (drm_buddy_block_is_clear(block)) {
> +				clear_reset(block);
> +				mm->clear_avail -= drm_buddy_block_size(mm, block);
> +			}
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(drm_buddy_clear_reset_blocks);
> +
>   /**
>    * drm_buddy_free_block - free a block
>    *
> diff --git a/include/drm/drm_buddy.h b/include/drm/drm_buddy.h
> index 9689a7c5dd36..da569dea16b7 100644
> --- a/include/drm/drm_buddy.h
> +++ b/include/drm/drm_buddy.h
> @@ -160,6 +160,8 @@ int drm_buddy_block_trim(struct drm_buddy *mm,
>   			 u64 new_size,
>   			 struct list_head *blocks);
>   
> +void drm_buddy_clear_reset_blocks(struct drm_buddy *mm);
> +
>   void drm_buddy_free_block(struct drm_buddy *mm, struct drm_buddy_block *block);
>   
>   void drm_buddy_free_list(struct drm_buddy *mm,


