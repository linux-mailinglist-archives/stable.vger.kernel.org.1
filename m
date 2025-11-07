Return-Path: <stable+bounces-192729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1316C4021A
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 14:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641663B465E
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7C2C11F2;
	Fri,  7 Nov 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oLFZycxD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC92DE70B
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522388; cv=none; b=MkXbY4dnxY7t34z87JM4s0as2oC1Yj8E9ybzfHEjzi+Elk1cJx+41RQLox7/prU5YEpS2Yo9Yn/AphhZB9OdSfJ/lmUDtm11NxMWemduPw6gcmi9794eqyvKD5HLrQH7oHvudrDyBpoVd7v215TcxUNPcavTxj+3F6Az6kc6IkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522388; c=relaxed/simple;
	bh=6cEx4exg+H6IENUejJJ0g4Gra18SrKuDLTQ+PeY6DPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxG/FISzBOKefmlGPJ/gIJ7gK7h4PA6MlXsOmN3vrkvU9C5naTE6mOvQSHK5Odt3KAMD4zcuf1esuC/ACdjSI160bZGj16gK0DkIV+/J+cddH4aIPKPG4yaPmF5jIn3DIEnN4tMpWLvWF1v/I2hWEXCDBQG9VWVIZSp93zOineA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oLFZycxD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762522386; x=1794058386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6cEx4exg+H6IENUejJJ0g4Gra18SrKuDLTQ+PeY6DPY=;
  b=oLFZycxDAr5lOebAyRX7cA4pibSEDBje90+d+jJkPQ3hLNRN6ffg/jys
   KzPLi5d9p0lsd8e4zKIWfmDoFp3cOMe5ui5XYyeyBOcNGbHeTHqBSNOUy
   Rx+cCcbHOzYnQ56FHcFTQMhmNHDAj3Y7eWUpFyItnRLiJAxVejsfv5oWD
   OI1Q6/kEol9DelHAufzO6Wjbig99YLjBZ3rxbD+QbEnAdU7pYFCQ2xweh
   t4OM4G61iA/cINBA8QcBQPB16+ArpTXKB9G7H/9tbTkjoXTZXAV6fRHXk
   68300dkilhPzePtjqyesZKm9pIjz+dKdXxZ9edCVgbQ4tCHu1HYbqOOVq
   g==;
X-CSE-ConnectionGUID: NONDmntYRB2HwqlH7IyrNg==
X-CSE-MsgGUID: CjMXE9EnQgu+yRVw2SThdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64578973"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64578973"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 05:33:04 -0800
X-CSE-ConnectionGUID: kz/cbQFCSxKCZXPekSw1sg==
X-CSE-MsgGUID: m5T4pI1TTRuwcqO2k3ZUmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="187985400"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 05:33:01 -0800
Date: Fri, 7 Nov 2025 15:32:59 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/psr: Reject async flips when selective fetch is
 enabled
Message-ID: <aQ31C2bUwiJKJS8N@intel.com>
References: <20251105171015.22234-1-ville.syrjala@linux.intel.com>
 <c4a4be9261eec75201ff5a8dcb8f5da2373a4884.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4a4be9261eec75201ff5a8dcb8f5da2373a4884.camel@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 06, 2025 at 07:13:28AM +0000, Hogander, Jouni wrote:
> On Wed, 2025-11-05 at 19:10 +0200, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > The selective fetch code doesn't handle asycn flips correctly.
> > There is a nonsense check for async flips in
> > intel_psr2_sel_fetch_config_valid() but that only gets called
> > for modesets/fastsets and thus does nothing for async flips.
> > 
> > Currently intel_async_flip_check_hw() is very unhappy as the
> > selective fetch code pulls in planes that are not even async
> > flips capable.
> > 
> > Reject async flips when selective fetch is enabled, until
> > someone fixes this properly (ie. disable selective fetch while
> > async flips are being issued).
> 
> Is it ok to allow psr2 hw tracking?

No idea.

> Not directly related to this patch
> so:
> 
> Reviewed-by: Jouni Högander <jouni.hogander@intel.com>

Ta.

> 
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_display.c | 8 ++++++++
> >  drivers/gpu/drm/i915/display/intel_psr.c     | 6 ------
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c
> > b/drivers/gpu/drm/i915/display/intel_display.c
> > index 42ec78798666..10583592fefe 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -6020,6 +6020,14 @@ static int intel_async_flip_check_uapi(struct
> > intel_atomic_state *state,
> >  		return -EINVAL;
> >  	}
> >  
> > +	/* FIXME: selective fetch should be disabled for async flips
> > */
> > +	if (new_crtc_state->enable_psr2_sel_fetch) {
> > +		drm_dbg_kms(display->drm,
> > +			    "[CRTC:%d:%s] async flip disallowed with
> > PSR2 selective fetch\n",
> > +			    crtc->base.base.id, crtc->base.name);
> > +		return -EINVAL;
> > +	}
> > +
> >  	for_each_oldnew_intel_plane_in_state(state, plane,
> > old_plane_state,
> >  					     new_plane_state, i) {
> >  		if (plane->pipe != crtc->pipe)
> > diff --git a/drivers/gpu/drm/i915/display/intel_psr.c
> > b/drivers/gpu/drm/i915/display/intel_psr.c
> > index 05014ffe3ce1..65d77aea9536 100644
> > --- a/drivers/gpu/drm/i915/display/intel_psr.c
> > +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> > @@ -1296,12 +1296,6 @@ static bool
> > intel_psr2_sel_fetch_config_valid(struct intel_dp *intel_dp,
> >  		return false;
> >  	}
> >  
> > -	if (crtc_state->uapi.async_flip) {
> > -		drm_dbg_kms(display->drm,
> > -			    "PSR2 sel fetch not enabled, async flip
> > enabled\n");
> > -		return false;
> > -	}
> > -
> >  	return crtc_state->enable_psr2_sel_fetch = true;
> >  }
> >  
> 

-- 
Ville Syrjälä
Intel

