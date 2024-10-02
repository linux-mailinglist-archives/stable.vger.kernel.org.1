Return-Path: <stable+bounces-78592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5675E98CBEE
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 06:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03131F25B6F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 04:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E70914A90;
	Wed,  2 Oct 2024 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FLSll4gW"
X-Original-To: stable@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6511185;
	Wed,  2 Oct 2024 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727842309; cv=none; b=FQNrzxLcloyg6Dd3dUNsOZ3Fj0yoNuuNsr9sRdsO8Da4pqX0JJBAsPByr9Z9wRIQSCtcZ2dHReSr6MDnQISB0534myJoMSpE2OkiPB/7DQu6Zi6osKI4X3HtUoHtWoYKzpPRZ9E3q+h4B+pd4efjvXqqr5jVgYnvGEqYcI52ivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727842309; c=relaxed/simple;
	bh=KRDX7NDyFkfGwAgj6TWGQt/j4+qO5MdL2S5X8YHmj3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VWCn4gJOo90FiQbgt3GJ/Bv42MjVWN7n8AnjccScm00G7+pU8a5DtJHcaFeM2WFIT1PTNwTsg/MTz+3rSnqpjY1sKpyN/h/iV1HvDSj5Uv92joCJrlFo8wyzxMmiW1YKQQUPMAaQY1Xu/g7Arv+Klztoj+ZVzItubfgfR2HCt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FLSll4gW; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 62EE08891B;
	Wed,  2 Oct 2024 06:11:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727842299;
	bh=KsfCFPP9nTCpb//a/vdl5dqro4qgVsCPuSJPDSKiUYo=;
	h=From:To:Cc:Subject:Date:From;
	b=FLSll4gWgWB0uH7B7uob6PMd7yP6nFa1lp5oQ7wZv7HpmS2k22acWrbi2hRCHLoVJ
	 VtKzBMvxsUf1ygiDi+uu0Tg2RudrFufmeHsbhzc9Ty0zABOi8VkiMO3dtKRpaqItIP
	 U6anGNDYce9kg4EQVDbSL9cLLtFh23BGXvIx40CxbtmiKmKMTiAwdvP9lI0JpmSljq
	 j/QLR4CfzJ4z9TZo2QXAhkXTF+c6uxH+98+Pj5t2pPCVDEkfPLtfQah4HlyXiRY+uB
	 UoHZfaN7OfzKN4HE19OMc+e1EhP+RdHpIvBemfp12EY36PcR+nZXc6+A0MKwy0AinW
	 1SAvUYdKx66oA==
From: Marek Vasut <marex@denx.de>
To: linux-serial@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Esben Haabendal <esben@geanix.com>,
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
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] serial: imx: Update mctrl old_status on RTSD interrupt
Date: Wed,  2 Oct 2024 06:11:16 +0200
Message-ID: <20241002041125.155643-1-marex@denx.de>
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
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
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
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 67d4a72eda770..3ad7f42790ef9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -762,6 +762,10 @@ static irqreturn_t __imx_uart_rtsint(int irq, void *dev_id)
 
 	imx_uart_writel(sport, USR1_RTSD, USR1);
 	usr1 = imx_uart_readl(sport, USR1) & USR1_RTSS;
+	if (usr1 & USR1_RTSS)
+		sport->old_status |= TIOCM_CTS;
+	else
+		sport->old_status &= ~TIOCM_CTS;
 	uart_handle_cts_change(&sport->port, usr1);
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 
-- 
2.45.2


