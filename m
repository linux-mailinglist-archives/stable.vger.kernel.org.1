Return-Path: <stable+bounces-226168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ52BuaEuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:44:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C43F52AE506
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 301B330AAC5E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8873EBF00;
	Tue, 17 Mar 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oABVAQyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F1375F99
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765571; cv=none; b=U7NcVqCUng3l28h2X2EXOMw0+s1YguOhLenALgEfklYJAQcTX1XuVKigT6OERodpjGzV+PjqlY0W427zwXlLIzEvHslvXgDcudGogysg7Lmd/Gf3Z1nl/VtT6lAeFtEa2NK9O+KCWmqltwdW4DMh9g0K/+5ERvl21GVn4o3MMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765571; c=relaxed/simple;
	bh=1Ew79qgTo41Z+diI7x+NHDyQf/ir9lKOTVNj7FFqKlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUQt2mrolBvg7UJuWH+uuRtcQVlYRRPVd5GB2PKe3lKz8sVPeK8qmad2Tt+PmQ4jTIYCjFsHsZnLIQs/BHcoOwbD/4jaIhtDbHcUukJFZxyCyUf0EqKltWhYUwYt2zSxy+RJji1zzq9qddn9fXk9KdYaqopBtohiK7LvrRRIxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oABVAQyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD90C19424;
	Tue, 17 Mar 2026 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765571;
	bh=1Ew79qgTo41Z+diI7x+NHDyQf/ir9lKOTVNj7FFqKlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oABVAQyTV8VzpqIXqcv8lPgwcV597J5K9cSl/nVEG7PTxpKPXglYBOdP6U3ggjSci
	 9aXI/wEcktWWeEgmubDyb13HzxHFl1LcwFWBS3bma+ynBgNvBZdMEm9zOScKlTZRTo
	 32E6dJYnYW2B2m6XnNFxpdbK0Y7KOvpJLUqtpuk8Ebi4UCaECrOQb0njjCKzgMNOMt
	 FpJo1oo8b9jTVy8Y+E02fNgZbw8hhoQCSn2DdRWlh8dUDLYdu3cr9CabzaMw4I6n3X
	 cQMzokn8rFJWG8kX/n+EpmEfpzSHeDmLD60vlCgJPt3B9TgdhaBBmaFyJ/4XBYTuRQ
	 LG1+dI6IWPmGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Animesh Manna <animesh.manna@intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/8] drm/i915/lobf: Update lobf if any change in dependent parameters
Date: Tue, 17 Mar 2026 12:39:22 -0400
Message-ID: <20260317163924.220634-6-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-226168-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C43F52AE506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Animesh Manna <animesh.manna@intel.com>

[ Upstream commit 64a5dd770d35cb2b14f929eb13fb7863d1bedb1c ]

For every commit the dependent condition for LOBF is checked
and accordingly update has_lobf flag which will be used
to update the ALPM_CTL register during commit.

v1: Initial version.
v2: Avoid reading h/w register without has_lobf check. [Jani]
v3: Update LOBF in post plane update instead of separate function. [Jouni]
v4:
- Add lobf disable print. [Jouni]
- Simplify condition check for enabling/disabling lobf. [Jouni]
v5: Disable LOBF in pre_plane_update(). [Jouni]
v6: use lobf flag of old_crtc_state and write 0 into ALPM_CTL. [Jouni]

Signed-off-by: Animesh Manna <animesh.manna@intel.com>
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Link: https://lore.kernel.org/r/20250423092334.2294483-7-animesh.manna@intel.com
Stable-dep-of: eb4a7139e973 ("drm/i915/alpm: ALPM disable fixes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_alpm.c    | 41 +++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_alpm.h    |  2 +
 drivers/gpu/drm/i915/display/intel_display.c |  1 +
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 8f83dfb899308..e3004725e044b 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -366,15 +366,54 @@ void intel_alpm_configure(struct intel_dp *intel_dp,
 	intel_dp->alpm_parameters.transcoder = crtc_state->cpu_transcoder;
 }
 
+void intel_alpm_pre_plane_update(struct intel_atomic_state *state,
+				 struct intel_crtc *crtc)
+{
+	struct intel_display *display = to_intel_display(state);
+	const struct intel_crtc_state *crtc_state =
+		intel_atomic_get_new_crtc_state(state, crtc);
+	const struct intel_crtc_state *old_crtc_state =
+		intel_atomic_get_old_crtc_state(state, crtc);
+	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
+	struct intel_encoder *encoder;
+
+	if (DISPLAY_VER(display) < 20)
+		return;
+
+	if (crtc_state->has_lobf || crtc_state->has_lobf == old_crtc_state->has_lobf)
+		return;
+
+	for_each_intel_encoder_mask(display->drm, encoder,
+				    crtc_state->uapi.encoder_mask) {
+		struct intel_dp *intel_dp;
+
+		if (!intel_encoder_is_dp(encoder))
+			continue;
+
+		intel_dp = enc_to_intel_dp(encoder);
+
+		if (!intel_dp_is_edp(intel_dp))
+			continue;
+
+		if (old_crtc_state->has_lobf) {
+			intel_de_write(display, ALPM_CTL(display, cpu_transcoder), 0);
+			drm_dbg_kms(display->drm, "Link off between frames (LOBF) disabled\n");
+		}
+	}
+}
+
 void intel_alpm_post_plane_update(struct intel_atomic_state *state,
 				  struct intel_crtc *crtc)
 {
 	struct intel_display *display = to_intel_display(state);
 	const struct intel_crtc_state *crtc_state =
 		intel_atomic_get_new_crtc_state(state, crtc);
+	const struct intel_crtc_state *old_crtc_state =
+		intel_atomic_get_old_crtc_state(state, crtc);
 	struct intel_encoder *encoder;
 
-	if (!crtc_state->has_lobf && !crtc_state->has_psr)
+	if ((!crtc_state->has_lobf ||
+	     crtc_state->has_lobf == old_crtc_state->has_lobf) && !crtc_state->has_psr)
 		return;
 
 	for_each_intel_encoder_mask(display->drm, encoder,
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index 91f51fb24f981..77bae022a0eaf 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -23,6 +23,8 @@ void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
 				    struct drm_connector_state *conn_state);
 void intel_alpm_configure(struct intel_dp *intel_dp,
 			  const struct intel_crtc_state *crtc_state);
+void intel_alpm_pre_plane_update(struct intel_atomic_state *state,
+				 struct intel_crtc *crtc);
 void intel_alpm_post_plane_update(struct intel_atomic_state *state,
 				  struct intel_crtc *crtc);
 void intel_alpm_lobf_debugfs_add(struct intel_connector *connector);
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index bb05c8fd5e5f3..62c0d2e968db8 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1198,6 +1198,7 @@ static void intel_pre_plane_update(struct intel_atomic_state *state,
 		intel_atomic_get_new_crtc_state(state, crtc);
 	enum pipe pipe = crtc->pipe;
 
+	intel_alpm_pre_plane_update(state, crtc);
 	intel_psr_pre_plane_update(state, crtc);
 
 	if (intel_crtc_vrr_disabling(state, crtc)) {
-- 
2.51.0


