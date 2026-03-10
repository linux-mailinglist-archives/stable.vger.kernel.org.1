Return-Path: <stable+bounces-223790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI+FICHZr2kkdAIAu9opvQ
	(envelope-from <stable+bounces-223790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:41:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D92247723
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E20F30EDE26
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0EC42E01D;
	Tue, 10 Mar 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYXIDepB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A152C029C
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132028; cv=none; b=d7OUDyIgJ0nVgUCy0dK1zVi1xY9aNPjUg8kmrbSAerHG6jnU0ntT6DkHt3XbrMvy3odIjJF8h4gVm+d6zwjCa4UN/T9TARMwo3yIi5iCFJ3oSqzxnM4MW57b+ubkxTUtINRrfLzbXSFpcZRPK2WCOMsAXlvgSCpXSfMPQE0s9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132028; c=relaxed/simple;
	bh=R4HrxgS+VKtXG+GIOR9QsX24WrXAaEul/9FnFSXu4ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgcyCP8/wXfvHyXMIdwwi51QnNUhTAUcoAK1tcsjl3OQdKnP2Q5BHCTAksBh08feWwXpceYr1dwYMNctz+zJzEfslxWDMG51+ZOmIZIxL/iO0Rfv5v1YWJXmar2pt+0MwsRYsHtpFMDtIykg5QBbyuXvxtczbsSoFC7JD1ldRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYXIDepB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773132025; x=1804668025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R4HrxgS+VKtXG+GIOR9QsX24WrXAaEul/9FnFSXu4ys=;
  b=LYXIDepBo/mstBvmVM7YOsHQaBwfMmJ0LD/sdGU1nguhj0iF5d35tuit
   OIvGBl+IhO7rcDxKtJDwZZrZAt7KQDzrB/qWhwn6MZo3zr5IZgc9388PE
   I1uEaZp72Vq3UKi0D28fzAEhg61D0frxVYnT7ydIBcIliKPH85/ps5X3h
   ud6qCWbpAcNBrKUtBKSBLojfUeM5vqVMnstMGEv1akWcQQE8GvUrpntCq
   vJHIAbxuXGfOVH/63nTArfOL/XMO8xjDt6M8hnZYNPPDMh3FMtkrV4toT
   L8AVsHkS+hMGq6MDCIM2SjkJBOYHs4Uo3PJDqfroILsFoDTYXPZI7QVdj
   w==;
X-CSE-ConnectionGUID: tQO1cNYXSg2Te1m568eXeg==
X-CSE-MsgGUID: wBjfVepARUytySR+IUf3og==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="85646788"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="85646788"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 01:40:24 -0700
X-CSE-ConnectionGUID: fK01IrQNQNi+5SXVB79c4g==
X-CSE-MsgGUID: LNl37PrGQFyeBR406jYsRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="220214473"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.33])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 01:40:20 -0700
Date: Tue, 10 Mar 2026 10:40:14 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Mohammed Thasleem <mohammed.thasleem@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Tao Liu <ltao@redhat.com>, stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [CI] drm/i915/dmc: Fix an unlikely NULL pointer deference at
 probe
Message-ID: <aa_Y7shwd1Vqiy3i@intel.com>
References: <20260309164803.1918158-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309164803.1918158-1-imre.deak@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-Rspamd-Queue-Id: D9D92247723
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-223790-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 06:48:03PM +0200, Imre Deak wrote:
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

Wasn't the original case some kdump kernel thing? I think that has
a few issues:
- loading full GPU drivers for a kdump kernel after the real kernel
  has crashed seems a bit risky. Who knows what state the hardware
  is in after the crash...
- we should probably try to unload DMC at kexec time (to the extent
  that DMC can actually be unloaded)

> 
> The tracking of the DC6 allowed counter only works if starting /
> stopping the counter depends on the _SW_ DC6 state vs. the current _HW_
> DC6 state (since stopping the counter requires the DC5 counter captured
> when the counter was started). Thus, using the HW DC6 state is incorrect
> and it also leads to the above oops. Fix both issues by using the SW DC6
> state for the tracking.
> 
> This is v2 of the fix originally sent by Jani, updated based on the
> first Link: discussion below.
> 
> Link: https://lore.kernel.org/all/3626411dc9e556452c432d0919821b76d9991217@intel.com
> Link: https://lore.kernel.org/all/20260228130946.50919-2-ltao@redhat.com
> Fixes: 88c1f9a4d36d ("drm/i915/dmc: Create debugfs entry for dc6 counter")
> Cc: Mohammed Thasleem <mohammed.thasleem@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Tao Liu <ltao@redhat.com>
> Cc: <stable@vger.kernel.org> # v6.16+
> Tested-by: Tao Liu <ltao@redhat.com>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display_power_well.c | 2 +-
>  drivers/gpu/drm/i915/display/intel_dmc.c                | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_power_well.c b/drivers/gpu/drm/i915/display/intel_display_power_well.c
> index 1e03187dbd38a..f855f0f886946 100644
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
>  
> -- 
> 2.49.1

-- 
Ville Syrjälä
Intel

