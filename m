Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDEF6FA607
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjEHKPa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjEHKPZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46673513D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3976862475
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50081C433D2;
        Mon,  8 May 2023 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540923;
        bh=yyXvubOl0Lqw6wg/6U4TJZLynShHOBkAUwmQ0uv7Q0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5qBafN8dwta0g5t6tzcAr88AWNIALDgx96BdfJYwokzDRO+aCkGXBC7hLf5c3Bcc
         WvzYSY+4JS1x8keeVYunoe+SDbff9uHcyLA45kb36pJUBxTuWJ10Fk0qVF+N0dqguO
         gKSZlCyBaRkQ6DTR+XVYkR4LKGw4M+QwAtt9Lfo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Andrew Lunn <andrew@lunn.ch>, Lee Jones <lee@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 548/611] mfd: tqmx86: Correct board names for TQMxE39x
Date:   Mon,  8 May 2023 11:46:30 +0200
Message-Id: <20230508094439.818300112@linuxfoundation.org>
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

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

[ Upstream commit f376c479668557bcc2fd9e9fbc0f53e7819a11cd ]

It seems that this driver was developed based on preliminary documentation.
Report the correct names for all TQMxE39x variants, as they are used by
the released hardware revisions:

- Fix names for TQMxE39C1/C2 board IDs
- Distinguish TQMxE39M and TQMxE39S, which use the same board ID

The TQMxE39M/S are distinguished using the SAUC (Sanctioned Alternate
Uses Configuration) register of the GPIO controller. This also prepares
for the correct handling of the differences between the GPIO controllers
of our COMe and SMARC modules.

Fixes: 2f17dd34ffed ("mfd: tqmx86: IO controller with I2C, Wachdog and GPIO")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/aca9a7cb42a85181bcb456c437554d2728e708ec.1676892223.git.matthias.schiffer@ew.tq-group.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tqmx86.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 958334f14eb00..fac02875fe7d9 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -30,9 +30,9 @@
 #define TQMX86_REG_BOARD_ID_50UC	2
 #define TQMX86_REG_BOARD_ID_E38C	3
 #define TQMX86_REG_BOARD_ID_60EB	4
-#define TQMX86_REG_BOARD_ID_E39M	5
-#define TQMX86_REG_BOARD_ID_E39C	6
-#define TQMX86_REG_BOARD_ID_E39x	7
+#define TQMX86_REG_BOARD_ID_E39MS	5
+#define TQMX86_REG_BOARD_ID_E39C1	6
+#define TQMX86_REG_BOARD_ID_E39C2	7
 #define TQMX86_REG_BOARD_ID_70EB	8
 #define TQMX86_REG_BOARD_ID_80UC	9
 #define TQMX86_REG_BOARD_ID_110EB	11
@@ -48,6 +48,7 @@
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
+#define TQMX86_REG_SAUC		0x17
 
 #define TQMX86_REG_I2C_DETECT	0x1a7
 #define TQMX86_REG_I2C_DETECT_SOFT		0xa5
@@ -110,7 +111,7 @@ static const struct mfd_cell tqmx86_devs[] = {
 	},
 };
 
-static const char *tqmx86_board_id_to_name(u8 board_id)
+static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 {
 	switch (board_id) {
 	case TQMX86_REG_BOARD_ID_E38M:
@@ -121,12 +122,12 @@ static const char *tqmx86_board_id_to_name(u8 board_id)
 		return "TQMxE38C";
 	case TQMX86_REG_BOARD_ID_60EB:
 		return "TQMx60EB";
-	case TQMX86_REG_BOARD_ID_E39M:
-		return "TQMxE39M";
-	case TQMX86_REG_BOARD_ID_E39C:
-		return "TQMxE39C";
-	case TQMX86_REG_BOARD_ID_E39x:
-		return "TQMxE39x";
+	case TQMX86_REG_BOARD_ID_E39MS:
+		return (sauc == 0xff) ? "TQMxE39M" : "TQMxE39S";
+	case TQMX86_REG_BOARD_ID_E39C1:
+		return "TQMxE39C1";
+	case TQMX86_REG_BOARD_ID_E39C2:
+		return "TQMxE39C2";
 	case TQMX86_REG_BOARD_ID_70EB:
 		return "TQMx70EB";
 	case TQMX86_REG_BOARD_ID_80UC:
@@ -159,9 +160,9 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	case TQMX86_REG_BOARD_ID_E40C1:
 	case TQMX86_REG_BOARD_ID_E40C2:
 		return 24000;
-	case TQMX86_REG_BOARD_ID_E39M:
-	case TQMX86_REG_BOARD_ID_E39C:
-	case TQMX86_REG_BOARD_ID_E39x:
+	case TQMX86_REG_BOARD_ID_E39MS:
+	case TQMX86_REG_BOARD_ID_E39C1:
+	case TQMX86_REG_BOARD_ID_E39C2:
 		return 25000;
 	case TQMX86_REG_BOARD_ID_E38M:
 	case TQMX86_REG_BOARD_ID_E38C:
@@ -175,7 +176,7 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 
 static int tqmx86_probe(struct platform_device *pdev)
 {
-	u8 board_id, rev, i2c_det, io_ext_int_val;
+	u8 board_id, sauc, rev, i2c_det, io_ext_int_val;
 	struct device *dev = &pdev->dev;
 	u8 gpio_irq_cfg, readback;
 	const char *board_name;
@@ -205,7 +206,8 @@ static int tqmx86_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	board_id = ioread8(io_base + TQMX86_REG_BOARD_ID);
-	board_name = tqmx86_board_id_to_name(board_id);
+	sauc = ioread8(io_base + TQMX86_REG_SAUC);
+	board_name = tqmx86_board_id_to_name(board_id, sauc);
 	rev = ioread8(io_base + TQMX86_REG_BOARD_REV);
 
 	dev_info(dev,
-- 
2.39.2



