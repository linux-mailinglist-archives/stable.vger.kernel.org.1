Return-Path: <stable+bounces-32312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8397788C0F5
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 12:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0331F391BA
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E778354905;
	Tue, 26 Mar 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5rBkgIf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220FC5475D
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453224; cv=none; b=JdyydDYDS/oSpcq8H6Odo0zK9NBG6jhSchKngMn7AUUJBNbJqdKHjyO3n2Q84wLGOgkHYTeW5tfgfTIuDnnAAeR6GoiQ/UiEtPNhIH7vC9QqAcaHoJ5WrSz/lx0yhyX3RoVS1k0PLUue32rREwdSS0ngXdAiEDZRwR7FHf9jd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453224; c=relaxed/simple;
	bh=HSrcWmxETJ8E8spBRNHk4NS3co0WzT5Z4jEDA/qhCp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baDYn7uRgWaRWbICXusKgXY/iBSNGEjGzG3i14ag591E6zDLEFDRxq6aJtJ1Vd9N5hppQzmEu+O8kWvwHNLduvhP/jTMFmillkmb0RzoAuohrWFUjgwIUFLt46E3bGh+FEHW3oY6m+1Ghy9u+nwg91x2/AySNoQW/EifjyLpgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5rBkgIf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711453223; x=1742989223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HSrcWmxETJ8E8spBRNHk4NS3co0WzT5Z4jEDA/qhCp8=;
  b=A5rBkgIf6ThPTGj9GtV+h9Rdip8KSAo3aLXEhbPb/ugH2HXpEiH6ZUuj
   AYOAQFZHs48Q9NDqaCrs7ZFrOEVNgd3Ck5PXFAs33GnB3Bh6V2aAKwH0e
   IoDnm9edeFqFnX4A8mbn9YVAoNpf+SAoM8Uag07ixbqLr2Of9KxPO5I7H
   t10wXIrCTU++K9sjyCELEIAuESomprBQx1TU9ZPp3tL0NKxGK0/S1E3us
   dkquv0+Rw/EzJu+tsl4oTxi02MmmLevX71GlFnJsaplC2G7IxK0N60QG0
   12hUXy2M6VPjr7uUJeWlfa6BUF6tfv/b7fCLQNW/dpoq37lxdpIXa1M9W
   w==;
X-CSE-ConnectionGUID: z9q/4sJpRaWWtNY6D4AVrA==
X-CSE-MsgGUID: ZSDTtANKQhiSOvOmLR5Chw==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="28978975"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="28978975"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 04:40:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="827785181"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="827785181"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 26 Mar 2024 04:40:19 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 26 Mar 2024 13:40:19 +0200
Date: Tue, 26 Mar 2024 13:40:19 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] drm/i915: Pre-populate the cursor physical dma address
Message-ID: <ZgK0IxB3I81KdFsh@intel.com>
References: <20240325175738.3440-1-ville.syrjala@linux.intel.com>
 <SJ1PR11MB612907EA0F41B6CD6ECC9B1AB9352@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <ZgKzPZWovqa-hm30@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgKzPZWovqa-hm30@intel.com>
X-Patchwork-Hint: comment

On Tue, Mar 26, 2024 at 01:36:29PM +0200, Ville Syrjälä wrote:
> On Tue, Mar 26, 2024 at 04:57:57AM +0000, Borah, Chaitanya Kumar wrote:
> > > -----Original Message-----
> > > From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of Ville
> > > Syrjala
> > > Sent: Monday, March 25, 2024 11:28 PM
> > > To: intel-gfx@lists.freedesktop.org
> > > Cc: stable@vger.kernel.org; Borislav Petkov <bp@alien8.de>
> > > Subject: [PATCH] drm/i915: Pre-populate the cursor physical dma address
> > > 
> > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > 
> > > Calling i915_gem_object_get_dma_address() from the vblank evade critical
> > > section triggers might_sleep().
> > > 
> > > While we know that we've already pinned the framebuffer and thus
> > > i915_gem_object_get_dma_address() will in fact not sleep in this case, it
> > > seems reasonable to keep the unconditional might_sleep() for maximum
> > > coverage.
> > > 
> > > So let's instead pre-populate the dma address during fb pinning, which all
> > > happens before we enter the vblank evade critical section.
> > > 
> > > We can use u32 for the dma address as this class of hardware doesn't
> > > support >32bit addresses.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 0225a90981c8 ("drm/i915: Make cursor plane registers unlocked")
> > > Link: https://lore.kernel.org/intel-
> > > gfx/20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local/
> > 
> > Nit. This could be changed to Closes and moved after Reported-by to keep checkpatch happy but otherwise, LGTM.
> 
> It's not a gitlab link, so Closes doesn't seem appropriate.

Hmm. Seems people have started to used Closes: for non-gitlab stuff
as well. I suppose it's OK then.

> 
> > 
> > Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> 
> Thanks.
> 
> > 
> > > Reported-by: Borislav Petkov <bp@alien8.de>
> > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > ---
> > >  drivers/gpu/drm/i915/display/intel_cursor.c        |  4 +---
> > >  drivers/gpu/drm/i915/display/intel_display_types.h |  1 +
> > >  drivers/gpu/drm/i915/display/intel_fb_pin.c        | 10 ++++++++++
> > >  3 files changed, 12 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c
> > > b/drivers/gpu/drm/i915/display/intel_cursor.c
> > > index f8b33999d43f..0d3da55e1c24 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_cursor.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_cursor.c
> > > @@ -36,12 +36,10 @@ static u32 intel_cursor_base(const struct
> > > intel_plane_state *plane_state)  {
> > >  	struct drm_i915_private *dev_priv =
> > >  		to_i915(plane_state->uapi.plane->dev);
> > > -	const struct drm_framebuffer *fb = plane_state->hw.fb;
> > > -	struct drm_i915_gem_object *obj = intel_fb_obj(fb);
> > >  	u32 base;
> > > 
> > >  	if (DISPLAY_INFO(dev_priv)->cursor_needs_physical)
> > > -		base = i915_gem_object_get_dma_address(obj, 0);
> > > +		base = plane_state->phys_dma_addr;
> > >  	else
> > >  		base = intel_plane_ggtt_offset(plane_state);
> > > 
> > > diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h
> > > b/drivers/gpu/drm/i915/display/intel_display_types.h
> > > index 8a35fb6b2ade..68f26a33870b 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> > > +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> > > @@ -728,6 +728,7 @@ struct intel_plane_state {  #define PLANE_HAS_FENCE
> > > BIT(0)
> > > 
> > >  	struct intel_fb_view view;
> > > +	u32 phys_dma_addr; /* for cursor_needs_physical */
> > > 
> > >  	/* Plane pxp decryption state */
> > >  	bool decrypt;
> > > diff --git a/drivers/gpu/drm/i915/display/intel_fb_pin.c
> > > b/drivers/gpu/drm/i915/display/intel_fb_pin.c
> > > index 7b42aef37d2f..b6df9baf481b 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_fb_pin.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_fb_pin.c
> > > @@ -255,6 +255,16 @@ int intel_plane_pin_fb(struct intel_plane_state
> > > *plane_state)
> > >  			return PTR_ERR(vma);
> > > 
> > >  		plane_state->ggtt_vma = vma;
> > > +
> > > +		/*
> > > +		 * Pre-populate the dma address before we enter the vblank
> > > +		 * evade critical section as
> > > i915_gem_object_get_dma_address()
> > > +		 * will trigger might_sleep() even if it won't actually sleep,
> > > +		 * which is the case when the fb has already been pinned.
> > > +		 */
> > > +		if (phys_cursor)
> > > +			plane_state->phys_dma_addr =
> > > +
> > > 	i915_gem_object_get_dma_address(intel_fb_obj(fb), 0);
> > >  	} else {
> > >  		struct intel_framebuffer *intel_fb = to_intel_framebuffer(fb);
> > > 
> > > --
> > > 2.43.2
> > 
> 
> -- 
> Ville Syrjälä
> Intel

-- 
Ville Syrjälä
Intel

