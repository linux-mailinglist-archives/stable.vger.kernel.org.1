Return-Path: <stable+bounces-40868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C838AF964
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0121C248C7
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7921448E0;
	Tue, 23 Apr 2024 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2NrA4+LB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17A143898;
	Tue, 23 Apr 2024 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908517; cv=none; b=L+haQeihc5cfHXPQqhggNCC2BmVolLEJuIIpezce5iCqBh2X8mUIK6Pa99C2aKgyEdxDwb1OXGd10c+GejIDx0VwGBvJDJLq9pMGNWwIQxo7Y3jq7cxWvst5xm1C6S+5jS4T7pAbjVJUAsZK+hczaky+cCs/9SD+TD6nMpO9OJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908517; c=relaxed/simple;
	bh=K2tTR2ZzIRFEFg7q4VyrbR3zD3RxT/8ijj384SmsbvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myS9/qwGJn9C1/UeKlZN/6OCcM3kuguxEKj6sl/8IIGfufp8S7nhqyP8yxWtp8hGT9fehFADwrNSgtMT6ikyhfjw9Lf88CzHoA7+du6iBp4gQD4oz/rOz4BbcuhvT1CnCaaM8cyxYfe3aIj6xPOHu45Jqt1BnuhRGTR/HFuVwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2NrA4+LB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB2EC3277B;
	Tue, 23 Apr 2024 21:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908517;
	bh=K2tTR2ZzIRFEFg7q4VyrbR3zD3RxT/8ijj384SmsbvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2NrA4+LBrNeHXDk7DBtHF85ma03w52mVh4lPeqMXQ8B1DN2lnV51bTTfFHh3+ar/O
	 SZ6zDkmTwAH/U0iCWlT2Kg8Lg9IR9W/g77c8NuACk//AbUHybexbUObTok0Xzsnsr4
	 muxlaKeLFwwlG7kGY3GEKtW6eoR+kT4fTI5EEZpc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 6.8 104/158] serial: stm32: Return IRQ_NONE in the ISR if no handling happend
Date: Tue, 23 Apr 2024 14:38:46 -0700
Message-ID: <20240423213859.323299900@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit 13c785323b36b845300b256d0e5963c3727667d7 upstream.

If there is a stuck irq that the handler doesn't address, returning
IRQ_HANDLED unconditionally makes it impossible for the irq core to
detect the problem and disable the irq. So only return IRQ_HANDLED if
an event was handled.

A stuck irq is still problematic, but with this change at least it only
makes the UART nonfunctional instead of occupying the (usually only) CPU
by 100% and so stall the whole machine.

Fixes: 48a6092fb41f ("serial: stm32-usart: Add STM32 USART Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/5f92603d0dfd8a5b8014b2b10a902d91e0bb881f.1713344161.git.u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/stm32-usart.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -857,6 +857,7 @@ static irqreturn_t stm32_usart_interrupt
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
 	unsigned int size;
+	irqreturn_t ret = IRQ_NONE;
 
 	sr = readl_relaxed(port->membase + ofs->isr);
 
@@ -865,11 +866,14 @@ static irqreturn_t stm32_usart_interrupt
 	    (sr & USART_SR_TC)) {
 		stm32_usart_tc_interrupt_disable(port);
 		stm32_usart_rs485_rts_disable(port);
+		ret = IRQ_HANDLED;
 	}
 
-	if ((sr & USART_SR_RTOF) && ofs->icr != UNDEF_REG)
+	if ((sr & USART_SR_RTOF) && ofs->icr != UNDEF_REG) {
 		writel_relaxed(USART_ICR_RTOCF,
 			       port->membase + ofs->icr);
+		ret = IRQ_HANDLED;
+	}
 
 	if ((sr & USART_SR_WUF) && ofs->icr != UNDEF_REG) {
 		/* Clear wake up flag and disable wake up interrupt */
@@ -878,6 +882,7 @@ static irqreturn_t stm32_usart_interrupt
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
 		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
 			pm_wakeup_event(tport->tty->dev, 0);
+		ret = IRQ_HANDLED;
 	}
 
 	/*
@@ -892,6 +897,7 @@ static irqreturn_t stm32_usart_interrupt
 			uart_unlock_and_check_sysrq(port);
 			if (size)
 				tty_flip_buffer_push(tport);
+			ret = IRQ_HANDLED;
 		}
 	}
 
@@ -899,6 +905,7 @@ static irqreturn_t stm32_usart_interrupt
 		uart_port_lock(port);
 		stm32_usart_transmit_chars(port);
 		uart_port_unlock(port);
+		ret = IRQ_HANDLED;
 	}
 
 	/* Receiver timeout irq for DMA RX */
@@ -908,9 +915,10 @@ static irqreturn_t stm32_usart_interrupt
 		uart_unlock_and_check_sysrq(port);
 		if (size)
 			tty_flip_buffer_push(tport);
+		ret = IRQ_HANDLED;
 	}
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static void stm32_usart_set_mctrl(struct uart_port *port, unsigned int mctrl)



