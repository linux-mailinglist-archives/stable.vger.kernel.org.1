Return-Path: <stable+bounces-255012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMWqCxpNGGomiwgAu9opvQ
	(envelope-from <stable+bounces-255012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:11:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AD65F3734
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC8FE30D9D61
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956A52D8793;
	Thu, 28 May 2026 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f59jEO0C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823C262D0B
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977050; cv=none; b=ZKvkl28Q0iM2x/HlLBTPDIeZO6Zxk70mSxuXWFM+DllCHiNUsUoyW7cA/7dcWjYoOiIJhUh8q3eJBXQmdRhgcXxOG/JMKPufm3DefPmtgBsfyrA5gNhBqT5q4kt7aWmAtfQKXiqrBg8zvdAOTvbEYf8JwkHBws576NlVJNgokUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977050; c=relaxed/simple;
	bh=F3aRlIljeWXugDLoXaeI2ArqfRL2ZQ+Ap/2nnQI6osI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VhyHscHVMJ6FZz4HY7ah9K8dmr18prmsdNje1hjHQmahN29Sf1NFW4IkaiQtUKwg4S8jMpJ+YW0OCkoJrXPqL/s1fooaV1Ra7J/+5V5HcKnPpd7RpcTnimd5kZxH1WQogtrnViRjn1yG9gXUiXO+ogZjNPo5SuTdvytgPeZwNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f59jEO0C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4E51F000E9;
	Thu, 28 May 2026 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779977048;
	bh=X7LEE0uWGofw5zn6K2PzjcIwCiL4bpN6XlPl2TgOSfs=;
	h=Subject:To:Cc:From:Date;
	b=f59jEO0CDRfilKXi34GYuA9CjsmtEXDaWZ/YuuEzKsRsYEXoddmAznWEgWEYhKGHL
	 Sz/ijMqJ9/F349ncPqaNn3lwOpd+l+RUkjfEBSkwuzyholZJqtwmS5Co9ZKrNjIJEH
	 w6n/f8QKZLg7y/PCy1Qj6SYjZGGyc3DKjukvzZeE=
Subject: FAILED: patch "[PATCH] drm/i915/psr: Apply Intel DPCD workaround when SDP on prior" failed to apply to 7.0-stable tree
To: jouni.hogander@intel.com,stable@vger.kernel.org,suraj.kandpal@intel.com,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 16:03:15 +0200
Message-ID: <2026052815-gown-browse-cf36@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255012-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,gregkh:email,ursulin.net:email,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A4AD65F3734
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 4703049f768fc1c1caac754134118bee1a3af189
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052815-gown-browse-cf36@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4703049f768fc1c1caac754134118bee1a3af189 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Date: Fri, 15 May 2026 12:57:55 +0300
Subject: [PATCH] drm/i915/psr: Apply Intel DPCD workaround when SDP on prior
 line used
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is Intel specific workaround DPCD address containing workaround for
case where SDP is on prior line. Apply this workaround according to values
in the offset.

Fixes: 61e887329e33 ("drm/i915/xelpd: Handle PSR2 SDP indication in the prior scanline")
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260515095756.2799483-4-jouni.hogander@intel.com
(cherry picked from commit c3fe899fbeac86ea4a5ca9dd845b2cbc0da46249)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 82eac4048382..29904a037575 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1365,9 +1365,35 @@ static bool psr2_granularity_check(struct intel_crtc_state *crtc_state,
 	return true;
 }
 
-static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_dp,
-							struct intel_crtc_state *crtc_state)
+static bool apply_scanline_indication_wa(struct intel_crtc_state *crtc_state,
+					 struct intel_connector *connector)
 {
+	struct intel_dp *intel_dp = intel_attached_dp(connector);
+	u8 early_scanline_support = connector->dp.psr_caps.intel_wa_dpcd &
+		INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_EARLYSCANLINE_SDP_SUPPORT_MASK;
+
+	if (intel_dp->edp_dpcd[0] >= DP_EDP_15)
+		return true;
+
+	switch (early_scanline_support)	{
+	case INTEL_DPCD_INTEL_WA_REGISTER_CAPS_FALL_BACK_TO_PSR1:
+		crtc_state->req_psr2_sdp_prior_scanline = false;
+		return false;
+	case INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITH_EARLY_SCANLINE:
+		return true;
+	case INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITHOUT_EARLY_SCANLINE:
+		crtc_state->req_psr2_sdp_prior_scanline = false;
+		return true;
+	default:
+		MISSING_CASE(early_scanline_support);
+		return false;
+	}
+}
+
+static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_crtc_state *crtc_state,
+							struct intel_connector *connector)
+{
+	struct intel_dp *intel_dp = intel_attached_dp(connector);
 	struct intel_display *display = to_intel_display(intel_dp);
 	const struct drm_display_mode *adjusted_mode = &crtc_state->uapi.adjusted_mode;
 	u32 hblank_total, hblank_ns, req_ns;
@@ -1386,7 +1412,8 @@ static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_d
 		return false;
 
 	crtc_state->req_psr2_sdp_prior_scanline = true;
-	return true;
+
+	return apply_scanline_indication_wa(crtc_state, connector);
 }
 
 static int intel_psr_entry_setup_frames(struct intel_dp *intel_dp,
@@ -1667,7 +1694,7 @@ static bool intel_sel_update_config_valid(struct intel_crtc_state *crtc_state,
 								      conn_state))
 		goto unsupported;
 
-	if (!_compute_psr2_sdp_prior_scanline_indication(intel_dp, crtc_state)) {
+	if (!_compute_psr2_sdp_prior_scanline_indication(crtc_state, connector)) {
 		drm_dbg_kms(display->drm,
 			    "Selective update not enabled, SDP indication do not fit in hblank\n");
 		goto unsupported;


