Return-Path: <stable+bounces-249904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDXnNTOuDWrW1QUAu9opvQ
	(envelope-from <stable+bounces-249904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:50:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9858E374
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B04303DADC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811BE3A4505;
	Wed, 20 May 2026 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qtf5zsU1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAC3D34AC
	for <stable@vger.kernel.org>; Wed, 20 May 2026 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280955; cv=none; b=TsnF/iL1hUUQAthMA4BcbvydU+t3ymlsFUjLaqPgo7vN5+LmaEw16mj6JhKeISS7bjPRGUeU8/PB2DifBS1bmNOii/fZeHzCkjBhVsM4C9Xuna2UGZZ+KZ/MS/VKT72m5N699GYwusTqvnGwGmpi7MYGI6m078Dg9nLZ3+lJIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280955; c=relaxed/simple;
	bh=JXG84T0gDqIOjzvvC9ld1fdVPogCwQOHnmLW9v1GnrI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DLTC0gqVODmd5TQwLCcUNoLIsHNgn86flSW3a2ZV6d2ADj4hNF/+jaU2F1+2Unuf2kVNYz4udj36o8RdB6WMnHOz0oErb8AH3eDTnWDd1B46kuhLU+O469Mzsb90WM0n37H27iEiWSrtg0Yfz4m5y0Ak+kJGjwqrA/QyS4eM+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qtf5zsU1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779280954; x=1810816954;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JXG84T0gDqIOjzvvC9ld1fdVPogCwQOHnmLW9v1GnrI=;
  b=Qtf5zsU1wadMqYF41SmqJVZdXHU41ePy9eoE3xIH88ZChGvQrPR7HfU3
   5mQx0TF4WX4SOQZCMwISrLw+i8fL1KONqpgr7zSgJff70J2ElBMb8QDAB
   KCQO6VPpx+ZeeP3iHnTVQXSuHDZQhnGDJXc2OzxR9ra4Lr/kVxBJhr7AK
   syqlhgqjEDAwT+qSASi/WRbIv0NNw5FwuTihX4MobQpRwLyPbjAki9hAC
   vxuNcb8xt+N5R3crgXthkcqkcFO1o3gfjTrCGTG11ZZ+LHvs3yt+VEp3P
   VX+3pESxtyO+zDG7px44kdv3KY8wOhdPlwZYbcw49V6I/slECJUkttW5M
   Q==;
X-CSE-ConnectionGUID: tyAdif9ARg2NioGR2sEjkw==
X-CSE-MsgGUID: cebXykCtQYie1pYUeM5iKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83793700"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="83793700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 05:42:34 -0700
X-CSE-ConnectionGUID: fzbt7MOSQ6aPbctLdkJehA==
X-CSE-MsgGUID: QGeBnDHtTACaJuJWZyZ0qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="237164852"
Received: from dev-417.igk.intel.com ([10.91.214.181])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 05:42:32 -0700
Date: Wed, 20 May 2026 14:42:30 +0200 (CEST)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: =?ISO-8859-15?Q?Jouni_H=F6gander?= <jouni.hogander@intel.com>
cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/i915/psr: Use DC_OFF wake reference to block
 DC6 on vblank enable
In-Reply-To: <20260520104944.239797-2-jouni.hogander@intel.com>
Message-ID: <dd038d76-36dd-a119-0a8a-46df00f062eb@intel.com>
References: <20260520104944.239797-1-jouni.hogander@intel.com> <20260520104944.239797-2-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-627402715-1779280953=:1544314"
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249904-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.grzelak@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 42E9858E374
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-627402715-1779280953=:1544314
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 20 May 2026, Jouni Högander wrote:
> We are observing following warnings:
>
> *ERROR* power well DC_off state mismatch (refcount 0/enabled 1)
>
> gen9_dc_off_power_well_enabled is considering target state DC_STATE_DISABLE
> as DC_OFF power well being enabled. Fix this by using wakeref for the
> purpose.
>
> To achieve this we need to modify notification code as well. Currently it
> is possible that PSR gets notified vblank enable/disable twice on same
> status. This is currently not a problem as it is just triggering call to
> intel_display_power_set_target_dc_state with same target state as a
> parameter. When using wakeref this becomes a problem due to reference
> counting. Fix this storing vbank status on last notification and use that
> to ensure there are no more than one notification with same vblank status.
>
> v2: ensure there is no subsequent notifications with same status
>
> Fixes: aa451abcffb5 ("drm/i915/display: Prevent DC6 while vblank is enabled for Panel Replay")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
> ---
> .../gpu/drm/i915/display/intel_display_core.h |  1 +
> .../gpu/drm/i915/display/intel_display_irq.c  |  8 +++++--
> .../drm/i915/display/intel_display_types.h    |  2 ++
> drivers/gpu/drm/i915/display/intel_psr.c      | 24 +++++++------------
> 4 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_core.h b/drivers/gpu/drm/i915/display/intel_display_core.h
> index 3dc5ac75a98b..64c1365fb366 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_core.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_core.h
> @@ -494,6 +494,7 @@ struct intel_display {
> 		u8 vblank_enabled;
>
> 		int vblank_enable_count;
> +		bool last_vblank_status_notified;

couple of the fields in the irq sub-struct are prepended with vblank, thus 
wondering if we can do it here as well. Maybe
vblank_last_status_notified? or vblank_status_last_notified?

Anyways, for the v2:

Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>

BR,
Michał

>
> 		struct work_struct vblank_notify_work;
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c b/drivers/gpu/drm/i915/display/intel_display_irq.c
> index 899a38c0a7b7..57f37f9b83a5 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_irq.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
> @@ -1786,8 +1786,12 @@ static void intel_display_vblank_notify_work(struct work_struct *work)
> 	struct intel_display *display =
> 		container_of(work, typeof(*display), irq.vblank_notify_work);
> 	int vblank_enable_count = READ_ONCE(display->irq.vblank_enable_count);
> +	bool vblank_status = !!vblank_enable_count;
>
> -	intel_psr_notify_vblank_enable_disable(display, vblank_enable_count);
> +	if (display->irq.last_vblank_status_notified != vblank_status) {
> +		intel_psr_notify_vblank_enable_disable(display, vblank_status);
> +		display->irq.last_vblank_status_notified = vblank_status;
> +	}
> }
>
> int bdw_enable_vblank(struct drm_crtc *_crtc)
> @@ -1800,10 +1804,10 @@ int bdw_enable_vblank(struct drm_crtc *_crtc)
> 	if (gen11_dsi_configure_te(crtc, true))
> 		return 0;
>
> +	spin_lock_irqsave(&display->irq.lock, irqflags);
> 	if (crtc->vblank_psr_notify && display->irq.vblank_enable_count++ == 0)
> 		schedule_work(&display->irq.vblank_notify_work);
>
> -	spin_lock_irqsave(&display->irq.lock, irqflags);
> 	bdw_enable_pipe_irq(display, pipe, GEN8_PIPE_VBLANK);
> 	spin_unlock_irqrestore(&display->irq.lock, irqflags);
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
> index f44be5c689ae..b8ccd635c575 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -1790,6 +1790,8 @@ struct intel_psr {
> 	u8 active_non_psr_pipes;
>
> 	const char *no_psr_reason;
> +
> +	struct ref_tracker *vblank_wakeref;
> };
>
> struct intel_dp {
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 70108e0a4c0c..19cfb23fe9f8 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -4180,14 +4180,20 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
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
> @@ -4195,18 +4201,6 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
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
--8323329-627402715-1779280953=:1544314--

