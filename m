Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E132076ADD3
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjHAJdv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjHAJdY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31B4ED9
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02FC361511
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117B4C433C8;
        Tue,  1 Aug 2023 09:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882267;
        bh=LKJVr04grVPhYAiQAmW9rlGWFRAAlQubJBvFgVHc3f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nq1IsfIHyfthVcpzlro2CWo/CHFIodNQwcpm3cutNPXAa5woVzzF/iwcrhcuh/KtD
         4EqRHuzqciNgjy8gsU1VZzZpoA+bBBAyBqM+FJMpZFN5EYm/7RlkAa4BHViTpvdhfe
         R/Y5vgD4yT9ZZRPE69YdEvo1TjX4OEqDXwZ8ixPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 044/228] drm/amd/display: fix dcn315 single stream crb allocation
Date:   Tue,  1 Aug 2023 11:18:22 +0200
Message-ID: <20230801091924.479706591@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[ Upstream commit 49f26218c344741cb3eaa740b1e44e960551a87f ]

Change to improve avoiding asymetric crb calculations for single stream
scenarios.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dcn315/dcn315_resource.c   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 88c4a378daa12..b9b1e5ac4f538 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1662,6 +1662,10 @@ static bool allow_pixel_rate_crb(struct dc *dc, struct dc_state *context)
 	int i;
 	struct resource_context *res_ctx = &context->res_ctx;
 
+	/*Don't apply for single stream*/
+	if (context->stream_count < 2)
+		return false;
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
@@ -1749,19 +1753,23 @@ static int dcn315_populate_dml_pipes_from_context(
 		pipe_cnt++;
 	}
 
-	/* Spread remaining unreserved crb evenly among all pipes, use default policy if not enough det or single pipe */
+	/* Spread remaining unreserved crb evenly among all pipes*/
 	if (pixel_rate_crb) {
 		for (i = 0, pipe_cnt = 0, crb_idx = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe = &res_ctx->pipe_ctx[i];
 			if (!pipe->stream)
 				continue;
 
+			/* Do not use asymetric crb if not enough for pstate support */
+			if (remaining_det_segs < 0) {
+				pipes[pipe_cnt].pipe.src.det_size_override = 0;
+				continue;
+			}
+
 			if (!pipe->top_pipe && !pipe->prev_odm_pipe) {
 				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
 						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
 
-				if (remaining_det_segs < 0 || crb_pipes == 1)
-					pipes[pipe_cnt].pipe.src.det_size_override = 0;
 				if (remaining_det_segs > MIN_RESERVED_DET_SEGS)
 					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
 							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
@@ -1777,6 +1785,7 @@ static int dcn315_populate_dml_pipes_from_context(
 				}
 				/* Convert segments into size for DML use */
 				pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
+
 				crb_idx++;
 			}
 			pipe_cnt++;
-- 
2.39.2



