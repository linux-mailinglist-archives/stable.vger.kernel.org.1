Return-Path: <stable+bounces-120216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AF9A4D796
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 10:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7E51883616
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C0E1FC7F2;
	Tue,  4 Mar 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faYthQOR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E51FAC5A
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079112; cv=none; b=Kc5iHeDZiNRaRE0exfxUkKXeutcmBZQhDk+Q91AbcBt98hKcjldlrwbiYHjMNI2/Pin/c+JG+eJGYMvL0vHSY0cg9/3q7VxXQdDqZM73Yx1R81NqhUMz25PxHJR01sQQWsaJENjctS3H+Sw2iLa8qzCXYLiBvK+Vw7+QCIFIQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079112; c=relaxed/simple;
	bh=kZzyfzFncVc+ljMfhzGSqNR0b4eVDe8lzq2wq/e9HPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SL0cygrH5daavBEKBA5OnrVCBE6X+PRXj013anUB8gZ2QhH2WXXWNKZwe1vtI7DpXHb4yv/YHOh7JyxLqlo9cRlY97eLgHMWQZn7HiwZVwjPq44uht+WEQBqeFnsnqpyk05NRp7S4GnlAviumYq2UGUMst26f6sS+0Z4kGlXmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faYthQOR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741079111; x=1772615111;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=kZzyfzFncVc+ljMfhzGSqNR0b4eVDe8lzq2wq/e9HPQ=;
  b=faYthQORBhLlijhppBR4Ymb8GrhcDQEkbVZYG8s+aweU5/wSmLR/SsQp
   CkgBKJKfP67lxfxR5oj6fpw4E6DhWk2IkVYAQc6IEX5MCIz7XzeU0JlRL
   PFXhJs0u7spbUPKN1Tpi4wRMTii7eYiBTbLmm6TCkCdIX7A7vNA9VpBOU
   hD4BMbrCrjMlUGxqsWcruhzsAuF5G2GAIfuMbTblwkGpVZVkGDBgxre0m
   ptglGp5n1mVbQnbiZl+CYTLtVYT0v25hxLyTiJJWVM8wDK42Zl5Akr3VJ
   9/c0/vlDUGg4Ak52CWk9fv0ckeQylq2147t/8JZIjCgFFQS9Zrr5Bo428
   w==;
X-CSE-ConnectionGUID: L8BcblMaRBCqa3u5Oh0IPg==
X-CSE-MsgGUID: 6IIFTxsZTtiT9qxx0SyPDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="64432582"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="64432582"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:05:11 -0800
X-CSE-ConnectionGUID: 7PkM7+BKQ16RXXac+d54ZQ==
X-CSE-MsgGUID: lWhfJ4AZS2q8EEcY/2Mn5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118324175"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.192])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:05:09 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/i915/dp: Reject HBR3 when sink doesn't support
 TPS4
In-Reply-To: <20250303123952.5669-1-ville.syrjala@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250303123952.5669-1-ville.syrjala@linux.intel.com>
Date: Tue, 04 Mar 2025 11:05:05 +0200
Message-ID: <87r03dyxmm.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 03 Mar 2025, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
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

Based on the logs this drops bpp from 30 to 24 on the device. In case
anyone notices, they might wonder about the degration.

As we'll no longer hit the "8.1 Gbps link rate without sink TPS4
support" warning in intel_dp_training_pattern(), as the sink rates are
filtered earlier, I'm thinking it would be a good idea to debug log
this. Otherwise it might take a while to find out why we're rejecting
HBR3.

BR,
Jani.

>
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/5969
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 36 ++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 205ec315b413..61a58ff801a5 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -172,10 +172,22 @@ int intel_dp_link_symbol_clock(int rate)
>=20=20
>  static int max_dprx_rate(struct intel_dp *intel_dp)
>  {
> +	int max_rate;
> +
>  	if (intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
> -		return drm_dp_tunnel_max_dprx_rate(intel_dp->tunnel);
> +		max_rate =3D drm_dp_tunnel_max_dprx_rate(intel_dp->tunnel);
> +	else
> +		max_rate =3D drm_dp_bw_code_to_link_rate(intel_dp->dpcd[DP_MAX_LINK_RA=
TE]);
> +
> +	/*
> +	 * Some broken eDP sinks illegally declare support for
> +	 * HBR3 without TPS4, and are unable to produce a stable
> +	 * output. Reject HBR3 when TPS4 is not available.
> +	 */
> +	if (!drm_dp_tps4_supported(intel_dp->dpcd))
> +		max_rate =3D min(max_rate, 540000);
>=20=20
> -	return drm_dp_bw_code_to_link_rate(intel_dp->dpcd[DP_MAX_LINK_RATE]);
> +	return max_rate;
>  }
>=20=20
>  static int max_dprx_lane_count(struct intel_dp *intel_dp)
> @@ -4180,10 +4192,7 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
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
> @@ -4191,7 +4200,20 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
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
> +			if (rate >=3D 810000 && !drm_dp_tps4_supported(intel_dp->dpcd))
> +				break;
> +
> +			intel_dp->sink_rates[i] =3D rate;
>  		}
>  		intel_dp->num_sink_rates =3D i;
>  	}

--=20
Jani Nikula, Intel

