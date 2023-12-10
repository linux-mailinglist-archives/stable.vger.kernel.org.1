Return-Path: <stable+bounces-5198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76380BA3F
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 12:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA441C20917
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC41B8493;
	Sun, 10 Dec 2023 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="tbRxF4EI"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4FD1;
	Sun, 10 Dec 2023 03:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702206128; x=1702810928; i=rwahl@gmx.de;
	bh=umoV7rOUxfbzITiKQLobTxX64+i9fe0nWUeWUl30t38=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=tbRxF4EIP8gAjRaD0p/eTQ3hbBAUxh+iCcUG735ZYqsZ8QHorkFEhr7pEnXYWP0X
	 ++rWQyWeRb/wxtxOhj4oubIcH3pAVHN7g3NwtCRMnqC5UACfYgHF/CD+ttwOZBhdb
	 KpgZojHX30MYwkJHdqjhJwBIJeqFrjKSbG6DLCBx96/foFosCi0+DaCLqaauGmHFy
	 ZsRZNs5GeeFot2Ufr9Q7+d7QeAdug0dHHd67i1cogacWCB87VpI8YwPT8UwwKCEgv
	 qJgyZ0uw7ekpVxuCkA4Q5ALchuVUnZIHAdVMnkC/mhXQGgT/D24Q8Hls/Jb1QqD0F
	 X2NBwhqXGugeNUOOkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.159.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1r4t2t1aqF-00D0OA; Sun, 10
 Dec 2023 12:02:08 +0100
From: Ronald Wahl <rwahl@gmx.de>
To: rwahl@gmx.de
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: ks8851: Fix TX stall caused by TX buffer overrun
Date: Sun, 10 Dec 2023 12:01:29 +0100
Message-ID: <20231210110130.935911-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YhUQ+G+3yiK4Zntu6DyMKg01202gIqNCj6TaJswXKXOVEGtwiDx
 6XRcYfTCfnA/cVQdQeZaXmS617TuLfUuhI0kCfa4ay7dolR/dIHBLmzJ//lLFo0v+gJqFA9
 5kg9EanSgLX2GYq1yM0Vm/ykQT/ftr/HPTWL3kK7rz4c8h7+0C9iyzu8NBuko3ginYkvSuS
 z0forCvrCTsBlZ4GCoKxA==
UI-OutboundReport: notjunk:1;M01:P0:JBLd1JxHl84=;BA5ofJUH8pPhHBFPdMD1zOhw4lZ
 JdeWJPeTMEemNE82UxH30UldL9F/tMAkZrbc4unhBNmuGYUoT/nvIZXmvYURazz16MKGQvvm+
 7mTxgDGcmlRfNpMUaIv+D3rAuqISGPL+0A4NKimwx8cwkN28p5xmKpX2GC60Xmiu/wj2YlIHo
 LaTwAjeTjbA1ArMlIrcoZlfxSFV0GxkZocUAkadkSAxXqBqdk06xAKTT572vbHpB1ARsqrQZJ
 sUj/pTLdefCOPnRG7DHqZjy5Qmr2bRUo9Qb2VLysFhqxoQ/zWNCivWeMTEM/doBgAKkX4iWvd
 5QCPfGy2kuDmHqJq++yqrGE3Ext8qm3xbhyUEtssn0uUPa+x1//pRxypENeJ0wSRASADvZ2c0
 iaBoZ3WOD4kOF65vwpvqkpUBtYla0bL5MgUSq2pAWs9BgfXKjoSomUIuQanMtlNyaQ0SEIBHN
 7JpgazDUnVlY3RfIJnA7Vyhrc2LTvz9i1Uh7LXjThhp7tnyABk5SXd7skLoxW/7F4lTs8rzYP
 LyRvSpU51ubbSN6ZMA+mgQ5KTqR/Bk9KEcvc/8UqNqGg0V31xw2qDItPLWDYq3lm3Tgzq7ldP
 nv4zzJAkOTV4BPoqhGr1kb1KOSzbVMk3M548m0bMnUz39ugku7gN4WPcaxn0HMPwL04DPCzjX
 V20z89MmDWqUsarEg1O5Oq3EaKZ7NTd/NithcjopWnww0YE84hobAc7MeJE7BTEt2rNXViGc/
 bTiL0w+foPkXMKLruFHVD/T4zcImb/dk9GyVANYqwkAM+zt79MidBsr+JQS1Lvzo+H+hYnUkq
 s57Ps5G5daEsG6N3hab64U6e6Tv4jZrvaIHrmd5pO0Lk92L02Fy0yiRTJoeh3doClroi9RIBq
 vX5lhzQcwRZM5932Bi0/0aSM8RfsC9fMQ8QQxOQYQTjY7Q/10Kzx/b/DftGPHmVC9PLIaysyg
 yZSWoNmlS1Gb41KYiL4w/90UwuE=

From: Ronald Wahl <ronald.wahl@raritan.com>

There is a bug in the ks8851 Ethernet driver that more data is written
to the hardware TX buffer than actually available. This is caused by
wrong accounting of the free TX buffer space.

The driver maintains a tx_space variable that represents the TX buffer
space that is deemed to be free. The ks8851_start_xmit_spi() function
adds an SKB to a queue if tx_space is large enough and reduces tx_space
by the amount of buffer space it will later need in the TX buffer and
then schedules a work item. If there is not enough space then the TX
queue is stopped.

The worker function ks8851_tx_work() dequeues all the SKBs and writes
the data into the hardware TX buffer. The last packet will trigger an
interrupt after it was send. Here it is assumed that all data fits into
the TX buffer.

In the interrupt routine (which runs asynchronously because it is a
threaded interrupt) tx_space is updated with the current value from the
hardware. Also the TX queue is woken up again.

Now it could happen that after data was sent to the hardware and before
handling the TX interrupt new data is queued in ks8851_start_xmit_spi()
when the TX buffer space had still some space left. When the interrupt
is actually handled tx_space is updated from the hardware but now we
already have new SKBs queued that have not been written to the hardware
TX buffer yet. Since tx_space has been overwritten by the value from the
hardware the space is not accounted for.

Now we have more data queued then buffer space available in the hardware
and ks8851_tx_work() will potentially overrun the hardware TX buffer. In
many cases it will still work because often the buffer is written out
fast enough so that no overrun occurs but for example if the peer
throttles us via flow control then an overrun may happen.

This can be fixed in different ways. The most simple way would be to set
tx_space to 0 before writing data to the hardware TX buffer preventing
the queuing of more SKBs until the TX interrupt has been handled. I have
choosen a slightly more efficient (and still rather simple) way and
track the amount of data that is already queued and not yet written to
the hardware. When new SKBs are to be queued the already queued amount
of data is honoured when checking free TX buffer space.

I tested this with a setup of two linked KS8851 running iperf3 between
the two in bidirectional mode. Before the fix I got a stall after some
minutes. With the fix I saw now issues anymore after hours.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 drivers/net/ethernet/micrel/ks8851.h        |  1 +
 drivers/net/ethernet/micrel/ks8851_common.c | 21 +++++------
 drivers/net/ethernet/micrel/ks8851_spi.c    | 41 +++++++++++++--------
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/m=
icrel/ks8851.h
index fecd43754cea..ce7e524f2542 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851.h
+++ b/drivers/net/ethernet/micrel/ks8851.h
@@ -399,6 +399,7 @@ struct ks8851_net {
 	struct work_struct	rxctrl_work;

 	struct sk_buff_head	txq;
+	unsigned int		queued_len;

 	struct eeprom_93cx6	eeprom;
 	struct regulator	*vdd_reg;
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/eth=
ernet/micrel/ks8851_common.c
index cfbc900d4aeb..daab9358124b 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -362,16 +362,17 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		handled |=3D IRQ_RXPSI;

 	if (status & IRQ_TXI) {
-		handled |=3D IRQ_TXI;
-
-		/* no lock here, tx queue should have been stopped */
+		unsigned short tx_space =3D ks8851_rdreg16(ks, KS_TXMIR);
+		netif_dbg(ks, intr, ks->netdev,
+			  "%s: txspace %d\n", __func__, tx_space);

-		/* update our idea of how much tx space is available to the
-		 * system */
-		ks->tx_space =3D ks8851_rdreg16(ks, KS_TXMIR);
+		spin_lock(&ks->statelock);
+		ks->tx_space =3D tx_space;
+		if (netif_queue_stopped(ks->netdev))
+			netif_wake_queue(ks->netdev);
+		spin_unlock(&ks->statelock);

-		netif_dbg(ks, intr, ks->netdev,
-			  "%s: txspace %d\n", __func__, ks->tx_space);
+		handled |=3D IRQ_TXI;
 	}

 	if (status & IRQ_RXI)
@@ -414,9 +415,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);

-	if (status & IRQ_TXI)
-		netif_wake_queue(ks->netdev);
-
 	return IRQ_HANDLED;
 }

@@ -500,6 +498,7 @@ static int ks8851_net_open(struct net_device *dev)
 	ks8851_wrreg16(ks, KS_ISR, ks->rc_ier);
 	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);

+	ks->queued_len =3D 0;
 	netif_start_queue(ks->netdev);

 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethern=
et/micrel/ks8851_spi.c
index 70bc7253454f..eb089b3120bc 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -286,6 +286,18 @@ static void ks8851_wrfifo_spi(struct ks8851_net *ks, =
struct sk_buff *txp,
 		netdev_err(ks->netdev, "%s: spi_sync() failed\n", __func__);
 }

+/**
+ * calc_txlen - calculate size of message to send packet
+ * @len: Length of data
+ *
+ * Returns the size of the TXFIFO message needed to send
+ * this packet.
+ */
+static unsigned int calc_txlen(unsigned int len)
+{
+	return ALIGN(len + 4, 4);
+}
+
 /**
  * ks8851_rx_skb_spi - receive skbuff
  * @ks: The device state
@@ -310,6 +322,8 @@ static void ks8851_tx_work(struct work_struct *work)
 	unsigned long flags;
 	struct sk_buff *txb;
 	bool last;
+	unsigned short tx_space;
+	unsigned int dequeued_len =3D 0;

 	kss =3D container_of(work, struct ks8851_net_spi, tx_work);
 	ks =3D &kss->ks8851;
@@ -320,6 +334,7 @@ static void ks8851_tx_work(struct work_struct *work)
 	while (!last) {
 		txb =3D skb_dequeue(&ks->txq);
 		last =3D skb_queue_empty(&ks->txq);
+		dequeued_len +=3D calc_txlen(txb->len);

 		if (txb) {
 			ks8851_wrreg16_spi(ks, KS_RXQCR,
@@ -332,6 +347,13 @@ static void ks8851_tx_work(struct work_struct *work)
 		}
 	}

+	tx_space =3D ks8851_rdreg16_spi(ks, KS_TXMIR);
+
+	spin_lock(&ks->statelock);
+	ks->queued_len -=3D dequeued_len;
+	ks->tx_space =3D tx_space;
+	spin_unlock(&ks->statelock);
+
 	ks8851_unlock_spi(ks, &flags);
 }

@@ -346,18 +368,6 @@ static void ks8851_flush_tx_work_spi(struct ks8851_ne=
t *ks)
 	flush_work(&kss->tx_work);
 }

-/**
- * calc_txlen - calculate size of message to send packet
- * @len: Length of data
- *
- * Returns the size of the TXFIFO message needed to send
- * this packet.
- */
-static unsigned int calc_txlen(unsigned int len)
-{
-	return ALIGN(len + 4, 4);
-}
-
 /**
  * ks8851_start_xmit_spi - transmit packet using SPI
  * @skb: The buffer to transmit
@@ -386,16 +396,17 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_b=
uff *skb,

 	spin_lock(&ks->statelock);

-	if (needed > ks->tx_space) {
+	if (ks->queued_len + needed > ks->tx_space) {
 		netif_stop_queue(dev);
 		ret =3D NETDEV_TX_BUSY;
 	} else {
-		ks->tx_space -=3D needed;
+		ks->queued_len +=3D needed;
 		skb_queue_tail(&ks->txq, skb);
 	}

 	spin_unlock(&ks->statelock);
-	schedule_work(&kss->tx_work);
+	if (ret =3D=3D NETDEV_TX_OK)
+		schedule_work(&kss->tx_work);

 	return ret;
 }
=2D-
2.43.0


