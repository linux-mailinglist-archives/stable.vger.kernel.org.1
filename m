Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71A07B8739
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbjJDSDB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243720AbjJDSDA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:03:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BFAAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:02:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A2EC433C7;
        Wed,  4 Oct 2023 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442576;
        bh=C6q3LsEvRQ03VQ04GreDK1YuhiKrtIm8hKjSizp2gxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPgm5NT1gZsrLhB9EhWpEglTKLfYk9pR6K2zwraIFDF2C2gHxvWGcADjqeyzZGRRE
         KpHBiRnUr+gbcIDHr3iOFY9CVwACzFI6Dss7Blt/fnOLvDfiq3+0GXs7jKtIbsR8IT
         M7lqD/lTKwQyLU045SdA0Nxv1cm/sY48KjCF/DLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 009/183] ata: ahci: Drop pointless VPRINTK() calls and convert the remaining ones
Date:   Wed,  4 Oct 2023 19:54:00 +0200
Message-ID: <20231004175204.383374398@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 93c7711494f47f9c829321e2a8711671b02f6e4c ]

Drop pointless VPRINTK() calls for entering and existing interrupt
routines and convert the remaining calls to dev_dbg().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Stable-dep-of: 737dd811a3db ("ata: libahci: clear pending interrupt status")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c       |  4 +---
 drivers/ata/ahci_xgene.c |  4 ----
 drivers/ata/libahci.c    | 18 ++++--------------
 3 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index acc028414ee94..719fe2e2b36c2 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -707,7 +707,7 @@ static void ahci_pci_init_controller(struct ata_host *host)
 
 		/* clear port IRQ */
 		tmp = readl(port_mmio + PORT_IRQ_STAT);
-		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
+		dev_dbg(&pdev->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
 		if (tmp)
 			writel(tmp, port_mmio + PORT_IRQ_STAT);
 	}
@@ -1499,7 +1499,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 	u32 irq_stat, irq_masked;
 	unsigned int handled = 1;
 
-	VPRINTK("ENTER\n");
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 	irq_stat = readl(mmio + HOST_IRQ_STAT);
@@ -1516,7 +1515,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 		irq_stat = readl(mmio + HOST_IRQ_STAT);
 		spin_unlock(&host->lock);
 	} while (irq_stat);
-	VPRINTK("EXIT\n");
 
 	return IRQ_RETVAL(handled);
 }
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 292099410cf68..c1f61d255bc31 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -588,8 +588,6 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -612,8 +610,6 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 192115a45dd78..b591a05768744 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1216,12 +1216,12 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 
 	/* clear SError */
 	tmp = readl(port_mmio + PORT_SCR_ERR);
-	VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
+	dev_dbg(dev, "PORT_SCR_ERR 0x%x\n", tmp);
 	writel(tmp, port_mmio + PORT_SCR_ERR);
 
 	/* clear port IRQ */
 	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
+	dev_dbg(dev, "PORT_IRQ_STAT 0x%x\n", tmp);
 	if (tmp)
 		writel(tmp, port_mmio + PORT_IRQ_STAT);
 
@@ -1252,10 +1252,10 @@ void ahci_init_controller(struct ata_host *host)
 	}
 
 	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	dev_dbg(host->dev, "HOST_CTL 0x%x\n", tmp);
 	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
 	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	dev_dbg(host->dev, "HOST_CTL 0x%x\n", tmp);
 }
 EXPORT_SYMBOL_GPL(ahci_init_controller);
 
@@ -1906,8 +1906,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 status;
 
-	VPRINTK("ENTER\n");
-
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
@@ -1915,8 +1913,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	ahci_handle_port_interrupt(ap, port_mmio, status);
 	spin_unlock(ap->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_HANDLED;
 }
 
@@ -1933,9 +1929,7 @@ u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 		ap = host->ports[i];
 		if (ap) {
 			ahci_port_intr(ap);
-			VPRINTK("port %u\n", i);
 		} else {
-			VPRINTK("port %u (no irq)\n", i);
 			if (ata_ratelimit())
 				dev_warn(host->dev,
 					 "interrupt on disabled port %u\n", i);
@@ -1956,8 +1950,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -1985,8 +1977,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
-- 
2.40.1



