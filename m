Return-Path: <stable+bounces-203088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4794BCCFFEE
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 14:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6DFB30A3216
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886832E135;
	Fri, 19 Dec 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="As4NLXXo"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0632D422
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149584; cv=none; b=eo9oyq+r/aiIBiQRomIS1MDD+t5E4LyfSFV7xMdi3UmsKgADNyMwcmqGY5mEqIr7q0WfiRTqp2hhB9Gomm9K8yQmGWu/VljM++upMmgL0P8MyLLWb3b68a6adPuR6ZoNp35dI/TDut/tjZ8blGaJgi3Dv6bW1RkijO/IGtAc4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149584; c=relaxed/simple;
	bh=xwEXc0YZI1B/QU3CrKy/Saw1yLKl2MvE/Ri9dIAvG70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igclcPBClrdNtS9sdfT3+9gjgMadvR0LCAWvR2O/Gs5vM0cMFbTRATQlGZbvS5To9NV6lGLtYHDowpQJ6LPUeKRkACTANCzcjYQ6ZVhcfVBbCPCn1wbY3VnsKzm7BvR08gv1pIn4CLONMFwE7caILRhuFiOUjiOo7XANWS0rM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=As4NLXXo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766149581;
	bh=xwEXc0YZI1B/QU3CrKy/Saw1yLKl2MvE/Ri9dIAvG70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=As4NLXXo8GNRgelCMvEZPX+33lORBHDFOzEMNTIKL1laBiig82d9prp2gbgJH/v5l
	 kh0cWJ1TIjAn2QwboOAdcJfTiOOAT+36ZokuajJu9s4g1MIMP9T9diTpLy+30Awr40
	 9J+jxMOGr8NzwundFzv42Oj5bfDH041NFBEU/j6187sr8MP0mf5NjU/BvPx29WWn1X
	 P/0tN7i+s84bqCst3SulDpKecWITOQtyu7jpndXP3zhI9KMGWW1t15PzzYPRFEVHEl
	 qNTh09bmJMnaV30TTd7kjk9qFvcfUj8/wkr3mzipPhf4lN7LtRCQFZDHua0D8kP16Z
	 k6NNKUwCJ8bMQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0221F17E0465;
	Fri, 19 Dec 2025 14:06:20 +0100 (CET)
Date: Fri, 19 Dec 2025 14:06:17 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dmitry.osipenko@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/5] drm/tests: shmem: Hold reservation lock around
 madvise
Message-ID: <20251219140617.279d3c78@fedora>
In-Reply-To: <20251212160317.287409-5-tzimmermann@suse.de>
References: <20251212160317.287409-1-tzimmermann@suse.de>
	<20251212160317.287409-5-tzimmermann@suse.de>
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

On Fri, 12 Dec 2025 17:00:35 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Acquire and release the GEM object's reservation lock around calls
> to the object's madvide operation. The tests use
> drm_gem_shmem_madvise_locked(), which led to errors such as show below.
> 
> [   58.339389] WARNING: CPU: 1 PID: 1352 at drivers/gpu/drm/drm_gem_shmem_helper.c:499 drm_gem_shmem_madvise_locked+0xde/0x140
> 
> Only export the new helper drm_gem_shmem_madvise() for Kunit tests.
> This is not an interface for regular drivers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 954907f7147d ("drm/shmem-helper: Refactor locked/unlocked functions")
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c     | 15 +++++++++++++++
>  drivers/gpu/drm/tests/drm_gem_shmem_test.c |  8 ++++----
>  include/drm/drm_gem_shmem_helper.h         |  1 +
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 06ef4e5adb7d..4ffcf6ed46f5 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -924,6 +924,21 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *
>  	dma_resv_unlock(obj->resv);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_vunmap);
> +
> +int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
> +{
> +	struct drm_gem_object *obj = &shmem->base;
> +	int ret;
> +
> +	ret = dma_resv_lock_interruptible(obj->resv, NULL);
> +	if (ret)
> +		return ret;
> +	ret = drm_gem_shmem_madvise_locked(shmem, madv);
> +	dma_resv_unlock(obj->resv);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(drm_gem_shmem_madvise);
>  #endif
>  
>  MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> index 3e7c6f20fbcc..d639848e3c8e 100644
> --- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> @@ -292,17 +292,17 @@ static void drm_gem_shmem_test_madvise(struct kunit *test)
>  	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
> -	ret = drm_gem_shmem_madvise_locked(shmem, 1);
> +	ret = drm_gem_shmem_madvise(shmem, 1);
>  	KUNIT_EXPECT_TRUE(test, ret);
>  	KUNIT_ASSERT_EQ(test, shmem->madv, 1);
>  
>  	/* Set madv to a negative value */
> -	ret = drm_gem_shmem_madvise_locked(shmem, -1);
> +	ret = drm_gem_shmem_madvise(shmem, -1);
>  	KUNIT_EXPECT_FALSE(test, ret);
>  	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
>  
>  	/* Check that madv cannot be set back to a positive value */
> -	ret = drm_gem_shmem_madvise_locked(shmem, 0);
> +	ret = drm_gem_shmem_madvise(shmem, 0);
>  	KUNIT_EXPECT_FALSE(test, ret);
>  	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
>  }
> @@ -330,7 +330,7 @@ static void drm_gem_shmem_test_purge(struct kunit *test)
>  	ret = drm_gem_shmem_is_purgeable(shmem);
>  	KUNIT_EXPECT_FALSE(test, ret);
>  
> -	ret = drm_gem_shmem_madvise_locked(shmem, 1);
> +	ret = drm_gem_shmem_madvise(shmem, 1);
>  	KUNIT_EXPECT_TRUE(test, ret);
>  
>  	/* The scatter/gather table will be freed by drm_gem_shmem_free */
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 6924ee226655..3dd93e2df709 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -310,6 +310,7 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
>  #if IS_ENABLED(CONFIG_KUNIT)
>  int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
>  void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem, struct iosys_map *map);
> +int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv);
>  #endif
>  
>  #endif /* __DRM_GEM_SHMEM_HELPER_H__ */


