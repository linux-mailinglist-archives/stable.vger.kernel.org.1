Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B697038A1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbjEORdt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244286AbjEORdc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0515261
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC02462D3A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4EEC433EF;
        Mon, 15 May 2023 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171881;
        bh=o3CztR2pOVZ9XTw3z60fpg3PRvvlhR+HFVkAVKfL3YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKCLdLaaNwEtcufQ5kXwLQshQS61Vt1tcmHZdCCsIhnYeqlRIbPHZti+guwZFaL8R
         t1Ab9UrAhr2EaDRJd+SWzrM801T2ROTZooUdKvOtQx8Z+OeaYa6bImgjtG+JaEaU4Z
         VCquBe8dmum9NlCpCqJEfDTgiPcFUkGqUBH9WUmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Dale Zhao <dale.zhao@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 107/134] drm/amd/display: Refine condition of cursor visibility for pipe-split
Date:   Mon, 15 May 2023 18:29:44 +0200
Message-Id: <20230515161706.686812987@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dale Zhao <dale.zhao@amd.com>

[ Upstream commit 63f8bee439c0e3f94cff90d0f9c7b719be693265 ]

[Why]
In some scenarios like fullscreen game, major plane is scaled. Then
if a upper layer owns the cursor, cursor is invisiable in the
majority of the screen.

[How]
Instead assuming upper plane handles cursor, summing up upper
split planes on the same layer. If whole upper plane covers current
half/whole pipe plane, disable cursor.

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: d29fb7baab09 ("drm/amd/display: Add NULL plane_state check for cursor disable logic")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 43 +++++++++++--------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c655d03ef754d..eef6e4c80a37f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3211,13 +3211,11 @@ void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data)
 
 static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 {
-	struct pipe_ctx *test_pipe;
+	struct pipe_ctx *test_pipe, *split_pipe;
 	const struct scaler_data *scl_data = &pipe_ctx->plane_res.scl_data;
-	const struct rect *r1 = &scl_data->recout, *r2;
-	int r1_r = r1->x + r1->width, r1_b = r1->y + r1->height, r2_r, r2_b;
+	struct rect r1 = scl_data->recout, r2, r2_half;
+	int r1_r = r1.x + r1.width, r1_b = r1.y + r1.height, r2_r, r2_b;
 	int cur_layer = pipe_ctx->plane_state->layer_index;
-	bool upper_pipe_exists = false;
-	struct fixed31_32 one = dc_fixpt_from_int(1);
 
 	/**
 	 * Disable the cursor if there's another pipe above this with a
@@ -3226,26 +3224,33 @@ static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 	 */
 	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
 	     test_pipe = test_pipe->top_pipe) {
-		if (!test_pipe->plane_state->visible)
+		// Skip invisible layer and pipe-split plane on same layer
+		if (!test_pipe->plane_state->visible || test_pipe->plane_state->layer_index == cur_layer)
 			continue;
 
-		r2 = &test_pipe->plane_res.scl_data.recout;
-		r2_r = r2->x + r2->width;
-		r2_b = r2->y + r2->height;
+		r2 = test_pipe->plane_res.scl_data.recout;
+		r2_r = r2.x + r2.width;
+		r2_b = r2.y + r2.height;
+		split_pipe = test_pipe;
 
-		if (r1->x >= r2->x && r1->y >= r2->y && r1_r <= r2_r && r1_b <= r2_b)
-			return true;
+		/**
+		 * There is another half plane on same layer because of
+		 * pipe-split, merge together per same height.
+		 */
+		for (split_pipe = pipe_ctx->top_pipe; split_pipe;
+		     split_pipe = split_pipe->top_pipe)
+			if (split_pipe->plane_state->layer_index == test_pipe->plane_state->layer_index) {
+				r2_half = split_pipe->plane_res.scl_data.recout;
+				r2.x = (r2_half.x < r2.x) ? r2_half.x : r2.x;
+				r2.width = r2.width + r2_half.width;
+				r2_r = r2.x + r2.width;
+				break;
+			}
 
-		if (test_pipe->plane_state->layer_index < cur_layer)
-			upper_pipe_exists = true;
+		if (r1.x >= r2.x && r1.y >= r2.y && r1_r <= r2_r && r1_b <= r2_b)
+			return true;
 	}
 
-	// if plane scaled, assume an upper plane can handle cursor if it exists.
-	if (upper_pipe_exists &&
-			(scl_data->ratios.horz.value != one.value ||
-			scl_data->ratios.vert.value != one.value))
-		return true;
-
 	return false;
 }
 
-- 
2.39.2



