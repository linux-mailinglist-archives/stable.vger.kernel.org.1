Return-Path: <stable+bounces-221959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGDlMZOqo2nfJQUAu9opvQ
	(envelope-from <stable+bounces-221959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:55:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6C11CE0EC
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B23433447E0
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E0B2F1FD0;
	Sun,  1 Mar 2026 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rj0/hoaf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675EC22AE65;
	Sun,  1 Mar 2026 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329557; cv=none; b=bdIVQ4nHOE0iUMZbPPaElr9zBiYwWVIq/ocIFq8ohMruBt1B86mBSsaNRNzTKlFfis+yZgHrrUgML33II083xNarffUi4KjxjwchU+G5Je/mONy4oTaAoJz7bqY9zsGizAtLyn3axBXvA5jWUwl2rN83vfwWOKL2T5U9EgEzG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329557; c=relaxed/simple;
	bh=2jzxscF55ZMyWRnSq+vPCf3kbP3acq2sNYhqjta5VAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rI735SDAOWlauhuT5vk+OHvWv5Xk16Rx9ZjmRVrtxOEcMBCls7DeA0J2Fp6JiV6IMnbEHrPBQ3q93/HkQOfhcTTx/ilsZ2x5F2fekZGjInINY/fLjteGgHv3C+G7wiv/4dSdu7N12/7CimQdXJdiMXmC+fFFAXPD2u1+C2Yvebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rj0/hoaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A32C19421;
	Sun,  1 Mar 2026 01:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329557;
	bh=2jzxscF55ZMyWRnSq+vPCf3kbP3acq2sNYhqjta5VAA=;
	h=From:To:Cc:Subject:Date:From;
	b=rj0/hoaf9GRkzbh3+8QuDpcpHvDr3spQDRWklNjnX2x2Mg4MjXFmhpCTww3n5LbJt
	 NQd+uK+QWHlN4BNtiPqv4GKncExXY7TI5ay5ZABS22/01SPmDsQ9dqI5sPm0ksGqqa
	 mJM7/GbPJzTT4wepRkkGEPgRFAlwV0t3aZ9zbFjD+a3zna2yxq22JKfdGIXWRqmN0g
	 HVHAe+sN+dIlzX91bRXIH4YMyjs6Vx1jPC5ZKrUh02anzsf7QrxpqQ+MEeXyagLn5x
	 N/D9KGk5O0F/adODXAWenT5bjVvEK0EyMypttFwLcWP03dPwIZb3/rsZUr2km951IC
	 QxZKA9GFVWVkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	carlos.song@nxp.com
Cc: Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "i2c: imx-lpi2c: fix SMBus block read NACK after byte count" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:45:54 -0500
Message-ID: <20260301014555.1708751-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221959-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3B6C11CE0EC
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From efdc383d1cc28d45cbf5a23b5ffa997010aaacb4 Mon Sep 17 00:00:00 2001
From: Carlos Song <carlos.song@nxp.com>
Date: Fri, 23 Jan 2026 18:54:58 +0800
Subject: [PATCH] i2c: imx-lpi2c: fix SMBus block read NACK after byte count

The LPI2C controller sends a NACK at the end of a receive command
unless another receive command is already queued in MTDR. During
SMBus block reads, this causes the controller to NACK immediately
after receiving the block length byte, aborting the transfer before
the data bytes are read.

Fix this by queueing a second receive command as soon as the block
length byte is received, keeping MTDR non-empty and ensuring
continuous ACKs. The initial receive command reads the block length,
and the subsequent command reads the remaining data bytes according
to the reported length.

Fixes: a55fa9d0e42e ("i2c: imx-lpi2c: add low power i2c bus driver")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Cc: <stable@vger.kernel.org> # v4.10+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260123105459.3448822-1-carlos.song@nxp.com
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 107 ++++++++++++++++++++++-------
 1 file changed, 83 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index be7134eefc2f5..f97f73faec82d 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -5,6 +5,7 @@
  * Copyright 2016 Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -90,6 +91,7 @@
 #define MRDR_RXEMPTY	BIT(14)
 #define MDER_TDDE	BIT(0)
 #define MDER_RDDE	BIT(1)
+#define MSR_RDF_ASSERTED(x) FIELD_GET(MSR_RDF, (x))
 
 #define SCR_SEN		BIT(0)
 #define SCR_RST		BIT(1)
@@ -482,7 +484,7 @@ static bool lpi2c_imx_write_txfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atom
 
 static bool lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atomic)
 {
-	unsigned int blocklen, remaining;
+	unsigned int remaining;
 	unsigned int temp, data;
 
 	do {
@@ -493,15 +495,6 @@ static bool lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atomi
 		lpi2c_imx->rx_buf[lpi2c_imx->delivered++] = data & 0xff;
 	} while (1);
 
-	/*
-	 * First byte is the length of remaining packet in the SMBus block
-	 * data read. Add it to msgs->len.
-	 */
-	if (lpi2c_imx->block_data) {
-		blocklen = lpi2c_imx->rx_buf[0];
-		lpi2c_imx->msglen += blocklen;
-	}
-
 	remaining = lpi2c_imx->msglen - lpi2c_imx->delivered;
 
 	if (!remaining) {
@@ -514,12 +507,7 @@ static bool lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atomi
 	lpi2c_imx_set_rx_watermark(lpi2c_imx);
 
 	/* multiple receive commands */
-	if (lpi2c_imx->block_data) {
-		lpi2c_imx->block_data = 0;
-		temp = remaining;
-		temp |= (RECV_DATA << 8);
-		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
-	} else if (!(lpi2c_imx->delivered & 0xff)) {
+	if (!(lpi2c_imx->delivered & 0xff)) {
 		temp = (remaining > CHUNK_DATA ? CHUNK_DATA : remaining) - 1;
 		temp |= (RECV_DATA << 8);
 		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
@@ -557,18 +545,77 @@ static int lpi2c_imx_write_atomic(struct lpi2c_imx_struct *lpi2c_imx,
 	return err;
 }
 
-static void lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
-				struct i2c_msg *msgs)
+static unsigned int lpi2c_SMBus_block_read_length_byte(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	unsigned int temp;
+	unsigned int data;
+
+	data = readl(lpi2c_imx->base + LPI2C_MRDR);
+	lpi2c_imx->rx_buf[lpi2c_imx->delivered++] = data & 0xff;
+
+	return data;
+}
+
+static int lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
+			       struct i2c_msg *msgs)
+{
+	unsigned int temp, val, block_len;
+	int ret;
 
 	lpi2c_imx->rx_buf = msgs->buf;
 	lpi2c_imx->block_data = msgs->flags & I2C_M_RECV_LEN;
 
 	lpi2c_imx_set_rx_watermark(lpi2c_imx);
-	temp = msgs->len > CHUNK_DATA ? CHUNK_DATA - 1 : msgs->len - 1;
-	temp |= (RECV_DATA << 8);
-	writel(temp, lpi2c_imx->base + LPI2C_MTDR);
+
+	if (!lpi2c_imx->block_data) {
+		temp = msgs->len > CHUNK_DATA ? CHUNK_DATA - 1 : msgs->len - 1;
+		temp |= (RECV_DATA << 8);
+		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
+	} else {
+		/*
+		 * The LPI2C controller automatically sends a NACK after the last byte of a
+		 * receive command, unless the next command in MTDR is also a receive command.
+		 * If MTDR is empty when a receive completes, a NACK is sent by default.
+		 *
+		 * To comply with the SMBus block read spec, we start with a 2-byte read:
+		 * The first byte in RXFIFO is the block length. Once this byte arrives, the
+		 * controller immediately updates MTDR with the next read command, ensuring
+		 * continuous ACK instead of NACK.
+		 *
+		 * The second byte is the first block data byte. Therefore, the subsequent
+		 * read command should request (block_len - 1) bytes, since one data byte
+		 * has already been read.
+		 */
+
+		writel((RECV_DATA << 8) | 0x01, lpi2c_imx->base + LPI2C_MTDR);
+
+		ret = readl_poll_timeout(lpi2c_imx->base + LPI2C_MSR, val,
+					 MSR_RDF_ASSERTED(val), 1, 1000);
+		if (ret) {
+			dev_err(&lpi2c_imx->adapter.dev, "SMBus read count failed %d\n", ret);
+			return ret;
+		}
+
+		/* Read block length byte and confirm this SMBus transfer meets protocol */
+		block_len = lpi2c_SMBus_block_read_length_byte(lpi2c_imx);
+		if (block_len == 0 || block_len > I2C_SMBUS_BLOCK_MAX) {
+			dev_err(&lpi2c_imx->adapter.dev, "Invalid SMBus block read length\n");
+			return -EPROTO;
+		}
+
+		/*
+		 * When block_len shows more bytes need to be read, update second read command to
+		 * keep MTDR non-empty and ensuring continuous ACKs. Only update command register
+		 * here. All block bytes will be read out at IRQ handler or lpi2c_imx_read_atomic()
+		 * function.
+		 */
+		if (block_len > 1)
+			writel((RECV_DATA << 8) | (block_len - 2), lpi2c_imx->base + LPI2C_MTDR);
+
+		lpi2c_imx->msglen += block_len;
+		msgs->len += block_len;
+	}
+
+	return 0;
 }
 
 static bool lpi2c_imx_read_chunk_atomic(struct lpi2c_imx_struct *lpi2c_imx)
@@ -613,6 +660,10 @@ static bool is_use_dma(struct lpi2c_imx_struct *lpi2c_imx, struct i2c_msg *msg)
 	if (!lpi2c_imx->can_use_dma)
 		return false;
 
+	/* DMA is not suitable for SMBus block read */
+	if (msg->flags & I2C_M_RECV_LEN)
+		return false;
+
 	/*
 	 * When the length of data is less than I2C_DMA_THRESHOLD,
 	 * cpu mode is used directly to avoid low performance.
@@ -623,10 +674,14 @@ static bool is_use_dma(struct lpi2c_imx_struct *lpi2c_imx, struct i2c_msg *msg)
 static int lpi2c_imx_pio_xfer(struct lpi2c_imx_struct *lpi2c_imx,
 			      struct i2c_msg *msg)
 {
+	int ret;
+
 	reinit_completion(&lpi2c_imx->complete);
 
 	if (msg->flags & I2C_M_RD) {
-		lpi2c_imx_read_init(lpi2c_imx, msg);
+		ret = lpi2c_imx_read_init(lpi2c_imx, msg);
+		if (ret)
+			return ret;
 		lpi2c_imx_intctrl(lpi2c_imx, MIER_RDIE | MIER_NDIE);
 	} else {
 		lpi2c_imx_write(lpi2c_imx, msg);
@@ -638,8 +693,12 @@ static int lpi2c_imx_pio_xfer(struct lpi2c_imx_struct *lpi2c_imx,
 static int lpi2c_imx_pio_xfer_atomic(struct lpi2c_imx_struct *lpi2c_imx,
 				     struct i2c_msg *msg)
 {
+	int ret;
+
 	if (msg->flags & I2C_M_RD) {
-		lpi2c_imx_read_init(lpi2c_imx, msg);
+		ret = lpi2c_imx_read_init(lpi2c_imx, msg);
+		if (ret)
+			return ret;
 		return lpi2c_imx_read_atomic(lpi2c_imx, msg);
 	}
 
-- 
2.51.0





