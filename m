Return-Path: <stable+bounces-254136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGj1AOVAFGo3LQcAu9opvQ
	(envelope-from <stable+bounces-254136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:30:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2C5CA84C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE95A3006101
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56D8381B1B;
	Mon, 25 May 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Trf40pUi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0F1CAA7D;
	Mon, 25 May 2026 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712224; cv=none; b=aDXxfinIrbRAl6bmjVFM9VcpCTsK+4zhaOZxJlqRGNXgAVC6V3xBaLJpNvHG6Uyjz6OedqgXOKRFANaiJNtdP82TD+LdKQhd7OZAnIbM7XO1o6ZrakIU95W3siHk/3hlLPKCNuUh8TK1mz/Yf07LgKqAdumGOYeLB9YyKGq7iuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712224; c=relaxed/simple;
	bh=5bhexpmneKoYSiRbvSbWWrxgpggJapgRMGJ1yQI3xC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTTyzwx5zLFfJBecHK4AefB3flqej/fiClvjVXBg57Ww21IBjaBnPGCCpZ6sYKhfdSjYJVQ0Xk0IgA0LurBbFJgn9LMC7U0an1ToxLFS5WxJLCpHsBnsIxSc7BIT0T0HCKNH2VRIw8HFAcp4xBvIRuoRsk0KnQDQUX4wwaMJhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Trf40pUi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779712222; x=1811248222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5bhexpmneKoYSiRbvSbWWrxgpggJapgRMGJ1yQI3xC8=;
  b=Trf40pUi3gsjs4hLE/qJB/lr9+rBl1qmgZS4VawRI05eJrUEjj7g+AaJ
   WBHMVhpaY+i61RB0ghxRS5+BQDbxBiaUiPcSUfiXc+XzvMPwl1Hi1qVfr
   8B4otDm1dQ185xPwWY5rnCh2sieprlbnHVF/zByIFA6gVJVtgcYzXj/hs
   aXUY1rro/4Aiay2WCYhMCcTJ205iFK0vyWkyAPeEYlxmijb2rHB5UkjVu
   GajeuhU5zDeoxtOTHgV86Z8czbDk4c85hYrXd42VCDNgs+vxT0cRgK1Zk
   PNlJSp3B2vKTZGUmeaDh/dEbFkw0I0OmQaOKcx2q8n/fgE4/vgPY4ZACA
   w==;
X-CSE-ConnectionGUID: lQqbkE1aS+qYyyvLNZ7wRg==
X-CSE-MsgGUID: GPLnYn7rSX6uR9UytkFXjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="97960959"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="97960959"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 05:30:21 -0700
X-CSE-ConnectionGUID: wYfTuSWdQoe10+GbYDwJRA==
X-CSE-MsgGUID: DrvYC+pmQ4iok4w5G6cMPQ==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 05:30:18 -0700
Date: Mon, 25 May 2026 15:30:15 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
Message-ID: <ahRA17a7JR2PVOuJ@intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de>
 <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
 <ahBZ8nIqR4qESLZg@intel.com>
 <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de>
 <ahCw9zakihaGHLsN@intel.com>
 <428be9d9-06f7-4bcb-807b-d351101c3c4b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <428be9d9-06f7-4bcb-807b-d351101c3c4b@linux.intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-Spamd-Result: default: False [-1.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,iscas.ac.cn,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org,icenowy.me];
	TAGGED_FROM(0.00)[bounces-254136-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 94C2C5CA84C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:13:57AM +0200, Maarten Lankhorst wrote:
> Hey,
> 
> Den 2026-05-22 kl. 21:39, skrev Ville Syrjälä:
> > On Fri, May 22, 2026 at 03:43:26PM +0200, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 22.05.26 um 15:28 schrieb Ville Syrjälä:
> >> [...]
> >>>>>> But why does your HW use CRTC 1 in the first place.
> >>>>> Could be eg. the enabled outputs can't be driven with CRTC 0.
> >>>>>
> >>>>> I guess what you want to do is pick the first crtc from modesets[]
> >>>>> which is enabled. Or perhaps even "pick the Nth enabled crtc from
> >>>>> modesets[] based on the ioctl argument".
> >>>> The enable-status of each CRTC could change later on, which might lead
> >>>> to problems.
> >>> Sound like a locking issue if someone is changing the configuration
> >>> at the same time we're trying to do the vblank wait here.
> >>
> >> I mean that the connected outputs could change at a later point or we 
> >> could have multiple CRTCs in use. Today, someone in #intel-gfx reported 
> >> a problem with panning if multiple CRTCs are in use.
> >>
> >> Therefore picking a CRTC freely could be a problem. Let's say we 
> >> configure modes from one CRTC, but later wait/pan/flush with another 
> >> CRTC. I would not trust this to work correctly.
> >>
> >> Hence, my suggestion is to select a primary CRTC during the fbdev 
> >> client's probe and use it for all later operations until the next probe 
> >> happens.  All other CRTCs would mirror the primary one.
> > 
> > Actual mirroring may not be possible due to different modes supported
> > on each output. The whole multi-output fbdev thing in the drm fb helper
> > is kind of a hack that's rather hard to make work 100% sensibly.
> > 
> > For the panning possibly the only sensible thing is to use the max of
> > hdisplay/vdisplay of all the crtcs as the xres/yres so it's clear
> > how much things can actually be panned. Oh and tiled displays (assuming
> > we would actually want the fbdev stuff to tile correctly) make the
> > situation even more complicated. I think the current support for tiled
> > displays in the fb helper is semi-busted.´
> 
> I tested fbdev on a tiled DP-MST monitor.
> It works better than my kwin's wayland compositor, as it detects both tiles
> and presents a single image spanning both tiles.

IIRC we've occasionally seen cases where it picks a non-tiled mode
on the primary connector, and also still enables the second tile.

> Kwin sees both as separate
> monitors.
> 
> I still see vertical tearing between both tiles, so it would be nice if
> intel/display would support atomic updates for both crtc's directly.
> 
> The code's already there for bigjoiner, just needs to do the same for
> tile joiner updates when all tiled crtc's are in the atomic update.

We don't have any special code for atomic updates with joiner
currently. It just happens to work most of the time.

With joiner the pipes will be in sync/phase, so that helps a bit.
But we do also try to make the pipes in sync/phase also for tiled
display via the use of the port sync. So if you see a difference
in tearing between joiner vs. tiled then that likely means the
problem is in userspace (as in it submits separate commits for
each tile).

I have occasionally pondered about hiding the tiled display stuff
completely from userspace and handling it in the kernel the same
was as joiner. But the problem is that we'd also need to cook up
a new EDID for the display that combines both tiles, and we'd
still need the second connector to be enabled internally (and 
hide that fact from userspace). None of that code exists
currently and wouldn't be entirely trivial to implement.

-- 
Ville Syrjälä
Intel

