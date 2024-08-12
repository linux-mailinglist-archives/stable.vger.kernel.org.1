Return-Path: <stable+bounces-66624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE5B94F06B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D34E281BB7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102FE183094;
	Mon, 12 Aug 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xjD8JIX0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481C172773
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474190; cv=none; b=INVAmdPMvYHRr2Dcc/cvGmtTwcgpTnzYAa8CEJyWqiFWbY/aqo3bw8w2J7kQC2Rziokb3iKVmu+vnjiFC54EbVVLnrGNQRoWLimttYgnXrXZxbm/U1p+CBZLp6o9eQRRNpfEkoyDc6GGNuhSWQzCDaNRO0sBQnb2Qq5uS4CVwwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474190; c=relaxed/simple;
	bh=pAll9M/aelzL1e8RHN1W5A23+CMH+XexyFTu9SLGrhc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BFrofJJH2GEMU9nZdQWCfRIVEggSbEaIJKrYOgjXw5r0KouXhvR25etjcrrCQuOPErHCDgqWVqv3u73uKhC4sQdjKfemN8HoyTTYaLxJwQ+sXWyC6KwUEdTnOKKBqjBMKjMVF/rc0bSUVfNA8jfU631RGJjjUtcF+d3SoHLVfyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xjD8JIX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40827C32782;
	Mon, 12 Aug 2024 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474190;
	bh=pAll9M/aelzL1e8RHN1W5A23+CMH+XexyFTu9SLGrhc=;
	h=Subject:To:Cc:From:Date:From;
	b=xjD8JIX0vHsydgDHUZsP1xX/0ZgGepHSAtDH+mToRMu2Ly/gFXcEiqn1JN92WW8dR
	 9YujCKJ3hX8mZZfL6fCdeYVnsMye7o0aMjySQuFKsOOcb1+WzRCmsCv3hf3DQEuLs+
	 P/L4zX8e9iKd950x+IChuW7DKpqfUCFDgQQO/TcM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix 1DLUT setting for NL SDR blending" failed to apply to 5.4-stable tree
To: relja.vojvodic@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,ilya.bakoulin@amd.co,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:28 +0200
Message-ID: <2024081228-starring-pavilion-bc20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 58acedd7849a238d2d06430b030b365cf069cca8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081228-starring-pavilion-bc20@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

58acedd7849a ("drm/amd/display: Fix 1DLUT setting for NL SDR blending")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
70839da63605 ("drm/amd/display: Add new DCN401 sources")
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


