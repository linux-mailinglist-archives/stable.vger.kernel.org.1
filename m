Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106C27A7F0A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjITMXS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjITMXS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:23:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7287D83
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:23:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABD6C433C7;
        Wed, 20 Sep 2023 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212592;
        bh=lej5Y3UbbLEbgzqiShF1txZf8rPGelK4oLK/WxQ9eS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okjpJ5Y7NBDq0I/vZVL1TEWLPcWNN2/DS5I9cBi4aw4Mqyl9rZLTCrw02U+tEdKym
         zx2SAKIstTRUvGtOm574RJeWKt766uqTqbf4JA6yi9w5P4M3l/0IpKzZk46ipgba4z
         ALBgZ65JoeXO0y14G7TGUO9DZ1NX77h849CLUfvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 51/83] mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller
Date:   Wed, 20 Sep 2023 13:31:41 +0200
Message-ID: <20230920112828.675034478@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Zhang <william.zhang@broadcom.com>

[ Upstream commit 2ec2839a9062db8a592525a3fdabd42dcd9a3a9b ]

v7.2 controller has different ECC level field size and shift in the acc
control register than its predecessor and successor controller. It needs
to be set specifically.

Fixes: decba6d47869 ("mtd: brcmnand: Add v7.2 controller support")
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-2-william.zhang@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 74 +++++++++++++-----------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 9ef58194d3a04..11d706ff30dd0 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -268,6 +268,7 @@ struct brcmnand_controller {
 	const unsigned int	*page_sizes;
 	unsigned int		page_size_shift;
 	unsigned int		max_oob;
+	u32			ecc_level_shift;
 	u32			features;
 
 	/* for low-power standby/resume only */
@@ -592,6 +593,34 @@ enum {
 	INTFC_CTLR_READY		= BIT(31),
 };
 
+/***********************************************************************
+ * NAND ACC CONTROL bitfield
+ *
+ * Some bits have remained constant throughout hardware revision, while
+ * others have shifted around.
+ ***********************************************************************/
+
+/* Constant for all versions (where supported) */
+enum {
+	/* See BRCMNAND_HAS_CACHE_MODE */
+	ACC_CONTROL_CACHE_MODE				= BIT(22),
+
+	/* See BRCMNAND_HAS_PREFETCH */
+	ACC_CONTROL_PREFETCH				= BIT(23),
+
+	ACC_CONTROL_PAGE_HIT				= BIT(24),
+	ACC_CONTROL_WR_PREEMPT				= BIT(25),
+	ACC_CONTROL_PARTIAL_PAGE			= BIT(26),
+	ACC_CONTROL_RD_ERASED				= BIT(27),
+	ACC_CONTROL_FAST_PGM_RDIN			= BIT(28),
+	ACC_CONTROL_WR_ECC				= BIT(30),
+	ACC_CONTROL_RD_ECC				= BIT(31),
+};
+
+#define	ACC_CONTROL_ECC_SHIFT			16
+/* Only for v7.2 */
+#define	ACC_CONTROL_ECC_EXT_SHIFT		13
+
 static inline bool brcmnand_non_mmio_ops(struct brcmnand_controller *ctrl)
 {
 	return static_branch_unlikely(&brcmnand_soc_has_ops_key);
@@ -729,6 +758,12 @@ static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
 	else if (of_property_read_bool(ctrl->dev->of_node, "brcm,nand-has-wp"))
 		ctrl->features |= BRCMNAND_HAS_WP;
 
+	/* v7.2 has different ecc level shift in the acc register */
+	if (ctrl->nand_version == 0x0702)
+		ctrl->ecc_level_shift = ACC_CONTROL_ECC_EXT_SHIFT;
+	else
+		ctrl->ecc_level_shift = ACC_CONTROL_ECC_SHIFT;
+
 	return 0;
 }
 
@@ -917,30 +952,6 @@ static inline int brcmnand_cmd_shift(struct brcmnand_controller *ctrl)
 	return 0;
 }
 
-/***********************************************************************
- * NAND ACC CONTROL bitfield
- *
- * Some bits have remained constant throughout hardware revision, while
- * others have shifted around.
- ***********************************************************************/
-
-/* Constant for all versions (where supported) */
-enum {
-	/* See BRCMNAND_HAS_CACHE_MODE */
-	ACC_CONTROL_CACHE_MODE				= BIT(22),
-
-	/* See BRCMNAND_HAS_PREFETCH */
-	ACC_CONTROL_PREFETCH				= BIT(23),
-
-	ACC_CONTROL_PAGE_HIT				= BIT(24),
-	ACC_CONTROL_WR_PREEMPT				= BIT(25),
-	ACC_CONTROL_PARTIAL_PAGE			= BIT(26),
-	ACC_CONTROL_RD_ERASED				= BIT(27),
-	ACC_CONTROL_FAST_PGM_RDIN			= BIT(28),
-	ACC_CONTROL_WR_ECC				= BIT(30),
-	ACC_CONTROL_RD_ECC				= BIT(31),
-};
-
 static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *ctrl)
 {
 	if (ctrl->nand_version == 0x0702)
@@ -953,18 +964,15 @@ static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *ctrl)
 		return GENMASK(4, 0);
 }
 
-#define NAND_ACC_CONTROL_ECC_SHIFT	16
-#define NAND_ACC_CONTROL_ECC_EXT_SHIFT	13
-
 static inline u32 brcmnand_ecc_level_mask(struct brcmnand_controller *ctrl)
 {
 	u32 mask = (ctrl->nand_version >= 0x0600) ? 0x1f : 0x0f;
 
-	mask <<= NAND_ACC_CONTROL_ECC_SHIFT;
+	mask <<= ACC_CONTROL_ECC_SHIFT;
 
 	/* v7.2 includes additional ECC levels */
-	if (ctrl->nand_version >= 0x0702)
-		mask |= 0x7 << NAND_ACC_CONTROL_ECC_EXT_SHIFT;
+	if (ctrl->nand_version == 0x0702)
+		mask |= 0x7 << ACC_CONTROL_ECC_EXT_SHIFT;
 
 	return mask;
 }
@@ -978,8 +986,8 @@ static void brcmnand_set_ecc_enabled(struct brcmnand_host *host, int en)
 
 	if (en) {
 		acc_control |= ecc_flags; /* enable RD/WR ECC */
-		acc_control |= host->hwcfg.ecc_level
-			       << NAND_ACC_CONTROL_ECC_SHIFT;
+		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
+		acc_control |= host->hwcfg.ecc_level << ctrl->ecc_level_shift;
 	} else {
 		acc_control &= ~ecc_flags; /* disable RD/WR ECC */
 		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
@@ -2533,7 +2541,7 @@ static int brcmnand_set_cfg(struct brcmnand_host *host,
 	tmp &= ~brcmnand_ecc_level_mask(ctrl);
 	tmp &= ~brcmnand_spare_area_mask(ctrl);
 	if (ctrl->nand_version >= 0x0302) {
-		tmp |= cfg->ecc_level << NAND_ACC_CONTROL_ECC_SHIFT;
+		tmp |= cfg->ecc_level << ctrl->ecc_level_shift;
 		tmp |= cfg->spare_area_size;
 	}
 	nand_writereg(ctrl, acc_control_offs, tmp);
-- 
2.40.1



