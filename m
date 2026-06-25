Return-Path: <stable+bounces-268599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VHKBMwZJPWo60wgAu9opvQ
	(envelope-from <stable+bounces-268599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:28:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4956C70DE
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:28:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=mR+mD8iv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268599-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268599-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 403663049675
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C437C918;
	Thu, 25 Jun 2026 15:28:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA63E6396
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 15:28:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401282; cv=none; b=i5pWoL1tXkT5p5n38mxB9TLkLRhTG5xPuk3T4YZKtIZFCeF/SvV2GH1EmEhs9CalnHjHHLKBoN29TDib2Wh3s8/Tcv0SlEZ4pW7Gk+yKpxD6714O4+mamgm4yt6Qq8bymRco2bV9JHcmdVvVlh+QLUFcKEFnHVfyl65yZY0pnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401282; c=relaxed/simple;
	bh=vfCzvBFrq4aqLZUqAlJsgQ9pz1xMZKJQzgI6UmSmEI4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fKP0wxQ1z27ZAxu9JtL1uGSPRHgRBholgJEaUaNTkYTY3YwF90xJHWBf3CV5RKxsAb/54KKRBE7zSzBIIw4ejP1EJoC5iSqEtJYpQSXwpoOth7FE3E9jeF/6m/C8K23xsjdHS7ydfY0zGdS4GCOmKIzCEJEX7gFwbA1LxWf6yvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mR+mD8iv; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782401280; x=1813937280;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vfCzvBFrq4aqLZUqAlJsgQ9pz1xMZKJQzgI6UmSmEI4=;
  b=mR+mD8iv39CCTKUdUp5Pt6+kTmy+y4gsl2SODq2DTwts3rzPTel3jakx
   WZbBd+tB7g0l5cV6ZoF8C4XyhDfxRybwXhDOrH3SKxjqZTg8tgXEYuzrj
   zT2i9nwSmUHFkhfPClg+ouHvqlT6rtu1V8MsAKQhuYHCMxRXXHz9RyGZM
   x0vavCCWUGQQ3PUdlHs1IjJgcG1wjeG3ZF2W2U2G8N/zHYkbthjL0VIlS
   0bpLgTx40ZgMgAKKyr4cDGoSj3gf62hQOAVVVAKZtRL0Ju+X/KFQ903P4
   mEEeaX7OyIf+Bq2oxVv6drJARWElzVt8r1xM5jjlG/5fY0dHupx2y7Vv3
   A==;
X-CSE-ConnectionGUID: 6e0jVfCnQc2MIBzWGbvEHQ==
X-CSE-MsgGUID: 1vBgBqygQDCWlGNP2t3OKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83057521"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83057521"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:27:59 -0700
X-CSE-ConnectionGUID: cwTZChLfQoOZDlSBPHTQUA==
X-CSE-MsgGUID: qoEYF/gQQV+BhVfiKIQ0ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="251337583"
Received: from dev-417.igk.intel.com ([10.91.214.181])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:27:58 -0700
Date: Thu, 25 Jun 2026 17:27:55 +0200 (CEST)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    Martin Hodo <martin.hodo@intel.com>, stable@vger.kernel.org, 
    Animesh Manna <animesh.manna@intel.com>, 
    =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@intel.com>
Subject: Re: [PATCH] drm/i915/bios: range check LFP Data Block panel_type2
In-Reply-To: <20260625135130.1067872-1-jani.nikula@intel.com>
Message-ID: <37079a8c-8eb7-aaa0-ed21-594f413210a2@intel.com>
References: <20260625135130.1067872-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-253770812-1782401279=:605841"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jani.nikula@intel.com,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:martin.hodo@intel.com,m:stable@vger.kernel.org,m:animesh.manna@intel.com,m:ville.syrjala@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michal.grzelak@intel.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268599-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.grzelak@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A4956C70DE

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-253770812-1782401279=:605841
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 25 Jun 2026, Jani Nikula wrote:
> While the panel_type from LFP Data Block is range checked, panel_type2
> is not. Add a few helpers for range checking, and use them to not only
> check panel_type2, but also imrove clarity and correctness in the panel

typo: s/imrove/improve/

> type selection.
>
> Discovered using AI-assisted static analysis confirmed by Intel Product
> Security.
>
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: 6434cf630086 ("drm/i915/bios: calculate panel type as per child device index in VBT")
> Cc: <stable@vger.kernel.org> # v6.0+
> Cc: Animesh Manna <animesh.manna@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@intel.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>

BR,
Michał

> ---
> drivers/gpu/drm/i915/display/intel_bios.c | 29 +++++++++++++++++------
> 1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
> index 15ebadc72b88..0c420019e46a 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> @@ -623,6 +623,16 @@ get_lfp_data_tail(const struct bdb_lfp_data *data,
> 		return NULL;
> }
>
> +static bool is_panel_type_valid(int panel_type)
> +{
> +	return panel_type >= 0 && panel_type < 16;
> +}
> +
> +static bool is_panel_type_valid_or_pnp(int panel_type)
> +{
> +	return is_panel_type_valid(panel_type) || panel_type == 0xff;
> +}
> +
> static int opregion_get_panel_type(struct intel_display *display,
> 				   const struct intel_bios_encoder_data *devdata,
> 				   const struct drm_edid *drm_edid, bool use_fallback)
> @@ -640,15 +650,21 @@ static int vbt_get_panel_type(struct intel_display *display,
> 	if (!lfp_options)
> 		return -1;
>
> -	if (lfp_options->panel_type > 0xf &&
> -	    lfp_options->panel_type != 0xff) {
> +	if (!is_panel_type_valid_or_pnp(lfp_options->panel_type)) {
> 		drm_dbg_kms(display->drm, "Invalid VBT panel type 0x%x\n",
> 			    lfp_options->panel_type);
> 		return -1;
> 	}
>
> -	if (devdata && devdata->child.handle == DEVICE_HANDLE_LFP2)
> +	if (devdata && devdata->child.handle == DEVICE_HANDLE_LFP2) {
> +		if (!is_panel_type_valid_or_pnp(lfp_options->panel_type2)) {
> +			drm_dbg_kms(display->drm, "Invalid VBT panel type 2 0x%x\n",
> +				    lfp_options->panel_type2);
> +			return -1;
> +		}
> +
> 		return lfp_options->panel_type2;
> +	}
>
> 	drm_WARN_ON(display->drm,
> 		    devdata && devdata->child.handle != DEVICE_HANDLE_LFP1);
> @@ -762,13 +778,12 @@ static int get_panel_type(struct intel_display *display,
> 				    panel_types[i].name, panel_types[i].panel_type);
> 	}
>
> -	if (panel_types[PANEL_TYPE_OPREGION].panel_type >= 0)
> +	if (is_panel_type_valid(panel_types[PANEL_TYPE_OPREGION].panel_type))
> 		i = PANEL_TYPE_OPREGION;
> 	else if (panel_types[PANEL_TYPE_VBT].panel_type == 0xff &&
> -		 panel_types[PANEL_TYPE_PNPID].panel_type >= 0)
> +		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID].panel_type))
> 		i = PANEL_TYPE_PNPID;
> -	else if (panel_types[PANEL_TYPE_VBT].panel_type != 0xff &&
> -		 panel_types[PANEL_TYPE_VBT].panel_type >= 0)
> +	else if (is_panel_type_valid(panel_types[PANEL_TYPE_VBT].panel_type))
> 		i = PANEL_TYPE_VBT;
> 	else
> 		i = PANEL_TYPE_FALLBACK;
> -- 
> 2.47.3
>
>
--8323329-253770812-1782401279=:605841--

