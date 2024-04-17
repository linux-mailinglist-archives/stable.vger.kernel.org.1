Return-Path: <stable+bounces-40087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B9B8A7F1B
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0755C1C21B32
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B3612F375;
	Wed, 17 Apr 2024 09:04:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9612DDB2
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344683; cv=none; b=BdFLEkh34qh2fVh2UbCWhnSsRL8tdCh5wXqYV9Ks2KSjii2MDzd5vBEHaUDM44N+5jDbXRu8rzU2Ta11Te1DkVQ/BGpeWhSm+sKvXGfM5ClmG2xZlfQCO1l8tyYQ0ia6PBa4FSZwmBWhoIEGlA5TtH/A93k+ezCDKZao83kdKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344683; c=relaxed/simple;
	bh=jz6AwetzGMEFARbI09ryhM79Cpp+5tcl5jRCkdSNET4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgJ+M8U1ZgMArOnFXXGcnSzP5na06FwjSa69r9x3yewmVZWLL2crR6hox1dI/9lLJtWUeDDdcIUojExQFSbFcYt+LRn2e2kHUQ13ZvIhzNJsILg3Wnv/DVA8HKamBzEkxKf70M1ZboLElnQsSGUbX3zsfMDehVQPPvbVv4uLgm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx1DD-0004om-PA; Wed, 17 Apr 2024 11:04:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx1DB-00ClGH-Va; Wed, 17 Apr 2024 11:04:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx1DB-002hM0-2s;
	Wed, 17 Apr 2024 11:04:13 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel@pengutronix.de,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Erwan Le Ray <erwan.leray@foss.st.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-serial@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] serial: stm32: Return IRQ_NONE in the ISR if no handling happend
Date: Wed, 17 Apr 2024 11:03:27 +0200
Message-ID:  <5f92603d0dfd8a5b8014b2b10a902d91e0bb881f.1713344161.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713344161.git.u.kleine-koenig@pengutronix.de>
References: <cover.1713344161.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=jz6AwetzGMEFARbI09ryhM79Cpp+5tcl5jRCkdSNET4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmH5BgGqqxohanUIs9ldgC3LKg8mUkUOW5enTWc nNTWDud12aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZh+QYAAKCRCPgPtYfRL+ Tn61B/wLkA8sd9+OtnXiV7D2HuC8Y3rIY+yd3AqI83nlYd01ePT6tnPUuatJgNSOV1d5bvjLaJm Ww7/8w3VW765fy5wfteHQLWausCQyAutmj+F6PnsX/OwEPLE4g4nxolcav8z+bREIaOtvDzyxy7 a/pNV+1rHNPJdvh/WU7yxwYahJbXPp/8CE1ULP4jU1fSzERqTXO9Ezig1qg5F1j4DDjhP4XxX57 ZBQ6Vr0E385ebYDSFYLSHM95N1xNfBpWjXb3Rs575gZMYo/3U+2F8eiw0j4QvXFfEHIOaAOBqGy pNB5jT61gSQrg8z709OwewOeRD9EqDtj7zvOHIteSZzbR+9u
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

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
---
 drivers/tty/serial/stm32-usart.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 8c66abcfe6ca..2bea1d7c9858 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -849,6 +849,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	u32 sr;
 	unsigned int size;
+	irqreturn_t ret = IRQ_NONE;
 
 	sr = readl_relaxed(port->membase + ofs->isr);
 
@@ -857,11 +858,14 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
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
@@ -870,6 +874,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
 		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
 			pm_wakeup_event(tport->tty->dev, 0);
+		ret = IRQ_HANDLED;
 	}
 
 	/*
@@ -884,6 +889,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 			uart_unlock_and_check_sysrq(port);
 			if (size)
 				tty_flip_buffer_push(tport);
+			ret = IRQ_HANDLED;
 		}
 	}
 
@@ -891,6 +897,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		uart_port_lock(port);
 		stm32_usart_transmit_chars(port);
 		uart_port_unlock(port);
+		ret = IRQ_HANDLED;
 	}
 
 	/* Receiver timeout irq for DMA RX */
@@ -900,9 +907,10 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 		uart_unlock_and_check_sysrq(port);
 		if (size)
 			tty_flip_buffer_push(tport);
+		ret = IRQ_HANDLED;
 	}
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static void stm32_usart_set_mctrl(struct uart_port *port, unsigned int mctrl)
-- 
2.43.0


