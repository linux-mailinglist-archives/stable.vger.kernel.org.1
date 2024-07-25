Return-Path: <stable+bounces-61365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA793BDD3
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 10:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D85B2113E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A26D167D8C;
	Thu, 25 Jul 2024 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSb7ZlZ1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675B1CD11;
	Thu, 25 Jul 2024 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895450; cv=none; b=t2mmWt6QTofdrXCdaNwOfJ2XhDHRaGQFUp9FxyOj1QUnuvKjl0az+75k3fiwJ5fJqRTlI2/cz5A10m2TBthBjZdnwZDdOqCm76OV7m/s0TYlCGyqt8WAt2A3+2lyOTuywAT2UCkgq4qVIOdw4paYDjpXKGGfH0jF21xfteB0HHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895450; c=relaxed/simple;
	bh=XlFLf44zMCEWWpHYzsOrImUWBiACkIazF5lyyDSgeR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RAO4phOJQ/XrEgDddIy0/CdUhdurFuxrvdn8EIo6Qj3YFAV4lMIL1G1JlXDO2fAE134fhgmy5L9HvPXQjCmpW/xi97gso5WEMdtHjjKSjk9Cv3SoSrra84o6uFLaz866f2lo7DZNlEnJN+Blx3H78zJX9mlCA4jAdceocq6Y6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSb7ZlZ1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721895448; x=1753431448;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=XlFLf44zMCEWWpHYzsOrImUWBiACkIazF5lyyDSgeR4=;
  b=NSb7ZlZ1nrJgMFp1RIeSe5gE0a0WsHK6SSa1H2jP8FGdcUfTgi790+r2
   bl6ZTgTgLThdaDT9Pw0vYANXeWjXD0IQnMGppsVdJftumY6MZ0eOzyPNa
   XB0jalB+FI3SBYTsm2TUiPCtiiHcKG/PgylL3dlFAgXABltntHvX7L+PB
   wGDLVPUEtMDA9rwKPzPkV7mF2RCq4yXsE/pqiGDGj5jhBz3IktpdW/e8H
   HW30Nu0pOt3pBbtwTetP3eoffC0BWsrsOIZRWZ6UheHgqicbVJABxMJKb
   Xq1TVAqDwH8u1J6AJi3y+A9vA8/hBcpLAWMj+ZgDX6heNdalzmgj/c6Zp
   w==;
X-CSE-ConnectionGUID: HahnwPIQQCKKG8iX6EoyRQ==
X-CSE-MsgGUID: 532oOGxLRPWo9EiNzCEcDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="45039862"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="45039862"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 01:17:27 -0700
X-CSE-ConnectionGUID: usovP4+WT8GJg3SZ6+7GvQ==
X-CSE-MsgGUID: 6WMOp1bIS9mZihOgavNtkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="57149891"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.243])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 01:17:22 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Fix possible int overflow in
 skl_ddi_calculate_wrpll()
In-Reply-To: <20240724184911.12250-1-n.zhandarovich@fintech.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240724184911.12250-1-n.zhandarovich@fintech.ru>
Date: Thu, 25 Jul 2024 11:17:17 +0300
Message-ID: <87sevxzy0i.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 24 Jul 2024, Nikita Zhandarovich <n.zhandarovich@fintech.ru> wrote:
> On the off chance that clock value ends up being too high (by means
> of skl_ddi_calculate_wrpll() having benn called with big enough
> value of crtc_state->port_clock * 1000), one possible consequence
> may be that the result will not be able to fit into signed int.
>
> Fix this, albeit unlikely, issue by first casting one of the operands
> to u32, then to u64, and thus avoid causing an integer overflow.

Okay, thanks for the patch, but please let's not do this.

Currently the highest possible port clock is 2000000 kHz, and 1000 times
that fits into 31 bits. When we need to support higher clocks, we'll
need to handle this. But not like this.

That (u64)(u32) is just too unintuitive, and assumes the caller has
already passed in something that has overflown. People are just going to
pause there, and wonder what's going on.

If we want to appease the static analyzer, I think a better approach
would be to change the parameter to u64 clock_hz, and have the caller
do:

	ret = skl_ddi_calculate_wrpll((u64)crtc_state->port_clock * 1000,
				      i915->display.dpll.ref_clks.nssc, &wrpll_params);

BR,
Jani.



>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: fe70b262e781 ("drm/i915: Move a bunch of stuff into rodata from the stack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> Fixes: tag is not entirely correct, as I can't properly identify the
> origin with all the code movement. I opted out for using the most
> recent topical commit instead.
>
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> index 90998b037349..46d4dac6c491 100644
> --- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> +++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> @@ -1683,7 +1683,7 @@ skl_ddi_calculate_wrpll(int clock /* in Hz */,
>  	};
>  	unsigned int dco, d, i;
>  	unsigned int p0, p1, p2;
> -	u64 afe_clock = clock * 5; /* AFE Clock is 5x Pixel clock */
> +	u64 afe_clock = (u64)(u32)clock * 5; /* AFE Clock is 5x Pixel clock */
>  
>  	for (d = 0; d < ARRAY_SIZE(dividers); d++) {
>  		for (dco = 0; dco < ARRAY_SIZE(dco_central_freq); dco++) {

-- 
Jani Nikula, Intel

