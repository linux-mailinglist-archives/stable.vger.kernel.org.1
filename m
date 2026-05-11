Return-Path: <stable+bounces-245182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH0PBEDKAWoRjwEAu9opvQ
	(envelope-from <stable+bounces-245182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:23:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAE350D969
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77E6930DB5CE
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4797376BD7;
	Mon, 11 May 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4zee22n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B08378839
	for <stable@vger.kernel.org>; Mon, 11 May 2026 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501776; cv=none; b=iC/GDbaZL9/qDTzDUwDzojo0l0aytlnoqyL513wAIEv15ljjXpHyFOuEW+MXlaIzAgtPQjvNamusfpCA39zf9WOg11k2C032W5tW7bm7OBKvBXKDtMTihZd0KbSWPydIHmhCjzBbWOb0QaavMaUc546h71lGpJg9VrKQZ5Y2X0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501776; c=relaxed/simple;
	bh=8HPEzE7WWxeIPpkvv9ZTlyBTcyaTA8Jyi/x39v8AChM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rOIqtaJH2fMmc12J/G/nzKWLc6AscgF9GjyMoNmYxk86uiFSA6f5TZExLYc0Ee91KBGnFdWip9ihXk0Vpo6Q9msvBIfXAjmH7JmUEbiS8q34pPMR5hweSbjJUY0gdNL11d0tpOODNEkBM6Nch/MJ63G0VXguSlOVjP3Q0hWS2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4zee22n; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778501773; x=1810037773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8HPEzE7WWxeIPpkvv9ZTlyBTcyaTA8Jyi/x39v8AChM=;
  b=X4zee22na01Ef3XJmYk2x8TL+kSYr10q+L7CQADXymyurkVzgb2Jr0/o
   4zgfktVMiG6Q0pcpJ29xLbL+JClXucuTkEZRQizQtqIeIJi4Sk9rZk5i8
   HuiK2B8tLTk3f9eg/SDZiBG4nLF/BSlNWuza6A6abJWfULpAelynPzRml
   IstpvvHRg30yKExZ26VB7QpPdktjMzfSvRqaLdRgDGUZ+RaB2TUsMJpSD
   CFhx6HKBIRhEMmWPfeBNGnHE05T96de7rSqkiLzFlq8Qr2D2fS9kOBc/f
   nBQjrG6JovoWnLYRiBh4QjzRA+couC3vruSegd6bMoL7rh15sEOXuSS73
   g==;
X-CSE-ConnectionGUID: F+FcDBVPQRu6vP8Qvo7LDA==
X-CSE-MsgGUID: WG3tDp2iQIKYT17HzPEsew==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79333212"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79333212"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 05:16:12 -0700
X-CSE-ConnectionGUID: 044v73eCQv2ww6iYgVQ16w==
X-CSE-MsgGUID: aUXl3/R+QBGdfEIPAa0UUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="242404924"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 05:16:10 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/i915/psr: Block DC states on vblank enable when Panel Replay supported
Date: Mon, 11 May 2026 15:15:50 +0300
Message-ID: <20260511121551.2373824-1-jouni.hogander@intel.com>
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
X-Rspamd-Queue-Id: 6EAE350D969
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
	TAGGED_FROM(0.00)[bounces-245182-lists,stable=lfdr.de];
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

Currently we are blocking DC states only when Panel Replay is enabled on
vblank enable. It may happen that Panel Replay is getting enabled when
vblank is already enabled. Fix this by blocking DC states always if Panel
Replay is supported.

While at it take care of possible dual eDP case by looping all encoders
supporting PSR.

Fixes: 0c427ac78a1d ("drm/i915/psr: Add interface to notify PSR of vblank enable/disable")
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 9958230a3dd9..657b1614cd65 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -4141,32 +4141,33 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
 					    bool enable)
 {
 	struct intel_encoder *encoder;
+	bool block_dc_states = false;
 
 	for_each_intel_encoder_with_psr(display->drm, encoder) {
 		struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 
 		mutex_lock(&intel_dp->psr.lock);
-		if (intel_dp->psr.panel_replay_enabled) {
-			mutex_unlock(&intel_dp->psr.lock);
-			break;
-		}
+		if (CAN_PANEL_REPLAY(intel_dp))
+			block_dc_states = true;
 
-		if (intel_dp->psr.enabled && intel_dp->psr.pkg_c_latency_used)
+		if (intel_dp->psr.enabled && !intel_dp->psr.panel_replay_enabled &&
+		    intel_dp->psr.pkg_c_latency_used)
 			intel_psr_apply_underrun_on_idle_wa_locked(intel_dp);
 
 		mutex_unlock(&intel_dp->psr.lock);
-		return;
 	}
 
 	/*
 	 * NOTE: intel_display_power_set_target_dc_state is used
-	 * only by PSR * code for DC3CO handling. DC3CO target
+	 * only by PSR code for DC3CO handling. DC3CO target
 	 * state is currently disabled in * PSR code. If DC3CO
 	 * is taken into use we need take that into account here
 	 * as well.
 	 */
-	intel_display_power_set_target_dc_state(display, enable ? DC_STATE_DISABLE :
-						DC_STATE_EN_UPTO_DC6);
+	if (block_dc_states)
+		intel_display_power_set_target_dc_state(display, enable ?
+							DC_STATE_DISABLE :
+							DC_STATE_EN_UPTO_DC6);
 }
 
 static void
-- 
2.43.0


