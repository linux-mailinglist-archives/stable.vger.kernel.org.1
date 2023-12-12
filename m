Return-Path: <stable+bounces-6428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B72E80E93B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C83281584
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD854273;
	Tue, 12 Dec 2023 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M07axvke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C221373
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 10:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB23C433C7;
	Tue, 12 Dec 2023 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702377472;
	bh=tHOj0nE4Bl4l5rWpW/U5BzV3QynrhJMGPGcXrEFE7fw=;
	h=Subject:To:Cc:From:Date:From;
	b=M07axvkeDo1T2HmbV8RkzTCxaqGb5crAmuVX0fOFyaH0/wUZ+Qhr24ECeZXs1kEJV
	 KWzh9f9o/cndgqEv/9rpORMs2lGKc/jTku9I1ycmQzSbw66d0bFtvoSKP6EJng//Zo
	 24WR5FsLKZiWONDN2BkgFRwpoK9FQ271FmN4pyMQ=
Subject: FAILED: patch "[PATCH] ARM: PL011: Fix DMA support" failed to apply to 4.14-stable tree
To: arnd@arndb.de,gregkh@linuxfoundation.org,gregory.clement@bootlin.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Dec 2023 11:37:50 +0100
Message-ID: <2023121249-grimace-outtakes-a409@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 58ac1b3799799069d53f5bf95c093f2fe8dd3cc5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121249-grimace-outtakes-a409@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

58ac1b379979 ("ARM: PL011: Fix DMA support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58ac1b3799799069d53f5bf95c093f2fe8dd3cc5 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 Nov 2023 18:15:03 +0100
Subject: [PATCH] ARM: PL011: Fix DMA support

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

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 61cc24cd90e4..b7635363373e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -218,17 +218,18 @@ static struct vendor_data vendor_st = {
 
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
@@ -241,7 +242,8 @@ struct pl011_dmarx_data {
 
 struct pl011_dmatx_data {
 	struct dma_chan		*chan;
-	struct scatterlist	sg;
+	dma_addr_t		dma;
+	size_t			len;
 	char			*buf;
 	bool			queued;
 };
@@ -366,32 +368,24 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 
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
 
@@ -552,8 +546,8 @@ static void pl011_dma_tx_callback(void *data)
 
 	uart_port_lock_irqsave(&uap->port, &flags);
 	if (uap->dmatx.queued)
-		dma_unmap_sg(dmatx->chan->device->dev, &dmatx->sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
+				dmatx->len, DMA_TO_DEVICE);
 
 	dmacr = uap->dmacr;
 	uap->dmacr = dmacr & ~UART011_TXDMAE;
@@ -639,18 +633,19 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
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
@@ -813,8 +808,8 @@ __acquires(&uap->port.lock)
 	dmaengine_terminate_async(uap->dmatx.chan);
 
 	if (uap->dmatx.queued) {
-		dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(uap->dmatx.chan->device->dev, uap->dmatx.dma,
+				 uap->dmatx.len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
@@ -828,15 +823,15 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
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
@@ -876,8 +871,8 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 			       bool readfifo)
 {
 	struct tty_port *port = &uap->port.state->port;
-	struct pl011_sgbuf *sgbuf = use_buf_b ?
-		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	struct pl011_dmabuf *dbuf = use_buf_b ?
+		&uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
 	int dma_count = 0;
 	u32 fifotaken = 0; /* only used for vdbg() */
 
@@ -886,7 +881,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	if (uap->dmarx.poll_rate) {
 		/* The data can be taken by polling */
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = dbuf->len - dmarx->last_residue;
 		/* Recalculate the pending size */
 		if (pending >= dmataken)
 			pending -= dmataken;
@@ -900,7 +895,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 		 * Note that tty_insert_flip_buf() tries to take as many chars
 		 * as it can.
 		 */
-		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
+		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
 				pending);
 
 		uap->port.icount.rx += dma_count;
@@ -911,7 +906,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	/* Reset the last_residue for Rx DMA poll */
 	if (uap->dmarx.poll_rate)
-		dmarx->last_residue = sgbuf->sg.length;
+		dmarx->last_residue = dbuf->len;
 
 	/*
 	 * Only continue with trying to read the FIFO if all DMA chars have
@@ -946,8 +941,8 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
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
@@ -969,7 +964,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmarx.running = false;
 
-	pending = sgbuf->sg.length - state.residue;
+	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -996,8 +991,8 @@ static void pl011_dma_rx_callback(void *data)
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
@@ -1015,7 +1010,7 @@ static void pl011_dma_rx_callback(void *data)
 	 * the DMA irq handler. So we check the residue here.
 	 */
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
-	pending = sgbuf->sg.length - state.residue;
+	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1067,16 +1062,16 @@ static void pl011_dma_rx_poll(struct timer_list *t)
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
@@ -1123,7 +1118,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		return;
 	}
 
-	sg_init_one(&uap->dmatx.sg, uap->dmatx.buf, PL011_DMA_BUFFER_SIZE);
+	uap->dmatx.len = PL011_DMA_BUFFER_SIZE;
 
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
@@ -1133,7 +1128,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		goto skip_rx;
 
 	/* Allocate and map DMA RX buffers */
-	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_a,
 			       DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
@@ -1141,12 +1136,12 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
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
@@ -1200,8 +1195,9 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
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
 
@@ -1212,8 +1208,8 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
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


