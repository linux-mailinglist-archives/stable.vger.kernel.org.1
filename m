Return-Path: <stable+bounces-83369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD17998D54
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7912B2A5AD
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF711CBEBC;
	Thu, 10 Oct 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mN+aBLcq"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F820DD2;
	Thu, 10 Oct 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574020; cv=none; b=VsnCaTsVIoGRLOgqUYJHwqGtmyc4mRTzXifVQ6LiHiaU6P7wGt+30CEsmikf3Vw5NiOc3r23HjftBCRNUWqNLNv0ZHD2Fm700asMeO4S3ouH8oSsGBbXvV+FcNKM8rjXW+5D68Vdk4MnydjRLqJQZ06Z05PMjkPU13jWJbaH4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574020; c=relaxed/simple;
	bh=ygDroZHA1j7JZxjtFU44rxkjVqjCtctM1ElAx6dSsDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVPV/luGBJ/S8Bz2VKL/WGD6IzAQ1dtSJV5Oi8282qh1/KYQmva0wtxV4FyM2dc9AQHIo8hXy8uEU4h5ZtUdbov9vIX/37adbx85v+pDrEZtoEwj+BH+vFd8Zr7Kh4IEnyIIE4yY3aseGJaydYIdsLso8RmAIRu/j5l4bn08bho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mN+aBLcq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14806FF807;
	Thu, 10 Oct 2024 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728574010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzE9jT9P4k/XrNuOOWoFuNHxaK3It9F/Ncn4nUJHRtA=;
	b=mN+aBLcqL0fC5B2Nh/GqSp9zUw3YoO09GtFyfxct1Ky77mVi1M+Jf0Q4JE3C9nSHju8iQJ
	yQiCJiwoYVvAbusHJNh93Kz9QIhhOsXMnOZBpI/Adoe7eTLXLhH7l8Ecbuo6Wths7iPsCc
	+p97nw7y+I3U7jXe5oWcYkPox0y7nIuaUWJ95aouJ5SwTIrvjUDckluKRyHmSruPnq/F7o
	kQrKswXvWxAmc4a54zLQORhIKT+p9VQCyRk+TD/00+FVuZ8GFCBYFqY3Ai4tNPzrm3vIdY
	R/VaX75Fn8FFJIRc0ivySGkGaR4PvTnK+gK0lhaj1dIw7FePzm8IOGikrPDmBQ==
Date: Thu, 10 Oct 2024 17:26:47 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, Stefan Agner <stefan@agner.ch>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	stable@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vblank: Require a driver register vblank support for
 0 or all CRTCs
Message-ID: <ZwfyN3uwfODqcw4U@louis-chauvet-laptop>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
	dri-devel@lists.freedesktop.org, Stefan Agner <stefan@agner.ch>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	stable@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20240927203946.695934-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927203946.695934-2-lyude@redhat.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 27/09/24 - 16:39, Lyude Paul a écrit :
> Currently, there's nothing actually stopping a driver from only registering
> vblank support for some of it's CRTCs and not for others. As far as I can
> tell, this isn't really defined behavior on the C side of things - as the
> documentation explicitly mentions to not use drm_vblank_init() if you don't
> have vblank support - since DRM then steps in and adds its own vblank
> emulation implementation.
> 
> So, let's fix this edge case and check to make sure it's all or none.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 3ed4351a83ca ("drm: Extract drm_vblank.[hc]")
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v4.13+
> ---
>  drivers/gpu/drm/drm_vblank.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 94e45ed6869d0..4d00937e8ca2e 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -525,9 +525,19 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
>   */
>  int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
>  {
> +	struct drm_crtc *crtc;
>  	int ret;
>  	unsigned int i;
>  
> +	// Confirm that the required vblank functions have been filled out for all CRTCS
> +	drm_for_each_crtc(crtc, dev) {
> +		if (!crtc->funcs->enable_vblank || !crtc->funcs->disable_vblank) {
> +			drm_err(dev, "CRTC vblank functions not initialized for %s, abort\n",
> +				crtc->name);
> +			return -EINVAL;
> +		}
> +	}
> +

Hi,

I noticed that the kernel bot reported an issue with VKMS and this patch.

I did not take the time to reproduce the issue, but it may come from the 
fact that VKMS call drm_vblank_init before calling 
drmm_crtc_init_with_planes [1]. I don't see anything in the documentation 
that requires the CRTC to be initialized before the vblank, is it a change 
of the API or an issue in VKMS since 2018 [2]?

Anyway, if this is a requirement, can you explain it in the 
drm_vblank_init documentation?

Thanks,
Louis Chauvet

[1]:https://elixir.bootlin.com/linux/v6.11.2/source/drivers/gpu/drm/vkms/vkms_drv.c#L209
[2]:https://lore.kernel.org/all/5d9ca7b3884c1995bd4a983b1d2ff1b840eb7f1a.1531402095.git.rodrigosiqueiramelo@gmail.com/

>  	spin_lock_init(&dev->vbl_lock);
>  	spin_lock_init(&dev->vblank_time_lock);
>  
> 
> base-commit: 22512c3ee0f47faab5def71c4453638923c62522
> -- 
> 2.46.1
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

