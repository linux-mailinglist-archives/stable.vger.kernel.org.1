Return-Path: <stable+bounces-253791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SArMDkVYEGocWgYAu9opvQ
	(envelope-from <stable+bounces-253791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:21:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C945B509E
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38B530CA1E6
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2AB39989D;
	Fri, 22 May 2026 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hX9VqTDl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2A39D3C1;
	Fri, 22 May 2026 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455606; cv=none; b=DicnG6Ff+qpFLXijBA9J23j7rllzxz63oIym0qVIezXHXf6JLh50ED3AXp2dnaA/0JT9Eb+A/MjqpiSesB+w6CgFyvXiIDp+WwkaqcboS6UjKSe+3ocUtSlv/NbiTTN/TmoF0WB9XvdKX+KILe74lLLylAPdN7StoDVVn1GKWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455606; c=relaxed/simple;
	bh=XGUCGxnEA4kj79DA+8/vsKuNs1lZvHw/84Eetaa9NPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyBawXRnRtVXQ+PKMjBlUGDBjJMAPweiGVhgOkzIxaoGxlxajBWiv9kM4rA/OBceXiTCwpziQjxGZU9ShgSognlZ1+zqISMfiLsOf1Z8QrQGE4tqOyXxUT3Opxy7L0B11pZUmR8bwCxvFRiJHLwAKp/LkhsCkhkcjsTW76YuhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hX9VqTDl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779455603; x=1810991603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XGUCGxnEA4kj79DA+8/vsKuNs1lZvHw/84Eetaa9NPI=;
  b=hX9VqTDlscuAD/lg3qzifERxVaOfFQWF0LM6IpV8aVY1R/iMBAKKgKxL
   SFB0TzMv4FgWRZf5TQlnqEpIqvEqMlxXl/Rl/VPOwcc2TXZmCxcB0DSkJ
   3iWvZ+KVG+HxPmmU+3m2KX6YpIpGHAwCTcxBYLOALlIqfG6KHsVjPehUO
   6hYOB4+4Rhkf/10O2dlpp0sn4FZrL2go3KlVgFiraPKG+gUoivvhKrbSD
   ubgkGY2tuwJG3CxRyAvqVkblGHKQh6dYZy74cplN2nv+Q8gP8ClRyMdiH
   ANh8Gdft6iD+bXua0OACaj88xuD9TjBV0qp3RThx9SA7/ffePak8be5Qp
   A==;
X-CSE-ConnectionGUID: 6E+wUM3TQyWEjlrTn3W64w==
X-CSE-MsgGUID: zqFhqZWCT/mOxPWggMLysQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="80353687"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="80353687"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 06:13:21 -0700
X-CSE-ConnectionGUID: HFH30V+WS5O0kcta+kn0sw==
X-CSE-MsgGUID: FB9kCSnSRSmU+NtgPu13lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="236689704"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.187])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 06:13:18 -0700
Date: Fri, 22 May 2026 16:13:15 +0300
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
Message-ID: <ahBWayIcQUHuAt4i@intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee86cb43-e5df-4946-a957-931a73dde752@suse.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-Spamd-Result: default: False [-1.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org,icenowy.me];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253791-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 63C945B509E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 01:55:59PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 19.05.26 um 11:24 schrieb Icenowy Zheng:
> > Currently the implementaion of drm_client_modeset_wait_for_vblank()
> > assumes drm_vblank_get() will fail when the CRTC isn't active. However
> > it seems that this is not true, and running fbcon on a device with the
> > first CRTC inactive will lead to kernel warning in some cases (which
> > could be reproduced with the loongson driver).
> >
> > Change the implementation to add a check for the active state (atomic) /
> > enabled state (non-atomic) before calling drm_vblank_get(). As the
> > assumption of drm_vblank_get() failing for inactive CRTC isn't met, the
> > error status of drm_vblank_get() can now be exported too.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > ---
> >   drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> > index bb49b8361271a..1b03bf351256e 100644
> > --- a/drivers/gpu/drm/drm_client_modeset.c
> > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
> >   {
> >   	struct drm_device *dev = client->dev;
> >   	struct drm_crtc *crtc;
> > -	int ret;
> > +	int ret = 0;
> >   
> >   	/*
> >   	 * Rate-limit update frequency to vblank. If there's a DRM master
> > @@ -1326,15 +1326,24 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
> >   	 * Only wait for a vblank event if the CRTC is enabled, otherwise
> >   	 * just don't do anything, not even report an error.
> >   	 */
> > +	if (drm_drv_uses_atomic_modeset(dev)) {
> > +		if (!crtc->state || !crtc->state->active)
> > +			goto out;
> > +	} else {
> > +		if (!crtc->enabled)
> > +			goto out;
> > +	}
> > +
> 
> This part is good.

Locking is missing.

> 
> >   	ret = drm_crtc_vblank_get(crtc);
> >   	if (!ret) {
> >   		drm_crtc_wait_one_vblank(crtc);
> >   		drm_crtc_vblank_put(crtc);
> >   	}
> >   
> > +out:
> >   	drm_master_internal_release(dev);
> >   
> > -	return 0;
> > +	return ret;
> 
> But this isn't. There can be CRTCs without any vblank at all. We still 
> want to fail silently for them. So we still have to return 0 here.
> 
> Having set this, fixing this helper is only partially what you want. 
> Since your device has vblanking, the emulation should check on the 
> correct CRTC. IOW you need to pass the right CRTC index at
> 
> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L237
> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L920
> 
> I'm not quite sure how to support this. The CRTC is under 
> fb_helper->client.modesets.crtc. You'd have to figure out which is the 
> relevant one and use that. But that's also not so great, as fbdev ioctls 
> only support CRTC 0. Doing internal re-mappings only complicates matters.
> 
> But why does your HW use CRTC 1 in the first place.

Could be eg. the enabled outputs can't be driven with CRTC 0.

I guess what you want to do is pick the first crtc from modesets[]
which is enabled. Or perhaps even "pick the Nth enabled crtc from
modesets[] based on the ioctl argument".

-- 
Ville Syrjälä
Intel

