Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA257A7831
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjITJ51 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjITJ5Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:57:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D9BC9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:57:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D568C433C9;
        Wed, 20 Sep 2023 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695203837;
        bh=/lRuwJ8g5nRiFqUInc7wICIEdLiF6B70ebvHXa6oZ2I=;
        h=Subject:To:Cc:From:Date:From;
        b=v/qhFXEkk8uE0Ms9YvqiTu6V1A3e2qI5vKkFMlcc21RSFoQTqsgmt0eHvGi/QPynn
         71EcMUpcTACiwzNUpHckq11vDnZc0H2VtfRHGR5TL//b8ArI5lUrPpINjX/YNMSHgt
         86qtTw8PxqQBIoL80FB+IxcRpHkolQZE8anUE7pA=
Subject: FAILED: patch "[PATCH] ata: libahci: clear pending interrupt status" failed to apply to 5.15-stable tree
To:     chensiying21@gmail.com, Chloe_Chen@asmedia.com.tw,
        dlemoal@kernel.org, niklas.cassel@wdc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 11:57:14 +0200
Message-ID: <2023092014-ritzy-preaching-56d2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 737dd811a3dbfd7edd4ad2ba5152e93d99074f83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092014-ritzy-preaching-56d2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

737dd811a3db ("ata: libahci: clear pending interrupt status")
93c7711494f4 ("ata: ahci: Drop pointless VPRINTK() calls and convert the remaining ones")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 737dd811a3dbfd7edd4ad2ba5152e93d99074f83 Mon Sep 17 00:00:00 2001
From: Szuying Chen <chensiying21@gmail.com>
Date: Thu, 7 Sep 2023 16:17:10 +0800
Subject: [PATCH] ata: libahci: clear pending interrupt status

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

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e2bacedf28ef..f1263364fa97 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1256,6 +1256,26 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
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
@@ -1270,18 +1290,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 	if (rc)
 		dev_warn(dev, "%s (%d)\n", emsg, rc);
 
-	/* clear SError */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	dev_dbg(dev, "PORT_SCR_ERR 0x%x\n", tmp);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
-
-	/* clear port IRQ */
-	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	dev_dbg(dev, "PORT_IRQ_STAT 0x%x\n", tmp);
-	if (tmp)
-		writel(tmp, port_mmio + PORT_IRQ_STAT);
-
-	writel(1 << port_no, mmio + HOST_IRQ_STAT);
+	ahci_port_clear_pending_irq(ap);
 
 	/* mark esata ports */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -1603,6 +1612,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.status = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
+	ahci_port_clear_pending_irq(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
 

