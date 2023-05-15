Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD8B703709
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243804AbjEORQW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbjEORPy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9488A106E0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:14:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B1AB62BB7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE94C433EF;
        Mon, 15 May 2023 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170880;
        bh=BrgvXij3p0YCVC0fEjMbECjcdxKbY6oYm2mV2Bbpu8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDaRefploL6cYv0iKdokG4dAd+VIkFRd/3nnZjm9hN8L/6EgUSY6c4X3AdEiOpzeK
         7S+Rz5/nX46rNF5q5ZcVqGsGts63mrfdt5wqaBDEMKJLztdalJ5hWCSscGzSoXYS8N
         MgtsoYxM+8jjPx1pCLia+pscYE+gkXsZNIvrcNHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leo Li <sunpeng.li@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 030/242] drm/amd/display: Update bounding box values for DCN321
Date:   Mon, 15 May 2023 18:25:56 +0200
Message-Id: <20230515161722.828003839@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[ Upstream commit 989cd3e76a4aab76fe7dd50090ac3fa501c537f6 ]

[Why&how]

Update bounding box values as per hardware spec

Fixes: 197485c69543 ("drm/amd/display: Create dcn321_fpu file")
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index b80cef70fa60f..383a409a3f54c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -106,16 +106,16 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.clock_limits = {
 		{
 			.state = 0,
-			.dcfclk_mhz = 1564.0,
-			.fabricclk_mhz = 400.0,
-			.dispclk_mhz = 2150.0,
-			.dppclk_mhz = 2150.0,
+			.dcfclk_mhz = 1434.0,
+			.fabricclk_mhz = 2250.0,
+			.dispclk_mhz = 1720.0,
+			.dppclk_mhz = 1720.0,
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
-			.phyclk_d32_mhz = 625.0,
+			.phyclk_d32_mhz = 313.0,
 			.socclk_mhz = 1200.0,
-			.dscclk_mhz = 716.667,
-			.dram_speed_mts = 1600.0,
+			.dscclk_mhz = 573.333,
+			.dram_speed_mts = 16000.0,
 			.dtbclk_mhz = 1564.0,
 		},
 	},
@@ -125,14 +125,14 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.sr_exit_z8_time_us = 285.0,
 	.sr_enter_plus_exit_z8_time_us = 320,
 	.writeback_latency_us = 12.0,
-	.round_trip_ping_latency_dcfclk_cycles = 263,
+	.round_trip_ping_latency_dcfclk_cycles = 207,
 	.urgent_latency_pixel_data_only_us = 4,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4,
 	.urgent_latency_vm_data_only_us = 4,
-	.fclk_change_latency_us = 20,
-	.usr_retraining_latency_us = 2,
-	.smn_latency_us = 2,
-	.mall_allocated_for_dcn_mbytes = 64,
+	.fclk_change_latency_us = 7,
+	.usr_retraining_latency_us = 0,
+	.smn_latency_us = 0,
+	.mall_allocated_for_dcn_mbytes = 32,
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-- 
2.39.2



