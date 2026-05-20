Return-Path: <stable+bounces-249807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEWtMdyRDWpyzgUAu9opvQ
	(envelope-from <stable+bounces-249807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:50:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6488458BF2F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF48D3006452
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66B93D1CB0;
	Wed, 20 May 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJ4+JzWZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA42690D5
	for <stable@vger.kernel.org>; Wed, 20 May 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274202; cv=none; b=kmIxld/Ffu1OWBQix4Zh6XDjN67qY+uijw/vsqb4/qmztxGvgB3KeslbU360eTkNY6uQFShbPYNoTTKE1pH8OcIkJQgirZzbwmuPQMFwL6Y3Hk4th+jZTwRY5ZPf7IlBAXp75ovzX96z2AgI+J1iLkQLwDhkgjtWD/7WYcAC634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274202; c=relaxed/simple;
	bh=5vZ3OqcwnWZ0kd4MNTjhgTqGUB9tPftXckCRzIfYkdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HTNn8rglnAey83dnOdAQsqsG32qWcFLZKQpq8GqlGYMwDT4zz1ANRgrV32fk2EayUBkgtxQPwJsZ31Fz6z1d3uYTAxE+hAiL+zOISVwnQasOAFhysNbIAoW4fJPJxMctaK6dh8GAjdDyfIxJJ9hBkD4DFDgZbljN53J9/+hZg9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJ4+JzWZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779274202; x=1810810202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5vZ3OqcwnWZ0kd4MNTjhgTqGUB9tPftXckCRzIfYkdI=;
  b=AJ4+JzWZUYvXLXrwNH8kLQrrW3L50/BC6INT1VohD6fykR2iLm5Xir00
   Sy64j9luYxAxAVdNIh1XKe8G3IY2J1jHZ/hGhryxL4cahOstQjUDjdAWM
   xFBrGHrk8lASiepqJK8V4zPzUpH9FTVMWiddfRF6pXx75QKGqnZCMpinT
   WUmlsGbxcC26cYpUIxXX3N0H24txYDFmflmOitmTVYTJfkUpTIUj5v7E1
   xSAI25sLyHNGAKuauClvI9waORrsOHE7pEkPAgJ3Q94zgPiBRlqeYZPjT
   g1ZmTkLgzyEF+xmChrf4piTEj6MKF0iQ7ZkreiCofjGDHzrS5kOaMqk23
   A==;
X-CSE-ConnectionGUID: DbLTGKcGSPCoDAjRFBTK+Q==
X-CSE-MsgGUID: CIEAuOHwSCax0QLd1GZ7jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84023486"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="84023486"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 03:50:01 -0700
X-CSE-ConnectionGUID: jIYS//fMTBKL3m3/CdlrNQ==
X-CSE-MsgGUID: C3CobzTXTm6BbFtDM4hsEQ==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.114])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 03:49:59 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.co>
Subject: [PATCH v2 1/2] drm/i915/psr: Block DC states on vblank enable when Panel Replay supported
Date: Wed, 20 May 2026 13:49:43 +0300
Message-ID: <20260520104944.239797-1-jouni.hogander@intel.com>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249807-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,intel.co:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6488458BF2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently we are blocking DC states only when Panel Replay is enabled on
vblank enable. It may happen that Panel Replay is getting enabled when
vblank is already enabled. Fix this by blocking DC states always if Panel
Replay is supported.

While at it take care of possible dual eDP case by looping all encoders
supporting PSR.

Fixes: 0c427ac78a1d ("drm/i915/psr: Add interface to notify PSR of vblank enable/disable")
Cc: <stable@vger.kernel.org> # v6.16+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Michał Grzelak <michal.grzelak@intel.co>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index b0414bd1dc6b..70108e0a4c0c 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -4180,32 +4180,33 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
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


