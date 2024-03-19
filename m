Return-Path: <stable+bounces-28444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F30880471
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 19:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C197284174
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 18:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9012BAE9;
	Tue, 19 Mar 2024 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSlw9nc0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9483838F
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871898; cv=none; b=KELCsog6Pog3w+L89ld4wZyxrMwMugOldLKfb3xaYZWZiD22qUwHqi6hlE1Ebjt86NdipeLtLdhuAdtr+eUazMeSOXv1WeafxCqmyq+QJ9MSzeZI5s71ssfzx3q7xzkZsyMZ2VZK6YcMan5ejE4c65JZAt7ARhUHnr7xEAYjH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871898; c=relaxed/simple;
	bh=X0crnYytFbsd8Clx7dU+qTJ/narfbG0arFZKRd0Lkr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXRIsoARKhnG5pHg3gGxZg3fVs7DJQk3TClF5/+E/zr/ul7qrLCLmfzeNJ4HEipH4EYY+okf6yJZRI+bSYLryoq6i2RHxEM2snmLLcw8w9p+4uLepx6l5b7cOu/iW02k6HTxdvhQadBO9V9uCNsblWXPl7AzoAoah0nRa871Ufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSlw9nc0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710871896; x=1742407896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X0crnYytFbsd8Clx7dU+qTJ/narfbG0arFZKRd0Lkr8=;
  b=mSlw9nc0B94B8x+BwoYGS2JdLOsFdUQjurcUD1ouUxBFdsL5uhbVarOC
   cUiN8zHU3ONMnlH8vBGSrL2HghjDl7JXvav0qT305lJBZBMfoPmN0zKgx
   cwN0j1jx1FmB1DHMzOAst2vMp2YE6EJbxcnzDV249OZSZBMDgNj9QgJHG
   TtEB6zHpPnHCsUwV3UpzDhOY7ZR/RVT/ciKZei32gvJiVh1NiIwgrKHcK
   nC88gskN5OBoSZDuT1wK4MFXISH7cIEYdKWwvBFxnd8Apwl9FV8nM1u0D
   UF3vNbxSLPONijkxir0J04tTZEv1DkYdSrA6FPnhNxLRBZHQS93eLGxPp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5699203"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5699203"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 11:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="827782237"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="827782237"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 19 Mar 2024 11:11:30 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 19 Mar 2024 20:11:29 +0200
Date: Tue, 19 Mar 2024 20:11:29 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/i915/bios: Tolerate devdata==NULL in
 intel_bios_encoder_supports_dp_dual_mode()
Message-ID: <ZfnVUbHNL4lEeinV@intel.com>
References: <20240319092443.15769-1-ville.syrjala@linux.intel.com>
 <87sf0mo9hx.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sf0mo9hx.fsf@intel.com>
X-Patchwork-Hint: comment

On Tue, Mar 19, 2024 at 11:29:14AM +0200, Jani Nikula wrote:
> On Tue, 19 Mar 2024, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >
> > If we have no VBT, or the VBT didn't declare the encoder
> > in question, we won't have the 'devdata' for the encoder.
> > Instead of oopsing just bail early.
> >
> > We won't be able to tell whether the port is DP++ or not,
> > but so be it.
> >
> > Cc: stable@vger.kernel.org
> > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10464
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_bios.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
> > index c7841b3eede8..c13a98431a7b 100644
> > --- a/drivers/gpu/drm/i915/display/intel_bios.c
> > +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> > @@ -3458,6 +3458,9 @@ bool intel_bios_encoder_supports_dp_dual_mode(const struct intel_bios_encoder_da
> >  {
> >  	const struct child_device_config *child = &devdata->child;
> 
> The above oopses already.

Nope. It's just taking the address of the thing.

> 
> BR,
> Jani.
> 
> >  
> > +	if (!devdata)
> > +		return false;
> > +
> >  	if (!intel_bios_encoder_supports_dp(devdata) ||
> >  	    !intel_bios_encoder_supports_hdmi(devdata))
> >  		return false;
> 
> -- 
> Jani Nikula, Intel

-- 
Ville Syrjälä
Intel

