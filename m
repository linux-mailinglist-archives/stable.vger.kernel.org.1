Return-Path: <stable+bounces-236034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBJ9JhLg3GnrXgkAu9opvQ
	(envelope-from <stable+bounces-236034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:22:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 068AB3EBDA1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83919303FAB5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57336167F;
	Mon, 13 Apr 2026 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qn0RztrI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217EA3161BA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082585; cv=none; b=lNO6aW1fGWMU083JfVg2jWlEDbxkOSkJJ9Ew+DAxo53orFestjritJr9ak6IbN99bLeSaCE8ORnd8jkGxb+WW4d+N981PkxILM0iMLgAWQ6iud0vwVXvVXrKDH3puHTcKqSEIV2irG9Y4z7IhhwQW80wZ2paQ8adGhv3FyDaf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082585; c=relaxed/simple;
	bh=1WrhATmH4v9Hwh++VdJVh5Z/V5/nhfjB3ZFCkXYM8Es=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PcJ4riYDm3XLXds+uNzeO1bPmSQAY31Ri9w9bPnlxWxtT2g2riUaMKiBOpTpQaJ4pdDDReskxg8JxmmeSstKSnPLEoTt2N4OUT6FPG7/iX9J5yr/D0CLh3tNGFvKdE3T52qhiY27ibTow6Or1ZO+8hhruxIPdBqOKblwJMNa4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qn0RztrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0534C116C6;
	Mon, 13 Apr 2026 12:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776082585;
	bh=1WrhATmH4v9Hwh++VdJVh5Z/V5/nhfjB3ZFCkXYM8Es=;
	h=Subject:To:Cc:From:Date:From;
	b=Qn0RztrICPeHBAQHolOCa6zgl+HUfKCXxN6BCAuEIxlFP3uz7GK1k/89QoQ6c4Bzk
	 5l3FpJTWLRdWy0+xywzic4p2p8pEp0PRZp030v7YgkVZ/4qojnQPebNrwLPEgZYLo7
	 6u9VSyHCqBbuJOF8UlOvjhYHMVWuh+gIVnSmt7+c=
Subject: FAILED: patch "[PATCH] drm/i915/psr: Do not use pipe_src as borders for SU area" failed to apply to 6.1-stable tree
To: jouni.hogander@intel.com,joonas.lahtinen@linux.intel.com,mika.kahola@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:16:14 +0200
Message-ID: <2026041314-laundry-reformer-de94@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236034-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email]
X-Rspamd-Queue-Id: 068AB3EBDA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 75519f5df2a9b23f7bf305e12dc9a6e3e65c24b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041314-laundry-reformer-de94@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75519f5df2a9b23f7bf305e12dc9a6e3e65c24b7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Date: Fri, 27 Mar 2026 13:45:53 +0200
Subject: [PATCH] drm/i915/psr: Do not use pipe_src as borders for SU area
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 3791944389db..097e18c1adb2 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2678,9 +2678,9 @@ static u32 psr2_pipe_srcsz_early_tpt_calc(struct intel_crtc_state *crtc_state,
 
 static void clip_area_update(struct drm_rect *overlap_damage_area,
 			     struct drm_rect *damage_area,
-			     struct drm_rect *pipe_src)
+			     struct drm_rect *display_area)
 {
-	if (!drm_rect_intersect(damage_area, pipe_src))
+	if (!drm_rect_intersect(damage_area, display_area))
 		return;
 
 	if (overlap_damage_area->y1 == -1) {
@@ -2731,6 +2731,7 @@ static bool intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_st
 static void
 intel_psr2_sel_fetch_et_alignment(struct intel_atomic_state *state,
 				  struct intel_crtc *crtc,
+				  struct drm_rect *display_area,
 				  bool *cursor_in_su_area)
 {
 	struct intel_crtc_state *crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
@@ -2758,7 +2759,7 @@ intel_psr2_sel_fetch_et_alignment(struct intel_atomic_state *state,
 			continue;
 
 		clip_area_update(&crtc_state->psr2_su_area, &new_plane_state->uapi.dst,
-				 &crtc_state->pipe_src);
+				 display_area);
 		*cursor_in_su_area = true;
 	}
 }
@@ -2855,6 +2856,12 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	struct intel_crtc_state *crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
 	struct intel_plane_state *new_plane_state, *old_plane_state;
 	struct intel_plane *plane;
+	struct drm_rect display_area = {
+		.x1 = 0,
+		.y1 = 0,
+		.x2 = crtc_state->hw.adjusted_mode.crtc_hdisplay,
+		.y2 = crtc_state->hw.adjusted_mode.crtc_vdisplay,
+	};
 	bool full_update = false, su_area_changed;
 	int i, ret;
 
@@ -2868,7 +2875,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 	crtc_state->psr2_su_area.x1 = 0;
 	crtc_state->psr2_su_area.y1 = -1;
-	crtc_state->psr2_su_area.x2 = drm_rect_width(&crtc_state->pipe_src);
+	crtc_state->psr2_su_area.x2 = drm_rect_width(&display_area);
 	crtc_state->psr2_su_area.y2 = -1;
 
 	/*
@@ -2906,14 +2913,14 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 				damaged_area.y1 = old_plane_state->uapi.dst.y1;
 				damaged_area.y2 = old_plane_state->uapi.dst.y2;
 				clip_area_update(&crtc_state->psr2_su_area, &damaged_area,
-						 &crtc_state->pipe_src);
+						 &display_area);
 			}
 
 			if (new_plane_state->uapi.visible) {
 				damaged_area.y1 = new_plane_state->uapi.dst.y1;
 				damaged_area.y2 = new_plane_state->uapi.dst.y2;
 				clip_area_update(&crtc_state->psr2_su_area, &damaged_area,
-						 &crtc_state->pipe_src);
+						 &display_area);
 			}
 			continue;
 		} else if (new_plane_state->uapi.alpha != old_plane_state->uapi.alpha) {
@@ -2921,7 +2928,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 			damaged_area.y1 = new_plane_state->uapi.dst.y1;
 			damaged_area.y2 = new_plane_state->uapi.dst.y2;
 			clip_area_update(&crtc_state->psr2_su_area, &damaged_area,
-					 &crtc_state->pipe_src);
+					 &display_area);
 			continue;
 		}
 
@@ -2937,7 +2944,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		damaged_area.x1 += new_plane_state->uapi.dst.x1 - src.x1;
 		damaged_area.x2 += new_plane_state->uapi.dst.x1 - src.x1;
 
-		clip_area_update(&crtc_state->psr2_su_area, &damaged_area, &crtc_state->pipe_src);
+		clip_area_update(&crtc_state->psr2_su_area, &damaged_area, &display_area);
 	}
 
 	/*
@@ -2972,7 +2979,8 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		 * cursor is added into affected planes even when
 		 * cursor is not updated by itself.
 		 */
-		intel_psr2_sel_fetch_et_alignment(state, crtc, &cursor_in_su_area);
+		intel_psr2_sel_fetch_et_alignment(state, crtc, &display_area,
+						  &cursor_in_su_area);
 
 		su_area_changed = intel_psr2_sel_fetch_pipe_alignment(crtc_state);
 
@@ -3048,8 +3056,8 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 skip_sel_fetch_set_loop:
 	if (full_update)
-		clip_area_update(&crtc_state->psr2_su_area, &crtc_state->pipe_src,
-				 &crtc_state->pipe_src);
+		clip_area_update(&crtc_state->psr2_su_area, &display_area,
+				 &display_area);
 
 	psr2_man_trk_ctl_calc(crtc_state, full_update);
 	crtc_state->pipe_srcsz_early_tpt =


