Return-Path: <stable+bounces-256543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDlbEPpIGWrHuAgAu9opvQ
	(envelope-from <stable+bounces-256543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:06:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2645FEF1E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8637830963CE
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CBE3B4404;
	Fri, 29 May 2026 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZyH14YN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A133B777D
	for <stable@vger.kernel.org>; Fri, 29 May 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041825; cv=none; b=WLOwRxaWIZo9Nu+8hvDDQ9Ozt8MWNfGLBLlvyZRLBvIey26U6rgV7RoOX1os6CLl3p5rb/Xo1VpvFKxpt/2OdCRpnZESkUghMUar7JoUp6wSoH48+aJ/ILqLD64YpQoGyRc0brn0hZFTFeIh9Sn30F/B6eAi0Pq2Fajfd3hI5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041825; c=relaxed/simple;
	bh=Z9yWBsOOW52Q2ZN+9vSa0vDBqo/Cjx1VJDMCEnP9O38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fATFa825KyXoGV6MPbJdiwtRKTQDDDpDutTqE/LaaSu06LPHvvTNUeejIh8eFmKnKB9vttK6xj7wB0M3k7VwtwpTm9+bTPsEqKubMKJHnexgz1/m0jAtotvKe3O0fqrca6SIk297Dw4hdD9qpvMHAO9jmcN/xAalE0uHyQ73hZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZyH14YN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041825; x=1811577825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z9yWBsOOW52Q2ZN+9vSa0vDBqo/Cjx1VJDMCEnP9O38=;
  b=JZyH14YNI2o8rE3N6eodKwgBgAybbGchBSqS6MU0v3iaJFITpGt6tb/v
   oZSZD/dFBPr+cm7M0VI7KPEvaKSnGEMSmI2ohCzATc5gLJUUYbTGajwcf
   AmCg96fPbVLUAqgXwvqme9CalddOKeBo7KjDqmywuPN1MeFKAJNfK715f
   2PztppQfnXSQU2oLvjEVfmYeu2XXxhDlgkG09PEx/FLNhetZzW/ogNcpw
   6eMXeu6NZ0rk+n9uGEjA0CfaeXSa9a+ZlSRlI/Vx6euQtOShxyRHlehIQ
   +reXRWdnOStsDPJHYU4mC1JHc/cwkjMaa3F59SAuJBkcYOKjgBe1bVzge
   A==;
X-CSE-ConnectionGUID: rWGUP178RWyYjGygclP16g==
X-CSE-MsgGUID: U05UYE/yRLaUDEOJTyGfRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81073763"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="81073763"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:03:44 -0700
X-CSE-ConnectionGUID: wdLTQ0A2Qz2BfRoqp/BD8Q==
X-CSE-MsgGUID: vx4KJ7ZAQBK1HLB4/J1U4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="247726786"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.54])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:03:43 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 5.15.y 4/4] drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used
Date: Fri, 29 May 2026 11:03:17 +0300
Message-ID: <20260529080317.343937-4-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529080317.343937-1-jouni.hogander@intel.com>
References: <2026052830-confirm-prepaid-2f4e@gregkh>
 <20260529080317.343937-1-jouni.hogander@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256543-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url,ursulin.net:email]
X-Rspamd-Queue-Id: 6A2645FEF1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 4703049f768fc1c1caac754134118bee1a3af189 upstream.

There is Intel specific workaround DPCD address containing workaround for
case where SDP is on prior line. Apply this workaround according to values
in the offset.

Fixes: 61e887329e33 ("drm/i915/xelpd: Handle PSR2 SDP indication in the prior scanline")
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260515095756.2799483-4-jouni.hogander@intel.com
(cherry picked from commit c3fe899fbeac86ea4a5ca9dd845b2cbc0da46249)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 27 +++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index aa00e062a2a6..fca55ae3ffe5 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -824,6 +824,30 @@ static bool psr2_granularity_check(struct intel_dp *intel_dp,
 	return true;
 }
 
+static bool apply_scanline_indication_wa(struct intel_dp *intel_dp,
+					 struct intel_crtc_state *crtc_state)
+{
+	u8 early_scanline_support = intel_dp->intel_wa_dpcd &
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
 static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_dp,
 							struct intel_crtc_state *crtc_state)
 {
@@ -844,7 +868,8 @@ static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_d
 		return false;
 
 	crtc_state->req_psr2_sdp_prior_scanline = true;
-	return true;
+
+	return apply_scanline_indication_wa(intel_dp, crtc_state);
 }
 
 static bool _compute_psr2_wake_times(struct intel_dp *intel_dp,
-- 
2.43.0


