Return-Path: <stable+bounces-116766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E124A39CFA
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D381898730
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EFD2690DF;
	Tue, 18 Feb 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTe3bZQB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB02690CD
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883921; cv=none; b=qgLgfFJYOgV0RSlfGGbtjE0+UkwvCVkDU55b+HjTBM38zcIHWgDVMswAYLng5BkqubvS3Bv1DoI4vQLzctv2DFm/NmsSIXdy37QpaZCBhqsbgBbpoKwU3CNsL+f4DedYreahLuSVCYIQkhv7CGizy5KkAbKU4qpheyPzIXqIqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883921; c=relaxed/simple;
	bh=71kS2+48mrgYJgp15fTP57cbCUmSXoX2GS52jWwTd6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm4UnfpVtO3PClxgkB4sgGD9ji4jX5VoU5/Qcg1QfEAtkabz+1eZX+JNNutojyHzDGsD0NOnStadgwgtPOJMM4/Tun5+JvwywVszdGAE6nGr6QQoj1SH+WTBDfnOxlHNeCwIZxlYfC8pFJNMUfHroRi3j8k4GUHA1LgAoVFhkJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTe3bZQB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739883919; x=1771419919;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=71kS2+48mrgYJgp15fTP57cbCUmSXoX2GS52jWwTd6k=;
  b=iTe3bZQB0u2g1ZHUl+7cbbmV054rkYMo6nhCiAVeaN6Isq7GEE4imgQ6
   l+y96RraL4PS5IcWc34YAzVc8LfIjDAqhjhqPEGbBLvC5LXb5QpBBau54
   bTo9rk7W6JSQiEqUvx8uVljogXuNykBAoxPVt9LLNV//h+q2QbHZTWHwM
   n3rOwLIsXnnmPXkX5DQX0sZqx/rgB+zirQiFCFLN821fQvhb8xuSpleOC
   rCQ0//qgx48ZGIi+Hndj51+IQYJUlsUPreAgBderQbFm37qKWZVDvV1Ix
   2W74v6gXbSqgXSQYc3ELO/X9a2tWKyVIH28NsHcjlef6Ptsbo4vguNCmb
   A==;
X-CSE-ConnectionGUID: c/wgJ0oWRlWE3lXGLrxK2w==
X-CSE-MsgGUID: Z/qN32C6Q6ilKpiJ+4fA6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52007613"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52007613"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 05:05:18 -0800
X-CSE-ConnectionGUID: cF6gCwh6T9SGTT0NHqU7sQ==
X-CSE-MsgGUID: 6VZhtQpVSA6Je94QwbgT9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114313710"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 05:05:17 -0800
Date: Tue, 18 Feb 2025 15:06:13 +0200
From: Imre Deak <imre.deak@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/i915/dp: Fix error handling during 128b/132b
 link training
Message-ID: <Z7SFxRKb9_H0fAjG@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20250217223828.1166093-1-imre.deak@intel.com>
 <20250217223828.1166093-2-imre.deak@intel.com>
 <875xl7o1py.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xl7o1py.fsf@intel.com>

On Tue, Feb 18, 2025 at 02:51:21PM +0200, Jani Nikula wrote:
> On Tue, 18 Feb 2025, Imre Deak <imre.deak@intel.com> wrote:
> > At the end of a 128b/132b link training sequence, the HW expects the
> > transcoder training pattern to be set to TPS2 and from that to normal
> > mode (disabling the training pattern). Transitioning from TPS1 directly
> > to normal mode leaves the transcoder in a stuck state, resulting in
> > page-flip timeouts later in the modeset sequence.
> >
> > Atm, in case of a failure during link training, the transcoder may be
> > still set to output the TPS1 pattern. Later the transcoder is then set
> > from TPS1 directly to normal mode in intel_dp_stop_link_train(), leading
> > to modeset failures later as described above. Fix this by setting the
> > training patter to TPS2, if the link training failed at any point.
> >
> > Cc: stable@vger.kernel.org # v5.18+
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Signed-off-by: Imre Deak <imre.deak@intel.com>
> 
> No bspec link for this?

The only clue I see for this is PTL's (and other platforms') modeset
page (68849) "Enable Sequence" 6. n.: "If DP v2.0/128b, set DP_TP_CTL
link training pattern 2."

Since setting TPS2 is normally part of the link training (described by
6. l./m.), so the only reason mentioning it as a separate step for
128b/132b (vs. 8b/10b for which it is not mentioned), could be this HW
behavior.

It's obscure imo, could've been explained in the spec better. I can
clarify this in the commit log and also file a bspec ticket for it.

> Acked-by: Jani Nikula <jani.nikula@intel.com>

Thanks.

> 
> > ---
> >  .../gpu/drm/i915/display/intel_dp_link_training.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > index 3cc06c916017d..11953b03bb6aa 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > @@ -1563,7 +1563,7 @@ intel_dp_128b132b_link_train(struct intel_dp *intel_dp,
> >  
> >  	if (wait_for(intel_dp_128b132b_intra_hop(intel_dp, crtc_state) == 0, 500)) {
> >  		lt_err(intel_dp, DP_PHY_DPRX, "128b/132b intra-hop not clear\n");
> > -		return false;
> > +		goto out;
> >  	}
> >  
> >  	if (intel_dp_128b132b_lane_eq(intel_dp, crtc_state) &&
> > @@ -1575,6 +1575,19 @@ intel_dp_128b132b_link_train(struct intel_dp *intel_dp,
> >  	       passed ? "passed" : "failed",
> >  	       crtc_state->port_clock, crtc_state->lane_count);
> >  
> > +out:
> > +	/*
> > +	 * Ensure that the training pattern does get set to TPS2 even in case
> > +	 * of a failure, as is the case at the end of a passing link training
> > +	 * and what is expected by the transcoder. Leaving TPS1 set (and
> > +	 * disabling the link train mode in DP_TP_CTL later from TPS1 directly)
> > +	 * would result in a stuck transcoder HW state and flip-done timeouts
> > +	 * later in the modeset sequence.
> > +	 */
> > +	if (!passed)
> > +		intel_dp_program_link_training_pattern(intel_dp, crtc_state,
> > +						       DP_PHY_DPRX, DP_TRAINING_PATTERN_2);
> > +
> >  	return passed;
> >  }
> 
> -- 
> Jani Nikula, Intel

