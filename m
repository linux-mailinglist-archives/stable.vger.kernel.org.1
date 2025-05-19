Return-Path: <stable+bounces-144783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F7ABBD39
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7EB188938B
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9250A269B03;
	Mon, 19 May 2025 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MdUVJoOn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521061F03F2
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656187; cv=none; b=DHNbeDjgafdR5OjvEXd783Dk9BUnSaSIZtnBd0dPLg0wrcPm2XS2+GjL4tTuGswCOp2wIz72duTq7s2EzYjbVi41pa3U5FsWDm94ncsXj1ZFbeXJW4rytYZhjt1PpKhuW4hLiI/cHQQDreSXKZe+ov8QLDdXxndAVCFJnhlekcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656187; c=relaxed/simple;
	bh=A3VNH9VoE8RdFVp/wXyXj1raairZsQNehwunleZmZmQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GttHFKThOAJ1qYTJRAhvAU4NE1gS2btTTQ5GlQAgGO3Gz8gLtL6r1jd4CtzZqa6PrXWoXxaD/wD+/D1vKJK4enDoJKJh15S6OqJlz10S9fAxy/S+lGpMOvhpAjZWLz/nvWZzJxz3a5gjEZ7TWmEvRB/uvZZBxjLKnv6yeEIMuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MdUVJoOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C6DC4CEE4;
	Mon, 19 May 2025 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747656187;
	bh=A3VNH9VoE8RdFVp/wXyXj1raairZsQNehwunleZmZmQ=;
	h=Subject:To:Cc:From:Date:From;
	b=MdUVJoOncLQOqRZ1QJocHEpVSBy/honEy3D2Bt0NVldRpPH/B+KWlGngLflM2nBjw
	 xOsJkOx0RNeJPFyvD8+98USUJ6epHAsM0l1+47V7ui2CbyPlOlDapY0NN5aifO127n
	 PN/Pl94CMprxOiRs2I9URo4/ckM3MZV3c+qCs1ng=
Subject: FAILED: patch "[PATCH] drm/amd/display: Defer BW-optimization-blocked DRR" failed to apply to 6.6-stable tree
To: john.olender@gmail.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,daniel.wheeler@amd.com,ray.wu@amd.com,sunpeng.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:02:56 +0200
Message-ID: <2025051956-dayroom-vintage-a21f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 874697e127931bf50a37ce9d96ee80f3a08a0c38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051956-dayroom-vintage-a21f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 874697e127931bf50a37ce9d96ee80f3a08a0c38 Mon Sep 17 00:00:00 2001
From: John Olender <john.olender@gmail.com>
Date: Wed, 16 Apr 2025 02:54:26 -0400
Subject: [PATCH] drm/amd/display: Defer BW-optimization-blocked DRR
 adjustments

[Why & How]
Instead of dropping DRR updates, defer them. This fixes issues where
monitor continues to see incorrect refresh rate after VRR was turned off
by userspace.

Fixes: 32953485c558 ("drm/amd/display: Do not update DRR while BW optimizations pending")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3546
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: John Olender <john.olender@gmail.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 53761b7ecd83e6fbb9f2206f8c980a6aa308c844)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1525c408d452..cc01b9c68b47 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -372,6 +372,8 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
 static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 					      struct dm_crtc_state *new_state)
 {
+	if (new_state->stream->adjust.timing_adjust_pending)
+		return true;
 	if (new_state->freesync_config.state ==  VRR_STATE_ACTIVE_FIXED)
 		return true;
 	else if (amdgpu_dm_crtc_vrr_active(old_state) != amdgpu_dm_crtc_vrr_active(new_state))
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 28d1353f403d..ba4ce8a63158 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -439,9 +439,12 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	 * Don't adjust DRR while there's bandwidth optimizations pending to
 	 * avoid conflicting with firmware updates.
 	 */
-	if (dc->ctx->dce_version > DCE_VERSION_MAX)
-		if (dc->optimized_required || dc->wm_optimized_required)
+	if (dc->ctx->dce_version > DCE_VERSION_MAX) {
+		if (dc->optimized_required || dc->wm_optimized_required) {
+			stream->adjust.timing_adjust_pending = true;
 			return false;
+		}
+	}
 
 	dc_exit_ips_for_hw_access(dc);
 
@@ -3168,7 +3171,8 @@ static void copy_stream_update_to_stream(struct dc *dc,
 
 	if (update->crtc_timing_adjust) {
 		if (stream->adjust.v_total_min != update->crtc_timing_adjust->v_total_min ||
-			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max)
+			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max ||
+			stream->adjust.timing_adjust_pending)
 			update->crtc_timing_adjust->timing_adjust_pending = true;
 		stream->adjust = *update->crtc_timing_adjust;
 		update->crtc_timing_adjust->timing_adjust_pending = false;


