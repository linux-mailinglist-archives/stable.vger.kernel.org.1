Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43979B2EB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354227AbjIKVwz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbjIKOFe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:05:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3309E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:05:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05572C433C8;
        Mon, 11 Sep 2023 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441129;
        bh=bxuHdAHxFhfMiR9SonF0d8K506349I2EkFFODKL5xyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPTjWMlQXQnXKb2JhuPGtYAJyMvSvfgmYEqqOOnYNldOHZJ1HdMkSwPx3UNpSq/k8
         DWuzROYyjwJaHQzQeqod0P131nxXSoJTCZqC9rodui6lk+RiJaLP5osWDNzSmfS1os
         do32maI6en9GF6amiNFy+zyCJEw+0oV7viRyOfCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Ryan McCann <quic_rmccann@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 305/739] drm/msm/dpu: Define names for unnamed sblks
Date:   Mon, 11 Sep 2023 15:41:44 +0200
Message-ID: <20230911134659.641568825@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

From: Ryan McCann <quic_rmccann@quicinc.com>

[ Upstream commit 46998bf8431c30879be29bbbf67eefb583136ccb ]

Some sub-blocks in the hw catalog have not been given a name, so when the
registers from that block are dumped, there is no name to reference.
Define names for relevant sub-blocks to fix this.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/546199/
Link: https://lore.kernel.org/r/20230622-devcoredump_patch-v5-3-67e8b66c4723@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Stable-dep-of: 57a1ca6cf73b ("drm/msm/dpu: fix DSC 1.2 enc subblock length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index e96b3c2c2faf0..8b7143f2c760d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -444,12 +444,12 @@ static const struct dpu_lm_sub_blks qcm2290_lm_sblk = {
  * DSPP sub blocks config
  *************************************************************/
 static const struct dpu_dspp_sub_blks msm8998_dspp_sblk = {
-	.pcc = {.id = DPU_DSPP_PCC, .base = 0x1700,
+	.pcc = {.name = "pcc", .id = DPU_DSPP_PCC, .base = 0x1700,
 		.len = 0x90, .version = 0x10007},
 };
 
 static const struct dpu_dspp_sub_blks sdm845_dspp_sblk = {
-	.pcc = {.id = DPU_DSPP_PCC, .base = 0x1700,
+	.pcc = {.name = "pcc", .id = DPU_DSPP_PCC, .base = 0x1700,
 		.len = 0x90, .version = 0x40000},
 };
 
@@ -465,19 +465,19 @@ static const struct dpu_dspp_sub_blks sdm845_dspp_sblk = {
  * PINGPONG sub blocks config
  *************************************************************/
 static const struct dpu_pingpong_sub_blks sdm845_pp_sblk_te = {
-	.te2 = {.id = DPU_PINGPONG_TE2, .base = 0x2000, .len = 0x0,
+	.te2 = {.name = "te2", .id = DPU_PINGPONG_TE2, .base = 0x2000, .len = 0x0,
 		.version = 0x1},
-	.dither = {.id = DPU_PINGPONG_DITHER, .base = 0x30e0,
+	.dither = {.name = "dither", .id = DPU_PINGPONG_DITHER, .base = 0x30e0,
 		.len = 0x20, .version = 0x10000},
 };
 
 static const struct dpu_pingpong_sub_blks sdm845_pp_sblk = {
-	.dither = {.id = DPU_PINGPONG_DITHER, .base = 0x30e0,
+	.dither = {.name = "dither", .id = DPU_PINGPONG_DITHER, .base = 0x30e0,
 		.len = 0x20, .version = 0x10000},
 };
 
 static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
-	.dither = {.id = DPU_PINGPONG_DITHER, .base = 0xe0,
+	.dither = {.name = "dither", .id = DPU_PINGPONG_DITHER, .base = 0xe0,
 	.len = 0x20, .version = 0x20000},
 };
 
@@ -517,13 +517,13 @@ static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
  * DSC sub blocks config
  *************************************************************/
 static const struct dpu_dsc_sub_blks dsc_sblk_0 = {
-	.enc = {.base = 0x100, .len = 0x100},
-	.ctl = {.base = 0xF00, .len = 0x10},
+	.enc = {.name = "enc", .base = 0x100, .len = 0x100},
+	.ctl = {.name = "ctl", .base = 0xF00, .len = 0x10},
 };
 
 static const struct dpu_dsc_sub_blks dsc_sblk_1 = {
-	.enc = {.base = 0x200, .len = 0x100},
-	.ctl = {.base = 0xF80, .len = 0x10},
+	.enc = {.name = "enc", .base = 0x200, .len = 0x100},
+	.ctl = {.name = "ctl", .base = 0xF80, .len = 0x10},
 };
 
 /*************************************************************
-- 
2.40.1



