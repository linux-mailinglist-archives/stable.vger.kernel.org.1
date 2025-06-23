Return-Path: <stable+bounces-157611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F179AE54D1
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8B31BC1B04
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71C222581;
	Mon, 23 Jun 2025 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Frt0xDjf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC833FB1B;
	Mon, 23 Jun 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716292; cv=none; b=sEBeri1Yx4yow5/em/g9Xv+OZVY5aVO3YJyLhwhpPFzCnaDp1ZuCGQTgSzMn557TahA1qftYDCMQUIAMa6Bz18yhygDvf0NDBpRqp/FIFQj3jvoHXxtcf1adRSHchRcH/Jn/o73h75q2YgpapQp/POg80fTDuAhkGRPlY0pf6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716292; c=relaxed/simple;
	bh=MNonQdZX7tq8c3ulDONCZcS+Fmo+YuUOFkqkMyyUPv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otiJoZG8qQgxR+xOQbhJeuU9GdNEcA9sDjb6NXyoS6DSItF0g4XMrrzsvyqSLXyCmR9rjKs9pl/eBvoDwdr8BM2Utiy7w5SuY1/aae2UNX+yzhtIHtWd/LHVGNxGPzmqFlB5FIv608EdS2MXqL87L2NqboJtIfXKfUyXrS2ClYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Frt0xDjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8866EC4CEEA;
	Mon, 23 Jun 2025 22:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716291;
	bh=MNonQdZX7tq8c3ulDONCZcS+Fmo+YuUOFkqkMyyUPv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Frt0xDjfK9BAfDaDOymatfqk4AeNkElohllcg+35gY3skgxKdTGpRtZeLpIdQ8S/3
	 S13qX/FSv+wUPOMMdHa4oe1n5QC+JxiBTbY8PSWy/tlGbHtsQowEWymFyWosXL0GD4
	 E0QV4Ojuva1mtdja33g69LZq4+ZIQN+eFw33nvT8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Moon Yeounsu <yyyynoom@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 313/411] net: dlink: add synchronization for stats update
Date: Mon, 23 Jun 2025 15:07:37 +0200
Message-ID: <20250623130641.520806432@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moon Yeounsu <yyyynoom@gmail.com>

[ Upstream commit 12889ce926e9a9baf6b83d809ba316af539b89e2 ]

This patch synchronizes code that accesses from both user-space
and IRQ contexts. The `get_stats()` function can be called from both
context.

`dev->stats.tx_errors` and `dev->stats.collisions` are also updated
in the `tx_errors()` function. Therefore, these fields must also be
protected by synchronized.

There is no code that accessses `dev->stats.tx_errors` between the
previous and updated lines, so the updating point can be moved.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
Link: https://patch.msgid.link/20250515075333.48290-1-yyyynoom@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/dlink/dl2k.c | 14 +++++++++++++-
 drivers/net/ethernet/dlink/dl2k.h |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index af0b6fa296e56..09a275eb44487 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -146,6 +146,8 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 	np->ioaddr = ioaddr;
 	np->chip_id = chip_idx;
 	np->pdev = pdev;
+
+	spin_lock_init(&np->stats_lock);
 	spin_lock_init (&np->tx_lock);
 	spin_lock_init (&np->rx_lock);
 
@@ -869,7 +871,6 @@ tx_error (struct net_device *dev, int tx_status)
 	frame_id = (tx_status & 0xffff0000);
 	printk (KERN_ERR "%s: Transmit error, TxStatus %4.4x, FrameId %d.\n",
 		dev->name, tx_status, frame_id);
-	dev->stats.tx_errors++;
 	/* Ttransmit Underrun */
 	if (tx_status & 0x10) {
 		dev->stats.tx_fifo_errors++;
@@ -906,9 +907,15 @@ tx_error (struct net_device *dev, int tx_status)
 		rio_set_led_mode(dev);
 		/* Let TxStartThresh stay default value */
 	}
+
+	spin_lock(&np->stats_lock);
 	/* Maximum Collisions */
 	if (tx_status & 0x08)
 		dev->stats.collisions++;
+
+	dev->stats.tx_errors++;
+	spin_unlock(&np->stats_lock);
+
 	/* Restart the Tx */
 	dw32(MACCtrl, dr16(MACCtrl) | TxEnable);
 }
@@ -1077,7 +1084,9 @@ get_stats (struct net_device *dev)
 	int i;
 #endif
 	unsigned int stat_reg;
+	unsigned long flags;
 
+	spin_lock_irqsave(&np->stats_lock, flags);
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
 
@@ -1127,6 +1136,9 @@ get_stats (struct net_device *dev)
 	dr16(TCPCheckSumErrors);
 	dr16(UDPCheckSumErrors);
 	dr16(IPCheckSumErrors);
+
+	spin_unlock_irqrestore(&np->stats_lock, flags);
+
 	return &dev->stats;
 }
 
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 0e33e2eaae960..56aff2f0bdbfa 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -372,6 +372,8 @@ struct netdev_private {
 	struct pci_dev *pdev;
 	void __iomem *ioaddr;
 	void __iomem *eeprom_addr;
+	// To ensure synchronization when stats are updated.
+	spinlock_t stats_lock;
 	spinlock_t tx_lock;
 	spinlock_t rx_lock;
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
-- 
2.39.5




