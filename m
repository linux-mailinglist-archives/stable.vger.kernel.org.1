Return-Path: <stable+bounces-2861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF27FB2B5
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 08:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A46E1C20AB1
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A89134C4;
	Tue, 28 Nov 2023 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eqISXMNY"
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 23:28:32 PST
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049458E
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 23:28:31 -0800 (PST)
Date: Tue, 28 Nov 2023 15:19:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701155958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8uqJSYQwjFCUay41Ix8e7EVNe5lKSgbz8vntysNfGs=;
	b=eqISXMNY5sRQ6TCaHK/RJ9QeGTChM9TJ+coBuLYWGjnrICGfyKt4T0KDWdxlfrbf1rGxT4
	0KPunZldfaj/Dsray/xZR30B1ahE5dyIuSDWUM9jNOrUMGT5uTUuagqahAdHKctz39d4vY
	Ny0CVMfwlwBYGmvRRlxWj0ZtjHCZugA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Cai Huoqing <cai.huoqing@linux.dev>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/14] arch/powerpc: Remove legacy DRM drivers from
 default configs
Message-ID: <ZWWUcRWemEFmJbmS@chq-MS-7D45>
References: <20231122122449.11588-1-tzimmermann@suse.de>
 <20231122122449.11588-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122122449.11588-2-tzimmermann@suse.de>
X-Migadu-Flow: FLOW_OUT

On 22 11月 23 13:09:30, Thomas Zimmermann wrote:
> DRM drivers for user-space modesetting have been removed. Do not
> select the respective options in the default configs.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: a276afc19eec ("drm: Remove some obsolete drm pciids(tdfx, mga, i810, savage, r128, sis, via)")

Reviewed-by: Cai Huoqing <cai.huoqing@linux.dev>

> Cc: Cai Huoqing <cai.huoqing@linux.dev>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.3+
> ---
>  arch/powerpc/configs/pmac32_defconfig | 2 --
>  arch/powerpc/configs/ppc6xx_defconfig | 7 -------
>  2 files changed, 9 deletions(-)
> 
> diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
> index 57ded82c28409..e41e7affd2482 100644
> --- a/arch/powerpc/configs/pmac32_defconfig
> +++ b/arch/powerpc/configs/pmac32_defconfig
> @@ -188,8 +188,6 @@ CONFIG_AGP=m
>  CONFIG_AGP_UNINORTH=m
>  CONFIG_DRM=m
>  CONFIG_DRM_RADEON=m
> -CONFIG_DRM_LEGACY=y
> -CONFIG_DRM_R128=m
>  CONFIG_FB=y
>  CONFIG_FB_OF=y
>  CONFIG_FB_CONTROL=y
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index f279703425d45..e680cd086f0e8 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -678,13 +678,6 @@ CONFIG_AGP=y
>  CONFIG_AGP_UNINORTH=y
>  CONFIG_DRM=m
>  CONFIG_DRM_RADEON=m
> -CONFIG_DRM_LEGACY=y
> -CONFIG_DRM_TDFX=m
> -CONFIG_DRM_R128=m
> -CONFIG_DRM_MGA=m
> -CONFIG_DRM_SIS=m
> -CONFIG_DRM_VIA=m
> -CONFIG_DRM_SAVAGE=m
>  CONFIG_FB=y
>  CONFIG_FB_CIRRUS=m
>  CONFIG_FB_OF=y
> -- 
> 2.42.1
> 

