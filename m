Return-Path: <stable+bounces-152615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9FDAD880F
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 11:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE4518832C1
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 09:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491827281F;
	Fri, 13 Jun 2025 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaQmhV8+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE741ACEAF
	for <stable@vger.kernel.org>; Fri, 13 Jun 2025 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807368; cv=none; b=HHREP1Lt38DiZbEFhqonzzw632gGJ5EQ57Bd6cHD+PlNnGaKf+O2XTXgTwyEOiItYvhWR9TEuzG6a0zxfNzz3cqKmfhFNc5A7eLVHuSqjn3ENm0sLee8iYm8YYW2/Db0TCr9zVh59za1M0hI0Ftw06mRhhzT211eAg7EgtCD/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807368; c=relaxed/simple;
	bh=qGUY2ypNF3GNmcerHutxgi8nu30RmEH27GQjhQQu1C4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=syLXdfSF/fh3fQGfHoow7Ni7mNTTYP+PBZboYfJgDxuTVMOIFVZqHUBPS3UFs1wl/OlKKwbeglDmCC5EAitjwHqkssTHv8didCCUlhoRJML2B4inLkoB61SrDHMiWEJl8gzBbh6dYqXSb2ZH48XiSWcSAGpG++BjTjH4JuZMwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaQmhV8+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749807367; x=1781343367;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qGUY2ypNF3GNmcerHutxgi8nu30RmEH27GQjhQQu1C4=;
  b=iaQmhV8++DW3nOkFl5K6sgfAVSbr80Xq5eev1UhHyEVjv8f4PINb5LGf
   WXYjLz5Ro1oSODzaBAtySMok7SjbrVtRwyLev2/hmqavElyJPz+rL7uux
   fuGtXnPj9JpfN+trLRTZ46cVTIgnDR4EsWKfP477Dppb7RXSNbEzJE5WO
   6tNo/xEtMuVJJVoh12B+y/KSaSXY07cMtorqe3PtXj7o5MjcP4zHna3TH
   Ggk/y2/YmWJ4RujT2wzrATJe37gvli4sTAjrO3PYocLKYedKiY9fHCGQs
   nDHsZdHnqRgxGy5/zQBYW2miXra7skd/0PnoTirgdWTL/4+0Aux+HptJi
   Q==;
X-CSE-ConnectionGUID: jD7cu31OQ/mjVmU9x08MRg==
X-CSE-MsgGUID: 0a4UO2CgQaWKw0+/a0Wlmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69460853"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="69460853"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 02:36:07 -0700
X-CSE-ConnectionGUID: fhoG/oIRTQSMwBflxWZbtQ==
X-CSE-MsgGUID: cnGmUmx1QBWvvxIvuJLLUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="147767689"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.26])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 02:36:04 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, suraj.kandpal@intel.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/snps_hdmi_pll: Fix 64-bit divisor truncation
 by using div64_u64
In-Reply-To: <20250613061246.1118579-1-ankit.k.nautiyal@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250613061246.1118579-1-ankit.k.nautiyal@intel.com>
Date: Fri, 13 Jun 2025 12:36:02 +0300
Message-ID: <0d7742055fbbadf97cc3a361de6838a7d0203f51@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 13 Jun 2025, Ankit Nautiyal <ankit.k.nautiyal@intel.com> wrote:
> DIV_ROUND_CLOSEST_ULL uses do_div(), which expects a 32-bit divisor.
> When passing a 64-bit constant like CURVE2_MULTIPLIER, the value is
> silently truncated to u32, potentially leading to incorrect results
> on large divisors.
>
> Replace DIV_ROUND_CLOSEST_ULL with div64_u64(), which correctly
> handles full 64-bit division. Since the result is clamped between
> 1 and 127, rounding is unnecessary and truncating division
> is sufficient.

I don't understand how you can make that conclusion. Please explain.

Would it be safer to just use DIV64_U64_ROUND_CLOSEST()?

> Fixes: 5947642004bf ("drm/i915/display: Add support for SNPS PHY HDMI PLL algorithm for DG2")
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: <stable@vger.kernel.org> # v6.15+
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c b/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
> index 74bb3bedf30f..ac609bdf6653 100644
> --- a/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
> +++ b/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
> @@ -103,8 +103,8 @@ static void get_ana_cp_int_prop(u64 vco_clk,
>  			    DIV_ROUND_DOWN_ULL(curve_1_interpolated, CURVE0_MULTIPLIER)));
>  
>  	ana_cp_int_temp =
> -		DIV_ROUND_CLOSEST_ULL(DIV_ROUND_DOWN_ULL(adjusted_vco_clk1, curve_2_scaled1),
> -				      CURVE2_MULTIPLIER);
> +		div64_u64(DIV_ROUND_DOWN_ULL(adjusted_vco_clk1, curve_2_scaled1),
> +			  CURVE2_MULTIPLIER);
>  
>  	*ana_cp_int = max(1, min(ana_cp_int_temp, 127));

Unrelated to this patch, but this should be:

	*ana_cp_int = clamp(ana_cp_int_temp, 1, 127);

There's a similar issue with ana_cp_prop also in the file.


BR,
Jani.


-- 
Jani Nikula, Intel

