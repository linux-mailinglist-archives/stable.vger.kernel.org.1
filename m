Return-Path: <stable+bounces-40655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CC18AE65C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200E21C21F67
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1EA136E2D;
	Tue, 23 Apr 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cOZ96pHa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF91350D1
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875817; cv=none; b=FTsFom14LvzjHRZatx1SUyJ0LlOg9Su2K3kpeYHOYsE8iBM8nDiiQYiSHUZlxWx/nAJ8Nq4DU8UVuvqsHD4Wjb1SUZITN4I7BQxZunLI7zhVVRr8J0cV+SzYcM+JgudWJ1EoFAJuNj6sOt6gVqkCwALacDzUErRtW1DX67pcVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875817; c=relaxed/simple;
	bh=Qs4OckOVj21HtKhaIovxzMC7+S7MqOTfskXAP+6uIWI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rZTZiL9zos9YNZcy1KpM16tPvaOwuAC5s6wzUVvgQzB6cgBWUuWt8Z7m/EygPTW+7VzzNfu9KRqnTvqQ3FBWSRe29NRH5lfobpiJD1nYGnjTH0MPe3mzWSYHBpxkPtaDTkpoi9Ucwx1bWEY7XeXyafDERbxoNG+BJdKtVmQFRWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOZ96pHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8379C3277B;
	Tue, 23 Apr 2024 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713875816;
	bh=Qs4OckOVj21HtKhaIovxzMC7+S7MqOTfskXAP+6uIWI=;
	h=Subject:To:Cc:From:Date:From;
	b=cOZ96pHaAJKNDaqH0hm6JfaRnNs8csRl7mpddY/x6G3bJRdFTXgs3D9n2uNwpVuRb
	 4Vxga/k+dzgP38wfYsFWYKvVjmxDg9TgYX1pQKwOImc+Bvogjm0tqmqeBgGynAMiMU
	 6JHJ+ggCYynCYITJJkZBQV/W2xVlL9+h8RDaVT5w=
Subject: FAILED: patch "[PATCH] serial: stm32: Return IRQ_NONE in the ISR if no handling" failed to apply to 5.4-stable tree
To: u.kleine-koenig@pengutronix.de,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:36:46 -0700
Message-ID: <2024042346-correct-footgear-b44a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 13c785323b36b845300b256d0e5963c3727667d7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042346-correct-footgear-b44a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

13c785323b36 ("serial: stm32: Return IRQ_NONE in the ISR if no handling happend")
c5d06662551c ("serial: stm32: Use port lock wrappers")
a01ae50d7eae ("serial: stm32: replace access to DMAR bit by dmaengine_pause/resume")
7f28bcea824e ("serial: stm32: group dma pause/resume error handling into single function")
00d1f9c6af0d ("serial: stm32: modify parameter and rename stm32_usart_rx_dma_enabled")
db89728abad5 ("serial: stm32: avoid clearing DMAT bit during transfer")
3f6c02fa712b ("serial: stm32: Merge hard IRQ and threaded IRQ handling into single IRQ handler")
d7c76716169d ("serial: stm32: Use TC interrupt to deassert GPIO RTS in RS485 mode")
3bcea529b295 ("serial: stm32: Factor out GPIO RTS toggling into separate function")
037b91ec7729 ("serial: stm32: fix software flow control transfer")
d3d079bde07e ("serial: stm32: prevent TDR register overwrite when sending x_char")
195437d14fb4 ("serial: stm32: correct loop for dma error handling")
2a3bcfe03725 ("serial: stm32: fix flow control transfer in DMA mode")
9a135f16d228 ("serial: stm32: rework TX DMA state condition")
56a23f9319e8 ("serial: stm32: move tx dma terminate DMA to shutdown")
6333a4850621 ("serial: stm32: push DMA RX data before suspending")
6eeb348c8482 ("serial: stm32: terminate / restart DMA transfer at suspend / resume")
e0abc903deea ("serial: stm32: rework RX dma initialization and release")
d1ec8a2eabe9 ("serial: stm32: update throttle and unthrottle ops for dma mode")
33bb2f6ac308 ("serial: stm32: rework RX over DMA")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 13c785323b36b845300b256d0e5963c3727667d7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Wed, 17 Apr 2024 11:03:27 +0200
Subject: [PATCH] serial: stm32: Return IRQ_NONE in the ISR if no handling
 happend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 58d169e5c1db..d60cbac69194 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -861,6 +861,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
 	unsigned int size;
+	irqreturn_t ret = IRQ_NONE;
 
 	sr = readl_relaxed(port->membase + ofs->isr);
 
@@ -869,11 +870,14 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
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
@@ -882,6 +886,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
 		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
 			pm_wakeup_event(tport->tty->dev, 0);
+		ret = IRQ_HANDLED;
 	}
 
 	/*
@@ -896,6 +901,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 			uart_unlock_and_check_sysrq(port);
 			if (size)
 				tty_flip_buffer_push(tport);
+			ret = IRQ_HANDLED;
 		}
 	}
 
@@ -903,6 +909,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		uart_port_lock(port);
 		stm32_usart_transmit_chars(port);
 		uart_port_unlock(port);
+		ret = IRQ_HANDLED;
 	}
 
 	/* Receiver timeout irq for DMA RX */
@@ -912,9 +919,10 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		uart_unlock_and_check_sysrq(port);
 		if (size)
 			tty_flip_buffer_push(tport);
+		ret = IRQ_HANDLED;
 	}
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static void stm32_usart_set_mctrl(struct uart_port *port, unsigned int mctrl)


