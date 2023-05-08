Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD3F6FA3F8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjEHJxm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHJxm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F072453A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 619046220B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DC4C4339C;
        Mon,  8 May 2023 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539619;
        bh=cJwUyqC8FkRQtxoxLbbvB9FCKSRZmN8fB+dNLhH02jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FugTxN+hrYpueGw5H1UmaFZSbC6aIzWhQ1jdNgJ4FfPehy83shG6/xZKWmezS5/Hz
         83YF4bijde0mNr0hlzWLoDyBSWW/ScIyzii7EglTilnnpLX00X6apU44GAkEdt4WvN
         PIIptyuUMUn2ymROS+4a5zARZR/y/5t/WZx8xLls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Miess <Daniel.Miess@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 083/611] drm/amd/display: limit timing for single dimm memory
Date:   Mon,  8 May 2023 11:38:45 +0200
Message-Id: <20230508094424.800806185@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Daniel Miess <Daniel.Miess@amd.com>

[ Upstream commit 1e994cc0956b8dabd1b1fef315bbd722733b8aa8 ]

[Why]
1. It could hit bandwidth limitdation under single dimm
memory when connecting 8K external monitor.
2. IsSupportedVidPn got validation failed with
2K240Hz eDP + 8K24Hz external monitor.
3. It's better to filter out such combination in
EnumVidPnCofuncModality
4. For short term, filter out in dc bandwidth validation.

[How]
Force 2K@240Hz+8K@24Hz timing validation false in dc.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Daniel Miess <Daniel.Miess@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dcn314/dcn314_resource.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 2f9c6d64b98bc..ffaa4e5b3fca0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1689,6 +1689,23 @@ static void dcn314_get_panel_config_defaults(struct dc_panel_config *panel_confi
 	*panel_config = panel_config_defaults;
 }
 
+static bool filter_modes_for_single_channel_workaround(struct dc *dc,
+		struct dc_state *context)
+{
+	// Filter 2K@240Hz+8K@24fps above combination timing if memory only has single dimm LPDDR
+	if (dc->clk_mgr->bw_params->vram_type == 34 && dc->clk_mgr->bw_params->num_channels < 2) {
+		int total_phy_pix_clk = 0;
+
+		for (int i = 0; i < context->stream_count; i++)
+			if (context->res_ctx.pipe_ctx[i].stream)
+				total_phy_pix_clk += context->res_ctx.pipe_ctx[i].stream->phy_pix_clk;
+
+		if (total_phy_pix_clk >= (1148928+826260)) //2K@240Hz+8K@24fps
+			return true;
+	}
+	return false;
+}
+
 bool dcn314_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
@@ -1704,6 +1721,9 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (filter_modes_for_single_channel_workaround(dc, context))
+		goto validate_fail;
+
 	DC_FP_START();
 	// do not support self refresh only
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, false);
-- 
2.39.2



