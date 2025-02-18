Return-Path: <stable+bounces-116764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF62BA39C85
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36F93A4B9C
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDE625A643;
	Tue, 18 Feb 2025 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkDV+ZL8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D95725A35C
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883090; cv=none; b=pQvshYSjuyU1dc6+EPfXqp+LSOVUy7C9EWTn4iadUUfBqCoMUSWXPqXpZ2kb1KQX21Zu1daHpdY2OiKANpJ2hnav9ipFiMLNy/A/i4fJW4M4/L1C1ddUKl5z00epjE1FhYNKE8Ick9pt1CZu23Pj0ahvX/Ih7gMVIcfv4+VteL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883090; c=relaxed/simple;
	bh=KN9nYO6fgdscblKlIndc2pPGgYUD0x9OR5V1rPZ24mI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z64A7RA6Uf/CdIQ6+LUotpZc2pPL/lAalcqCnVPKXz3i/XR4eZLv/SQbOqxHmhoOo+xZxMwqo3uPHW1GRX74qE5pTFV7EZJxbb0aafJPeAH5bTh2VUxIUSZu0HZKf8sK9/MnZJztjQsbPmpxzKEIiMw7K3hC0qvDVpbbjN9eXik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WkDV+ZL8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739883088; x=1771419088;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KN9nYO6fgdscblKlIndc2pPGgYUD0x9OR5V1rPZ24mI=;
  b=WkDV+ZL8MkImhAB58GPd0BpY41sgfVKhe1AXDpVkziftLedpN/uDVxqx
   4+fJRuyr7YH28Vb4wmlQlgWVN3oj7qXB2pDnctnMUJzPhRAUHhGUOKsER
   6bE20HGLgKyR5swz/hhjRBpdjK1PnQyKiOikxWYkUNfMGi1aMFjyUaW0Q
   p0bv/9xDo4PMh98tGacF+Utu5f739MKvRy38O4nSOdu4KhFg06m/EjtV8
   BaadOHkzjDniqN92u8lr3wOPAlaoAQeO2h9k41lSEVo3Om1pZFtJMxQg4
   B1Yix0yBxpFM74adhaH7cYElf/9/F73efAuTYgqwz1EqlcOUPfihoHevY
   Q==;
X-CSE-ConnectionGUID: SbqWgwuATlClRv0cFj3SQA==
X-CSE-MsgGUID: OaEdA6chRkqk226HTMnl1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39810488"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="39810488"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 04:51:27 -0800
X-CSE-ConnectionGUID: x/fCLpXARZ2mNnUcJxCPTA==
X-CSE-MsgGUID: 8uQ057pBR3qaAuICPEi9Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114901675"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.43])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 04:51:25 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/i915/dp: Fix error handling during 128b/132b
 link training
In-Reply-To: <20250217223828.1166093-2-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250217223828.1166093-1-imre.deak@intel.com>
 <20250217223828.1166093-2-imre.deak@intel.com>
Date: Tue, 18 Feb 2025 14:51:21 +0200
Message-ID: <875xl7o1py.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 18 Feb 2025, Imre Deak <imre.deak@intel.com> wrote:
> At the end of a 128b/132b link training sequence, the HW expects the
> transcoder training pattern to be set to TPS2 and from that to normal
> mode (disabling the training pattern). Transitioning from TPS1 directly
> to normal mode leaves the transcoder in a stuck state, resulting in
> page-flip timeouts later in the modeset sequence.
>
> Atm, in case of a failure during link training, the transcoder may be
> still set to output the TPS1 pattern. Later the transcoder is then set
> from TPS1 directly to normal mode in intel_dp_stop_link_train(), leading
> to modeset failures later as described above. Fix this by setting the
> training patter to TPS2, if the link training failed at any point.
>
> Cc: stable@vger.kernel.org # v5.18+
> Cc: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Imre Deak <imre.deak@intel.com>

No bspec link for this?

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  .../gpu/drm/i915/display/intel_dp_link_training.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> index 3cc06c916017d..11953b03bb6aa 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> @@ -1563,7 +1563,7 @@ intel_dp_128b132b_link_train(struct intel_dp *intel_dp,
>  
>  	if (wait_for(intel_dp_128b132b_intra_hop(intel_dp, crtc_state) == 0, 500)) {
>  		lt_err(intel_dp, DP_PHY_DPRX, "128b/132b intra-hop not clear\n");
> -		return false;
> +		goto out;
>  	}
>  
>  	if (intel_dp_128b132b_lane_eq(intel_dp, crtc_state) &&
> @@ -1575,6 +1575,19 @@ intel_dp_128b132b_link_train(struct intel_dp *intel_dp,
>  	       passed ? "passed" : "failed",
>  	       crtc_state->port_clock, crtc_state->lane_count);
>  
> +out:
> +	/*
> +	 * Ensure that the training pattern does get set to TPS2 even in case
> +	 * of a failure, as is the case at the end of a passing link training
> +	 * and what is expected by the transcoder. Leaving TPS1 set (and
> +	 * disabling the link train mode in DP_TP_CTL later from TPS1 directly)
> +	 * would result in a stuck transcoder HW state and flip-done timeouts
> +	 * later in the modeset sequence.
> +	 */
> +	if (!passed)
> +		intel_dp_program_link_training_pattern(intel_dp, crtc_state,
> +						       DP_PHY_DPRX, DP_TRAINING_PATTERN_2);
> +
>  	return passed;
>  }

-- 
Jani Nikula, Intel

