Return-Path: <stable+bounces-238041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEhiIPwk32lcPQAAu9opvQ
	(envelope-from <stable+bounces-238041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:41:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD940086F
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A676F303A13A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFE036D513;
	Wed, 15 Apr 2026 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwUZNcRq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D234EF0C
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776231631; cv=none; b=LU5p0kEyxGV0F74Hv0muVnVOfc45KtZwUMV1/2ObU83uGENPMHpavepg9Iddr/TgGK1uh2+MC3QdLRgFdQ3PLBYk6jgJOClkVTWSHkR3H4tzSFYZ3QKvbzU4+pjCw+jw4GM4BpZZUuzzPyq9z0WjFQ98dRvqyZZmZKKSd/6dgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776231631; c=relaxed/simple;
	bh=70uWmhQSBPhkTGB+oAjtaz/7Ep6qaeC/Myyl7te6GJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laTPp1QWsuiPEGhLzZy3j2XXwty3z1KZIregv4eWSeZWOaBnENYSfYDz7WC5M2hdHTgz+9BtjKMdtLfUqw+xn2A8626gZ3AOBG7/E1rgBnZSq05grueXAiupLS02IF9EZhBrs4X/ft6z7ymmABbdEebr0vYfzAcrjvet6gUD75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwUZNcRq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776231629; x=1807767629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70uWmhQSBPhkTGB+oAjtaz/7Ep6qaeC/Myyl7te6GJ4=;
  b=SwUZNcRqoMLlDT+ct00Nn3QGq85GiU72pIYPvc4U2gf1df+XuLhAW3Im
   XgvZesh1buwjVyuXri4vkn8Gj3JCoYY7GWcsJzZi3vvL5BUMoiawQj+EX
   zZQtqBmc/nl7Su7H7EM52tBIHARtB+bSyfqOLbhjwukfxe1KGIKxM9QIs
   2h8HOCiArF6+TGpZY6zk2yUC3HkcPlWFjdISffcDWat1+2+Eu/qcbdzVB
   a/ymkjMbUjnEjQ/qsAt77neG8OqKUZ3+r/S28OrvCNrFtvSoA8FQ6Xv0C
   ijuer7FVaMdJcHVpV+Jnr0TkctB8USY1m2EuAdSra4MYnpTIXrFNjAaJt
   w==;
X-CSE-ConnectionGUID: oFLEUyRPTXmhV2V9WloBbg==
X-CSE-MsgGUID: IFQZagMhQ+GDIgPshYmxBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="102657063"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="102657063"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:40:28 -0700
X-CSE-ConnectionGUID: 2u6HHMcMQnmidSn4BleNAQ==
X-CSE-MsgGUID: EOT7dOsRR0CNG7fMUn+xTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227129786"
Received: from abityuts-desk.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.244.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:40:27 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used
Date: Wed, 15 Apr 2026 08:39:59 +0300
Message-ID: <20260415054000.400070-4-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415054000.400070-1-jouni.hogander@intel.com>
References: <20260415054000.400070-1-jouni.hogander@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238041-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: CDDD940086F
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


