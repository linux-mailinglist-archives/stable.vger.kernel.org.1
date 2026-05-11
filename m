Return-Path: <stable+bounces-245216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMouGlvaAWoDlgEAu9opvQ
	(envelope-from <stable+bounces-245216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:32:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D9B50EFBD
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12093048DCE
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C363783BB;
	Mon, 11 May 2026 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFuX4BST"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212CA3B19AA
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505918; cv=none; b=gWBpsCxy85q9TbiMfBnU7zX2SgaTe1uLfg0Fz7XMhnQEcIvGE6yM6+dwQk8nUdItlYnCCVyj+BvFVbppBOuZFaQdccQmNhSg1LzO5c2NXI/6u8479+O49oPm09gZxrsoshSwoNrIoU3+g/i42mzuJ9dbAY/9wg/QPPCFPL2DeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505918; c=relaxed/simple;
	bh=0AJH8elwU2s8KFirikXSOPnVKp9/S963D5Srz8NT0/4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GTcVXEEOvGG5fJoD7hDdf7lboxDPV6s1M11NKZ2mDicE0xlOZQ8TbI55xLdRp+weZvaQAZvZCO66xznF97voRDtIyLahO8IHi/nqlo8Mf5zUQRr9q3jKUGyneb3I6OxQ42KaiYD9mIf5XYWzzn/VGfr4k1f0KDSRcOvcAHcbWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFuX4BST; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778505917; x=1810041917;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=0AJH8elwU2s8KFirikXSOPnVKp9/S963D5Srz8NT0/4=;
  b=DFuX4BSTk8z7PofQyp7bVjolwsX98p7aC/CA7mrMUC6x++g4vnOfuIhy
   F6jY1fmmtOYdzZSHzZoEuY9Q7uCT/TyB9iQ2doxsiS0ctNmwToe8XrBwI
   YCjzZgrage5uBeFuGlOiYh5l1OJxzipnr7yHWynMy3Z9KAxwUIf+oBd0u
   nXkzLSw39h2l40Ruq6gGXPKvDjMW1qJNL//Hvo7T4cDL/XwSo8wAJ0KqZ
   UL4KaWd10Ma2x3LB29XBEsWPzugSIuEn52B14/WSfYW27rbsmlvUBsc/k
   IdrRloUYiqf3mM2YPF82qZITbmCSCzIP+89C/+J88PvftwnsryxGfXlf4
   A==;
X-CSE-ConnectionGUID: YDI0gyOnTEKi8kZL8lHXFQ==
X-CSE-MsgGUID: 4EQoBgfxTamKktKylwK/GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79338086"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79338086"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:25:17 -0700
X-CSE-ConnectionGUID: SOQn5w02SqyGbvz9M4gOtw==
X-CSE-MsgGUID: k16o8aNPSXWDBj1xxUsmeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="267810814"
Received: from dev-417.igk.intel.com ([10.91.214.181])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:25:16 -0700
Date: Mon, 11 May 2026 15:25:13 +0200 (CEST)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: =?ISO-8859-15?Q?Jouni_H=F6gander?= <jouni.hogander@intel.com>
cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/i915/psr: Use DC_OFF wake reference to block
 DC6 on vblank enable
In-Reply-To: <20260511121551.2373824-2-jouni.hogander@intel.com>
Message-ID: <7af4c9b9-c2f8-8970-ec4f-b244df92dd08@intel.com>
References: <20260511121551.2373824-1-jouni.hogander@intel.com> <20260511121551.2373824-2-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-983092090-1778505731=:541093"
Content-ID: <135e2c34-5465-c537-ee08-5e56dd62c7ab@intel.com>
X-Rspamd-Queue-Id: A3D9B50EFBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245216-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.grzelak@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-983092090-1778505731=:541093
Content-Type: text/plain; CHARSET=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <98b15bf3-fc96-01fc-9e4c-282201889e14@intel.com>

On Mon, 11 May 2026, Jouni Högander wrote:
> We are observing following warnings:
>
> *ERROR* power well DC_off state mismatch (refcount 0/enabled 1)
>
> gen9_dc_off_power_well_enabled is concidering target state DC_STATE_DISABLE

s/concidering/considering/

Reviewed-by: Micha³ Grzelak <michal.grzelak@intel.com>

BR,
Micha³

> as DC_OFF power well being enabled. Fix this by using wakeref for the
> purpose.
>
> Fixes: aa451abcffb5 ("drm/i915/display: Prevent DC6 while vblank is enabled for Panel Replay")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
> ---
> .../drm/i915/display/intel_display_types.h    |  2 ++
> drivers/gpu/drm/i915/display/intel_psr.c      | 24 +++++++------------
> 2 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 26e59110e743..e2861476b215 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -1789,6 +1789,8 @@ struct intel_psr {
> 	u8 active_non_psr_pipes;
>
> 	const char *no_psr_reason;
> +
> +	struct ref_tracker *vblank_wakeref;
> };
>
> struct intel_dp {
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 657b1614cd65..a8f02f928bd8 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -4141,14 +4141,20 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
> 					    bool enable)
> {
> 	struct intel_encoder *encoder;
> -	bool block_dc_states = false;
>
> 	for_each_intel_encoder_with_psr(display->drm, encoder) {
> 		struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
>
> 		mutex_lock(&intel_dp->psr.lock);
> -		if (CAN_PANEL_REPLAY(intel_dp))
> -			block_dc_states = true;
> +		if (CAN_PANEL_REPLAY(intel_dp)) {
> +			if (enable)
> +				intel_dp->psr.vblank_wakeref =
> +					intel_display_power_get(display,
> +								POWER_DOMAIN_DC_OFF);
> +			else
> +				intel_display_power_put(display, POWER_DOMAIN_DC_OFF,
> +							intel_dp->psr.vblank_wakeref);
> +		}
>
> 		if (intel_dp->psr.enabled && !intel_dp->psr.panel_replay_enabled &&
> 		    intel_dp->psr.pkg_c_latency_used)
> @@ -4156,18 +4162,6 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
>
> 		mutex_unlock(&intel_dp->psr.lock);
> 	}
> -
> -	/*
> -	 * NOTE: intel_display_power_set_target_dc_state is used
> -	 * only by PSR code for DC3CO handling. DC3CO target
> -	 * state is currently disabled in * PSR code. If DC3CO
> -	 * is taken into use we need take that into account here
> -	 * as well.
> -	 */
> -	if (block_dc_states)
> -		intel_display_power_set_target_dc_state(display, enable ?
> -							DC_STATE_DISABLE :
> -							DC_STATE_EN_UPTO_DC6);
> }
>
> static void
> -- 
> 2.43.0
>
>
--8323329-983092090-1778505731=:541093--

