Return-Path: <stable+bounces-230642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEYKDAdwxmmkJwUAu9opvQ
	(envelope-from <stable+bounces-230642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:54:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E3343D82
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F140F307F76D
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74E1381AF6;
	Fri, 27 Mar 2026 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvQxMbuK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC88386C09
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612003; cv=none; b=Tj3W6CkHYNOfKqwyVhoBSYqlzWndwwFhsxB67clMxJ0uD3x2GT1WMlxw/1RNeUnt5XkGyhQjm5e0Adfni3pJe/ZDab3nxnl3lev4Wuj3NZ9WwX0uL1hy7jcLydX+BZbEkeur6W5BrkhUkjQpNRwXAgvpWrKvOXuxZNA6CntIQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612003; c=relaxed/simple;
	bh=2SReUIEW+N5fPvKsaAFz3LSS6Xf5KjfFY30T7fnWYAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XBT/6f8UFcmtUSKhIq21MUHLXDWJ8qZFy5cWkQXDdsnfytPjs+spd+5dumgzcdROdlns1Ozs1HINtu15yzVQt+Oa+lFmS7pb2M8iaKwAF02Wf5WMHs1jcpQBQhwz4TjlOX0W4rVH9ZXIQY7LJ6uJzYXn0Tg1qnWLqoXcsPX/Jro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvQxMbuK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774612001; x=1806148001;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2SReUIEW+N5fPvKsaAFz3LSS6Xf5KjfFY30T7fnWYAw=;
  b=fvQxMbuKcxMJWKTk3a2Qrt6LynXVQCPRw6sFBe2Ti01kkqu/kWyWAXUK
   HNZFPUXvoTwL/MUtR2GhqBeMdqZGti6tK35AvOKNBYb9+RY2/82gbJu9R
   Oe7Eh64bDBKmEKmGo0thpgIc9xeZhmtOptTnJSEx0XNXCw3a1X15BCXsz
   EzKR1s/KzbERpRIWxGyqYS6ofDJs7uTqPw44nP2S2/UbsiMnUPngYCK4D
   OiRWI1KyRukLL3s8+f61SVa8B/vpI54cmDXo1CQXucb7fOpwG8oSrT5Il
   8NopvSeNtP9WVHalSst1sxcIrZ0tGSFkohgSqltT2/kA+iaGSniH8bVxS
   Q==;
X-CSE-ConnectionGUID: mPJPDKO2RN6Q2mQHLUBBPg==
X-CSE-MsgGUID: bnd9Zf3fQsunnb4tV0Pf3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75564584"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75564584"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:46:40 -0700
X-CSE-ConnectionGUID: VhsguT5/QRGXCL7jFoVtkg==
X-CSE-MsgGUID: EQ+A1sM0RCGmuRcvV0NCjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="222422328"
Received: from rvuia-mobl.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.244.118])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:46:39 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/psr: Do not use pipe_src as borders for SU area
Date: Fri, 27 Mar 2026 13:45:53 +0200
Message-ID: <20260327114553.195285-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230642-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 398E3343D82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This far using crtc_state->pipe_src as borders for Selective Update area
haven't caused visible problems as drm_rect_width(crtc_state->pipe_src) ==
crtc_state->hw.adjusted_mode.crtc_hdisplay and
drm_rect_height(crtc_state->pipe_src) ==
crtc_state->hw.adjusted_mode.crtc_vdisplay when pipe scaling is not
used. On the other hand using pipe scaling is forcing full frame updates and all the
Selective Update area calculations are skipped. Now this improper usage of
crtc_state->pipe_src is causing following warnings:

<4> [7771.978166] xe 0000:00:02.0: [drm] drm_WARN_ON_ONCE(su_lines % vdsc_cfg->slice_height)

after WARN_ON_ONCE was added by commit:

"drm/i915/dsc: Add helper for writing DSC Selective Update ET parameters"

These warnings are seen when DSC and pipe scaling are enabled
simultaneously. This is because on full frame update SU area is improperly
set as pipe_src which is not aligned with DSC slice height.

Fix these by creating local rectangle using
crtc_state->hw.adjusted_mode.crtc_hdisplay and
crtc_state->hw.adjusted_mode.crtc_vdisplay. Use this local rectangle as
borders for SU area.

Fixes: d6774b8c3c58 ("drm/i915: Ensure damage clip area is within pipe area")
Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 27 ++++++++++++++----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 2f1b48cd8efd..33b2ae17274a 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2689,9 +2689,9 @@ static u32 psr2_pipe_srcsz_early_tpt_calc(struct intel_crtc_state *crtc_state,
 
 static void clip_area_update(struct drm_rect *overlap_damage_area,
 			     struct drm_rect *damage_area,
-			     struct drm_rect *pipe_src)
+			     struct drm_rect *display_area)
 {
-	if (!drm_rect_intersect(damage_area, pipe_src))
+	if (!drm_rect_intersect(damage_area, display_area))
 		return;
 
 	if (overlap_damage_area->y1 == -1) {
@@ -2742,6 +2742,7 @@ static bool intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_st
 static void
 intel_psr2_sel_fetch_et_alignment(struct intel_atomic_state *state,
 				  struct intel_crtc *crtc,
+				  struct drm_rect *display_area,
 				  bool *cursor_in_su_area)
 {
 	struct intel_crtc_state *crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
@@ -2769,7 +2770,7 @@ intel_psr2_sel_fetch_et_alignment(struct intel_atomic_state *state,
 			continue;
 
 		clip_area_update(&crtc_state->psr2_su_area, &new_plane_state->uapi.dst,
-				 &crtc_state->pipe_src);
+				 display_area);
 		*cursor_in_su_area = true;
 	}
 }
@@ -2866,6 +2867,9 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	struct intel_crtc_state *crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
 	struct intel_plane_state *new_plane_state, *old_plane_state;
 	struct intel_plane *plane;
+	struct drm_rect display_area = { .x1 = 0, .y1 = 0,
+		.x2 = crtc_state->hw.adjusted_mode.crtc_hdisplay,
+		.y2 = crtc_state->hw.adjusted_mode.crtc_vdisplay};
 	bool full_update = false, su_area_changed;
 	int i, ret;
 
@@ -2879,7 +2883,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 	crtc_state->psr2_su_area.x1 = 0;
 	crtc_state->psr2_su_area.y1 = -1;
-	crtc_state->psr2_su_area.x2 = drm_rect_width(&crtc_state->pipe_src);
+	crtc_state->psr2_su_area.x2 = drm_rect_width(&display_area);
 	crtc_state->psr2_su_area.y2 = -1;
 
 	/*
@@ -2917,14 +2921,14 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 				damaged_area.y1 = old_plane_state->uapi.dst.y1;
 				damaged_area.y2 = old_plane_state->uapi.dst.y2;
 				clip_area_update(&crtc_state->psr2_su_area, &damaged_area,
-						 &crtc_state->pipe_src);
+						 &display_area);
 			}
 
 			if (new_plane_state->uapi.visible) {
 				damaged_area.y1 = new_plane_state->uapi.dst.y1;
 				damaged_area.y2 = new_plane_state->uapi.dst.y2;
 				clip_area_update(&crtc_state->psr2_su_area, &damaged_area,
-						 &crtc_state->pipe_src);
+						 &display_area);
 			}
 			continue;
 		} else if (new_plane_state->uapi.alpha != old_plane_state->uapi.alpha) {
@@ -2932,7 +2936,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 			damaged_area.y1 = new_plane_state->uapi.dst.y1;
 			damaged_area.y2 = new_plane_state->uapi.dst.y2;
 			clip_area_update(&crtc_state->psr2_su_area, &damaged_area,
-					 &crtc_state->pipe_src);
+					 &display_area);
 			continue;
 		}
 
@@ -2948,7 +2952,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		damaged_area.x1 += new_plane_state->uapi.dst.x1 - src.x1;
 		damaged_area.x2 += new_plane_state->uapi.dst.x1 - src.x1;
 
-		clip_area_update(&crtc_state->psr2_su_area, &damaged_area, &crtc_state->pipe_src);
+		clip_area_update(&crtc_state->psr2_su_area, &damaged_area, &display_area);
 	}
 
 	/*
@@ -2983,7 +2987,8 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		 * cursor is added into affected planes even when
 		 * cursor is not updated by itself.
 		 */
-		intel_psr2_sel_fetch_et_alignment(state, crtc, &cursor_in_su_area);
+		intel_psr2_sel_fetch_et_alignment(state, crtc, &display_area,
+						  &cursor_in_su_area);
 
 		su_area_changed = intel_psr2_sel_fetch_pipe_alignment(crtc_state);
 
@@ -3059,8 +3064,8 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 skip_sel_fetch_set_loop:
 	if (full_update)
-		clip_area_update(&crtc_state->psr2_su_area, &crtc_state->pipe_src,
-				 &crtc_state->pipe_src);
+		clip_area_update(&crtc_state->psr2_su_area, &display_area,
+				 &display_area);
 
 	psr2_man_trk_ctl_calc(crtc_state, full_update);
 	crtc_state->pipe_srcsz_early_tpt =
-- 
2.43.0


