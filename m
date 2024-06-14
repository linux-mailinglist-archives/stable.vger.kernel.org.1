Return-Path: <stable+bounces-52209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DB3908DA4
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 16:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A003B1F24456
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 14:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4015E90;
	Fri, 14 Jun 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9slFBLa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4FFC08
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375994; cv=none; b=FwZobGn9eKXpALqj6cKm2xgMzFA0uMcqdGYeWa8HJwYjJ/7HGCqD50tgTSewROjjVsl3UIXgK2xJHim/ltL7IYc56iEWVYinNpVBBLx+mIBiJHrGEUB3NXRp1ZGoL9M1d7qKy04FEmIrL+hKoIvU7iB7gLBa2wEr0LqCiIY9GSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375994; c=relaxed/simple;
	bh=J7uz1x5jYI7lPoTiLt2qtkWfX7SjMOs7CGOUsUyfTM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HynoxkunYfF4nWFguo9Qcf6sDQepgpMH2pJXG2bJc8ADRH4w+BH7XXLl7XB09SldnFEsr+N+r6ZftovZRQmDNZHRee08ZcnUV8qoP9SuyK4cWXdBD0r7LD17J9+KHLJjyTd5yTEosorMi84+7uJ2xTjVHcxD+laVNARmpHvLFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9slFBLa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718375992; x=1749911992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J7uz1x5jYI7lPoTiLt2qtkWfX7SjMOs7CGOUsUyfTM4=;
  b=R9slFBLa21PMaUr5g8LfP3x+1HAQ69UIYsHJ6ZR/S9p1QIYw+1/IjYT5
   Z94O1KHDCHTiDEn2wsKjHkeLlJfEz4IVk413wXbCZZCFlfC4XbTsoSWzN
   mBDZzDuPtFda8dOUiHoRM1tE3PRhKRYIWoHZWZ9jWjQ+QIBWRmBPjxnAp
   z42oroc8v/bas9nwJB+/1XNf0XoMwySr7L3djmU2+lcPwDq4/A8sCNx9I
   59o9wcO4vLUnAtDB9SId8Ko+nEXzO+7cOeu8kvXxruldh5OV0KfaZ2m6D
   MowGKVgo/zBJ1nSH6dq2H6fo6muHwgbUSHXUcR8Lc9RdfDTbXd9t4gZIv
   Q==;
X-CSE-ConnectionGUID: NKIsrXSrRy2I2QDnOtawgw==
X-CSE-MsgGUID: RXKW6m7LR+uCFloYueWdbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="32742027"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="32742027"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:39:42 -0700
X-CSE-ConnectionGUID: s+JFUkSNTyi0qJpVlco4Ow==
X-CSE-MsgGUID: vPjUpIANQTebIVEa0HgCZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40479774"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 14 Jun 2024 07:39:40 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 14 Jun 2024 17:39:39 +0300
Date: Fri, 14 Jun 2024 17:39:39 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/mso: using joiner is not possible with eDP MSO
Message-ID: <ZmxWKyz8RcqjQ0Mg@intel.com>
References: <20240614142311.589089-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614142311.589089-1-jani.nikula@intel.com>
X-Patchwork-Hint: comment

On Fri, Jun 14, 2024 at 05:23:11PM +0300, Jani Nikula wrote:
> It's not possible to use the joiner at the same time with eDP MSO. When
> a panel needs MSO, it's not optional, so MSO trumps joiner.
> 
> v3: Only change intel_dp_has_joiner(), leave debugfs alone (Ville)
> 
> Cc: stable@vger.kernel.org
> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1668
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> ---
> 
> Just the minimal fix for starters to move things along.
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 9a9bb0f5b7fe..ab33c9de393a 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -465,6 +465,10 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
>  	struct intel_encoder *encoder = &intel_dig_port->base;
>  	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
>  
> +	/* eDP MSO is not compatible with joiner */
> +	if (intel_dp->mso_link_count)
> +		return false;
> +
>  	return DISPLAY_VER(dev_priv) >= 12 ||
>  		(DISPLAY_VER(dev_priv) == 11 &&
>  		 encoder->port != PORT_A);
> -- 
> 2.39.2

-- 
Ville Syrjälä
Intel

