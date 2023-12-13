Return-Path: <stable+bounces-6356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A6F80DA40
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 20:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C85B215A8
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8FC524C8;
	Mon, 11 Dec 2023 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nQlhILBe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68BE548;
	Mon, 11 Dec 2023 19:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65032C433C8;
	Mon, 11 Dec 2023 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702321207;
	bh=rYGH7J2pVo3m4aXg6cVXq7NH4zoIv82ZJsaWSDXww8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQlhILBe1RLk5VTP73QobYZgyrPtacDWbjFzVeAV4orpiWyLyokOsjewTqmOhmAHu
	 /0qyMYTUCqOLqwRv7sKYZzbgPSyTDmF0SoW6fI411Nq7ZaJEwYX4S8iUcpbur2y9Q2
	 oV28jor9p4Sf3/+ndF5IEZo2pmSBqBjl3o0lhN48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.15 127/141] ARM: PL011: Fix DMA support
Date: Mon, 11 Dec 2023 19:23:06 +0100
Message-ID: <20231211182032.078852016@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 58ac1b3799799069d53f5bf95c093f2fe8dd3cc5 upstream.

Since there is no guarantee that the memory returned by
dma_alloc_coherent() is associated with a 'struct page', using the
architecture specific phys_to_page() is wrong, but using
virt_to_page() would be as well.

Stop using sg lists altogether and just use the *_single() functions
instead. This also simplifies the code a bit since the scatterlists in
this driver always have only one entry anyway.

https://lore.kernel.org/lkml/86db0fe5-930d-4cbb-bd7d-03367da38951@app.fastmail.com/
    Use consistent names for dma buffers

gc: Add a commit log from the initial thread:
https://lore.kernel.org/lkml/86db0fe5-930d-4cbb-bd7d-03367da38951@app.fastmail.com/
    Use consistent names for dma buffers

Fixes: cb06ff102e2d7 ("ARM: PL011: Add support for Rx DMA buffer polling.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20231122171503.235649-1-gregory.clement@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/amba-pl011.c |  112 +++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 58 deletions(-)

--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -222,17 +222,18 @@ static struct vendor_data vendor_zte = {
 
 /* Deals with DMA transactions */
 
-struct pl011_sgbuf {
-	struct scatterlist sg;
-	char *buf;
+struct pl011_dmabuf {
+	dma_addr_t		dma;
+	size_t			len;
+	char			*buf;
 };
 
 struct pl011_dmarx_data {
 	struct dma_chan		*chan;
 	struct completion	complete;
 	bool			use_buf_b;
-	struct pl011_sgbuf	sgbuf_a;
-	struct pl011_sgbuf	sgbuf_b;
+	struct pl011_dmabuf	dbuf_a;
+	struct pl011_dmabuf	dbuf_b;
 	dma_cookie_t		cookie;
 	bool			running;
 	struct timer_list	timer;
@@ -245,7 +246,8 @@ struct pl011_dmarx_data {
 
 struct pl011_dmatx_data {
 	struct dma_chan		*chan;
-	struct scatterlist	sg;
+	dma_addr_t		dma;
+	size_t			len;
 	char			*buf;
 	bool			queued;
 };
@@ -370,32 +372,24 @@ static int pl011_fifo_to_tty(struct uart
 
 #define PL011_DMA_BUFFER_SIZE PAGE_SIZE
 
-static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
+static int pl011_dmabuf_init(struct dma_chan *chan, struct pl011_dmabuf *db,
 	enum dma_data_direction dir)
 {
-	dma_addr_t dma_addr;
-
-	sg->buf = dma_alloc_coherent(chan->device->dev,
-		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
-	if (!sg->buf)
+	db->buf = dma_alloc_coherent(chan->device->dev, PL011_DMA_BUFFER_SIZE,
+				     &db->dma, GFP_KERNEL);
+	if (!db->buf)
 		return -ENOMEM;
-
-	sg_init_table(&sg->sg, 1);
-	sg_set_page(&sg->sg, phys_to_page(dma_addr),
-		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
-	sg_dma_address(&sg->sg) = dma_addr;
-	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
+	db->len = PL011_DMA_BUFFER_SIZE;
 
 	return 0;
 }
 
-static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
+static void pl011_dmabuf_free(struct dma_chan *chan, struct pl011_dmabuf *db,
 	enum dma_data_direction dir)
 {
-	if (sg->buf) {
+	if (db->buf) {
 		dma_free_coherent(chan->device->dev,
-			PL011_DMA_BUFFER_SIZE, sg->buf,
-			sg_dma_address(&sg->sg));
+				  PL011_DMA_BUFFER_SIZE, db->buf, db->dma);
 	}
 }
 
@@ -556,8 +550,8 @@ static void pl011_dma_tx_callback(void *
 
 	spin_lock_irqsave(&uap->port.lock, flags);
 	if (uap->dmatx.queued)
-		dma_unmap_sg(dmatx->chan->device->dev, &dmatx->sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
+				dmatx->len, DMA_TO_DEVICE);
 
 	dmacr = uap->dmacr;
 	uap->dmacr = dmacr & ~UART011_TXDMAE;
@@ -643,18 +637,19 @@ static int pl011_dma_tx_refill(struct ua
 			memcpy(&dmatx->buf[first], &xmit->buf[0], second);
 	}
 
-	dmatx->sg.length = count;
-
-	if (dma_map_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE) != 1) {
+	dmatx->len = count;
+	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
+				    DMA_TO_DEVICE);
+	if (dmatx->dma == DMA_MAPPING_ERROR) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
 	}
 
-	desc = dmaengine_prep_slave_sg(chan, &dmatx->sg, 1, DMA_MEM_TO_DEV,
+	desc = dmaengine_prep_slave_single(chan, dmatx->dma, dmatx->len, DMA_MEM_TO_DEV,
 					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
-		dma_unmap_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE);
+		dma_unmap_single(dma_dev->dev, dmatx->dma, dmatx->len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		/*
 		 * If DMA cannot be used right now, we complete this
@@ -818,8 +813,8 @@ __acquires(&uap->port.lock)
 	dmaengine_terminate_async(uap->dmatx.chan);
 
 	if (uap->dmatx.queued) {
-		dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(uap->dmatx.chan->device->dev, uap->dmatx.dma,
+				 uap->dmatx.len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
@@ -833,15 +828,15 @@ static int pl011_dma_rx_trigger_dma(stru
 	struct dma_chan *rxchan = uap->dmarx.chan;
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_async_tx_descriptor *desc;
-	struct pl011_sgbuf *sgbuf;
+	struct pl011_dmabuf *dbuf;
 
 	if (!rxchan)
 		return -EIO;
 
 	/* Start the RX DMA job */
-	sgbuf = uap->dmarx.use_buf_b ?
-		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
-	desc = dmaengine_prep_slave_sg(rxchan, &sgbuf->sg, 1,
+	dbuf = uap->dmarx.use_buf_b ?
+		&uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
+	desc = dmaengine_prep_slave_single(rxchan, dbuf->dma, dbuf->len,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	/*
@@ -881,8 +876,8 @@ static void pl011_dma_rx_chars(struct ua
 			       bool readfifo)
 {
 	struct tty_port *port = &uap->port.state->port;
-	struct pl011_sgbuf *sgbuf = use_buf_b ?
-		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	struct pl011_dmabuf *dbuf = use_buf_b ?
+		&uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
 	int dma_count = 0;
 	u32 fifotaken = 0; /* only used for vdbg() */
 
@@ -891,7 +886,7 @@ static void pl011_dma_rx_chars(struct ua
 
 	if (uap->dmarx.poll_rate) {
 		/* The data can be taken by polling */
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = dbuf->len - dmarx->last_residue;
 		/* Recalculate the pending size */
 		if (pending >= dmataken)
 			pending -= dmataken;
@@ -905,7 +900,7 @@ static void pl011_dma_rx_chars(struct ua
 		 * Note that tty_insert_flip_buf() tries to take as many chars
 		 * as it can.
 		 */
-		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
+		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
 				pending);
 
 		uap->port.icount.rx += dma_count;
@@ -916,7 +911,7 @@ static void pl011_dma_rx_chars(struct ua
 
 	/* Reset the last_residue for Rx DMA poll */
 	if (uap->dmarx.poll_rate)
-		dmarx->last_residue = sgbuf->sg.length;
+		dmarx->last_residue = dbuf->len;
 
 	/*
 	 * Only continue with trying to read the FIFO if all DMA chars have
@@ -951,8 +946,8 @@ static void pl011_dma_rx_irq(struct uart
 {
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_chan *rxchan = dmarx->chan;
-	struct pl011_sgbuf *sgbuf = dmarx->use_buf_b ?
-		&dmarx->sgbuf_b : &dmarx->sgbuf_a;
+	struct pl011_dmabuf *dbuf = dmarx->use_buf_b ?
+		&dmarx->dbuf_b : &dmarx->dbuf_a;
 	size_t pending;
 	struct dma_tx_state state;
 	enum dma_status dmastat;
@@ -974,7 +969,7 @@ static void pl011_dma_rx_irq(struct uart
 	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmarx.running = false;
 
-	pending = sgbuf->sg.length - state.residue;
+	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1001,8 +996,8 @@ static void pl011_dma_rx_callback(void *
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_chan *rxchan = dmarx->chan;
 	bool lastbuf = dmarx->use_buf_b;
-	struct pl011_sgbuf *sgbuf = dmarx->use_buf_b ?
-		&dmarx->sgbuf_b : &dmarx->sgbuf_a;
+	struct pl011_dmabuf *dbuf = dmarx->use_buf_b ?
+		&dmarx->dbuf_b : &dmarx->dbuf_a;
 	size_t pending;
 	struct dma_tx_state state;
 	int ret;
@@ -1020,7 +1015,7 @@ static void pl011_dma_rx_callback(void *
 	 * the DMA irq handler. So we check the residue here.
 	 */
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
-	pending = sgbuf->sg.length - state.residue;
+	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1072,16 +1067,16 @@ static void pl011_dma_rx_poll(struct tim
 	unsigned long flags;
 	unsigned int dmataken = 0;
 	unsigned int size = 0;
-	struct pl011_sgbuf *sgbuf;
+	struct pl011_dmabuf *dbuf;
 	int dma_count;
 	struct dma_tx_state state;
 
-	sgbuf = dmarx->use_buf_b ? &uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	dbuf = dmarx->use_buf_b ? &uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
 	if (likely(state.residue < dmarx->last_residue)) {
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = dbuf->len - dmarx->last_residue;
 		size = dmarx->last_residue - state.residue;
-		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
+		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
 				size);
 		if (dma_count == size)
 			dmarx->last_residue =  state.residue;
@@ -1128,7 +1123,7 @@ static void pl011_dma_startup(struct uar
 		return;
 	}
 
-	sg_init_one(&uap->dmatx.sg, uap->dmatx.buf, PL011_DMA_BUFFER_SIZE);
+	uap->dmatx.len = PL011_DMA_BUFFER_SIZE;
 
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
@@ -1138,7 +1133,7 @@ static void pl011_dma_startup(struct uar
 		goto skip_rx;
 
 	/* Allocate and map DMA RX buffers */
-	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_a,
 			       DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
@@ -1146,12 +1141,12 @@ static void pl011_dma_startup(struct uar
 		goto skip_rx;
 	}
 
-	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_b,
+	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_b,
 			       DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
 			"RX buffer B", ret);
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a,
 				 DMA_FROM_DEVICE);
 		goto skip_rx;
 	}
@@ -1205,8 +1200,9 @@ static void pl011_dma_shutdown(struct ua
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
 		dmaengine_terminate_all(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
-			dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-				     DMA_TO_DEVICE);
+			dma_unmap_single(uap->dmatx.chan->device->dev,
+					 uap->dmatx.dma, uap->dmatx.len,
+					 DMA_TO_DEVICE);
 			uap->dmatx.queued = false;
 		}
 
@@ -1217,8 +1213,8 @@ static void pl011_dma_shutdown(struct ua
 	if (uap->using_rx_dma) {
 		dmaengine_terminate_all(uap->dmarx.chan);
 		/* Clean up the RX DMA */
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a, DMA_FROM_DEVICE);
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_b, DMA_FROM_DEVICE);
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a, DMA_FROM_DEVICE);
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_b, DMA_FROM_DEVICE);
 		if (uap->dmarx.poll_rate)
 			del_timer_sync(&uap->dmarx.timer);
 		uap->using_rx_dma = false;



