Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3774C2DF
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjGILZp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGILZo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:25:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51504186
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBB5F60BD8
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADD0C433C7;
        Sun,  9 Jul 2023 11:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901942;
        bh=IqcS2cZQRVrAGu5W/39d2xEMbM6OyWpMZrLY7NjONjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4vn0tNhMJLABSflmQiWqFDELF4W0FI9dJ1gBjfs5k8ymeWUregCDU3lrLZf0JuPz
         ddopodcnv+ucBuM1ZyXFbSf2rcCj+sjtuygUL+oIFrph/5X4avQzRuLS1EQ6XMQkQK
         WKPi0PsJ2ctZ/jKBy2ls6bZG8vdCwXuN7RhkODkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 182/431] clk: rs9: Check for vendor/device ID
Date:   Sun,  9 Jul 2023 13:12:10 +0200
Message-ID: <20230709111455.446897341@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit da751726ff2ad2322d81316ebf6aadb22dfad0d8 ]

This is in preparation to support additional devices which have different
IDs as well as a slightly different register layout.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Link: https://lore.kernel.org/r/20230310075535.3476580-1-alexander.stein@ew.tq-group.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: ad527ca87e4e ("clk: rs9: Fix .driver_data content in i2c_device_id")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-renesas-pcie.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index ff3a52d484790..f4e9f70f412af 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -45,6 +45,13 @@
 #define RS9_REG_DID				0x6
 #define RS9_REG_BCP				0x7
 
+#define RS9_REG_VID_IDT				0x01
+
+#define RS9_REG_DID_TYPE_FGV			(0x0 << RS9_REG_DID_TYPE_SHIFT)
+#define RS9_REG_DID_TYPE_DBV			(0x1 << RS9_REG_DID_TYPE_SHIFT)
+#define RS9_REG_DID_TYPE_DMV			(0x2 << RS9_REG_DID_TYPE_SHIFT)
+#define RS9_REG_DID_TYPE_SHIFT			0x6
+
 /* Supported Renesas 9-series models. */
 enum rs9_model {
 	RENESAS_9FGV0241,
@@ -54,6 +61,7 @@ enum rs9_model {
 struct rs9_chip_info {
 	const enum rs9_model	model;
 	unsigned int		num_clks;
+	u8			did;
 };
 
 struct rs9_driver_data {
@@ -270,6 +278,7 @@ static int rs9_probe(struct i2c_client *client)
 {
 	unsigned char name[5] = "DIF0";
 	struct rs9_driver_data *rs9;
+	unsigned int vid, did;
 	struct clk_hw *hw;
 	int i, ret;
 
@@ -306,6 +315,20 @@ static int rs9_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = regmap_read(rs9->regmap, RS9_REG_VID, &vid);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(rs9->regmap, RS9_REG_DID, &did);
+	if (ret < 0)
+		return ret;
+
+	if (vid != RS9_REG_VID_IDT || did != rs9->chip_info->did)
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "Incorrect VID/DID: %#02x, %#02x. Expected %#02x, %#02x\n",
+				     vid, did, RS9_REG_VID_IDT,
+				     rs9->chip_info->did);
+
 	/* Register clock */
 	for (i = 0; i < rs9->chip_info->num_clks; i++) {
 		snprintf(name, 5, "DIF%d", i);
@@ -349,6 +372,7 @@ static int __maybe_unused rs9_resume(struct device *dev)
 static const struct rs9_chip_info renesas_9fgv0241_info = {
 	.model		= RENESAS_9FGV0241,
 	.num_clks	= 2,
+	.did		= RS9_REG_DID_TYPE_FGV | 0x02,
 };
 
 static const struct i2c_device_id rs9_id[] = {
-- 
2.39.2



