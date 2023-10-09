Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984F87BDF48
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376670AbjJIN2W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376821AbjJIN2V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:28:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25BC5
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:28:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9A4C433C8;
        Mon,  9 Oct 2023 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858096;
        bh=4Cz+vTaK7K/GFT+WsOQZ8URSML/iWytNJw20OZSvxAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMS3uMkkKc3MXuZMFvRV7uVnRFirlB+TinmD3WEAIj5KUEOXxBsbpJdO5b53E1PBK
         PPZAd5cy7waGE5w2XVbkXQ2JNc+uJ8mM5SPMBT013RV1dQl+alte0SRtTBIU0V8cGC
         HfO48SKmjeeQbJS6GEakGTzu7cZKs5AC5G8ty9Iw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Szuying Chen <Chloe_Chen@asmedia.com.tw>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 004/131] ata: libahci: clear pending interrupt status
Date:   Mon,  9 Oct 2023 15:00:44 +0200
Message-ID: <20231009130116.465060932@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Szuying Chen <chensiying21@gmail.com>

[ Upstream commit 737dd811a3dbfd7edd4ad2ba5152e93d99074f83 ]

When a CRC error occurs, the HBA asserts an interrupt to indicate an
interface fatal error (PxIS.IFS). The ISR clears PxIE and PxIS, then
does error recovery. If the adapter receives another SDB FIS
with an error (PxIS.TFES) from the device before the start of the EH
recovery process, the interrupt signaling the new SDB cannot be
serviced as PxIE was cleared already. This in turn results in the HBA
inability to issue any command during the error recovery process after
setting PxCMD.ST to 1 because PxIS.TFES is still set.

According to AHCI 1.3.1 specifications section 6.2.2, fatal errors
notified by setting PxIS.HBFS, PxIS.HBDS, PxIS.IFS or PxIS.TFES will
cause the HBA to enter the ERR:Fatal state. In this state, the HBA
shall not issue any new commands.

To avoid this situation, introduce the function
ahci_port_clear_pending_irq() to clear pending interrupts before
executing a COMRESET. This follows the AHCI 1.3.1 - section 6.2.2.2
specification.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
Fixes: e0bfd149973d ("[PATCH] ahci: stop engine during hard reset")
Cc: stable@vger.kernel.org
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libahci.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index fec2e9754aed2..61b5ba8dc1d21 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1199,6 +1199,26 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
 	return sprintf(buf, "%d\n", emp->blink_policy);
 }
 
+static void ahci_port_clear_pending_irq(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp;
+
+	/* clear SError */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	dev_dbg(ap->host->dev, "PORT_SCR_ERR 0x%x\n", tmp);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* clear port IRQ */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	dev_dbg(ap->host->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
+	if (tmp)
+		writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+	writel(1 << ap->port_no, hpriv->mmio + HOST_IRQ_STAT);
+}
+
 static void ahci_port_init(struct device *dev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
@@ -1213,18 +1233,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 	if (rc)
 		dev_warn(dev, "%s (%d)\n", emsg, rc);
 
-	/* clear SError */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
-
-	/* clear port IRQ */
-	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
-	if (tmp)
-		writel(tmp, port_mmio + PORT_IRQ_STAT);
-
-	writel(1 << port_no, mmio + HOST_IRQ_STAT);
+	ahci_port_clear_pending_irq(ap);
 
 	/* mark esata ports */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -1554,6 +1563,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.command = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
+	ahci_port_clear_pending_irq(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
 
-- 
2.40.1



