Return-Path: <stable+bounces-5556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8217A80D55C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14BA1C20AB1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5EF5101B;
	Mon, 11 Dec 2023 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xVcNmhZ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA844F212;
	Mon, 11 Dec 2023 18:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6E0C433C7;
	Mon, 11 Dec 2023 18:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319036;
	bh=ABDIy7CHBUIiStB3jEwQVW3fgOjiTBuyX+lQpLpEHGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xVcNmhZ2Ir+XnQxOCmHeVD5U7lHMG3dYjsdJORtLAuc1KSgg4U/YpVtz1vYBEGY39
	 HO9kL8npLr7EiE3CuqknNI+1KlFHz5yqUZAlbgSyzCCclWn2kXzSPdtPx/PxKN98KN
	 yOn1oIzloi8tZIw7iYTTGm6vRubxaaD2+gAO+Ywk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ahmed S. Darwish" <a.darwish@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/55] net: arcnet: Fix RESET flag handling
Date: Mon, 11 Dec 2023 19:21:25 +0100
Message-ID: <20231211182012.768630607@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182012.263036284@linuxfoundation.org>
References: <20231211182012.263036284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ahmed S. Darwish <a.darwish@linutronix.de>

[ Upstream commit 01365633bd1c836240f9bbf86bbeee749795480a ]

The main arcnet interrupt handler calls arcnet_close() then
arcnet_open(), if the RESET status flag is encountered.

This is invalid:

  1) In general, interrupt handlers should never call ->ndo_stop() and
     ->ndo_open() functions. They are usually full of blocking calls and
     other methods that are expected to be called only from drivers
     init and exit code paths.

  2) arcnet_close() contains a del_timer_sync(). If the irq handler
     interrupts the to-be-deleted timer, del_timer_sync() will just loop
     forever.

  3) arcnet_close() also calls tasklet_kill(), which has a warning if
     called from irq context.

  4) For device reset, the sequence "arcnet_close(); arcnet_open();" is
     not complete.  Some children arcnet drivers have special init/exit
     code sequences, which then embed a call to arcnet_open() and
     arcnet_close() accordingly. Check drivers/net/arcnet/com20020.c.

Run the device RESET sequence from a scheduled workqueue instead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20210128194802.727770-1-a.darwish@linutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 6b17a597fc2f ("arcnet: restoring support for multiple Sohard Arcnet cards")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/arcnet/arc-rimi.c     |    4 +-
 drivers/net/arcnet/arcdevice.h    |    6 +++
 drivers/net/arcnet/arcnet.c       |   66 +++++++++++++++++++++++++++++++++++---
 drivers/net/arcnet/com20020-isa.c |    4 +-
 drivers/net/arcnet/com20020-pci.c |    2 -
 drivers/net/arcnet/com20020_cs.c  |    2 -
 drivers/net/arcnet/com90io.c      |    4 +-
 drivers/net/arcnet/com90xx.c      |    4 +-
 8 files changed, 78 insertions(+), 14 deletions(-)

--- a/drivers/net/arcnet/arc-rimi.c
+++ b/drivers/net/arcnet/arc-rimi.c
@@ -332,7 +332,7 @@ static int __init arc_rimi_init(void)
 		dev->irq = 9;
 
 	if (arcrimi_probe(dev)) {
-		free_netdev(dev);
+		free_arcdev(dev);
 		return -EIO;
 	}
 
@@ -349,7 +349,7 @@ static void __exit arc_rimi_exit(void)
 	iounmap(lp->mem_start);
 	release_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1);
 	free_irq(dev->irq, dev);
-	free_netdev(dev);
+	free_arcdev(dev);
 }
 
 #ifndef MODULE
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -303,6 +303,10 @@ struct arcnet_local {
 
 	int excnak_pending;    /* We just got an excesive nak interrupt */
 
+	/* RESET flag handling */
+	int reset_in_progress;
+	struct work_struct reset_work;
+
 	struct {
 		uint16_t sequence;	/* sequence number (incs with each packet) */
 		__be16 aborted_seq;
@@ -355,7 +359,9 @@ void arcnet_dump_skb(struct net_device *
 
 void arcnet_unregister_proto(struct ArcProto *proto);
 irqreturn_t arcnet_interrupt(int irq, void *dev_id);
+
 struct net_device *alloc_arcdev(const char *name);
+void free_arcdev(struct net_device *dev);
 
 int arcnet_open(struct net_device *dev);
 int arcnet_close(struct net_device *dev);
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -387,10 +387,44 @@ static void arcnet_timer(struct timer_li
 	struct arcnet_local *lp = from_timer(lp, t, timer);
 	struct net_device *dev = lp->dev;
 
-	if (!netif_carrier_ok(dev)) {
+	spin_lock_irq(&lp->lock);
+
+	if (!lp->reset_in_progress && !netif_carrier_ok(dev)) {
 		netif_carrier_on(dev);
 		netdev_info(dev, "link up\n");
 	}
+
+	spin_unlock_irq(&lp->lock);
+}
+
+static void reset_device_work(struct work_struct *work)
+{
+	struct arcnet_local *lp;
+	struct net_device *dev;
+
+	lp = container_of(work, struct arcnet_local, reset_work);
+	dev = lp->dev;
+
+	/* Do not bring the network interface back up if an ifdown
+	 * was already done.
+	 */
+	if (!netif_running(dev) || !lp->reset_in_progress)
+		return;
+
+	rtnl_lock();
+
+	/* Do another check, in case of an ifdown that was triggered in
+	 * the small race window between the exit condition above and
+	 * acquiring RTNL.
+	 */
+	if (!netif_running(dev) || !lp->reset_in_progress)
+		goto out;
+
+	dev_close(dev);
+	dev_open(dev);
+
+out:
+	rtnl_unlock();
 }
 
 static void arcnet_reply_tasklet(unsigned long data)
@@ -452,12 +486,25 @@ struct net_device *alloc_arcdev(const ch
 		lp->dev = dev;
 		spin_lock_init(&lp->lock);
 		timer_setup(&lp->timer, arcnet_timer, 0);
+		INIT_WORK(&lp->reset_work, reset_device_work);
 	}
 
 	return dev;
 }
 EXPORT_SYMBOL(alloc_arcdev);
 
+void free_arcdev(struct net_device *dev)
+{
+	struct arcnet_local *lp = netdev_priv(dev);
+
+	/* Do not cancel this at ->ndo_close(), as the workqueue itself
+	 * indirectly calls the ifdown path through dev_close().
+	 */
+	cancel_work_sync(&lp->reset_work);
+	free_netdev(dev);
+}
+EXPORT_SYMBOL(free_arcdev);
+
 /* Open/initialize the board.  This is called sometime after booting when
  * the 'ifconfig' program is run.
  *
@@ -587,6 +634,10 @@ int arcnet_close(struct net_device *dev)
 
 	/* shut down the card */
 	lp->hw.close(dev);
+
+	/* reset counters */
+	lp->reset_in_progress = 0;
+
 	module_put(lp->hw.owner);
 	return 0;
 }
@@ -820,6 +871,9 @@ irqreturn_t arcnet_interrupt(int irq, vo
 
 	spin_lock_irqsave(&lp->lock, flags);
 
+	if (lp->reset_in_progress)
+		goto out;
+
 	/* RESET flag was enabled - if device is not running, we must
 	 * clear it right away (but nothing else).
 	 */
@@ -852,11 +906,14 @@ irqreturn_t arcnet_interrupt(int irq, vo
 		if (status & RESETflag) {
 			arc_printk(D_NORMAL, dev, "spurious reset (status=%Xh)\n",
 				   status);
-			arcnet_close(dev);
-			arcnet_open(dev);
+
+			lp->reset_in_progress = 1;
+			netif_stop_queue(dev);
+			netif_carrier_off(dev);
+			schedule_work(&lp->reset_work);
 
 			/* get out of the interrupt handler! */
-			break;
+			goto out;
 		}
 		/* RX is inhibited - we must have received something.
 		 * Prepare to receive into the next buffer.
@@ -1052,6 +1109,7 @@ irqreturn_t arcnet_interrupt(int irq, vo
 	udelay(1);
 	lp->hw.intmask(dev, lp->intmask);
 
+out:
 	spin_unlock_irqrestore(&lp->lock, flags);
 	return retval;
 }
--- a/drivers/net/arcnet/com20020-isa.c
+++ b/drivers/net/arcnet/com20020-isa.c
@@ -169,7 +169,7 @@ static int __init com20020_init(void)
 		dev->irq = 9;
 
 	if (com20020isa_probe(dev)) {
-		free_netdev(dev);
+		free_arcdev(dev);
 		return -EIO;
 	}
 
@@ -182,7 +182,7 @@ static void __exit com20020_exit(void)
 	unregister_netdev(my_dev);
 	free_irq(my_dev->irq, my_dev);
 	release_region(my_dev->base_addr, ARCNET_TOTAL_SIZE);
-	free_netdev(my_dev);
+	free_arcdev(my_dev);
 }
 
 #ifndef MODULE
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -294,7 +294,7 @@ static void com20020pci_remove(struct pc
 
 		unregister_netdev(dev);
 		free_irq(dev->irq, dev);
-		free_netdev(dev);
+		free_arcdev(dev);
 	}
 }
 
--- a/drivers/net/arcnet/com20020_cs.c
+++ b/drivers/net/arcnet/com20020_cs.c
@@ -177,7 +177,7 @@ static void com20020_detach(struct pcmci
 		dev = info->dev;
 		if (dev) {
 			dev_dbg(&link->dev, "kfree...\n");
-			free_netdev(dev);
+			free_arcdev(dev);
 		}
 		dev_dbg(&link->dev, "kfree2...\n");
 		kfree(info);
--- a/drivers/net/arcnet/com90io.c
+++ b/drivers/net/arcnet/com90io.c
@@ -394,7 +394,7 @@ static int __init com90io_init(void)
 	err = com90io_probe(dev);
 
 	if (err) {
-		free_netdev(dev);
+		free_arcdev(dev);
 		return err;
 	}
 
@@ -417,7 +417,7 @@ static void __exit com90io_exit(void)
 
 	free_irq(dev->irq, dev);
 	release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
-	free_netdev(dev);
+	free_arcdev(dev);
 }
 
 module_init(com90io_init)
--- a/drivers/net/arcnet/com90xx.c
+++ b/drivers/net/arcnet/com90xx.c
@@ -554,7 +554,7 @@ err_free_irq:
 err_release_mem:
 	release_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1);
 err_free_dev:
-	free_netdev(dev);
+	free_arcdev(dev);
 	return -EIO;
 }
 
@@ -672,7 +672,7 @@ static void __exit com90xx_exit(void)
 		release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
 		release_mem_region(dev->mem_start,
 				   dev->mem_end - dev->mem_start + 1);
-		free_netdev(dev);
+		free_arcdev(dev);
 	}
 }
 



