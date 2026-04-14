Return-Path: <stable+bounces-237802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBOsJP4i3mk1ngkAu9opvQ
	(envelope-from <stable+bounces-237802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:20:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69F3F93F1
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13CA53009539
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5573469E0;
	Tue, 14 Apr 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZ0P+y3a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD6150997
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165627; cv=none; b=cZjYJoA9+S40LFr47sVhYUgXE2dneuWIon70d7hJO4hEU2YCPXLcM1XG1FhurQ5O2Jih/KgWd/0NkBQ5jpzCVlnlYzopGqL+Au3wtETlfRAOOcWn/XujPrgckT3Du73nc+g8x0oB+KHyTs3wK7MBPAvomW/yQ7mYtuphV4P/b0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165627; c=relaxed/simple;
	bh=70uWmhQSBPhkTGB+oAjtaz/7Ep6qaeC/Myyl7te6GJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAc1N9aUOXl34rNr1E4+Rzk/U8k8zURn+kI0080QZ2L8thD29vsk7ebtQrdS/agh8uYZdfczk4JWtKpsAGR40bHwmoSE3oAk1V9wt/I/mnCD5dyRVmkybGWNemSM0JFOdVqZhguhfxLgtboXd9DJhm6danor7flwV9y6kEmz5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZ0P+y3a; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776165625; x=1807701625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70uWmhQSBPhkTGB+oAjtaz/7Ep6qaeC/Myyl7te6GJ4=;
  b=gZ0P+y3ahuGSZuNnzKuuYoDOn40yjW3MDAX4jHUj3aYa/Ax6aQcH4ClD
   VgRqbWv59Pd/HaOka2vHHpCspKjjwEfB/9nFB5E4+AE0nWoiMXzMU3cYa
   oxF+bZo7tVEHLNpZcsWPjkGaqn0Kcyr+SOKtmAGkmV8kkXF90MY1FMktO
   Ss+jHyguRa3zsV/zIphF2/BS2HhPhyXUNfMLe+u4JFVRBFmPVCfxawBpN
   P6V2llQEgb+hCvG82pbaoU5PJivL6IcAy9sfuznZwYwQRm3EY0BCfvG1O
   Hs8+o6oxyFD2izrqQeTRxmcvpLt3vsjDxqzcnu8VZEVN6PopH4qngFDOr
   w==;
X-CSE-ConnectionGUID: tNcDjIUcRT+9pPhF7Pm7eA==
X-CSE-MsgGUID: A7r7MVcFRa+ZijroBC/EfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87424218"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87424218"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:20:25 -0700
X-CSE-ConnectionGUID: Q4DbUWFVQwaETPbDr3Q8sg==
X-CSE-MsgGUID: UG/GCFm0TK6DbbFaMNvVXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229943240"
Received: from amilburn-desk.amilburn-desk (HELO jhogande-mobl3.intel.com) ([10.245.245.120])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:20:24 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx-trybot@lists.freedesktop.or
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used
Date: Tue, 14 Apr 2026 14:20:07 +0300
Message-ID: <20260414112008.329217-4-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414112008.329217-1-jouni.hogander@intel.com>
References: <20260414112008.329217-1-jouni.hogander@intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237802-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: CF69F3F93F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is Intel specific workaround DPCD address containing workaround for
case where SDP is on prior line. Apply this workaround according to values
in the offset.

Fixes: 61e887329e33 ("drm/i915/xelpd: Handle PSR2 SDP indication in the prior scanline")
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 36 +++++++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 1f3f0d35d52a..341186622ed4 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1385,9 +1385,36 @@ static bool psr2_granularity_check(struct intel_crtc_state *crtc_state,
 	return true;
 }
 
-static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_dp,
-							struct intel_crtc_state *crtc_state)
+static bool apply_scanline_indication_wa(struct intel_crtc_state *crtc_state,
+					 struct intel_connector *connector)
 {
+	struct intel_dp *intel_dp = intel_attached_dp(connector);
+	u8 early_scanline_support = connector->dp.psr_caps.intel_wa_dpcd &
+		INTEL_WA_REGISTER_CAPS_PSR2_EARLYSCANLINE_SDP_SUPPORT_MASK;
+
+	if (intel_dp->edp_dpcd[0] >= DP_EDP_15)
+		return true;
+
+	switch(early_scanline_support)
+	{
+	case INTEL_WA_REGISTER_CAPS_FALL_BACK_TO_PSR1:
+		crtc_state->req_psr2_sdp_prior_scanline = false;
+		return false;
+	case INTEL_WA_REGISTER_CAPS_PSR2_WITH_EARLY_SCANLINE:
+		return true;
+	case INTEL_WA_REGISTER_CAPS_PSR2_WITHOUT_EARLY_SCANLINE:
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
@@ -1406,7 +1433,8 @@ static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_d
 		return false;
 
 	crtc_state->req_psr2_sdp_prior_scanline = true;
-	return true;
+
+	return apply_scanline_indication_wa(crtc_state, connector);
 }
 
 static int intel_psr_entry_setup_frames(struct intel_dp *intel_dp,
@@ -1687,7 +1715,7 @@ static bool intel_sel_update_config_valid(struct intel_crtc_state *crtc_state,
 								      conn_state))
 		goto unsupported;
 
-	if (!_compute_psr2_sdp_prior_scanline_indication(intel_dp, crtc_state)) {
+	if (!_compute_psr2_sdp_prior_scanline_indication(crtc_state, connector)) {
 		drm_dbg_kms(display->drm,
 			    "Selective update not enabled, SDP indication do not fit in hblank\n");
 		goto unsupported;
-- 
2.43.0


