Return-Path: <stable+bounces-62102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A0393E312
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D10B23F49
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697421A01CF;
	Sun, 28 Jul 2024 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e15UROx6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DD1A01C4;
	Sun, 28 Jul 2024 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128143; cv=none; b=j6yCphyQ5BTfkkJNXOjYrLU8mihopJqbsM5uhm4HzZM+pwc6JaihahtnUuaREK74O4AfU32GggTKIyHEaAwBAP8hmYtm50uEcFmrvuKGBCrFhxnv0SE0UGC+Fzzk7n6GOjEpWwiSyLpl+k1+P9ktldbFYMw7G9TULW/WOIlwiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128143; c=relaxed/simple;
	bh=+7Xyeeae4IU4tv3mt/xQy0bgHrJK/LbR1uNesVW9FiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8NCXOzsGcXf5m2R9JJHrlch7HfLjqwQ1JJ3lwK1WCEN7ZTiWSuMMXewr/Q8IZ/PNPMIPLOhnJ1DX32It9LCqsC8N41ZUyu0NRNx1oVAOsX6fjXq7zfRHSv3Bw8sAHqL4gDn9Pk+kJip8X/ZMYoddyuHdMqlxuAu6Qmb2Ds/VzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e15UROx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02533C32781;
	Sun, 28 Jul 2024 00:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128142;
	bh=+7Xyeeae4IU4tv3mt/xQy0bgHrJK/LbR1uNesVW9FiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e15UROx6qDZqyaQ7piSISwo8QubBfk5pYBLAjgtm/uieP3SdxHiJlbwDzaWJKcVD9
	 JAP0O+pmEQ+7vgPLfI46qi5F/52OTa/KVvAT2lZLuhruPJXEWCWEhajdQdISIfOele
	 keWUIqZL4v2pEEqn8VSB3FYZr//RWUAUJu112MhoFVhOfTKmWlAt2SE7JaE8myc2t5
	 4S0WM5bi+41Hl/PdsHIofC6iA2QbvtJ6zXXUPoR1g5QbxELNhVbqD3iu/A6bLB2IM4
	 MTXfyc8GVtUSq6UnxFYqcAIneJanbfbiT6+8Za+Q1a9TBC2W1m5jZx8MMeHncDlw8w
	 3g+iZp2OqPRVQ==
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
Subject: [PATCH AUTOSEL 6.1 09/11] can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum
Date: Sat, 27 Jul 2024 20:55:14 -0400
Message-ID: <20240728005522.1731999-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005522.1731999-1-sashal@kernel.org>
References: <20240728005522.1731999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index bf3f0f150199d..4d0246a0779a6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -475,6 +475,8 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 		clear_bit(MCP251XFD_FLAGS_FD_MODE, priv->flags);
 	}
 
+	tx_ring->obj_num_shift_to_u8 = BITS_PER_TYPE(tx_ring->obj_num) -
+		ilog2(tx_ring->obj_num);
 	tx_ring->obj_size = tx_obj_size;
 
 	rem = priv->rx_obj_num;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index 237617b0c125f..b33192964cf7d 100644
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
index b98ded7098a5a..78d12dda08a05 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -519,6 +519,7 @@ struct mcp251xfd_tef_ring {
 
 	/* u8 obj_num equals tx_ring->obj_num */
 	/* u8 obj_size equals sizeof(struct mcp251xfd_hw_tef_obj) */
+	/* u8 obj_num_shift_to_u8 equals tx_ring->obj_num_shift_to_u8 */
 
 	union mcp251xfd_write_reg_buf irq_enable_buf;
 	struct spi_transfer irq_enable_xfer;
@@ -537,6 +538,7 @@ struct mcp251xfd_tx_ring {
 	u8 nr;
 	u8 fifo_nr;
 	u8 obj_num;
+	u8 obj_num_shift_to_u8;
 	u8 obj_size;
 
 	struct mcp251xfd_tx_obj obj[MCP251XFD_TX_OBJ_NUM_MAX];
@@ -843,17 +845,8 @@ static inline u8 mcp251xfd_get_tef_tail(const struct mcp251xfd_priv *priv)
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


