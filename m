Return-Path: <stable+bounces-3763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C1802432
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8091C20980
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE999EED5;
	Sun,  3 Dec 2023 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyzTjmMw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99488C8CB
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E9AC433C8;
	Sun,  3 Dec 2023 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701609744;
	bh=ITmfuMLH22eJpPuC/e1tsAbs1gqeTAAyvVBHbLq2AZ0=;
	h=Subject:To:Cc:From:Date:From;
	b=JyzTjmMwaZmogRxABuoTjqsyHzy0HF4grLYA3HiNACkWoCM9cP8ajexOQMQ4nuIEq
	 gBQtSJXIVUqHAyiE3GUGsVxIEueXbD71cDNqSjmDm/y/qXAD8D0XBT+v263DeDhhob
	 L79cQgR3Ke/A3q4pVqrStzB3y50NsUTbM8ekh3gM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix MPCC 1DLUT programming" failed to apply to 6.6-stable tree
To: ilya.bakoulin@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,krunoslav.kovac@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:22:13 +0100
Message-ID: <2023120313-financial-boogeyman-d74e@gregkh>
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
git cherry-pick -x 6f395cebdd8927fbffdc3a55a14fcacf93634359
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120313-financial-boogeyman-d74e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

6f395cebdd89 ("drm/amd/display: Fix MPCC 1DLUT programming")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f395cebdd8927fbffdc3a55a14fcacf93634359 Mon Sep 17 00:00:00 2001
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


