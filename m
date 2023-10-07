Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3617BC7B3
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 14:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbjJGMnH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 08:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbjJGMnG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 08:43:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE1BAB
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 05:43:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A53C433C9;
        Sat,  7 Oct 2023 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696682584;
        bh=AQXCe5d8oWFCeDEu+DYFWVDX3WDJ4o+MaMTQk6Qxf9c=;
        h=Subject:To:Cc:From:Date:From;
        b=0OZSz1J52jaLW+CN7C6vlls3zlgAzDHo0pWiPgd8wx9QKMyfYg+4YcHd68q7cOaSb
         hg+2f4mA4WIpryQ3Y9grjdq4qN91YPWYfL5WAvFMGkRPpT37Nf1VPNus8yjphiD5R+
         ijcpXi1ayiA/JGGkaZSoTVdQESTMNI2KS8vMOyb0=
Subject: FAILED: patch "[PATCH] drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to" failed to apply to 6.5-stable tree
To:     samson.tam@amd.com, alexander.deucher@amd.com, alvin.lee2@amd.com,
        aurabindo.pillai@amd.com, daniel.wheeler@amd.com,
        mario.limonciello@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 07 Oct 2023 14:43:01 +0200
Message-ID: <2023100701-upheaval-crispness-02a3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x b206011bf05069797df1f4c5ce639398728978e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100701-upheaval-crispness-02a3@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

b206011bf050 ("drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to master OTG pipes only")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b206011bf05069797df1f4c5ce639398728978e2 Mon Sep 17 00:00:00 2001
From: Samson Tam <samson.tam@amd.com>
Date: Mon, 18 Sep 2023 18:43:13 -0400
Subject: [PATCH] drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to
 master OTG pipes only

[Why]
The edge-case DISPCLK WDIVIDER changes call stream_enc functions.
But with MPC pipes, downstream pipes have null stream_enc and will
 cause crash.

[How]
Only call stream_enc functions for pipes that are OTG master.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index c435f7632e8e..5ee87965a078 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -157,7 +157,7 @@ void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
@@ -188,7 +188,7 @@ void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 984b52923534..e9345f6554db 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -355,7 +355,7 @@ static void dcn32_update_clocks_update_dentist(
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
@@ -401,7 +401,7 @@ static void dcn32_update_clocks_update_dentist(
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)

