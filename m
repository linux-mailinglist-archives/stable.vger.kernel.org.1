Return-Path: <stable+bounces-224821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEiGH2p7sml/MwAAu9opvQ
	(envelope-from <stable+bounces-224821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:38:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02226F070
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AAB330DDCDF
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5637DEBA;
	Thu, 12 Mar 2026 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFJxGkxT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8835DA49
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304649; cv=none; b=Ga8/9JE5E2+MtN1Swup6PHvw1Xl/9cgOOYRAYa1/7mPSyPC2xOWJ8v81xGFuANDdhFChLWhtE9k18tcaOAZHn5GmrfEsLMwxd2Oacqhcui3n7hzOV8Ki9f9N3VkA6U1QJJ3DyL5qLZn/iSG0TAOtWRQUnV1FTXK/zgT1EghpHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304649; c=relaxed/simple;
	bh=tiWtAovlTjAKHZNl/3BWfmav2Tc88WZI6jjRnuOE4yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd/NZqPUom+QwQIuAsoZyDjY/SvpUvBaBJwGp4kvsfdUm2O5nWoWzkdoDMIpBwyRbQKs7G2aClTq1rYOpvXWOj4WSGHmfOuemRgG50UA4rn1EbHkeGR+3EaC84tbF4trwrg9k9rkZsUm2eaVp68xZkwr731x+wO/dPIvgjw2Krw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFJxGkxT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773304647; x=1804840647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiWtAovlTjAKHZNl/3BWfmav2Tc88WZI6jjRnuOE4yA=;
  b=dFJxGkxTRUVr8grMzpMicsTSOfqbqLw/IM7UU1bEEGXyZyXsqEPo98kv
   vD0hdjxhe9y7L69utjlf/L+/wi0qEkGMtrphJYN56APzipVCwGUlwBemE
   xUhfsw5QoMf1ItSU5UOaj4n03te99v8g18mcK3QQlZstHAFjcTpc9tSRl
   DD8BW+tEar5fAg3Sj4vm+20qILdy99bKZh2ND8Qa0OkxFHaPw771d4Fa2
   hP+ZkUDFfKEh+WBtVSq0F+7dI9RPsSDW6qbX82Ou+PUeNHw1yPYlfqG0W
   zuPYZ6M0AwREIois86FVCHKOX7/4l/ihhBZtA83tO3iN0gsL+zmht9Okb
   g==;
X-CSE-ConnectionGUID: QiPWpUyFS+C+c67YDLxxeQ==
X-CSE-MsgGUID: LN3BYnSGQ5CLmVnWJs34NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74280170"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74280170"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:37:27 -0700
X-CSE-ConnectionGUID: ZIjzzrBMTvySrc6Q30atrw==
X-CSE-MsgGUID: 3ZvPQL6nTtilzc9dAJ5bFg==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.245.57])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:37:24 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/i915/psr: Compute psr_entry_setup_frames into intel_crtc_state
Date: Thu, 12 Mar 2026 10:37:10 +0200
Message-ID: <20260312083710.1593781-3-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312083710.1593781-1-jouni.hogander@intel.com>
References: <20260312083710.1593781-1-jouni.hogander@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224821-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: DE02226F070
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Psr_entry_setup_frames is currently computed directly into struct
intel_dp:intel_psr:entry_setup_frames. This causes a problem if mode change
gets rejected after PSR compute config: Psr_entry_setup_frames computed for
this rejected state is in intel_dp:intel_psr:entry_setup_frame. Fix this by
computing it into intel_crtc_state and copy the value into
intel_dp:intel_psr:entry_setup_frames on PSR enable.

Fixes: 2b981d57e480 ("drm/i915/display: Support PSR entry VSC packet to be transmitted one frame earlier")
Cc: Mika Kahola <mika.kahola@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_types.h | 1 +
 drivers/gpu/drm/i915/display/intel_psr.c           | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index e189f8c39ccb..d3a9ace4c9d1 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1188,6 +1188,7 @@ struct intel_crtc_state {
 	u32 dc3co_exitline;
 	u16 su_y_granularity;
 	u8 active_non_psr_pipes;
+	u8 entry_setup_frames;
 	const char *no_psr_reason;
 
 	/*
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 7e0e4c3bf985..c13116e6f17f 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1716,7 +1716,7 @@ static bool _psr_compute_config(struct intel_dp *intel_dp,
 	entry_setup_frames = intel_psr_entry_setup_frames(intel_dp, conn_state, adjusted_mode);
 
 	if (entry_setup_frames >= 0) {
-		intel_dp->psr.entry_setup_frames = entry_setup_frames;
+		crtc_state->entry_setup_frames = entry_setup_frames;
 	} else {
 		crtc_state->no_psr_reason = "PSR setup timing not met";
 		drm_dbg_kms(display->drm,
@@ -1814,7 +1814,7 @@ static bool intel_psr_needs_wa_18037818876(struct intel_dp *intel_dp,
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 
-	return (DISPLAY_VER(display) == 20 && intel_dp->psr.entry_setup_frames > 0 &&
+	return (DISPLAY_VER(display) == 20 && crtc_state->entry_setup_frames > 0 &&
 		!crtc_state->has_sel_update);
 }
 
@@ -2190,6 +2190,7 @@ static void intel_psr_enable_locked(struct intel_dp *intel_dp,
 	intel_dp->psr.pkg_c_latency_used = crtc_state->pkg_c_latency_used;
 	intel_dp->psr.io_wake_lines = crtc_state->alpm_state.io_wake_lines;
 	intel_dp->psr.fast_wake_lines = crtc_state->alpm_state.fast_wake_lines;
+	intel_dp->psr.entry_setup_frames = crtc_state->entry_setup_frames;
 
 	if (!psr_interrupt_error_check(intel_dp))
 		return;
-- 
2.43.0


