Return-Path: <stable+bounces-73140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A8C96D084
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675672877B8
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CF419309A;
	Thu,  5 Sep 2024 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X9z0AToR"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A507193424;
	Thu,  5 Sep 2024 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521792; cv=none; b=VYy27DWeWFENHRaJdB5ocjxmzkrk39bFRgoxDbNliapTZ1acZIb+ZWDDuFiON5MMJKqZjJLTBQNnH/k+K1meWyD007ozWLtst7Kg2WezXh0SPMjnwifeI6vsg9QGaegIVVdloENNJDRSfTmvZ7rhcHQbansFvtFCczBIByaEqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521792; c=relaxed/simple;
	bh=c3vslbBoFN4/FzsZhpF4QZxQivbp8+eO+2EsSCHtjgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ct1ztmNRHv3GdEMnO1RlCZIxkS32mV8rMIs8J7q/BCgiziBosT61RgaUCFX0e8jz/y+ruaLohLy9/K2UstjVVC6zL2XOIoDerQ/D+kNCBjAuDvt5nsD5onR6y66oM0LhlYzk8Uj2mLHmfN1XaXgGpNkheLkBFxhOGgDCb9Qp53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X9z0AToR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725521788;
	bh=c3vslbBoFN4/FzsZhpF4QZxQivbp8+eO+2EsSCHtjgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X9z0AToRkD7GBaeLb1ixP3IF7oD+sj20CnmRljf0gnNSunsk5J2Wlny+vsQLhGrQw
	 bEm+XoxFAz+3RyTVESwmF63v/8gqlu4Qb2xzl8F/aaEI3hroqC+Kh73TlYm/C9kR0C
	 Zi3o18H5STvZ5HRZlCJnvYA59pA1TkawEhh4wLOCrGFdbEQ/5G/tQI5ZWAnhKojV4J
	 yKwNhBpIzm6Qu956gyoUWJuMHoS/tFoPylbPk10eWKFhZvKeZxlnIaBmchntxQtWY7
	 U8OKtx19yKWloVNUDKWSgjjnpdjqZC0dBx9E937inBBlOnRDNPa8V00CtXlXbnwvtp
	 p04FchU9VH2+g==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F353B17E0F92;
	Thu,  5 Sep 2024 09:36:27 +0200 (CEST)
Date: Thu, 5 Sep 2024 09:36:23 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Mary Guillemard <mary.guillemard@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
 stable@vger.kernel.org, Steven Price <steven.price@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panthor: Restrict high priorities on group_create
Message-ID: <20240905093623.64b6963d@collabora.com>
In-Reply-To: <20240903144955.144278-2-mary.guillemard@collabora.com>
References: <20240903144955.144278-2-mary.guillemard@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Sep 2024 16:49:55 +0200
Mary Guillemard <mary.guillemard@collabora.com> wrote:

> We were allowing any users to create a high priority group without any
> permission checks. As a result, this was allowing possible denial of
> service.
> 
> We now only allow the DRM master or users with the CAP_SYS_NICE
> capability to set higher priorities than PANTHOR_GROUP_PRIORITY_MEDIUM.
> 
> As the sole user of that uAPI lives in Mesa and hardcode a value of
> MEDIUM [1], this should be safe to do.
> 
> Additionally, as those checks are performed at the ioctl level,
> panthor_group_create now only check for priority level validity.
> 
> [1]https://gitlab.freedesktop.org/mesa/mesa/-/blob/f390835074bdf162a63deb0311d1a6de527f9f89/src/gallium/drivers/panfrost/pan_csf.c#L1038
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Cc: stable@vger.kernel.org

Queued to drm-misc-fixes.

Thanks!

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c   | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_sched.c |  2 +-
>  include/uapi/drm/panthor_drm.h          |  6 +++++-
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index b5e7b919f241..34182f67136c 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -10,6 +10,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  
> +#include <drm/drm_auth.h>
>  #include <drm/drm_debugfs.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_exec.h>
> @@ -996,6 +997,24 @@ static int panthor_ioctl_group_destroy(struct drm_device *ddev, void *data,
>  	return panthor_group_destroy(pfile, args->group_handle);
>  }
>  
> +static int group_priority_permit(struct drm_file *file,
> +				 u8 priority)
> +{
> +	/* Ensure that priority is valid */
> +	if (priority > PANTHOR_GROUP_PRIORITY_HIGH)
> +		return -EINVAL;
> +
> +	/* Medium priority and below are always allowed */
> +	if (priority <= PANTHOR_GROUP_PRIORITY_MEDIUM)
> +		return 0;
> +
> +	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
> +	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
> +		return 0;
> +
> +	return -EACCES;
> +}
> +
>  static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
>  				      struct drm_file *file)
>  {
> @@ -1011,6 +1030,10 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
>  	if (ret)
>  		return ret;
>  
> +	ret = group_priority_permit(file, args->priority);
> +	if (ret)
> +		return ret;
> +
>  	ret = panthor_group_create(pfile, args, queue_args);
>  	if (ret >= 0) {
>  		args->group_handle = ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index c426a392b081..91a31b70c037 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3092,7 +3092,7 @@ int panthor_group_create(struct panthor_file *pfile,
>  	if (group_args->pad)
>  		return -EINVAL;
>  
> -	if (group_args->priority > PANTHOR_CSG_PRIORITY_HIGH)
> +	if (group_args->priority >= PANTHOR_CSG_PRIORITY_COUNT)
>  		return -EINVAL;
>  
>  	if ((group_args->compute_core_mask & ~ptdev->gpu_info.shader_present) ||
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 926b1deb1116..e23a7f9b0eac 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -692,7 +692,11 @@ enum drm_panthor_group_priority {
>  	/** @PANTHOR_GROUP_PRIORITY_MEDIUM: Medium priority group. */
>  	PANTHOR_GROUP_PRIORITY_MEDIUM,
>  
> -	/** @PANTHOR_GROUP_PRIORITY_HIGH: High priority group. */
> +	/**
> +	 * @PANTHOR_GROUP_PRIORITY_HIGH: High priority group.
> +	 *
> +	 * Requires CAP_SYS_NICE or DRM_MASTER.
> +	 */
>  	PANTHOR_GROUP_PRIORITY_HIGH,
>  };
>  
> 
> base-commit: a15710027afb40c7c1e352902fa5b8c949f021de


