Return-Path: <stable+bounces-161547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D236DAFFD83
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 11:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6FE1731D7
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124D28E5E6;
	Thu, 10 Jul 2025 09:05:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03928E56B;
	Thu, 10 Jul 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138357; cv=none; b=kOqTYhu2U4OXB0SQcp14uHi44SC3ForY66WzrShixZUpZWBMrenG6ssY03BpNvKAmqyVKLooCnZuCzjcp6MgPvaoTv7lc90/7+gnA7Whhp5mSMRzv5yNPYeeQ3piCGcim155wWfQX6ncJxOqDuFKHIWGLXy9vc9XSwfR4St8/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138357; c=relaxed/simple;
	bh=7WYC0Q01SuTeXVO2p/jlKOCMn9aAW/fTfixuG0PDXYo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UKLmLO6gkeJC/jyoQ9kLbtYwXvChoBjXsnKeb52t8Oo9QEzqszpRAMfvDUW913EX1qcN/SoUljd0vwT75cLGyYpnxOJlB+b3JClJNwvNLh2C2OHBtue7sWQNljUSdFtNM/pKkGWImNbFt+/X4snha5/d/Lc4MfS6qQr/9Wzf5h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 10 Jul
 2025 10:50:40 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%6]) with mapi id
 15.01.2507.057; Thu, 10 Jul 2025 10:50:40 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Ming Lei <ming.lei@canonical.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE event
Thread-Topic: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE
 event
Thread-Index: AQHb8Xe2qza52xx55UmGbnkg6Pc/lg==
Date: Thu, 10 Jul 2025 08:50:40 +0000
Message-ID: <20250710085028.1070922-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2956B14450657066
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Having a Gemalto Cinterion PLS83-W modem attached to USB and activating the
cellular data link would sometimes yield the following RCU stall, leading
to a system freeze:

    rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 0-.... =
} 33108 jiffies s: 201 root: 0x1/.
    rcu: blocking rcu_node structures (internal RCU debug):
    Sending NMI from CPU 1 to CPUs 0:
    NMI backtrace for cpu 0

    Call trace:
     arch_local_irq_enable+0x4/0x8
     local_bh_enable+0x18/0x20
     __netdev_alloc_skb+0x18c/0x1cc
     rx_submit+0x68/0x1f8 [usbnet]
     rx_alloc_submit+0x4c/0x74 [usbnet]
     usbnet_bh+0x1d8/0x218 [usbnet]
     usbnet_bh_tasklet+0x10/0x18 [usbnet]
     tasklet_action_common+0xa8/0x110
     tasklet_action+0x2c/0x34
     handle_softirqs+0x2cc/0x3a0
     __do_softirq+0x10/0x18
     ____do_softirq+0xc/0x14
     call_on_irq_stack+0x24/0x34
     do_softirq_own_stack+0x18/0x20
     __irq_exit_rcu+0xa8/0xb8
     irq_exit_rcu+0xc/0x30
     el1_interrupt+0x34/0x48
     el1h_64_irq_handler+0x14/0x1c
     el1h_64_irq+0x68/0x6c
     _raw_spin_unlock_irqrestore+0x38/0x48
     xhci_urb_dequeue+0x1ac/0x45c [xhci_hcd]
     unlink1+0xd4/0xdc [usbcore]
     usb_hcd_unlink_urb+0x70/0xb0 [usbcore]
     usb_unlink_urb+0x24/0x44 [usbcore]
     unlink_urbs.constprop.0.isra.0+0x64/0xa8 [usbnet]
     __handle_link_change+0x34/0x70 [usbnet]
     usbnet_deferred_kevent+0x1c0/0x320 [usbnet]
     process_scheduled_works+0x2d0/0x48c
     worker_thread+0x150/0x1dc
     kthread+0xd8/0xe8
     ret_from_fork+0x10/0x20

It turns out that during the link activation a LINK_CHANGE event is emitted
which causes the active RX URBs to be unlinked, while that is happening
rx_submit() may begin pushing new URBs to the queue being emptied.
Causing the unlink queue to never empty.

Use the same approach as commit 43daa96b166c ("usbnet: Stop RX Q on MTU
change") and pause the RX queue while unlinking the URBs on LINK_CHANGE
as well.

Fixes: 4b49f58fff00 ("usbnet: handle link change")
Cc: stable@vger.kernel.org
Signed-off-by: John Ernberg <john.ernberg@actia.se>

---

Tested on 6.12.20 and forward ported.
---
 drivers/net/usb/usbnet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index c04e715a4c2a..156f0e85a135 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1115,7 +1115,9 @@ static void __handle_link_change(struct usbnet *dev)
=20
 	if (!netif_carrier_ok(dev->net)) {
 		/* kill URBs for reading packets to save bus bandwidth */
+		usbnet_pause_rx(dev);
 		unlink_urbs(dev, &dev->rxq);
+		usbnet_resume_rx(dev);
=20
 		/*
 		 * tx_timeout will unlink URBs for sending packets and
--=20
2.49.0

