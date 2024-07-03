Return-Path: <stable+bounces-57792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3D925E59
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18435296F96
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7E179654;
	Wed,  3 Jul 2024 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c6SX9kje"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099791DA338;
	Wed,  3 Jul 2024 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005948; cv=none; b=Mox7vuIsAlUeD5toVRAx78QZ/9ioxgvtPHtBCqAmkeWLM3trV3sVD4YwBUdoAjkfN00flDNt8Gts5xhbPb/PEXkkpX/RkD4gAG13sN5fobctBTaN8jF3TCVh6A1KuGS/n8BLTfZjMYyoUoRlmLiJmznxZEqyXQDDEfbZPi6JdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005948; c=relaxed/simple;
	bh=cZ6zZ/4NTK3usxTy9offcKQ72ktKZOmXzlMdj3qTkf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDyM508b/5AY+/8VVpQ+yq5EV11R5jMEniivVr/YhjCdbdWUwQ/cYY3EpQ5GsxK+jw1KT+7gv/rYP5pi70FN1Fzv5Wy+sI77FU43Kv57bfkKfgK8l1D9Had0cEPK4XKfka1djVCv+4ryI6l0T/lP00NafJmpT5leqOsZ88128z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c6SX9kje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832E3C2BD10;
	Wed,  3 Jul 2024 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005947;
	bh=cZ6zZ/4NTK3usxTy9offcKQ72ktKZOmXzlMdj3qTkf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6SX9kjeH2WBDe7ceM8o6x66tUhbfQvxuFmngwIYO8TrRVazobglviqeso8lfsEDp
	 lW/V/bX/zhY5L1BjbSkGAWhDzOX6V4MvYsgyqSHwPDEuZ3bOrxWTAdMNwtYk0McX2f
	 WJwzRHbVQRxg312oPSJVZdGFymt4WXQMurHm4+LM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Valentin Caron <valentin.caron@foss.st.com>,
	Erwan Le Ray <erwan.leray@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [PATCH 5.15 218/356] serial: stm32: rework RX over DMA
Date: Wed,  3 Jul 2024 12:39:14 +0200
Message-ID: <20240703102921.360974831@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

From: Erwan Le Ray <erwan.leray@foss.st.com>

commit 33bb2f6ac3088936b7aad3cab6f439f91af0223c upstream.

This patch reworks RX support over DMA to improve reliability:
- change dma buffer cyclic configuration by using 2 periods. DMA buffer
data are handled by a flip-flop between the 2 periods in order to avoid
risk of data loss/corruption
- change the size of dma buffer to 4096 to limit overruns
- add rx errors management (breaks, parity, framing and overrun).
  When an error occurs on the uart line, the dma request line is masked at
  HW level. The SW must 1st clear DMAR (dma request line enable), to
  handle the error, then re-enable DMAR to recover. So, any correct data
  is taken from the DMA buffer, before handling the error itself. Then
  errors are handled from RDR/ISR/FIFO (e.g. in PIO mode). Last, DMA
  reception is resumed.
- add a condition on DMA request line in DMA RX routines in order to
switch to PIO mode when no DMA request line is disabled, even if the DMA
channel is still enabled.
  When the UART is wakeup source and is configured to use DMA for RX, any
  incoming data that wakes up the system isn't correctly received.
  At data reception, the irq_handler handles the WUF irq, and then the
  data reception over DMA.
  As the DMA transfer has been terminated at suspend, and will be restored
  by resume callback (which has no yet been called by system), the data
  can't be received.
  The wake-up data has to be handled in PIO mode while suspend callback
  has not been called.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Link: https://lore.kernel.org/r/20211020150332.10214-3-erwan.leray@foss.st.com
[ dario: fix conflicts for backport to v5.15. From the [1] series, only the
  first patch was applied to the v5.15 branch. This caused a regression in
  character reception, which can be fixed by applying the second patch. The
  patch has been tested on the stm32f469-disco board.
  [1] https://lore.kernel.org/all/20211020150332.10214-1-erwan.leray@foss.st.com/. ]
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/stm32-usart.c |  204 ++++++++++++++++++++++++++++++---------
 drivers/tty/serial/stm32-usart.h |   12 +-
 2 files changed, 164 insertions(+), 52 deletions(-)

--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -220,66 +220,60 @@ static int stm32_usart_init_rs485(struct
 	return uart_get_rs485_mode(port);
 }
 
-static int stm32_usart_pending_rx(struct uart_port *port, u32 *sr,
-				  int *last_res, bool threaded)
+static bool stm32_usart_rx_dma_enabled(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	if (!stm32_port->rx_ch)
+		return false;
+
+	return !!(readl_relaxed(port->membase + ofs->cr3) & USART_CR3_DMAR);
+}
+
+/* Return true when data is pending (in pio mode), and false when no data is pending. */
+static bool stm32_usart_pending_rx_pio(struct uart_port *port, u32 *sr)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	enum dma_status status;
-	struct dma_tx_state state;
 
 	*sr = readl_relaxed(port->membase + ofs->isr);
+	/* Get pending characters in RDR or FIFO */
+	if (*sr & USART_SR_RXNE) {
+		/* Get all pending characters from the RDR or the FIFO when using interrupts */
+		if (!stm32_usart_rx_dma_enabled(port))
+			return true;
 
-	if (threaded && stm32_port->rx_ch) {
-		status = dmaengine_tx_status(stm32_port->rx_ch,
-					     stm32_port->rx_ch->cookie,
-					     &state);
-		if (status == DMA_IN_PROGRESS && (*last_res != state.residue))
-			return 1;
-		else
-			return 0;
-	} else if (*sr & USART_SR_RXNE) {
-		return 1;
+		/* Handle only RX data errors when using DMA */
+		if (*sr & USART_SR_ERR_MASK)
+			return true;
 	}
-	return 0;
+
+	return false;
 }
 
-static unsigned long stm32_usart_get_char(struct uart_port *port, u32 *sr,
-					  int *last_res)
+static unsigned long stm32_usart_get_char_pio(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long c;
 
-	if (stm32_port->rx_ch) {
-		c = stm32_port->rx_buf[RX_BUF_L - (*last_res)--];
-		if ((*last_res) == 0)
-			*last_res = RX_BUF_L;
-	} else {
-		c = readl_relaxed(port->membase + ofs->rdr);
-		/* apply RDR data mask */
-		c &= stm32_port->rdr_mask;
-	}
+	c = readl_relaxed(port->membase + ofs->rdr);
+	/* Apply RDR data mask */
+	c &= stm32_port->rdr_mask;
 
 	return c;
 }
 
-static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
+static void stm32_usart_receive_chars_pio(struct uart_port *port)
 {
-	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	unsigned long c, flags;
+	unsigned long c;
 	u32 sr;
 	char flag;
 
-	if (irqflag)
-		spin_lock_irqsave(&port->lock, flags);
-	else
-		spin_lock(&port->lock);
-
-	while (stm32_usart_pending_rx(port, &sr, &stm32_port->last_res,
-				      irqflag)) {
+	while (stm32_usart_pending_rx_pio(port, &sr)) {
 		sr |= USART_SR_DUMMY_RX;
 		flag = TTY_NORMAL;
 
@@ -298,7 +292,7 @@ static void stm32_usart_receive_chars(st
 			writel_relaxed(sr & USART_SR_ERR_MASK,
 				       port->membase + ofs->icr);
 
-		c = stm32_usart_get_char(port, &sr, &stm32_port->last_res);
+		c = stm32_usart_get_char_pio(port);
 		port->icount.rx++;
 		if (sr & USART_SR_ERR_MASK) {
 			if (sr & USART_SR_ORE) {
@@ -332,6 +326,94 @@ static void stm32_usart_receive_chars(st
 			continue;
 		uart_insert_char(port, sr, USART_SR_ORE, c, flag);
 	}
+}
+
+static void stm32_usart_push_buffer_dma(struct uart_port *port, unsigned int dma_size)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	struct tty_port *ttyport = &stm32_port->port.state->port;
+	unsigned char *dma_start;
+	int dma_count, i;
+
+	dma_start = stm32_port->rx_buf + (RX_BUF_L - stm32_port->last_res);
+
+	/*
+	 * Apply rdr_mask on buffer in order to mask parity bit.
+	 * This loop is useless in cs8 mode because DMA copies only
+	 * 8 bits and already ignores parity bit.
+	 */
+	if (!(stm32_port->rdr_mask == (BIT(8) - 1)))
+		for (i = 0; i < dma_size; i++)
+			*(dma_start + i) &= stm32_port->rdr_mask;
+
+	dma_count = tty_insert_flip_string(ttyport, dma_start, dma_size);
+	port->icount.rx += dma_count;
+	if (dma_count != dma_size)
+		port->icount.buf_overrun++;
+	stm32_port->last_res -= dma_count;
+	if (stm32_port->last_res == 0)
+		stm32_port->last_res = RX_BUF_L;
+}
+
+static void stm32_usart_receive_chars_dma(struct uart_port *port)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	unsigned int dma_size;
+
+	/* DMA buffer is configured in cyclic mode and handles the rollback of the buffer. */
+	if (stm32_port->rx_dma_state.residue > stm32_port->last_res) {
+		/* Conditional first part: from last_res to end of DMA buffer */
+		dma_size = stm32_port->last_res;
+		stm32_usart_push_buffer_dma(port, dma_size);
+	}
+
+	dma_size = stm32_port->last_res - stm32_port->rx_dma_state.residue;
+	stm32_usart_push_buffer_dma(port, dma_size);
+}
+
+static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
+{
+	struct tty_port *tport = &port->state->port;
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	enum dma_status rx_dma_status;
+	unsigned long flags;
+	u32 sr;
+
+	if (irqflag)
+		spin_lock_irqsave(&port->lock, flags);
+	else
+		spin_lock(&port->lock);
+
+	if (stm32_usart_rx_dma_enabled(port)) {
+		rx_dma_status = dmaengine_tx_status(stm32_port->rx_ch,
+						    stm32_port->rx_ch->cookie,
+						    &stm32_port->rx_dma_state);
+		if (rx_dma_status == DMA_IN_PROGRESS) {
+			/* Empty DMA buffer */
+			stm32_usart_receive_chars_dma(port);
+			sr = readl_relaxed(port->membase + ofs->isr);
+			if (sr & USART_SR_ERR_MASK) {
+				/* Disable DMA request line */
+				stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+
+				/* Switch to PIO mode to handle the errors */
+				stm32_usart_receive_chars_pio(port);
+
+				/* Switch back to DMA mode */
+				stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAR);
+			}
+		} else {
+			/* Disable RX DMA */
+			dmaengine_terminate_async(stm32_port->rx_ch);
+			stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+			/* Fall back to interrupt mode */
+			dev_dbg(port->dev, "DMA error, fallback to irq mode\n");
+			stm32_usart_receive_chars_pio(port);
+		}
+	} else {
+		stm32_usart_receive_chars_pio(port);
+	}
 
 	if (irqflag)
 		uart_unlock_and_check_sysrq_irqrestore(port, irqflag);
@@ -373,6 +455,13 @@ static void stm32_usart_tx_interrupt_ena
 		stm32_usart_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
 }
 
+static void stm32_usart_rx_dma_complete(void *arg)
+{
+	struct uart_port *port = arg;
+
+	stm32_usart_receive_chars(port, true);
+}
+
 static void stm32_usart_tc_interrupt_enable(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
@@ -588,7 +677,12 @@ static irqreturn_t stm32_usart_interrupt
 			pm_wakeup_event(tport->tty->dev, 0);
 	}
 
-	if ((sr & USART_SR_RXNE) && !(stm32_port->rx_ch))
+	/*
+	 * rx errors in dma mode has to be handled ASAP to avoid overrun as the DMA request
+	 * line has been masked by HW and rx data are stacking in FIFO.
+	 */
+	if (((sr & USART_SR_RXNE) && !stm32_usart_rx_dma_enabled(port)) ||
+	    ((sr & USART_SR_ERR_MASK) && stm32_usart_rx_dma_enabled(port)))
 		stm32_usart_receive_chars(port, false);
 
 	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
@@ -597,7 +691,7 @@ static irqreturn_t stm32_usart_interrupt
 		spin_unlock(&port->lock);
 	}
 
-	if (stm32_port->rx_ch)
+	if (stm32_usart_rx_dma_enabled(port))
 		return IRQ_WAKE_THREAD;
 	else
 		return IRQ_HANDLED;
@@ -903,9 +997,11 @@ static void stm32_usart_set_termios(stru
 		stm32_port->cr1_irq = USART_CR1_RTOIE;
 		writel_relaxed(bits, port->membase + ofs->rtor);
 		cr2 |= USART_CR2_RTOEN;
-		/* Not using dma, enable fifo threshold irq */
-		if (!stm32_port->rx_ch)
-			stm32_port->cr3_irq =  USART_CR3_RXFTIE;
+		/*
+		 * Enable fifo threshold irq in two cases, either when there is no DMA, or when
+		 * wake up over usart, from low power until the DMA gets re-enabled by resume.
+		 */
+		stm32_port->cr3_irq =  USART_CR3_RXFTIE;
 	}
 
 	cr1 |= stm32_port->cr1_irq;
@@ -968,8 +1064,16 @@ static void stm32_usart_set_termios(stru
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= USART_SR_DUMMY_RX;
 
-	if (stm32_port->rx_ch)
+	if (stm32_port->rx_ch) {
+		/*
+		 * Setup DMA to collect only valid data and enable error irqs.
+		 * This also enables break reception when using DMA.
+		 */
+		cr1 |= USART_CR1_PEIE;
+		cr3 |= USART_CR3_EIE;
 		cr3 |= USART_CR3_DMAR;
+		cr3 |= USART_CR3_DDRE;
+	}
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		stm32_usart_config_reg_rs485(&cr1, &cr3,
@@ -1298,9 +1402,9 @@ static int stm32_usart_of_dma_rx_probe(s
 		return -ENODEV;
 	}
 
-	/* No callback as dma buffer is drained on usart interrupt */
-	desc->callback = NULL;
-	desc->callback_param = NULL;
+	/* Set DMA callback */
+	desc->callback = stm32_usart_rx_dma_complete;
+	desc->callback_param = port;
 
 	/* Push current DMA transaction in the pending queue */
 	ret = dma_submit_error(dmaengine_submit(desc));
@@ -1464,6 +1568,7 @@ static int stm32_usart_serial_remove(str
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	int err;
+	u32 cr3;
 
 	pm_runtime_get_sync(&pdev->dev);
 	err = uart_remove_one_port(&stm32_usart_driver, port);
@@ -1474,7 +1579,12 @@ static int stm32_usart_serial_remove(str
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
+	stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_PEIE);
+	cr3 = readl_relaxed(port->membase + ofs->cr3);
+	cr3 &= ~USART_CR3_EIE;
+	cr3 &= ~USART_CR3_DMAR;
+	cr3 &= ~USART_CR3_DDRE;
+	writel_relaxed(cr3, port->membase + ofs->cr3);
 
 	if (stm32_port->tx_ch) {
 		stm32_usart_of_dma_tx_remove(stm32_port, pdev);
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -109,7 +109,7 @@ struct stm32_usart_info stm32h7_info = {
 /* USART_SR (F4) / USART_ISR (F7) */
 #define USART_SR_PE		BIT(0)
 #define USART_SR_FE		BIT(1)
-#define USART_SR_NF		BIT(2)
+#define USART_SR_NE		BIT(2)		/* F7 (NF for F4) */
 #define USART_SR_ORE		BIT(3)
 #define USART_SR_IDLE		BIT(4)
 #define USART_SR_RXNE		BIT(5)
@@ -126,7 +126,8 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_SR_SBKF		BIT(18)		/* F7 */
 #define USART_SR_WUF		BIT(20)		/* H7 */
 #define USART_SR_TEACK		BIT(21)		/* F7 */
-#define USART_SR_ERR_MASK	(USART_SR_ORE | USART_SR_FE | USART_SR_PE)
+#define USART_SR_ERR_MASK	(USART_SR_ORE | USART_SR_NE | USART_SR_FE |\
+				 USART_SR_PE)
 /* Dummy bits */
 #define USART_SR_DUMMY_RX	BIT(16)
 
@@ -246,9 +247,9 @@ struct stm32_usart_info stm32h7_info = {
 #define STM32_SERIAL_NAME "ttySTM"
 #define STM32_MAX_PORTS 8
 
-#define RX_BUF_L 200		 /* dma rx buffer length     */
-#define RX_BUF_P RX_BUF_L	 /* dma rx buffer period     */
-#define TX_BUF_L 200		 /* dma tx buffer length     */
+#define RX_BUF_L 4096		 /* dma rx buffer length     */
+#define RX_BUF_P (RX_BUF_L / 2)	 /* dma rx buffer period     */
+#define TX_BUF_L RX_BUF_L	 /* dma tx buffer length     */
 
 struct stm32_port {
 	struct uart_port port;
@@ -273,6 +274,7 @@ struct stm32_port {
 	bool wakeup_src;
 	int rdr_mask;		/* receive data register mask */
 	struct mctrl_gpios *gpios; /* modem control gpios */
+	struct dma_tx_state rx_dma_state;
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];



