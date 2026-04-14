Return-Path: <stable+bounces-237784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PFPFq4Y3mmFnAkAu9opvQ
	(envelope-from <stable+bounces-237784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:36:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E20443F8CED
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7EBD306EF6A
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2743D5662;
	Tue, 14 Apr 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="j58Z43nt"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C53D567A;
	Tue, 14 Apr 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162828; cv=none; b=j+3/irbOTOMJ2sgw7bO76CbDJta/TAW77bwqd2iGY3bKUMm9PT9aOkeoVI1fGXbiNMWwtlQCb+2c9dHAPDBXpuLMX9wOxqaGL04+GvUVLfT6WkLP7vVYgkQkfABT3C1sfJyn2+WFYR0Tudn0Sqgy+VlblUfdoGRAy6vGqXktVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162828; c=relaxed/simple;
	bh=kaLB+8F1h5Th8eW7hDvEq0svmkaBi8BRflFKEWRfyII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1OmFfBJI4DixAaE8YZZC3nq+lBnDoB1APCw5BPUiVyeUCtZxYD0gSTFwS4xZnnrvvu87C1JCqH4+IuDToZeIrrEbQ7KIuBLUYQbvgYdppWfzV4Cw/VM/LoxiXriMuZqkxtjANnPP3Eo43cdo8MCUfdOqVzT7oYxJ8LnY/n00HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=j58Z43nt; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58BEB10BA27;
	Tue, 14 Apr 2026 12:33:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776162814; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=L/V7WAkCUFA5n2pPoxCccxlsDRKYK5x1m8q1PzIM2vo=;
	b=j58Z43nt+EPUTUXbFXXFApRTZFTWZPvcGE5egi/XKBv1Z2Lf3Ybo4RhJ8d+oJ+cwp0xC3O
	YvgVwt3N3z4Ez+3A7Y6xkhqcKYCqPMlyyzvjBi/Pl1X2F33caUuxv5vPGzSYZSI5Nj/sOM
	oedbjTA5szXJYTFd8SBcgSLBNnDw8QU4CKn7v2bK1uOKFPO1dg6en+9l6UfJGkfiEwru1i
	k1g8IC8K3jvkZO4xRh3xaCNtp16D/L/fZjkVwQwju2vkmMlgG61Jx5Imo/grXSrbFNmX1o
	EKiqIBMUcB+QsF5m2V48c3LLWxMqaA0wwQr1+LD6jh4j00ixGOQdP7+2DeOoRg==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Yicong Hui <yiconghui@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs around IRQ handler
Date: Tue, 14 Apr 2026 12:32:52 +0200
Message-ID: <20260414103327.113500-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-237784-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nabladev.com,vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,tipi-net.de,redhat.com,raritan.com,linutronix.de,gmail.com];
	NEURAL_HAM(-0.00)[-0.977];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[raritan.com:email,nabladev.com:dkim,nabladev.com:email,nabladev.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,tipi-net.de:email]
X-Rspamd-Queue-Id: E20443F8CED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If CONFIG_PREEMPT_RT=y is set AND the driver executes ks8851_irq() AND
KSZ_ISR register bit IRQ_RXI is set AND ks8851_rx_pkts() detects that
there are packets in the RX FIFO, then netdev_alloc_skb_ip_align() is
called to allocate SKBs. If netdev_alloc_skb_ip_align() is called with
BH enabled, local_bh_enable() at the end of netdev_alloc_skb_ip_align()
will call __local_bh_enable_ip(), which will call __do_softirq(), which
may trigger net_tx_action() softirq, which may ultimately call the xmit
callback ks8851_start_xmit_par(). The ks8851_start_xmit_par() will try
to lock struct ks8851_net_par .lock spinlock, which is already locked
by ks8851_irq() from which ks8851_start_xmit_par() was called. This
leads to a deadlock, which is reported by the kernel, including a trace
listed below.

Fix the problem by disabling BH around critical sections, including the
IRQ handler, thus preventing the net_tx_action() softirq from triggering
during these critical sections. The net_tx_action() softirq is triggered
at the end of the IRQ handler, once all the other IRQ handler actions have
been completed.

 __schedule from schedule_rtlock+0x1c/0x34
 schedule_rtlock from rtlock_slowlock_locked+0x548/0x904
 rtlock_slowlock_locked from rt_spin_lock+0x60/0x9c
 rt_spin_lock from ks8851_start_xmit_par+0x74/0x1a8
 ks8851_start_xmit_par from netdev_start_xmit+0x20/0x44
 netdev_start_xmit from dev_hard_start_xmit+0xd0/0x188
 dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
 sch_direct_xmit from __qdisc_run+0x1f8/0x4ec
 __qdisc_run from qdisc_run+0x1c/0x28
 qdisc_run from net_tx_action+0x1f0/0x268
 net_tx_action from handle_softirqs+0x1a4/0x270
 handle_softirqs from __local_bh_enable_ip+0xcc/0xe0
 __local_bh_enable_ip from __alloc_skb+0xd8/0x128
 __alloc_skb from __netdev_alloc_skb+0x3c/0x19c
 __netdev_alloc_skb from ks8851_irq+0x388/0x4d4
 ks8851_irq from irq_thread_fn+0x24/0x64
 irq_thread_fn from irq_thread+0x178/0x28c
 irq_thread from kthread+0x12c/0x138
 kthread from ret_from_fork+0x14/0x28

Fixes: e0863634bf9f ("net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yicong Hui <yiconghui@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: Register dedicated IRQ handler wrapper which disables BH for the
    parallel variant of the MAC, the variant which uses spinlocks as
    the locking primitive. Use stock IRQ handler with BH unchanged
    for the SPI variant, which uses mutexes as locking primitive.
V3: Switch to spin_lock_bh(), update commit message
---
 drivers/net/ethernet/micrel/ks8851.h        |  6 +-
 drivers/net/ethernet/micrel/ks8851_common.c | 64 +++++++++------------
 drivers/net/ethernet/micrel/ks8851_par.c    | 15 ++---
 drivers/net/ethernet/micrel/ks8851_spi.c    | 11 ++--
 4 files changed, 38 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/micrel/ks8851.h
index 31f75b4a67fd7..b795a3a605711 100644
--- a/drivers/net/ethernet/micrel/ks8851.h
+++ b/drivers/net/ethernet/micrel/ks8851.h
@@ -408,10 +408,8 @@ struct ks8851_net {
 	struct gpio_desc	*gpio;
 	struct mii_bus		*mii_bus;
 
-	void			(*lock)(struct ks8851_net *ks,
-					unsigned long *flags);
-	void			(*unlock)(struct ks8851_net *ks,
-					  unsigned long *flags);
+	void			(*lock)(struct ks8851_net *ks);
+	void			(*unlock)(struct ks8851_net *ks);
 	unsigned int		(*rdreg16)(struct ks8851_net *ks,
 					   unsigned int reg);
 	void			(*wrreg16)(struct ks8851_net *ks,
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 8048770958d60..6c375647b24de 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -28,25 +28,23 @@
 /**
  * ks8851_lock - register access lock
  * @ks: The chip state
- * @flags: Spinlock flags
  *
  * Claim chip register access lock
  */
-static void ks8851_lock(struct ks8851_net *ks, unsigned long *flags)
+static void ks8851_lock(struct ks8851_net *ks)
 {
-	ks->lock(ks, flags);
+	ks->lock(ks);
 }
 
 /**
  * ks8851_unlock - register access unlock
  * @ks: The chip state
- * @flags: Spinlock flags
  *
  * Release chip register access lock
  */
-static void ks8851_unlock(struct ks8851_net *ks, unsigned long *flags)
+static void ks8851_unlock(struct ks8851_net *ks)
 {
-	ks->unlock(ks, flags);
+	ks->unlock(ks);
 }
 
 /**
@@ -129,11 +127,10 @@ static void ks8851_set_powermode(struct ks8851_net *ks, unsigned pwrmode)
 static int ks8851_write_mac_addr(struct net_device *dev)
 {
 	struct ks8851_net *ks = netdev_priv(dev);
-	unsigned long flags;
 	u16 val;
 	int i;
 
-	ks8851_lock(ks, &flags);
+	ks8851_lock(ks);
 
 	/*
 	 * Wake up chip in case it was powered off when stopped; otherwise,
@@ -149,7 +146,7 @@ static int ks8851_write_mac_addr(struct net_device *dev)
 	if (!netif_running(dev))
 		ks8851_set_powermode(ks, PMECR_PM_SOFTDOWN);
 
-	ks8851_unlock(ks, &flags);
+	ks8851_unlock(ks);
 
 	return 0;
 }
@@ -163,12 +160,11 @@ static int ks8851_write_mac_addr(struct net_device *dev)
 static void ks8851_read_mac_addr(struct net_device *dev)
 {
 	struct ks8851_net *ks = netdev_priv(dev);
-	unsigned long flags;
 	u8 addr[ETH_ALEN];
 	u16 reg;
 	int i;
 
-	ks8851_lock(ks, &flags);
+	ks8851_lock(ks);
 
 	for (i = 0; i < ETH_ALEN; i += 2) {
 		reg = ks8851_rdreg16(ks, KS_MAR(i));
@@ -177,7 +173,7 @@ static void ks8851_read_mac_addr(struct net_device *dev)
 	}
 	eth_hw_addr_set(dev, addr);
 
-	ks8851_unlock(ks, &flags);
+	ks8851_unlock(ks);
 }
 
 /**
@@ -312,11 +308,10 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 {
 	struct ks8851_net *ks = _ks;
 	struct sk_buff_head rxq;
-	unsigned long flags;
 	unsigned int status;
 	struct sk_buff *skb;
 
-	ks8851_lock(ks, &flags);
+	ks8851_lock(ks);
 
 	status = ks8851_rdreg16(ks, KS_ISR);
 	ks8851_wrreg16(ks, KS_ISR, status);
@@ -373,7 +368,7 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		ks8851_wrreg16(ks, KS_RXCR1, rxc->rxcr1);
 	}
 
-	ks8851_unlock(ks, &flags);
+	ks8851_unlock(ks);
 
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
@@ -405,7 +400,6 @@ static void ks8851_flush_tx_work(struct ks8851_net *ks)
 static int ks8851_net_open(struct net_device *dev)
 {
 	struct ks8851_net *ks = netdev_priv(dev);
-	unsigned long flags;
 	int ret;
 
 	ret = request_threaded_irq(dev->irq, NULL, ks8851_irq,
@@ -418,7 +412,7 @@ static int ks8851_net_open(struct net_device *dev)
 
 	/* lock the card, even if we may not actually be doing anything
 	 * else at the moment */
-	ks8851_lock(ks, &flags);
+	ks8851_lock(ks);
 
 	netif_dbg(ks, ifup, ks->netdev, "opening\n");
 
@@ -471,7 +465,7 @@ static int ks8851_net_open(struct net_device *dev)
 
 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
 
-	ks8851_unlock(ks, &flags);
+	ks8851_unlock(ks);
 	mii_check_link(&ks->mii);
 	return 0;
 }
@@ -487,23 +481,22 @@ static int ks8851_net_open(struct net_device *dev)
 static int ks8851_net_stop(struct net_device *dev)
 {
 	struct ks8851_net *ks = netdev_priv(dev);
-	unsigned long flags;
 
 	netif_info(ks, ifdown, dev, "shutting down\n");
 
 	netif_stop_queue(dev);
 
-	ks8851_lock(ks, &flags);
+	ks8851_lock(ks);
 	/* turn off the IRQs and ack any outstanding */
 	ks8851_wrreg16(ks, KS_IER, 0x0000);
 	ks8851_wrreg16(ks, KS_ISR, 0xffff);
-	ks8851_unlock(ks, &flags);
+	ks8851_unlock(ks);
 
 	/* stop any outstanding work */
 	ks8851_flush_tx_work(ks);
 	flush_work(&ks->rxctrl_work);
 
-	ks8851_lock(ks, &flags);
+	ks8851_lock(ks);
 	/* shutdown RX process */
 	ks8851_wrreg16(ks, KS_RXCR1, 0x0000);
 
@@ -512,7 +505,7 @@ static int ks8851_net_stop(struct net_device *dev)
 
 	/* set powermode to soft power down to save power */
 	ks8851_set_powermode(ks, PMECR_PM_SOFTDOWN);
-	ks8851_unlock(ks, &flags);
+	ks8851_unlock(ks);
 
 	/* ensure any queued tx buffers are dumped */
 	while (!skb_queue_empty(&ks->txq)) {
@@ -566,14 +559,13 @@ static netdev_tx_t ks8851_start_xmit(struct sk_buff *skb,
 static void ks8851_rxctrl_work(struct work_struct *work)
 {
 	struct ks8851_net *ks = container_of(work, struct ks8851_net, rxctrl_work);
-	unsigned long flags;
 
-	ks8851_lock(ks, &flags);
+	ks8851_lock(ks);
 
 	/* need to shutdown RXQ before modifying filter parameters */
 	ks8851_wrreg16(ks, KS_RXCR1, 0x00);
 
-	ks8851_unlock(ks, &flags);
+	ks8851_unlock(ks);
 }
 
 static void ks8851_set_rx_mode(struct net_device *dev)
@@ -780,7 +772,6 @@ static int ks8851_set_eeprom(struct net_device *dev,
 {
 	struct ks8851_net *ks = netdev_priv(dev);
 	int offset = ee->offset;
-	unsigned long flags;
 	int len = ee->len;
 	u16 tmp;
 
@@ -794,7 +785,7 @@ static int ks8851_set_eeprom(struct net_device *dev,
 	if (!(ks->rc_ccr & CCR_EEPROM))
 		return -ENOENT;
 
-	ks8851_lock(ks, &flags);
+	ks8851_lock(ks);
 
 	ks8851_eeprom_claim(ks);
 
@@ -817,7 +808,7 @@ static int ks8851_set_eeprom(struct net_device *dev,
 	eeprom_93cx6_wren(&ks->eeprom, false);
 
 	ks8851_eeprom_release(ks);
-	ks8851_unlock(ks, &flags);
+	ks8851_unlock(ks);
 
 	return 0;
 }
@@ -827,7 +818,6 @@ static int ks8851_get_eeprom(struct net_device *dev,
 {
 	struct ks8851_net *ks = netdev_priv(dev);
 	int offset = ee->offset;
-	unsigned long flags;
 	int len = ee->len;
 
 	/* must be 2 byte aligned */
@@ -837,7 +827,7 @@ static int ks8851_get_eeprom(struct net_device *dev,
 	if (!(ks->rc_ccr & CCR_EEPROM))
 		return -ENOENT;
 
-	ks8851_lock(ks, &flags);
+	ks8851_lock(ks);
 
 	ks8851_eeprom_claim(ks);
 
@@ -845,7 +835,7 @@ static int ks8851_get_eeprom(struct net_device *dev,
 
 	eeprom_93cx6_multiread(&ks->eeprom, offset/2, (__le16 *)data, len/2);
 	ks8851_eeprom_release(ks);
-	ks8851_unlock(ks, &flags);
+	ks8851_unlock(ks);
 
 	return 0;
 }
@@ -904,7 +894,6 @@ static int ks8851_phy_reg(int reg)
 static int ks8851_phy_read_common(struct net_device *dev, int phy_addr, int reg)
 {
 	struct ks8851_net *ks = netdev_priv(dev);
-	unsigned long flags;
 	int result;
 	int ksreg;
 
@@ -912,9 +901,9 @@ static int ks8851_phy_read_common(struct net_device *dev, int phy_addr, int reg)
 	if (ksreg < 0)
 		return ksreg;
 
-	ks8851_lock(ks, &flags);
+	ks8851_lock(ks);
 	result = ks8851_rdreg16(ks, ksreg);
-	ks8851_unlock(ks, &flags);
+	ks8851_unlock(ks);
 
 	return result;
 }
@@ -949,14 +938,13 @@ static void ks8851_phy_write(struct net_device *dev,
 			     int phy, int reg, int value)
 {
 	struct ks8851_net *ks = netdev_priv(dev);
-	unsigned long flags;
 	int ksreg;
 
 	ksreg = ks8851_phy_reg(reg);
 	if (ksreg >= 0) {
-		ks8851_lock(ks, &flags);
+		ks8851_lock(ks);
 		ks8851_wrreg16(ks, ksreg, value);
-		ks8851_unlock(ks, &flags);
+		ks8851_unlock(ks);
 	}
 }
 
diff --git a/drivers/net/ethernet/micrel/ks8851_par.c b/drivers/net/ethernet/micrel/ks8851_par.c
index 78695be2570bf..9f1c33f6ddec0 100644
--- a/drivers/net/ethernet/micrel/ks8851_par.c
+++ b/drivers/net/ethernet/micrel/ks8851_par.c
@@ -55,29 +55,27 @@ struct ks8851_net_par {
 /**
  * ks8851_lock_par - register access lock
  * @ks: The chip state
- * @flags: Spinlock flags
  *
  * Claim chip register access lock
  */
-static void ks8851_lock_par(struct ks8851_net *ks, unsigned long *flags)
+static void ks8851_lock_par(struct ks8851_net *ks)
 {
 	struct ks8851_net_par *ksp = to_ks8851_par(ks);
 
-	spin_lock_irqsave(&ksp->lock, *flags);
+	spin_lock_bh(&ksp->lock);
 }
 
 /**
  * ks8851_unlock_par - register access unlock
  * @ks: The chip state
- * @flags: Spinlock flags
  *
  * Release chip register access lock
  */
-static void ks8851_unlock_par(struct ks8851_net *ks, unsigned long *flags)
+static void ks8851_unlock_par(struct ks8851_net *ks)
 {
 	struct ks8851_net_par *ksp = to_ks8851_par(ks);
 
-	spin_unlock_irqrestore(&ksp->lock, *flags);
+	spin_unlock_bh(&ksp->lock);
 }
 
 /**
@@ -233,7 +231,6 @@ static netdev_tx_t ks8851_start_xmit_par(struct sk_buff *skb,
 {
 	struct ks8851_net *ks = netdev_priv(dev);
 	netdev_tx_t ret = NETDEV_TX_OK;
-	unsigned long flags;
 	unsigned int txqcr;
 	u16 txmir;
 	int err;
@@ -241,7 +238,7 @@ static netdev_tx_t ks8851_start_xmit_par(struct sk_buff *skb,
 	netif_dbg(ks, tx_queued, ks->netdev,
 		  "%s: skb %p, %d@%p\n", __func__, skb, skb->len, skb->data);
 
-	ks8851_lock_par(ks, &flags);
+	ks8851_lock_par(ks);
 
 	txmir = ks8851_rdreg16_par(ks, KS_TXMIR) & 0x1fff;
 
@@ -262,7 +259,7 @@ static netdev_tx_t ks8851_start_xmit_par(struct sk_buff *skb,
 		ret = NETDEV_TX_BUSY;
 	}
 
-	ks8851_unlock_par(ks, &flags);
+	ks8851_unlock_par(ks);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index a161ae45743ab..b9e68520278d0 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -71,11 +71,10 @@ struct ks8851_net_spi {
 /**
  * ks8851_lock_spi - register access lock
  * @ks: The chip state
- * @flags: Spinlock flags
  *
  * Claim chip register access lock
  */
-static void ks8851_lock_spi(struct ks8851_net *ks, unsigned long *flags)
+static void ks8851_lock_spi(struct ks8851_net *ks)
 {
 	struct ks8851_net_spi *kss = to_ks8851_spi(ks);
 
@@ -85,11 +84,10 @@ static void ks8851_lock_spi(struct ks8851_net *ks, unsigned long *flags)
 /**
  * ks8851_unlock_spi - register access unlock
  * @ks: The chip state
- * @flags: Spinlock flags
  *
  * Release chip register access lock
  */
-static void ks8851_unlock_spi(struct ks8851_net *ks, unsigned long *flags)
+static void ks8851_unlock_spi(struct ks8851_net *ks)
 {
 	struct ks8851_net_spi *kss = to_ks8851_spi(ks);
 
@@ -309,7 +307,6 @@ static void ks8851_tx_work(struct work_struct *work)
 	struct ks8851_net_spi *kss;
 	unsigned short tx_space;
 	struct ks8851_net *ks;
-	unsigned long flags;
 	struct sk_buff *txb;
 	bool last;
 
@@ -317,7 +314,7 @@ static void ks8851_tx_work(struct work_struct *work)
 	ks = &kss->ks8851;
 	last = skb_queue_empty(&ks->txq);
 
-	ks8851_lock_spi(ks, &flags);
+	ks8851_lock_spi(ks);
 
 	while (!last) {
 		txb = skb_dequeue(&ks->txq);
@@ -343,7 +340,7 @@ static void ks8851_tx_work(struct work_struct *work)
 	ks->tx_space = tx_space;
 	spin_unlock_bh(&ks->statelock);
 
-	ks8851_unlock_spi(ks, &flags);
+	ks8851_unlock_spi(ks);
 }
 
 /**
-- 
2.53.0


