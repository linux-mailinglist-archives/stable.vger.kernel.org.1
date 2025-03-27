Return-Path: <stable+bounces-126830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB872A72AA1
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 08:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510501896FA1
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9281FF61D;
	Thu, 27 Mar 2025 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUp2PcTJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850F1FF613
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743060964; cv=none; b=n192VvDwq8I9Mw0Kk+Ea7LpY23ChqX1tv4HTtqogCcTKjtBJJ9klIucBRoW7yYW/KtGHwEyP04fZUv/B/OStelNx1Ez0xT3EmopSYPdIgfTHJONblq/5+A8+NxHWqC9IBFDVJ8gJkxftJrO9t6SlcV4lnKhP1GW2eCfplqoUbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743060964; c=relaxed/simple;
	bh=yrY8VfjNeosBxXXkOauKnIhZOnR93pLSzmdIVaLmK3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dl/h54uNrkR/c4Fl7cuUsqIgdZ+1Fd4+Jh4G78xeqLcqrJURmuUfGhpg8meoTyAyAQKJgMzLU5MrvNE0RQ8fqp10TFOQ1Tpe2lnVtBh6KuOKn0yIHxulqDSXkfWZ53po1eMk1BIIkjoT7iTZsJ4gp7LseeLNJeeHOYFg5Alk3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUp2PcTJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743060962; x=1774596962;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=yrY8VfjNeosBxXXkOauKnIhZOnR93pLSzmdIVaLmK3o=;
  b=YUp2PcTJRlL40XbEeeH6NlaAoKNl5WaILSx+S2vMJf3WaX3mGSfwCxO1
   259QjtbWJUcnRIV/8dHrZQ44NOc0ohRllhBhyjdH/wRveOeajJJbSWkQg
   Wr9p32M2Jn029J0FpMAdVLEycFuGfcrDey115Or6Nt3fiQxhWq0Z2gKjR
   ij57rzTHaAuxQSrDL3U9xQ0z/gUUWSfbf1PUMq35p3zYRxR/FgFkhb2qh
   kILmcBNo9hvYHqMW9r16pMGoQO9QVJsZc8fcgeSThmd03WkwjZWQ5Whyb
   7lRZm/xMh4oSWVw2hvjBgKhG6T0zDZ2LgogmsJE14RYdT9aoCFGtGUH1S
   g==;
X-CSE-ConnectionGUID: J6e3ltYgSkCbYagGW7Vcjw==
X-CSE-MsgGUID: 9hGYRXnaQ1eVl2h6LNCBTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44297070"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="44297070"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 00:36:01 -0700
X-CSE-ConnectionGUID: rvqhyw/1TaqgLYess/peMw==
X-CSE-MsgGUID: 7pjgDcxfTh+aro5gLqyw8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="125029781"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.17])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 00:35:59 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/i915/dp: Reject HBR3 when sink doesn't
 support TPS4
In-Reply-To: <20250306210740.11886-1-ville.syrjala@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250303123952.5669-1-ville.syrjala@linux.intel.com>
 <20250306210740.11886-1-ville.syrjala@linux.intel.com>
Date: Thu, 27 Mar 2025 09:35:56 +0200
Message-ID: <87h63f6i3n.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 06 Mar 2025, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> According to the DP spec TPS4 is mandatory for HBR3. We have
> however seen some broken eDP sinks that violate this and
> declare support for HBR3 without TPS4 support.
>
> At least in the case of the icl Dell XPS 13 7390 this results
> in an unstable output.
>
> Reject HBR3 when TPS4 supports is unavailable on the sink.
>
> v2: Leave breadcrumbs in dmesg to avoid head scratching (Jani)
>
> Cc: stable@vger.kernel.org
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/5969
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 49 +++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 205ec315b413..70f5d1465f81 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -172,10 +172,28 @@ int intel_dp_link_symbol_clock(int rate)
>=20=20
>  static int max_dprx_rate(struct intel_dp *intel_dp)
>  {
> +	struct intel_display *display =3D to_intel_display(intel_dp);
> +	struct intel_encoder *encoder =3D &dp_to_dig_port(intel_dp)->base;
> +	int max_rate;
> +
>  	if (intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
> -		return drm_dp_tunnel_max_dprx_rate(intel_dp->tunnel);
> +		max_rate =3D drm_dp_tunnel_max_dprx_rate(intel_dp->tunnel);
> +	else
> +		max_rate =3D drm_dp_bw_code_to_link_rate(intel_dp->dpcd[DP_MAX_LINK_RA=
TE]);
>=20=20
> -	return drm_dp_bw_code_to_link_rate(intel_dp->dpcd[DP_MAX_LINK_RATE]);
> +	/*
> +	 * Some broken eDP sinks illegally declare support for
> +	 * HBR3 without TPS4, and are unable to produce a stable
> +	 * output. Reject HBR3 when TPS4 is not available.
> +	 */
> +	if (max_rate >=3D 810000 && !drm_dp_tps4_supported(intel_dp->dpcd)) {
> +		drm_dbg_kms(display->drm,
> +			    "[ENCODER:%d:%s] Rejecting HBR3 due to missing TPS4 support\n",
> +			    encoder->base.base.id, encoder->base.name);
> +		max_rate =3D 540000;
> +	}
> +
> +	return max_rate;
>  }
>=20=20
>  static int max_dprx_lane_count(struct intel_dp *intel_dp)
> @@ -4170,6 +4188,9 @@ static void intel_edp_mso_init(struct intel_dp *int=
el_dp)
>  static void
>  intel_edp_set_sink_rates(struct intel_dp *intel_dp)
>  {
> +	struct intel_display *display =3D to_intel_display(intel_dp);
> +	struct intel_encoder *encoder =3D &dp_to_dig_port(intel_dp)->base;
> +
>  	intel_dp->num_sink_rates =3D 0;
>=20=20
>  	if (intel_dp->edp_dpcd[0] >=3D DP_EDP_14) {
> @@ -4180,10 +4201,7 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
>  				 sink_rates, sizeof(sink_rates));
>=20=20
>  		for (i =3D 0; i < ARRAY_SIZE(sink_rates); i++) {
> -			int val =3D le16_to_cpu(sink_rates[i]);
> -
> -			if (val =3D=3D 0)
> -				break;
> +			int rate;
>=20=20
>  			/* Value read multiplied by 200kHz gives the per-lane
>  			 * link rate in kHz. The source rates are, however,
> @@ -4191,7 +4209,24 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
>  			 * back to symbols is
>  			 * (val * 200kHz)*(8/10 ch. encoding)*(1/8 bit to Byte)
>  			 */
> -			intel_dp->sink_rates[i] =3D (val * 200) / 10;
> +			rate =3D le16_to_cpu(sink_rates[i]) * 200 / 10;
> +
> +			if (rate =3D=3D 0)
> +				break;
> +
> +			/*
> +			 * Some broken eDP sinks illegally declare support for
> +			 * HBR3 without TPS4, and are unable to produce a stable
> +			 * output. Reject HBR3 when TPS4 is not available.
> +			 */
> +			if (rate >=3D 810000 && !drm_dp_tps4_supported(intel_dp->dpcd)) {
> +				drm_dbg_kms(display->drm,
> +					    "[ENCODER:%d:%s] Rejecting HBR3 due to missing TPS4 support\n",
> +					    encoder->base.base.id, encoder->base.name);
> +				break;
> +			}
> +
> +			intel_dp->sink_rates[i] =3D rate;
>  		}
>  		intel_dp->num_sink_rates =3D i;
>  	}

--=20
Jani Nikula, Intel

