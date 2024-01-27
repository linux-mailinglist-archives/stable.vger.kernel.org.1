Return-Path: <stable+bounces-16196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E589B83F19E
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A184C282310
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA92200CA;
	Sat, 27 Jan 2024 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QoTISPDu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131D200AD
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397129; cv=none; b=Azt3DL7A+COlQ8X791nFQRwhMzXkc3o6Fov0Y7Ra/bl3g0CBi7XOywbliCMeiV5DDlU+wKHySXLmRbpD0YdzYZAaVdSDu+uhzgT2Cf3pXeEuR/hplvZf25jVaNoqN18mpvcXNMtmE4PBEUxu4tbmX94lWslIjdfRWZvWk7FYvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397129; c=relaxed/simple;
	bh=Fvx4+TH7uemEB9xRB29W2gYfxcqpIoRH/ct047P/3Vc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B0upp2nL+T45wEQ72ik6Ar6RAnLTXN3EfZhVeff936R7QnWYnWnT7AOhd/b+r9K2Unx6l0Xq/y489wD7pTE/RTeUJfvqZsQtqdp7lMqj26YGAUVBrDBDvLwO2zX9z2k+E03YoZOa50hSMP4m54vFZFIq5X4j4TrtGpX0WskSa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QoTISPDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5619DC433C7;
	Sat, 27 Jan 2024 23:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397129;
	bh=Fvx4+TH7uemEB9xRB29W2gYfxcqpIoRH/ct047P/3Vc=;
	h=Subject:To:Cc:From:Date:From;
	b=QoTISPDuQUxNLBVf3yHG/DG2lnLEME78sWmeBSrm7ctlZmTcSGdnu4e/TkzQtQthE
	 sMA/3GVUEUs/DeXLgLJhLElnRRF2SqeScJNk+vHgFP+qF9sc40etvJcS/kwT/bcozi
	 XwzbAdKeFxocxEmHu+iFVF35+dgYthH078CD/8Ng=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix MPCC 1DLUT programming" failed to apply to 6.1-stable tree
To: ilya.bakoulin@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,krunoslav.kovac@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:12:08 -0800
Message-ID: <2024012708-platinum-doorknob-8a5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a953cd8cac6be69fba0b66e6fb46d1324d797af4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012708-platinum-doorknob-8a5d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a953cd8cac6b ("drm/amd/display: Fix MPCC 1DLUT programming")
e53524cdcc02 ("drm/amd/display: Refactor HWSS into component folder")
6e2c4941ce0c ("drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard")
1cb87e048975 ("drm/amd/display: Add DCN35 blocks to Makefile")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")
ec129fa356be ("drm/amd/display: Add DCN35 init")
6f8b7565cca4 ("drm/amd/display: Add DCN35 HWSEQ")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a953cd8cac6be69fba0b66e6fb46d1324d797af4 Mon Sep 17 00:00:00 2001
From: Ilya Bakoulin <ilya.bakoulin@amd.com>
Date: Tue, 7 Nov 2023 15:07:56 -0500
Subject: [PATCH] drm/amd/display: Fix MPCC 1DLUT programming

[Why]
Wrong function is used to translate LUT values to HW format, leading to
visible artifacting in some cases.

[How]
Use the correct cm3_helper function.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 6a65af8c36b9..5f7f474ef51c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -487,8 +487,7 @@ bool dcn32_set_mcm_luts(
 		if (plane_state->blend_tf->type == TF_TYPE_HWPWL)
 			lut_params = &plane_state->blend_tf->pwl;
 		else if (plane_state->blend_tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					plane_state->blend_tf,
+			cm3_helper_translate_curve_to_hw_format(plane_state->blend_tf,
 					&dpp_base->regamma_params, false);
 			lut_params = &dpp_base->regamma_params;
 		}
@@ -503,8 +502,7 @@ bool dcn32_set_mcm_luts(
 		else if (plane_state->in_shaper_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
 			// TODO: dpp_base replace
 			ASSERT(false);
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					plane_state->in_shaper_func,
+			cm3_helper_translate_curve_to_hw_format(plane_state->in_shaper_func,
 					&dpp_base->shaper_params, true);
 			lut_params = &dpp_base->shaper_params;
 		}


