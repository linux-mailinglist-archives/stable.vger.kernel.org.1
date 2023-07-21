Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DFC75CED1
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjGUQYp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjGUQYa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E214F5586
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C70361D2B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CB4C433B6;
        Fri, 21 Jul 2023 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956453;
        bh=v/eXKJyZMg+qG2X7bz6YRvbKxMrACiTeUFnCVZ9zmok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHdo4ShUI6ipcAzQFbOFvzYcubr1fmcgCugulR3M/NliURW0LSHRNmdmM+7Lgf3yy
         JbiVuH9CNt6CpU3bIpeeVrXqF/6LAYAq/iqQe+YItNWxjQ2EV2/84NzmKllx2p9Ja8
         NvTIa25mngP97HjzsLbMjRfKqCSncuRUzKDE8Gfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.4 199/292] drm/amd/display: fix seamless odm transitions
Date:   Fri, 21 Jul 2023 18:05:08 +0200
Message-ID: <20230721160537.435107263@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

commit 75c2b7ed080d7421157c03064be82275364136e7 upstream.

Add missing programming and function pointers

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h  |    1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1732,6 +1732,17 @@ static void dcn20_program_pipe(
 
 		if (hws->funcs.setup_vupdate_interrupt)
 			hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
+
+		if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
+			unsigned int k1_div, k2_div;
+
+			hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
+
+			dc->res_pool->dccg->funcs->set_pixel_rate_div(
+				dc->res_pool->dccg,
+				pipe_ctx->stream_res.tg->inst,
+				k1_div, k2_div);
+		}
 	}
 
 	if (pipe_ctx->update_flags.bits.odm)
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -98,7 +98,7 @@ static void optc32_set_odm_combine(struc
 	optc1->opp_count = opp_cnt;
 }
 
-static void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode)
+void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
@@ -179,5 +179,6 @@
 	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
 
 void dcn32_timing_generator_init(struct optc *optc1);
+void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode);
 
 #endif /* __DC_OPTC_DCN32_H__ */


