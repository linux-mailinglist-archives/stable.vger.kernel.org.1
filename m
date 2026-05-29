Return-Path: <stable+bounces-256557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGTzDklSGWrzuQgAu9opvQ
	(envelope-from <stable+bounces-256557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:46:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A605FF679
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8770F30FFF58
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921AA3B774B;
	Fri, 29 May 2026 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlpmlQxu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8A3B7752
	for <stable@vger.kernel.org>; Fri, 29 May 2026 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044164; cv=none; b=ge6D74FwQQwcoU1Au/2nz+fll9WOjLhaRkgYfsSQWPnxz8O0/jE+t+cTK57Fj15xgSedDECh43Ajjm2jk/1Ijb8EJJy08mBIn1R3EEiw5Q+3gBuB15hadVY6GZ+2ZAlxuL0BHAy1/lwOQ1LbYkDjZu88NkROjFdLj4km2PCzWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044164; c=relaxed/simple;
	bh=nyrU+ZAyyVUCI5ajQCZ0DOvUmtjOq9bct/ibf5owqO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGun2CKswaEU1+8z5Q0tmTGtesl3PVZY7hStktmXpnQNrA+vhB1ZjXpC9VKlO/VCWkWZ7kfh9YOYsaoXrAH1sY69XAUUTEjKjAmaMN048EwcgpfsLBnYUEUuvvw0olc/59qVvSdS38vV2BgVtxK/A6wMkiBNWPgKrao+IDLfSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlpmlQxu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780044160; x=1811580160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nyrU+ZAyyVUCI5ajQCZ0DOvUmtjOq9bct/ibf5owqO0=;
  b=IlpmlQxuG50pFfCTRTqEu3UYr1GXRw9JAUNh7xd+x0xEq7emyFyJyQYe
   ntzEGfxmO6n3Rv3jJizyW7Hish2H05Ruiwp3B42h2JaQAR6hMoPJSj7Yp
   J8wInrBmmNyx/JnLNZwf82ZjZfXtKTO8hI4YaQK+34obeIT/j7L/6D+Lo
   zqM7e9FtY6kPegV9ZoNAlUNeZJqLjdO/ZfAvHdek/Q3GG5C8s0Vy6OJAr
   XzLEh+o+zn1ZwnZcepvKXNcvTDA0+mFpfVMb5cgGDanC8mbhh/xUi9IgL
   8TEAkHTM8lGfkJ8mTGAbJnq1NPRB9XE1vc76ALOj3UHTSj+wei+PHjTzv
   A==;
X-CSE-ConnectionGUID: W6WnNEx7SOewYv9BPw2HGw==
X-CSE-MsgGUID: MsJaLI62QW6odiBuku9h0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80922455"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80922455"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:42:39 -0700
X-CSE-ConnectionGUID: etMUzZ4wRc+2OSi9SD5m4g==
X-CSE-MsgGUID: 9Qv6HaOIQ4qontve6Eitow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="266418810"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.54])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:42:37 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.1.y 3/4] drm/i915/psr: Read Intel DPCD workaround register
Date: Fri, 29 May 2026 11:41:57 +0300
Message-ID: <20260529084158.459248-3-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529084158.459248-1-jouni.hogander@intel.com>
References: <2026052828-boaster-whenever-f598@gregkh>
 <20260529084158.459248-1-jouni.hogander@intel.com>
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
	TAGGED_FROM(0.00)[bounces-256557-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A1A605FF679
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit f30bece421a4ae34359254e1dc2a187a42b6af9b upstream.

Read Intel DPCD workaround register and store it into
intel_connector->dp.psr_caps. psr_caps was chosen as currently it contains
only PSR workaround for PSR2 SDP on prior scanline implementation.

Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260515095756.2799483-3-jouni.hogander@intel.com
(cherry picked from commit c48ff24d0f4ab7ad696b2d35ad64ce7e049c668c)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
---
 drivers/gpu/drm/i915/display/intel_display_types.h | 1 +
 drivers/gpu/drm/i915/display/intel_psr.c           | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index a8bf91a21cb2..a26c082bdc32 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1637,6 +1637,7 @@ struct intel_dp {
 	u8 lttpr_phy_caps[DP_MAX_LTTPR_COUNT][DP_LTTPR_PHY_CAP_SIZE];
 	u8 fec_capable;
 	u8 pcon_dsc_dpcd[DP_PCON_DSC_ENCODER_CAP_SIZE];
+	u8 intel_wa_dpcd;
 	/* source rates */
 	int num_source_rates;
 	const int *source_rates;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 505c3c4251a5..3e634873a097 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -31,6 +31,7 @@
 #include "intel_crtc.h"
 #include "intel_de.h"
 #include "intel_display_types.h"
+#include "intel_dpcd.h"
 #include "intel_dp_aux.h"
 #include "intel_hdmi.h"
 #include "intel_psr.h"
@@ -388,6 +389,12 @@ void intel_psr_init_dpcd(struct intel_dp *intel_dp)
 			intel_dp_get_su_granularity(intel_dp);
 		}
 	}
+
+	if (intel_dp->psr.sink_psr2_support)
+		drm_dp_dpcd_read(&intel_dp->aux,
+				 INTEL_DPCD_INTEL_WA_REGISTER_CAPS,
+				 &intel_dp->intel_wa_dpcd,
+				 sizeof(intel_dp->intel_wa_dpcd));
 }
 
 static void intel_psr_enable_sink(struct intel_dp *intel_dp)
-- 
2.43.0


