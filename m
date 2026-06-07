Return-Path: <stable+bounces-261711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O4vWEOxNJWpxGgIAu9opvQ
	(envelope-from <stable+bounces-261711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:54:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B149C6501C7
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:54:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dytO7+Ct;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261711-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261711-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BFA63039F48
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7722F31E83A;
	Sun,  7 Jun 2026 10:52:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA834071DD;
	Sun,  7 Jun 2026 10:52:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829557; cv=none; b=ZpGjh96To16nTingvZm+DypQMwX1y0pSAgXpKLx1R7gKImuCsPl6jas+Ts0tQISrdh1lACqjkh33DrNsye5yiv7F2xymCXi+8jnE4oDeFKxp5TvW16kwT1Bf1ReHti6iCHiSoOWQ4atgr7/73fKg1cSD6RiaFQnBtJidE9tpZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829557; c=relaxed/simple;
	bh=/jaIVMENPGemub6csbh6eUxHNyughOsplTlYg0QFzWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDX+19/X/YfhwYKAeuscWJAMyzK3glSXn5ZbFkK1s84JJ3ZNFfgDbUHEM9ZInCJjeEg1iOJfqL6Mkxlax/aAd0VeJQrKonfjwr0zdTurS9mdTy263TgamSwW/m54xhrqH6OGTUU3473s3pREU8itwgMDVf9kZDBeteUBARD4Z2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dytO7+Ct; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DC51F00893;
	Sun,  7 Jun 2026 10:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829556;
	bh=BQQ7rehku++7n70RJrYowjakR6IiUWhf9T7oC7pToEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dytO7+CtTd5B+Ds7bSh5G7VZhuLX3GzojFKUIHRINxdGUNhZg96Aj/0/rRe+7QEK+
	 QENWgktBX0wxB6d4EhcmMN6embdSBv5Kq5rNoMG6ky+CuTqne0l1gRacp6Lbfw396P
	 Nb9f14/5NwSsywq2tSJeMrO5wqCgS32VxID/NlB4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.18 258/315] drm/i915/psr: Block DC states on vblank enable when Panel Replay supported
Date: Sun,  7 Jun 2026 12:00:45 +0200
Message-ID: <20260607095737.037255332@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jouni.hogander@intel.com,m:michal.grzelak@intel.com,m:tursulin@ursulin.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261711-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,ursulin.net:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B149C6501C7

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jouni Högander <jouni.hogander@intel.com>

commit 8bb9093df555f9e89fdbe1405118b11384c03e04 upstream.

Currently we are blocking DC states only when Panel Replay is enabled on
vblank enable. It may happen that Panel Replay is getting enabled when
vblank is already enabled. Fix this by blocking DC states always if Panel
Replay is supported.

While at it take care of possible dual eDP case by looping all encoders
supporting PSR.

Fixes: 0c427ac78a1d ("drm/i915/psr: Add interface to notify PSR of vblank enable/disable")
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>
Link: https://patch.msgid.link/20260520104944.239797-1-jouni.hogander@intel.com
(cherry picked from commit eb5911f990554f7ce947dd53df00c114362e4465)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3982,32 +3982,33 @@ void intel_psr_notify_vblank_enable_disa
 					    bool enable)
 {
 	struct intel_encoder *encoder;
+	bool block_dc_states = false;
 
 	for_each_intel_encoder_with_psr(display->drm, encoder) {
 		struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 
 		mutex_lock(&intel_dp->psr.lock);
-		if (intel_dp->psr.panel_replay_enabled) {
-			mutex_unlock(&intel_dp->psr.lock);
-			break;
-		}
+		if (CAN_PANEL_REPLAY(intel_dp))
+			block_dc_states = true;
 
-		if (intel_dp->psr.enabled && intel_dp->psr.pkg_c_latency_used)
+		if (intel_dp->psr.enabled && !intel_dp->psr.panel_replay_enabled &&
+		    intel_dp->psr.pkg_c_latency_used)
 			intel_psr_apply_underrun_on_idle_wa_locked(intel_dp);
 
 		mutex_unlock(&intel_dp->psr.lock);
-		return;
 	}
 
 	/*
 	 * NOTE: intel_display_power_set_target_dc_state is used
-	 * only by PSR * code for DC3CO handling. DC3CO target
+	 * only by PSR code for DC3CO handling. DC3CO target
 	 * state is currently disabled in * PSR code. If DC3CO
 	 * is taken into use we need take that into account here
 	 * as well.
 	 */
-	intel_display_power_set_target_dc_state(display, enable ? DC_STATE_DISABLE :
-						DC_STATE_EN_UPTO_DC6);
+	if (block_dc_states)
+		intel_display_power_set_target_dc_state(display, enable ?
+							DC_STATE_DISABLE :
+							DC_STATE_EN_UPTO_DC6);
 }
 
 static void



