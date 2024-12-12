Return-Path: <stable+bounces-102932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C899EF56B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E447B18828E4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75924222D46;
	Thu, 12 Dec 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fM6J9ZNa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C521C166;
	Thu, 12 Dec 2024 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023027; cv=none; b=un9C/ElRgKDOfJ2gzDEqHyiJ/pgYElS8PWMEGQ2c9/Nu6ORDWezzTX+uDHOkTowiEtUuMRH08RayEMMwNCOBPy5jzLYMlq2nHeUwG/VXXbm60NlX/I59kY0hnY0Zs1yL/wB4qyOe7RHA7xiCJYcHYMdIZRCCCMGbC7yXS/VfGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023027; c=relaxed/simple;
	bh=cK0DD2UuYfezC81X+C7/Xjw2ASFVVK3EqUAsjgZcI/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=didNPkkLgI5vEq7sS0gQJYjSvkisPa5NYGEdpVMarG1lei96Ubuur3nC8oVnETGIJMNk1iUlUbt/okSeDL/54L7Mpqk+thiAKqj+BIPc3vr9U00dfZVAjSJdCOtagisOaaX7IMK0PQsk/eFM0h34elHvuxCWN1Y+NXzC3l2Zhoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fM6J9ZNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0642BC4CECE;
	Thu, 12 Dec 2024 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023026;
	bh=cK0DD2UuYfezC81X+C7/Xjw2ASFVVK3EqUAsjgZcI/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fM6J9ZNaR10XsVp8N67lojBELOs/4zugQuvzDuRHV8kgv36mM0+hxMzzRKSLQpI1I
	 Us8H+l5mfSBl9HK/mMeBw1dD0dgpzXlcEuAj015vf4SHL31aYNrlpUi2zIK/e/EcPx
	 LenGV0dltcmFl9bx0VAfe+tpid1JQ1o+06KS7oFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Maxime Ripard <mripard@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Stephane Grosjean <s.grosjean@peak-system.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Sasha Levin <sashal@kernel.org>,
	Jimmy Assarsson <extja@kvaser.com>,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
Subject: [PATCH 5.15 401/565] can: do not increase rx statistics when generating a CAN rx error message frame
Date: Thu, 12 Dec 2024 15:59:56 +0100
Message-ID: <20241212144327.501472646@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

[ Upstream commit 676068db69b847f06fe054fca15bf6b107bd24da ]

The CAN error message frames (i.e. error skb) are an interface
specific to socket CAN. The payload of the CAN error message frames
does not correspond to any actual data sent on the wire. Only an error
flag and a delimiter are transmitted when an error occurs (c.f. ISO
11898-1 section 10.4.4.2 "Error flag").

For this reason, it makes no sense to increment the rx_packets and
rx_bytes fields of struct net_device_stats because no actual payload
were transmitted on the wire.

This patch fixes all the CAN drivers.

Link: https://lore.kernel.org/all/20211207121531.42941-2-mailhol.vincent@wanadoo.fr
CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
CC: Maxime Ripard <mripard@kernel.org>
CC: Chen-Yu Tsai <wens@csie.org>
CC: Jernej Skrabec <jernej.skrabec@gmail.com>
CC: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
CC: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
CC: Michal Simek <michal.simek@xilinx.com>
CC: Stephane Grosjean <s.grosjean@peak-system.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com> # kvaser
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Acked-by: Stefan Mätje <stefan.maetje@esd.eu> # esd_usb2
Tested-by: Stefan Mätje <stefan.maetje@esd.eu> # esd_usb2
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: 9e66242504f4 ("can: c_can: c_can_handle_bus_err(): update statistics if skb allocation fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/at91_can.c                        | 6 ------
 drivers/net/can/c_can/c_can_main.c                | 5 -----
 drivers/net/can/cc770/cc770.c                     | 3 ---
 drivers/net/can/dev/dev.c                         | 4 ----
 drivers/net/can/dev/rx-offload.c                  | 6 ++++--
 drivers/net/can/ifi_canfd/ifi_canfd.c             | 5 -----
 drivers/net/can/kvaser_pciefd.c                   | 5 -----
 drivers/net/can/m_can/m_can.c                     | 7 -------
 drivers/net/can/mscan/mscan.c                     | 9 +++++----
 drivers/net/can/pch_can.c                         | 3 ---
 drivers/net/can/peak_canfd/peak_canfd.c           | 4 ----
 drivers/net/can/rcar/rcar_can.c                   | 6 +-----
 drivers/net/can/rcar/rcar_canfd.c                 | 4 ----
 drivers/net/can/sja1000/sja1000.c                 | 2 --
 drivers/net/can/sun4i_can.c                       | 7 ++-----
 drivers/net/can/usb/ems_usb.c                     | 2 --
 drivers/net/can/usb/esd_usb2.c                    | 2 --
 drivers/net/can/usb/etas_es58x/es58x_core.c       | 7 -------
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  | 2 --
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 8 --------
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 4 ----
 drivers/net/can/usb/peak_usb/pcan_usb.c           | 2 --
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c        | 3 ---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c       | 2 --
 drivers/net/can/usb/ucan.c                        | 6 ++++--
 drivers/net/can/usb/usb_8dev.c                    | 2 --
 drivers/net/can/xilinx_can.c                      | 9 +--------
 27 files changed, 17 insertions(+), 108 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index b06af90a99640..26cb3d8869789 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -553,8 +553,6 @@ static void at91_rx_overflow_err(struct net_device *dev)
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_receive_skb(skb);
 }
 
@@ -779,8 +777,6 @@ static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 
 	at91_poll_err_frame(dev, cf, reg_sr);
 
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += cf->len;
 	netif_receive_skb(skb);
 
 	return 1;
@@ -1037,8 +1033,6 @@ static void at91_irq_err(struct net_device *dev)
 
 	at91_irq_err_state(dev, cf, new_state);
 
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += cf->len;
 	netif_rx(skb);
 
 	priv->can.state = new_state;
diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index 8ab43f1272bd9..d9595eb3e125f 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -919,7 +919,6 @@ static int c_can_handle_state_change(struct net_device *dev,
 	unsigned int reg_err_counter;
 	unsigned int rx_err_passive;
 	struct c_can_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	struct can_berr_counter bec;
@@ -995,8 +994,6 @@ static int c_can_handle_state_change(struct net_device *dev,
 		break;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_receive_skb(skb);
 
 	return 1;
@@ -1068,8 +1065,6 @@ static int c_can_handle_bus_err(struct net_device *dev,
 		break;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_receive_skb(skb);
 	return 1;
 }
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index f8a130f594e2e..a5fd8ccedec21 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -499,7 +499,6 @@ static void cc770_rx(struct net_device *dev, unsigned int mo, u8 ctrl1)
 static int cc770_err(struct net_device *dev, u8 status)
 {
 	struct cc770_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	u8 lec;
@@ -571,8 +570,6 @@ static int cc770_err(struct net_device *dev, u8 status)
 	}
 
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 94916f2d24d41..62d3e4d1fe99e 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -136,7 +136,6 @@ EXPORT_SYMBOL_GPL(can_change_state);
 static void can_restart(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	int err;
@@ -156,9 +155,6 @@ static void can_restart(struct net_device *dev)
 
 	cf->can_id |= CAN_ERR_RESTARTED;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
-
 	netif_rx_ni(skb);
 
 restart:
diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 37b0cc65237b7..7dbf46b9ca5dd 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -54,8 +54,10 @@ static int can_rx_offload_napi_poll(struct napi_struct *napi, int quota)
 		struct can_frame *cf = (struct can_frame *)skb->data;
 
 		work_done++;
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
+		if (!(cf->can_id & CAN_ERR_FLAG)) {
+			stats->rx_packets++;
+			stats->rx_bytes += cf->len;
+		}
 		netif_receive_skb(skb);
 	}
 
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 5bb957a26bc69..e8318e984bf2f 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -430,8 +430,6 @@ static int ifi_canfd_handle_lec_err(struct net_device *ndev)
 	       priv->base + IFI_CANFD_INTERRUPT);
 	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CTR);
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_receive_skb(skb);
 
 	return 1;
@@ -456,7 +454,6 @@ static int ifi_canfd_handle_state_change(struct net_device *ndev,
 					 enum can_state new_state)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
-	struct net_device_stats *stats = &ndev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	struct can_berr_counter bec;
@@ -522,8 +519,6 @@ static int ifi_canfd_handle_state_change(struct net_device *ndev,
 		break;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_receive_skb(skb);
 
 	return 1;
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 477bc56b12060..26bc8c7ad75b9 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1327,9 +1327,6 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	cf->data[6] = bec.txerr;
 	cf->data[7] = bec.rxerr;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
-
 	netif_rx(skb);
 	return 0;
 }
@@ -1524,8 +1521,6 @@ static void kvaser_pciefd_handle_nack_packet(struct kvaser_pciefd_can *can,
 
 	if (skb) {
 		cf->can_id |= CAN_ERR_BUSERROR;
-		stats->rx_bytes += cf->len;
-		stats->rx_packets++;
 		netif_rx(skb);
 	} else {
 		stats->rx_dropped++;
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a87f6ce86cea3..abc3907feb739 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -653,9 +653,6 @@ static int m_can_handle_lec_err(struct net_device *dev,
 		break;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
-
 	if (cdev->is_peripheral)
 		timestamp = m_can_get_timestamp(cdev);
 
@@ -712,7 +709,6 @@ static int m_can_handle_state_change(struct net_device *dev,
 				     enum can_state new_state)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	struct can_berr_counter bec;
@@ -777,9 +773,6 @@ static int m_can_handle_state_change(struct net_device *dev,
 		break;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
-
 	if (cdev->is_peripheral)
 		timestamp = m_can_get_timestamp(cdev);
 
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index fa32e418eb296..9e1cce0260da6 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -401,13 +401,14 @@ static int mscan_rx_poll(struct napi_struct *napi, int quota)
 			continue;
 		}
 
-		if (canrflg & MSCAN_RXF)
+		if (canrflg & MSCAN_RXF) {
 			mscan_get_rx_frame(dev, frame);
-		else if (canrflg & MSCAN_ERR_IF)
+			stats->rx_packets++;
+			stats->rx_bytes += frame->len;
+		} else if (canrflg & MSCAN_ERR_IF) {
 			mscan_get_err_frame(dev, frame, canrflg);
+		}
 
-		stats->rx_packets++;
-		stats->rx_bytes += frame->len;
 		work_done++;
 		netif_receive_skb(skb);
 	}
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index cd8d536c6fb20..da01ce36ed592 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -561,9 +561,6 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 
 	priv->can.state = state;
 	netif_receive_skb(skb);
-
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 }
 
 static irqreturn_t pch_can_interrupt(int irq, void *dev_id)
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index d08718e98e110..d5b8bc6d29804 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -409,8 +409,6 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 		return -ENOMEM;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	pucan_netif_rx(skb, msg->ts_low, msg->ts_high);
 
 	return 0;
@@ -438,8 +436,6 @@ static int pucan_handle_cache_critical(struct peak_canfd_priv *priv)
 	cf->data[6] = priv->bec.txerr;
 	cf->data[7] = priv->bec.rxerr;
 
-	stats->rx_bytes += cf->len;
-	stats->rx_packets++;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 945b319de841c..68ad7da5c07e0 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -223,7 +223,6 @@ static void tx_failure_cleanup(struct net_device *ndev)
 static void rcar_can_error(struct net_device *ndev)
 {
 	struct rcar_can_priv *priv = netdev_priv(ndev);
-	struct net_device_stats *stats = &ndev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	u8 eifr, txerr = 0, rxerr = 0;
@@ -362,11 +361,8 @@ static void rcar_can_error(struct net_device *ndev)
 		}
 	}
 
-	if (skb) {
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
+	if (skb)
 		netif_rx(skb);
-	}
 }
 
 static void rcar_can_tx_done(struct net_device *ndev)
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4e230e1456647..9d5b8cda8fc54 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1033,8 +1033,6 @@ static void rcar_canfd_error(struct net_device *ndev, u32 cerfl,
 	/* Clear channel error interrupts that are handled */
 	rcar_canfd_write(priv->base, RCANFD_CERFL(ch),
 			 RCANFD_CERFL_ERR(~cerfl));
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
@@ -1176,8 +1174,6 @@ static void rcar_canfd_state_change(struct net_device *ndev,
 		rx_state = txerr <= rxerr ? state : 0;
 
 		can_change_state(ndev, cf, tx_state, rx_state);
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
 		netif_rx(skb);
 	}
 }
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index aae2677e24f99..1e4c797679674 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -488,8 +488,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 			can_bus_off(dev);
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index ad8f50807aca5..ab9adfe92a94b 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -621,13 +621,10 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 			can_bus_off(dev);
 	}
 
-	if (likely(skb)) {
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
+	if (likely(skb))
 		netif_rx(skb);
-	} else {
+	else
 		return -ENOMEM;
-	}
 
 	return 0;
 }
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index a1b7c1a451c0c..0581e70ab903e 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -397,8 +397,6 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 		stats->rx_errors++;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index 1abdf88597de0..14104cb02fb1a 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -301,8 +301,6 @@ static void esd_usb2_rx_event(struct esd_usb2_net_priv *priv,
 		priv->bec.txerr = txerr;
 		priv->bec.rxerr = rxerr;
 
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
 		netif_rx(skb);
 	}
 }
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 0e6faf962ebbc..34d374d301e50 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -849,13 +849,6 @@ int es58x_rx_err_msg(struct net_device *netdev, enum es58x_err error,
 		break;
 	}
 
-	/* driver/net/can/dev.c:can_restart() takes in account error
-	 * messages in the RX stats. Doing the same here for
-	 * consistency.
-	 */
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += CAN_ERR_DLC;
-
 	if (cf) {
 		if (cf->data[1])
 			cf->can_id |= CAN_ERR_CRTL;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 95ed200553929..f6cb5ba61ac93 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -315,8 +315,6 @@ int kvaser_usb_can_rx_over_error(struct net_device *netdev)
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 562105b8a6327..684c9685ba613 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -922,7 +922,6 @@ static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 	struct net_device *netdev = priv->netdev;
 	struct can_frame *cf;
 	struct sk_buff *skb;
-	struct net_device_stats *stats;
 	enum can_state new_state, old_state;
 
 	old_state = priv->can.state;
@@ -974,9 +973,6 @@ static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 		cf->data[7] = bec->rxerr;
 	}
 
-	stats = &netdev->stats;
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
@@ -1131,8 +1127,6 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 		cf->data[7] = bec.rxerr;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 
 	priv->bec.txerr = bec.txerr;
@@ -1166,8 +1160,6 @@ static void kvaser_usb_hydra_one_shot_fail(struct kvaser_usb_net_priv *priv,
 	}
 
 	stats->tx_errors++;
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index ad3103391c793..43ec056646661 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -907,8 +907,6 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 		if (skb) {
 			cf->can_id |= CAN_ERR_RESTARTED;
 
-			stats->rx_packets++;
-			stats->rx_bytes += cf->len;
 			netif_rx(skb);
 		} else {
 			netdev_err(priv->netdev,
@@ -1131,8 +1129,6 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		cf->data[7] = es->rxerr;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index af8d3dadbbb8b..d7adc313a6eda 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -520,8 +520,6 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 				     &hwts->hwtstamp);
 	}
 
-	mc->netdev->stats.rx_packets++;
-	mc->netdev->stats.rx_bytes += cf->len;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 6bd12549f1014..185f5a98d2177 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -577,9 +577,6 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 	if (!skb)
 		return -ENOMEM;
 
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += cf->len;
-
 	peak_usb_netif_rx_64(skb, le32_to_cpu(sm->ts_low),
 			     le32_to_cpu(sm->ts_high));
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 858ab22708fcd..f6d19879bf404 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -660,8 +660,6 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 
 	hwts = skb_hwtstamps(skb);
 	peak_usb_get_ts_time(&usb_if->time_ref, le32_to_cpu(er->ts32), &hwts->hwtstamp);
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += can_frame->len;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 1679cbe45ded2..d582c39fc8d0e 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -621,8 +621,10 @@ static void ucan_rx_can_msg(struct ucan_priv *up, struct ucan_message_in *m)
 		memcpy(cf->data, m->msg.can_msg.data, cf->len);
 
 	/* don't count error frames as real packets */
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
+	if (!(cf->can_id & CAN_ERR_FLAG)) {
+		stats->rx_packets++;
+		stats->rx_bytes += cf->len;
+	}
 
 	/* pass it to Linux */
 	netif_rx(skb);
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index a5dee2ee24656..3dbb689535d1e 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -450,8 +450,6 @@ static void usb_8dev_rx_err_msg(struct usb_8dev_priv *priv,
 	priv->bec.txerr = txerr;
 	priv->bec.rxerr = rxerr;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index a2e751f0ae0b1..cb48598e32ad8 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -966,13 +966,8 @@ static void xcan_update_error_state_after_rxtx(struct net_device *ndev)
 
 		xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
 
-		if (skb) {
-			struct net_device_stats *stats = &ndev->stats;
-
-			stats->rx_packets++;
-			stats->rx_bytes += cf->len;
+		if (skb)
 			netif_rx(skb);
-		}
 	}
 }
 
@@ -1096,8 +1091,6 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		if (skb) {
 			skb_cf->can_id |= cf.can_id;
 			memcpy(skb_cf->data, cf.data, CAN_ERR_DLC);
-			stats->rx_packets++;
-			stats->rx_bytes += CAN_ERR_DLC;
 			netif_rx(skb);
 		}
 	}
-- 
2.43.0




