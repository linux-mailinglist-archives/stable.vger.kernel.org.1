Return-Path: <stable+bounces-223074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJwJL3I5qGkTqgAAu9opvQ
	(envelope-from <stable+bounces-223074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:53:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2668F200C23
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D986A3083E04
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46739FCBC;
	Wed,  4 Mar 2026 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQocogmq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1F312837
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632334; cv=none; b=RFMp/XUMveoWvdIQedf2mEbgQVRQX7ZlyFyMx7BL9OmjT+3dtD9QNirQV0L1PjQ3fRBR1jZydlB7IbgnxIphiZKh5AGOYapMbBFgv/RdnOwpOMKMAwBHycXCW8iavT7alyKk1KHmKrQ4Ok8Hc9SyBCEkJQY0eOPFmYjgPG7ji6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632334; c=relaxed/simple;
	bh=YFL3qE0wQPE5w3jx8D26+umnGo/HtN8DLl39vbJd1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stQkuErmQns6Ljusj0ZDBEJW5TX81nwqR90ow4YM00AomopLV6j17IfPW2ddFF6Sm7DXJICw2RuriQX5YX3Xx+F7s7Gkv2AMfT4PSSuxmpuVnWTVOpkP2B8/Bu6EVmlqkpn0AQLqrG2bXyLMfrlIj+YfM/2QcFNkbTJdg7mAQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQocogmq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772632332; x=1804168332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YFL3qE0wQPE5w3jx8D26+umnGo/HtN8DLl39vbJd1Dg=;
  b=SQocogmq8XWdE5YSy3fNfS5wF3ebmqqnpHsdvzRWAGGkiDw7soe2u5xb
   x4oqAuuHCeKcIDBK72Hpwd6MIMOOlCeKqcVz1p4jZnojxZAN6/dcq/rGM
   4ccb9jOieVQouWfKZSOYfZpQxMWcc2O0RI0b/zGxUjV/Fe8x7TF9IERSR
   xIyV3hMdKO7CaqNLxy8L621fB37Sx053OKlQtqabssK+pgL63Sb9UuqNy
   K34RO4/+aqUkL35TV6F7oIjc+IwPK+SYx9pvz9Px6aj6Yp5Vv+7e+1Hwr
   NX9IFjcAw4HN3LWXevs/eBDkptkq8d4mNCZ39nT4dSevSOHw3kCorsdyC
   Q==;
X-CSE-ConnectionGUID: 9AJi2w0fRvC/5Z71r9EqeQ==
X-CSE-MsgGUID: kClYdk8aS6+9hBhmzBywpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="61265256"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="61265256"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 05:52:12 -0800
X-CSE-ConnectionGUID: UcAByEEdRICJwEx3wRRWSw==
X-CSE-MsgGUID: R97t88v8TOu3B1AZVZSqgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="256228923"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.149])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 05:52:09 -0800
Date: Wed, 4 Mar 2026 15:52:07 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH] drm/i915/vrr: Configure VRR timings after enabling
 TRANS_DDI_FUNC_CTL
Message-ID: <aag5B8l05c696dGr@intel.com>
References: <20260303095414.4331-1-ville.syrjala@linux.intel.com>
 <53aa591f-7245-4b4b-b13a-dfa050134000@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53aa591f-7245-4b4b-b13a-dfa050134000@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-Rspamd-Queue-Id: 2668F200C23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223074-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,gitlab.freedesktop.org:url]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:36:12AM +0530, Nautiyal, Ankit K wrote:
> 
> On 3/3/2026 3:24 PM, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >
> > Apparently ICL may hang with an MCE if we write TRANS_VRR_VMAX/FLIPLINE
> > before enabling TRANS_DDI_FUNC_CTL.
> >
> > Personally I was only able to reproduce a hang (on an Dell XPS 7390
> > 2-in-1) with an external display connected via a dock using a dodgy
> > type-C cable that made the link training fail. After the failed
> > link training the machine would hang. TGL seemed immune to the
> > problem for whatever reason.
> >
> > BSpec does tell us to configure VRR after enabling TRANS_DDI_FUNC_CTL
> > as well. The DMC firmware also does the VRR restore in two stages:
> > - first stage seems to be unconditional and includes TRANS_VRR_CTL
> >    and a few other VRR registers, among other things
> > - second stage is conditional on the DDI being enabled,
> >    and includes TRANS_DDI_FUNC_CTL and TRANS_VRR_VMAX/VMIN/FLIPLINE,
> >    among other things
> >
> > So let's reorder the steps to match to avoid the hang, and
> > toss in an extra WARN to make sure we don't screw this up later.
> >
> > BSpec: 22243
> > Cc: stable@vger.kernel.org
> > Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> > Reported-by: Benjamin Tissoires <bentiss@kernel.org>
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15777
> > Tested-by: Benjamin Tissoires <bentiss@kernel.org>
> > Fixes: dda7dcd9da73 ("drm/i915/vrr: Use fixed timings for platforms that support VRR")
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> You are right. VRR timing registers are indeed supposed to be programmed 
> after TRANS_DDI_FUNC_CTL.
> 
> Thanks for catching this, Ville, and thanks Benjamin for the bisection.
> 
> Change looks good to me.
> 
> Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

Pushed.

Thanks for the review, and the bug report.

> 
> 
> > ---
> >   drivers/gpu/drm/i915/display/intel_display.c |  1 -
> >   drivers/gpu/drm/i915/display/intel_vrr.c     | 14 ++++++++++++++
> >   2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> > index 27354585ba92..138ee7dd1977 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -1637,7 +1637,6 @@ static void hsw_configure_cpu_transcoder(const struct intel_crtc_state *crtc_sta
> >   	}
> >   
> >   	intel_set_transcoder_timings(crtc_state);
> > -	intel_vrr_set_transcoder_timings(crtc_state);
> >   
> >   	if (cpu_transcoder != TRANSCODER_EDP)
> >   		intel_de_write(display, TRANS_MULT(display, cpu_transcoder),
> > diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
> > index 00ca76dbdd6c..8a957804cb97 100644
> > --- a/drivers/gpu/drm/i915/display/intel_vrr.c
> > +++ b/drivers/gpu/drm/i915/display/intel_vrr.c
> > @@ -599,6 +599,18 @@ void intel_vrr_set_transcoder_timings(const struct intel_crtc_state *crtc_state)
> >   	if (!HAS_VRR(display))
> >   		return;
> >   
> > +	/*
> > +	 * Bspec says:
> > +	 * "(note: VRR needs to be programmed after
> > +	 *  TRANS_DDI_FUNC_CTL and before TRANS_CONF)."
> > +	 *
> > +	 * In practice it turns out that ICL can hang if
> > +	 * TRANS_VRR_VMAX/FLIPLINE are written before
> > +	 * enabling TRANS_DDI_FUNC_CTL.
> > +	 */
> > +	drm_WARN_ON(display->drm,
> > +		    !(intel_de_read(display, TRANS_DDI_FUNC_CTL(display, cpu_transcoder)) & TRANS_DDI_FUNC_ENABLE));
> > +
> >   	/*
> >   	 * This bit seems to have two meanings depending on the platform:
> >   	 * TGL: generate VRR "safe window" for DSB vblank waits
> > @@ -961,6 +973,8 @@ void intel_vrr_transcoder_enable(const struct intel_crtc_state *crtc_state)
> >   {
> >   	struct intel_display *display = to_intel_display(crtc_state);
> >   
> > +	intel_vrr_set_transcoder_timings(crtc_state);
> > +
> >   	if (!intel_vrr_possible(crtc_state))
> >   		return;
> >   

-- 
Ville Syrjälä
Intel

