Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8B97A7F27
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbjITMYf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjITMYe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:24:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C8A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:24:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C474EC433CA;
        Wed, 20 Sep 2023 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212668;
        bh=ENHGCWHgC0eOzUUnbjuSiOnobEA5yVJKDeC1UhOtGlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjJehBWRvRtwhdiCi+fzCEgBouEzJmoOhAL1vIaogTbr4LGlHsJXdNiVBXSZokEmi
         J6KuNtciinh3wIbjv4XntETPIK9R/gMR5y7Y7Avb6hUc66JWcKC7C8lVxOZcWgYeAS
         ZeJhe74i191ntNlD04zvSsS+fXR5jWZq3W6p78Zo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 50/83] mtd: rawnand: brcmnand: Allow SoC to provide I/O operations
Date:   Wed, 20 Sep 2023 13:31:40 +0200
Message-ID: <20230920112828.635735710@linuxfoundation.org>
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

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 25f97138f8c225dbf365b428a94d7b30a6daefb3 ]

Allow a brcmnand_soc instance to provide a custom set of I/O operations
which we will require when using this driver on a BCMA bus which is not
directly memory mapped I/O. Update the nand_{read,write}_reg accordingly
to use the SoC operations if provided.

To minimize the penalty on other SoCs which do support standard MMIO
accesses, we use a static key which is disabled by default and gets
enabled if a soc implementation does provide I/O operations.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20220107184614.2670254-3-f.fainelli@gmail.com
Stable-dep-of: 2ec2839a9062 ("mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 28 +++++++++++++++++++++--
 drivers/mtd/nand/raw/brcmnand/brcmnand.h | 29 ++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index e170c545fec50..9ef58194d3a04 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include <linux/static_key.h>
 #include <linux/list.h>
 #include <linux/log2.h>
 
@@ -207,6 +208,8 @@ enum {
 
 struct brcmnand_host;
 
+static DEFINE_STATIC_KEY_FALSE(brcmnand_soc_has_ops_key);
+
 struct brcmnand_controller {
 	struct device		*dev;
 	struct nand_controller	controller;
@@ -589,15 +592,25 @@ enum {
 	INTFC_CTLR_READY		= BIT(31),
 };
 
+static inline bool brcmnand_non_mmio_ops(struct brcmnand_controller *ctrl)
+{
+	return static_branch_unlikely(&brcmnand_soc_has_ops_key);
+}
+
 static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)
 {
+	if (brcmnand_non_mmio_ops(ctrl))
+		return brcmnand_soc_read(ctrl->soc, offs);
 	return brcmnand_readl(ctrl->nand_base + offs);
 }
 
 static inline void nand_writereg(struct brcmnand_controller *ctrl, u32 offs,
 				 u32 val)
 {
-	brcmnand_writel(val, ctrl->nand_base + offs);
+	if (brcmnand_non_mmio_ops(ctrl))
+		brcmnand_soc_write(ctrl->soc, val, offs);
+	else
+		brcmnand_writel(val, ctrl->nand_base + offs);
 }
 
 static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
@@ -763,13 +776,18 @@ static inline void brcmnand_rmw_reg(struct brcmnand_controller *ctrl,
 
 static inline u32 brcmnand_read_fc(struct brcmnand_controller *ctrl, int word)
 {
+	if (brcmnand_non_mmio_ops(ctrl))
+		return brcmnand_soc_read(ctrl->soc, BRCMNAND_NON_MMIO_FC_ADDR);
 	return __raw_readl(ctrl->nand_fc + word * 4);
 }
 
 static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
 				     int word, u32 val)
 {
-	__raw_writel(val, ctrl->nand_fc + word * 4);
+	if (brcmnand_non_mmio_ops(ctrl))
+		brcmnand_soc_write(ctrl->soc, val, BRCMNAND_NON_MMIO_FC_ADDR);
+	else
+		__raw_writel(val, ctrl->nand_fc + word * 4);
 }
 
 static inline void edu_writel(struct brcmnand_controller *ctrl,
@@ -2985,6 +3003,12 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	dev_set_drvdata(dev, ctrl);
 	ctrl->dev = dev;
 
+	/* Enable the static key if the soc provides I/O operations indicating
+	 * that a non-memory mapped IO access path must be used
+	 */
+	if (brcmnand_soc_has_ops(ctrl->soc))
+		static_branch_enable(&brcmnand_soc_has_ops_key);
+
 	init_completion(&ctrl->done);
 	init_completion(&ctrl->dma_done);
 	init_completion(&ctrl->edu_done);
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
index eb498fbe505ec..f1f93d85f50d2 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
@@ -11,12 +11,25 @@
 
 struct platform_device;
 struct dev_pm_ops;
+struct brcmnand_io_ops;
+
+/* Special register offset constant to intercept a non-MMIO access
+ * to the flash cache register space. This is intentionally large
+ * not to overlap with an existing offset.
+ */
+#define BRCMNAND_NON_MMIO_FC_ADDR	0xffffffff
 
 struct brcmnand_soc {
 	bool (*ctlrdy_ack)(struct brcmnand_soc *soc);
 	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
 	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
 				 bool is_param);
+	const struct brcmnand_io_ops *ops;
+};
+
+struct brcmnand_io_ops {
+	u32 (*read_reg)(struct brcmnand_soc *soc, u32 offset);
+	void (*write_reg)(struct brcmnand_soc *soc, u32 val, u32 offset);
 };
 
 static inline void brcmnand_soc_data_bus_prepare(struct brcmnand_soc *soc,
@@ -58,6 +71,22 @@ static inline void brcmnand_writel(u32 val, void __iomem *addr)
 		writel_relaxed(val, addr);
 }
 
+static inline bool brcmnand_soc_has_ops(struct brcmnand_soc *soc)
+{
+	return soc && soc->ops && soc->ops->read_reg && soc->ops->write_reg;
+}
+
+static inline u32 brcmnand_soc_read(struct brcmnand_soc *soc, u32 offset)
+{
+	return soc->ops->read_reg(soc, offset);
+}
+
+static inline void brcmnand_soc_write(struct brcmnand_soc *soc, u32 val,
+				      u32 offset)
+{
+	soc->ops->write_reg(soc, val, offset);
+}
+
 int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc);
 int brcmnand_remove(struct platform_device *pdev);
 
-- 
2.40.1



