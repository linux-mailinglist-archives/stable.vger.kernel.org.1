Return-Path: <stable+bounces-253794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEVnDsZiEGphWwYAu9opvQ
	(envelope-from <stable+bounces-253794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:05:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B44C5B5CFD
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F100F3022679
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECF3AE188;
	Fri, 22 May 2026 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jp5MlugV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4873A4524;
	Fri, 22 May 2026 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456508; cv=none; b=ZzhnqIn75zokVoO/H6NGqv7Y/BKm91qUv2dKvWbzXXSGl5JIE7kd2jDO4LCWTvDlyzWFgTAxANggCUQ6mXPt2UckUi5kVh5KxDu7kV9s1RZ+oHnSCchspTbt7kLY5vWSno7UGv4ztyJIWEoB8Dze3ECCl9UhY83nIHtnO4xpwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456508; c=relaxed/simple;
	bh=vMCnx8a+02wpW1v2x3Gaju1pVGV683eSmQkhfp/4j3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jViV1GusmUvcfOSWPSF+bTpd/AigyE0IbWgd89rZZu5pgKguH4Ga541M/nKBpfXlXs2pmmn8E072lAvNOGP/WiRrrGbkxf5IUANuegkzAvFah2OTPp4JNDJYGMHCzgCB8uACZLO48v5fu1cp5XW/RQQjI38nYLG3M57tPzCN3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jp5MlugV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779456506; x=1810992506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vMCnx8a+02wpW1v2x3Gaju1pVGV683eSmQkhfp/4j3U=;
  b=Jp5MlugV/BBp62w6fFZ7ISWyUR2bJZqFZWZ2m6M3QjCXU7ovamz5M6iW
   PWdr7uskW0YtrjPUJaP7/s7W6LtWforpw/nY2ThyeVuLuMrGFoSZmk/9e
   2uRkQ9zamuNI+fN9avVwEWiL+6TEBdPqwlJBtmFK/tGV7ydU98h7EnDxp
   X5ROz6ZwnWYN3Zbzo1lgAy4MH1aE6fWwBdMezZnU4nKc7lpmWt+c3hC+5
   UNkgkHRDIFnUIZSzPuaP5mCZUTlI1lkF/Jh5DEq6q8TTuGkcL6Pj8JTnc
   zvws7v0gkgY1oDuBMft+d5c85fLCyA7hCasmpmfs6hWXzLydc7m3z0DUc
   Q==;
X-CSE-ConnectionGUID: 7vlGKRXwRbCjs8EzuGwa+A==
X-CSE-MsgGUID: 3kpDVoEXR/m/uQpJvT+Ayg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="80236689"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="80236689"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 06:28:25 -0700
X-CSE-ConnectionGUID: q+1wd2RyQXCYQ84bgdaVhA==
X-CSE-MsgGUID: LG5P5DgUT5uXTJP5dpOaXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="241143308"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.187])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 06:28:22 -0700
Date: Fri, 22 May 2026 16:28:18 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
Message-ID: <ahBZ8nIqR4qESLZg@intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de>
 <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-Spamd-Result: default: False [-1.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org,icenowy.me];
	TAGGED_FROM(0.00)[bounces-253794-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,iscas.ac.cn:email,suse.com:url,bootlin.com:url]
X-Rspamd-Queue-Id: 3B44C5B5CFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 03:24:05PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 22.05.26 um 15:13 schrieb Ville Syrjälä:
> > On Fri, May 22, 2026 at 01:55:59PM +0200, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 19.05.26 um 11:24 schrieb Icenowy Zheng:
> >>> Currently the implementaion of drm_client_modeset_wait_for_vblank()
> >>> assumes drm_vblank_get() will fail when the CRTC isn't active. However
> >>> it seems that this is not true, and running fbcon on a device with the
> >>> first CRTC inactive will lead to kernel warning in some cases (which
> >>> could be reproduced with the loongson driver).
> >>>
> >>> Change the implementation to add a check for the active state (atomic) /
> >>> enabled state (non-atomic) before calling drm_vblank_get(). As the
> >>> assumption of drm_vblank_get() failing for inactive CRTC isn't met, the
> >>> error status of drm_vblank_get() can now be exported too.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
> >>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> >>> ---
> >>>    drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
> >>>    1 file changed, 11 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> >>> index bb49b8361271a..1b03bf351256e 100644
> >>> --- a/drivers/gpu/drm/drm_client_modeset.c
> >>> +++ b/drivers/gpu/drm/drm_client_modeset.c
> >>> @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
> >>>    {
> >>>    	struct drm_device *dev = client->dev;
> >>>    	struct drm_crtc *crtc;
> >>> -	int ret;
> >>> +	int ret = 0;
> >>>    
> >>>    	/*
> >>>    	 * Rate-limit update frequency to vblank. If there's a DRM master
> >>> @@ -1326,15 +1326,24 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
> >>>    	 * Only wait for a vblank event if the CRTC is enabled, otherwise
> >>>    	 * just don't do anything, not even report an error.
> >>>    	 */
> >>> +	if (drm_drv_uses_atomic_modeset(dev)) {
> >>> +		if (!crtc->state || !crtc->state->active)
> >>> +			goto out;
> >>> +	} else {
> >>> +		if (!crtc->enabled)
> >>> +			goto out;
> >>> +	}
> >>> +
> >> This part is good.
> > Locking is missing.
> 
> Ok
> 
> >
> >>>    	ret = drm_crtc_vblank_get(crtc);
> >>>    	if (!ret) {
> >>>    		drm_crtc_wait_one_vblank(crtc);
> >>>    		drm_crtc_vblank_put(crtc);
> >>>    	}
> >>>    
> >>> +out:
> >>>    	drm_master_internal_release(dev);
> >>>    
> >>> -	return 0;
> >>> +	return ret;
> >> But this isn't. There can be CRTCs without any vblank at all. We still
> >> want to fail silently for them. So we still have to return 0 here.
> >>
> >> Having set this, fixing this helper is only partially what you want.
> >> Since your device has vblanking, the emulation should check on the
> >> correct CRTC. IOW you need to pass the right CRTC index at
> >>
> >> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L237
> >> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L920
> >>
> >> I'm not quite sure how to support this. The CRTC is under
> >> fb_helper->client.modesets.crtc. You'd have to figure out which is the
> >> relevant one and use that. But that's also not so great, as fbdev ioctls
> >> only support CRTC 0. Doing internal re-mappings only complicates matters.
> >>
> >> But why does your HW use CRTC 1 in the first place.
> > Could be eg. the enabled outputs can't be driven with CRTC 0.
> >
> > I guess what you want to do is pick the first crtc from modesets[]
> > which is enabled. Or perhaps even "pick the Nth enabled crtc from
> > modesets[] based on the ioctl argument".
> 
> The enable-status of each CRTC could change later on, which might lead 
> to problems.

Sound like a locking issue if someone is changing the configuration
at the same time we're trying to do the vblank wait here.

> Picking the one CRTC/output with the lowest spec and 
> mirroring it to the others might work. This CRTC would then be the one 
> to wait for.
> 
> Best regards
> Thomas
> 
> >
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> 

-- 
Ville Syrjälä
Intel

