Return-Path: <stable+bounces-222841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePCvKNmvpmn9SgAAu9opvQ
	(envelope-from <stable+bounces-222841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:54:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72B1EC230
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABFCC30234D1
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEA738F64E;
	Tue,  3 Mar 2026 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gc/KWk3E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1638BF76
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772531661; cv=none; b=lyfLegoAkaHyZVBy4c5qEIl2XUZWIwjVD/F4/syTmquox7SQDgwutN8s4uQh9YiaCvs3sq8DExfzAor0vPadlk7CrmVC7waBk02aivFY2GUNwno3USDinrlQLjI8DvBkO3aiTXXBXztduJykAMuqxG/j2FtOTPZjJvgNi5RwU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772531661; c=relaxed/simple;
	bh=Wtq1RpF9IxcaDanOBKbk3dW3S8LStHlLmhGW+Gw8zQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QAC9R3W3NTVSJoNghysiPiEJJhUfK8z5aC5ML27ai5BTqqjcHmnASeT751vMRYEbLe3RxrAxIeQL2KYxwCpgBL6S5arbP1IA4oxA40AllGAKvtEakgz3a8LDhMQmdraQ6ESMK+Kq2uEjOqnRx3ZZ2ExMNaUgACo+o4NqtcvrPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gc/KWk3E; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772531660; x=1804067660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wtq1RpF9IxcaDanOBKbk3dW3S8LStHlLmhGW+Gw8zQ8=;
  b=gc/KWk3E9YlK/VVS8GKHr92z9rvyqDF60WXBdsuyjWtH6UMzfyV7KTYF
   7+pUfR+VMtwGhgni6v5u0ShAtX2FolMf6mvQzVpF/huZzCsQeHepZ+khn
   AFjQpxwv5dSyMLDJOhJL4/ssUUyGp2sGSIlz1oMbm1REAp3Bl8LLYSFVw
   4OkEXLzBaOMtaKq9rk/3Z87n0qCc6JrCyMdTmga6TyYv7vG3HwegfuNVy
   qlocqrjHecinooUXfscuzWUAo34oO2a+K1jOGYCyMg70D9wMxRN9KFGqW
   Lp6iK4MpUtrpc/fKby7KzESTS3+HJpc/1ee1g8XRZIl7aL2vFqCLDWPGy
   A==;
X-CSE-ConnectionGUID: zF/Ig7RfToWAnSjzKPomYA==
X-CSE-MsgGUID: RB9FGGYkQneGZyLXXR6VeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73626288"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73626288"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 01:54:19 -0800
X-CSE-ConnectionGUID: qVn+92IYRsul4D0KZOkMMQ==
X-CSE-MsgGUID: FNrpiF5tSd2d1M+yeoGfsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="255833917"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.23])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 01:54:17 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH] drm/i915/vrr: Configure VRR timings after enabling TRANS_DDI_FUNC_CTL
Date: Tue,  3 Mar 2026 11:54:14 +0200
Message-ID: <20260303095414.4331-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C72B1EC230
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222841-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid,intel.com:dkim,intel.com:email,gitlab.freedesktop.org:url]
X-Rspamd-Action: no action

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Apparently ICL may hang with an MCE if we write TRANS_VRR_VMAX/FLIPLINE
before enabling TRANS_DDI_FUNC_CTL.

Personally I was only able to reproduce a hang (on an Dell XPS 7390
2-in-1) with an external display connected via a dock using a dodgy
type-C cable that made the link training fail. After the failed
link training the machine would hang. TGL seemed immune to the
problem for whatever reason.

BSpec does tell us to configure VRR after enabling TRANS_DDI_FUNC_CTL
as well. The DMC firmware also does the VRR restore in two stages:
- first stage seems to be unconditional and includes TRANS_VRR_CTL
  and a few other VRR registers, among other things
- second stage is conditional on the DDI being enabled,
  and includes TRANS_DDI_FUNC_CTL and TRANS_VRR_VMAX/VMIN/FLIPLINE,
  among other things

So let's reorder the steps to match to avoid the hang, and
toss in an extra WARN to make sure we don't screw this up later.

BSpec: 22243
Cc: stable@vger.kernel.org
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reported-by: Benjamin Tissoires <bentiss@kernel.org>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15777
Tested-by: Benjamin Tissoires <bentiss@kernel.org>
Fixes: dda7dcd9da73 ("drm/i915/vrr: Use fixed timings for platforms that support VRR")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c |  1 -
 drivers/gpu/drm/i915/display/intel_vrr.c     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 27354585ba92..138ee7dd1977 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1637,7 +1637,6 @@ static void hsw_configure_cpu_transcoder(const struct intel_crtc_state *crtc_sta
 	}
 
 	intel_set_transcoder_timings(crtc_state);
-	intel_vrr_set_transcoder_timings(crtc_state);
 
 	if (cpu_transcoder != TRANSCODER_EDP)
 		intel_de_write(display, TRANS_MULT(display, cpu_transcoder),
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 00ca76dbdd6c..8a957804cb97 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -599,6 +599,18 @@ void intel_vrr_set_transcoder_timings(const struct intel_crtc_state *crtc_state)
 	if (!HAS_VRR(display))
 		return;
 
+	/*
+	 * Bspec says:
+	 * "(note: VRR needs to be programmed after
+	 *  TRANS_DDI_FUNC_CTL and before TRANS_CONF)."
+	 *
+	 * In practice it turns out that ICL can hang if
+	 * TRANS_VRR_VMAX/FLIPLINE are written before
+	 * enabling TRANS_DDI_FUNC_CTL.
+	 */
+	drm_WARN_ON(display->drm,
+		    !(intel_de_read(display, TRANS_DDI_FUNC_CTL(display, cpu_transcoder)) & TRANS_DDI_FUNC_ENABLE));
+
 	/*
 	 * This bit seems to have two meanings depending on the platform:
 	 * TGL: generate VRR "safe window" for DSB vblank waits
@@ -961,6 +973,8 @@ void intel_vrr_transcoder_enable(const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
 
+	intel_vrr_set_transcoder_timings(crtc_state);
+
 	if (!intel_vrr_possible(crtc_state))
 		return;
 
-- 
2.52.0


