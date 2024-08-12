Return-Path: <stable+bounces-66623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF6D94F06A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF29D282A8F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E9C18132A;
	Mon, 12 Aug 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s7H2fYbU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83941172773
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474187; cv=none; b=N9yMUU44ZCnTV66K0exfz4rxDyu5c8lfQ+pupugK+mbvKFt+5fFp8bD+fRZ5KV6GIK+9q0VbyFaY6uxJALOE8+vI3V1/8y+fTEENrpVOuAto9NlXwTqi8ONRVsJ7rixtyaJOWkQhNkhYL2l3nTT7FUfo+3vAU6oAd/BWlgDt/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474187; c=relaxed/simple;
	bh=9nE2ldbr8gSyt9KvKC9RrY9oMwJ+RKSN2lst6gGVGgM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b1J2bW4amrw8oMxFDg8QsuaxevFa3HUr5k69CyhcOSA0VDIa5hvm9xA0qn1CDyAUE6t56XfUFNKCyO4XH3QvpbtwX68nWT7YxQPCF07r98odus1CxpHss+WHB9ym6qHVK6L6FJgI117PdYwevCWZH9MPOGyUxf8bLR/sa8Fz1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s7H2fYbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E790EC32782;
	Mon, 12 Aug 2024 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474187;
	bh=9nE2ldbr8gSyt9KvKC9RrY9oMwJ+RKSN2lst6gGVGgM=;
	h=Subject:To:Cc:From:Date:From;
	b=s7H2fYbUUSdstvek/8+jf+Z69ivfsC6l2dHHZzYX0rFU6xkFsszXJwWE+kBBJXMeg
	 MfmFvUVSjgljjVZHd8ckRkXdicw24qI3YFWZcuWQlaT2HlS4QHAKcY6INkpvCyWYEs
	 e7KeAJV1Aq0A+6oM7d2Otgn5Wl1kV53LLXxEnGr0=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix 1DLUT setting for NL SDR blending" failed to apply to 5.10-stable tree
To: relja.vojvodic@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,ilya.bakoulin@amd.co,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:27 +0200
Message-ID: <2024081227-reclining-trimness-bdb3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 58acedd7849a238d2d06430b030b365cf069cca8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081227-reclining-trimness-bdb3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


