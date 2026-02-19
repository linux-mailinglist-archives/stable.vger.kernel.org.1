Return-Path: <stable+bounces-217438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOCqIqULl2kcuAIAu9opvQ
	(envelope-from <stable+bounces-217438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 14:09:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E9915EED9
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 14:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36DFC301F32A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82022261B9C;
	Thu, 19 Feb 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5juXETj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1201CD2C
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506490; cv=none; b=kVXGCLsCk7n3I6UnSj9f8ljVUXLBinVek1Vsd6P/taK+VLB8vMh0p3mUDEa6hfigHOTEazveOR4kg7XpC1N3XoaWXZpdVp9sxVM/uCesm4a35mXjVSsT/F/j8isp2jPpLVMbnm3SmUC8MKlXpir0RSPQ8PgoAjUxxFY0q5CChYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506490; c=relaxed/simple;
	bh=27RuguUc24Foz/Z0yMb63i9Bn80pnNrEE9wi9biXXOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XR3ia94euo8Qn3vTfKua7oeCFmfH3p02IBRSsWIutE3EXmabGdn1hFX7wvC6mJXm4lL5QjFWwGMqAzmcQIXCvspg3ZlsccVL2AOwoThvy96Yqtf75vMjETc1c/yBP7lb3N+rh2cGEeuT7QtRtg08a5X1QcIENauAc0A2arIB2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5juXETj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771506489; x=1803042489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=27RuguUc24Foz/Z0yMb63i9Bn80pnNrEE9wi9biXXOM=;
  b=W5juXETjVVo1hLyXJxk9G0oSP7u3Fu1BkrKqhAESl1Q/slhV76Y/P2Uf
   vRyLfA6ZelJIz303+2FC2w66DONb1E/ubb4/HGdYIukJJgdIgs28xu18w
   jUKKh6P7whvNH1TGv/0YVYezrmhnRSY3bPl4iYGA45tC2eiHFx74uk4CW
   0N1cpmu6QVCrc9QqNTqgI4SYX+wY4VBAhQG3tGvoMYPQcRh45fPmCpQoT
   +Bk3YHT1Ox7PeTQ3R9WydkLe4jbNA6tqe4isCc/QEwDQHjAx5l+KzRyiE
   58vsrMmWsE8oZjSS/lKwCdilweVJEIY2OSssv+2lTIAlHBmzKu9w/rz7E
   w==;
X-CSE-ConnectionGUID: xRhfwW2ERX6TB0MJLbYV/w==
X-CSE-MsgGUID: g6P9xicPQAixx2KOQwNQIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72475530"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72475530"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 05:08:09 -0800
X-CSE-ConnectionGUID: xUdHBKghRzOuz/qi5X3xXg==
X-CSE-MsgGUID: 9xbGTC8vTSyhC9HNgbqMIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="212458604"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.120])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 05:08:07 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] drm/i915/psr: DSC configuration for Early Transport
Date: Thu, 19 Feb 2026 15:07:42 +0200
Message-ID: <20260219130743.1232188-5-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219130743.1232188-1-jouni.hogander@intel.com>
References: <20260219130743.1232188-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217438-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9E9915EED9
X-Rspamd-Action: no action

There is Selective Update slice row per frame and picture height
configurations needed on DSC when using Selective Update Early
Transport. Calculate and configure these when using Early Transport.

Bspec: 68927
Fixes: 467e4e061c44 ("drm/i915/psr: Enable psr2 early transport as possible")
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_psr.c      | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index e8e4af03a6a6..8903804c04b1 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1381,6 +1381,7 @@ struct intel_crtc_state {
 	u32 psr2_man_track_ctl;
 
 	u32 pipe_srcsz_early_tpt;
+	u32 dsc_su_parameter_set_0_calc;
 
 	struct drm_rect psr2_su_area;
 
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 331645a2c9f6..0a2948ec308d 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2618,6 +2618,11 @@ void intel_psr2_program_trans_man_trk_ctl(struct intel_dsb *dsb,
 
 	intel_de_write_dsb(display, dsb, PIPE_SRCSZ_ERLY_TPT(crtc->pipe),
 			   crtc_state->pipe_srcsz_early_tpt);
+	intel_de_write_dsb(display, dsb, DSC_SU_PARAMETER_SET_0_DSC0(crtc->pipe),
+			   crtc_state->dsc_su_parameter_set_0_calc);
+	if (intel_dsc_get_vdsc_per_pipe(crtc_state) > 1)
+		intel_de_write_dsb(display, dsb, DSC_SU_PARAMETER_SET_0_DSC1(crtc->pipe),
+				   crtc_state->dsc_su_parameter_set_0_calc);
 }
 
 static void psr2_man_trk_ctl_calc(struct intel_crtc_state *crtc_state,
@@ -2668,6 +2673,23 @@ static u32 psr2_pipe_srcsz_early_tpt_calc(struct intel_crtc_state *crtc_state,
 	return PIPESRC_WIDTH(width - 1) | PIPESRC_HEIGHT(height - 1);
 }
 
+static u32 psr2_dsc_su_parameter_set_0_calc(struct intel_crtc_state *crtc_state,
+					    bool full_update)
+{
+	const struct drm_dsc_config *vdsc_cfg = &crtc_state->dsc.config;
+	int slice_row_per_frame, pic_height;
+
+	if (!crtc_state->enable_psr2_su_region_et || full_update ||
+	    !crtc_state->dsc.compression_enable)
+		return 0;
+
+	slice_row_per_frame = drm_rect_height(&crtc_state->psr2_su_area) / vdsc_cfg->slice_height;
+	pic_height = slice_row_per_frame * vdsc_cfg->slice_height;
+
+	return DSC_SU_PARAMETER_SET_0_SU_SLICE_ROW_PER_FRAME(slice_row_per_frame) |
+		DSC_SU_PARAMETER_SET_0_SU_PIC_HEIGHT(pic_height);
+}
+
 static void clip_area_update(struct drm_rect *overlap_damage_area,
 			     struct drm_rect *damage_area,
 			     struct drm_rect *pipe_src)
@@ -3026,6 +3048,8 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	psr2_man_trk_ctl_calc(crtc_state, full_update);
 	crtc_state->pipe_srcsz_early_tpt =
 		psr2_pipe_srcsz_early_tpt_calc(crtc_state, full_update);
+	crtc_state->dsc_su_parameter_set_0_calc = psr2_dsc_su_parameter_set_0_calc(crtc_state,
+										   full_update);
 	return 0;
 }
 
-- 
2.43.0


