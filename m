Return-Path: <stable+bounces-226167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAYbMuKEuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:44:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8286B2AE4FE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 972E430AA3D9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D623ECBD7;
	Tue, 17 Mar 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7u9yvJT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9A3EC2E4
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765570; cv=none; b=dRpsvTK9GZdZlzkc5GLhL2LrxdRSpj+En/aWyGyA4TGd4p6EtIbREAnmBZ4MdnKdLqOxgptquyf96Cch0py4EHyhRJNcTcHCw5zWHP80qO+ELZZ0HBuCUUvz4PSfF4iS9u87I3BdMWOqSmOa0hDJ3dXJ8eZUB+fq5cfll50OjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765570; c=relaxed/simple;
	bh=cn5mKvSsLWeU2/we4D9CV8XTM3lnDyJ1nXketrUS8fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSIXFSLo5j0wxGGC/f1sYjUYSSfxm7b1sfim9Gc0glROX0IA/ETeviPX3Iszqw7yiCOBU31F3b4w5mAwsT4S7w/OgNn7wTtOyrTwfnS8+Uoe0XiLxXaRCzzzuOvDYKqCHZgJJMBrGTwFgFvhYQdxPMQzLRg2kISB4RXFOBS3mtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7u9yvJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2150CC2BCB1;
	Tue, 17 Mar 2026 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765570;
	bh=cn5mKvSsLWeU2/we4D9CV8XTM3lnDyJ1nXketrUS8fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7u9yvJTMyYybTQqaMMOiW8ClWtVB8M9sbTX6IhoAgOObdhckwHZZcGw5KQkRazv1
	 BYIW5KcyP6fzBYAvfR7EI9YtkkxOMcVYbY1ydHYX/iQLrz+XYgiqEmOZCI8Roo5E0x
	 EuKi7CHzVnaqVtSkvxUwhx9yaV/Df/7MbB7FB/UNnFk6RtpL1uDHrMIRXE4PK1Rvdd
	 oSC2XGlz1tJUzLo6LnVz206DT4RHLiVa6medpPBBY6VPc0zwYGYx8k4wZQ7CGOo9GT
	 os8zDxKeWTLpyuJoTZnNTl9XJ+MukVMfhgd07gR9UwBks+CBhzpFVt6AFPAmHc7HAX
	 t8L0C6DkqE2/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Animesh Manna <animesh.manna@intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/8] drm/i915/lobf: Disintegrate alpm_disable from psr_disable
Date: Tue, 17 Mar 2026 12:39:21 -0400
Message-ID: <20260317163924.220634-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317163924.220634-1-sashal@kernel.org>
References: <2026031731-secret-rocket-af05@gregkh>
 <20260317163924.220634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226167-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 8286B2AE4FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Animesh Manna <animesh.manna@intel.com>

[ Upstream commit 504766382edb2a8babe030aad507965be1d632ee ]

Currently clearing of alpm registers is done through psr_disable()
which is always not correct, without psr also alpm can exist. So
dis-integrate alpm_disable() from psr_disable().

v1: Initial version.
v2:
- Remove h/w register read from alpm_disable(). [Jani]

Signed-off-by: Animesh Manna <animesh.manna@intel.com>
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Link: https://lore.kernel.org/r/20250423092334.2294483-5-animesh.manna@intel.com
Stable-dep-of: eb4a7139e973 ("drm/i915/alpm: ALPM disable fixes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_alpm.c      | 18 ++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_alpm.h      |  1 +
 drivers/gpu/drm/i915/display/intel_ddi.c       |  2 ++
 .../gpu/drm/i915/display/intel_display_types.h |  1 +
 drivers/gpu/drm/i915/display/intel_psr.c       | 11 -----------
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index d256bb831b136..8f83dfb899308 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -363,6 +363,7 @@ void intel_alpm_configure(struct intel_dp *intel_dp,
 			  const struct intel_crtc_state *crtc_state)
 {
 	lnl_alpm_configure(intel_dp, crtc_state);
+	intel_dp->alpm_parameters.transcoder = crtc_state->cpu_transcoder;
 }
 
 void intel_alpm_post_plane_update(struct intel_atomic_state *state,
@@ -438,3 +439,20 @@ void intel_alpm_lobf_debugfs_add(struct intel_connector *connector)
 	debugfs_create_file("i915_edp_lobf_info", 0444, root,
 			    connector, &i915_edp_lobf_info_fops);
 }
+
+void intel_alpm_disable(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+	enum transcoder cpu_transcoder = intel_dp->alpm_parameters.transcoder;
+
+	if (DISPLAY_VER(display) < 20)
+		return;
+
+	intel_de_rmw(display, ALPM_CTL(display, cpu_transcoder),
+		     ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE |
+		     ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
+
+	intel_de_rmw(display,
+		     PORT_ALPM_CTL(cpu_transcoder),
+		     PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index 2f862b0476a8a..91f51fb24f981 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -28,4 +28,5 @@ void intel_alpm_post_plane_update(struct intel_atomic_state *state,
 void intel_alpm_lobf_debugfs_add(struct intel_connector *connector);
 bool intel_alpm_aux_wake_supported(struct intel_dp *intel_dp);
 bool intel_alpm_aux_less_wake_supported(struct intel_dp *intel_dp);
+void intel_alpm_disable(struct intel_dp *intel_dp);
 #endif
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 5b24460c01341..6514ebbaf0025 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -34,6 +34,7 @@
 #include "i915_drv.h"
 #include "i915_reg.h"
 #include "icl_dsi.h"
+#include "intel_alpm.h"
 #include "intel_audio.h"
 #include "intel_audio_regs.h"
 #include "intel_backlight.h"
@@ -3423,6 +3424,7 @@ static void intel_disable_ddi_dp(struct intel_atomic_state *state,
 	intel_dp->link_trained = false;
 
 	intel_psr_disable(intel_dp, old_crtc_state);
+	intel_alpm_disable(intel_dp);
 	intel_edp_backlight_off(old_conn_state);
 	/* Disable the decompression in DP Sink */
 	intel_dp_sink_disable_decompression(state,
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 9812191e7ef29..b6a388f5a7c8b 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1906,6 +1906,7 @@ struct intel_dp {
 	struct {
 		u8 io_wake_lines;
 		u8 fast_wake_lines;
+		enum transcoder transcoder;
 
 		/* LNL and beyond */
 		u8 check_entry_lines;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 855f22f1f8328..3a8da3dcab6d5 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2108,17 +2108,6 @@ static void intel_psr_disable_locked(struct intel_dp *intel_dp)
 	if (intel_dp_is_edp(intel_dp))
 		intel_snps_phy_update_psr_power_state(&dp_to_dig_port(intel_dp)->base, false);
 
-	/* Panel Replay on eDP is always using ALPM aux less. */
-	if (intel_dp->psr.panel_replay_enabled && intel_dp_is_edp(intel_dp)) {
-		intel_de_rmw(display, ALPM_CTL(display, cpu_transcoder),
-			     ALPM_CTL_ALPM_ENABLE |
-			     ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
-
-		intel_de_rmw(display,
-			     PORT_ALPM_CTL(cpu_transcoder),
-			     PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
-	}
-
 	/* Disable PSR on Sink */
 	if (!intel_dp->psr.panel_replay_enabled) {
 		drm_dp_dpcd_writeb(&intel_dp->aux, DP_PSR_EN_CFG, 0);
-- 
2.51.0


