Return-Path: <stable+bounces-6757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F2813985
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223481F21F11
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBC667E8E;
	Thu, 14 Dec 2023 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="CB3UinES"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD9A6;
	Thu, 14 Dec 2023 10:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702577522; x=1703182322; i=rwahl@gmx.de;
	bh=y0gZgjKFDt45sqcpbnkAZQQKNmdiomYQehcJG5hMcjs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=CB3UinESDXsKYAwRzHMB78tCIdcf3Lm4QfR8wvvXCNUxCLyS6W9KoQy20EJW9Ofu
	 4jHbnNo5VQ/NSZlrku1B4CM/HVUdCKgvJPRbTYQYMg9z4udrzMM7uyeKBH0u/qWA+
	 7sPsYgFLoWiZAXoegzcKDUFmpJEIcHN4qmHztGN42Qlw/tZas+fzyJn31HCV+7/xl
	 roSsvGzebexHJk2EoKyu+iwEUuJOsYyVRs6OyHCK3e0jfHWhECkykTpb8sx4VWhgl
	 YqFv60XYu3WStgY29Z/7Q5dMycf0SEhBzeJ5Ge8ERFXvV7iVFe21ViWhBq/Mbd4ai
	 ibOW2flnqN02AzGMtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.159.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbRs-1qz38O0BXK-00HB5C; Thu, 14
 Dec 2023 19:12:02 +0100
From: Ronald Wahl <rwahl@gmx.de>
To: rwahl@gmx.de
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: ks8851: Fix TX stall caused by TX buffer overrun
Date: Thu, 14 Dec 2023 19:11:12 +0100
Message-ID: <20231214181112.76052-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ENGDJNlUJxvTcIvevplJwYp1cjTUUO0/w28Ay6940NVO6AaSpMT
 WCMZxNImz2AkojI+FHXiDjh0hJpgBbwT/zGjOWObsUIlpf6jnZWBxwtQko2+f6KWYRNovAI
 CQI88I6NVAkAqJ1RT0o8vdBX+05/YOkde97U1maY/WxJO2bEVlldEVceLO7gqiOafoL7MbC
 iZCz2aPe5/Mq7ki3E0EIw==
UI-OutboundReport: notjunk:1;M01:P0:GKtxaFjQaCI=;omzPKt/aZcBd4gx3CNLw9Zo1aHr
 Agrs00FZ/ND4HzPFc96iTQQiEMslSv4RWX4i8nec4cI/mlMEfTawZPMo0No/nSOnpgxbs70ay
 7uoYctREy+pZpXUjTMPqCFsLvlijbMRcL+EvIzy69jma4qYDSezWWZnaRriLNmNU6do5vYHOT
 sl+q8gmlAwp9+jgFu1E2R2qwMlnxSqLzRPbdnltdXegSihhLXaHlV6Zl2ELYoUFVSNo2xl8R8
 anyEr3Nf1egSJXuJMXhrSux4/VNLiOOHwBNqw6ftYbxy50/BWebme+bqAQ7TvdMbmOrijTvF8
 loCyE6Jluz7eCIdrn9ukUKK8xmPz/k7hMRtGEae3ZeZdn5NkicL55IhBhFFPsXhw3CbbEJTrM
 xczulOZNqKM2zDjQ0iS3WbLqvy6PJH6MzBNxBj3hHfDncLLdt7OJlRH6LkaHFcpbCDY5vsZX7
 A2tYnCS6TDXZzQyZuFcYKJb/iq4K1npGTD/7JlsrzyNrdcJJPJ1SlNHGcjr4hvV3YmkOC6k4E
 gM5AuhNgP2kf8EEmg1eamg25kV+iL4ILodSpQGhp9X2FUQb12jr8UVTF46YEEgcggr4mx7eDA
 i/WIkoNuG3ZFVIJIQnviqzC/zrdfSfoLttHjacvoumlhrb4pucsyIIQ4m7i5WrUs4sru1BGNe
 MzKcGvz1PVf4C4/Wbj1cBTb1i5U27cIX+9yqmR4dr3ed3mdPMTjy6wT5CPHSGM4byhQZcyvep
 RfCnaTby//dwjS1C3ljUQhwqHEeonTbGw6FMvLv7HU/T1aR1GMVsl5UBJcQSAxokdvUBlQN6q
 pR6DaUkXth9Zd2iaOLT5bPzu8eR9m+MGbDhHD+jXCs3XUCdyxvb2xQOrYdR2jHcaY1PJnD8xH
 HHyA9jUSXbk+hf4Sty3smy4WvjE4hb2h0E3K85LYbbd5aXhJ4LOenaHYODVoSKgwvSmJ8IDad
 uY95Rw==

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
chosen a slightly more efficient (and still rather simple) way and
track the amount of data that is already queued and not yet written to
the hardware. When new SKBs are to be queued the already queued amount
of data is honoured when checking free TX buffer space.

I tested this with a setup of two linked KS8851 running iperf3 between
the two in bidirectional mode. Before the fix I got a stall after some
minutes. With the fix I saw now issues anymore after hours.

Fixes: 3ba81f3ece3c ("net: Micrel KS8851 SPI network driver")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
V3: - Add missing kdoc of structure fields
    - Avoid potential NULL pointer dereference
    - Fix stack variable declaration order

V2: - Added Fixes: tag (issue actually present from the beginning)
    - cosmetics reported by checkpatch

 drivers/net/ethernet/micrel/ks8851.h        |  3 ++
 drivers/net/ethernet/micrel/ks8851_common.c | 20 +++++-----
 drivers/net/ethernet/micrel/ks8851_spi.c    | 42 +++++++++++++--------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/m=
icrel/ks8851.h
index fecd43754cea..e5ec0a363aff 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851.h
+++ b/drivers/net/ethernet/micrel/ks8851.h
@@ -350,6 +350,8 @@ union ks8851_tx_hdr {
  * @rxd: Space for receiving SPI data, in DMA-able space.
  * @txd: Space for transmitting SPI data, in DMA-able space.
  * @msg_enable: The message flags controlling driver output (see ethtool)=
.
+ * @tx_space: Free space in the hardware TX buffer (cached copy of KS_TXM=
IR).
+ * @queued_len: Space required in hardware TX buffer for queued packets i=
n txq.
  * @fid: Incrementing frame id tag.
  * @rc_ier: Cached copy of KS_IER.
  * @rc_ccr: Cached copy of KS_CCR.
@@ -399,6 +401,7 @@ struct ks8851_net {
 	struct work_struct	rxctrl_work;

 	struct sk_buff_head	txq;
+	unsigned int		queued_len;

 	struct eeprom_93cx6	eeprom;
 	struct regulator	*vdd_reg;
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/eth=
ernet/micrel/ks8851_common.c
index cfbc900d4aeb..0bf13b38b8f5 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -362,16 +362,18 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		handled |=3D IRQ_RXPSI;

 	if (status & IRQ_TXI) {
-		handled |=3D IRQ_TXI;
+		unsigned short tx_space =3D ks8851_rdreg16(ks, KS_TXMIR);

-		/* no lock here, tx queue should have been stopped */
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
@@ -414,9 +416,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);

-	if (status & IRQ_TXI)
-		netif_wake_queue(ks->netdev);
-
 	return IRQ_HANDLED;
 }

@@ -500,6 +499,7 @@ static int ks8851_net_open(struct net_device *dev)
 	ks8851_wrreg16(ks, KS_ISR, ks->rc_ier);
 	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);

+	ks->queued_len =3D 0;
 	netif_start_queue(ks->netdev);

 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethern=
et/micrel/ks8851_spi.c
index 70bc7253454f..88e26c120b48 100644
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
@@ -305,7 +317,9 @@ static void ks8851_rx_skb_spi(struct ks8851_net *ks, s=
truct sk_buff *skb)
  */
 static void ks8851_tx_work(struct work_struct *work)
 {
+	unsigned int dequeued_len =3D 0;
 	struct ks8851_net_spi *kss;
+	unsigned short tx_space;
 	struct ks8851_net *ks;
 	unsigned long flags;
 	struct sk_buff *txb;
@@ -322,6 +336,8 @@ static void ks8851_tx_work(struct work_struct *work)
 		last =3D skb_queue_empty(&ks->txq);

 		if (txb) {
+			dequeued_len +=3D calc_txlen(txb->len);
+
 			ks8851_wrreg16_spi(ks, KS_RXQCR,
 					   ks->rc_rxqcr | RXQCR_SDA);
 			ks8851_wrfifo_spi(ks, txb, last);
@@ -332,6 +348,13 @@ static void ks8851_tx_work(struct work_struct *work)
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

@@ -346,18 +369,6 @@ static void ks8851_flush_tx_work_spi(struct ks8851_ne=
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
@@ -386,16 +397,17 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_b=
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


