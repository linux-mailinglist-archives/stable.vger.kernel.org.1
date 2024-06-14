Return-Path: <stable+bounces-52188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432C908AF2
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 13:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9E11F24D68
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8D4195968;
	Fri, 14 Jun 2024 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJeI2Ptr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08085190477
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365289; cv=none; b=MGnc6RjrOLbtOrAHLkgcfNCvbpgKAv/LZZwCIzcQ+cClzg8XTeKl3DKNezHUxf0sF6M/eko+fnfDJ5GqNf4ElbOX3KBpsUUfX1GVI83Isz55mgRwPWYU+irKXBx/RmvDytnzML6yjSSOlPtVcxOtUTRviDVvT80dRASNqcel6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365289; c=relaxed/simple;
	bh=n6W9IR8P3WJJbwaWBW6LhiiUpw5Cf8KISMHenG0gpD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVAbZQLKJpJeS9iN8y+lmuP1+wyVX82oOCWU9L5DrgBCBcX+xiTrv/VgcDXhtc6WCUgLbL8jWJSkQhBp+EvmKB/5oGbCgcEIp51ylyIcFKmpxne+B9KiBMEtjoBvHOMXfSwxDLryqHannVNDGU+iFCcD5dJMOAVgI5H8R4qZvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJeI2Ptr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718365288; x=1749901288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n6W9IR8P3WJJbwaWBW6LhiiUpw5Cf8KISMHenG0gpD0=;
  b=mJeI2Ptr4MItfr8UEhgtXCipcbfqITvaNzw3UfhyUskXgA7FOknIkcIS
   UjAXYXGpr4XUOUaQFVZ6UUYrOjm/MuDpml47C+hg/79wDraptmiF2GCBq
   rRj30uNIvupdr3tAy46mfYSM+Gg4XNZf4T850qozhYh+Q6DU96v9g6KTP
   PKXe3PYoGjXKiw9K8ldqYqMLVLnC2qzFlJEWXiH/iiOG0/USzEJD+iFdG
   yQ7rwcK3PttHf6YZ70mmCG2FJDlDzpTQTHpKk7WmbmuH56vquMG65N8QQ
   22hJLPTNR5C+MG5WqVMvAm//K8c4QPrptarLo0Vhep8aCbgm+khyQAOze
   g==;
X-CSE-ConnectionGUID: iEv+41UvRoykQ0y3t8OA/w==
X-CSE-MsgGUID: ju/44vHwSPqYnnIHxxBTvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="18167074"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="18167074"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 04:41:27 -0700
X-CSE-ConnectionGUID: nylO4FS2RFCTbXxJvNCMlA==
X-CSE-MsgGUID: 3NRBCPhNT4qzIREzSgIROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40443672"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 14 Jun 2024 04:41:25 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 14 Jun 2024 14:41:24 +0300
Date: Fri, 14 Jun 2024 14:41:24 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/i915/mso: using joiner is not possible with
 eDP MSO
Message-ID: <ZmwsZCkP6mobS7ki@intel.com>
References: <cover.1718360103.git.jani.nikula@intel.com>
 <137a010815ab8ba8f266fea7a85fe14d7bfb74cd.1718360103.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <137a010815ab8ba8f266fea7a85fe14d7bfb74cd.1718360103.git.jani.nikula@intel.com>
X-Patchwork-Hint: comment

On Fri, Jun 14, 2024 at 01:16:03PM +0300, Jani Nikula wrote:
> It's not possible to use the joiner at the same time with eDP MSO. When
> a panel needs MSO, it's not optional, so MSO trumps joiner.
> 
> While just reporting false for intel_dp_has_joiner() should be
> sufficient, also skip creation of the joiner force enable debugfs to
> better handle this in testing.
> 
> Cc: stable@vger.kernel.org
> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1668
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display_debugfs.c | 8 ++++++--
>  drivers/gpu/drm/i915/display/intel_dp.c              | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> index 91757fed9c6d..5eb31404436c 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> @@ -1546,8 +1546,12 @@ void intel_connector_debugfs_add(struct intel_connector *connector)
>  	if (DISPLAY_VER(i915) >= 11 &&
>  	    (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
>  	     connector_type == DRM_MODE_CONNECTOR_eDP)) {
> -		debugfs_create_bool("i915_bigjoiner_force_enable", 0644, root,
> -				    &connector->force_bigjoiner_enable);
> +		struct intel_dp *intel_dp = intel_attached_dp(connector);

That won't give you anything on MST. Dunno if there's any point in
trying to do anything here anyway. We don't account for the other
intel_dp_has_joiner() restrictions here either.

> +
> +		/* eDP MSO is not compatible with joiner */
> +		if (!intel_dp->mso_link_count)
> +			debugfs_create_bool("i915_bigjoiner_force_enable", 0644, root,
> +					    &connector->force_bigjoiner_enable);
>  	}
>  
>  	if (connector_type == DRM_MODE_CONNECTOR_DSI ||
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

This part looks fine.

>  	return DISPLAY_VER(dev_priv) >= 12 ||
>  		(DISPLAY_VER(dev_priv) == 11 &&
>  		 encoder->port != PORT_A);
> -- 
> 2.39.2

-- 
Ville Syrjälä
Intel

