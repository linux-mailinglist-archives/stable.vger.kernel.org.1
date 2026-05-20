Return-Path: <stable+bounces-249808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ycuVId6RDWrTzgUAu9opvQ
	(envelope-from <stable+bounces-249808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:50:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F009358BF3C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D860E3011C4C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F01399377;
	Wed, 20 May 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/OTM7bR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39D39A053
	for <stable@vger.kernel.org>; Wed, 20 May 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274204; cv=none; b=N6ddgZeuYZyigzyOAycNi/IPemvUC6ZK3mjC5N1P09nSu9Li+3t+RcuXamEQW4L8HAp9lKT7bnadaa7yKC8IByGjxzeAzcfs8QwCCR4WBK6D8M7K5gPBex0CgdYXs/LXRqokMKiAuX/huB5IPbohaVxR9FNMtIcWREEquf0C85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274204; c=relaxed/simple;
	bh=tdd8DrRqc1c9GV8gpnJG3FO5FSffrns6/zQN9bVMCNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0aHNWP8orrSeyfONEJ47P87tLmQrHjYnLYMhxcyaHO2cXPtfXr98Eci1OMkX4l/LdwL6I0DDkvCYpN9tU0rzphmWDoqTXzCC+qdBAYs12SuVrqDNqENuo4BaU4WcZ/tiZVd75tbOroIBJh+npyUMa6KXlWrCTSGaTJ0Ygjhrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/OTM7bR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779274203; x=1810810203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tdd8DrRqc1c9GV8gpnJG3FO5FSffrns6/zQN9bVMCNQ=;
  b=f/OTM7bR85gQ8jmN+aZTNRzEBdozIQtpvpwhan82ntsu3Y0IU26gyIgj
   KiwgLtWKnDcg9bwEzyhot2qrONTR0ZPUrTa5r5pe/3jllKvC0ZL4ZY/1C
   pFocUlzP79T0kvDv25HdbbUBm98H+YcA9Ee4ot4f1wgL1QGXp3OzCGoDt
   Z/6gFBhw+R+KaxkwcB1GjNH/RF+DuhuHjl+cWjECuEfWe2HouJrpbP4kU
   alBuaR6KSqyciNqfxCXlSr/TLN7KvkhMzv4F969/KjDq7jH3akSNy9pTF
   TGenVYGeGM+unXRjXM/hZP9bvEd/phoWdKleIGpCdGMku38KwYu+Hzb1C
   A==;
X-CSE-ConnectionGUID: Yyh2VhaSTECch3m+ECPMbw==
X-CSE-MsgGUID: w1xLmhj6Q9mlND/mYX9OrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84023492"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="84023492"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 03:50:03 -0700
X-CSE-ConnectionGUID: m9muDAsIT4GgRfl5mVTxaA==
X-CSE-MsgGUID: SzZU8drcSca90I6UbuHpVg==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.114])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 03:50:01 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] drm/i915/psr: Use DC_OFF wake reference to block DC6 on vblank enable
Date: Wed, 20 May 2026 13:49:44 +0300
Message-ID: <20260520104944.239797-2-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520104944.239797-1-jouni.hogander@intel.com>
References: <20260520104944.239797-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249808-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: F009358BF3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 .../gpu/drm/i915/display/intel_display_core.h |  1 +
 .../gpu/drm/i915/display/intel_display_irq.c  |  8 +++++--
 .../drm/i915/display/intel_display_types.h    |  2 ++
 drivers/gpu/drm/i915/display/intel_psr.c      | 24 +++++++------------
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_core.h b/drivers/gpu/drm/i915/display/intel_display_core.h
index 3dc5ac75a98b..64c1365fb366 100644
--- a/drivers/gpu/drm/i915/display/intel_display_core.h
+++ b/drivers/gpu/drm/i915/display/intel_display_core.h
@@ -494,6 +494,7 @@ struct intel_display {
 		u8 vblank_enabled;
 
 		int vblank_enable_count;
+		bool last_vblank_status_notified;
 
 		struct work_struct vblank_notify_work;
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c b/drivers/gpu/drm/i915/display/intel_display_irq.c
index 899a38c0a7b7..57f37f9b83a5 100644
--- a/drivers/gpu/drm/i915/display/intel_display_irq.c
+++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
@@ -1786,8 +1786,12 @@ static void intel_display_vblank_notify_work(struct work_struct *work)
 	struct intel_display *display =
 		container_of(work, typeof(*display), irq.vblank_notify_work);
 	int vblank_enable_count = READ_ONCE(display->irq.vblank_enable_count);
+	bool vblank_status = !!vblank_enable_count;
 
-	intel_psr_notify_vblank_enable_disable(display, vblank_enable_count);
+	if (display->irq.last_vblank_status_notified != vblank_status) {
+		intel_psr_notify_vblank_enable_disable(display, vblank_status);
+		display->irq.last_vblank_status_notified = vblank_status;
+	}
 }
 
 int bdw_enable_vblank(struct drm_crtc *_crtc)
@@ -1800,10 +1804,10 @@ int bdw_enable_vblank(struct drm_crtc *_crtc)
 	if (gen11_dsi_configure_te(crtc, true))
 		return 0;
 
+	spin_lock_irqsave(&display->irq.lock, irqflags);
 	if (crtc->vblank_psr_notify && display->irq.vblank_enable_count++ == 0)
 		schedule_work(&display->irq.vblank_notify_work);
 
-	spin_lock_irqsave(&display->irq.lock, irqflags);
 	bdw_enable_pipe_irq(display, pipe, GEN8_PIPE_VBLANK);
 	spin_unlock_irqrestore(&display->irq.lock, irqflags);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index f44be5c689ae..b8ccd635c575 100644
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
index 70108e0a4c0c..19cfb23fe9f8 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -4180,14 +4180,20 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
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
@@ -4195,18 +4201,6 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
 
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
-- 
2.43.0


