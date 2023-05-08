Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7996FA6B8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjEHKXd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjEHKWz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D8DC7E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C56862560
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617AAC433EF;
        Mon,  8 May 2023 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541349;
        bh=2rSVD32M6YkyiT4CTDT1uf5wATV3jM1JsbS0zW1tn3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWUKnESgcafJC7nzmNVX77T+yMhn24J3L4JZfVJyliJPii4vY5hn7IUVnSNj8aji/
         Dl5VgF2fChFrq1aRQT0vqCPXsuCz9fH0HN4lxeHokAkuhOdoRJ+ttNWk1TFhnJa8dV
         USYT7Fi7ZqbtJC/AQfYN+KQUXW5+Gxt5SwSPSUKI=
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
Subject: [PATCH 6.2 086/663] drm/amd/display: limit timing for single dimm memory
Date:   Mon,  8 May 2023 11:38:32 +0200
Message-Id: <20230508094431.244630388@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index 54ed3de869d3b..9ffba4c6fe550 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1697,6 +1697,23 @@ static void dcn314_get_panel_config_defaults(struct dc_panel_config *panel_confi
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
@@ -1712,6 +1729,9 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (filter_modes_for_single_channel_workaround(dc, context))
+		goto validate_fail;
+
 	DC_FP_START();
 	// do not support self refresh only
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, false);
-- 
2.39.2



