Return-Path: <stable+bounces-233940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHTSLY2B1mmwFwgAu9opvQ
	(envelope-from <stable+bounces-233940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:25:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 297483BECD6
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 473DE3016833
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1523A1E66;
	Wed,  8 Apr 2026 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="PVW3QDFE"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84889293C42;
	Wed,  8 Apr 2026 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665542; cv=none; b=BcuxXutmxacRIUpjGGo9aLPkuZzQQz1LkUoSXdJxG3PXuHiL/WIvW5RXaAFltvb9czcMpdmpHhgyLbDDY7IDANMw4tte85KBo/SC5v9OJt7FGZ1Vbd7d1QsppTGMbOem+62FHN1qObK6hcLgYYbt8DwtvZzV+ZyD3xCANSAa14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665542; c=relaxed/simple;
	bh=oU3cGNG1gyzGMkL230cK8OgbwNBgqqNZjYe/TtXjBnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aN55O+tVuOdd09yAMfsv8UFUSQqgD3j70PsZnv4EXrtvJQX31XOffdlfe0raYEBdx5vYeizResvYMZIfbCXj3notXPQOD8nmP+V3fg23bc2MCi0jnQHmFi8uokQjoFRQdTzDH4Q0QSYt8aSvJNsAB8r5b/frONfABnk3vfcj5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=PVW3QDFE; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20B971133C9;
	Wed,  8 Apr 2026 18:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775665537; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=H3MDv5DrE3n0lO8SZbH60eyp94/nbiqdmXCVjHsR7ik=;
	b=PVW3QDFEErM2AkbuNXMgZx0PpJbQ8AaXz4of9awayj6Fq0Ikbatd7DXnCmHHLqkVzMj3MS
	5KhvpJIlXZ+D70wyuL+5UR5h4c5qaQSLIYYrYxbLpj6EirkOG4y6FcU4yk9dPDviS5mkhQ
	i1+B+dGu0g/4tY9NQ7NbRjo1esSpUw8fF5CCo0AAZ42N6JtshWErkaV1L98N3PWL393vj7
	uGIWcQks8OLVJUGt8aO+Pm9Tnm776Mtmt7TLcRLcye8wnAr6A+YX/SRst9cBSyvY0h9qPr
	IpxkxHCiryFE0pkWkKHeRgZ38gQMW7Y22CWzIZ2rjpLoRwmk7M3dYk4nUbKWHA==
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
	Yicong Hui <yiconghui@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around IRQ handler
Date: Wed,  8 Apr 2026 18:24:58 +0200
Message-ID: <20260408162535.98108-1-marex@nabladev.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233940-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nabladev.com,vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,tipi-net.de,redhat.com,raritan.com,gmail.com];
	DKIM_TRACE(0.00)[nabladev.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,raritan.com:email]
X-Rspamd-Queue-Id: 297483BECD6
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

Fix the problem by disabling BH around the IRQ handler, thus preventing
the net_tx_action() softirq from triggering during the IRQ handler. The
net_tx_action() softirq is now triggered at the end of the IRQ handler,
once all the other IRQ handler actions have been completed.

  __schedule from schedule_rtlock+0x1c/0x34
  schedule_rtlock from rtlock_slowlock_locked+0x538/0x894
  rtlock_slowlock_locked from rt_spin_lock+0x44/0x5c
  rt_spin_lock from ks8851_start_xmit_par+0x68/0x1a0
  ks8851_start_xmit_par from netdev_start_xmit+0x1c/0x40
  netdev_start_xmit from dev_hard_start_xmit+0xec/0x1b0
  dev_hard_start_xmit from sch_direct_xmit+0xb8/0x25c
  sch_direct_xmit from __qdisc_run+0x20c/0x4fc
  __qdisc_run from qdisc_run+0x1c/0x28
  qdisc_run from net_tx_action+0x1f4/0x244
  net_tx_action from handle_softirqs+0x1c0/0x29c
  handle_softirqs from __local_bh_enable_ip+0xdc/0xf4
  __local_bh_enable_ip from __netdev_alloc_skb+0x140/0x194
  __netdev_alloc_skb from ks8851_irq+0x348/0x4d8
  ks8851_irq from irq_thread_fn+0x24/0x64
  irq_thread_fn from irq_thread+0x110/0x1dc
  irq_thread from kthread+0x104/0x10c
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
Cc: Yicong Hui <yiconghui@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: Register dedicated IRQ handler wrapper which disables BH for the
    parallel variant of the MAC, the variant which uses spinlocks as
    the locking primitive. Use stock IRQ handler with BH unchanged
    for the SPI variant, which uses mutexes as locking primitive.
---
 drivers/net/ethernet/micrel/ks8851.h        |  2 ++
 drivers/net/ethernet/micrel/ks8851_common.c | 22 ++++++++++++++++++++-
 drivers/net/ethernet/micrel/ks8851_par.c    |  1 +
 drivers/net/ethernet/micrel/ks8851_spi.c    |  1 +
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/micrel/ks8851.h
index 31f75b4a67fd7..71213b44b0d04 100644
--- a/drivers/net/ethernet/micrel/ks8851.h
+++ b/drivers/net/ethernet/micrel/ks8851.h
@@ -394,6 +394,8 @@ struct ks8851_net {
 	u16			rc_rxqcr;
 	u16			rc_ccr;
 
+	bool			no_bh_in_irq_handler;
+
 	struct mii_if_info	mii;
 	struct ks8851_rxctrl	rxctrl;
 
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 8048770958d60..0d7c548d18356 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -385,6 +385,24 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	return IRQ_HANDLED;
 }
 
+/**
+ * ks8851_irq_nobh - IRQ handler with BH disabled
+ * @irq: IRQ number
+ * @_ks: cookie
+ *
+ * Wrapper which calls ks8851_irq() with BH disabled.
+ */
+static irqreturn_t ks8851_irq_nobh(int irq, void *_ks)
+{
+	irqreturn_t ret;
+
+	local_bh_disable();
+	ret = ks8851_irq(irq, _ks);
+	local_bh_enable();
+
+	return ret;
+}
+
 /**
  * ks8851_flush_tx_work - flush outstanding TX work
  * @ks: The device state
@@ -408,7 +426,9 @@ static int ks8851_net_open(struct net_device *dev)
 	unsigned long flags;
 	int ret;
 
-	ret = request_threaded_irq(dev->irq, NULL, ks8851_irq,
+	ret = request_threaded_irq(dev->irq, NULL,
+				   ks->no_bh_in_irq_handler ?
+				   ks8851_irq_nobh : ks8851_irq,
 				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				   dev->name, ks);
 	if (ret < 0) {
diff --git a/drivers/net/ethernet/micrel/ks8851_par.c b/drivers/net/ethernet/micrel/ks8851_par.c
index 78695be2570bf..0fe3e40291a24 100644
--- a/drivers/net/ethernet/micrel/ks8851_par.c
+++ b/drivers/net/ethernet/micrel/ks8851_par.c
@@ -288,6 +288,7 @@ static int ks8851_probe_par(struct platform_device *pdev)
 	ks->rdfifo = ks8851_rdfifo_par;
 	ks->wrfifo = ks8851_wrfifo_par;
 	ks->start_xmit = ks8851_start_xmit_par;
+	ks->no_bh_in_irq_handler = true;
 
 #define STD_IRQ (IRQ_LCI |	/* Link Change */	\
 		 IRQ_RXI |	/* RX done */		\
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index a161ae45743ab..9afdb7eb7953f 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -424,6 +424,7 @@ static int ks8851_probe_spi(struct spi_device *spi)
 	ks->wrfifo = ks8851_wrfifo_spi;
 	ks->start_xmit = ks8851_start_xmit_spi;
 	ks->flush_tx_work = ks8851_flush_tx_work_spi;
+	ks->no_bh_in_irq_handler = false;
 
 #define STD_IRQ (IRQ_LCI |	/* Link Change */	\
 		 IRQ_TXI |	/* TX done */		\
-- 
2.53.0


