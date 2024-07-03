Return-Path: <stable+bounces-57950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69092657D
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5A52850A3
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18E18131E;
	Wed,  3 Jul 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="DN2UJXz9"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E917A589;
	Wed,  3 Jul 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022477; cv=none; b=VZbX3XNqN+IIpQFHyD4sXcriI/0XXotuGCFk0n6QzghkAoNkOMIyabc4pNWUDmpfM7HgPXkKIqScBMa9G00zm4Xp0iTh890u7m5s9QgILVXXmdxBMXYamBk47Hr700/ES55Unn81lugZF60uqTXofL813ydcKBHpe57Bo7b5yC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022477; c=relaxed/simple;
	bh=ZR9BK/GWJEq7gHd/0bbA64bMZiRioRHZNtKi3Saf/YY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEQiHREwFGHZ2Hp+kg9LCtmiCwQL4x+e+7DqABh0yPZAq75NoxDDwYoLsMbzEoNAu+Fxp9822DXeukGfgzqfykJS8h9iDDk+V/CaRCDyjfMEaZH5SPP4oYup5QK2K7+Zae9YwVd7VF4LWboj7QxggMVqTkNjMxhhAa7jdN9s12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b=DN2UJXz9; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720022460; x=1720627260; i=rwahl@gmx.de;
	bh=3hwJTNAzBcv9p6zS7trpMax+3zGjHvUT11S8vrZthl8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DN2UJXz9TFra3ZPXbPaFHCr64eBC5K3EDOoH10Dd3ZHCp4L8wFCGUzKf1KNK4A3b
	 m7vu9pQVjf3UlBK6cOxZrtSnj8x+4s7ADOulVwTJoUi/sAiz9ZtK8w2viD4rjhrut
	 D9i3Y6uNhiwycdnixMl4s7LJpkZDm8cms93qayAodIiAyjgwWrafVLjoFOFdBCyM0
	 Zm/T1urmGMFG4LTvI6aylFLje7kIpIx+M95k2gfNSC0TUp7CxFJf7utD9sddC+S7D
	 RTtS4r4BpcpCtCkkZ+eXUrbOGkM6Qw8JMyOxy5YV0Q23904i9eTvSgAlON6sTlAZp
	 ZdXwRjXoUu/17pJ2dg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.148.180]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFzr-1sWQGH2qQP-009tk4; Wed, 03
 Jul 2024 18:01:00 +0200
From: Ronald Wahl <rwahl@gmx.de>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ks8851: Fix deadlock with the SPI chip variant
Date: Wed,  3 Jul 2024 18:00:53 +0200
Message-ID: <20240703160053.9892-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hb8Cg3leN6wUrtRM1p9dTOgOlPf4jnME98EIaURLd77AGXedIsC
 Q4zLoEmWcfq33vr6sSCvry63lk99Cb/46Akx8j26I2HM8fglooKU28z21/yiWWSPUdTLCvR
 hNIbMo8mknz+2zT7iR1oVQZXlMq2G/ZokTU6Lj3dS2YwXkizKYqnbCIr96CJUMEDAusUqiS
 7rHCxbbTUGLUARl7O0vFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C08WSY/PR1A=;mpCj2jWlSfR3Xb3SUFfkxH/H3VH
 j00I0TCIA+jHQtHRq3PTRTGVJ3x1QqY96f17bJnODrInew63DWU7obcrw2Q2Mz2jqGIezH8+/
 zIQ5cIPW4sXmetX4YxaAGHsjBkKy4cIEhH3nuOpwQhb+WHGkeGoo3CNPWxYOd2u6Jk0YgmgDC
 nAY8E5gdrqYukLvXLD9yo9Xl0v2qMB6UpdBUDwaN8dULZ4zyXD2HyrXW+hCFq5h40o3UnMNoQ
 Jcx06ABL054ts4F1fXnAK1jVYC9rTII650tBo3zQ9dWkULKEwqwvGwcDScrX56iFpsPGaW/qu
 gp8WKDWVQxqqP4rESdC67R4sDM6nZkmr/96NEhi7zYXtqwcNtgz0lc1AhE6J3Eo/1fjhbQ0Y+
 KItPQ6qlgq6EQWpDW1jE+ZerzPSCkcuF9m24owjrwnASABUniaygbwlZfRcxa/5GGLFyxCrQm
 HGcIoMa7vsIqWnojzAoOcdU6D/1TbeGvw0Rgo4dsUzmuDolZykqnVxCjtZhJBw96NiS/NW3kQ
 oQ0cvNvOQ57QnpeCP7hiAIEDct+JIV34fpvE2JKO0KBJTKdoY2BsNFcnKAYfl0udWSJOUfqOe
 1uT0SiYfQ+y3GaCvoaVV/DEDgb6fcubumW4aXXVRHCjnRBpGoRFM2+GnabAZxQm43b51kPsw8
 x/P5heQDcQ+lkOWOTGNSRI4y0OPlCVncIUQ4pg2h0nE7nIKrvrkfTbTYOs7jsoscRUPiK0HMP
 Bo4XrTRZ+lF+IpWTuG27c9nuDICx4t6kZdtveySgKOKfv3kIQe8XkAvp+gBceAKTDPgrFWe2Z
 cTykTFYgU6UciwC02KLvGe3NfdtrRbRAPGISIMMLlOf/0=

From: Ronald Wahl <ronald.wahl@raritan.com>

When SMP is enabled and spinlocks are actually functional then there is
a deadlock with the 'statelock' spinlock between ks8851_start_xmit_spi
and ks8851_irq:

    watchdog: BUG: soft lockup - CPU#0 stuck for 27s!
    call trace:
      queued_spin_lock_slowpath+0x100/0x284
      do_raw_spin_lock+0x34/0x44
      ks8851_start_xmit_spi+0x30/0xb8
      ks8851_start_xmit+0x14/0x20
      netdev_start_xmit+0x40/0x6c
      dev_hard_start_xmit+0x6c/0xbc
      sch_direct_xmit+0xa4/0x22c
      __qdisc_run+0x138/0x3fc
      qdisc_run+0x24/0x3c
      net_tx_action+0xf8/0x130
      handle_softirqs+0x1ac/0x1f0
      __do_softirq+0x14/0x20
      ____do_softirq+0x10/0x1c
      call_on_irq_stack+0x3c/0x58
      do_softirq_own_stack+0x1c/0x28
      __irq_exit_rcu+0x54/0x9c
      irq_exit_rcu+0x10/0x1c
      el1_interrupt+0x38/0x50
      el1h_64_irq_handler+0x18/0x24
      el1h_64_irq+0x64/0x68
      __netif_schedule+0x6c/0x80
      netif_tx_wake_queue+0x38/0x48
      ks8851_irq+0xb8/0x2c8
      irq_thread_fn+0x2c/0x74
      irq_thread+0x10c/0x1b0
      kthread+0xc8/0xd8
      ret_from_fork+0x10/0x20

This issue has not been identified earlier because tests were done on
a device with SMP disabled and so spinlocks were actually NOPs.

This commit moves the netif_wake_queue call outside the spinlock
protected area.

Fixes: 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overru=
n")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 drivers/net/ethernet/micrel/ks8851_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/eth=
ernet/micrel/ks8851_common.c
index 6453c92f0fa7..60b959126b26 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -348,15 +348,17 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)

 	if (status & IRQ_TXI) {
 		unsigned short tx_space =3D ks8851_rdreg16(ks, KS_TXMIR);
+		bool need_wake_queue;

 		netif_dbg(ks, intr, ks->netdev,
 			  "%s: txspace %d\n", __func__, tx_space);

 		spin_lock(&ks->statelock);
 		ks->tx_space =3D tx_space;
-		if (netif_queue_stopped(ks->netdev))
-			netif_wake_queue(ks->netdev);
+		need_wake_queue =3D netif_queue_stopped(ks->netdev);
 		spin_unlock(&ks->statelock);
+		if (need_wake_queue)
+			netif_wake_queue(ks->netdev);
 	}

 	if (status & IRQ_SPIBEI) {
=2D-
2.45.2


