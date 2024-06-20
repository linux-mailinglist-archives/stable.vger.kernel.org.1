Return-Path: <stable+bounces-54729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEA49109D5
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 17:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3FBB20CA3
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7541158DCE;
	Thu, 20 Jun 2024 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eMhCOva3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268741AED46
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897237; cv=none; b=H8hVfXvh/mgeSXXL9gADLZAet+Q39Ea2dsJZMVGVTimtu26dyuhHbRAaTPK7tG8M/XpQMnAoWCao+oU/Jz0fBT5ph9PfGONSukNbxndgM0e1EdkxezXS+nKBoHnXW8xgB1UEPHAvIHbYpPelJsr8oj9FhhDeIJ5mS+Anh6EWzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897237; c=relaxed/simple;
	bh=9WOTSrQCB6JhIuBCm1Vx6VheXfHFQMZdHe1Ortnzkyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nH0CgABrOHxgAbxWcW5EWXuCOVPFZP0cMD6wIXGjGggEItUGf9oaCMEwG/8D+C3K3PIVqJg4mO0eGFVyZPhKclYgxgFxWpk2pkx1Fk9eMCIZqC7l3NQTzq8uLSqYDURhJ249JsIfukp0WxlZYUt9i3sy3DW5s+88Pt+7FYltmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=eMhCOva3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso1135836e87.1
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1718897233; x=1719502033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgWn6B8X9CGDnzNbumEgck1MpzXZogu7XFJ3vKcWj48=;
        b=eMhCOva3wRc9NX2OU7Sq8gu5JWpLZBFE8oY2Un/gtuvSqsaYJMI5DWYnMpYg6bolKq
         8DjJdjg1bt23wTFTIGOGku2Eg5LecCSkXkYS8C702Ds0HwR2Gg5FpGPYSOkWZCCTuyPU
         aSUihg9Gz6xLMpzcZPTtXJFWlxTSnOKoVdzDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897233; x=1719502033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgWn6B8X9CGDnzNbumEgck1MpzXZogu7XFJ3vKcWj48=;
        b=isNtahtfpKV2xmPjdaxzTSN/2hg+8A2Zho0GWQMCwN6SJKY4Df3JJCq5cON4wRRx7E
         FKyd6dJXEJcPfiiEDCWCCfAeRrmLt7agafEG2OTzpFz2mWBsjKlTNRETWwlTfmMrDHxu
         GQC8iTdJG5nISOqpOO1dKzUh0BJzonDEIpFqGdHz4oiBoRT7lD2k85NEuEovn/Vt8I0Q
         0CmktDAopfluEJLd6yb/7ejxBlqU/DTGiROjTSUOX8S6Ms9XAcSETzxHdZM5dv4RJxn1
         o48kOslq6cCQZKvNnbojBdiw+eE7RnqnT88g0+pfk/cV0+CZ4lvorRIWAZMT/Ls8F9lR
         CbPw==
X-Gm-Message-State: AOJu0YxaiEeK/GM/U0a6EsBnkpvs5JJi79+jcH3J+cxhG7Zv7ffCNpgM
	coofqfF4xu56rmvcd9OaiOfvY4hvgCs2SD3ukujfnmFj1sLKXmj8si3VWMRNIUaQYD/Kvl2JVCI
	0
X-Google-Smtp-Source: AGHT+IHfmOE3Z+KEFUhte6GX9MGDMkr2WBjSOnRf7diSCnbJ/t+RH8mDv4t43jpdnf2l5RuMT0wipA==
X-Received: by 2002:a05:6512:70:b0:52c:8932:27bd with SMTP id 2adb3069b0e04-52ccaa38052mr2918392e87.41.1718897232907;
        Thu, 20 Jun 2024 08:27:12 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42471584311sm59167835e9.0.2024.06.20.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:27:12 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: stable@vger.kernel.org
Cc: dario.binacchi@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Erwan Le Ray <erwan.leray@foss.st.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH 5.15] serial: stm32: rework RX over DMA
Date: Thu, 20 Jun 2024 17:26:57 +0200
Message-ID: <20240620152658.1033479-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ dario: fix conflicts for backport to v5.15. From the [1] series, only the
  first patch was applied to the v5.15 branch. This caused a regression in
  character reception, which can be fixed by applying the second patch. The
  patch has been tested on the stm32f469-disco board.
  [1] https://lore.kernel.org/all/20211020150332.10214-1-erwan.leray@foss.st.com/. ]
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/tty/serial/stm32-usart.c | 206 ++++++++++++++++++++++++-------
 drivers/tty/serial/stm32-usart.h |  12 +-
 2 files changed, 165 insertions(+), 53 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 3b7d4481edbe..c20f8917ebff 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -220,66 +220,60 @@ static int stm32_usart_init_rs485(struct uart_port *port,
 	return uart_get_rs485_mode(port);
 }
 
-static int stm32_usart_pending_rx(struct uart_port *port, u32 *sr,
-				  int *last_res, bool threaded)
+static bool stm32_usart_rx_dma_enabled(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	enum dma_status status;
-	struct dma_tx_state state;
 
-	*sr = readl_relaxed(port->membase + ofs->isr);
+	if (!stm32_port->rx_ch)
+		return false;
 
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
+	return !!(readl_relaxed(port->membase + ofs->cr3) & USART_CR3_DMAR);
+}
+
+/* Return true when data is pending (in pio mode), and false when no data is pending. */
+static bool stm32_usart_pending_rx_pio(struct uart_port *port, u32 *sr)
+{
+	struct stm32_port *stm32_port = to_stm32_port(port);
+	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+
+	*sr = readl_relaxed(port->membase + ofs->isr);
+	/* Get pending characters in RDR or FIFO */
+	if (*sr & USART_SR_RXNE) {
+		/* Get all pending characters from the RDR or the FIFO when using interrupts */
+		if (!stm32_usart_rx_dma_enabled(port))
+			return true;
+
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
 
@@ -298,7 +292,7 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
 			writel_relaxed(sr & USART_SR_ERR_MASK,
 				       port->membase + ofs->icr);
 
-		c = stm32_usart_get_char(port, &sr, &stm32_port->last_res);
+		c = stm32_usart_get_char_pio(port);
 		port->icount.rx++;
 		if (sr & USART_SR_ERR_MASK) {
 			if (sr & USART_SR_ORE) {
@@ -332,6 +326,94 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
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
@@ -373,6 +455,13 @@ static void stm32_usart_tx_interrupt_enable(struct uart_port *port)
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
@@ -588,7 +677,12 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
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
@@ -597,7 +691,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		spin_unlock(&port->lock);
 	}
 
-	if (stm32_port->rx_ch)
+	if (stm32_usart_rx_dma_enabled(port))
 		return IRQ_WAKE_THREAD;
 	else
 		return IRQ_HANDLED;
@@ -903,9 +997,11 @@ static void stm32_usart_set_termios(struct uart_port *port,
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
@@ -968,8 +1064,16 @@ static void stm32_usart_set_termios(struct uart_port *port,
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
@@ -1298,9 +1402,9 @@ static int stm32_usart_of_dma_rx_probe(struct stm32_port *stm32port,
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
@@ -1464,6 +1568,7 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	int err;
+	u32 cr3;
 
 	pm_runtime_get_sync(&pdev->dev);
 	err = uart_remove_one_port(&stm32_usart_driver, port);
@@ -1474,7 +1579,12 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
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
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index ad6335155de2..852573e1a690 100644
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
-- 
2.43.0


