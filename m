Return-Path: <stable+bounces-223322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OES4IAqpqmmzVAEAu9opvQ
	(envelope-from <stable+bounces-223322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 11:14:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D735E21E86E
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 11:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5082E308DDA9
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A9C367F3F;
	Fri,  6 Mar 2026 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0GzFVLP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326035F17F
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791970; cv=none; b=tv/9kdOFIAokwkjy5z7mdlM5ZKMkAZvgYuHhUn5bzIoK9xb8BWPrVY0RzB83W92MKcU9yHNJE8c+xGtjI6Ivy0Z0/Nk3yr3NRJJftDAI2zO/X3Ws2MDW5+FdEruuI/IheBuLRV9+eDfk2HEgxCwIO5nQK6kN9eGNyGqOzzBxYAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791970; c=relaxed/simple;
	bh=vLTWreXrcuLexzfs+oXxVXznKD7YNAwC4CLC/PfG1/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rsgd2Rv2r8Lokwd2bWgp8IQevTBonL9dFCaPYGh9Nkt7NNW9jV62QE5wWRdyQVj0N69r6/Fy7vJe8mzsZDDfnfmLxemaqmwzzPmk3sho7mqymop1nOpI3cg/SvZy33GW4J/O1dcDQXJqe5ivQ3zhOtS4dbK+GXNGScx1NOcqXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0GzFVLP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772791967; x=1804327967;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vLTWreXrcuLexzfs+oXxVXznKD7YNAwC4CLC/PfG1/U=;
  b=h0GzFVLP1BQRXUGPVVR4KSVJkVUXQM21YdQmn3vyixQsYB7b2B7OsjNt
   MgF1U0OaixjUSttAZcyzXu8CoxHeClo6pcey52egfvy+Ot3dmP01heEoJ
   TYRzoqnJBCrDW9oqaBm2ULa4f6bKjPI6yn8bqr7H82MhcdGkB1ZgRlI4Y
   VOMucFSnwXefDpC8/hME033/ajF9VOZkPR23Ad7so20O4lKRfpdsVSUTH
   fcK7W0gt9Rgu3CaVaQQ6Ef8A9wDWs2b0gEfPA0yXREjtMIC6/ORCSI6Zb
   gD6sz9IeojAoy24kVhJRxwOnKOc8IWlSumrNRqfkBB3j/A9um2yXnUst7
   g==;
X-CSE-ConnectionGUID: yqn+xhfiQYWKm5KnRmTX6g==
X-CSE-MsgGUID: pMpFaO/5SBu9hWldr3eyHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77499082"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="77499082"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 02:12:46 -0800
X-CSE-ConnectionGUID: fOJM/jljSVurv+s/oGPg7Q==
X-CSE-MsgGUID: 0YbGUMOCRWOZcZ/R6LsLdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="241977594"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.191])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 02:12:44 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Mohammed Thasleem <mohammed.thasleem@intel.com>, Tao Liu
 <ltao@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/dmc: fix an unlikely NULL pointer deference
 at probe
In-Reply-To: <20260302174849.1541350-1-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20251202183950.2450315-1-jani.nikula@intel.com>
 <20260302174849.1541350-1-imre.deak@intel.com>
Date: Fri, 06 Mar 2026 12:12:41 +0200
Message-ID: <c24d25703c51fe7df93b16762bc82898b0485e98@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D735E21E86E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223322-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

On Mon, 02 Mar 2026, Imre Deak <imre.deak@intel.com> wrote:
> intel_dmc_update_dc6_allowed_count() oopses when DMC hasn't been
> initialized, and dmc is thus NULL.
>
> That would be the case when the call path is
> intel_power_domains_init_hw() -> {skl,bxt,icl}_display_core_init() ->
> gen9_set_dc_state() -> intel_dmc_update_dc6_allowed_count(), as
> intel_power_domains_init_hw() is called *before* intel_dmc_init().
>
> However, gen9_set_dc_state() calls intel_dmc_update_dc6_allowed_count()
> conditionally, depending on the current and target DC states. At probe,
> the target is disabled, but if DC6 is enabled, the function is called,
> and an oops follows. Apparently it's quite unlikely that DC6 is enabled
> at probe, as we haven't seen this failure mode before.
>
> It is also strange to have DC6 enabled at boot, since that would require
> the DMC firmware (loaded by BIOS); the BIOS loading the DMC firmware and
> the driver stopping / reprogramming the firmware is a poorly specified
> sequence and as such unlikely an intentional BIOS behaviour. It's more
> likely that BIOS is leaving an unintentionally enabled DC6 HW state
> behind (without actually loading the required DMC firmware for this).
>
> The tracking of the DC6 allowed counter only works if starting /
> stopping the counter depends on the _SW_ DC6 state vs. the current _HW_
> DC6 state (since stopping the counter requires the DC5 counter captured
> when the counter was started). Thus, using the HW DC6 state is incorrect
> and it also leads to the above oops. Fix both issues by using the SW DC6
> state for the tracking.
>
> This is v2 of the fix originally sent by Jani, updated based on the
> first References: discussion below.
>
> Link: https://lore.kernel.org/all/3626411dc9e556452c432d0919821b76d9991217@intel.com
> Link: https://lore.kernel.org/all/20260228130946.50919-2-ltao@redhat.com
> Fixes: 88c1f9a4d36d ("drm/i915/dmc: Create debugfs entry for dc6 counter")
> Cc: Mohammed Thasleem <mohammed.thasleem@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Tao Liu <ltao@redhat.com>
> Cc: <stable@vger.kernel.org> # v6.16+
> Signed-off-by: Imre Deak <imre.deak@intel.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

However, I still think the whole gen9_set_dc_state() is a bit fragile
wrt DMC loaded or not. Pretty much everything else wraps the relevant
parts within intel_dmc_has_payload(), and it's obvious what's going
on. The comment for the function primarily talks about DMC but there's
not even a mention of the possibility DMC is not loaded.

I also think intel_dmc_update_dc6_allowed_count() is fragile in oopsing
when DMC is not loaded, and I still think that should be fixed too.

The patch at hand looks like it fixes the root cause, but I still think
the parts around it could use some more robustness, if only to make it
evident to the reader what the possible conditions are.


BR,
Jani.


> ---
>  drivers/gpu/drm/i915/display/intel_display_power_well.c | 2 +-
>  drivers/gpu/drm/i915/display/intel_dmc.c                | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_power_well.c b/drivers/gpu/drm/i915/display/intel_display_power_well.c
> index 9c8d29839cafc..969b2c421d308 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_power_well.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_power_well.c
> @@ -852,7 +852,7 @@ void gen9_set_dc_state(struct intel_display *display, u32 state)
>  			power_domains->dc_state, val & mask);
>  
>  	enable_dc6 = state & DC_STATE_EN_UPTO_DC6;
> -	dc6_was_enabled = val & DC_STATE_EN_UPTO_DC6;
> +	dc6_was_enabled = power_domains->dc_state & DC_STATE_EN_UPTO_DC6;
>  	if (!dc6_was_enabled && enable_dc6)
>  		intel_dmc_update_dc6_allowed_count(display, true);
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
> index c3b411259a0c5..90ba932d940ac 100644
> --- a/drivers/gpu/drm/i915/display/intel_dmc.c
> +++ b/drivers/gpu/drm/i915/display/intel_dmc.c
> @@ -1598,8 +1598,7 @@ static bool intel_dmc_get_dc6_allowed_count(struct intel_display *display, u32 *
>  		return false;
>  
>  	mutex_lock(&power_domains->lock);
> -	dc6_enabled = intel_de_read(display, DC_STATE_EN) &
> -		      DC_STATE_EN_UPTO_DC6;
> +	dc6_enabled = power_domains->dc_state & DC_STATE_EN_UPTO_DC6;
>  	if (dc6_enabled)
>  		intel_dmc_update_dc6_allowed_count(display, false);

-- 
Jani Nikula, Intel

