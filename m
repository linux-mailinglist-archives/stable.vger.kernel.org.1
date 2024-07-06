Return-Path: <stable+bounces-58171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA88929270
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 12:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC0E1C20A89
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3F65025E;
	Sat,  6 Jul 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="ET+Pwwsv"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BC81804F;
	Sat,  6 Jul 2024 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720260846; cv=none; b=ZH4CtD6Zyzujjeef4VdTWvk4odWNJqhlaOzxXNvRx1E1MsujCupN1XvSYazrP2hxLVyFgCmYxbdYfeBhYZZEilJZpc2S//nh326Tst3PuZnf9swQ5RVkxcadgeZ8uHUqnHWXQR4TPb7QI68gnyvTsskQvkIRvUAqSRsFDPmQKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720260846; c=relaxed/simple;
	bh=YxzFQTfNZcef/1tEKq+XSz/47xbZZ+JX6yvn+RFS3lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUhOr9W1cnnMLXyWpxFNAWtEJfX78oCo46tRPCXDjL8upuAKNxCx6iDBM64/HYmlk0XT5s4UCGQ++gpyhecozDEM77vVJEzRr2hrNRqCuEn8Fg8E2g7p5+GIDbAniWDM7CmZqv7XpfqN58uxUFb6DrBSDDz1Jn1c396zbG3wYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b=ET+Pwwsv; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720260826; x=1720865626; i=rwahl@gmx.de;
	bh=sKptHKoTuQagbCsE0QBZI7P7LK/i8w9EaJqdov5EZEw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ET+PwwsvIfxpfgbJmOOm9JKQQn4nfb20wJERbacN/IhQ8nEu6Q3G2tKPj0T8vEEK
	 9p3hffqIwwtXDAdJrvpQF7kwnhNE/Kjj/es4qctnAFvcUlvNrz16yxefH32d9reiS
	 Tk8nqBzWFXwZuN9g7zU7Q8hqAGdE9kpjGJkFXHA0ONzgXzndYf3m7g77m8Y5mYlUQ
	 G8SgyyHQgm2Bf27iLlaRLXuzp+AAz6w5CnS/yDGVJM3aT6p/mMYB9adgDwp8r31nE
	 oBJ8ALYOabBCJL6NQj2iORiPbsJ62TXHFYsz7HaP5Y8noV0Rv84oUb/v5KLfYZfmK
	 rkCrpjhZww346PNRog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.148.180]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1sW4pb3l5y-004cP4; Sat, 06
 Jul 2024 12:13:45 +0200
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
Subject: [PATCH v3] net: ks8851: Fix deadlock with the SPI chip variant
Date: Sat,  6 Jul 2024 12:13:37 +0200
Message-ID: <20240706101337.854474-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gg492lsOmKd5XrvljZT0KKFMQnKwwKmB0Yvup+05QLZiWdztdv3
 L92Mfjzad/z005Y30F/2sI7PLNSQbWui2NLDcIkEZxeCb0hJRXZcAK7HYAgyWHpOlrR3oo+
 ClskxQXxL7H8FJXc6IC4U/D/dwqN+3N+DbGcQmz+m6D4dVvTT8kTZT+9iw+f/vy9MD0/2E6
 SJ2a39f7ftUxkdFXnZWhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JEDy5pP0dzI=;Yh6JcwdE4nwR8e84VpykaNYa2La
 dEp6ZVtG19TcJ9kcIURLX+eaTDwFFyqm+7SZC1gY2g+DAQ1uUXeQko5s4JAqNxTmOyZYRalkq
 kny4CUPwuQPwb2gqBK5h/39BvsBByOYq51jf+uwTDRMA2ylFbtox3t4MiA7qokMdwDtcxG0Bm
 4IRBULY0YhqPrBkQm7/FUzPhc+fesAQfDz0vqnh4WUlHjVQGfH2L11ehquqaJhzFejMJkc+Av
 XR5Gcrqcdf1TjbjhzBgCrthglr7NjnqcWzdW47jFVlcmA5KYGAeDeGBuPzmPo7Ft7gfEUYivd
 kdWWYbcGIPbKXZkfVU49jFB9Yt/id6PKO94Uu0oPjSOAC6nCpa34ahlpTpO21lZN3gW9RJeC+
 hyq0zb65f3UFnBd5OiGG/MDu0ibnvuVUfWTEs0+fEx5VC2MMu/1PieB6Tebveifu8y6QUGp06
 7T8XMuR6BHtdgXpqQJENPVqWmi2qce39rhRbsZ6fMIyFcS14l043DiYSDJ8qVCqpphvVEpSXf
 HugImCItPHTAOcSqg4Yk83pH+LZUZd1rf4/CzMxInWglxRYUDIP4d55MlBuVVl0F7YsD24YEq
 Bxm2sT7cIsHsN3mH7UI1r3CzgCD6iJL/l8z+xAaCK6bsbLq1NWh5O2lV6WflTy5yrQkhHFkNb
 aD3mGPi/TDSkoBX4JkrLelJ413R1zNGHQ/M9U2FRShKB6wEsRwfjXKVseZHfz0GguT1KlWtdj
 uNh7xgKRCNiDdd5MQrdvdUTibAZSpEV6XQPKFXZGBMe3aJJswE3HemGnoqQn5vItG0j4pPU0Q
 QJg7NLQ8sfyTYKlHZdOGVvpS5yYXou39jHFu4TUpKkDPY=

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

Now use spin_(un)lock_bh for TX queue related locking to avoid execution
of softirq work synchronously that would lead to a deadlock.

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
V2: - use spin_lock_bh instead of moving netif_wake_queue outside of
      locked region (doing the same in the start_xmit function)
    - add missing net: tag

V3: - spin_lock_bh(ks->statelock) always except in xmit which is in BH
      already

 drivers/net/ethernet/micrel/ks8851_common.c | 8 ++++----
 drivers/net/ethernet/micrel/ks8851_spi.c    | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/eth=
ernet/micrel/ks8851_common.c
index 6453c92f0fa7..13462811eaae 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -352,11 +352,11 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		netif_dbg(ks, intr, ks->netdev,
 			  "%s: txspace %d\n", __func__, tx_space);

-		spin_lock(&ks->statelock);
+		spin_lock_bh(&ks->statelock);
 		ks->tx_space =3D tx_space;
 		if (netif_queue_stopped(ks->netdev))
 			netif_wake_queue(ks->netdev);
-		spin_unlock(&ks->statelock);
+		spin_unlock_bh(&ks->statelock);
 	}

 	if (status & IRQ_SPIBEI) {
@@ -635,14 +635,14 @@ static void ks8851_set_rx_mode(struct net_device *de=
v)

 	/* schedule work to do the actual set of the data if needed */

-	spin_lock(&ks->statelock);
+	spin_lock_bh(&ks->statelock);

 	if (memcmp(&rxctrl, &ks->rxctrl, sizeof(rxctrl)) !=3D 0) {
 		memcpy(&ks->rxctrl, &rxctrl, sizeof(ks->rxctrl));
 		schedule_work(&ks->rxctrl_work);
 	}

-	spin_unlock(&ks->statelock);
+	spin_unlock_bh(&ks->statelock);
 }

 static int ks8851_set_mac_address(struct net_device *dev, void *addr)
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethern=
et/micrel/ks8851_spi.c
index 670c1de966db..3062cc0f9199 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -340,10 +340,10 @@ static void ks8851_tx_work(struct work_struct *work)

 	tx_space =3D ks8851_rdreg16_spi(ks, KS_TXMIR);

-	spin_lock(&ks->statelock);
+	spin_lock_bh(&ks->statelock);
 	ks->queued_len -=3D dequeued_len;
 	ks->tx_space =3D tx_space;
-	spin_unlock(&ks->statelock);
+	spin_unlock_bh(&ks->statelock);

 	ks8851_unlock_spi(ks, &flags);
 }
=2D-
2.45.2


