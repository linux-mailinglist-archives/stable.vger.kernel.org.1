Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8856FAE25
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbjEHLlu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbjEHLl2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA59B423AC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D8C363539
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B76CC433D2;
        Mon,  8 May 2023 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546057;
        bh=4TKXIcYv+nEbW51CdgHkvfVkvDfIpmy7mzNDqq/8gK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJAfE9Bcl37L6etWhIciwWPtQfbVfg2B8raEE19dONe29NS12tApwHhfb7ZBdpSPP
         6V9M1hYeYnOpA92C9hKYc3A5sZibbI9JEsNLH1z44/SSju7sxPGI43mRFGj3IWnazE
         Y0XRy+tgPGC87CNoCLD5RL6WW2MTxHArkfkGks80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Erwan Le Ray <erwan.leray@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 242/371] serial: stm32: re-introduce an irq flag condition in usart_receive_chars
Date:   Mon,  8 May 2023 11:47:23 +0200
Message-Id: <20230508094821.672749995@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Erwan Le Ray <erwan.leray@foss.st.com>

[ Upstream commit cc58d0a3f0a4755b9c808e065d9227c6e984e7db ]

Re-introduce an irq flag condition in usart_receive_chars.
This condition has been deleted by commit 75f4e830fa9c ("serial: do not
restore interrupt state in sysrq helper").
This code was present to handle threaded case, and has been removed
because it is no more needed in this case. Nevertheless an irq safe lock
is still needed in some cases, when DMA should be stopped to receive errors
or breaks in PIO mode.
This patch is a precursor to the complete rework or stm32 serial driver
DMA implementation.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
Link: https://lore.kernel.org/r/20211020150332.10214-2-erwan.leray@foss.st.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: c47527cbcc3c ("serial: stm32: Re-assert RTS/DE GPIO in RS485 mode only if more data are transmitted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/stm32-usart.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 5c60960e185d2..0e8158cfaf0f9 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -264,19 +264,22 @@ static unsigned long stm32_usart_get_char(struct uart_port *port, u32 *sr,
 	return c;
 }
 
-static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
+static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
 {
 	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	unsigned long c;
+	unsigned long c, flags;
 	u32 sr;
 	char flag;
 
-	spin_lock(&port->lock);
+	if (irqflag)
+		spin_lock_irqsave(&port->lock, flags);
+	else
+		spin_lock(&port->lock);
 
 	while (stm32_usart_pending_rx(port, &sr, &stm32_port->last_res,
-				      threaded)) {
+				      irqflag)) {
 		sr |= USART_SR_DUMMY_RX;
 		flag = TTY_NORMAL;
 
@@ -330,7 +333,10 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
 		uart_insert_char(port, sr, USART_SR_ORE, c, flag);
 	}
 
-	uart_unlock_and_check_sysrq(port);
+	if (irqflag)
+		uart_unlock_and_check_sysrq_irqrestore(port, irqflag);
+	else
+		uart_unlock_and_check_sysrq(port);
 
 	tty_flip_buffer_push(tport);
 }
@@ -599,10 +605,9 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
-	struct stm32_port *stm32_port = to_stm32_port(port);
 
-	if (stm32_port->rx_ch)
-		stm32_usart_receive_chars(port, true);
+	/* Receiver timeout irq for DMA RX */
+	stm32_usart_receive_chars(port, false);
 
 	return IRQ_HANDLED;
 }
-- 
2.39.2



