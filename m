Return-Path: <stable+bounces-263413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id icRgH1w1MGrkPwUAu9opvQ
	(envelope-from <stable+bounces-263413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:24:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9EF688D22
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:24:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hKUeDI5I;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263413-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263413-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0908B3012760
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A25411695;
	Mon, 15 Jun 2026 17:20:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893D413221
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544018; cv=none; b=ipqYOpD7MhcbStlXM+NMwSjTTLX/MiN00DPc30qm/bT4K7Iy+8NSelr9VPVkcdKY/7css5Cqslt3Ntg4tm98/0xlOrScNTprTqvohZdkP/8io00H0WZW2NbodE1C+TL3QObDLoHwq89X8yTTGasdOQnYbEZCxA8JmD3Fnaew4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544018; c=relaxed/simple;
	bh=nQMx2xjGZaZEzcyc9EI+7IwbIbnUSvIu+pCMMd6vvZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XHXCPvNAYDWZFfWUJeY1HqPnWdAKNz6qncUGuu89cUtSv0BuzZwnHMuH0ydanVdh5+w5ewO1QiicL4ScyBpWKj+Av/XNihoJ6vJxrEd/4hRuKHVsgb8egWnDYhPbVIwWR0t1bLffUWX/C9ZgeyxPwDCOaN4Tfjz9hjqpNo9JI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKUeDI5I; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781544016; x=1813080016;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nQMx2xjGZaZEzcyc9EI+7IwbIbnUSvIu+pCMMd6vvZo=;
  b=hKUeDI5IFXSylJCQRQgp+nUAoSPTdpNvKn6SYjWppIgWVH49Z58B0MxL
   +c7wQuJGuyu4xLhKiIrfT6rWUa/9+kmLxnTurmUwq5PPINN9UrHkamDY9
   0R3d/yvM/SmxDWG77esUbSjSzIBinQ92VJFAjGl8cQmfJNArptYqok77y
   L2k73Xb3dfj29Eejfmku9q7/wdCEST5opsxW5AnAB35LkyxYwEml4QxHv
   MHIWrsf9W5E+uhr01zHIkdHlB5wrkvdtGUckbspEGj607nx0CK0m8JWQF
   EydENjxv3UrE8lx0Qs+tAGsIw/9esAaMK0keDFBepFt7pYY/ygtiHGtkC
   g==;
X-CSE-ConnectionGUID: VajzAFaXR+mCR943o2fuDA==
X-CSE-MsgGUID: ZlutY/rWTaS4EihfmSDhsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82190227"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82190227"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 10:20:15 -0700
X-CSE-ConnectionGUID: 4SJVtSTeTWymtaGZDr0jrQ==
X-CSE-MsgGUID: ZflAhESTQC6HTBWUV7/b5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="285647746"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 10:20:14 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: chafi <chafiprc@foxmail.com>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org, Yu Zhang
 <chafiprc@foxmail.com>
Subject: Re: [PATCH 1/3] drm/i915/dsi: Program TRANS_HSYNC register for
 dual-link command mode
In-Reply-To: <tencent_41186F27AF2C13B660C14ED5E6E14759800A@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <tencent_41186F27AF2C13B660C14ED5E6E14759800A@qq.com>
Date: Mon, 15 Jun 2026 20:20:10 +0300
Message-ID: <ed14be7c1d21587af9731726ae1c311c4ad6602c@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:chafiprc@foxmail.com,m:intel-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-263413-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com,lists.freedesktop.org];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jani.nikula@linux.intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,foxmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A9EF688D22

On Mon, 08 Jun 2026, chafi <chafiprc@foxmail.com> wrote:
> From: Yu Zhang <chafiprc@foxmail.com>
>
> The TRANS_HSYNC register programming and dual-link hsync halving is
> placed inside the is_vid_mode() guard, so it only runs for video mode.
> Command mode dual-link DSI also needs this:
>
> 1. Without TRANS_HSYNC written, the hardware retains an inconsistent
>    state, leading to errors on modeset:
>
>    [drm] *ERROR* mismatch in hw.pipe_mode.crtc_hsync_start
>    (expected 2762, found 1380)
>
> 2. The hsync_start/end are not halved for each link, so the hardware
>    stores per-link values while the software expects full values.
>
> Fix this by moving the dual-link hsync halving and TRANS_HSYNC write
> outside the is_vid_mode() guard, making them unconditional for all
> DSI modes.
>
> Fixes: d1aeb5f399d9 ("drm/i915/icl: Configure DSI transcoder timings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <chafiprc@foxmail.com>

Hey, I see you've sent a few paches for DSI. Nice! Do you actually have
the hardware? Would be great to have a bug report over at [1] with the
dmesg (with drm debugs enabled) so we can see the failure mode and exact
hardware details.


BR,
Jani.


[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


> ---
>  drivers/gpu/drm/i915/display/icl_dsi.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
> index 951f30a64..c667d5941 100644
> --- a/drivers/gpu/drm/i915/display/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/display/icl_dsi.c
> @@ -950,7 +950,6 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
>  			       HACTIVE(hactive - 1) | HTOTAL(htotal - 1));
>  	}
>  
> -	/* TRANS_HSYNC register to be programmed only for video mode */
>  	if (is_vid_mode(intel_dsi)) {
>  		if (intel_dsi->video_mode == NON_BURST_SYNC_PULSE) {
>  			/* BSPEC: hsync size should be atleast 16 pixels */
> @@ -961,18 +960,18 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
>  
>  		if (hback_porch < 16)
>  			drm_err(display->drm, "hback porch < 16 pixels\n");
> +	}
>  
> -		if (intel_dsi->dual_link) {
> -			hsync_start /= 2;
> -			hsync_end /= 2;
> -		}
> +	if (intel_dsi->dual_link) {
> +		hsync_start /= 2;
> +		hsync_end /= 2;
> +	}
>  
> -		for_each_dsi_port(port, intel_dsi->ports) {
> -			dsi_trans = dsi_port_to_transcoder(port);
> -			intel_de_write(display,
> -				       TRANS_HSYNC(display, dsi_trans),
> -				       HSYNC_START(hsync_start - 1) | HSYNC_END(hsync_end - 1));
> -		}
> +	for_each_dsi_port(port, intel_dsi->ports) {
> +		dsi_trans = dsi_port_to_transcoder(port);
> +		intel_de_write(display,
> +			       TRANS_HSYNC(display, dsi_trans),
> +			       HSYNC_START(hsync_start - 1) | HSYNC_END(hsync_end - 1));
>  	}
>  
>  	/* program TRANS_VTOTAL register */

-- 
Jani Nikula, Intel

