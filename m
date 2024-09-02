Return-Path: <stable+bounces-72726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B51968AB6
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE21F23006
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D51A1CB530;
	Mon,  2 Sep 2024 15:11:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8651CB500;
	Mon,  2 Sep 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289918; cv=none; b=uT9w1kGLp/Jopej0EgyV+bf0u9wMXVpjolBZRjdR5T0NBKLORAmsrC6+ycdI4fEiiMP7j0VjJ4d3I4ut4pWbRkbddR9OQmir6eso3iGIq73H1IgltlO8VqVZTj6bR8upUpXbdA/9Jnz5MWWaxSvC8vv4odUe5sLksrvq55Fg2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289918; c=relaxed/simple;
	bh=X1SRkOIEclecSiSFXHA6ALTW+HF6xkbXxqQDb2xapEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGWeqMXDXY+ETXH9CZs76E0YwWu5buXT4nTuwdY9h5+IcHV1K8c2/Hq8l76YQ62fjwo4iLaP7VG2SMPBAQraOimazFA16+Jv7nBtKpZbJwmU8xL7zYXMeVdKFM2OWdDhMDkZFc1pbL0Q+QMMiUZuDziXBmXjTD16gxGI/DtC19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AAC6FEC;
	Mon,  2 Sep 2024 08:12:21 -0700 (PDT)
Received: from [10.57.74.147] (unknown [10.57.74.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 967703F66E;
	Mon,  2 Sep 2024 08:11:52 -0700 (PDT)
Message-ID: <6074ec45-7642-4558-83c5-4c9af7e0543d@arm.com>
Date: Mon, 2 Sep 2024 16:11:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: flush FW AS caches in slow reset path
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: kernel@collabora.com, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240902130237.3440720-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240902130237.3440720-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/09/2024 14:02, Adrián Larumbe wrote:
> In the off-chance that waiting for the firmware to signal its booted status
> timed out in the fast reset path, one must flush the cache lines for the
> entire FW VM address space before reloading the regions, otherwise stale
> values eventually lead to a scheduler job timeout.
> 
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c  |  8 +++++++-
>  drivers/gpu/drm/panthor/panthor_mmu.c | 21 ++++++++++++++++++---
>  drivers/gpu/drm/panthor/panthor_mmu.h |  1 +
>  3 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 857f3f11258a..ef232c0c2049 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1089,6 +1089,12 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
>  		panthor_fw_stop(ptdev);
>  		ptdev->fw->fast_reset = false;
>  		drm_err(&ptdev->base, "FW fast reset failed, trying a slow reset");
> +
> +		ret = panthor_vm_flush_all(ptdev->fw->vm);
> +		if (ret) {
> +			drm_err(&ptdev->base, "FW slow reset failed (couldn't flush FW's AS l2cache)");
> +			return ret;
> +		}
>  	}
>  
>  	/* Reload all sections, including RO ones. We're not supposed
> @@ -1099,7 +1105,7 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
>  
>  	ret = panthor_fw_start(ptdev);
>  	if (ret) {
> -		drm_err(&ptdev->base, "FW slow reset failed");
> +		drm_err(&ptdev->base, "FW slow reset failed (couldn't start the FW )");
>  		return ret;
>  	}
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d47972806d50..bbc12728437f 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -576,6 +576,12 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
>  	if (as_nr < 0)
>  		return 0;
>  
> +	/*
> +	 * If the AS number is greater than zero, then we can be sure
> +	 * the device is up and running, so we don't need to explicitly
> +	 * power it up
> +	 */
> +
>  	if (op != AS_COMMAND_UNLOCK)
>  		lock_region(ptdev, as_nr, iova, size);
>  
> @@ -874,14 +880,23 @@ static int panthor_vm_flush_range(struct panthor_vm *vm, u64 iova, u64 size)
>  	if (!drm_dev_enter(&ptdev->base, &cookie))
>  		return 0;
>  
> -	/* Flush the PTs only if we're already awake */
> -	if (pm_runtime_active(ptdev->base.dev))
> -		ret = mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);
> +	ret = mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);
>  
>  	drm_dev_exit(cookie);
>  	return ret;
>  }
>  
> +/**
> + * panthor_vm_flush_all() - Flush L2 caches for the entirety of a VM's AS
> + * @vm: VM whose cache to flush
> + *
> + * Return: 0 on success, a negative error code if flush failed.
> + */
> +int panthor_vm_flush_all(struct panthor_vm *vm)
> +{
> +	return panthor_vm_flush_range(vm, vm->base.mm_start, vm->base.mm_range);
> +}
> +
>  static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
>  {
>  	struct panthor_device *ptdev = vm->ptdev;
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> index f3c1ed19f973..6788771071e3 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -31,6 +31,7 @@ panthor_vm_get_bo_for_va(struct panthor_vm *vm, u64 va, u64 *bo_offset);
>  int panthor_vm_active(struct panthor_vm *vm);
>  void panthor_vm_idle(struct panthor_vm *vm);
>  int panthor_vm_as(struct panthor_vm *vm);
> +int panthor_vm_flush_all(struct panthor_vm *vm);
>  
>  struct panthor_heap_pool *
>  panthor_vm_get_heap_pool(struct panthor_vm *vm, bool create);


