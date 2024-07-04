Return-Path: <stable+bounces-58083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3708927C7B
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029641C22314
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FDB49628;
	Thu,  4 Jul 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="V1y7+Gtz"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7C4C70;
	Thu,  4 Jul 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115307; cv=none; b=TIpK0VXTp6AMajEUbn5wZiEpeS2ql5EUHESblBf1EsZ84WLGMzYVZL5mktfodzJl9WZpWTRsmxSJs3WaOIkgi6DjMZaaXPu4oi1WFLQ5J96OFGwGSTDGACTluFvoph2jInD2aKMifR9XF+kg5H/THoRupTFAeZq3gfRwNZCIIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115307; c=relaxed/simple;
	bh=Yc0zNpZ7yoOoesJaCOQkk0Xhy57Zg/icg5CJTpzqzNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4jo81Nhks5zvHtuwag5/cS8ttvtdT/2ilRjiy90tyoKl00put9NQJTdAK3dJnQeWjnJrp/p2Db4sIuYpO5jI4GOUTijiuNm6knx1tECOGgGJ70iA9GWbS3jWsu7NkPvYu2t8lwN/a1A5Purc6LzvSB3StaA4wDc3gBUU9Mh6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b=V1y7+Gtz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720115288; x=1720720088; i=rwahl@gmx.de;
	bh=7LDXHLNLfnxrAFNgMdyIX1fCxVRtyyU9V4pGYiZPxgM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V1y7+GtzHpKpxUmUvK/fezAADG0iHuLRFGAf9Q3aKNSqF1jq3bUKagSn83WWD1cU
	 zqXA0IYJr3Tz/rSYZX/CPo2MK+FiLZvH/CYuZeGGDiSj9jLBrpPAGgY2llCSCrYPl
	 M7Hkh3Fm8TVaCjrmc6jxmgE07+RsUneu92lOJ+Wm8SnITZ29tTijn28VedkLfGZj8
	 Fyk28iM6KKMahpgC+2mopDBXb0p1gIXxHYDonBwMBxTvdVk0wFxNpzhPIv/Hcq9N7
	 kFk4T9dWrzAK1ykE902TLSpQ4DNkI8Lb4hIoXEJzwj52+z8gs5zfHjUzBsvo2jdUm
	 BfcFLSlmtjzpCY9MgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.148.180]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf0U-1ryJI20jj8-00kV1L; Thu, 04
 Jul 2024 19:48:08 +0200
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
Subject: [PATCH v2] net: ks8851: Fix deadlock with the SPI chip variant
Date: Thu,  4 Jul 2024 19:47:56 +0200
Message-ID: <20240704174756.1225995-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sJYiy9JTOJQCBASi0xLwnIAhQLZHvk0tde4aJDG+y37WRKIC0KC
 sX8LML5acO8eLkl9nNtmZ6UVVw8CR2dBgUmvrGpn05EmV00I3Wu+W1I2/IfGeYdUuS0eP76
 jFYJGLwWUXdZx8QaOImT5mappJHudsGVLoA0Rv6JM/OePeKM1x6g0FlYVaFlvYCv73wQqeL
 76uaJTDPhbuApPkbhq/YQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Z6QciS3880=;uasue+K82X3QyU6E6+U8RXeeebn
 /CLyc6iWjWHqk8UwzRQPESm7vYfpxahRDNz/5uSMJAcZz/1UJfxzE7LCVlAmfpINdeTHao4hV
 5y+sYf7em8YKGxohxBYtqG9AcVQ9Av9SXhKJJbmnU24Bn9J70RBPO1jz72br+BFdGIFf3blNX
 pizKYoSE0l3dRRLQEdFr4UubMvrj/iJrB/w/GQF/l2YuIxIfA3fyDQfVt69Ur2/rkm3dyIK+T
 FqOh+b0KP8byKS0klVyKKRCcwqPvRa0DY0uf9vY/zvO+dkN+s6Fmmk5MhdsrwZQrWs7WVQ0GF
 DbxmTJAn7pCtY/lwRcf0aUuuPq30KGvnppBj0gzbeB2aiyAW+bSXykM0GaH1SGS01u6NjWvxZ
 0isBJmTkIUVqkjwrBbutModsAG469UJCMBb4vBOAEYLio3KL7B+o3UwXyKCxXVuUfgjWBUw1E
 DHbwahicusPoOlBk/F1MTM+rCAokh+a9/KgkR+q53l1V9nMh2X/ov8za07kiUGpeTAOb5jNdQ
 1kN1IIjYxYj6TffL/QvIV+V1S9KSSPB+hHYw5SPK6m9lQkvNOCXXrSuBZS+w4J2cGMfUk+X6/
 0ANZB9xq57xISwub+cldlb7TkHbbhUMM7LlC+pzxh797rhiihQmB5gTXBkQQg6JR4ww35ZgAr
 OZ2XyBbx/g46ukq4Ta/QfVGJNNPCk8xV+pFmIbWGiuiVRoyhvODc01WmXtEw33VZmgCUtvM2d
 0bQWUkJfTPAlrsdi49i11aeZNv94AqKpaI6cVehLTABp75x9Euiab1h/wfQ9o0mWKVz48hpgv
 Ublztoz9RDEGSrTCdW/YpuKtrpB4xgISCFTm/fXjIYWNg=

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

 drivers/net/ethernet/micrel/ks8851_common.c | 4 ++--
 drivers/net/ethernet/micrel/ks8851_spi.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/eth=
ernet/micrel/ks8851_common.c
index 6453c92f0fa7..51fb6c27153e 100644
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
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethern=
et/micrel/ks8851_spi.c
index 670c1de966db..818e1ce3227b 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -385,7 +385,7 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_buf=
f *skb,
 	netif_dbg(ks, tx_queued, ks->netdev,
 		  "%s: skb %p, %d@%p\n", __func__, skb, skb->len, skb->data);

-	spin_lock(&ks->statelock);
+	spin_lock_bh(&ks->statelock);

 	if (ks->queued_len + needed > ks->tx_space) {
 		netif_stop_queue(dev);
@@ -395,7 +395,7 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_buf=
f *skb,
 		skb_queue_tail(&ks->txq, skb);
 	}

-	spin_unlock(&ks->statelock);
+	spin_unlock_bh(&ks->statelock);
 	if (ret =3D=3D NETDEV_TX_OK)
 		schedule_work(&kss->tx_work);

=2D-
2.45.2


