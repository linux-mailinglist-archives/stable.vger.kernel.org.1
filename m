Return-Path: <stable+bounces-66621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC394F068
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F161C223BC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDFD4D8CB;
	Mon, 12 Aug 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="poSnMS6Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB902B9B5
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474181; cv=none; b=LSIIGE91qKCRgf4sYXixFoEXcMN23jR3xTNipQiaNS9CVJ3Zz1xtah686N6xPXYPXnlYwCJYZwi7o14Z+A4wBw9W0SPFa8N2DbfyNlU+SbirxEV3C+SKG4i0EspkTL93DYol7MjxVakmeUdOnMayI2jTkGdF7/LyYIYLcdOMLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474181; c=relaxed/simple;
	bh=uIOI/4tqlIrpJo8z2xUWFuIJGd6C33RyyNbWBJg/fsw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AXPfBYFWXOhpBtZ4kQ+gojWdXr09lcntnrf7U7eOmMcV8EGTYbytwFGuhPGrwZJxDFycdZ4MhV0I3rLscpxqBGZ2G5VuyoPsrm/Ix/xpGG0nBTF9iPEO3MSDVDvi+XcCG5xc7hJw3pGHToQkcIlnjx2d3RyHRtnkMMkEx/Psu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=poSnMS6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64530C32782;
	Mon, 12 Aug 2024 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474180;
	bh=uIOI/4tqlIrpJo8z2xUWFuIJGd6C33RyyNbWBJg/fsw=;
	h=Subject:To:Cc:From:Date:From;
	b=poSnMS6Z9xsN7470kcwbSlxMa8sE2o4HaH0R3mqrbzBJvSWarO6M8AH6bXd/CZX84
	 ICTVu85uq2Ap8lZ2/STVSc6kAJqhM4ZmzuW0gvKFjC0zCUubYd7b9cV+5X1uZD5AZM
	 I5lXPnSLQyu7ZGsyQ06OX0NKgAAwOD6seUeWnSUs=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix 1DLUT setting for NL SDR blending" failed to apply to 5.15-stable tree
To: relja.vojvodic@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,ilya.bakoulin@amd.co,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:26 +0200
Message-ID: <2024081226-recipient-singer-f268@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 58acedd7849a238d2d06430b030b365cf069cca8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081226-recipient-singer-f268@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


