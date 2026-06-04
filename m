Return-Path: <stable+bounces-260443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FE0rOP9aIWreEwEAu9opvQ
	(envelope-from <stable+bounces-260443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 13:01:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BE063F439
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 13:01:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=SJgxyW8C;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260443-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260443-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA72930062E4
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16202330324;
	Thu,  4 Jun 2026 10:52:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE249402BB1
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:52:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570352; cv=none; b=Fwb+p15rKL14BVvverGZpT924VtRdaJYTqDFUW6Ud3D76hs6ZeA3vIbFukC0R0ulS+Sp1PP4dM8anX+qgP6fcWICMHll9qTBSwJ0p3LZshwwqky1pvSSeWNa+X/S2bbG8UR+GI0WPDIXrjc6yaBhfydpI2PeUG06ZEZWgbFmC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570352; c=relaxed/simple;
	bh=dkT3ddwfharwlkrHioVb3N3sjf9/WAiRzhOqmTBJUbo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pvuTa94FCezlF+ZD7BMRKWLiWP6EDC+4tvoDsLlaJ3AqCVTnq/aHZSc3Zy8hvsRtc2UTkx+hQr1tWhFKYOUssY/RWZr0C8i+/9zhuXgLlhV341iooew8ppBBnIe+6c6q2MNg6TNB+jowslmo3Vylxvq6/Zve5mbCx59VIoGAPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SJgxyW8C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A561F00893;
	Thu,  4 Jun 2026 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570351;
	bh=eWNX3uqDKmHuBk2jaLpmWtobIEdbgIkSjkKvHF/EIK8=;
	h=Subject:To:Cc:From:Date;
	b=SJgxyW8CFXK8spm4EhN+f51PaVlm3PFP/7iPyXdmna6QvaThn4LdHbLS3RZDJCjbM
	 p/RnSKtOqXPNxPONAOiAmDiOmy819s9RFNPElPlkjBaSdx3508rvPIAkgwfoXJpVhI
	 nrq0WtiJ3FHyLEADE7wOBSqt2C3QeP6OZDsuc+yA=
Subject: FAILED: patch "[PATCH] drm/i915/psr: Use DC_OFF wake reference to block DC6 on" failed to apply to 6.18-stable tree
To: jouni.hogander@intel.com,michal.grzelak@intel.com,stable@vger.kernel.org,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:51:34 +0200
Message-ID: <2026060434-tattoo-wise-091f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260443-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jouni.hogander@intel.com,m:michal.grzelak@intel.com,m:stable@vger.kernel.org,m:tursulin@ursulin.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52BE063F439


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3549a9649dc7c5fc586ab12f675279283cdcb2a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060434-tattoo-wise-091f@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3549a9649dc7c5fc586ab12f675279283cdcb2a7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Date: Wed, 20 May 2026 13:49:44 +0300
Subject: [PATCH] drm/i915/psr: Use DC_OFF wake reference to block DC6 on
 vblank enable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are observing following warnings:

*ERROR* power well DC_off state mismatch (refcount 0/enabled 1)

gen9_dc_off_power_well_enabled is considering target state DC_STATE_DISABLE
as DC_OFF power well being enabled. Fix this by using wakeref for the
purpose.

To achieve this we need to modify notification code as well. Currently it
is possible that PSR gets notified vblank enable/disable twice on same
status. This is currently not a problem as it is just triggering call to
intel_display_power_set_target_dc_state with same target state as a
parameter. When using wakeref this becomes a problem due to reference
counting. Fix this storing vbank status on last notification and use that
to ensure there are no more than one notification with same vblank status.

v2: ensure there is no subsequent notifications with same status

Fixes: aa451abcffb5 ("drm/i915/display: Prevent DC6 while vblank is enabled for Panel Replay")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>
Link: https://patch.msgid.link/20260520104944.239797-2-jouni.hogander@intel.com
(cherry picked from commit 35485ac56d878192a3829a58cb26503125ec7104)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_display_core.h b/drivers/gpu/drm/i915/display/intel_display_core.h
index d9baca2d5aaf..78afcd42f44c 100644
--- a/drivers/gpu/drm/i915/display/intel_display_core.h
+++ b/drivers/gpu/drm/i915/display/intel_display_core.h
@@ -497,6 +497,7 @@ struct intel_display {
 		u8 vblank_enabled;
 
 		int vblank_enable_count;
+		bool vblank_status_last_notified;
 
 		struct work_struct vblank_notify_work;
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c b/drivers/gpu/drm/i915/display/intel_display_irq.c
index 70c1bba7c0a8..aedf3928a089 100644
--- a/drivers/gpu/drm/i915/display/intel_display_irq.c
+++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
@@ -1773,8 +1773,12 @@ static void intel_display_vblank_notify_work(struct work_struct *work)
 	struct intel_display *display =
 		container_of(work, typeof(*display), irq.vblank_notify_work);
 	int vblank_enable_count = READ_ONCE(display->irq.vblank_enable_count);
+	bool vblank_status = !!vblank_enable_count;
 
-	intel_psr_notify_vblank_enable_disable(display, vblank_enable_count);
+	if (display->irq.vblank_status_last_notified != vblank_status) {
+		intel_psr_notify_vblank_enable_disable(display, vblank_status);
+		display->irq.vblank_status_last_notified = vblank_status;
+	}
 }
 
 int bdw_enable_vblank(struct drm_crtc *_crtc)
@@ -1787,10 +1791,10 @@ int bdw_enable_vblank(struct drm_crtc *_crtc)
 	if (gen11_dsi_configure_te(crtc, true))
 		return 0;
 
+	spin_lock_irqsave(&display->irq.lock, irqflags);
 	if (crtc->vblank_psr_notify && display->irq.vblank_enable_count++ == 0)
 		schedule_work(&display->irq.vblank_notify_work);
 
-	spin_lock_irqsave(&display->irq.lock, irqflags);
 	bdw_enable_pipe_irq(display, pipe, GEN8_PIPE_VBLANK);
 	spin_unlock_irqrestore(&display->irq.lock, irqflags);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 9c7c357afb09..2e6a85708555 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1790,6 +1790,8 @@ struct intel_psr {
 	u8 active_non_psr_pipes;
 
 	const char *no_psr_reason;
+
+	struct ref_tracker *vblank_wakeref;
 };
 
 struct intel_dp {
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index bd5a8c6ac6ef..598fe769a402 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -4151,14 +4151,20 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
 					    bool enable)
 {
 	struct intel_encoder *encoder;
-	bool block_dc_states = false;
 
 	for_each_intel_encoder_with_psr(display->drm, encoder) {
 		struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 
 		mutex_lock(&intel_dp->psr.lock);
-		if (CAN_PANEL_REPLAY(intel_dp))
-			block_dc_states = true;
+		if (CAN_PANEL_REPLAY(intel_dp)) {
+			if (enable)
+				intel_dp->psr.vblank_wakeref =
+					intel_display_power_get(display,
+								POWER_DOMAIN_DC_OFF);
+			else
+				intel_display_power_put(display, POWER_DOMAIN_DC_OFF,
+							intel_dp->psr.vblank_wakeref);
+		}
 
 		if (intel_dp->psr.enabled && !intel_dp->psr.panel_replay_enabled &&
 		    intel_dp->psr.pkg_c_latency_used)
@@ -4166,18 +4172,6 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
 
 		mutex_unlock(&intel_dp->psr.lock);
 	}
-
-	/*
-	 * NOTE: intel_display_power_set_target_dc_state is used
-	 * only by PSR code for DC3CO handling. DC3CO target
-	 * state is currently disabled in * PSR code. If DC3CO
-	 * is taken into use we need take that into account here
-	 * as well.
-	 */
-	if (block_dc_states)
-		intel_display_power_set_target_dc_state(display, enable ?
-							DC_STATE_DISABLE :
-							DC_STATE_EN_UPTO_DC6);
 }
 
 static void


