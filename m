Return-Path: <stable+bounces-19302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C384E479
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 16:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7101C23BEA
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE767CF15;
	Thu,  8 Feb 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BY1EkPIR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F766BFA7
	for <stable@vger.kernel.org>; Thu,  8 Feb 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407774; cv=none; b=SHvbwbOW2UMnMnScvHZcDdkdc5O+JeajXefp5dsgvIBMy+S4Uqty49tK91kKgfN17RZb5IKWzOU7lp2ekYU2JUF67gjqiS77M++Pi2LwaYXl9oh3EfX70apv8teaDRYoi+VuJ726X5n7bFSGnhdz6XTkgBGOffU2IAeTyHVP8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407774; c=relaxed/simple;
	bh=lAwzNKO/gag6aJ20qqU1kWN6RLF7uPPEhVquuaSE/MQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dbr6JnFHe9SqqQNgFADt8I5osCE4OcqE+jFllfRmqWTfxLYnHgTBO4CT5hPQSROqZ7UDx8iWp5QTbfS1vGy2Dj6fCu6wnl8yQ73xyPiJFSAbiEBjLyaOoT78F8qVdMIAIoEJ8VpN5KK7st+kz3aL0yrd+CwB7xU5sPWqmgmH+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BY1EkPIR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707407770; x=1738943770;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=lAwzNKO/gag6aJ20qqU1kWN6RLF7uPPEhVquuaSE/MQ=;
  b=BY1EkPIRYgUql0X5i2KSmt2fPFksEa7wAJIF92QWZvGpsZPpXICHZ0wF
   ojoFpo+Npn9lPSpMfPgVqU+8Ish6Iaqih7gNPYzzxiAuTua8YLgTKfBB4
   OfO7AGoTWnkmLdFjua1uPZmiakydvn3lCFF9TjCXB+uDhfRpkq4phSHpN
   Ktbg0Tj4FsRcprfSKgRo/1Yi4aSwQcf1JxlxLahs9gVANjoGPzB9sQMJN
   WFA5aYLUbXyCPxAq2vLZc4wOMon55F2Dx02E/BevOGlWIjbJTAqH14A6b
   1R4GUSEtQhrrLZmD7nFwKmbsum4J7SkCrRlGbCkUImuH80h+X5S4puBth
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1384715"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1384715"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 07:56:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1682539"
Received: from unknown (HELO localhost) ([10.237.66.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 07:56:00 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dp: Limit SST link rate to <=8.1Gbps
In-Reply-To: <20240208154552.14545-1-ville.syrjala@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240208154552.14545-1-ville.syrjala@linux.intel.com>
Date: Thu, 08 Feb 2024 17:55:53 +0200
Message-ID: <87le7var1y.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 08 Feb 2024, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> Limit the link rate to HBR3 or below (<=3D8.1Gbps) in SST mode.
> UHBR (10Gbps+) link rates require 128b/132b channel encoding
> which we have not yet hooked up into the SST/no-sideband codepaths.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

My bad.

I guess this is the smallest most isolated fix for stable.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>



> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index ab415f41924d..5045c34a16be 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -2356,6 +2356,9 @@ intel_dp_compute_config_limits(struct intel_dp *int=
el_dp,
>  	limits->min_rate =3D intel_dp_common_rate(intel_dp, 0);
>  	limits->max_rate =3D intel_dp_max_link_rate(intel_dp);
>=20=20
> +	/* FIXME 128b/132b SST support missing */
> +	limits->max_rate =3D min(limits->max_rate, 810000);
> +
>  	limits->min_lane_count =3D 1;
>  	limits->max_lane_count =3D intel_dp_max_lane_count(intel_dp);

--=20
Jani Nikula, Intel

