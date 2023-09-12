Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4787B79C000
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjIKUza (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbjIKOF2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:05:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC6CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:05:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE08C433C8;
        Mon, 11 Sep 2023 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441123;
        bh=zWVTGJ4SQhJhopu7+njRdf73lzhLFAsXWoQe9PZQcyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hW+GPhUxB25XSf2WhpRNxF6VmGCo6YqlMudmNwQ9pDNbvevbwsfierW5X+NkZj5Bx
         De6FYOJVfui2jDt/B/yBW5HL09WiUPb6MGxfL51PN/PRGpfLBGupiqSFZ7NxjCSD5X
         ct2JOFFJyltFDVl1Qv1+DHJCyqvOlqg1YGYAkmpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ryan McCann <quic_rmccann@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 303/739] drm/msm/dpu: fix DSC 1.2 block lengths
Date:   Mon, 11 Sep 2023 15:41:42 +0200
Message-ID: <20230911134659.588908190@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit e550ad0e5c3d1a521413e6efb22729698a70110b ]

All DSC_BLK_1_2 declarations incorrectly pass 0x29c as the block length.
This includes the common block itself, enc subblocks and some empty
space around. Change that to pass 0x4 instead, the length of common
register block itself.

Fixes: 0d1b10c63346 ("drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets")
Reported-by: Ryan McCann <quic_rmccann@quicinc.com>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Patchwork: https://patchwork.freedesktop.org/patch/550998/
Link: https://lore.kernel.org/r/20230802183655.4188640-1-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h   |  8 ++++----
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h   |  2 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 12 ++++++------
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h   |  8 ++++----
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h   |  8 ++++----
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
index a7baef8d9c490..b2a90e9e849e5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
@@ -161,22 +161,22 @@ static const struct dpu_merge_3d_cfg sm8350_merge_3d[] = {
 static const struct dpu_dsc_cfg sm8350_dsc[] = {
 	{
 		.name = "dce_0_0", .id = DSC_0,
-		.base = 0x80000, .len = 0x29c,
+		.base = 0x80000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2),
 		.sblk = &dsc_sblk_0,
 	}, {
 		.name = "dce_0_1", .id = DSC_1,
-		.base = 0x80000, .len = 0x29c,
+		.base = 0x80000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2),
 		.sblk = &dsc_sblk_1,
 	}, {
 		.name = "dce_1_0", .id = DSC_2,
-		.base = 0x81000, .len = 0x29c,
+		.base = 0x81000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
 		.sblk = &dsc_sblk_0,
 	}, {
 		.name = "dce_1_1", .id = DSC_3,
-		.base = 0x81000, .len = 0x29c,
+		.base = 0x81000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
 		.sblk = &dsc_sblk_1,
 	},
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
index 9bfea24105629..76a2530238aab 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
@@ -106,7 +106,7 @@ static const struct dpu_pingpong_cfg sc7280_pp[] = {
 static const struct dpu_dsc_cfg sc7280_dsc[] = {
 	{
 		.name = "dce_0_0", .id = DSC_0,
-		.base = 0x80000, .len = 0x29c,
+		.base = 0x80000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
 		.sblk = &dsc_sblk_0,
 	},
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
index 16310d3d24dce..7ed302ade28c8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
@@ -150,32 +150,32 @@ static const struct dpu_merge_3d_cfg sc8280xp_merge_3d[] = {
 static const struct dpu_dsc_cfg sc8280xp_dsc[] = {
 	{
 		.name = "dce_0_0", .id = DSC_0,
-		.base = 0x80000, .len = 0x29c,
+		.base = 0x80000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2),
 		.sblk = &dsc_sblk_0,
 	}, {
 		.name = "dce_0_1", .id = DSC_1,
-		.base = 0x80000, .len = 0x29c,
+		.base = 0x80000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2),
 		.sblk = &dsc_sblk_1,
 	}, {
 		.name = "dce_1_0", .id = DSC_2,
-		.base = 0x81000, .len = 0x29c,
+		.base = 0x81000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
 		.sblk = &dsc_sblk_0,
 	}, {
 		.name = "dce_1_1", .id = DSC_3,
-		.base = 0x81000, .len = 0x29c,
+		.base = 0x81000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
 		.sblk = &dsc_sblk_1,
 	}, {
 		.name = "dce_2_0", .id = DSC_4,
-		.base = 0x82000, .len = 0x29c,
+		.base = 0x82000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2),
 		.sblk = &dsc_sblk_0,
 	}, {
 		.name = "dce_2_1", .id = DSC_5,
-		.base = 0x82000, .len = 0x29c,
+		.base = 0x82000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2),
 		.sblk = &dsc_sblk_1,
 	},
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
index ed5a9f9e2d331..7a27f26c69b62 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
@@ -169,22 +169,22 @@ static const struct dpu_merge_3d_cfg sm8450_merge_3d[] = {
 static const struct dpu_dsc_cfg sm8450_dsc[] = {
 	{
 		.name = "dce_0_0", .id = DSC_0,
-		.base = 0x80000, .len = 0x29c,
+		.base = 0x80000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2),
 		.sblk = &dsc_sblk_0,
 	}, {
 		.name = "dce_0_1", .id = DSC_1,
-		.base = 0x80000, .len = 0x29c,
+		.base = 0x80000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2),
 		.sblk = &dsc_sblk_1,
 	}, {
 		.name = "dce_1_0", .id = DSC_2,
-		.base = 0x81000, .len = 0x29c,
+		.base = 0x81000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
 		.sblk = &dsc_sblk_0,
 	}, {
 		.name = "dce_1_1", .id = DSC_3,
-		.base = 0x81000, .len = 0x29c,
+		.base = 0x81000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
 		.sblk = &dsc_sblk_1,
 	},
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
index 3f91f230636db..9b653a95e019c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
@@ -173,22 +173,22 @@ static const struct dpu_merge_3d_cfg sm8550_merge_3d[] = {
 static const struct dpu_dsc_cfg sm8550_dsc[] = {
 	{
 		.name = "dce_0_0", .id = DSC_0,
-		.base = 0x80000, .len = 0x29c,
+		.base = 0x80000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2),
 		.sblk = &dsc_sblk_0,
 	}, {
 		.name = "dce_0_1", .id = DSC_1,
-		.base = 0x80000, .len = 0x29c,
+		.base = 0x80000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2),
 		.sblk = &dsc_sblk_1,
 	}, {
 		.name = "dce_1_0", .id = DSC_2,
-		.base = 0x81000, .len = 0x29c,
+		.base = 0x81000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
 		.sblk = &dsc_sblk_0,
 	}, {
 		.name = "dce_1_1", .id = DSC_3,
-		.base = 0x81000, .len = 0x29c,
+		.base = 0x81000, .len = 0x4,
 		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN),
 		.sblk = &dsc_sblk_1,
 	},
-- 
2.40.1



