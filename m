Return-Path: <stable+bounces-227051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBWhGKiaumnaZQIAu9opvQ
	(envelope-from <stable+bounces-227051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:29:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB522BB7B1
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E7A8300AC82
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799973590AE;
	Wed, 18 Mar 2026 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLr2wKOF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61A3D5254
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836963; cv=none; b=jvWeJjqH5uXuHexeaNeSNVqf+rXQG02QtnCdxcaSi2a/+wqsset6klTEyMx4zoZSWkV1QN0EB6aPwGS6zQ+yUV3Oa6JF1EIap+YyCxjh0LtiTWnWVcE1m0CNi1kSPoJuoFY93M9S0S4hnuKHvtY0m/xOvXTX5bO552goHEAp5EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836963; c=relaxed/simple;
	bh=E7QWmEC7edmxqKGqgdRmn4pXc6zL7zC6EsBxmK+4gXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXADKQWNHk3KSoWsm6gAeaHY+MPEzs8tNRMV7asCf4jmUKM0nliJ6JXpHw2b4E0a+Vqujj7blmdeNnW4/ls4ABOif8mZDlwYnwCexU4VrM2JaMTdQusm3GC1XNkL2GsDosYfo1YWWSbqL4bLwxfu4WT6xnWMy1sL7UH1LYDUJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLr2wKOF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773836962; x=1805372962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E7QWmEC7edmxqKGqgdRmn4pXc6zL7zC6EsBxmK+4gXY=;
  b=MLr2wKOFpCPQ8pAFWSqor+DxAMakO5zFuGjPG1JQJ17+yFDnskj/KGDJ
   EeLlEHdVIFlNT9zYq/7N5/w0ZjSHOO2IhjWq8CIxODUBfpHrp59aK1t9/
   Sf7A5I7AUsW/2IdiCzeVOG0cwqAtM334cu9MpgNxwThBHUWaLXhWNHYIA
   9sd696aDuP0Kb93B9XXJmza5TWVQfuMTsn+E1E0+mfBZDjvl4YlH9ltJR
   3G9nQ6qxw/TLGBXaGaInGNRwHi644/3Capr8L0MWK1b9d7J9CayF/3Ckf
   u6v2gwmotIzu3r7q9GktPE0uR09RMNbQ5pdzwN9ZH075rKj4E3Qa2+vFB
   Q==;
X-CSE-ConnectionGUID: rZMizTZuRX2SwDzu6JGdCg==
X-CSE-MsgGUID: ZdAso4F2TVaBSZ3JctEIjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86361868"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="86361868"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:29:22 -0700
X-CSE-ConnectionGUID: NHf5JtdwTrOqioDz8NH9gg==
X-CSE-MsgGUID: f9jnFFWaSvq9C7uu1hpQ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="218191962"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.245.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:29:19 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.12.y] drm/i915/psr: Repeat Selective Update area alignment
Date: Wed, 18 Mar 2026 14:29:05 +0200
Message-ID: <20260318122905.971323-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026031757-reflux-strongman-61ef@gregkh>
References: <2026031757-reflux-strongman-61ef@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227051-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ursulin.net:email,intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CB522BB7B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 1be2fca84f520105413d0d89ed04bb0ff742ab16 upstream.

Currently we are aligning Selective Update area to cover cursor fully if
needed only once. It may happen that cursor is in Selective Update area
after pipe alignment and after that covering cursor plane only
partially. Fix this by looping alignment as long as alignment isn't needed
anymore.

v2:
  - do not unecessarily loop if cursor was already fully covered
  - rename aligned as su_area_changed

Fixes: 1bff93b8bc27 ("drm/i915/psr: Extend SU area to cover cursor fully if needed")
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260304113011.626542-2-jouni.hogander@intel.com
(cherry picked from commit 681e12440d8b110350a5709101169f319e10ccbb)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
(cherry picked from commit 1be2fca84f520105413d0d89ed04bb0ff742ab16)
---
 drivers/gpu/drm/i915/display/intel_psr.c | 50 ++++++++++++++++++------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 34d61e44c6bd..f802dd8993a2 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2390,12 +2390,13 @@ static void clip_area_update(struct drm_rect *overlap_damage_area,
 		overlap_damage_area->y2 = damage_area->y2;
 }
 
-static void intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_state)
+static bool intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
 	struct drm_i915_private *dev_priv = to_i915(crtc_state->uapi.crtc->dev);
 	const struct drm_dsc_config *vdsc_cfg = &crtc_state->dsc.config;
 	u16 y_alignment;
+	bool su_area_changed = false;
 
 	/* ADLP aligns the SU region to vdsc slice height in case dsc is enabled */
 	if (crtc_state->dsc.compression_enable &&
@@ -2404,10 +2405,18 @@ static void intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_st
 	else
 		y_alignment = crtc_state->su_y_granularity;
 
-	crtc_state->psr2_su_area.y1 -= crtc_state->psr2_su_area.y1 % y_alignment;
-	if (crtc_state->psr2_su_area.y2 % y_alignment)
+	if (crtc_state->psr2_su_area.y1 % y_alignment) {
+		crtc_state->psr2_su_area.y1 -= crtc_state->psr2_su_area.y1 % y_alignment;
+		su_area_changed = true;
+	}
+
+	if (crtc_state->psr2_su_area.y2 % y_alignment) {
 		crtc_state->psr2_su_area.y2 = ((crtc_state->psr2_su_area.y2 /
 						y_alignment) + 1) * y_alignment;
+		su_area_changed = true;
+	}
+
+	return su_area_changed;
 }
 
 /*
@@ -2492,7 +2501,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	struct intel_crtc_state *crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
 	struct intel_plane_state *new_plane_state, *old_plane_state;
 	struct intel_plane *plane;
-	bool full_update = false, cursor_in_su_area = false;
+	bool full_update = false, su_area_changed;
 	int i, ret;
 
 	if (!crtc_state->enable_psr2_sel_fetch)
@@ -2604,15 +2613,32 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	if (ret)
 		return ret;
 
-	/*
-	 * Adjust su area to cover cursor fully as necessary (early
-	 * transport). This needs to be done after
-	 * drm_atomic_add_affected_planes to ensure visible cursor is added into
-	 * affected planes even when cursor is not updated by itself.
-	 */
-	intel_psr2_sel_fetch_et_alignment(state, crtc, &cursor_in_su_area);
+	do {
+		bool cursor_in_su_area;
 
-	intel_psr2_sel_fetch_pipe_alignment(crtc_state);
+		/*
+		 * Adjust su area to cover cursor fully as necessary
+		 * (early transport). This needs to be done after
+		 * drm_atomic_add_affected_planes to ensure visible
+		 * cursor is added into affected planes even when
+		 * cursor is not updated by itself.
+		 */
+		intel_psr2_sel_fetch_et_alignment(state, crtc, &cursor_in_su_area);
+
+		su_area_changed = intel_psr2_sel_fetch_pipe_alignment(crtc_state);
+
+		/*
+		 * If the cursor was outside the SU area before
+		 * alignment, the alignment step (which only expands
+		 * SU) may pull the cursor partially inside, so we
+		 * must run ET alignment again to fully cover it. But
+		 * if the cursor was already fully inside before
+		 * alignment, expanding the SU area won't change that,
+		 * so no further work is needed.
+		 */
+		if (cursor_in_su_area)
+			break;
+	} while (su_area_changed);
 
 	/*
 	 * Now that we have the pipe damaged area check if it intersect with
-- 
2.43.0


