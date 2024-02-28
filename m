Return-Path: <stable+bounces-25438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F75B86B80D
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 20:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA1A1C2204E
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16114085D;
	Wed, 28 Feb 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RICXecgh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC979B74
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148138; cv=none; b=qPuicNsy3wIlgU3cxtm+E1cDayEbrmGdQ4qECIJ+oio/BXfyWrZ1v16TjFwrcyLJ8nY09mVDjr2i5HRdjWY0zFx3MDXR0hJfs/5aRNqsIAZ7+bME2Hx8eiQgx/HmuvntsH7F+ZfVlCqfhiPw2I2uCx/mqdjlhNYMhMEWjH6lBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148138; c=relaxed/simple;
	bh=yfVx8xVCmwxqOiBAXDn0E0GtJRffgsuqh7uZQ03+BQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjFoQLrfXa+20ff1AA7kssxZtHVrst3YuJlk3IhPTkV7WdV716o4HjSCjiFBOGL3pGgivWzU/kUt3RiYo9QdjUtN2ub7k0ffYrizXedAO/rlrhU9O5kvQ9OA8zL/23sOaUK9NAkuHUp5YffSeGyQM7v8sXPwLuV/hyNuXthp5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RICXecgh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709148137; x=1740684137;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yfVx8xVCmwxqOiBAXDn0E0GtJRffgsuqh7uZQ03+BQk=;
  b=RICXecghFMkWEDmbkIpLvwBjdUlDsmWHVChpxvYdBj7/7Q9OyU0LJJCz
   YI8aQQofXlQ26V6+oZeeV88w8lCloQ930xxb+w7ykS9SYT6d5zoU1BFRO
   4B6RsVWkUMA1TfQkP0F0MjG8zGBJadV9DDQVz5ArbgjFMIYPwjZ6eo56/
   1HW94SExB+EAd/y74Uyo7aZT+snA9phSn92XKgBA0rRW9DIU2/hOvvMM2
   /dfVnjkKUvhZuqLYh+isHm8Et1KKIlDvpeZD2+PteAAuWnXO/UyyKaixo
   Qk5JYYLe1V01SllgR4qQad4I6ge/fIF5i5Msk1B4lgKsMOL7wCKEu688h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3493554"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3493554"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:22:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12079316"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:22:14 -0800
Date: Wed, 28 Feb 2024 21:22:37 +0200
From: Imre Deak <imre.deak@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/i915: Don't explode when the dig port we don't
 have an AUX CH
Message-ID: <Zd+H/T7u05uVSXaK@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20240223203216.15210-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223203216.15210-1-ville.syrjala@linux.intel.com>

On Fri, Feb 23, 2024 at 10:32:15PM +0200, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> The icl+ power well code currently assumes that every AUX power
> well maps to an encoder which is using said power well. That is
> by no menas guaranteed as we:
> - only register encoders for ports declared in the VBT
> - combo PHY HDMI-only encoder no longer get an AUX CH since
>   commit 9856308c94ca ("drm/i915: Only populate aux_ch if really needed")
> 
> However we have places such as intel_power_domains_sanitize_state()
> that blindly traverse all the possible power wells. So these bits
> of code may very well encounbter an aux power well with no associated
> encoder.
> 
> In this particular case the BIOS seems to have left one AUX power
> well enabled even though we're dealing with a HDMI only encoder
> on a combo PHY. We then proceed to turn off said power well and
> explode when we can't find a matching encoder. As a short term fix
> we should be able to just skip the PHY related parts of the power
> well programming since we know this situation can only happen with
> combo PHYs.
> 
> Another option might be to go back to always picking an AUX CH for
> all encoders. However I'm a bit wary about that since we might in
> theory end up conflicting with the VBT AUX CH assignment. Also
> that wouldn't help with encoders not declared in the VBT, should
> we ever need to poke the corresponding power wells.
> 
> Longer term we need to figure out what the actual relationship
> is between the PHY vs. AUX CH vs. AUX power well. Currently this
> is entirely unclear.

This is unspecified, so the only way would be to test an actual platform
with an alternative AUX CH VBT setting (on a DDI platform). My current
assumption is that this alternative AUX CH determines:

- The AUX power well to be enabled for an AUX transfer
- The AUX CH data/ctl registers to be used for an AUX transfer

Otoh, for the (overloaded) power control for the main lane functionality
it is not the alternative AUX CH power well, rather the given DDIs
direct mapped/own AUX CH power well what would be required. The driver
doesn't make a distinction in this now, since it's unspecified. I think
cross connecting AUX CHs wouldn't really work on DDI platforms for this
reason (at least on TC DDIs/PHYs/AUX CHs).

For the PHY workarounds which are part of the AUX power well programming
sequence, it is the PHY connected to the given DDI (so not affected by
any alternative AUX CH setting), which needs to be programmed. As above
this is also unspeficied, so just my assumption.

> Cc: stable@vger.kernel.org
> Fixes: 9856308c94ca ("drm/i915: Only populate aux_ch if really needed")
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10184
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  .../drm/i915/display/intel_display_power_well.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_power_well.c b/drivers/gpu/drm/i915/display/intel_display_power_well.c
> index 47cd6bb04366..06900ff307b2 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_power_well.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_power_well.c
> @@ -246,7 +246,14 @@ static enum phy icl_aux_pw_to_phy(struct drm_i915_private *i915,
>  	enum aux_ch aux_ch = icl_aux_pw_to_ch(power_well);
>  	struct intel_digital_port *dig_port = aux_ch_to_digital_port(i915, aux_ch);
>  
> -	return intel_port_to_phy(i915, dig_port->base.port);
> +	/*
> +	 * FIXME should we care about the (VBT defined) dig_port->aux_ch
> +	 * relationship or should this be purely defined by the hardware layout?
> +	 * Currently if the port doesn't appear in the VBT, or if it's declared
> +	 * as HDMI-only and routed to a combo PHY, the encoder either won't be
> +	 * present at all or it will not have an aux_ch assigned.
> +	 */
> +	return dig_port ? intel_port_to_phy(i915, dig_port->base.port) : PHY_NONE;

Yes, if it's not known which PHY is used in connection with an AUX CH
(which in theory could be remapped via VBT), then the WA can't be
applied either; so on both patches:
Reviewed-by: Imre Deak <imre.deak@intel.com>

>  }
>  
>  static void hsw_wait_for_power_well_enable(struct drm_i915_private *dev_priv,
> @@ -414,7 +421,8 @@ icl_combo_phy_aux_power_well_enable(struct drm_i915_private *dev_priv,
>  
>  	intel_de_rmw(dev_priv, regs->driver, 0, HSW_PWR_WELL_CTL_REQ(pw_idx));
>  
> -	if (DISPLAY_VER(dev_priv) < 12)
> +	/* FIXME this is a mess */
> +	if (phy != PHY_NONE)
>  		intel_de_rmw(dev_priv, ICL_PORT_CL_DW12(phy),
>  			     0, ICL_LANE_ENABLE_AUX);
>  
> @@ -437,7 +445,10 @@ icl_combo_phy_aux_power_well_disable(struct drm_i915_private *dev_priv,
>  
>  	drm_WARN_ON(&dev_priv->drm, !IS_ICELAKE(dev_priv));
>  
> -	intel_de_rmw(dev_priv, ICL_PORT_CL_DW12(phy), ICL_LANE_ENABLE_AUX, 0);
> +	/* FIXME this is a mess */
> +	if (phy != PHY_NONE)
> +		intel_de_rmw(dev_priv, ICL_PORT_CL_DW12(phy),
> +			     ICL_LANE_ENABLE_AUX, 0);
>  
>  	intel_de_rmw(dev_priv, regs->driver, HSW_PWR_WELL_CTL_REQ(pw_idx), 0);
>  
> -- 
> 2.43.0
> 

