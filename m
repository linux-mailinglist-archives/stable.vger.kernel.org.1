Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967387036B7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243776AbjEORNJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243823AbjEORMt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E1CDDA1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C69B962B60
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DCAC433D2;
        Mon, 15 May 2023 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170664;
        bh=t4wfhlhv0WB64ZrugnH109btefTtEgBncFuv009EILA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErE7YqlXY7Gsb4O6PfaGk57GX25Sx4Wbg1RP5pMKNfMQIhgEhNlp6jMYkcl6N/IhY
         6z5vBSe/6PrrEz1/Wh2ez6UV1de/U7ynFi7v1pppcD+g/lG3TN4TEXUz2y8kTfrgG+
         W8kWr0ecL4m6Pjk4H8m8kBgjemiFU88prRM4Naho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Charlene Liu <Charlene.Liu@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 202/239] drm/amd/display: Fix Z8 support configurations
Date:   Mon, 15 May 2023 18:27:45 +0200
Message-Id: <20230515161727.791262434@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 73dd4ca4b5a01235607231839bd351bbef75a1d2 ]

[Why]
It's not supported in multi-display, but it is supported in 2nd eDP
screen only.

[How]
Remove multi display support, restrict number of planes for all
z-states support, but still allow Z8 if we're not using PWRSEQ0.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: d893f39320e1 ("drm/amd/display: Lowering min Z8 residency time")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index feef0a75878f9..6a7bcba4a7dad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -949,7 +949,6 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	int plane_count;
 	int i;
 	unsigned int optimized_min_dst_y_next_start_us;
-	bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > 1000.0;
 
 	plane_count = 0;
 	optimized_min_dst_y_next_start_us = 0;
@@ -974,6 +973,8 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
+		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > 1000.0;
+		bool is_pwrseq0 = link->link_index == 0;
 
 		if (dc_extended_blank_supported(dc)) {
 			for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -986,18 +987,17 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 				}
 			}
 		}
-		/* zstate only supported on PWRSEQ0  and when there's <2 planes*/
-		if (link->link_index != 0 || stream_status->plane_count > 1)
+
+		/* Don't support multi-plane configurations */
+		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000)
+		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000))
 			return DCN_ZSTATE_SUPPORT_ALLOW;
-		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
+		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
 		else
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY : DCN_ZSTATE_SUPPORT_DISALLOW;
-	} else if (allow_z8) {
-		return DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY;
 	} else {
 		return DCN_ZSTATE_SUPPORT_DISALLOW;
 	}
-- 
2.39.2



