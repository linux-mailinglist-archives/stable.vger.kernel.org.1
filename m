Return-Path: <stable+bounces-203087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA1CCFFD9
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 14:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A2CF303A83F
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211602DF140;
	Fri, 19 Dec 2025 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EmdFKPzN"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFABF328253
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149528; cv=none; b=DPhfAF2sPlwud7Ciu1ekFxCkePkvBsclLuTwaW9a2EkBrDlvXggghxxl0XaAqZgkViHAcuOEkdqKQyLuJQhAgS6ycPDAC/C/V6/KooG3fMSCVwscjKZ6+Hu0pUx1RaJC9sOkP0cTsSxjN8jR1pmTy7qfMe2bykvTCWuG/tbjmwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149528; c=relaxed/simple;
	bh=2TrjiM2xZt8zsYlVMOnJvseuEJNlqNI6QSyzHPTjIJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVa4BpyFC/2UkVKJQUOl2c+0R1q8jlLCVA+x8IUJqTLTnF/gmjNt1vmDSTJ7l6Uwqu8zIjXaj+A9YjLFxHMkUOgHPwaDEp5+CJ/hb834ObDhkrBRYnTVI1je4WFgEGR6C0AIecKHZHG9OjrEI4q6rjs+7ujVxjJVfyHSo9EXUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EmdFKPzN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766149525;
	bh=2TrjiM2xZt8zsYlVMOnJvseuEJNlqNI6QSyzHPTjIJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EmdFKPzNE/0huIeVmDpP75xuLqUe3RN5483SDf6OpTK14OOiaes78B9mt74BgLwqS
	 QY2B6i8WZHK6cNcbkhzWeejyQ3Qpgv2NmOzPu9dH1d+8K8XJoIHE9rQuVmVLeUls7N
	 CNfQRWOk9dQzX3KqVli7LEEsjBUeONhSUQDUXMoUiorLTlW/hJLBYECl2twtU69G6m
	 TdEUOSDZ0k/xxnSxEt6i6bcPRty5sRpG7n5eKEHwQsIEJ73tT8ph/lbklnJLFgu0fU
	 wLhRLT7pXtRR3lpKN2KRNg5Zf/V1pon0U9hv9K5oAUWxYDE0rluiGaBusvt3OQxpbt
	 UGqizUqWfzu0g==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BB39217E0465;
	Fri, 19 Dec 2025 14:05:24 +0100 (CET)
Date: Fri, 19 Dec 2025 14:05:21 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dmitry.osipenko@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/tests: shmem: Hold reservation lock around
 vmap/vunmap
Message-ID: <20251219140521.56c9caac@fedora>
In-Reply-To: <20251212160317.287409-4-tzimmermann@suse.de>
References: <20251212160317.287409-1-tzimmermann@suse.de>
	<20251212160317.287409-4-tzimmermann@suse.de>
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

On Fri, 12 Dec 2025 17:00:34 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Acquire and release the GEM object's reservation lock around vmap and
> vunmap operations. The tests use vmap_locked, which led to errors such
> as show below.
> 
> [  122.292030] WARNING: CPU: 3 PID: 1413 at drivers/gpu/drm/drm_gem_shmem_helper.c:390 drm_gem_shmem_vmap_locked+0x3a3/0x6f0
> 
> [  122.468066] WARNING: CPU: 3 PID: 1413 at drivers/gpu/drm/drm_gem_shmem_helper.c:293 drm_gem_shmem_pin_locked+0x1fe/0x350
> 
> [  122.563504] WARNING: CPU: 3 PID: 1413 at drivers/gpu/drm/drm_gem_shmem_helper.c:234 drm_gem_shmem_get_pages_locked+0x23c/0x370
> 
> [  122.662248] WARNING: CPU: 2 PID: 1413 at drivers/gpu/drm/drm_gem_shmem_helper.c:452 drm_gem_shmem_vunmap_locked+0x101/0x330
> 
> Only export the new vmap/vunmap helpers for Kunit tests. These are
> not interfaces for regular drivers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 954907f7147d ("drm/shmem-helper: Refactor locked/unlocked functions")
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c     | 33 ++++++++++++++++++++++
>  drivers/gpu/drm/tests/drm_gem_shmem_test.c |  6 ++--
>  include/drm/drm_gem_shmem_helper.h         |  9 ++++++
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index dc94a27710e5..06ef4e5adb7d 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -15,6 +15,8 @@
>  #include <asm/set_memory.h>
>  #endif
>  
> +#include <kunit/visibility.h>
> +
>  #include <drm/drm.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>
> @@ -893,6 +895,37 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_no_map);
>  
> +/*
> + * Kunit helpers
> + */
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map)
> +{
> +	struct drm_gem_object *obj = &shmem->base;
> +	int ret;
> +
> +	ret = dma_resv_lock_interruptible(obj->resv, NULL);
> +	if (ret)
> +		return ret;
> +	ret = drm_gem_shmem_vmap_locked(shmem, map);
> +	dma_resv_unlock(obj->resv);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_vmap);
> +
> +void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map)
> +{
> +	struct drm_gem_object *obj = &shmem->base;
> +
> +	dma_resv_lock_interruptible(obj->resv, NULL);
> +	drm_gem_shmem_vunmap_locked(shmem, map);
> +	dma_resv_unlock(obj->resv);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_vunmap);
> +#endif
> +
>  MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
>  MODULE_IMPORT_NS("DMA_BUF");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> index 1d50bab51ef3..3e7c6f20fbcc 100644
> --- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> @@ -19,6 +19,8 @@
>  #include <drm/drm_gem_shmem_helper.h>
>  #include <drm/drm_kunit_helpers.h>
>  
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> +
>  #define TEST_SIZE		SZ_1M
>  #define TEST_BYTE		0xae
>  
> @@ -176,7 +178,7 @@ static void drm_gem_shmem_test_vmap(struct kunit *test)
>  	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
> -	ret = drm_gem_shmem_vmap_locked(shmem, &map);
> +	ret = drm_gem_shmem_vmap(shmem, &map);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  	KUNIT_ASSERT_NOT_NULL(test, shmem->vaddr);
>  	KUNIT_ASSERT_FALSE(test, iosys_map_is_null(&map));
> @@ -186,7 +188,7 @@ static void drm_gem_shmem_test_vmap(struct kunit *test)
>  	for (i = 0; i < TEST_SIZE; i++)
>  		KUNIT_EXPECT_EQ(test, iosys_map_rd(&map, i, u8), TEST_BYTE);
>  
> -	drm_gem_shmem_vunmap_locked(shmem, &map);
> +	drm_gem_shmem_vunmap(shmem, &map);
>  	KUNIT_EXPECT_NULL(test, shmem->vaddr);
>  	KUNIT_EXPECT_EQ(test, refcount_read(&shmem->vmap_use_count), 0);
>  }
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 589f7bfe7506..6924ee226655 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -303,4 +303,13 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
>  	.gem_prime_import       = drm_gem_shmem_prime_import_no_map, \
>  	.dumb_create            = drm_gem_shmem_dumb_create
>  
> +/*
> + * Kunit helpers
> + */
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
> +void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
> +#endif
> +
>  #endif /* __DRM_GEM_SHMEM_HELPER_H__ */


