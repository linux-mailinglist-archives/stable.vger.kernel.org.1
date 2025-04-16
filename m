Return-Path: <stable+bounces-132872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A54A90798
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADBF190748F
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CA2189BB5;
	Wed, 16 Apr 2025 15:23:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from animx.eu.org (tn-76-7-174-50.sta.embarqhsd.net [76.7.174.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695E207A06
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.7.174.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816990; cv=none; b=ownvTuGmY28mpVU4BBkVZwXjeNI20l7ob4y4hFGerOSOxoECKPEDcEssbYTkMJ/WxKVIv2BiETP8rq4UVhuhFNIs2YbLetdMn/uZba2cPkO/KVnykaKxMC3jBOS7HDoi2P7QZ++AKWA4aIzdO4nTmNiRtLwoUkbsRvO67rNK8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816990; c=relaxed/simple;
	bh=Ky5tr0vp97oSEY3lXlimmD9kzeH9ixC1EB/Dv9GqclI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4choZAqgXivgbbSd3PS/fcfVTaemzDdJe9aXl5d2o9lcWgggA3mgMO4gGtB6d4u7RW7L4e4uxS80wj1XcOHR5GyGzOOpJn60m3/16KNFg0ShfeYMJMyq2nK+ZgXblMQp4eq6CtuOgIBhBlebVMSPqV41EG0sU7BjMr/gNi7HYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=animx.eu.org; spf=pass smtp.mailfrom=animx.eu.org; arc=none smtp.client-ip=76.7.174.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=animx.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=animx.eu.org
Received: from wakko by animx.eu.org with local 
	id 1u54bA-0002oe-I5;
	Wed, 16 Apr 2025 11:22:48 -0400
Date: Wed, 16 Apr 2025 11:22:48 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, jfalempe@redhat.com,
	dri-devel@lists.freedesktop.org, ???????????? <afmerlord@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/mgag200: Fix value in <VBLKSTR> register
Message-ID: <Z//LSBwuoc6Hf3zG@animx.eu.org>
References: <20250416083847.51764-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416083847.51764-1-tzimmermann@suse.de>

Thomas Zimmermann wrote:
> Fix an off-by-one error when setting the vblanking start in
> <VBLKSTR>. Commit d6460bd52c27 ("drm/mgag200: Add dedicated
> variables for blanking fields") switched the value from
> crtc_vdisplay to crtc_vblank_start, which DRM helpers copy
> from the former. The commit missed to subtract one though.

Applied to 6.14.2.  BMC and external monitor works as expected.

Thank you.

> Reported-by: Wakko Warner <wakko@animx.eu.org>
> Closes: https://lore.kernel.org/dri-devel/CAMwc25rKPKooaSp85zDq2eh-9q4UPZD=RqSDBRp1fAagDnmRmA@mail.gmail.com/
> Reported-by: ???????????? <afmerlord@gmail.com>
> Closes: https://lore.kernel.org/all/5b193b75-40b1-4342-a16a-ae9fc62f245a@gmail.com/
> Closes: https://bbs.archlinux.org/viewtopic.php?id=303819
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: d6460bd52c27 ("drm/mgag200: Add dedicated variables for blanking fields")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.12+
> ---
>  drivers/gpu/drm/mgag200/mgag200_mode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index fb71658c3117..6067d08aeee3 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -223,7 +223,7 @@ void mgag200_set_mode_regs(struct mga_device *mdev, const struct drm_display_mod
>  	vsyncstr = mode->crtc_vsync_start - 1;
>  	vsyncend = mode->crtc_vsync_end - 1;
>  	vtotal = mode->crtc_vtotal - 2;
> -	vblkstr = mode->crtc_vblank_start;
> +	vblkstr = mode->crtc_vblank_start - 1;
>  	vblkend = vtotal + 1;
>  
>  	linecomp = vdispend;
> -- 
> 2.49.0
> 
-- 
 Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
 million bugs.

