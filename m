Return-Path: <stable+bounces-58144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D610928B76
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85002828F6
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EFE16B72D;
	Fri,  5 Jul 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWuqC7pp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F71487D8
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192611; cv=none; b=F/AkbV8xVB8VRwG/UhSxV1GcnRQkF2cMD/mupBuDk5aJVrI/WSAQGZh1uuKeKk71eGJbYQwuAuEIfdpqKMrBL7uvtl+pvfIiwTcredLf2/Fy1Mu3NAjGtEWTO4ZHPTKEBnKRzqOXkRlT+ilSP3ykVoW7hOE5gyRdxNmSmogvJig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192611; c=relaxed/simple;
	bh=ulFGnZkUqan+tJw+L9tWJw227NKsEDMDRBXxumF8L0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPPE6K0slhvIp3OYkVqgYSZQYQ92VjV1YwjumKIAzdONoIUaEkDLMc6u57c1RPoIYDblv+JNxvaM6v7LrP7XR+4jybZkwLt4+0FqQix+GrpnrrtzkzdhlBpfzbWMlxS9FpaOQGqjFAdxqjfdqtPriYlPHpVqD5DlyKpkqxRnNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWuqC7pp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720192609; x=1751728609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ulFGnZkUqan+tJw+L9tWJw227NKsEDMDRBXxumF8L0c=;
  b=aWuqC7ppK8k7EeLMjYb6MyJk57xbM5cRMnrh3KnkJrPBWgrHlHs9SsVn
   golxsXKQK8qs8xQyxoGs2WcGRkftfWSwwP2jVontba8Q45kXDT4hEcwYO
   9temmN7pa2no8x6nCNph7DyIWk+dveV2sfpiVQakVqrWsH4nbpXYkVaqI
   nU8BmTBV3S9rG7yiq1fls7ntCZWALVVjDqnZTn0d+LdCa32uZ19kx4iia
   b7lkrU1fRlj8VErWhKYBQ097V+saWWkCdeptBRW/69esxuRFrFxamoZx6
   dxIgbC4NhX4HW43GLm9HPICWsy8S9jPVdA0/T4Q5pfD1aJxgRljq9CY3t
   w==;
X-CSE-ConnectionGUID: BHeWdFb9Q0WArMR0c70lgg==
X-CSE-MsgGUID: mX7w+P6lSOWsBURoQZMWDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28879247"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="28879247"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 08:16:48 -0700
X-CSE-ConnectionGUID: 4aFSfx62SMmPolgWWfIAwA==
X-CSE-MsgGUID: 6gYSpmimSBaVp1W2u4pS7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="46870229"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 05 Jul 2024 08:16:46 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 05 Jul 2024 18:16:45 +0300
Date: Fri, 5 Jul 2024 18:16:45 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Gareth Yu <gareth.yu@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915/dp: Don't switch the LTTPR mode on an
 active link
Message-ID: <ZogOXbUb9pL6Zmg6@intel.com>
References: <20240703155937.1674856-1-imre.deak@intel.com>
 <20240703155937.1674856-2-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703155937.1674856-2-imre.deak@intel.com>
X-Patchwork-Hint: comment

On Wed, Jul 03, 2024 at 06:59:33PM +0300, Imre Deak wrote:
> Switching to transparent mode leads to a loss of link synchronization,
> so prevent doing this on an active link. This happened at least on an
> Intel N100 system / DELL UD22 dock, the LTTPR residing either on the
> host or the dock. To fix the issue, keep the current mode on an active
> link, adjusting the LTTPR count accordingly (resetting it to 0 in
> transparent mode).
> 
> Fixes: 7b2a4ab8b0ef ("drm/i915: Switch to LTTPR transparent mode link training")
> Reported-and-tested-by: Gareth Yu <gareth.yu@intel.com>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/10902
> Cc: <stable@vger.kernel.org> # v5.15+
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  .../drm/i915/display/intel_dp_link_training.c | 49 +++++++++++++++++--
>  1 file changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> index 1bc4ef84ff3bc..08a27fe077917 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> @@ -117,10 +117,24 @@ intel_dp_set_lttpr_transparent_mode(struct intel_dp *intel_dp, bool enable)
>  	return drm_dp_dpcd_write(&intel_dp->aux, DP_PHY_REPEATER_MODE, &val, 1) == 1;
>  }
>  
> -static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> +static bool intel_dp_lttpr_transparent_mode_enabled(struct intel_dp *intel_dp)
> +{
> +	return intel_dp->lttpr_common_caps[DP_PHY_REPEATER_MODE -
> +					   DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV] ==
> +		DP_PHY_REPEATER_MODE_TRANSPARENT;
> +}
> +
> +/*
> + * Read the LTTPR common capabilities and switch the LTTPR PHYs to
> + * non-transparent mode if this is supported. Preserve the
> + * transparent/non-transparent mode on an active link.
> + *
> + * Return the number of detected LTTPRs in non-transparent mode or 0 if the
> + * LTTPRs are in transparent mode or the detection failed.
> + */
> +static int intel_dp_init_lttpr_phys(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
>  {
>  	int lttpr_count;
> -	int i;
>  
>  	if (!intel_dp_read_lttpr_common_caps(intel_dp, dpcd))
>  		return 0;
> @@ -134,6 +148,19 @@ static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEI
>  	if (lttpr_count == 0)
>  		return 0;
>  
> +	/*
> +	 * Don't change the mode on an active link, to prevent a loss of link
> +	 * synchronization. See DP Standard v2.0 3.6.7. about the LTTPR
> +	 * resetting its internal state when the mode is changed from
> +	 * non-transparent to transparent.
> +	 */
> +	if (intel_dp->link_trained) {
> +		if (lttpr_count < 0 || intel_dp_lttpr_transparent_mode_enabled(intel_dp))
> +			goto out_reset_lttpr_count;

I was pondering whether we should flag this for LTTPR reinit
on the next link training, but looks like we already do that
unconditionally. So the TODO in intel_dp_start_link_train()
should perhaps be removed if it's the behaviour we now want?

However, it looks like we leave link_trained==true when
using the non-modeset link retrain path. So that will again
skip the LTTPR mode change, whereas the modeset based path
will do the mode change. Doesn't really matter I suppose,
but probably good to keep that change in behaviour in mind
when we get rid of the non-modeset retrain path for good.

Series is
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> +
> +		return lttpr_count;
> +	}
> +
>  	/*
>  	 * See DP Standard v2.0 3.6.6.1. about the explicit disabling of
>  	 * non-transparent mode and the disable->enable non-transparent mode
> @@ -154,11 +181,25 @@ static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEI
>  		       "Switching to LTTPR non-transparent LT mode failed, fall-back to transparent mode\n");
>  
>  		intel_dp_set_lttpr_transparent_mode(intel_dp, true);
> -		intel_dp_reset_lttpr_count(intel_dp);
>  
> -		return 0;
> +		goto out_reset_lttpr_count;
>  	}
>  
> +	return lttpr_count;
> +
> +out_reset_lttpr_count:
> +	intel_dp_reset_lttpr_count(intel_dp);
> +
> +	return 0;
> +}
> +
> +static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> +{
> +	int lttpr_count;
> +	int i;
> +
> +	lttpr_count = intel_dp_init_lttpr_phys(intel_dp, dpcd);
> +
>  	for (i = 0; i < lttpr_count; i++)
>  		intel_dp_read_lttpr_phy_caps(intel_dp, dpcd, DP_PHY_LTTPR(i));
>  
> -- 
> 2.43.3

-- 
Ville Syrjälä
Intel

