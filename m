Return-Path: <stable+bounces-44478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53768C5309
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89A72820C8
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2B8139578;
	Tue, 14 May 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YvWC8x9K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7B1350C6;
	Tue, 14 May 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686278; cv=none; b=Xt00WSM3afGa7Rmu38Ht1nKdU5lEemDepJSGUTmmxEt9er+v1hQzDPM0Qzho2g0QebfsA33rka0/+YDeAV0T6XMMYWRYjYIT+vm12jVqtovBrbWSzRiGIeYkge72VyQFyaWaS1/WMZGegxIm9JtJAnT1cbaNqJShTVSqa4FEx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686278; c=relaxed/simple;
	bh=mplbPKyjDEe6huhYm038XEBOzSaDbRJw7DZKC7X7btU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZJ/cOcIZ0q70qJohJ+D1xrZqT6NTxlsty5jeFLRZEK3i2/OqPZwe2HegnuPBtDQeP10G1E4chJaJwRjPvFCtFvJeXQ7aoMUAkLt9mfH00yNvOjmYllU2shdgz7BqZgroWRfpoKGd6YOdjhVbFkP2UiElvkn9YaL5eZHb/xmkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YvWC8x9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE129C2BD10;
	Tue, 14 May 2024 11:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686278;
	bh=mplbPKyjDEe6huhYm038XEBOzSaDbRJw7DZKC7X7btU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvWC8x9KcRLIxka2NeMr7tETRRwDv5Za+N245ZJVp5o8pY6HoH+kBjmfeLwAfhCTo
	 KYuMj7dYMe8elVDOPqxXfeuA7VSmn64BPCrwt/kxt5wU1YbE6a3zRi1Q9Ps8jM0dFT
	 0e7aIj0BWMe2EhcvZ/sns1O20joRGMrl3llLsJlo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 050/236] spi: axi-spi-engine: move msg state to new struct
Date: Tue, 14 May 2024 12:16:52 +0200
Message-ID: <20240514101022.245273160@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit 7f970ecb77b6759d37ee743fc36fc0daba960e75 ]

This moves the message state in the AXI SPI Engine driver to a new
struct spi_engine_msg_state.

Previously, the driver state contained various pointers that pointed
to memory owned by a struct spi_message. However, it did not set any of
these pointers to NULL when a message was completed. This could lead to
use after free bugs.

Example of how this could happen:
1. SPI core calls into spi_engine_transfer_one_message() with msg1.
2. Assume something was misconfigured and spi_engine_tx_next() is not
   called enough times in interrupt callbacks for msg1 such that
   spi_engine->tx_xfer is never set to NULL before the msg1 completes.
3. SYNC interrupt is received and spi_finalize_current_message() is
   called for msg1. spi_engine->msg is set to NULL but no other
   message-specific state is reset.
4. Caller that sent msg1 is notified of the completion and frees msg1
   and the associated xfers and tx/rx buffers.
4. SPI core calls into spi_engine_transfer_one_message() with msg2.
5. When spi_engine_tx_next() is called for msg2, spi_engine->tx_xfer is
   still be pointing to an xfer from msg1, which was already freed.
   spi_engine_xfer_next() tries to access xfer->transfer_list of one
   of the freed xfers and we get a segfault or undefined behavior.

To avoid issues like this, instead of putting per-message state in the
driver state struct, we can make use of the struct spi_message::state
field to store a pointer to a new struct spi_engine_msg_state. This way,
all of the state that belongs to specific message stays with that
message and we don't have to remember to manually reset all aspects of
the message state when a message is completed. Rather, a new state is
allocated for each message.

Most of the changes are just renames where the state is accessed. One
place where this wasn't straightforward was the sync_id member. This
has been changed to use ida_alloc_range() since we needed to separate
the per-message sync_id from the per-controller next available sync_id.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://lore.kernel.org/r/20231117-axi-spi-engine-series-1-v1-9-cc59db999b87@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 0064db9ce4aa ("spi: axi-spi-engine: fix version format string")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-axi-spi-engine.c | 150 ++++++++++++++++++++-----------
 1 file changed, 96 insertions(+), 54 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 69c4ff142baae..b75c1272de5f3 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -78,28 +79,42 @@ struct spi_engine_program {
 	uint16_t instructions[];
 };
 
-struct spi_engine {
-	struct clk *clk;
-	struct clk *ref_clk;
-
-	spinlock_t lock;
-
-	void __iomem *base;
-
-	struct spi_message *msg;
+/**
+ * struct spi_engine_message_state - SPI engine per-message state
+ */
+struct spi_engine_message_state {
+	/** Instructions for executing this message. */
 	struct spi_engine_program *p;
+	/** Number of elements in cmd_buf array. */
 	unsigned cmd_length;
+	/** Array of commands not yet written to CMD FIFO. */
 	const uint16_t *cmd_buf;
-
+	/** Next xfer with tx_buf not yet fully written to TX FIFO. */
 	struct spi_transfer *tx_xfer;
+	/** Size of tx_buf in bytes. */
 	unsigned int tx_length;
+	/** Bytes not yet written to TX FIFO. */
 	const uint8_t *tx_buf;
-
+	/** Next xfer with rx_buf not yet fully written to RX FIFO. */
 	struct spi_transfer *rx_xfer;
+	/** Size of tx_buf in bytes. */
 	unsigned int rx_length;
+	/** Bytes not yet written to the RX FIFO. */
 	uint8_t *rx_buf;
+	/** ID to correlate SYNC interrupts with this message. */
+	u8 sync_id;
+};
+
+struct spi_engine {
+	struct clk *clk;
+	struct clk *ref_clk;
 
-	unsigned int sync_id;
+	spinlock_t lock;
+
+	void __iomem *base;
+
+	struct spi_message *msg;
+	struct ida sync_ida;
 	unsigned int completed_id;
 
 	unsigned int int_enable;
@@ -258,100 +273,105 @@ static void spi_engine_xfer_next(struct spi_engine *spi_engine,
 
 static void spi_engine_tx_next(struct spi_engine *spi_engine)
 {
-	struct spi_transfer *xfer = spi_engine->tx_xfer;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_transfer *xfer = st->tx_xfer;
 
 	do {
 		spi_engine_xfer_next(spi_engine, &xfer);
 	} while (xfer && !xfer->tx_buf);
 
-	spi_engine->tx_xfer = xfer;
+	st->tx_xfer = xfer;
 	if (xfer) {
-		spi_engine->tx_length = xfer->len;
-		spi_engine->tx_buf = xfer->tx_buf;
+		st->tx_length = xfer->len;
+		st->tx_buf = xfer->tx_buf;
 	} else {
-		spi_engine->tx_buf = NULL;
+		st->tx_buf = NULL;
 	}
 }
 
 static void spi_engine_rx_next(struct spi_engine *spi_engine)
 {
-	struct spi_transfer *xfer = spi_engine->rx_xfer;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
+	struct spi_transfer *xfer = st->rx_xfer;
 
 	do {
 		spi_engine_xfer_next(spi_engine, &xfer);
 	} while (xfer && !xfer->rx_buf);
 
-	spi_engine->rx_xfer = xfer;
+	st->rx_xfer = xfer;
 	if (xfer) {
-		spi_engine->rx_length = xfer->len;
-		spi_engine->rx_buf = xfer->rx_buf;
+		st->rx_length = xfer->len;
+		st->rx_buf = xfer->rx_buf;
 	} else {
-		spi_engine->rx_buf = NULL;
+		st->rx_buf = NULL;
 	}
 }
 
 static bool spi_engine_write_cmd_fifo(struct spi_engine *spi_engine)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_CMD_FIFO;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
 	unsigned int n, m, i;
 	const uint16_t *buf;
 
 	n = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_CMD_FIFO_ROOM);
-	while (n && spi_engine->cmd_length) {
-		m = min(n, spi_engine->cmd_length);
-		buf = spi_engine->cmd_buf;
+	while (n && st->cmd_length) {
+		m = min(n, st->cmd_length);
+		buf = st->cmd_buf;
 		for (i = 0; i < m; i++)
 			writel_relaxed(buf[i], addr);
-		spi_engine->cmd_buf += m;
-		spi_engine->cmd_length -= m;
+		st->cmd_buf += m;
+		st->cmd_length -= m;
 		n -= m;
 	}
 
-	return spi_engine->cmd_length != 0;
+	return st->cmd_length != 0;
 }
 
 static bool spi_engine_write_tx_fifo(struct spi_engine *spi_engine)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_SDO_DATA_FIFO;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
 	unsigned int n, m, i;
 	const uint8_t *buf;
 
 	n = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_SDO_FIFO_ROOM);
-	while (n && spi_engine->tx_length) {
-		m = min(n, spi_engine->tx_length);
-		buf = spi_engine->tx_buf;
+	while (n && st->tx_length) {
+		m = min(n, st->tx_length);
+		buf = st->tx_buf;
 		for (i = 0; i < m; i++)
 			writel_relaxed(buf[i], addr);
-		spi_engine->tx_buf += m;
-		spi_engine->tx_length -= m;
+		st->tx_buf += m;
+		st->tx_length -= m;
 		n -= m;
-		if (spi_engine->tx_length == 0)
+		if (st->tx_length == 0)
 			spi_engine_tx_next(spi_engine);
 	}
 
-	return spi_engine->tx_length != 0;
+	return st->tx_length != 0;
 }
 
 static bool spi_engine_read_rx_fifo(struct spi_engine *spi_engine)
 {
 	void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_SDI_DATA_FIFO;
+	struct spi_engine_message_state *st = spi_engine->msg->state;
 	unsigned int n, m, i;
 	uint8_t *buf;
 
 	n = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_SDI_FIFO_LEVEL);
-	while (n && spi_engine->rx_length) {
-		m = min(n, spi_engine->rx_length);
-		buf = spi_engine->rx_buf;
+	while (n && st->rx_length) {
+		m = min(n, st->rx_length);
+		buf = st->rx_buf;
 		for (i = 0; i < m; i++)
 			buf[i] = readl_relaxed(addr);
-		spi_engine->rx_buf += m;
-		spi_engine->rx_length -= m;
+		st->rx_buf += m;
+		st->rx_length -= m;
 		n -= m;
-		if (spi_engine->rx_length == 0)
+		if (st->rx_length == 0)
 			spi_engine_rx_next(spi_engine);
 	}
 
-	return spi_engine->rx_length != 0;
+	return st->rx_length != 0;
 }
 
 static irqreturn_t spi_engine_irq(int irq, void *devid)
@@ -387,12 +407,16 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 			disable_int |= SPI_ENGINE_INT_SDI_ALMOST_FULL;
 	}
 
-	if (pending & SPI_ENGINE_INT_SYNC) {
-		if (spi_engine->msg &&
-		    spi_engine->completed_id == spi_engine->sync_id) {
+	if (pending & SPI_ENGINE_INT_SYNC && spi_engine->msg) {
+		struct spi_engine_message_state *st = spi_engine->msg->state;
+
+		if (spi_engine->completed_id == st->sync_id) {
 			struct spi_message *msg = spi_engine->msg;
+			struct spi_engine_message_state *st = msg->state;
 
-			kfree(spi_engine->p);
+			ida_free(&spi_engine->sync_ida, st->sync_id);
+			kfree(st->p);
+			kfree(st);
 			msg->status = 0;
 			msg->actual_length = msg->frame_length;
 			spi_engine->msg = NULL;
@@ -417,29 +441,46 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 {
 	struct spi_engine_program p_dry, *p;
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_message_state *st;
 	unsigned int int_enable = 0;
 	unsigned long flags;
 	size_t size;
+	int ret;
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
 
 	p_dry.length = 0;
 	spi_engine_compile_message(spi_engine, msg, true, &p_dry);
 
 	size = sizeof(*p->instructions) * (p_dry.length + 1);
 	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);
-	if (!p)
+	if (!p) {
+		kfree(st);
 		return -ENOMEM;
+	}
+
+	ret = ida_alloc_range(&spi_engine->sync_ida, 0, U8_MAX, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(p);
+		kfree(st);
+		return ret;
+	}
+
+	st->sync_id = ret;
+
 	spi_engine_compile_message(spi_engine, msg, false, p);
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
-	spi_engine->sync_id = (spi_engine->sync_id + 1) & 0xff;
-	spi_engine_program_add_cmd(p, false,
-		SPI_ENGINE_CMD_SYNC(spi_engine->sync_id));
+	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(st->sync_id));
 
+	msg->state = st;
 	spi_engine->msg = msg;
-	spi_engine->p = p;
+	st->p = p;
 
-	spi_engine->cmd_buf = p->instructions;
-	spi_engine->cmd_length = p->length;
+	st->cmd_buf = p->instructions;
+	st->cmd_length = p->length;
 	if (spi_engine_write_cmd_fifo(spi_engine))
 		int_enable |= SPI_ENGINE_INT_CMD_ALMOST_EMPTY;
 
@@ -448,7 +489,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		int_enable |= SPI_ENGINE_INT_SDO_ALMOST_EMPTY;
 
 	spi_engine_rx_next(spi_engine);
-	if (spi_engine->rx_length != 0)
+	if (st->rx_length != 0)
 		int_enable |= SPI_ENGINE_INT_SDI_ALMOST_FULL;
 
 	int_enable |= SPI_ENGINE_INT_SYNC;
@@ -480,6 +521,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spi_engine = spi_controller_get_devdata(host);
 
 	spin_lock_init(&spi_engine->lock);
+	ida_init(&spi_engine->sync_ida);
 
 	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(spi_engine->clk))
-- 
2.43.0




