Return-Path: <stable+bounces-263983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LK2jIH9sMWreiwUAu9opvQ
	(envelope-from <stable+bounces-263983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:32:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BD66911CB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:32:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Czp92SPK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263983-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263983-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6626C31E59DF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782CF4418FC;
	Tue, 16 Jun 2026 15:25:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9143E49F;
	Tue, 16 Jun 2026 15:25:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623521; cv=none; b=UF1qDW91SD+q5lL3gr8X2+n6GM2NU5nWAeP0pIdCZDU5LNyVZhcuWYabo3B0fl2anvV7aALl5pEFLQa34YK5+6ZQdb7fQA4DGD8Syn7NbpiyO47hj+YPsjorWUL4hBinNo5774n489Z1C1V7Zh3FNM1BPtXL0Kja7vMM9/umDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623521; c=relaxed/simple;
	bh=UlTwDwvBJ/O1NVENUiy3fbu1IwIoEGlndSt0GHHkUXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv56rQNDc108CdIl72KSvN8rwWGmLspSFR1OOeEmZnq9B5+JnGRq/Rtd5/j8xG0eHXRAuT0ElKRa9Do2E9LnrIob+nXiSCpRm/kX8VYSOssWMZEebEebWn1PxaF+n1eTWlX3/FDJNQMTfPv9/NCEtR2z9L4H1qN9AazaIP2avcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Czp92SPK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7675B1F000E9;
	Tue, 16 Jun 2026 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623518;
	bh=/aEdxqvLMrfaKQhX9TB0twoGMjRelpp6eAgOhvaeDmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Czp92SPKvaORP4RBAPqFsnmcd37zZ/967/bcNQDXAmQYkC6ECs93QgY21U269urhb
	 vo0WzNX9BnNGZ4Qc74dM89z8b9kMIv22Gswyd2OV6AplaBeoiTwTVujXKi/slJjx3x
	 Se41VCslWqrdzHj5NkKwO7lpD2J3TGfElRWex63s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Alex Hung <alex.hung@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 7.0 163/378] drm/atomic: track individual colorop updates
Date: Tue, 16 Jun 2026 20:26:34 +0530
Message-ID: <20260616145118.843136613@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,amd.com,igalia.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-263983-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:chaitanya.kumar.borah@intel.com,m:alex.hung@amd.com,m:mwen@igalia.com,m:melissa.srw@gmail.com,m:sashal@kernel.org,m:harry.wentland@amd.com,m:melissasrw@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,vger.kernel.org:from_smtp,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,igalia.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6BD66911CB

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Melissa Wen <mwen@igalia.com>

[ Upstream commit 2e235e2a2784b12b735321e5b42240ca51c49b0f ]

As we do for CRTC color mgmt properties, use color_mgmt_changed flag to
track any value changes in the color pipeline of a given plane, so that
drivers can update color blocks as soon as plane color pipeline or
individual colorop values change. Since we're here, only announce and
track changes to plane COLOR_PIPELINE prop if its value is actually
changing.

Fixes: 8c5ea1745f4c ("drm/colorop: Add BYPASS property")
Fixes: 7fa3ee8c0a79 ("drm/colorop: Define LUT_1D interpolation")
Fixes: 41651f9d42eb ("drm/colorop: Add 1D Curve subtype")
Fixes: 3410108037d5 ("drm/colorop: Add multiplier type")
Fixes: db971856bbe0 ("drm/colorop: Add 3D LUT support to color pipeline")
Fixes: e5719e7f1900 ("drm/colorop: Add 3x4 CTM type")
Fixes: 99a4e4f08abe ("drm/colorop: Add 1D Curve Custom LUT type")
Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
Reviewed-by: Harry Wentland <harry.wentland@amd.com> #v1
Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Fixes: 9ba25915efba ("drm/amd/display: Add support for sRGB EOTF in DEGAM block")
Signed-off-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Link: https://patch.msgid.link/20260609110420.1298352-4-mwen@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 64 ++++++++++++++++++++++++-------
 include/drm/drm_atomic_uapi.h     |  4 +-
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index aefcf58e4f0399..97bbf91f3c7975 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -265,13 +265,19 @@ EXPORT_SYMBOL(drm_atomic_set_fb_for_plane);
  *
  * Helper function to select the color pipeline on a plane by setting
  * it to the first drm_colorop element of the pipeline.
+ *
+ * Return: true if plane color pipeline value changed, false otherwise.
  */
-void
+bool
 drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
 				 struct drm_colorop *colorop)
 {
 	struct drm_plane *plane = plane_state->plane;
 
+	/* Color pipeline didn't change */
+	if (plane_state->color_pipeline == colorop)
+		return false;
+
 	if (colorop)
 		drm_dbg_atomic(plane->dev,
 			       "Set [COLOROP:%d] for [PLANE:%d:%s] state %p\n",
@@ -283,6 +289,8 @@ drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
 			       plane->base.id, plane->name, plane_state);
 
 	plane_state->color_pipeline = colorop;
+
+	return true;
 }
 EXPORT_SYMBOL(drm_atomic_set_colorop_for_plane);
 
@@ -600,7 +608,7 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		if (val && !colorop)
 			return -EACCES;
 
-		drm_atomic_set_colorop_for_plane(state, colorop);
+		state->color_mgmt_changed |= drm_atomic_set_colorop_for_plane(state, colorop);
 	} else if (property == config->prop_fb_damage_clips) {
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->fb_damage_clips,
@@ -709,11 +717,11 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
 static int drm_atomic_color_set_data_property(struct drm_colorop *colorop,
 					      struct drm_colorop_state *state,
 					      struct drm_property *property,
-					      uint64_t val)
+					      uint64_t val,
+					      bool *replaced)
 {
 	ssize_t elem_size = -1;
 	ssize_t size = -1;
-	bool replaced = false;
 
 	switch (colorop->type) {
 	case DRM_COLOROP_1D_LUT:
@@ -735,28 +743,45 @@ static int drm_atomic_color_set_data_property(struct drm_colorop *colorop,
 						 &state->data,
 						 val,
 						 -1, size, elem_size,
-						 &replaced);
+						 replaced);
 }
 
 static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
 					   struct drm_colorop_state *state,
 					   struct drm_file *file_priv,
 					   struct drm_property *property,
-					   uint64_t val)
+					   uint64_t val,
+					   bool *replaced)
 {
 	if (property == colorop->bypass_property) {
-		state->bypass = val;
+		if (state->bypass != val) {
+			state->bypass = val;
+			*replaced = true;
+		}
 	} else if (property == colorop->lut1d_interpolation_property) {
-		state->lut1d_interpolation = val;
+		if (state->lut1d_interpolation != val) {
+			state->lut1d_interpolation = val;
+			*replaced = true;
+		}
 	} else if (property == colorop->curve_1d_type_property) {
-		state->curve_1d_type = val;
+		if (state->curve_1d_type != val) {
+			state->curve_1d_type = val;
+			*replaced = true;
+		}
 	} else if (property == colorop->multiplier_property) {
-		state->multiplier = val;
+		if (state->multiplier != val) {
+			state->multiplier = val;
+			*replaced = true;
+		}
 	} else if (property == colorop->lut3d_interpolation_property) {
-		state->lut3d_interpolation = val;
+		if (state->lut3d_interpolation != val) {
+			state->lut3d_interpolation = val;
+			*replaced = true;
+		}
 	} else if (property == colorop->data_property) {
 		return drm_atomic_color_set_data_property(colorop, state,
-							  property, val);
+							  property, val,
+							  replaced);
 	} else {
 		drm_dbg_atomic(colorop->dev,
 			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
@@ -1271,8 +1296,10 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 		break;
 	}
 	case DRM_MODE_OBJECT_COLOROP: {
+		struct drm_plane_state *plane_state;
 		struct drm_colorop *colorop = obj_to_colorop(obj);
 		struct drm_colorop_state *colorop_state;
+		bool replaced = false;
 
 		colorop_state = drm_atomic_get_colorop_state(state, colorop);
 		if (IS_ERR(colorop_state)) {
@@ -1281,7 +1308,18 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 		}
 
 		ret = drm_atomic_colorop_set_property(colorop, colorop_state,
-						      file_priv, prop, prop_value);
+						      file_priv, prop, prop_value,
+						      &replaced);
+		if (ret || !replaced)
+			break;
+
+		plane_state = drm_atomic_get_plane_state(state, colorop->plane);
+		if (IS_ERR(plane_state)) {
+			ret = PTR_ERR(plane_state);
+			break;
+		}
+		plane_state->color_mgmt_changed |= replaced;
+
 		break;
 	}
 	default:
diff --git a/include/drm/drm_atomic_uapi.h b/include/drm/drm_atomic_uapi.h
index 4363155233267b..4e7e78f711e26a 100644
--- a/include/drm/drm_atomic_uapi.h
+++ b/include/drm/drm_atomic_uapi.h
@@ -29,6 +29,8 @@
 #ifndef DRM_ATOMIC_UAPI_H_
 #define DRM_ATOMIC_UAPI_H_
 
+#include <linux/types.h>
+
 struct drm_crtc_state;
 struct drm_display_mode;
 struct drm_property_blob;
@@ -50,7 +52,7 @@ drm_atomic_set_crtc_for_plane(struct drm_plane_state *plane_state,
 			      struct drm_crtc *crtc);
 void drm_atomic_set_fb_for_plane(struct drm_plane_state *plane_state,
 				 struct drm_framebuffer *fb);
-void drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
+bool drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
 				      struct drm_colorop *colorop);
 int __must_check
 drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
-- 
2.53.0




