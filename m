Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284797A2FFA
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbjIPMXu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbjIPMXb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:23:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3738CCC1
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:23:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB07C433C7;
        Sat, 16 Sep 2023 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867005;
        bh=z5pQCgQT7euzrcTHNwC4KjtrqzA6KhFhxIA/fQq7CFA=;
        h=Subject:To:Cc:From:Date:From;
        b=nQR04V4mIJeep5IIZBuemlIDrcJ6xPUjvbJ26tUhmLVxrGPtnd+9msQwFcIEPKkCa
         BOFkgCTYzcyzFoEuglBfg9X5o/1j/ZhSSUgKnajAhLFdd+WrsOwI+6/Qi3hFVKhUdX
         KM7wZQe6y1HUMF3gHn+8PRR4n8ChcUg6ZdfKR7KA=
Subject: FAILED: patch "[PATCH] mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT" failed to apply to 6.1-stable tree
To:     Takahiro.Kuwano@infineon.com, tudor.ambarus@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:22:59 +0200
Message-ID: <2023091659-unguarded-greeting-7dbb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1e611e104b9acb6310b8c684d5acee0e11ca7bd1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091659-unguarded-greeting-7dbb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

1e611e104b9a ("mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT")
d534fd9787d5 ("mtd: spi-nor: spansion: use CLPEF as an alternative to CLSR")
4095f4d9225a ("mtd: spi-nor: Fix divide by zero for spi-nor-generic flashes")
df6def86b9dc ("mtd: spi-nor: spansion: Add support for s25hl02gt and s25hs02gt")
91f3c430f622 ("mtd: spi-nor: spansion: Add a new ->ready() hook for multi-chip device")
6c01ae11130c ("mtd: spi-nor: spansion: Rework cypress_nor_get_page_size() for multi-chip device support")
e570f7872a34 ("mtd: spi-nor: Allow post_sfdp hook to return errors")
120c94a67b26 ("mtd: spi-nor: spansion: Rename method to cypress_nor_get_page_size")
a9180c298d35 ("mtd: spi-nor: spansion: Enable JFFS2 write buffer for S25FS256T")
4199c1719e24 ("mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s25hx SEMPER flash")
9fd0945fe6fa ("mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s28hx SEMPER flash")
c87c9b11c53c ("mtd: spi-nor: spansion: Determine current address mode")
4e53ab0c292d ("mtd: spi-nor: Set the 4-Byte Address Mode method based on SFDP data")
d75c22f376f6 ("mtd: spi-nor: core: Update name and description of spi_nor_set_4byte_addr_mode")
f1f1976224f3 ("mtd: spi-nor: core: Update name and description of spansion_set_4byte_addr_mode")
288df4378319 ("mtd: spi-nor: core: Update name and description of micron_st_nor_set_4byte_addr_mode")
076aa4eac8b3 ("mtd: spi-nor: core: Move generic method to core - micron_st_nor_set_4byte_addr_mode")
79a4db50192c ("mtd: spi-nor: Delay the initialization of bank_size")
4eddee70140b ("mtd: spi-nor: Add a RWW flag")
6afcc84080c4 ("mtd: spi-nor: spansion: Add support for Infineon S25FS256T")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e611e104b9acb6310b8c684d5acee0e11ca7bd1 Mon Sep 17 00:00:00 2001
From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Wed, 26 Jul 2023 10:52:48 +0300
Subject: [PATCH] mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT

CFR2V[7] is assigned to Flash's address mode (3- or 4-ybte) and must not
be changed when writing MEMLAT (CFR2V[3:0]). CFR2V shall be used in a read,
update, write back fashion.

Fixes: c3266af101f2 ("mtd: spi-nor: spansion: add support for Cypress Semper flash")
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230726075257.12985-3-tudor.ambarus@linaro.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 6b2532ed053c..6460d2247bdf 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2014, Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/mtd/spi-nor.h>
 
@@ -28,6 +29,7 @@
 #define SPINOR_REG_CYPRESS_CFR2			0x3
 #define SPINOR_REG_CYPRESS_CFR2V					\
 	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR2)
+#define SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK	GENMASK(3, 0)
 #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
 #define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
 #define SPINOR_REG_CYPRESS_CFR3			0x4
@@ -161,8 +163,18 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	int ret;
 	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
 
+	op = (struct spi_mem_op)
+		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes,
+					  SPINOR_REG_CYPRESS_CFR2V, 0, buf);
+
+	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
+
 	/* Use 24 dummy cycles for memory array reads. */
-	*buf = SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24;
+	*buf &= ~SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK;
+	*buf |= FIELD_PREP(SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK,
+			   SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24);
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
 					  SPINOR_REG_CYPRESS_CFR2V, 1, buf);

