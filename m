Return-Path: <stable+bounces-80597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1898E2BD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 20:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8397F28361B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525A2141B9;
	Wed,  2 Oct 2024 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="dN4eCUGP"
X-Original-To: stable@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559601D0431;
	Wed,  2 Oct 2024 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894511; cv=none; b=BpSrz3VzEhpmk0jb+xUJcD3kTTLXBXKqId6tlOlJKCCpwqTMuNvvIkx7Y+1+bSW99fNHk6YXbveH+/JrX7atFFHYt7HyOC/Tyv+Vq3O0Oo8BKgm1ZKkn9f7TD77yizm9cNMYUM85PWYTiPJ/zIudR+AhzWet1uphb5qcxz6fs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894511; c=relaxed/simple;
	bh=JKE1QjGzfsOmvyp0yAYM6Te10fCsyTqWk4OqCJlP3N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wymk+tqqBLJpId5Ufy00Nv8Pt2f6ofYi80CIP43slaPt7PA+eoVTruVU5wjlWwtK0oxJm2jjjWo3Y0rmtuc4923T/+/QLE8ijHimcUoarF4/jlwL0Sy8p4PTikWpjlz2hoWRu0Uc156aKmTG5RQ/cF45kTT/kAYGcLoalip11jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=dN4eCUGP; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9ED0A88F44;
	Wed,  2 Oct 2024 20:41:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727894506;
	bh=zuPq8tlRciTxlcbGOB0i7tsntZdMbWeR5LKsvLq22ZU=;
	h=From:To:Cc:Subject:Date:From;
	b=dN4eCUGPYJu8qYlYJL8JmdrYPyNZGIpGkOW0kg4oygCoWO78WU+3Sd37CjRO7cj3C
	 pN2LGe8ww3sRrIpR4WNjZ+SMsoHlO2pX4pXW/Svc4Mkxjxc/pMnqHiCdIpcE6S+B1H
	 ZcJj17RerMoso/w/YxW/xhtYbeD+i1yl1K8isq3+L9w+4jJyIdfYbl1yt8dqSB/+Li
	 VmyEX340nleck3tFdpDArZ50wLuCUZ4XV5Mz9wOu5bdheyRhmrQpm0utItzdxhhZxt
	 6tOHvlQku2IQPD3FGPwSSs60dlSBbPbw0kDEwZ7359VhVgAbVxF4vVsjqbvZIPz/+7
	 HzAJjwTx2xnQA==
From: Marek Vasut <marex@denx.de>
To: linux-serial@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Esben Haabendal <esben@geanix.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Fabio Estevam <festevam@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Rickard x Andersson <rickaran@axis.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: imx: Update mctrl old_status on RTSD interrupt
Date: Wed,  2 Oct 2024 20:40:38 +0200
Message-ID: <20241002184133.19427-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

When sending data using DMA at high baudrate (4 Mbdps in local test case) to
a device with small RX buffer which keeps asserting RTS after every received
byte, it is possible that the iMX UART driver would not recognize the falling
edge of RTS input signal and get stuck, unable to transmit any more data.

This condition happens when the following sequence of events occur:
- imx_uart_mctrl_check() is called at some point and takes a snapshot of UART
  control signal status into sport->old_status using imx_uart_get_hwmctrl().
  The RTSS/TIOCM_CTS bit is of interest here (*).
- DMA transfer occurs, the remote device asserts RTS signal after each byte.
  The i.MX UART driver recognizes each such RTS signal change, raises an
  interrupt with USR1 register RTSD bit set, which leads to invocation of
  __imx_uart_rtsint(), which calls uart_handle_cts_change().
  - If the RTS signal is deasserted, uart_handle_cts_change() clears
    port->hw_stopped and unblocks the port for further data transfers.
  - If the RTS is asserted, uart_handle_cts_change() sets port->hw_stopped
    and blocks the port for further data transfers. This may occur as the
    last interrupt of a transfer, which means port->hw_stopped remains set
    and the port remains blocked (**).
- Any further data transfer attempts will trigger imx_uart_mctrl_check(),
  which will read current status of UART control signals by calling
  imx_uart_get_hwmctrl() (***) and compare it with sport->old_status .
  - If current status differs from sport->old_status for RTS signal,
    uart_handle_cts_change() is called and possibly unblocks the port
    by clearing port->hw_stopped .
  - If current status does not differ from sport->old_status for RTS
    signal, no action occurs. This may occur in case prior snapshot (*)
    was taken before any transfer so the RTS is deasserted, current
    snapshot (***) was taken after a transfer and therefore RTS is
    deasserted again, which means current status and sport->old_status
    are identical. In case (**) triggered when RTS got asserted, and
    made port->hw_stopped set, the port->hw_stopped will remain set
    because no change on RTS line is recognized by this driver and
    uart_handle_cts_change() is not called from here to unblock the
    port->hw_stopped.

Update sport->old_status in __imx_uart_rtsint() accordingly to make
imx_uart_mctrl_check() detect such RTS change. Note that TIOCM_CAR
and TIOCM_RI bits in sport->old_status do not suffer from this problem.

Fixes: ceca629e0b48 ("[ARM] 2971/1: i.MX uart handle rts irq")
Reviewed-by: Esben Haabendal <esben@geanix.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Esben Haabendal <esben@geanix.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Rickard x Andersson <rickaran@axis.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
---
V2: - Add code comment
    - Add RB from Esben
---
 drivers/tty/serial/imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 67d4a72eda770..90974d338f3c0 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -762,6 +762,21 @@ static irqreturn_t __imx_uart_rtsint(int irq, void *dev_id)
 
 	imx_uart_writel(sport, USR1_RTSD, USR1);
 	usr1 = imx_uart_readl(sport, USR1) & USR1_RTSS;
+	/*
+	 * Update sport->old_status here, so any follow-up calls to
+	 * imx_uart_mctrl_check() will be able to recognize that RTS
+	 * state changed since last imx_uart_mctrl_check() call.
+	 *
+	 * In case RTS has been detected as asserted here and later on
+	 * deasserted by the time imx_uart_mctrl_check() was called,
+	 * imx_uart_mctrl_check() can detect the RTS state change and
+	 * trigger uart_handle_cts_change() to unblock the port for
+	 * further TX transfers.
+	 */
+	if (usr1 & USR1_RTSS)
+		sport->old_status |= TIOCM_CTS;
+	else
+		sport->old_status &= ~TIOCM_CTS;
 	uart_handle_cts_change(&sport->port, usr1);
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 
-- 
2.45.2


