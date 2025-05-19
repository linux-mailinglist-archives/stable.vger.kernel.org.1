Return-Path: <stable+bounces-144866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B7ABC002
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A244A4EA1
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9377280CF1;
	Mon, 19 May 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uh/kv5rh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899D27B4FA
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662795; cv=none; b=rGbMZ6L7I97aVGIEaki0/NPi2IiYGci8NnaBDgfA4dKIWNBjuYitScnx6flxsohKtf/VIIEy9ichIviFt5ltfTV3mQWSWeRs/bN25128j9z2Okw36qL8thdlI8YqfAzV9nnsKsMVn8pLPRiN7raiEc2Ae//IAhSj1v6k8i9rVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662795; c=relaxed/simple;
	bh=pUjXAMbBLib/2zr+K4Bj+FQkDfDaNdUaNv7OI5MSlvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HyFDytcxKE6Xhcwy/dU/jo3mKvuGEUliS3s6nI8zz9IipbkRr4PIAPmJYa3i8u9/khaZ/m2c1fFL+QAdDDs3l1r6YHtbm1ZKgkpDKS3h/2QfaEqgg50AVbzh0nbjJDvjhwipKhAQIuV1B2xRSzEJt9jEcW6kN9t7G7oaNHEAJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uh/kv5rh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747662794; x=1779198794;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pUjXAMbBLib/2zr+K4Bj+FQkDfDaNdUaNv7OI5MSlvU=;
  b=Uh/kv5rh8KSXWRudClN6SDo8nd0Rk6KBZmHbudnkGCAChRJU12ijDfDx
   5Ju79JY3WzqyHvDnk9JZaFDAcVkkdT5AhiQ1uKKcphqfryLPamjHLgLWC
   aSDtBrZADNoLBa1z7zLsZOaMZ5wnUuMz8BGDA7OAvPw4zozeIkUIL4VEy
   m6ymNBIqJr9fGDZDl/sNGfGhVG1u1TY8IsxLTe3yZMwd0FQb+WwWihx9a
   KHKuqrenGPnfrqewjnLHhclK061/8T54iFnPyLXND3LuwnLw3HDuD+NAm
   8lOYd7GAsymR3RJBveyaYnWI2I9bTETfc3rbJq9Ps7To3vBGAxxCCfuC4
   Q==;
X-CSE-ConnectionGUID: AGtC2HYlQiSjf275Pkd+8w==
X-CSE-MsgGUID: 8u0OvuzoSd2YjEQHyPjMuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="72069346"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="72069346"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:53:13 -0700
X-CSE-ConnectionGUID: GBhNIDYgTlWmYGLwyUnJHA==
X-CSE-MsgGUID: AjpI7fXLQCuioAUCsIlvGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139270242"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:53:11 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/dp_mst: Work around Thunderbolt sink
 disconnect after SINK_COUNT_ESI read
In-Reply-To: <20250519133417.1469181-1-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250516170946.1313722-1-imre.deak@intel.com>
 <20250519133417.1469181-1-imre.deak@intel.com>
Date: Mon, 19 May 2025 16:53:08 +0300
Message-ID: <87zff8u2pn.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 19 May 2025, Imre Deak <imre.deak@intel.com> wrote:
> Due to a problem in the iTBT DP-in adapter's firmware the sink on a TBT
> link may get disconnected inadvertently if the SINK_COUNT_ESI and the
> DP_LINK_SERVICE_IRQ_VECTOR_ESI0 registers are read in a single AUX
> transaction. Work around the issue by reading these registers in
> separate transactions.
>
> The issue affects MTL+ platforms and will be fixed in the DP-in adapter
> firmware, however releasing that firmware fix may take some time and is
> not guaranteed to be available for all systems. Based on this apply the
> workaround on affected platforms.
>
> See HSD #13013007775.
>
> v2: Cc'ing Mika Westerberg.

In general, please don't resend just for the sake of adding a Cc. It
triggers a full CI rerun.

BR,
Jani.

>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13760
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14147
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 21297bc4cc00d..208a953b04a2f 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4538,6 +4538,23 @@ intel_dp_mst_disconnect(struct intel_dp *intel_dp)
>  static bool
>  intel_dp_get_sink_irq_esi(struct intel_dp *intel_dp, u8 *esi)
>  {
> +	struct intel_display *display = to_intel_display(intel_dp);
> +
> +	/*
> +	 * Display WA for HSD #13013007775: mtl/arl/lnl
> +	 * Read the sink count and link service IRQ registers in separate
> +	 * transactions to prevent disconnecting the sink on a TBT link
> +	 * inadvertently.
> +	 */
> +	if (IS_DISPLAY_VER(display, 14, 20) && !display->platform.battlemage) {
> +		if (drm_dp_dpcd_read(&intel_dp->aux, DP_SINK_COUNT_ESI, esi, 3) != 3)
> +			return false;
> +
> +		/* DP_SINK_COUNT_ESI + 3 == DP_LINK_SERVICE_IRQ_VECTOR_ESI0 */
> +		return drm_dp_dpcd_readb(&intel_dp->aux, DP_LINK_SERVICE_IRQ_VECTOR_ESI0,
> +					 &esi[3]) == 1;
> +	}
> +
>  	return drm_dp_dpcd_read(&intel_dp->aux, DP_SINK_COUNT_ESI, esi, 4) == 4;
>  }

-- 
Jani Nikula, Intel

