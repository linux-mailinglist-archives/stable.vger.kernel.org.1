Return-Path: <stable+bounces-247636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF2fMtHzBmohpQIAu9opvQ
	(envelope-from <stable+bounces-247636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D354D3D9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6A71309F8EE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A741C2E9;
	Fri, 15 May 2026 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grIVFuLx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D233E5EE0
	for <stable@vger.kernel.org>; Fri, 15 May 2026 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839097; cv=none; b=IjuClBNBMy/wsbjAWgq29Q6Vi6IjS8zflTVae8Pv4Jby/eazWZDDiA+Kh7bXCBa0C758X5NXSsVqkKfnvZOdLopQUbISEwhMETLw1KhOXZgz+RrOe7NMJW5aGBy8+KpAk3u6YLYX17jnROCJ992WiiueQPbDN0T6EZjDtMH3XDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839097; c=relaxed/simple;
	bh=XthEBRlRRfWIHacRuRmSguYOPOHjuVxLd6BVX5QvrqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJd41A+HpG0mZbPBCU8hJvbDHvn0EEd1eJz5bIr3P0nLxF9sTh4gRnhhwPePFcIcupBj3sr7+Wj3LHrbvaOu9DIG0x/2PxrGF41Ves7nJPtRaLdYJkpQD3D/wqJNuMkpfV3Pi5TMHB/ERBVWP1IJOpTsc6usNWZUb8PVZHMfpQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grIVFuLx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778839095; x=1810375095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XthEBRlRRfWIHacRuRmSguYOPOHjuVxLd6BVX5QvrqA=;
  b=grIVFuLxbQCvtKH/iS2KPPjo8phZnxKesspVXae9qNgAMQte8XH1P8/J
   scltpMc9go5uw2dQ+MgAqqoGrotUF/My3A/a2Rz50ZRqVxtYEtoEBZ3ld
   H1fbo2xOCn24UZMUoK+dlHdubtA5ykdexzP8/oxNxo9B/B+u8liIgs0yC
   2DPxq3VZxMscC8NtIDNLek3htLoVLo7vvUCDC4KM3qyJaBN20/yr1rwRm
   RFFMFHsUo6h/SnNw8PWf4c573XkreqkN6MUpWTOUG+T1b4qY7vpQKOoif
   dodQlxlXSY0u9nFpRU5PoTce0sOnPliOFUfwfL8VguaK92JhBTipbGMcr
   g==;
X-CSE-ConnectionGUID: pmi6qqCYThSS20EHUmlDGw==
X-CSE-MsgGUID: NP/1zWmaTmGb9OXX5xzrtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="82360383"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="82360383"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:58:15 -0700
X-CSE-ConnectionGUID: L6OxcyNsS+WHmMRQHbaxgA==
X-CSE-MsgGUID: 39coXZkaRLu0Kx/8gikFNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235601810"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.20])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 02:58:13 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH v2 3/4] drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used
Date: Fri, 15 May 2026 12:57:55 +0300
Message-ID: <20260515095756.2799483-4-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515095756.2799483-1-jouni.hogander@intel.com>
References: <20260515095756.2799483-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 633D354D3D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247636-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

There is Intel specific workaround DPCD address containing workaround for
case where SDP is on prior line. Apply this workaround according to values
in the offset.

Fixes: 61e887329e33 ("drm/i915/xelpd: Handle PSR2 SDP indication in the prior scanline")
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 35 +++++++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 749057e96647..2f78d76c4ee1 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1389,9 +1389,35 @@ static bool psr2_granularity_check(struct intel_crtc_state *crtc_state,
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
@@ -1410,7 +1436,8 @@ static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_d
 		return false;
 
 	crtc_state->req_psr2_sdp_prior_scanline = true;
-	return true;
+
+	return apply_scanline_indication_wa(crtc_state, connector);
 }
 
 static int intel_psr_entry_setup_frames(struct intel_dp *intel_dp,
@@ -1691,7 +1718,7 @@ static bool intel_sel_update_config_valid(struct intel_crtc_state *crtc_state,
 								      conn_state))
 		goto unsupported;
 
-	if (!_compute_psr2_sdp_prior_scanline_indication(intel_dp, crtc_state)) {
+	if (!_compute_psr2_sdp_prior_scanline_indication(crtc_state, connector)) {
 		drm_dbg_kms(display->drm,
 			    "Selective update not enabled, SDP indication do not fit in hblank\n");
 		goto unsupported;
-- 
2.43.0


