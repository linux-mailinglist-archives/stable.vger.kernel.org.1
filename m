Return-Path: <stable+bounces-62088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C7493E2E1
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE441F214EC
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40243198E82;
	Sun, 28 Jul 2024 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD6vLiDG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A2198845;
	Sun, 28 Jul 2024 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128106; cv=none; b=lOlN7A90RLH/UH+kBDEiZFRXGjMmhdODSrsKBRBYLtc1Dmh97J4GPQKbJw2qp/tlXROs5r9bXllp3/8wL0MEEyAda8MQdQND7i81cty0syfrmf3rrf8B8WscW4jPu1gDdsW+zwz5LcT7/bSRURhvPvl5FCABEXQxx1CI7QdQdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128106; c=relaxed/simple;
	bh=SbIW82o2osnGMsoWwjUuP6ozuneei5JqzcCvzP2deOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQeUqGvpK2yWehlCclhT6gSWOmKiXqqfV6jTXJBU+tQQGdAs/qCZA86qgph5/OVY+eqYCOZ0Q+IZX7OviDlEVW8DIPfW+YGXQQJ32LoinBmPN0s6C7cw4s4UYW6qQvkOjWTYVkvdqdgJtWGXZrxin3QV2laQH1e0wiQvf7u7clI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MD6vLiDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA902C32781;
	Sun, 28 Jul 2024 00:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128105;
	bh=SbIW82o2osnGMsoWwjUuP6ozuneei5JqzcCvzP2deOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MD6vLiDGOlmDiVo8DnBa1WW9lv3Pg/9jV5S7wWXgioTVHOFF0BuV5339VDIy8F6da
	 Qtx+SWFOM7hYbz6Im6aN2aDeKLkWJ8W0P5uglptrnWKj81wqVk5gl5itrB3iwBgowQ
	 09cbFk7ebITxb1YF8aDMED4s+hGU6+jRy64NOD5NmrT5aVpo+wEBpuchBw3pDSpTkE
	 abhaq8o0+U1lzwz2fmJKmMjIuQYfFz1qFY1me58Rhyvsh4bf6WwJ3tpYRi4kkh9cWj
	 4JXW6Ung8mgu20/sflko9iW/snBXFi6W11b+g45Qf87UQCKWyMlwM2Ua5eS7wxk2iW
	 8Vnfni3Un4H8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	=?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Sasha Levin <sashal@kernel.org>,
	manivannan.sadhasivam@linaro.org,
	mailhol.vincent@wanadoo.fr,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/15] can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum
Date: Sat, 27 Jul 2024 20:54:31 -0400
Message-ID: <20240728005442.1729384-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005442.1729384-1-sashal@kernel.org>
References: <20240728005442.1729384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit b8e0ddd36ce9536ad7478dd27df06c9ae92370ba ]

This is a preparatory patch to work around a problem similar to
erratum DS80000789E 6 of the mcp2518fd, the other variants of the chip
family (mcp2517fd and mcp251863) are probably also affected.

Erratum DS80000789E 6 says "reading of the FIFOCI bits in the FIFOSTA
register for an RX FIFO may be corrupted". However observation shows
that this problem is not limited to RX FIFOs but also effects the TEF
FIFO.

When handling the TEF interrupt, the driver reads the FIFO header
index from the TEF FIFO STA register of the chip.

In the bad case, the driver reads a too large head index. In the
original code, the driver always trusted the read value, which caused
old CAN transmit complete events that were already processed to be
re-processed.

Instead of reading and trusting the head index, read the head index
and calculate the number of CAN frames that were supposedly received -
replace mcp251xfd_tef_ring_update() with mcp251xfd_get_tef_len().

The mcp251xfd_handle_tefif() function reads the CAN transmit complete
events from the chip, iterates over them and pushes them into the
network stack. The original driver already contains code to detect old
CAN transmit complete events, that will be updated in the next patch.

Cc: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    |  2 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 54 +++++++++++++------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 13 ++---
 3 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index bfe4caa0c99d4..4cb79a4f24612 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -485,6 +485,8 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 		clear_bit(MCP251XFD_FLAGS_FD_MODE, priv->flags);
 	}
 
+	tx_ring->obj_num_shift_to_u8 = BITS_PER_TYPE(tx_ring->obj_num) -
+		ilog2(tx_ring->obj_num);
 	tx_ring->obj_size = tx_obj_size;
 
 	rem = priv->rx_obj_num;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index e5bd57b65aafe..b41fad3b37c06 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2019, 2020, 2021 Pengutronix,
+// Copyright (c) 2019, 2020, 2021, 2023 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 // Based on:
@@ -16,6 +16,11 @@
 
 #include "mcp251xfd.h"
 
+static inline bool mcp251xfd_tx_fifo_sta_full(u32 fifo_sta)
+{
+	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
+}
+
 static inline int
 mcp251xfd_tef_tail_get_from_chip(const struct mcp251xfd_priv *priv,
 				 u8 *tef_tail)
@@ -120,28 +125,44 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	return 0;
 }
 
-static int mcp251xfd_tef_ring_update(struct mcp251xfd_priv *priv)
+static int
+mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv, u8 *len_p)
 {
 	const struct mcp251xfd_tx_ring *tx_ring = priv->tx;
-	unsigned int new_head;
-	u8 chip_tx_tail;
+	const u8 shift = tx_ring->obj_num_shift_to_u8;
+	u8 chip_tx_tail, tail, len;
+	u32 fifo_sta;
 	int err;
 
-	err = mcp251xfd_tx_tail_get_from_chip(priv, &chip_tx_tail);
+	err = regmap_read(priv->map_reg, MCP251XFD_REG_FIFOSTA(priv->tx->fifo_nr),
+			  &fifo_sta);
 	if (err)
 		return err;
 
-	/* chip_tx_tail, is the next TX-Object send by the HW.
-	 * The new TEF head must be >= the old head, ...
+	if (mcp251xfd_tx_fifo_sta_full(fifo_sta)) {
+		*len_p = tx_ring->obj_num;
+		return 0;
+	}
+
+	chip_tx_tail = FIELD_GET(MCP251XFD_REG_FIFOSTA_FIFOCI_MASK, fifo_sta);
+
+	err =  mcp251xfd_check_tef_tail(priv);
+	if (err)
+		return err;
+	tail = mcp251xfd_get_tef_tail(priv);
+
+	/* First shift to full u8. The subtraction works on signed
+	 * values, that keeps the difference steady around the u8
+	 * overflow. The right shift acts on len, which is an u8.
 	 */
-	new_head = round_down(priv->tef->head, tx_ring->obj_num) + chip_tx_tail;
-	if (new_head <= priv->tef->head)
-		new_head += tx_ring->obj_num;
+	BUILD_BUG_ON(sizeof(tx_ring->obj_num) != sizeof(chip_tx_tail));
+	BUILD_BUG_ON(sizeof(tx_ring->obj_num) != sizeof(tail));
+	BUILD_BUG_ON(sizeof(tx_ring->obj_num) != sizeof(len));
 
-	/* ... but it cannot exceed the TX head. */
-	priv->tef->head = min(new_head, tx_ring->head);
+	len = (chip_tx_tail << shift) - (tail << shift);
+	*len_p = len >> shift;
 
-	return mcp251xfd_check_tef_tail(priv);
+	return 0;
 }
 
 static inline int
@@ -182,13 +203,12 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 	u8 tef_tail, len, l;
 	int err, i;
 
-	err = mcp251xfd_tef_ring_update(priv);
+	err = mcp251xfd_get_tef_len(priv, &len);
 	if (err)
 		return err;
 
 	tef_tail = mcp251xfd_get_tef_tail(priv);
-	len = mcp251xfd_get_tef_len(priv);
-	l = mcp251xfd_get_tef_linear_len(priv);
+	l = mcp251xfd_get_tef_linear_len(priv, len);
 	err = mcp251xfd_tef_obj_read(priv, hw_tef_obj, tef_tail, l);
 	if (err)
 		return err;
@@ -223,6 +243,8 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 		struct mcp251xfd_tx_ring *tx_ring = priv->tx;
 		int offset;
 
+		ring->head += len;
+
 		/* Increment the TEF FIFO tail pointer 'len' times in
 		 * a single SPI message.
 		 *
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index b35bfebd23f29..4628bf847bc9b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -524,6 +524,7 @@ struct mcp251xfd_tef_ring {
 
 	/* u8 obj_num equals tx_ring->obj_num */
 	/* u8 obj_size equals sizeof(struct mcp251xfd_hw_tef_obj) */
+	/* u8 obj_num_shift_to_u8 equals tx_ring->obj_num_shift_to_u8 */
 
 	union mcp251xfd_write_reg_buf irq_enable_buf;
 	struct spi_transfer irq_enable_xfer;
@@ -542,6 +543,7 @@ struct mcp251xfd_tx_ring {
 	u8 nr;
 	u8 fifo_nr;
 	u8 obj_num;
+	u8 obj_num_shift_to_u8;
 	u8 obj_size;
 
 	struct mcp251xfd_tx_obj obj[MCP251XFD_TX_OBJ_NUM_MAX];
@@ -861,17 +863,8 @@ static inline u8 mcp251xfd_get_tef_tail(const struct mcp251xfd_priv *priv)
 	return priv->tef->tail & (priv->tx->obj_num - 1);
 }
 
-static inline u8 mcp251xfd_get_tef_len(const struct mcp251xfd_priv *priv)
+static inline u8 mcp251xfd_get_tef_linear_len(const struct mcp251xfd_priv *priv, u8 len)
 {
-	return priv->tef->head - priv->tef->tail;
-}
-
-static inline u8 mcp251xfd_get_tef_linear_len(const struct mcp251xfd_priv *priv)
-{
-	u8 len;
-
-	len = mcp251xfd_get_tef_len(priv);
-
 	return min_t(u8, len, priv->tx->obj_num - mcp251xfd_get_tef_tail(priv));
 }
 
-- 
2.43.0


