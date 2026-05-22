Return-Path: <stable+bounces-253838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM6pOg6xEGpWcgYAu9opvQ
	(envelope-from <stable+bounces-253838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:39:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F975B980B
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BAD430060B0
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 19:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEBB3750BC;
	Fri, 22 May 2026 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwfN5X0e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08AC349CCB;
	Fri, 22 May 2026 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478793; cv=none; b=IuwBRIUrtC7iezod0J/LtTlyXORsTAvRu/AngAZhZSuodJ/jpHFP8hz1Rc7TdNglkhRcLxVKxpRQzU7iJmfe9WtIm7Hl+3sdU0fK8V3H7p8F4LdauHUxsomv5XdWAccdgKDnjhIZeULyUFZQrRu18rUkYw1fnvJdW3nJ2iLI+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478793; c=relaxed/simple;
	bh=8qODzv8/snRPyzB4ZYUerxS720pTvueUQIu6KbHQAAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne77UiLkTSUq26M/KWqFt0mpWO06TIheOvTzezrCRd20fdzBTW9cmWUja1Big4tburwYUyqaLQsyt7cO3l2K7GVp6/vXzxW1N7VSXk4TAfW705EGU94YMAe6gjUyRRbjTdl64Lk2v7PJk8MbkBp8XrjxnPJvN328g+/gqd+uLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwfN5X0e; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779478791; x=1811014791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8qODzv8/snRPyzB4ZYUerxS720pTvueUQIu6KbHQAAU=;
  b=RwfN5X0e2wJPc2cm9Z8uMafbuIjrOEPd0PUJEcwhyoZ2VXQmj8NKObTb
   SE/cWC9mFYUeDl9eUh1+fM2keR9wetH0+YC9pbyQwV7eUKukZnASibPTL
   KlebNyOFqJ1IeCiYf7MwJOuVdbiammQ2PLcuMRq0G1qJhRs8F5l10q/av
   yn1bPQZxUW+FTCqubAKIzJKRwjN2jfa+IklHWzM+FapO37gwG2/oHWiMA
   Jv39KTM1G8ZEoR16nvKHI4uZ2X6Xh0vH1ZpHz+tHtAGInJelZAWYKk3RL
   miUzie0CWcT7eG7d6kC9JVu2keydTLJD4ytZVuPBm+QKJwc01WICTYq8x
   w==;
X-CSE-ConnectionGUID: u+Ihy6rRRnK/ItPsqmL9vw==
X-CSE-MsgGUID: dLKaRKmZSFyJui5kHg2C5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="105876358"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; 
   d="scan'208";a="105876358"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 12:39:42 -0700
X-CSE-ConnectionGUID: UzTcu6xHSnSHnGQhVSGzUw==
X-CSE-MsgGUID: GKIoeDDuTG2BQchHMPJ/8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; 
   d="scan'208";a="279105916"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 12:39:40 -0700
Date: Fri, 22 May 2026 22:39:35 +0300
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
Message-ID: <ahCw9zakihaGHLsN@intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de>
 <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
 <ahBZ8nIqR4qESLZg@intel.com>
 <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-Spamd-Result: default: False [-1.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org,icenowy.me];
	TAGGED_FROM(0.00)[bounces-253838-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: E4F975B980B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 03:43:26PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 22.05.26 um 15:28 schrieb Ville Syrjälä:
> [...]
> >>>> But why does your HW use CRTC 1 in the first place.
> >>> Could be eg. the enabled outputs can't be driven with CRTC 0.
> >>>
> >>> I guess what you want to do is pick the first crtc from modesets[]
> >>> which is enabled. Or perhaps even "pick the Nth enabled crtc from
> >>> modesets[] based on the ioctl argument".
> >> The enable-status of each CRTC could change later on, which might lead
> >> to problems.
> > Sound like a locking issue if someone is changing the configuration
> > at the same time we're trying to do the vblank wait here.
> 
> I mean that the connected outputs could change at a later point or we 
> could have multiple CRTCs in use. Today, someone in #intel-gfx reported 
> a problem with panning if multiple CRTCs are in use.
> 
> Therefore picking a CRTC freely could be a problem. Let's say we 
> configure modes from one CRTC, but later wait/pan/flush with another 
> CRTC. I would not trust this to work correctly.
> 
> Hence, my suggestion is to select a primary CRTC during the fbdev 
> client's probe and use it for all later operations until the next probe 
> happens.  All other CRTCs would mirror the primary one.

Actual mirroring may not be possible due to different modes supported
on each output. The whole multi-output fbdev thing in the drm fb helper
is kind of a hack that's rather hard to make work 100% sensibly.

For the panning possibly the only sensible thing is to use the max of
hdisplay/vdisplay of all the crtcs as the xres/yres so it's clear
how much things can actually be panned. Oh and tiled displays (assuming
we would actually want the fbdev stuff to tile correctly) make the
situation even more complicated. I think the current support for tiled
displays in the fb helper is semi-busted.

> Best regards
> Thomas
> 
> 
> >
> >> Picking the one CRTC/output with the lowest spec and
> >> mirroring it to the others might work. This CRTC would then be the one
> >> to wait for.
> >>
> >> Best regards
> >> Thomas
> >>
> >> -- 
> >> --
> >> Thomas Zimmermann
> >> Graphics Driver Developer
> >> SUSE Software Solutions Germany GmbH
> >> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> >> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> >>
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

