Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781757F50B7
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 20:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjKVTg1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 14:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjKVTg0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 14:36:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A4C12A
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 11:36:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7475DC433C8;
        Wed, 22 Nov 2023 19:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700681782;
        bh=GU1ROVxpfRBaPDx/G5VOdhtMgY9q/cL6XrDc3aw/RmM=;
        h=Subject:To:Cc:From:Date:From;
        b=zAsVhiMIjtQkQaOdM71OXRmYiwtsCz8K27K2NIBcMMbWnaBB6tn+eFLJHT61Ut5rA
         gK53HSkFkNPj8522dEp8lLW+y8PYSVV6yLhcuzSpV4hfmP+1VOfcViCxZDzb1cuNcW
         hA/k+dzy2FG1o7A7RzWIzAwqzA3nAgowQvd69JJo=
Subject: FAILED: patch "[PATCH] drm/amd/display: enable dsc_clk even if dsc_pg disabled" failed to apply to 6.6-stable tree
To:     ahmed.ahmed@amd.com, alexander.deucher@amd.com,
        aurabindo.pillai@amd.com, charlene.liu@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 19:36:20 +0000
Message-ID: <2023112220-immovable-squirt-1044@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 40255df370e94d44f0f0a924400d68db0ee31bec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112220-immovable-squirt-1044@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

40255df370e9 ("drm/amd/display: enable dsc_clk even if dsc_pg disabled")
0fa45b6aeae4 ("drm/amd/display: Add DCN35 Resource")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40255df370e94d44f0f0a924400d68db0ee31bec Mon Sep 17 00:00:00 2001
From: Muhammad Ahmed <ahmed.ahmed@amd.com>
Date: Mon, 18 Sep 2023 16:52:54 -0400
Subject: [PATCH] drm/amd/display: enable dsc_clk even if dsc_pg disabled

[why]
need to enable dsc_clk regardless dsc_pg

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 72dffb7a49f9..39e291a467e2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1853,7 +1853,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	if (dc->hwss.subvp_pipe_control_lock)
 		dc->hwss.subvp_pipe_control_lock(dc, context, true, true, NULL, subvp_prev_use);
 
-	if (dc->debug.enable_double_buffered_dsc_pg_support)
+	if (dc->hwss.update_dsc_pg)
 		dc->hwss.update_dsc_pg(dc, context, false);
 
 	disable_dangling_plane(dc, context);
@@ -1960,7 +1960,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.optimize_bandwidth(dc, context);
 	}
 
-	if (dc->debug.enable_double_buffered_dsc_pg_support)
+	if (dc->hwss.update_dsc_pg)
 		dc->hwss.update_dsc_pg(dc, context, true);
 
 	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
@@ -2207,7 +2207,7 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 
 		dc->hwss.optimize_bandwidth(dc, context);
 
-		if (dc->debug.enable_double_buffered_dsc_pg_support)
+		if (dc->hwss.update_dsc_pg)
 			dc->hwss.update_dsc_pg(dc, context, true);
 	}
 
@@ -3565,7 +3565,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (get_seamless_boot_stream_count(context) == 0)
 			dc->hwss.prepare_bandwidth(dc, context);
 
-		if (dc->debug.enable_double_buffered_dsc_pg_support)
+		if (dc->hwss.update_dsc_pg)
 			dc->hwss.update_dsc_pg(dc, context, false);
 
 		context_clock_trace(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 76fd7a41bdbf..45b557d8e089 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -77,6 +77,9 @@ void dcn32_dsc_pg_control(
 	if (hws->ctx->dc->debug.disable_dsc_power_gate)
 		return;
 
+	if (!hws->ctx->dc->debug.enable_double_buffered_dsc_pg_support)
+		return;
+
 	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 	if (org_ip_request_cntl == 0)
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, 1);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 10ae1b3da751..6214866916c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -742,7 +742,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_mem_low_power = false,
 	.enable_hpo_pg_support = false,
 	//must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions
-	.enable_double_buffered_dsc_pg_support = false,
+	.enable_double_buffered_dsc_pg_support = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 	.disable_z10 = false,
 	.ignore_pg = true,

