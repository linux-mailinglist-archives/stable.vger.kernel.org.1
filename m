Return-Path: <stable+bounces-74567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44726972FF9
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2258288A68
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568F318C021;
	Tue, 10 Sep 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wcq4Zhjc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2014F12C;
	Tue, 10 Sep 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962182; cv=none; b=P6P7Hc5gFEltEV7R3P1UEXb48aUrNO2FiVySOKklnjLPeHFcgi4VzCYMsKdQcSsDzkGE7txPopA6uuJ9AtkGbcEnvaGWR1frv3jfvggejl9+Ryam7psY7T5e7+5VSTGl/h6KJRjF2qxdw4mXZ/O70bRAbllVVdlk4qG8O9r1Us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962182; c=relaxed/simple;
	bh=/wq18z9h+1FH9W9fCTWKDOXVu/4+oiv+iTPRW/pgUas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhIKgx40Fpcwd3erODTRSL63WAA1bbGSFpeXVndvoRL5/xCPR74uchxWQA0dQ+BMK8KFhEixsuUl45SEaQRJeIRiaYcnG2nNgycnFK4nXGLhMwHntWbH8xFASRDLRhZcwYhLuwHBG1TfX7R0hTGxNDuQHJIRscTFqZSxCAdCDK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wcq4Zhjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1BEC4CEC3;
	Tue, 10 Sep 2024 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962181;
	bh=/wq18z9h+1FH9W9fCTWKDOXVu/4+oiv+iTPRW/pgUas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wcq4ZhjcgfFCSdDO7rnaO/RlQWMI+I6Fbi1u9qFS9f8ckRXRUzAjfv9RVyX5757tb
	 PZv44pYNPCw5JMF4ZzhgwDSL9P4azqekDu0wOqm4imSYKZs3aHhn3s1N8hlweJEwdg
	 TAEqcC+wc8r+x4w9/A/1RyrwYXH8A3D4T7lZiRk4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 323/375] can: mcp251xfd: clarify the meaning of timestamp
Date: Tue, 10 Sep 2024 11:32:00 +0200
Message-ID: <20240910092633.413286976@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit e793c724b48ca8cae9693bc3be528e85284c126a ]

The mcp251xfd chip is configured to provide a timestamp with each
received and transmitted CAN frame. The timestamp is derived from the
internal free-running timer, which can also be read from the TBC
register via SPI. The timer is 32 bits wide and is clocked by the
external oscillator (typically 20 or 40 MHz).

To avoid confusion, we call this timestamp "timestamp_raw" or "ts_raw"
for short.

Using the timecounter framework, the "ts_raw" is converted to 64 bit
nanoseconds since the epoch. This is what we call "timestamp".

This is a preparation for the next patches which use the "timestamp"
to work around a bug where so far only the "ts_raw" is used.

Tested-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Tested-by: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: 24436be590c6 ("can: mcp251xfd: rx: add workaround for erratum DS80000789E 6 of mcp2518fd")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 28 +++++++++----------
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c  |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c |  2 +-
 .../can/spi/mcp251xfd/mcp251xfd-timestamp.c   | 22 ++++-----------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 27 ++++++++++++++----
 5 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index bf1589aef1fc..f1e6007b74ce 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2019, 2020, 2021 Pengutronix,
+// Copyright (c) 2019, 2020, 2021, 2023 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 // Based on:
@@ -867,18 +867,18 @@ static int mcp251xfd_get_berr_counter(const struct net_device *ndev,
 
 static struct sk_buff *
 mcp251xfd_alloc_can_err_skb(struct mcp251xfd_priv *priv,
-			    struct can_frame **cf, u32 *timestamp)
+			    struct can_frame **cf, u32 *ts_raw)
 {
 	struct sk_buff *skb;
 	int err;
 
-	err = mcp251xfd_get_timestamp(priv, timestamp);
+	err = mcp251xfd_get_timestamp_raw(priv, ts_raw);
 	if (err)
 		return NULL;
 
 	skb = alloc_can_err_skb(priv->ndev, cf);
 	if (skb)
-		mcp251xfd_skb_set_timestamp(priv, skb, *timestamp);
+		mcp251xfd_skb_set_timestamp_raw(priv, skb, *ts_raw);
 
 	return skb;
 }
@@ -889,7 +889,7 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
 	struct mcp251xfd_rx_ring *ring;
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	u32 timestamp, rxovif;
+	u32 ts_raw, rxovif;
 	int err, i;
 
 	stats->rx_over_errors++;
@@ -924,14 +924,14 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
 			return err;
 	}
 
-	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &ts_raw);
 	if (!skb)
 		return 0;
 
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -948,12 +948,12 @@ static int mcp251xfd_handle_txatif(struct mcp251xfd_priv *priv)
 static int mcp251xfd_handle_ivmif(struct mcp251xfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
-	u32 bdiag1, timestamp;
+	u32 bdiag1, ts_raw;
 	struct sk_buff *skb;
 	struct can_frame *cf = NULL;
 	int err;
 
-	err = mcp251xfd_get_timestamp(priv, &timestamp);
+	err = mcp251xfd_get_timestamp_raw(priv, &ts_raw);
 	if (err)
 		return err;
 
@@ -1035,8 +1035,8 @@ static int mcp251xfd_handle_ivmif(struct mcp251xfd_priv *priv)
 	if (!cf)
 		return 0;
 
-	mcp251xfd_skb_set_timestamp(priv, skb, timestamp);
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	mcp251xfd_skb_set_timestamp_raw(priv, skb, ts_raw);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -1049,7 +1049,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 	struct sk_buff *skb;
 	struct can_frame *cf = NULL;
 	enum can_state new_state, rx_state, tx_state;
-	u32 trec, timestamp;
+	u32 trec, ts_raw;
 	int err;
 
 	err = regmap_read(priv->map_reg, MCP251XFD_REG_TREC, &trec);
@@ -1079,7 +1079,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 	/* The skb allocation might fail, but can_change_state()
 	 * handles cf == NULL.
 	 */
-	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &ts_raw);
 	can_change_state(priv->ndev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
@@ -1110,7 +1110,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 		cf->data[7] = bec.rxerr;
 	}
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index 5d0fb1c454cd..a79e6c661ecc 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
@@ -160,7 +160,7 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 	if (!(hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_RTR))
 		memcpy(cfd->data, hw_rx_obj->data, cfd->len);
 
-	mcp251xfd_skb_set_timestamp(priv, skb, hw_rx_obj->ts);
+	mcp251xfd_skb_set_timestamp_raw(priv, skb, hw_rx_obj->ts);
 }
 
 static int
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index 5b0c7890d4b4..3886476a8f8e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -97,7 +97,7 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	tef_tail = mcp251xfd_get_tef_tail(priv);
 	skb = priv->can.echo_skb[tef_tail];
 	if (skb)
-		mcp251xfd_skb_set_timestamp(priv, skb, hw_tef_obj->ts);
+		mcp251xfd_skb_set_timestamp_raw(priv, skb, hw_tef_obj->ts);
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
 							    tef_tail, hw_tef_obj->ts,
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 712e09186987..1db99aabe85c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2021 Pengutronix,
+// Copyright (c) 2021, 2023 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 
@@ -11,20 +11,20 @@
 
 #include "mcp251xfd.h"
 
-static u64 mcp251xfd_timestamp_read(const struct cyclecounter *cc)
+static u64 mcp251xfd_timestamp_raw_read(const struct cyclecounter *cc)
 {
 	const struct mcp251xfd_priv *priv;
-	u32 timestamp = 0;
+	u32 ts_raw = 0;
 	int err;
 
 	priv = container_of(cc, struct mcp251xfd_priv, cc);
-	err = mcp251xfd_get_timestamp(priv, &timestamp);
+	err = mcp251xfd_get_timestamp_raw(priv, &ts_raw);
 	if (err)
 		netdev_err(priv->ndev,
 			   "Error %d while reading timestamp. HW timestamps may be inaccurate.",
 			   err);
 
-	return timestamp;
+	return ts_raw;
 }
 
 static void mcp251xfd_timestamp_work(struct work_struct *work)
@@ -39,21 +39,11 @@ static void mcp251xfd_timestamp_work(struct work_struct *work)
 			      MCP251XFD_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
-void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
-				 struct sk_buff *skb, u32 timestamp)
-{
-	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
-	u64 ns;
-
-	ns = timecounter_cyc2time(&priv->tc, timestamp);
-	hwtstamps->hwtstamp = ns_to_ktime(ns);
-}
-
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv)
 {
 	struct cyclecounter *cc = &priv->cc;
 
-	cc->read = mcp251xfd_timestamp_read;
+	cc->read = mcp251xfd_timestamp_raw_read;
 	cc->mask = CYCLECOUNTER_MASK(32);
 	cc->shift = 1;
 	cc->mult = clocksource_hz2mult(priv->can.clock.freq, cc->shift);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 2e5cee6ad0c4..ae35845d4ce1 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -2,7 +2,7 @@
  *
  * mcp251xfd - Microchip MCP251xFD Family CAN controller driver
  *
- * Copyright (c) 2019, 2020, 2021 Pengutronix,
+ * Copyright (c) 2019, 2020, 2021, 2023 Pengutronix,
  *               Marc Kleine-Budde <kernel@pengutronix.de>
  * Copyright (c) 2019 Martin Sperl <kernel@martin.sperl.org>
  */
@@ -812,10 +812,27 @@ mcp251xfd_spi_cmd_write(const struct mcp251xfd_priv *priv,
 	return data;
 }
 
-static inline int mcp251xfd_get_timestamp(const struct mcp251xfd_priv *priv,
-					  u32 *timestamp)
+static inline int mcp251xfd_get_timestamp_raw(const struct mcp251xfd_priv *priv,
+					      u32 *ts_raw)
 {
-	return regmap_read(priv->map_reg, MCP251XFD_REG_TBC, timestamp);
+	return regmap_read(priv->map_reg, MCP251XFD_REG_TBC, ts_raw);
+}
+
+static inline void mcp251xfd_skb_set_timestamp(struct sk_buff *skb, u64 ns)
+{
+	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+
+	hwtstamps->hwtstamp = ns_to_ktime(ns);
+}
+
+static inline
+void mcp251xfd_skb_set_timestamp_raw(const struct mcp251xfd_priv *priv,
+				     struct sk_buff *skb, u32 ts_raw)
+{
+	u64 ns;
+
+	ns = timecounter_cyc2time(&priv->tc, ts_raw);
+	mcp251xfd_skb_set_timestamp(skb, ns);
 }
 
 static inline u16 mcp251xfd_get_tef_obj_addr(u8 n)
@@ -936,8 +953,6 @@ void mcp251xfd_ring_free(struct mcp251xfd_priv *priv);
 int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_rxif(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv);
-void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
-				 struct sk_buff *skb, u32 timestamp);
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
-- 
2.43.0




