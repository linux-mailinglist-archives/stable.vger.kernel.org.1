Return-Path: <stable+bounces-223035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKtFE9sXqGmgnwAAu9opvQ
	(envelope-from <stable+bounces-223035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:30:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79F1FEFF8
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1ED8130074D4
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC563CB;
	Wed,  4 Mar 2026 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R358NFYu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9C25F994
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623829; cv=none; b=I6zf49NgRW7Uuo7laynww/sbfF0DsgpyGBxA8RI4HSRD55HcgSHvc9vY5Erxhh04RTmEueBrXd0B9JEVZOw1RpwwKy5BvlN9l54CTMyJ3IWCOd/f3kzwozlJEEw6s9grsM3fARBTlNo5aYv8iPfiSCENmh94NKTOYAjn4RRiL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623829; c=relaxed/simple;
	bh=VyEFWTQb4qhEJbfhtgA0EcgAW0Bgk6i+K7CQ5W5tVEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2ag+hXeiqUJOi/vm20ZQrA2aHrMl31yQ8gqherNtQmrUqB1B1AtcleQHlkJL97Wn3GOjd9IRdekvq6LDPZBG5J434JVkQVw92jFllT+6lKZHRnrUCs22xO/9zgtW1M5JIKFsFtnr6CjLc9aDEIzJ/JBdUmXEYL2fVFnqtLCufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R358NFYu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772623828; x=1804159828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyEFWTQb4qhEJbfhtgA0EcgAW0Bgk6i+K7CQ5W5tVEA=;
  b=R358NFYuNlELytQ6H00/N4GYM9ASbZrIRzk7amqQ2kk5SpWAtP4X28gG
   kXbKutoHvnheoNBFoKzGlAottsJaQGf5Q2q2yyU0CJlS8rbzgUhZRG49i
   /q+skjW2LKcTCc/Qza5Gjl3e2W7HHK5Hfo0j2I1j1O7X6sBIbsYzF96BH
   S93TprrXyZrA+MmKKuiMKYBhKCo6i29Q21CcVLIiei/VfoFdO7LP/H65d
   skDigZVFp3xa0+ObBXTqHZZ4gEjdK0B7lqK0M8xQ2Ff0FvTQEvNWPjW+V
   0oXvG6hb9SpFVb7zs+2VGzMmQki/rOyo2gzl1jPK1fk8SQHzFTnefPyMX
   w==;
X-CSE-ConnectionGUID: 9HO/M+7TTHi9Yc3h68wG6A==
X-CSE-MsgGUID: 9E9gYlKURTKKXUyvzXDfpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="91255316"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="91255316"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 03:30:27 -0800
X-CSE-ConnectionGUID: nAivn7gJS8it9ezHcM+yAw==
X-CSE-MsgGUID: eGlsbLdAR6mtr6LY/50R7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="248789998"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.245.129])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 03:30:26 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH v3 1/4] drm/i915/psr: Repeat Selective Update area alignment
Date: Wed,  4 Mar 2026 13:30:08 +0200
Message-ID: <20260304113011.626542-2-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304113011.626542-1-jouni.hogander@intel.com>
References: <20260304113011.626542-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A79F1FEFF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223035-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

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
---
 drivers/gpu/drm/i915/display/intel_psr.c | 50 ++++++++++++++++++------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 5bea2eda744b..7b197e84e77d 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2688,11 +2688,12 @@ static void clip_area_update(struct drm_rect *overlap_damage_area,
 		overlap_damage_area->y2 = damage_area->y2;
 }
 
-static void intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_state)
+static bool intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
 	const struct drm_dsc_config *vdsc_cfg = &crtc_state->dsc.config;
 	u16 y_alignment;
+	bool su_area_changed = false;
 
 	/* ADLP aligns the SU region to vdsc slice height in case dsc is enabled */
 	if (crtc_state->dsc.compression_enable &&
@@ -2701,10 +2702,18 @@ static void intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_st
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
@@ -2838,7 +2847,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	struct intel_crtc_state *crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
 	struct intel_plane_state *new_plane_state, *old_plane_state;
 	struct intel_plane *plane;
-	bool full_update = false, cursor_in_su_area = false;
+	bool full_update = false, su_area_changed;
 	int i, ret;
 
 	if (!crtc_state->enable_psr2_sel_fetch)
@@ -2945,15 +2954,32 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
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


