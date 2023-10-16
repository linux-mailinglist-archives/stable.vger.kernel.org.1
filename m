Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50C7CA37C
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjJPJGn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjJPJGm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:06:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F3095
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:06:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F78C433BB;
        Mon, 16 Oct 2023 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697447201;
        bh=nbIHYK8/C75qW4v+2T5Wend5VeTD3PTdLoMdrv+3iXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hf89dokdLYtO9yCEQsh79qABizlCqaeycq2C1jnw7iAy4fzeiCp2gjW4OuWVyJnwX
         vfWDz7FDMpf+OH5oWixCyu7768dFcK78A3u3nu9ppDm9VeKGR8gqHrnhcSlDh1VzIq
         xqCo5fGY0dn+PqPPGdeqfphUBzmHsqXDFXE2FjhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alvin Lee <alvin.lee2@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Samson Tam <samson.tam@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.5 012/191] drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to master OTG pipes only
Date:   Mon, 16 Oct 2023 10:39:57 +0200
Message-ID: <20231016084015.689108768@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samson Tam <samson.tam@amd.com>

commit b206011bf05069797df1f4c5ce639398728978e2 upstream.

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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c |    4 ++--
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -157,7 +157,7 @@ void dcn20_update_clocks_update_dentist(
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
@@ -188,7 +188,7 @@ void dcn20_update_clocks_update_dentist(
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -355,7 +355,7 @@ static void dcn32_update_clocks_update_d
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)
@@ -401,7 +401,7 @@ static void dcn32_update_clocks_update_d
 			int32_t N;
 			int32_t j;
 
-			if (!pipe_ctx->stream)
+			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 				continue;
 			/* Virtual encoders don't have this function */
 			if (!stream_enc->funcs->get_fifo_cal_average_level)


