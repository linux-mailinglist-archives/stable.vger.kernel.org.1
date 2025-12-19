Return-Path: <stable+bounces-203089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0952CD0102
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 14:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E6EE30AE003
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086833372A;
	Fri, 19 Dec 2025 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CUTOfDQr"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A42AE68
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149623; cv=none; b=Phb9yGr0gZ8CH+sv+nhUieIakmfrK1bHZHUh9ZvGtoM0BY1QYBNryaPD2DPWy+fTS94sKzi7N/34z18AdYIZm8Q6B0Wac5HHTY0WdnmcXzq8FjexjnOzAyLIDgZuS94CLAQCqTzgq0xcIjbXqU0Gf4NWuIkUwkNgFq4NweeaR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149623; c=relaxed/simple;
	bh=tK7Bn43uKd6+LIAvp8DushvK+2fQJjQM9yu8oPHG/Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOQIaCwAFR33cmsMAfHR3I9bqn3VwG1179RjZRwNJEGDzfDrnQuFiE14a9CHNYf9ZA+1TfRm2P/0nv0CtIsU4wfDMB5MkD2e2lPk4MVrU7BSXthtCq9SQoq/wOYrvaWr4ZtHpHjl+xDiugUIVsUPS2kc2+utM4W9kNXFmL/tAEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CUTOfDQr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766149617;
	bh=tK7Bn43uKd6+LIAvp8DushvK+2fQJjQM9yu8oPHG/Rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CUTOfDQr2J2DRsNFu0qdnReME2egHoxRYUYSYn3+vfwMXbemBD8DDIQ9D/cUTR9le
	 J9vqiIjewd/SjA5QXhze+SG83K51HTBTSWfq3eRwv5duTelFooDV6FGKdL4v9zlAmU
	 O4EdBJt07WaQT/ZxiLgCiuq+hDv5YOyVl8gZ/dYJKDM4fmu8vS40clGd8apUSLkpNM
	 oFimbbqT32dc0X3VldqhmX5uSs3B3fJMhdAP4x+vSZKxDikRlNWcyqFbIxtu7txJAs
	 vfIdb0anRBEN9/17CSp16u720m421s0yeofdu5TBjbqP80W4g+BXx9w47wZJBd19N6
	 MBFvPrCa0sSBA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1335917E0465;
	Fri, 19 Dec 2025 14:06:57 +0100 (CET)
Date: Fri, 19 Dec 2025 14:06:53 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dmitry.osipenko@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/tests: shmem: Hold reservation lock around
 purge
Message-ID: <20251219140653.176ad59b@fedora>
In-Reply-To: <20251212160317.287409-6-tzimmermann@suse.de>
References: <20251212160317.287409-1-tzimmermann@suse.de>
	<20251212160317.287409-6-tzimmermann@suse.de>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 17:00:36 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Acquire and release the GEM object's reservation lock around calls
> to the object's purge operation. The tests use
> drm_gem_shmem_purge_locked(), which led to errors such as show below.
> 
> [   58.709128] WARNING: CPU: 1 PID: 1354 at drivers/gpu/drm/drm_gem_shmem_helper.c:515 drm_gem_shmem_purge_locked+0x51c/0x740
> 
> Only export the new helper drm_gem_shmem_purge() for Kunit tests.
> This is not an interface for regular drivers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 954907f7147d ("drm/shmem-helper: Refactor locked/unlocked functions")
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c     | 15 +++++++++++++++
>  drivers/gpu/drm/tests/drm_gem_shmem_test.c |  4 +++-
>  include/drm/drm_gem_shmem_helper.h         |  1 +
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 4ffcf6ed46f5..dfc24392cb61 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -939,6 +939,21 @@ int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
>  	return ret;
>  }
>  EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_madvise);
> +
> +int drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
> +{
> +	struct drm_gem_object *obj = &shmem->base;
> +	int ret;
> +
> +	ret = dma_resv_lock_interruptible(obj->resv, NULL);
> +	if (ret)
> +		return ret;
> +	drm_gem_shmem_purge_locked(shmem);
> +	dma_resv_unlock(obj->resv);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_purge);
>  #endif
>  
>  MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> index d639848e3c8e..4b459f21acfd 100644
> --- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> @@ -340,7 +340,9 @@ static void drm_gem_shmem_test_purge(struct kunit *test)
>  	ret = drm_gem_shmem_is_purgeable(shmem);
>  	KUNIT_EXPECT_TRUE(test, ret);
>  
> -	drm_gem_shmem_purge_locked(shmem);
> +	ret = drm_gem_shmem_purge(shmem);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
>  	KUNIT_EXPECT_NULL(test, shmem->pages);
>  	KUNIT_EXPECT_NULL(test, shmem->sgt);
>  	KUNIT_EXPECT_EQ(test, shmem->madv, -1);
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 3dd93e2df709..8d56970d7eed 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -311,6 +311,7 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
>  int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
>  void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
>  int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv);
> +int drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem);
>  #endif
>  
>  #endif /* __DRM_GEM_SHMEM_HELPER_H__ */


