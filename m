Return-Path: <stable+bounces-66620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C95894F067
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DEB1F20B66
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC07F17995B;
	Mon, 12 Aug 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hYUis/jq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF50153BF6
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474177; cv=none; b=eS7NHLEu6D/+EXvy4plgNcT4XCzC0TQwdklFHRTrEn2ymI6Xo5J1sU7tEp1f3TlH3Eb2J3dyaTAJktVb/tcOgc/NL5YLi4dpnJEjEJVqJVropdLg/YPeQwBAcZ737A7lfmsKi+iAx59amTrBIhEus+MZN41EX4P2HhfFaDe1m4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474177; c=relaxed/simple;
	bh=LyEMHvWUvDx+GutKQkfiDtXJLLqiZwcIVUWz6gyadw4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AnC1hDx1Gx1Vylg9vrFnnikz9LnJs5CaB9+CAh3IK2j23RnRuLeKVyTC0rEWuF2SkA4D5fbMTxMc8rVdDf0NYbLqVZLmYKM9Epro5TDqHG2rEPVO+r0loZq+tEyV3ktJTFV/qo6Qx5dyOSQf6z3y5YTeogDqYWhXoP5u6w+E+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hYUis/jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C79FC32782;
	Mon, 12 Aug 2024 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474177;
	bh=LyEMHvWUvDx+GutKQkfiDtXJLLqiZwcIVUWz6gyadw4=;
	h=Subject:To:Cc:From:Date:From;
	b=hYUis/jqxVNUfqNRFs3ZXbcer0P0zQwUH0ZP8t81Modx+yzgbnx1tZQm3zLV3q9pO
	 V+uEpOYoAtwiHgB8DM8tGBqZQjTn6dOt7PBALEDfFMNkqo6DNiH/Pvbgbak5miCJsJ
	 1PPVbBUYFHMwe/vKPLB4SmdpflWUINSpvue9ZVbw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix 1DLUT setting for NL SDR blending" failed to apply to 6.6-stable tree
To: relja.vojvodic@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,ilya.bakoulin@amd.co,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:25 +0200
Message-ID: <2024081225-stream-destiny-f75a@gregkh>
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
git cherry-pick -x 58acedd7849a238d2d06430b030b365cf069cca8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081225-stream-destiny-f75a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

58acedd7849a ("drm/amd/display: Fix 1DLUT setting for NL SDR blending")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58acedd7849a238d2d06430b030b365cf069cca8 Mon Sep 17 00:00:00 2001
From: Relja Vojvodic <relja.vojvodic@amd.com>
Date: Fri, 14 Jun 2024 16:49:44 -0400
Subject: [PATCH] drm/amd/display: Fix 1DLUT setting for NL SDR blending

[WHY]
Enabling NL SDR blending caused the 1D LUTs to be set/populated in two
different functions. This caused flickering as the LUT was set differently
by the two functions, one of which should only have been modifying the 1D
LUT if 3D LUT was enabled.

[HOW]
Added check to only modify the 1D LUT in populate_mcm if 3D LUT was
enabled.

Added blend_tf function update for non-main planes if the 3D LUT path
was taken.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.co>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 5306c8c170c5..b5a02a8fc9d8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -502,7 +502,7 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 	dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
 
 	/* 1D LUT */
-	if (mcm_luts.lut1d_func) {
+	if (mcm_luts.lut1d_func && lut3d_xable != MCM_LUT_DISABLE) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
 		if (mcm_luts.lut1d_func->type == TF_TYPE_HWPWL)
 			m_lut_params.pwl = &mcm_luts.lut1d_func->pwl;
@@ -674,7 +674,7 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
 	pipe_ctx->plane_state->mcm_location = MPCC_MOVABLE_CM_LOCATION_BEFORE;
 	// 1D LUT
-	if (!plane_state->mcm_lut1d_enable) {
+	if (plane_state->mcm_shaper_3dlut_setting == DC_CM2_SHAPER_3DLUT_SETTING_BYPASS_ALL) {
 		if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
 			lut_params = &plane_state->blend_tf.pwl;
 		else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {


