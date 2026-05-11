Return-Path: <stable+bounces-245183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF7xMTnKAWoRjwEAu9opvQ
	(envelope-from <stable+bounces-245183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:23:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A6F50D962
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4252F3024288
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A9376BD7;
	Mon, 11 May 2026 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mS21uxbu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D1374722
	for <stable@vger.kernel.org>; Mon, 11 May 2026 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501786; cv=none; b=uCXAmElCssDSR6eoK/w5IOcsdWemT08KQzi9DsIE0tcI4IyxeShhB7FvnAESdvmb9/mkacaD4o8xmNaL4/+KddruyjlFyUH+9BR90AgcatapsM4j639izp0DIDfA7kZosojpa2O7lTugv3AgAaoXDF7x7nZ8ewD58FOoJfAowIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501786; c=relaxed/simple;
	bh=381zPiy+ozUJfTW656U74+nwPlV0OaMzq+UVvOW/nBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HW9uJF2qy2ya3ArQD7j0bUNPCv0xwDqdvv5GBd38xEQH7S8vC8Td7kYlutTJz31ecAs+p0snOwDlXSiwJrkdBLNPN9eKZ8XiMjX3MFRoZxm4Z8TtHIWlXLUct0l4aHcRQy34liTmF74pEuv1JBBCe4oYNeHLfoLaOJB/0QrwaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mS21uxbu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778501785; x=1810037785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=381zPiy+ozUJfTW656U74+nwPlV0OaMzq+UVvOW/nBs=;
  b=mS21uxbuT9mO/8kn0uvJwN/bpEtgQJVfRuLIYgYrHTsfcr+NtBFwAwop
   HA1f0nRaFTc6XtnJvxBVcZEMjkRWd8JXanijKSBIPR7JDOAkRQVEPNz8T
   PCfjgTFcYKhDaL7W2BS48me9vIVSujRyLj/1w3tj+UJ+6akfQjabAsLQC
   7znmhWhoW+9yCy5aKDqW4MOXGVdZgxZsx/gjn5WHeZTc7BGGx5ySuVykM
   5H3jBX1lIOFnZMQoWpu9KERjkbMtR/2BJ9FfUpqfLIW2TnoZdUFqDmmrm
   Pgy2zx91m/JgU1Qr/WFavEdVbr50m2HdWnQ/uyy/IOye4/nghtc+eqHV6
   g==;
X-CSE-ConnectionGUID: vjp2v/awSIK5WJokdde4uQ==
X-CSE-MsgGUID: t71mHKkMSgOFeoiigYnY0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79333221"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79333221"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 05:16:25 -0700
X-CSE-ConnectionGUID: UDXPR6TaSNS/Rw/kjamhQw==
X-CSE-MsgGUID: mrJgdtEfTp2UieP4V8Memg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="242405006"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 05:16:22 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/i915/psr: Use DC_OFF wake reference to block DC6 on vblank enable
Date: Mon, 11 May 2026 15:15:51 +0300
Message-ID: <20260511121551.2373824-2-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511121551.2373824-1-jouni.hogander@intel.com>
References: <20260511121551.2373824-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 49A6F50D962
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245183-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

We are observing following warnings:

*ERROR* power well DC_off state mismatch (refcount 0/enabled 1)

gen9_dc_off_power_well_enabled is concidering target state DC_STATE_DISABLE
as DC_OFF power well being enabled. Fix this by using wakeref for the
purpose.

Fixes: aa451abcffb5 ("drm/i915/display: Prevent DC6 while vblank is enabled for Panel Replay")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 .../drm/i915/display/intel_display_types.h    |  2 ++
 drivers/gpu/drm/i915/display/intel_psr.c      | 24 +++++++------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 26e59110e743..e2861476b215 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1789,6 +1789,8 @@ struct intel_psr {
 	u8 active_non_psr_pipes;
 
 	const char *no_psr_reason;
+
+	struct ref_tracker *vblank_wakeref;
 };
 
 struct intel_dp {
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 657b1614cd65..a8f02f928bd8 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -4141,14 +4141,20 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
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
@@ -4156,18 +4162,6 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
 
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


