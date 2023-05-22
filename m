Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5008670C882
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjEVTjc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjEVTj2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B6B18B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E3D0629E2
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA2FC433EF;
        Mon, 22 May 2023 19:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784361;
        bh=4pPVHYEAZWbJahev3Eq2w8HYt0C6JYYI7TKXF+3xQwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIcLx4o0eHGmw9uZwl8B01kfJ2rq0/flu++mw7qe4aBL6in+zNg7ztAEhILD/Qs8n
         qy9zeuo6Dm7Noy8wz5bJ2pxfnUaAH8fcgFPf2nS6Fd33aHdvUzogQRbrdpyD8fhg5i
         tMBbUrR4C86uL94gsk+q1z7jO7Xw3K3vIJeniSpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alvin Lee <Alvin.Lee2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Samson Tam <Samson.Tam@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 056/364] drm/amd/display: reallocate DET for dual displays with high pixel rate ratio
Date:   Mon, 22 May 2023 20:06:01 +0100
Message-Id: <20230522190414.199772512@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Samson Tam <Samson.Tam@amd.com>

[ Upstream commit 5f3401eeb064fab5ce50728cce46532cce7a85c5 ]

[Why]
For dual displays where pixel rate is much higher on one display,
we may get underflow when DET is evenly allocated.

[How]
Allocate less DET segments for the lower pixel rate display and
more DET segments for the higher pixel rate display

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 3a2d7bcc4b6d6..8310bcf651728 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -261,6 +261,8 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
 	return psr_capable;
 }
 
+#define DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER 7
+
 /**
  * *******************************************************************************************
  * dcn32_determine_det_override: Determine DET allocation for each pipe
@@ -272,7 +274,6 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  * If there is a plane that's driven by more than 1 pipe (i.e. pipe split), then the
  * number of DET for that given plane will be split among the pipes driving that plane.
  *
- *
  * High level algorithm:
  * 1. Split total DET among number of streams
  * 2. For each stream, split DET among the planes
@@ -280,6 +281,18 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  *    among those pipes.
  * 4. Assign the DET override to the DML pipes.
  *
+ * Special cases:
+ *
+ * For two displays that have a large difference in pixel rate, we may experience
+ *  underflow on the larger display when we divide the DET equally. For this, we
+ *  will implement a modified algorithm to assign more DET to larger display.
+ *
+ * 1. Calculate difference in pixel rates ( multiplier ) between two displays
+ * 2. If the multiplier exceeds DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER, then
+ *    implement the modified DET override algorithm.
+ * 3. Assign smaller DET size for lower pixel display and higher DET size for
+ *    higher pixel display
+ *
  * @param [in]: dc: Current DC state
  * @param [in]: context: New DC state to be programmed
  * @param [in]: pipes: Array of DML pipes
@@ -299,18 +312,46 @@ void dcn32_determine_det_override(struct dc *dc,
 	struct dc_plane_state *current_plane = NULL;
 	uint8_t stream_count = 0;
 
+	int phy_pix_clk_mult, lower_mode_stream_index;
+	int phy_pix_clk[MAX_PIPES] = {0};
+	bool use_new_det_override_algorithm = false;
+
 	for (i = 0; i < context->stream_count; i++) {
 		/* Don't count SubVP streams for DET allocation */
 		if (context->streams[i]->mall_stream_config.type != SUBVP_PHANTOM) {
+			phy_pix_clk[i] = context->streams[i]->phy_pix_clk;
 			stream_count++;
 		}
 	}
 
+	/* Check for special case with two displays, one with much higher pixel rate */
+	if (stream_count == 2) {
+		ASSERT(!phy_pix_clk[0] || !phy_pix_clk[1]);
+		if (phy_pix_clk[0] < phy_pix_clk[1]) {
+			lower_mode_stream_index = 0;
+			phy_pix_clk_mult = phy_pix_clk[1] / phy_pix_clk[0];
+		} else {
+			lower_mode_stream_index = 1;
+			phy_pix_clk_mult = phy_pix_clk[0] / phy_pix_clk[1];
+		}
+
+		if (phy_pix_clk_mult >= DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER)
+			use_new_det_override_algorithm = true;
+	}
+
 	if (stream_count > 0) {
 		stream_segments = 18 / stream_count;
 		for (i = 0; i < context->stream_count; i++) {
 			if (context->streams[i]->mall_stream_config.type == SUBVP_PHANTOM)
 				continue;
+
+			if (use_new_det_override_algorithm) {
+				if (i == lower_mode_stream_index)
+					stream_segments = 4;
+				else
+					stream_segments = 14;
+			}
+
 			if (context->stream_status[i].plane_count > 0)
 				plane_segments = stream_segments / context->stream_status[i].plane_count;
 			else
-- 
2.39.2



