Return-Path: <stable+bounces-252601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDOJOUn8DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:24:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64268596062
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C03D1302FA2B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876EA3F789B;
	Wed, 20 May 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jxa5s+gB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87133CCFB0;
	Wed, 20 May 2026 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301103; cv=none; b=E9uXA83krslTE96S1QKDKTg0mriKHKfxjNOHjaDmXK5cahS9JRl8p4qRSiGSxpXtjxn0fAQqW2gsrvPfQFp6/ar0ykTtkkUJmiGvK/qknfpGRdr+HL6yeXzTc3wmq5lhSEc0w2zGitOJqrdA+l5ISoBWOCp4pMQ/vVSSG9H0gSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301103; c=relaxed/simple;
	bh=otC08+ysUGtTqI0LEZe8meF7PkHja98zJnypilCqbgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hw1ql7WCdbsDNK5HQxQCUa5gqC1S7hg9h6YQu/31EZ2kSudfmF5j1/vCD4L5nzjsrT/egXX0BpcWNX6iK2SrpY7sDIaM4JnA/+uI09xa8dzo+V8+AXF4TlOGlg7o75CM+9VzaU/gwLLXVTTyLpAAzq82oyIXOtsB2QcTn9s9t5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jxa5s+gB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC791F000E9;
	Wed, 20 May 2026 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301101;
	bh=9PjLR92C6xiI394Q+99Eytslg24ujwxa7qh+hmNwl5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jxa5s+gBOAICrdNjuoFnj5XyVKQJhLOdRwglmGaTnao1VxDukml0ay60z5EUxPI6S
	 ESQnPNrzJwFWldK8PKwW8QCLFTAY0WHBcRbaAaqVMqU1gC3F3Ia2FtjsvBI/3Ug8bq
	 nAsW8B7y2K8BpYH+Ys5Vdl26WmrRlqdLoZgnD09c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 425/666] drm/i915: Relocate the SKL wm sanitation code
Date: Wed, 20 May 2026 18:20:36 +0200
Message-ID: <20260520162120.481492150@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252601-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 64268596062
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit e31e8681d29c5c35aa070ca6323c6b95ecf0db99 ]

In order to add more MBUS sanitation into the code we'll want
to reuse a bunch of the code that performs the MBUS/related
hardware programming. Currently that code comes after the
main skl_wm_get_hw_state_and_sanitize() entrypoint. In order
to avoid annoying forward declarations relocate the
skl_wm_get_hw_state_and_sanitize() and related stuff nearer to
the end of the file.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241031155646.15165-2-ville.syrjala@linux.intel.com
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Stable-dep-of: a97c88a176b6 ("drm/i915/wm: Verify the correct plane DDB entry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/skl_watermark.c | 420 +++++++++----------
 1 file changed, 210 insertions(+), 210 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_watermark.c b/drivers/gpu/drm/i915/display/skl_watermark.c
index 045c7cac166bb..2b05db764a3a9 100644
--- a/drivers/gpu/drm/i915/display/skl_watermark.c
+++ b/drivers/gpu/drm/i915/display/skl_watermark.c
@@ -3039,202 +3039,6 @@ static void skl_wm_get_hw_state(struct drm_i915_private *i915)
 	dbuf_state->enabled_slices = i915->display.dbuf.enabled_slices;
 }
 
-static bool skl_dbuf_is_misconfigured(struct drm_i915_private *i915)
-{
-	const struct intel_dbuf_state *dbuf_state =
-		to_intel_dbuf_state(i915->display.dbuf.obj.state);
-	struct skl_ddb_entry entries[I915_MAX_PIPES] = {};
-	struct intel_crtc *crtc;
-
-	for_each_intel_crtc(&i915->drm, crtc) {
-		const struct intel_crtc_state *crtc_state =
-			to_intel_crtc_state(crtc->base.state);
-
-		entries[crtc->pipe] = crtc_state->wm.skl.ddb;
-	}
-
-	for_each_intel_crtc(&i915->drm, crtc) {
-		const struct intel_crtc_state *crtc_state =
-			to_intel_crtc_state(crtc->base.state);
-		u8 slices;
-
-		slices = skl_compute_dbuf_slices(crtc, dbuf_state->active_pipes,
-						 dbuf_state->joined_mbus);
-		if (dbuf_state->slices[crtc->pipe] & ~slices)
-			return true;
-
-		if (skl_ddb_allocation_overlaps(&crtc_state->wm.skl.ddb, entries,
-						I915_MAX_PIPES, crtc->pipe))
-			return true;
-	}
-
-	return false;
-}
-
-static void skl_wm_sanitize(struct drm_i915_private *i915)
-{
-	struct intel_crtc *crtc;
-
-	/*
-	 * On TGL/RKL (at least) the BIOS likes to assign the planes
-	 * to the wrong DBUF slices. This will cause an infinite loop
-	 * in skl_commit_modeset_enables() as it can't find a way to
-	 * transition between the old bogus DBUF layout to the new
-	 * proper DBUF layout without DBUF allocation overlaps between
-	 * the planes (which cannot be allowed or else the hardware
-	 * may hang). If we detect a bogus DBUF layout just turn off
-	 * all the planes so that skl_commit_modeset_enables() can
-	 * simply ignore them.
-	 */
-	if (!skl_dbuf_is_misconfigured(i915))
-		return;
-
-	drm_dbg_kms(&i915->drm, "BIOS has misprogrammed the DBUF, disabling all planes\n");
-
-	for_each_intel_crtc(&i915->drm, crtc) {
-		struct intel_plane *plane = to_intel_plane(crtc->base.primary);
-		const struct intel_plane_state *plane_state =
-			to_intel_plane_state(plane->base.state);
-		struct intel_crtc_state *crtc_state =
-			to_intel_crtc_state(crtc->base.state);
-
-		if (plane_state->uapi.visible)
-			intel_plane_disable_noatomic(crtc, plane);
-
-		drm_WARN_ON(&i915->drm, crtc_state->active_planes != 0);
-
-		memset(&crtc_state->wm.skl.ddb, 0, sizeof(crtc_state->wm.skl.ddb));
-	}
-}
-
-static void skl_wm_get_hw_state_and_sanitize(struct drm_i915_private *i915)
-{
-	skl_wm_get_hw_state(i915);
-	skl_wm_sanitize(i915);
-}
-
-void intel_wm_state_verify(struct intel_atomic_state *state,
-			   struct intel_crtc *crtc)
-{
-	struct drm_i915_private *i915 = to_i915(state->base.dev);
-	const struct intel_crtc_state *new_crtc_state =
-		intel_atomic_get_new_crtc_state(state, crtc);
-	struct skl_hw_state {
-		struct skl_ddb_entry ddb[I915_MAX_PLANES];
-		struct skl_ddb_entry ddb_y[I915_MAX_PLANES];
-		struct skl_pipe_wm wm;
-	} *hw;
-	const struct skl_pipe_wm *sw_wm = &new_crtc_state->wm.skl.optimal;
-	struct intel_plane *plane;
-	u8 hw_enabled_slices;
-	int level;
-
-	if (DISPLAY_VER(i915) < 9 || !new_crtc_state->hw.active)
-		return;
-
-	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
-	if (!hw)
-		return;
-
-	skl_pipe_wm_get_hw_state(crtc, &hw->wm);
-
-	skl_pipe_ddb_get_hw_state(crtc, hw->ddb, hw->ddb_y);
-
-	hw_enabled_slices = intel_enabled_dbuf_slices_mask(i915);
-
-	if (DISPLAY_VER(i915) >= 11 &&
-	    hw_enabled_slices != i915->display.dbuf.enabled_slices)
-		drm_err(&i915->drm,
-			"mismatch in DBUF Slices (expected 0x%x, got 0x%x)\n",
-			i915->display.dbuf.enabled_slices,
-			hw_enabled_slices);
-
-	for_each_intel_plane_on_crtc(&i915->drm, crtc, plane) {
-		const struct skl_ddb_entry *hw_ddb_entry, *sw_ddb_entry;
-		const struct skl_wm_level *hw_wm_level, *sw_wm_level;
-
-		/* Watermarks */
-		for (level = 0; level < i915->display.wm.num_levels; level++) {
-			hw_wm_level = &hw->wm.planes[plane->id].wm[level];
-			sw_wm_level = skl_plane_wm_level(sw_wm, plane->id, level);
-
-			if (skl_wm_level_equals(hw_wm_level, sw_wm_level))
-				continue;
-
-			drm_err(&i915->drm,
-				"[PLANE:%d:%s] mismatch in WM%d (expected e=%d b=%u l=%u, got e=%d b=%u l=%u)\n",
-				plane->base.base.id, plane->base.name, level,
-				sw_wm_level->enable,
-				sw_wm_level->blocks,
-				sw_wm_level->lines,
-				hw_wm_level->enable,
-				hw_wm_level->blocks,
-				hw_wm_level->lines);
-		}
-
-		hw_wm_level = &hw->wm.planes[plane->id].trans_wm;
-		sw_wm_level = skl_plane_trans_wm(sw_wm, plane->id);
-
-		if (!skl_wm_level_equals(hw_wm_level, sw_wm_level)) {
-			drm_err(&i915->drm,
-				"[PLANE:%d:%s] mismatch in trans WM (expected e=%d b=%u l=%u, got e=%d b=%u l=%u)\n",
-				plane->base.base.id, plane->base.name,
-				sw_wm_level->enable,
-				sw_wm_level->blocks,
-				sw_wm_level->lines,
-				hw_wm_level->enable,
-				hw_wm_level->blocks,
-				hw_wm_level->lines);
-		}
-
-		hw_wm_level = &hw->wm.planes[plane->id].sagv.wm0;
-		sw_wm_level = &sw_wm->planes[plane->id].sagv.wm0;
-
-		if (HAS_HW_SAGV_WM(i915) &&
-		    !skl_wm_level_equals(hw_wm_level, sw_wm_level)) {
-			drm_err(&i915->drm,
-				"[PLANE:%d:%s] mismatch in SAGV WM (expected e=%d b=%u l=%u, got e=%d b=%u l=%u)\n",
-				plane->base.base.id, plane->base.name,
-				sw_wm_level->enable,
-				sw_wm_level->blocks,
-				sw_wm_level->lines,
-				hw_wm_level->enable,
-				hw_wm_level->blocks,
-				hw_wm_level->lines);
-		}
-
-		hw_wm_level = &hw->wm.planes[plane->id].sagv.trans_wm;
-		sw_wm_level = &sw_wm->planes[plane->id].sagv.trans_wm;
-
-		if (HAS_HW_SAGV_WM(i915) &&
-		    !skl_wm_level_equals(hw_wm_level, sw_wm_level)) {
-			drm_err(&i915->drm,
-				"[PLANE:%d:%s] mismatch in SAGV trans WM (expected e=%d b=%u l=%u, got e=%d b=%u l=%u)\n",
-				plane->base.base.id, plane->base.name,
-				sw_wm_level->enable,
-				sw_wm_level->blocks,
-				sw_wm_level->lines,
-				hw_wm_level->enable,
-				hw_wm_level->blocks,
-				hw_wm_level->lines);
-		}
-
-		/* DDB */
-		hw_ddb_entry = &hw->ddb[PLANE_CURSOR];
-		sw_ddb_entry = &new_crtc_state->wm.skl.plane_ddb[PLANE_CURSOR];
-
-		if (!skl_ddb_entry_equal(hw_ddb_entry, sw_ddb_entry)) {
-			drm_err(&i915->drm,
-				"[PLANE:%d:%s] mismatch in DDB (expected (%u,%u), found (%u,%u))\n",
-				plane->base.base.id, plane->base.name,
-				sw_ddb_entry->start, sw_ddb_entry->end,
-				hw_ddb_entry->start, hw_ddb_entry->end);
-		}
-	}
-
-	kfree(hw);
-}
-
 bool skl_watermark_ipc_enabled(struct drm_i915_private *i915)
 {
 	return i915->display.wm.ipc_enabled;
@@ -3390,20 +3194,6 @@ static void skl_setup_wm_latency(struct drm_i915_private *i915)
 	intel_print_wm_latency(i915, "Gen9 Plane", i915->display.wm.skl_latency);
 }
 
-static const struct intel_wm_funcs skl_wm_funcs = {
-	.compute_global_watermarks = skl_compute_wm,
-	.get_hw_state = skl_wm_get_hw_state_and_sanitize,
-};
-
-void skl_wm_init(struct drm_i915_private *i915)
-{
-	intel_sagv_init(i915);
-
-	skl_setup_wm_latency(i915);
-
-	i915->display.funcs.wm = &skl_wm_funcs;
-}
-
 static struct intel_global_state *intel_dbuf_duplicate_state(struct intel_global_obj *obj)
 {
 	struct intel_dbuf_state *dbuf_state;
@@ -3747,6 +3537,216 @@ void intel_dbuf_post_plane_update(struct intel_atomic_state *state)
 	gen9_dbuf_slices_update(i915, new_slices);
 }
 
+static bool skl_dbuf_is_misconfigured(struct drm_i915_private *i915)
+{
+	const struct intel_dbuf_state *dbuf_state =
+		to_intel_dbuf_state(i915->display.dbuf.obj.state);
+	struct skl_ddb_entry entries[I915_MAX_PIPES] = {};
+	struct intel_crtc *crtc;
+
+	for_each_intel_crtc(&i915->drm, crtc) {
+		const struct intel_crtc_state *crtc_state =
+			to_intel_crtc_state(crtc->base.state);
+
+		entries[crtc->pipe] = crtc_state->wm.skl.ddb;
+	}
+
+	for_each_intel_crtc(&i915->drm, crtc) {
+		const struct intel_crtc_state *crtc_state =
+			to_intel_crtc_state(crtc->base.state);
+		u8 slices;
+
+		slices = skl_compute_dbuf_slices(crtc, dbuf_state->active_pipes,
+						 dbuf_state->joined_mbus);
+		if (dbuf_state->slices[crtc->pipe] & ~slices)
+			return true;
+
+		if (skl_ddb_allocation_overlaps(&crtc_state->wm.skl.ddb, entries,
+						I915_MAX_PIPES, crtc->pipe))
+			return true;
+	}
+
+	return false;
+}
+
+static void skl_wm_sanitize(struct drm_i915_private *i915)
+{
+	struct intel_crtc *crtc;
+
+	/*
+	 * On TGL/RKL (at least) the BIOS likes to assign the planes
+	 * to the wrong DBUF slices. This will cause an infinite loop
+	 * in skl_commit_modeset_enables() as it can't find a way to
+	 * transition between the old bogus DBUF layout to the new
+	 * proper DBUF layout without DBUF allocation overlaps between
+	 * the planes (which cannot be allowed or else the hardware
+	 * may hang). If we detect a bogus DBUF layout just turn off
+	 * all the planes so that skl_commit_modeset_enables() can
+	 * simply ignore them.
+	 */
+	if (!skl_dbuf_is_misconfigured(i915))
+		return;
+
+	drm_dbg_kms(&i915->drm, "BIOS has misprogrammed the DBUF, disabling all planes\n");
+
+	for_each_intel_crtc(&i915->drm, crtc) {
+		struct intel_plane *plane = to_intel_plane(crtc->base.primary);
+		const struct intel_plane_state *plane_state =
+			to_intel_plane_state(plane->base.state);
+		struct intel_crtc_state *crtc_state =
+			to_intel_crtc_state(crtc->base.state);
+
+		if (plane_state->uapi.visible)
+			intel_plane_disable_noatomic(crtc, plane);
+
+		drm_WARN_ON(&i915->drm, crtc_state->active_planes != 0);
+
+		memset(&crtc_state->wm.skl.ddb, 0, sizeof(crtc_state->wm.skl.ddb));
+	}
+}
+
+static void skl_wm_get_hw_state_and_sanitize(struct drm_i915_private *i915)
+{
+	skl_wm_get_hw_state(i915);
+	skl_wm_sanitize(i915);
+}
+
+void intel_wm_state_verify(struct intel_atomic_state *state,
+			   struct intel_crtc *crtc)
+{
+	struct drm_i915_private *i915 = to_i915(state->base.dev);
+	const struct intel_crtc_state *new_crtc_state =
+		intel_atomic_get_new_crtc_state(state, crtc);
+	struct skl_hw_state {
+		struct skl_ddb_entry ddb[I915_MAX_PLANES];
+		struct skl_ddb_entry ddb_y[I915_MAX_PLANES];
+		struct skl_pipe_wm wm;
+	} *hw;
+	const struct skl_pipe_wm *sw_wm = &new_crtc_state->wm.skl.optimal;
+	struct intel_plane *plane;
+	u8 hw_enabled_slices;
+	int level;
+
+	if (DISPLAY_VER(i915) < 9 || !new_crtc_state->hw.active)
+		return;
+
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return;
+
+	skl_pipe_wm_get_hw_state(crtc, &hw->wm);
+
+	skl_pipe_ddb_get_hw_state(crtc, hw->ddb, hw->ddb_y);
+
+	hw_enabled_slices = intel_enabled_dbuf_slices_mask(i915);
+
+	if (DISPLAY_VER(i915) >= 11 &&
+	    hw_enabled_slices != i915->display.dbuf.enabled_slices)
+		drm_err(&i915->drm,
+			"mismatch in DBUF Slices (expected 0x%x, got 0x%x)\n",
+			i915->display.dbuf.enabled_slices,
+			hw_enabled_slices);
+
+	for_each_intel_plane_on_crtc(&i915->drm, crtc, plane) {
+		const struct skl_ddb_entry *hw_ddb_entry, *sw_ddb_entry;
+		const struct skl_wm_level *hw_wm_level, *sw_wm_level;
+
+		/* Watermarks */
+		for (level = 0; level < i915->display.wm.num_levels; level++) {
+			hw_wm_level = &hw->wm.planes[plane->id].wm[level];
+			sw_wm_level = skl_plane_wm_level(sw_wm, plane->id, level);
+
+			if (skl_wm_level_equals(hw_wm_level, sw_wm_level))
+				continue;
+
+			drm_err(&i915->drm,
+				"[PLANE:%d:%s] mismatch in WM%d (expected e=%d b=%u l=%u, got e=%d b=%u l=%u)\n",
+				plane->base.base.id, plane->base.name, level,
+				sw_wm_level->enable,
+				sw_wm_level->blocks,
+				sw_wm_level->lines,
+				hw_wm_level->enable,
+				hw_wm_level->blocks,
+				hw_wm_level->lines);
+		}
+
+		hw_wm_level = &hw->wm.planes[plane->id].trans_wm;
+		sw_wm_level = skl_plane_trans_wm(sw_wm, plane->id);
+
+		if (!skl_wm_level_equals(hw_wm_level, sw_wm_level)) {
+			drm_err(&i915->drm,
+				"[PLANE:%d:%s] mismatch in trans WM (expected e=%d b=%u l=%u, got e=%d b=%u l=%u)\n",
+				plane->base.base.id, plane->base.name,
+				sw_wm_level->enable,
+				sw_wm_level->blocks,
+				sw_wm_level->lines,
+				hw_wm_level->enable,
+				hw_wm_level->blocks,
+				hw_wm_level->lines);
+		}
+
+		hw_wm_level = &hw->wm.planes[plane->id].sagv.wm0;
+		sw_wm_level = &sw_wm->planes[plane->id].sagv.wm0;
+
+		if (HAS_HW_SAGV_WM(i915) &&
+		    !skl_wm_level_equals(hw_wm_level, sw_wm_level)) {
+			drm_err(&i915->drm,
+				"[PLANE:%d:%s] mismatch in SAGV WM (expected e=%d b=%u l=%u, got e=%d b=%u l=%u)\n",
+				plane->base.base.id, plane->base.name,
+				sw_wm_level->enable,
+				sw_wm_level->blocks,
+				sw_wm_level->lines,
+				hw_wm_level->enable,
+				hw_wm_level->blocks,
+				hw_wm_level->lines);
+		}
+
+		hw_wm_level = &hw->wm.planes[plane->id].sagv.trans_wm;
+		sw_wm_level = &sw_wm->planes[plane->id].sagv.trans_wm;
+
+		if (HAS_HW_SAGV_WM(i915) &&
+		    !skl_wm_level_equals(hw_wm_level, sw_wm_level)) {
+			drm_err(&i915->drm,
+				"[PLANE:%d:%s] mismatch in SAGV trans WM (expected e=%d b=%u l=%u, got e=%d b=%u l=%u)\n",
+				plane->base.base.id, plane->base.name,
+				sw_wm_level->enable,
+				sw_wm_level->blocks,
+				sw_wm_level->lines,
+				hw_wm_level->enable,
+				hw_wm_level->blocks,
+				hw_wm_level->lines);
+		}
+
+		/* DDB */
+		hw_ddb_entry = &hw->ddb[PLANE_CURSOR];
+		sw_ddb_entry = &new_crtc_state->wm.skl.plane_ddb[PLANE_CURSOR];
+
+		if (!skl_ddb_entry_equal(hw_ddb_entry, sw_ddb_entry)) {
+			drm_err(&i915->drm,
+				"[PLANE:%d:%s] mismatch in DDB (expected (%u,%u), found (%u,%u))\n",
+				plane->base.base.id, plane->base.name,
+				sw_ddb_entry->start, sw_ddb_entry->end,
+				hw_ddb_entry->start, hw_ddb_entry->end);
+		}
+	}
+
+	kfree(hw);
+}
+
+static const struct intel_wm_funcs skl_wm_funcs = {
+	.compute_global_watermarks = skl_compute_wm,
+	.get_hw_state = skl_wm_get_hw_state_and_sanitize,
+};
+
+void skl_wm_init(struct drm_i915_private *i915)
+{
+	intel_sagv_init(i915);
+
+	skl_setup_wm_latency(i915);
+
+	i915->display.funcs.wm = &skl_wm_funcs;
+}
+
 static int skl_watermark_ipc_status_show(struct seq_file *m, void *data)
 {
 	struct drm_i915_private *i915 = m->private;
-- 
2.53.0




