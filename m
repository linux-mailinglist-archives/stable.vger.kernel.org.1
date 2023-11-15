Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA4E7ECFBF
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjKOTud (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjKOTuc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:50:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D37B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C611C433C9;
        Wed, 15 Nov 2023 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077828;
        bh=pq/4Iypxo5bqfQpOY5eLDx52QlBSU44cFklCOy9+a3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iaZFmmJMjEm2dfRGJIiprBDotjQMTwrW5bN0ZkN+ehy+mmOxiX6uFYyoKrgKS5Xfg
         p0spqLdfeNd2jOq34vpCb1jQrc8XScnrWnKTXpySGdQWKy3whFDaGICnirxsJBgesu
         j8AS0GoyQnbt3aioNA630ST4+smeEGrGfKyGdW7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 522/603] media: i2c: imx219: Replace register addresses with macros
Date:   Wed, 15 Nov 2023 14:17:47 -0500
Message-ID: <20231115191648.117998213@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 1c9083565a4698ff072f1209e9450ff6c305e2cc ]

Define macros for all the known registers used in the register arrays,
and use them to replace the numerical addresses. This improves
readability.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: ec80c606cca5 ("media: i2c: imx219: Drop IMX219_REG_CSI_LANE_MODE from common regs array")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 169 ++++++++++++++++++-------------------
 1 file changed, 81 insertions(+), 88 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index c5aeec50b9e85..f8d164e69b05f 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -41,6 +41,13 @@
 #define IMX219_CSI_2_LANE_MODE		0x01
 #define IMX219_CSI_4_LANE_MODE		0x03
 
+#define IMX219_REG_DPHY_CTRL		CCI_REG8(0x0128)
+#define IMX219_DPHY_CTRL_TIMING_AUTO	0
+#define IMX219_DPHY_CTRL_TIMING_MANUAL	1
+
+#define IMX219_REG_EXCK_FREQ		CCI_REG16(0x012a)
+#define IMX219_EXCK_FREQ(n)		((n) * 256)		/* n expressed in MHz */
+
 /* Analog gain control */
 #define IMX219_REG_ANALOG_GAIN		CCI_REG8(0x0157)
 #define IMX219_ANA_GAIN_MIN		0
@@ -81,6 +88,15 @@
 /* HBLANK control - read only */
 #define IMX219_PPL_DEFAULT		3448
 
+#define IMX219_REG_LINE_LENGTH_A	CCI_REG16(0x0162)
+#define IMX219_REG_X_ADD_STA_A		CCI_REG16(0x0164)
+#define IMX219_REG_X_ADD_END_A		CCI_REG16(0x0166)
+#define IMX219_REG_Y_ADD_STA_A		CCI_REG16(0x0168)
+#define IMX219_REG_Y_ADD_END_A		CCI_REG16(0x016a)
+#define IMX219_REG_X_OUTPUT_SIZE	CCI_REG16(0x016c)
+#define IMX219_REG_Y_OUTPUT_SIZE	CCI_REG16(0x016e)
+#define IMX219_REG_X_ODD_INC_A		CCI_REG8(0x0170)
+#define IMX219_REG_Y_ODD_INC_A		CCI_REG8(0x0171)
 #define IMX219_REG_ORIENTATION		CCI_REG8(0x0172)
 
 /* Binning  Mode */
@@ -89,6 +105,18 @@
 #define IMX219_BINNING_2X2		0x0101
 #define IMX219_BINNING_2X2_ANALOG	0x0303
 
+#define IMX219_REG_CSI_DATA_FORMAT_A	CCI_REG16(0x018c)
+
+/* PLL Settings */
+#define IMX219_REG_VTPXCK_DIV		CCI_REG8(0x0301)
+#define IMX219_REG_VTSYCK_DIV		CCI_REG8(0x0303)
+#define IMX219_REG_PREPLLCK_VT_DIV	CCI_REG8(0x0304)
+#define IMX219_REG_PREPLLCK_OP_DIV	CCI_REG8(0x0305)
+#define IMX219_REG_PLL_VT_MPY		CCI_REG16(0x0306)
+#define IMX219_REG_OPPXCK_DIV		CCI_REG8(0x0309)
+#define IMX219_REG_OPSYCK_DIV		CCI_REG8(0x030b)
+#define IMX219_REG_PLL_OP_MPY		CCI_REG16(0x030c)
+
 /* Test Pattern Control */
 #define IMX219_REG_TEST_PATTERN		CCI_REG16(0x0600)
 #define IMX219_TEST_PATTERN_DISABLE	0
@@ -110,6 +138,9 @@
 #define IMX219_TESTP_BLUE_DEFAULT	0
 #define IMX219_TESTP_GREENB_DEFAULT	0
 
+#define IMX219_REG_TP_WINDOW_WIDTH	CCI_REG16(0x0624)
+#define IMX219_REG_TP_WINDOW_HEIGHT	CCI_REG16(0x0626)
+
 /* External clock frequency is 24.0M */
 #define IMX219_XCLK_FREQ		24000000
 
@@ -154,7 +185,7 @@ struct imx219_mode {
 };
 
 static const struct cci_reg_sequence imx219_common_regs[] = {
-	{ CCI_REG8(0x0100), 0x00 },	/* Mode Select */
+	{ IMX219_REG_MODE_SELECT, 0x00 },	/* Mode Select */
 
 	/* To Access Addresses 3000-5fff, send the following commands */
 	{ CCI_REG8(0x30eb), 0x0c },
@@ -165,15 +196,13 @@ static const struct cci_reg_sequence imx219_common_regs[] = {
 	{ CCI_REG8(0x30eb), 0x09 },
 
 	/* PLL Clock Table */
-	{ CCI_REG8(0x0301), 0x05 },	/* VTPXCK_DIV */
-	{ CCI_REG8(0x0303), 0x01 },	/* VTSYSCK_DIV */
-	{ CCI_REG8(0x0304), 0x03 },	/* PREPLLCK_VT_DIV 0x03 = AUTO set */
-	{ CCI_REG8(0x0305), 0x03 },	/* PREPLLCK_OP_DIV 0x03 = AUTO set */
-	{ CCI_REG8(0x0306), 0x00 },	/* PLL_VT_MPY */
-	{ CCI_REG8(0x0307), 0x39 },
-	{ CCI_REG8(0x030b), 0x01 },	/* OP_SYS_CLK_DIV */
-	{ CCI_REG8(0x030c), 0x00 },	/* PLL_OP_MPY */
-	{ CCI_REG8(0x030d), 0x72 },
+	{ IMX219_REG_VTPXCK_DIV, 5 },
+	{ IMX219_REG_VTSYCK_DIV, 1 },
+	{ IMX219_REG_PREPLLCK_VT_DIV, 3 },	/* 0x03 = AUTO set */
+	{ IMX219_REG_PREPLLCK_OP_DIV, 3 },	/* 0x03 = AUTO set */
+	{ IMX219_REG_PLL_VT_MPY, 57 },
+	{ IMX219_REG_OPSYCK_DIV, 1 },
+	{ IMX219_REG_PLL_OP_MPY, 114 },
 
 	/* Undocumented registers */
 	{ CCI_REG8(0x455e), 0x00 },
@@ -190,16 +219,14 @@ static const struct cci_reg_sequence imx219_common_regs[] = {
 	{ CCI_REG8(0x479b), 0x0e },
 
 	/* Frame Bank Register Group "A" */
-	{ CCI_REG8(0x0162), 0x0d },	/* Line_Length_A */
-	{ CCI_REG8(0x0163), 0x78 },
-	{ CCI_REG8(0x0170), 0x01 },	/* X_ODD_INC_A */
-	{ CCI_REG8(0x0171), 0x01 },	/* Y_ODD_INC_A */
+	{ IMX219_REG_LINE_LENGTH_A, 3448 },
+	{ IMX219_REG_X_ODD_INC_A, 1 },
+	{ IMX219_REG_Y_ODD_INC_A, 1 },
 
 	/* Output setup registers */
-	{ CCI_REG8(0x0114), 0x01 },	/* CSI 2-Lane Mode */
-	{ CCI_REG8(0x0128), 0x00 },	/* DPHY Auto Mode */
-	{ CCI_REG8(0x012a), 0x18 },	/* EXCK_Freq */
-	{ CCI_REG8(0x012b), 0x00 },
+	{ IMX219_REG_CSI_LANE_MODE, IMX219_CSI_2_LANE_MODE },
+	{ IMX219_REG_DPHY_CTRL, IMX219_DPHY_CTRL_TIMING_AUTO },
+	{ IMX219_REG_EXCK_FREQ, IMX219_EXCK_FREQ(IMX219_XCLK_FREQ / 1000000) },
 };
 
 /*
@@ -208,91 +235,57 @@ static const struct cci_reg_sequence imx219_common_regs[] = {
  * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
  */
 static const struct cci_reg_sequence mode_3280x2464_regs[] = {
-	{ CCI_REG8(0x0164), 0x00 },
-	{ CCI_REG8(0x0165), 0x00 },
-	{ CCI_REG8(0x0166), 0x0c },
-	{ CCI_REG8(0x0167), 0xcf },
-	{ CCI_REG8(0x0168), 0x00 },
-	{ CCI_REG8(0x0169), 0x00 },
-	{ CCI_REG8(0x016a), 0x09 },
-	{ CCI_REG8(0x016b), 0x9f },
-	{ CCI_REG8(0x016c), 0x0c },
-	{ CCI_REG8(0x016d), 0xd0 },
-	{ CCI_REG8(0x016e), 0x09 },
-	{ CCI_REG8(0x016f), 0xa0 },
-	{ CCI_REG8(0x0624), 0x0c },
-	{ CCI_REG8(0x0625), 0xd0 },
-	{ CCI_REG8(0x0626), 0x09 },
-	{ CCI_REG8(0x0627), 0xa0 },
+	{ IMX219_REG_X_ADD_STA_A, 0 },
+	{ IMX219_REG_X_ADD_END_A, 3279 },
+	{ IMX219_REG_Y_ADD_STA_A, 0 },
+	{ IMX219_REG_Y_ADD_END_A, 2463 },
+	{ IMX219_REG_X_OUTPUT_SIZE, 3280 },
+	{ IMX219_REG_Y_OUTPUT_SIZE, 2464 },
+	{ IMX219_REG_TP_WINDOW_WIDTH, 3280 },
+	{ IMX219_REG_TP_WINDOW_HEIGHT, 2464 },
 };
 
 static const struct cci_reg_sequence mode_1920_1080_regs[] = {
-	{ CCI_REG8(0x0164), 0x02 },
-	{ CCI_REG8(0x0165), 0xa8 },
-	{ CCI_REG8(0x0166), 0x0a },
-	{ CCI_REG8(0x0167), 0x27 },
-	{ CCI_REG8(0x0168), 0x02 },
-	{ CCI_REG8(0x0169), 0xb4 },
-	{ CCI_REG8(0x016a), 0x06 },
-	{ CCI_REG8(0x016b), 0xeb },
-	{ CCI_REG8(0x016c), 0x07 },
-	{ CCI_REG8(0x016d), 0x80 },
-	{ CCI_REG8(0x016e), 0x04 },
-	{ CCI_REG8(0x016f), 0x38 },
-	{ CCI_REG8(0x0624), 0x07 },
-	{ CCI_REG8(0x0625), 0x80 },
-	{ CCI_REG8(0x0626), 0x04 },
-	{ CCI_REG8(0x0627), 0x38 },
+	{ IMX219_REG_X_ADD_STA_A, 680 },
+	{ IMX219_REG_X_ADD_END_A, 2599 },
+	{ IMX219_REG_Y_ADD_STA_A, 692 },
+	{ IMX219_REG_Y_ADD_END_A, 1771 },
+	{ IMX219_REG_X_OUTPUT_SIZE, 1920 },
+	{ IMX219_REG_Y_OUTPUT_SIZE, 1080 },
+	{ IMX219_REG_TP_WINDOW_WIDTH, 1920 },
+	{ IMX219_REG_TP_WINDOW_HEIGHT, 1080 },
 };
 
 static const struct cci_reg_sequence mode_1640_1232_regs[] = {
-	{ CCI_REG8(0x0164), 0x00 },
-	{ CCI_REG8(0x0165), 0x00 },
-	{ CCI_REG8(0x0166), 0x0c },
-	{ CCI_REG8(0x0167), 0xcf },
-	{ CCI_REG8(0x0168), 0x00 },
-	{ CCI_REG8(0x0169), 0x00 },
-	{ CCI_REG8(0x016a), 0x09 },
-	{ CCI_REG8(0x016b), 0x9f },
-	{ CCI_REG8(0x016c), 0x06 },
-	{ CCI_REG8(0x016d), 0x68 },
-	{ CCI_REG8(0x016e), 0x04 },
-	{ CCI_REG8(0x016f), 0xd0 },
-	{ CCI_REG8(0x0624), 0x06 },
-	{ CCI_REG8(0x0625), 0x68 },
-	{ CCI_REG8(0x0626), 0x04 },
-	{ CCI_REG8(0x0627), 0xd0 },
+	{ IMX219_REG_X_ADD_STA_A, 0 },
+	{ IMX219_REG_X_ADD_END_A, 3279 },
+	{ IMX219_REG_Y_ADD_STA_A, 0 },
+	{ IMX219_REG_Y_ADD_END_A, 2463 },
+	{ IMX219_REG_X_OUTPUT_SIZE, 1640 },
+	{ IMX219_REG_Y_OUTPUT_SIZE, 1232 },
+	{ IMX219_REG_TP_WINDOW_WIDTH, 1640 },
+	{ IMX219_REG_TP_WINDOW_HEIGHT, 1232 },
 };
 
 static const struct cci_reg_sequence mode_640_480_regs[] = {
-	{ CCI_REG8(0x0164), 0x03 },
-	{ CCI_REG8(0x0165), 0xe8 },
-	{ CCI_REG8(0x0166), 0x08 },
-	{ CCI_REG8(0x0167), 0xe7 },
-	{ CCI_REG8(0x0168), 0x02 },
-	{ CCI_REG8(0x0169), 0xf0 },
-	{ CCI_REG8(0x016a), 0x06 },
-	{ CCI_REG8(0x016b), 0xaf },
-	{ CCI_REG8(0x016c), 0x02 },
-	{ CCI_REG8(0x016d), 0x80 },
-	{ CCI_REG8(0x016e), 0x01 },
-	{ CCI_REG8(0x016f), 0xe0 },
-	{ CCI_REG8(0x0624), 0x06 },
-	{ CCI_REG8(0x0625), 0x68 },
-	{ CCI_REG8(0x0626), 0x04 },
-	{ CCI_REG8(0x0627), 0xd0 },
+	{ IMX219_REG_X_ADD_STA_A, 1000 },
+	{ IMX219_REG_X_ADD_END_A, 2279 },
+	{ IMX219_REG_Y_ADD_STA_A, 752 },
+	{ IMX219_REG_Y_ADD_END_A, 1711 },
+	{ IMX219_REG_X_OUTPUT_SIZE, 640 },
+	{ IMX219_REG_Y_OUTPUT_SIZE, 480 },
+	{ IMX219_REG_TP_WINDOW_WIDTH, 1640 },
+	{ IMX219_REG_TP_WINDOW_HEIGHT, 1232 },
 };
 
 static const struct cci_reg_sequence raw8_framefmt_regs[] = {
-	{ CCI_REG8(0x018c), 0x08 },
-	{ CCI_REG8(0x018d), 0x08 },
-	{ CCI_REG8(0x0309), 0x08 },
+	{ IMX219_REG_CSI_DATA_FORMAT_A, 0x0808 },
+	{ IMX219_REG_OPPXCK_DIV, 8 },
 };
 
 static const struct cci_reg_sequence raw10_framefmt_regs[] = {
-	{ CCI_REG8(0x018c), 0x0a },
-	{ CCI_REG8(0x018d), 0x0a },
-	{ CCI_REG8(0x0309), 0x0a },
+	{ IMX219_REG_CSI_DATA_FORMAT_A, 0x0a0a },
+	{ IMX219_REG_OPPXCK_DIV, 10 },
 };
 
 static const s64 imx219_link_freq_menu[] = {
-- 
2.42.0



