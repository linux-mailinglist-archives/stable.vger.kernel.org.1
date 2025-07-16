Return-Path: <stable+bounces-163190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E24B07D0A
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 20:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B691C284B1
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80DC29B20C;
	Wed, 16 Jul 2025 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hThoi0Bm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D7188A3A
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691247; cv=none; b=t1DRMVNBNevs/9R+3tZd6Ivps1Hut90dcWK3PQYwbnaAulG3KGYzqhyBsLwiNyo77RArdENv3u8g1QnDnBxs8asstBaA27fLQa80eTkNeG9EVS7RrQ+nL1as2+mXiOIMt+4xYw5fcCByVTYXTZ01ZYN1wkq5igMxQ7z252tGALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691247; c=relaxed/simple;
	bh=lWnbiAf4ytPP2bVU4uh4Lj6VhtdMwzO6Ouf9JgwG01M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fiio5z82oWvPwBXggAosoz7eyoLWotNmEjqsow27f8FlnejcOVK0x+oOOnn6yiUY9+wWN5sAbjh87JWQVKFlFoQt+iyEzUDubWEJhmXq1snybAz2fcqjZLcnSBMUfd/cawikuDsBc6Nzf9qwl7W8YDtWmmW/3Bn9FXJii8gCuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hThoi0Bm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752691245; x=1784227245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lWnbiAf4ytPP2bVU4uh4Lj6VhtdMwzO6Ouf9JgwG01M=;
  b=hThoi0BmUw+hOwh+oZk3XdoGADLwiLGrM9hPVbHP75BQiewnXM7BNQT0
   e3C2Xt+annnUs42yFpEB31HV498eh497BIIflCiI6UVzGiCz9qqVktcek
   +LbiCW6EtWX5a5mwJReVqPl833h2UxV+t8BncSXOTUrLC5xyveHXy/iGc
   a2SSMMYLu9ZDWgSaE+epGhVHRUSNRx6ZIUVRwAREZsLbtsp8AxcolszMo
   7Nl5lt2MPpwEFLBGVkKKm6NrH8eZcBxfuf16TDw3gllOXxek3bvvjSWNc
   3k8lcdITzgsVWhlPaEMJ1/v2RLRWGS2iR29Ul1SUZIr69h9PrOWXOTqvO
   g==;
X-CSE-ConnectionGUID: kB3al30CSFySwObp03CLZw==
X-CSE-MsgGUID: XpsuSF9xTMat2wDoNYY8tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58760739"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="58760739"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 11:40:44 -0700
X-CSE-ConnectionGUID: 5GCTy5J9QWCTb81s1XmyPA==
X-CSE-MsgGUID: ts3VSS5/QoyIzOHJMpsHHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="163210921"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO stinkbox) ([10.245.245.254])
  by orviesa005.jf.intel.com with SMTP; 16 Jul 2025 11:40:42 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 16 Jul 2025 21:40:40 +0300
Date: Wed, 16 Jul 2025 21:40:40 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/7] drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x
Message-ID: <aHfyKJ_NJL-i8B94@intel.com>
References: <20250710201718.25310-1-ville.syrjala@linux.intel.com>
 <20250710201718.25310-2-ville.syrjala@linux.intel.com>
 <aHenHJLCSVjYDUKp@ideak-desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHenHJLCSVjYDUKp@ideak-desk>
X-Patchwork-Hint: comment

On Wed, Jul 16, 2025 at 04:20:28PM +0300, Imre Deak wrote:
> On Thu, Jul 10, 2025 at 11:17:12PM +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > On g4x we currently use the 96MHz non-SSC refclk, which can't actually
> > generate an exact 2.7 Gbps link rate. In practice we end up with 2.688
> > Gbps which seems to be close enough to actually work, but link training
> > is currently failing due to miscalculating the DP_LINK_BW value (we
> > calcualte it directly from port_clock which reflects the actual PLL
> > outpout frequency).
> > 
> > Ideas how to fix this:
> > - nudge port_clock back up to 270000 during PLL computation/readout
> > - track port_clock and the nominal link rate separately so they might
> >   differ a bit
> > - switch to the 100MHz refclk, but that one should be SSC so perhaps
> >   not something we want
> > 
> > While we ponder about a better solution apply some band aid to the
> > immediate issue of miscalculated DP_LINK_BW value. With this
> > I can again use 2.7 Gbps link rate on g4x.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 665a7b04092c ("drm/i915: Feed the DPLL output freq back into crtc_state")
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Reviewed-by: Imre Deak <imre.deak@intel.com>
> 
> IIUC, port_clock for g4x is ref * m / n / p, where for DP the fixed
> ref=96000 and m/n/p values from g4x_dpll are used.
> 
> Ftr, m = 135, n = 6, p = 8 would give port_clock = 270000, but there's
> no intel_limit for DP, so can't know if these params are within range.

The P divider can only be some multiple of 5.

> 
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> > index f48912f308df..7976fec88606 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -1606,6 +1606,12 @@ int intel_dp_rate_select(struct intel_dp *intel_dp, int rate)
> >  void intel_dp_compute_rate(struct intel_dp *intel_dp, int port_clock,
> >  			   u8 *link_bw, u8 *rate_select)
> >  {
> > +	struct intel_display *display = to_intel_display(intel_dp);
> > +
> > +	/* FIXME g4x can't generate an exact 2.7GHz with the 96MHz non-SSC refclk */
> > +	if (display->platform.g4x && port_clock == 268800)
> > +		port_clock = 270000;
> > +
> >  	/* eDP 1.4 rate select method. */
> >  	if (intel_dp->use_rate_select) {
> >  		*link_bw = 0;
> > -- 
> > 2.49.0
> > 

-- 
Ville Syrjälä
Intel

