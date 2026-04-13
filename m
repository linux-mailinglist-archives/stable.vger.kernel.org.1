Return-Path: <stable+bounces-237635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JxmGH893WmqbAkAu9opvQ
	(envelope-from <stable+bounces-237635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:01:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 320EA3F25CD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9565A3016B3B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB538D6A8;
	Mon, 13 Apr 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ5H7p7a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4423EAB2
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106742; cv=none; b=TqKeCB9ahvzExqE+uSR1g3W/6Z6rTS5Hm1KTTldo1c044tQh04Po6e0+ph4xPnLc92LLSLl9Cdb9yOeJUb7uoN0MG1EJrIM0qtlas38Nuvt6BgJD3CWfnSzKbJ0nPoEhYfMTrR+Tqb7IIvXahXdaZybngCPDcKujex+/aM6DoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106742; c=relaxed/simple;
	bh=vgsTuhAL0yt4riRA6FzdkvJU7XP8Chc7SlMycKfDpXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGAM6NbdHAivgLBuuJXF5H8w6LQfMzJqtubSFT4uGF4EjrcmiMGNpnEPRTIDy96VkVYiEURyjW+KxmMkQWY1LWZ+PfhHtgQW2Va3QcfHT/XQbCtVgnxzHYG5iP2MVaW585HcA1hm7JAZ1niDwcAFZEg2ld9qJCDPncBWJSDFb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ5H7p7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9D7C2BCAF;
	Mon, 13 Apr 2026 18:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776106742;
	bh=vgsTuhAL0yt4riRA6FzdkvJU7XP8Chc7SlMycKfDpXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJ5H7p7aWIm91k/YL3+SbHGD/P3p+EuMSEHOrjLEVt1Wn+SZiNwY4sjsp6gqFjv0c
	 WnpBtvL2qxML8fXGJo1sH2qACBXDwLJFV81w4aBFVyxtExVQrimWu0vNRU0ZPvBfgD
	 I2x9t8qW3ogewBcghNfhqHcIPGopnakYeq+HJKPpVYYECjWqsBfNRJ0ZFTxxzUoXCp
	 qAyVVZIQPWLeSB9xNKR4sqmwFKVJAhWCO7XtoOvFXJvxXkYIboGA6mKGmOhvxtolIb
	 9zITKRyLPvjbNMetysme+JU08p0IBYWMd0F0g7Al2B+wQEELiVY0U1jVnsSFgYSZRN
	 oNvZeg4W7SVFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/i915/psr: Do not use pipe_src as borders for SU area
Date: Mon, 13 Apr 2026 14:59:00 -0400
Message-ID: <20260413185900.3429717-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041314-laundry-reformer-de94@gregkh>
References: <2026041314-laundry-reformer-de94@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237635-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 320EA3F25CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit 75519f5df2a9b23f7bf305e12dc9a6e3e65c24b7 ]

This far using crtc_state->pipe_src as borders for Selective Update area
haven't caused visible problems as drm_rect_width(crtc_state->pipe_src) ==
crtc_state->hw.adjusted_mode.crtc_hdisplay and
drm_rect_height(crtc_state->pipe_src) ==
crtc_state->hw.adjusted_mode.crtc_vdisplay when pipe scaling is not
used. On the other hand using pipe scaling is forcing full frame updates and all the
Selective Update area calculations are skipped. Now this improper usage of
crtc_state->pipe_src is causing following warnings:

<4> [7771.978166] xe 0000:00:02.0: [drm] drm_WARN_ON_ONCE(su_lines % vdsc_cfg->slice_height)

after WARN_ON_ONCE was added by commit:

"drm/i915/dsc: Add helper for writing DSC Selective Update ET parameters"

These warnings are seen when DSC and pipe scaling are enabled
simultaneously. This is because on full frame update SU area is improperly
set as pipe_src which is not aligned with DSC slice height.

Fix these by creating local rectangle using
crtc_state->hw.adjusted_mode.crtc_hdisplay and
crtc_state->hw.adjusted_mode.crtc_vdisplay. Use this local rectangle as
borders for SU area.

Fixes: d6774b8c3c58 ("drm/i915: Ensure damage clip area is within pipe area")
Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patch.msgid.link/20260327114553.195285-1-jouni.hogander@intel.com
(cherry picked from commit da0cdc1c329dd2ff09c41fbbe9fbd9c92c5d2c6e)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
[ omitted hunks for DSC selective update ET alignment infrastructure ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index e2d7c0a6802aa..a465b19293108 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1686,9 +1686,9 @@ static void psr2_man_trk_ctl_calc(struct intel_crtc_state *crtc_state,
 
 static void clip_area_update(struct drm_rect *overlap_damage_area,
 			     struct drm_rect *damage_area,
-			     struct drm_rect *pipe_src)
+			     struct drm_rect *display_area)
 {
-	if (!drm_rect_intersect(damage_area, pipe_src))
+	if (!drm_rect_intersect(damage_area, display_area))
 		return;
 
 	if (overlap_damage_area->y1 == -1) {
@@ -1761,6 +1761,12 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	struct drm_rect pipe_clip = { .x1 = 0, .y1 = -1, .x2 = INT_MAX, .y2 = -1 };
 	struct intel_plane_state *new_plane_state, *old_plane_state;
 	struct intel_plane *plane;
+	struct drm_rect display_area = {
+		.x1 = 0,
+		.y1 = 0,
+		.x2 = crtc_state->hw.adjusted_mode.crtc_hdisplay,
+		.y2 = crtc_state->hw.adjusted_mode.crtc_vdisplay,
+	};
 	bool full_update = false;
 	int i, ret;
 
@@ -1807,14 +1813,14 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 				damaged_area.y1 = old_plane_state->uapi.dst.y1;
 				damaged_area.y2 = old_plane_state->uapi.dst.y2;
 				clip_area_update(&pipe_clip, &damaged_area,
-						 &crtc_state->pipe_src);
+						 &display_area);
 			}
 
 			if (new_plane_state->uapi.visible) {
 				damaged_area.y1 = new_plane_state->uapi.dst.y1;
 				damaged_area.y2 = new_plane_state->uapi.dst.y2;
 				clip_area_update(&pipe_clip, &damaged_area,
-						 &crtc_state->pipe_src);
+						 &display_area);
 			}
 			continue;
 		} else if (new_plane_state->uapi.alpha != old_plane_state->uapi.alpha) {
@@ -1822,7 +1828,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 			damaged_area.y1 = new_plane_state->uapi.dst.y1;
 			damaged_area.y2 = new_plane_state->uapi.dst.y2;
 			clip_area_update(&pipe_clip, &damaged_area,
-					 &crtc_state->pipe_src);
+					 &display_area);
 			continue;
 		}
 
@@ -1838,7 +1844,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		damaged_area.x1 += new_plane_state->uapi.dst.x1 - src.x1;
 		damaged_area.x2 += new_plane_state->uapi.dst.x1 - src.x1;
 
-		clip_area_update(&pipe_clip, &damaged_area, &crtc_state->pipe_src);
+		clip_area_update(&pipe_clip, &damaged_area, &display_area);
 	}
 
 	/*
-- 
2.53.0


