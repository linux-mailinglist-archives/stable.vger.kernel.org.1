Return-Path: <stable+bounces-269910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4u5FNYd+Q2pEZQoAu9opvQ
	(envelope-from <stable+bounces-269910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 10:29:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F416E1AAC
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 10:29:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CGFr1xg5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269910-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269910-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88BDB3044A47
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 08:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD5394788;
	Tue, 30 Jun 2026 08:29:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B02239B96A
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:29:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808160; cv=none; b=kRwXu2PPMOErax/EPgV2uW/mlEX6Y9ALD6n5jWf6WuO5abIvHlrNtAQPy5O3bK0iL1NmdgAGCSL/2Jt6rSIdHVFPbjm42a4uVs3qJg4Wj9JNrcqnhQ0V7yCM0TnA032khfFuRrunIRMeAXzqnxnr8n6xTCYlm5IIr10O0UEXnZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808160; c=relaxed/simple;
	bh=+S4eAojz/g8C9jCveAwNs9kiMSikarxTsxTmuHeIXVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXqBmNaGs93fTFaPwY3p+WmF+R+F5y4PAKXAZ1IiQmvp76RQOF9LFDfGvhXPaW/FCzb5COdO3YgTvu7Vxy0HSCobr7UK+DrGUAz4rRaVCb28ANSae9HbEjpZJd//36cSwCLJjKptng2pSaLNQlSAKcMs5i+DiKqh68IT3pj9qCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGFr1xg5; arc=none smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782808158; x=1814344158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+S4eAojz/g8C9jCveAwNs9kiMSikarxTsxTmuHeIXVU=;
  b=CGFr1xg5MyIpMVK6YMvmK4Qm9Ni4TWZBJPiS6t+zJPEFf5c/MS5Vb94S
   QQtTmVBqOpjdT1b3tmVqiapYQkNES8YV/7wNZLa+Ht/xaXEFoszYUfzXW
   dx4iXTJ5QE7atpUNlwghCKM2nWjdNIEvRZ7vJLZlVun6q6QdMQUkeff/9
   Di7EER9qKHXzQKrV9RWIM3j4xKjr3iHsPJ4yom4UKrJxvmy8fr4phfe5x
   gnN0FaraPeYB5enyWiufkfpemCbPLGVYnP5EZZP0UBuaYjrp7IAJZih6Q
   1d0D5FtR2Pr+gxPXljsocOya+vhFM3Jd8t2PHrA42NvtRnu0QG/99JP+y
   A==;
X-CSE-ConnectionGUID: MctyOQtKTUeBYPyBpid0XQ==
X-CSE-MsgGUID: AWx7xSZwSBadWb6tMHDJWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="93870428"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="93870428"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 01:29:18 -0700
X-CSE-ConnectionGUID: 3i2WV8R3Tje1dYOabLX8BQ==
X-CSE-MsgGUID: iarQpEQJS2eWHoXc+WEe5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="251794796"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.174])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 01:29:15 -0700
Date: Tue, 30 Jun 2026 11:29:11 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Martin Hodo <martin.hodo@intel.com>, stable@vger.kernel.org,
	Animesh Manna <animesh.manna@intel.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@intel.com>,
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>
Subject: Re: [PATCH v2] drm/i915/bios: range check LFP Data Block panel_type2
Message-ID: <akN8-YNa6kwRVkHk@intel.com>
References: <20260625135130.1067872-1-jani.nikula@intel.com>
 <20260626140155.1389655-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626140155.1389655-1-jani.nikula@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.49 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jani.nikula@intel.com,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:martin.hodo@intel.com,m:stable@vger.kernel.org,m:animesh.manna@intel.com,m:ville.syrjala@intel.com,m:michal.grzelak@intel.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269910-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2F416E1AAC

On Fri, Jun 26, 2026 at 05:01:55PM +0300, Jani Nikula wrote:
> While the panel_type from LFP Data Block is range checked, panel_type2
> is not. Add a few helpers for range checking, and use them to not only
> check panel_type2, but also improve clarity and correctness in the panel
> type selection.
> 
> Discovered using AI-assisted static analysis confirmed by Intel Product
> Security.
> 
> v2:
> - Fix commit message typo (Michał)
> - Add is_panel_type_pnp() (Ville)
> 
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: 6434cf630086 ("drm/i915/bios: calculate panel type as per child device index in VBT")
> Cc: <stable@vger.kernel.org> # v6.0+
> Cc: Animesh Manna <animesh.manna@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@intel.com>
> Reviewed-by: Michał Grzelak <michal.grzelak@intel.com> # v1
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_bios.c | 36 ++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
> index 15ebadc72b88..97cbae2e547e 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> @@ -623,6 +623,21 @@ get_lfp_data_tail(const struct bdb_lfp_data *data,
>  		return NULL;
>  }
>  
> +static bool is_panel_type_valid(int panel_type)
> +{
> +	return panel_type >= 0 && panel_type < 16;
> +}
> +
> +static bool is_panel_type_pnp(int panel_type)
> +{
> +	return panel_type == 0xff;
> +}
> +
> +static bool is_panel_type_valid_or_pnp(int panel_type)
> +{
> +	return is_panel_type_valid(panel_type) || is_panel_type_pnp(panel_type);
> +}
> +
>  static int opregion_get_panel_type(struct intel_display *display,
>  				   const struct intel_bios_encoder_data *devdata,
>  				   const struct drm_edid *drm_edid, bool use_fallback)
> @@ -640,15 +655,21 @@ static int vbt_get_panel_type(struct intel_display *display,
>  	if (!lfp_options)
>  		return -1;
>  
> -	if (lfp_options->panel_type > 0xf &&
> -	    lfp_options->panel_type != 0xff) {
> +	if (!is_panel_type_valid_or_pnp(lfp_options->panel_type)) {
>  		drm_dbg_kms(display->drm, "Invalid VBT panel type 0x%x\n",
>  			    lfp_options->panel_type);
>  		return -1;
>  	}
>  
> -	if (devdata && devdata->child.handle == DEVICE_HANDLE_LFP2)
> +	if (devdata && devdata->child.handle == DEVICE_HANDLE_LFP2) {
> +		if (!is_panel_type_valid_or_pnp(lfp_options->panel_type2)) {
> +			drm_dbg_kms(display->drm, "Invalid VBT panel type 2 0x%x\n",
> +				    lfp_options->panel_type2);
> +			return -1;
> +		}
> +
>  		return lfp_options->panel_type2;
> +	}

Hmm, this code will always return 'panel_type' if it's valid, even
for LFP2. That seems wrong, but would need to double check the
Windows behaviour to be sure...

But that's a separate issue, so this patch is
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  
>  	drm_WARN_ON(display->drm,
>  		    devdata && devdata->child.handle != DEVICE_HANDLE_LFP1);
> @@ -762,13 +783,12 @@ static int get_panel_type(struct intel_display *display,
>  				    panel_types[i].name, panel_types[i].panel_type);
>  	}
>  
> -	if (panel_types[PANEL_TYPE_OPREGION].panel_type >= 0)
> +	if (is_panel_type_valid(panel_types[PANEL_TYPE_OPREGION].panel_type))
>  		i = PANEL_TYPE_OPREGION;
> -	else if (panel_types[PANEL_TYPE_VBT].panel_type == 0xff &&
> -		 panel_types[PANEL_TYPE_PNPID].panel_type >= 0)
> +	else if (is_panel_type_pnp(panel_types[PANEL_TYPE_VBT].panel_type) &&
> +		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID].panel_type))
>  		i = PANEL_TYPE_PNPID;
> -	else if (panel_types[PANEL_TYPE_VBT].panel_type != 0xff &&
> -		 panel_types[PANEL_TYPE_VBT].panel_type >= 0)
> +	else if (is_panel_type_valid(panel_types[PANEL_TYPE_VBT].panel_type))
>  		i = PANEL_TYPE_VBT;
>  	else
>  		i = PANEL_TYPE_FALLBACK;
> -- 
> 2.47.3

-- 
Ville Syrjälä
Intel

