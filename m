Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF66173E883
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjFZS0i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjFZS0T (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:26:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6442738
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AD4C60EFC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4C6C433C8;
        Mon, 26 Jun 2023 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803939;
        bh=xaQ61A1i4l7YQmR9ONgjZJSLeAzdorilXPRpjwAvtIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2GdZUiThXAnoPmo5dfmIHIBKjXsEp0SzVR4nLQ8RSkLqqQT3hqCCEWBlyfg5tBYH
         fIPo4HANEi50b67I9jSaas/vZRJyKPcXAQGw5kklY4NM7qyt+1f5syp6zH08yb5Im3
         np5+98COaFThG6pCftPJ8sGV4zFi006yOpALAIqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hauke Mehrtens <hauke@hauke-m.de>,
        John Crispin <john@phrozen.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 03/41] serial: lantiq: Do not swap register read/writes
Date:   Mon, 26 Jun 2023 20:11:26 +0200
Message-ID: <20230626180736.362992733@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
References: <20230626180736.243379844@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hauke Mehrtens <hauke@hauke-m.de>

[ Upstream commit d3a28a53630e1ca10f59562ef560e3f70785cb09 ]

The ltq_r32() and ltq_w32() macros use the __raw_readl() and
__raw_writel() functions which do not swap the value to little endian.
On the big endian vrx200 SoC the UART is operated in big endian IO mode,
the readl() and write() functions convert the value to little endian
first and then the driver does not work any more on this SoC.
Currently the vrx200 SoC selects the CONFIG_SWAP_IO_SPACE option,
without this option the serial driver would work, but PCI devices do not
work any more.

This patch makes the driver use the __raw_readl() and __raw_writel()
functions which do not swap the endianness. On big endian system it is
assumed that the device should be access in big endian IO mode and on a
little endian system it would be access in little endian mode.

Fixes: 89b8bd2082bb ("serial: lantiq: Use readl/writel instead of ltq_r32/ltq_w32")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: John Crispin <john@phrozen.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 306320034e8f ("serial: lantiq: add missing interrupt ack")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/lantiq.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index c8dce404ed0c2..de2d051cd7664 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -115,9 +115,9 @@ struct ltq_uart_port {
 
 static inline void asc_update_bits(u32 clear, u32 set, void __iomem *reg)
 {
-	u32 tmp = readl(reg);
+	u32 tmp = __raw_readl(reg);
 
-	writel((tmp & ~clear) | set, reg);
+	__raw_writel((tmp & ~clear) | set, reg);
 }
 
 static inline struct
@@ -145,7 +145,7 @@ lqasc_start_tx(struct uart_port *port)
 static void
 lqasc_stop_rx(struct uart_port *port)
 {
-	writel(ASCWHBSTATE_CLRREN, port->membase + LTQ_ASC_WHBSTATE);
+	__raw_writel(ASCWHBSTATE_CLRREN, port->membase + LTQ_ASC_WHBSTATE);
 }
 
 static int
@@ -154,11 +154,12 @@ lqasc_rx_chars(struct uart_port *port)
 	struct tty_port *tport = &port->state->port;
 	unsigned int ch = 0, rsr = 0, fifocnt;
 
-	fifocnt = readl(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_RXFFLMASK;
+	fifocnt = __raw_readl(port->membase + LTQ_ASC_FSTAT) &
+		  ASCFSTAT_RXFFLMASK;
 	while (fifocnt--) {
 		u8 flag = TTY_NORMAL;
 		ch = readb(port->membase + LTQ_ASC_RBUF);
-		rsr = (readl(port->membase + LTQ_ASC_STATE)
+		rsr = (__raw_readl(port->membase + LTQ_ASC_STATE)
 			& ASCSTATE_ANY) | UART_DUMMY_UER_RX;
 		tty_flip_buffer_push(tport);
 		port->icount.rx++;
@@ -218,7 +219,7 @@ lqasc_tx_chars(struct uart_port *port)
 		return;
 	}
 
-	while (((readl(port->membase + LTQ_ASC_FSTAT) &
+	while (((__raw_readl(port->membase + LTQ_ASC_FSTAT) &
 		ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF) != 0) {
 		if (port->x_char) {
 			writeb(port->x_char, port->membase + LTQ_ASC_TBUF);
@@ -246,7 +247,7 @@ lqasc_tx_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
-	writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
+	__raw_writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	lqasc_start_tx(port);
 	return IRQ_HANDLED;
@@ -271,7 +272,7 @@ lqasc_rx_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
-	writel(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
+	__raw_writel(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
 	lqasc_rx_chars(port);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	return IRQ_HANDLED;
@@ -281,7 +282,8 @@ static unsigned int
 lqasc_tx_empty(struct uart_port *port)
 {
 	int status;
-	status = readl(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_TXFFLMASK;
+	status = __raw_readl(port->membase + LTQ_ASC_FSTAT) &
+		 ASCFSTAT_TXFFLMASK;
 	return status ? 0 : TIOCSER_TEMT;
 }
 
@@ -314,12 +316,12 @@ lqasc_startup(struct uart_port *port)
 	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
 		port->membase + LTQ_ASC_CLC);
 
-	writel(0, port->membase + LTQ_ASC_PISEL);
-	writel(
+	__raw_writel(0, port->membase + LTQ_ASC_PISEL);
+	__raw_writel(
 		((TXFIFO_FL << ASCTXFCON_TXFITLOFF) & ASCTXFCON_TXFITLMASK) |
 		ASCTXFCON_TXFEN | ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
-	writel(
+	__raw_writel(
 		((RXFIFO_FL << ASCRXFCON_RXFITLOFF) & ASCRXFCON_RXFITLMASK)
 		| ASCRXFCON_RXFEN | ASCRXFCON_RXFFLU,
 		port->membase + LTQ_ASC_RXFCON);
@@ -351,7 +353,7 @@ lqasc_startup(struct uart_port *port)
 		goto err2;
 	}
 
-	writel(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
+	__raw_writel(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
 		port->membase + LTQ_ASC_IRNREN);
 	return 0;
 
@@ -370,7 +372,7 @@ lqasc_shutdown(struct uart_port *port)
 	free_irq(ltq_port->rx_irq, port);
 	free_irq(ltq_port->err_irq, port);
 
-	writel(0, port->membase + LTQ_ASC_CON);
+	__raw_writel(0, port->membase + LTQ_ASC_CON);
 	asc_update_bits(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
 		port->membase + LTQ_ASC_RXFCON);
 	asc_update_bits(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
@@ -462,13 +464,13 @@ lqasc_set_termios(struct uart_port *port,
 	asc_update_bits(ASCCON_BRS, 0, port->membase + LTQ_ASC_CON);
 
 	/* now we can write the new baudrate into the register */
-	writel(divisor, port->membase + LTQ_ASC_BG);
+	__raw_writel(divisor, port->membase + LTQ_ASC_BG);
 
 	/* turn the baudrate generator back on */
 	asc_update_bits(0, ASCCON_R, port->membase + LTQ_ASC_CON);
 
 	/* enable rx */
-	writel(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
+	__raw_writel(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
 
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 
@@ -579,7 +581,7 @@ lqasc_console_putchar(struct uart_port *port, int ch)
 		return;
 
 	do {
-		fifofree = (readl(port->membase + LTQ_ASC_FSTAT)
+		fifofree = (__raw_readl(port->membase + LTQ_ASC_FSTAT)
 			& ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
 	} while (fifofree == 0);
 	writeb(ch, port->membase + LTQ_ASC_TBUF);
-- 
2.39.2



