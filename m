Return-Path: <stable+bounces-111812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6EDA23E53
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B863A8CAA
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D6F4A07;
	Fri, 31 Jan 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGZI5nz9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236014409
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330306; cv=none; b=jVTrcX2MP/cmfQg5o6vg7hziKlQN6Nsoe1JJP5st0VzxUP7d1uxRklxZ0AqOGLhqmSVZPxg88sRbbRvNp8sqX+C3Sq77ErkgOfTdYQTIKIzbZHx4q8isuLYqkrKDa8csVbhPnxKsYGB73WsYE61HXzcRweXQ+rOMeGYQ0QMdhek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330306; c=relaxed/simple;
	bh=acxBtP3naVLbc/nuu2Xr7tOIoK71doyEyfio1+8KUkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOTKdIX7DWQygQUEJObBM3xZiBgiYYNoADc2NNJB+LIzcTEs2yp5sJJ+4eSarfwaxFPjBASWnl08lZHvU+QyVp1RlFYbN7EHmv9T5efQp9ei53hNQT0LHF0ocV66LmFGGsxhvymihltFST02QVPgHOt7jhunORiAa1kcUykH92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGZI5nz9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738330305; x=1769866305;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=acxBtP3naVLbc/nuu2Xr7tOIoK71doyEyfio1+8KUkk=;
  b=DGZI5nz9xhB02Mu/rl4V5Jxlde7HGddQx+qFbEuZc8Vs50kFKg27tjtC
   s2nekfsZSoS0FOLhC7tnwWD+AKWZqKiG//fUB3ba2a3YFDa+pwYFL/UU/
   Crlsy5txGseIar9UvrP6D89+ea4PPKeX1qyQjFNZ4ISRg8zBMyIDn4Dei
   FjflmbR/8qPHlYpHdPpCLLr4K+ohlh1W1bwclqDkJAsZMVIDMJG4028QP
   lvBcPTXso0XSe3+ygzaZyHZ9xj0ayUHi9Jb4Bo/SMJO+C4Ze6s46Ry52T
   A065BFSHr7o6kEAz7RaiKFsQMumAo6xT72lOzy9S/aOBWNxdjc6Twa/qR
   w==;
X-CSE-ConnectionGUID: GU65RLAYREe2RUOPCrridw==
X-CSE-MsgGUID: GXvn6n/RRqeZ+dy9X4kJ3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="56326109"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="56326109"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 05:31:44 -0800
X-CSE-ConnectionGUID: YOdfq9UORaeFIO1OFIifaw==
X-CSE-MsgGUID: Vzm88yZzRYe7aZHt/ka6jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114778336"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 05:31:41 -0800
Date: Fri, 31 Jan 2025 15:32:36 +0200
From: Imre Deak <imre.deak@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/14] drm/i915/dp: Iterate DSC BPP from high to low on
 all platforms
Message-ID: <Z5zQ9BjEkA_PN9Ns@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <cover.1738327620.git.jani.nikula@intel.com>
 <3bba67923cbcd13a59d26ef5fa4bb042b13c8a9b.1738327620.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bba67923cbcd13a59d26ef5fa4bb042b13c8a9b.1738327620.git.jani.nikula@intel.com>

On Fri, Jan 31, 2025 at 02:49:54PM +0200, Jani Nikula wrote:
> Commit 1c56e9a39833 ("drm/i915/dp: Get optimal link config to have best
> compressed bpp") tries to find the best compressed bpp for the
> link. However, it iterates from max to min bpp on display 13+, and from
> min to max on other platforms. This presumably leads to minimum
> compressed bpp always being chosen on display 11-12.
> 
> Iterate from high to low on all platforms to actually use the best
> possible compressed bpp.
> 
> Fixes: 1c56e9a39833 ("drm/i915/dp: Get optimal link config to have best compressed bpp")
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: <stable@vger.kernel.org> # v6.7+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Imre Deak <imre.deak@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index d1b4fd542a1f..ecf192262eb9 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -2073,11 +2073,10 @@ icl_dsc_compute_link_config(struct intel_dp *intel_dp,
>  	/* Compressed BPP should be less than the Input DSC bpp */
>  	dsc_max_bpp = min(dsc_max_bpp, output_bpp - 1);
>  
> -	for (i = 0; i < ARRAY_SIZE(valid_dsc_bpp); i++) {
> -		if (valid_dsc_bpp[i] < dsc_min_bpp)
> +	for (i = ARRAY_SIZE(valid_dsc_bpp) - 1; i >= 0; i--) {
> +		if (valid_dsc_bpp[i] < dsc_min_bpp ||
> +		    valid_dsc_bpp[i] > dsc_max_bpp)
>  			continue;
> -		if (valid_dsc_bpp[i] > dsc_max_bpp)
> -			break;
>  
>  		ret = dsc_compute_link_config(intel_dp,
>  					      pipe_config,
> -- 
> 2.39.5
> 

