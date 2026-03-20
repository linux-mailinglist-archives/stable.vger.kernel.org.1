Return-Path: <stable+bounces-227512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O9ZN30fvWnG6QIAu9opvQ
	(envelope-from <stable+bounces-227512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:20:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B1F2D8A02
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 047F8300DD6F
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC838E5C1;
	Fri, 20 Mar 2026 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbOn5yc/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82538D68E
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002040; cv=none; b=byAU8+vV7d6pMDZh0wp7h2Ho4Y5TLNxj9WnqnUJQ7Vj7Xlj36HrnC/xcr0oiH3iQLBMN7IOo+wyJOBYjKH0d8EBzb1hHclO94wi5Ck97WDWbFTkod12Sv9LkKxOEghijqoVhshv1lwmTjWf1DH9SLE6SYlqtv6wO38RwthaNjw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002040; c=relaxed/simple;
	bh=DKjRbzTvTQfEwFkAhATBVoudyTIxi0tbaXwC6s6J9V4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=obAjXzIdWtY41iCHjrE36+l7puOO/1izgqOxlJb4ZgJ06m7S4IckV1cCmnHOWaDmcS+y90Wj1sUlXbak0TuwXg/CTAt3ZRF0drkPkUKn2v0nAeqLj8YQUAtrUoGYccbITRIKhPcAXh8qo9QlHez6xUhUMsLKZeplZ3/BHv+WXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbOn5yc/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774002034; x=1805538034;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DKjRbzTvTQfEwFkAhATBVoudyTIxi0tbaXwC6s6J9V4=;
  b=NbOn5yc/QVXN52YcMhXuudVKvpe9livyjj1CMUHowhWZmgeMsBCsDUb3
   WJU74ztIZVPTIqLAk9EPBaxhYq+gQQ/BvdPIadzMjybY6PGli8LYFxqhO
   6bO4MSLKHdUZvtCVsVnCslU78GeRuMnki80Y5tv/SbEXeqShHvduAEsva
   NDhnJ5R/0k0arQUdQJ85vy8USKb5RhmgMMiuaoxpScIRZYfH9W4aE0Gdc
   45sErjNoRHz6Of06TUD8e/qLSRBsQJ/bf2OclY9Em5+FT23svNzEkcwob
   iRRlgkfxasibRjlL2zI06MwjNH4UMzN1gIGQ/zLt5V3Zg15TkXyOSYBrz
   w==;
X-CSE-ConnectionGUID: Yn89WbweRvKkc8o7pucscw==
X-CSE-MsgGUID: vdKa47NAQxafIj8XXkd5Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="92658947"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="92658947"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:20:33 -0700
X-CSE-ConnectionGUID: 7/xScI95SwqrP1H7wK/1BQ==
X-CSE-MsgGUID: tFKrxceVTyy0WR1y0h/8Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218616305"
Received: from administrator-system-product-name.igk.intel.com ([10.91.214.181])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:20:30 -0700
Date: Fri, 20 Mar 2026 11:20:28 +0100 (CET)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: Imre Deak <imre.deak@intel.com>
cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    Uma Shankar <uma.shankar@intel.com>, 
    =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dp_tunnel: Fix error handling when clearing
 stream BW in atomic state
In-Reply-To: <20260320092900.13210-1-imre.deak@intel.com>
Message-ID: <bbaf3e50-4660-877f-579d-82fa406e077e@intel.com>
References: <20260320092900.13210-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1895512094-1774002031=:3548790"
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-227512-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.grzelak@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 19B1F2D8A02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1895512094-1774002031=:3548790
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 20 Mar 2026, Imre Deak wrote:
> Clearing the DP tunnel stream BW in the atomic state involves getting
> the tunnel group state, which can fail. Handle the error accordingly.
>
> This fixes at least one issue where drm_dp_tunnel_atomic_set_stream_bw()
> failed to get the tunnel group state returning -EDEADLK, which wasn't
> handled. This lead to the ctx->contended warn later in modeset_lock()
> while taking a WW mutex for another object in the same atomic state, and
> thus within the same already contended WW context.
>
> Moving intel_crtc_state_alloc() later would avoid freeing saved_state on
> the error path; this stable patch leaves that simplification for a
> follow-up.
>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.9+
> Fixes: a4efae87ecb2 ("drm/i915/dp: Compute DP tunnel BW during encoder state computation")
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
> drivers/gpu/drm/i915/display/intel_display.c  |  8 +++++++-
> .../gpu/drm/i915/display/intel_dp_tunnel.c    | 20 +++++++++++++------
> .../gpu/drm/i915/display/intel_dp_tunnel.h    | 11 ++++++----
> 3 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index ee501009a251f..882db77c0bbcd 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -4640,6 +4640,7 @@ intel_crtc_prepare_cleared_state(struct intel_atomic_state *state,
> 	struct intel_crtc_state *crtc_state =
> 		intel_atomic_get_new_crtc_state(state, crtc);
> 	struct intel_crtc_state *saved_state;
> +	int err;
>
> 	saved_state = intel_crtc_state_alloc(crtc);
> 	if (!saved_state)
> @@ -4648,7 +4649,12 @@ intel_crtc_prepare_cleared_state(struct intel_atomic_state *state,
> 	/* free the old crtc_state->hw members */
> 	intel_crtc_free_hw_state(crtc_state);
>
> -	intel_dp_tunnel_atomic_clear_stream_bw(state, crtc_state);
> +	err = intel_dp_tunnel_atomic_clear_stream_bw(state, crtc_state);
> +	if (err) {
> +		kfree(saved_state);
> +

I am unsure if the blank line above is neccessary, but I might be also
missing style guidelines. Otherwise looks good to me.

Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>

BR,
Michał

> +		return err;
> +	}
>
> 	/* FIXME: before the switch to atomic started, a new pipe_config was
> 	 * kzalloc'd. Code that depends on any field being zero should be
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
> index 1fd1ac8d556d8..7363c98172971 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
> @@ -659,19 +659,27 @@ int intel_dp_tunnel_atomic_compute_stream_bw(struct intel_atomic_state *state,
>  *
>  * Clear any DP tunnel stream BW requirement set by
>  * intel_dp_tunnel_atomic_compute_stream_bw().
> + *
> + * Returns 0 in case of success, a negative error code otherwise.
>  */
> -void intel_dp_tunnel_atomic_clear_stream_bw(struct intel_atomic_state *state,
> -					    struct intel_crtc_state *crtc_state)
> +int intel_dp_tunnel_atomic_clear_stream_bw(struct intel_atomic_state *state,
> +					   struct intel_crtc_state *crtc_state)
> {
> 	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
> +	int err;
>
> 	if (!crtc_state->dp_tunnel_ref.tunnel)
> -		return;
> +		return 0;
> +
> +	err = drm_dp_tunnel_atomic_set_stream_bw(&state->base,
> +						 crtc_state->dp_tunnel_ref.tunnel,
> +						 crtc->pipe, 0);
> +	if (err)
> +		return err;
>
> -	drm_dp_tunnel_atomic_set_stream_bw(&state->base,
> -					   crtc_state->dp_tunnel_ref.tunnel,
> -					   crtc->pipe, 0);
> 	drm_dp_tunnel_ref_put(&crtc_state->dp_tunnel_ref);
> +
> +	return 0;
> }
>
> /**
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_tunnel.h b/drivers/gpu/drm/i915/display/intel_dp_tunnel.h
> index 7f0f720e8dcad..10ab9eebcef69 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_tunnel.h
> +++ b/drivers/gpu/drm/i915/display/intel_dp_tunnel.h
> @@ -40,8 +40,8 @@ int intel_dp_tunnel_atomic_compute_stream_bw(struct intel_atomic_state *state,
> 					     struct intel_dp *intel_dp,
> 					     const struct intel_connector *connector,
> 					     struct intel_crtc_state *crtc_state);
> -void intel_dp_tunnel_atomic_clear_stream_bw(struct intel_atomic_state *state,
> -					    struct intel_crtc_state *crtc_state);
> +int intel_dp_tunnel_atomic_clear_stream_bw(struct intel_atomic_state *state,
> +					   struct intel_crtc_state *crtc_state);
>
> int intel_dp_tunnel_atomic_add_state_for_crtc(struct intel_atomic_state *state,
> 					      struct intel_crtc *crtc);
> @@ -88,9 +88,12 @@ intel_dp_tunnel_atomic_compute_stream_bw(struct intel_atomic_state *state,
> 	return 0;
> }
>
> -static inline void
> +static inline int
> intel_dp_tunnel_atomic_clear_stream_bw(struct intel_atomic_state *state,
> -				       struct intel_crtc_state *crtc_state) {}
> +				       struct intel_crtc_state *crtc_state)
> +{
> +	return 0;
> +}
>
> static inline int
> intel_dp_tunnel_atomic_add_state_for_crtc(struct intel_atomic_state *state,
> -- 
> 2.49.1
>
>
--8323329-1895512094-1774002031=:3548790--

