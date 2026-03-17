Return-Path: <stable+bounces-226169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Bi0IdSDuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:39:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 523152AE2AB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2352303AA8C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55903EC2CD;
	Tue, 17 Mar 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5mx64I/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835A375F99
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765572; cv=none; b=nSXPDR5C+Bw1Z0Y9LC1GcalviDFAWnzEdrRUmCH7KsOAIaqztnina92L30in8mftXpNVtp7s1uBPj3AgIPxQ4GdHBPTD76zpVL1IaVcjF0dCFzJ5FDM2Ty4Lejz6lQeEFNhXELBQEe0JoZ3JcOLqvCNKy1ngPLUeBU9eLZBnobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765572; c=relaxed/simple;
	bh=vsX5ZgyI2yzAupeD43f7excAFksBBh0Rysf9g91xeBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfPRZqa8FktfbLTVTvzAENdfYaPQyzlK9uIRNlrqkLROJ7mI2Gc19NPuK4GOqR9bRw3r8yJXSc220k9D9XJlexmpE11SNDD2okHbmmWEPnZ7xq/TxdetetSX80hslg+YLescRAqm1g0MsdCls26R9DTkGb8lj5Xa2+JkTNe/BEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5mx64I/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB656C4CEF7;
	Tue, 17 Mar 2026 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765572;
	bh=vsX5ZgyI2yzAupeD43f7excAFksBBh0Rysf9g91xeBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5mx64I/oA6xo+CFv353G2culRD6XGDHSRSkWY3inMIXSG+wb03KxMSI1fjL38wIH
	 oMtkF8d4acsopwa1lM8HiOV5X5FktuAOFmr/qVAU06T6nwvr1483cDbR+vymOEI+zY
	 DscIpTQaAPbj1aoiaA2RLVvAmrRilE/XkSOajid55mAXVlbIGjZT7aeOpPsIIpv0lI
	 r57eRe03ZuXv+SU7k+u+6KOQfWz+UERhshjHX0QUyhYgtrVoXXPPEpLzqvymQPuFCP
	 0hoBH4NfS8lknB47SkKG4TxI+mMBGGlpdIgxyQVjD4w653lEZ3OBPKaZQ6yjyOhY3/
	 iN+Q2oy34eriA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Animesh Manna <animesh.manna@intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/8] drm/i915/lobf: Add mutex for alpm update
Date: Tue, 17 Mar 2026 12:39:23 -0400
Message-ID: <20260317163924.220634-7-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226169-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 523152AE2AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Animesh Manna <animesh.manna@intel.com>

[ Upstream commit acff6d6bded31d98698693827860adc5befdd854 ]

The ALPM_CTL can be updated from different context, so
add mutex to sychonize the update.

Signed-off-by: Animesh Manna <animesh.manna@intel.com>
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Link: https://lore.kernel.org/r/20250423092334.2294483-9-animesh.manna@intel.com
Stable-dep-of: eb4a7139e973 ("drm/i915/alpm: ALPM disable fixes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_alpm.c          | 11 ++++++++++-
 drivers/gpu/drm/i915/display/intel_alpm.h          |  2 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c            |  2 +-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index e3004725e044b..d72e10160f1d4 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -21,7 +21,7 @@ bool intel_alpm_aux_less_wake_supported(struct intel_dp *intel_dp)
 	return intel_dp->alpm_dpcd & DP_ALPM_AUX_LESS_CAP;
 }
 
-void intel_alpm_init_dpcd(struct intel_dp *intel_dp)
+void intel_alpm_init(struct intel_dp *intel_dp)
 {
 	u8 dpcd;
 
@@ -29,6 +29,7 @@ void intel_alpm_init_dpcd(struct intel_dp *intel_dp)
 		return;
 
 	intel_dp->alpm_dpcd = dpcd;
+	mutex_init(&intel_dp->alpm_parameters.lock);
 }
 
 /*
@@ -318,6 +319,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 	    (!intel_dp->psr.sel_update_enabled && !intel_dp_is_edp(intel_dp)))
 		return;
 
+	mutex_lock(&intel_dp->alpm_parameters.lock);
 	/*
 	 * Panel Replay on eDP is always using ALPM aux less. I.e. no need to
 	 * check panel support at this point.
@@ -357,6 +359,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 	alpm_ctl |= ALPM_CTL_ALPM_ENTRY_CHECK(intel_dp->alpm_parameters.check_entry_lines);
 
 	intel_de_write(display, ALPM_CTL(display, cpu_transcoder), alpm_ctl);
+	mutex_unlock(&intel_dp->alpm_parameters.lock);
 }
 
 void intel_alpm_configure(struct intel_dp *intel_dp,
@@ -396,8 +399,10 @@ void intel_alpm_pre_plane_update(struct intel_atomic_state *state,
 			continue;
 
 		if (old_crtc_state->has_lobf) {
+			mutex_lock(&intel_dp->alpm_parameters.lock);
 			intel_de_write(display, ALPM_CTL(display, cpu_transcoder), 0);
 			drm_dbg_kms(display->drm, "Link off between frames (LOBF) disabled\n");
+			mutex_unlock(&intel_dp->alpm_parameters.lock);
 		}
 	}
 }
@@ -487,6 +492,8 @@ void intel_alpm_disable(struct intel_dp *intel_dp)
 	if (DISPLAY_VER(display) < 20)
 		return;
 
+	mutex_lock(&intel_dp->alpm_parameters.lock);
+
 	intel_de_rmw(display, ALPM_CTL(display, cpu_transcoder),
 		     ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE |
 		     ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
@@ -494,4 +501,6 @@ void intel_alpm_disable(struct intel_dp *intel_dp)
 	intel_de_rmw(display,
 		     PORT_ALPM_CTL(cpu_transcoder),
 		     PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
+
+	mutex_unlock(&intel_dp->alpm_parameters.lock);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index 77bae022a0eaf..c043a071f84f3 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -15,7 +15,7 @@ struct intel_connector;
 struct intel_atomic_state;
 struct intel_crtc;
 
-void intel_alpm_init_dpcd(struct intel_dp *intel_dp);
+void intel_alpm_init(struct intel_dp *intel_dp);
 bool intel_alpm_compute_params(struct intel_dp *intel_dp,
 			       const struct intel_crtc_state *crtc_state);
 void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index b6a388f5a7c8b..cb4b192c9e9bd 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1907,6 +1907,7 @@ struct intel_dp {
 		u8 io_wake_lines;
 		u8 fast_wake_lines;
 		enum transcoder transcoder;
+		struct mutex lock;
 
 		/* LNL and beyond */
 		u8 check_entry_lines;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index eb4952be7bccc..fd9d9649c962d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6716,7 +6716,7 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 	 */
 	intel_hpd_enable_detection(encoder);
 
-	intel_alpm_init_dpcd(intel_dp);
+	intel_alpm_init(intel_dp);
 
 	/* Cache DPCD and EDID for edp. */
 	has_dpcd = intel_edp_init_dpcd(intel_dp, intel_connector);
-- 
2.51.0


