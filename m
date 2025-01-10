Return-Path: <stable+bounces-108235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D46A09D4D
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 22:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED763AA896
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 21:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1182116E6;
	Fri, 10 Jan 2025 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wva81Aww"
X-Original-To: stable@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBCF18C03A
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736545119; cv=none; b=FhP/PUI8m6xVG/3wEkPmh+WPwk93VsRoxq55EnUu9prJOG7MG5z5KkZ+dPY8Sk/eCjXMWk2bW8HejQSuKIUVk7jUW/qOQ12UHsGggSISTQgRXr27wQeebKTYz8J1CQdnXnrjV2moewF4RZzx5Q2yafRnSnjbshuvZCBfznLCuy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736545119; c=relaxed/simple;
	bh=uN8OvW217jnJrGT746idFk71yViCEnErL4OQOhqSQZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DYX2Jjgq+g5Wd/8Kf7/TWiaA/CEDRjmxd4SpHZdm3D5lv8p4s605tyM2DTp7NBmamLXmZwBlLC4gxYHrOU4GFMEG1nbHlPLwRek0Lq3n9JI1YCGT/uQ1urCuLTzyt6I3QSmbXx/3ZmZNF/+ggE7NngpJyxatO56KE4uahkstjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wva81Aww; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736545109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iC3k1SZlNlarqOZELintr0r8/tkyMFglXXS2+edHzKk=;
	b=Wva81Awwv8ENbIE/bgyPENEqbHTNL7iwNmGOtP50PP3xoef58qXCG690ciwFORmKWOkdrA
	FNQQVJ3dEzFR5l/R2SluGnP4Br//1R/g2BpGUpQFhiM0+NiikXAjGI5g6lNrvm9Vedt/b/
	wGU6ue67daWJX2W5IWpOviA0bntRhrY=
From: Sean Anderson <sean.anderson@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sean Anderson <sean.anderson@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] tty: xilinx_uartps: split sysrq handling
Date: Fri, 10 Jan 2025 16:38:22 -0500
Message-Id: <20250110213822.2107462-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

lockdep detects the following circular locking dependency:

CPU 0                      CPU 1
========================== ============================
cdns_uart_isr()            printk()
  uart_port_lock(port)       console_lock()
			     cdns_uart_console_write()
                               if (!port->sysrq)
                                 uart_port_lock(port)
  uart_handle_break()
    port->sysrq = ...
  uart_handle_sysrq_char()
    printk()
      console_lock()

The fixed commit attempts to avoid this situation by only taking the
port lock in cdns_uart_console_write if port->sysrq unset. However, if
(as shown above) cdns_uart_console_write runs before port->sysrq is set,
then it will try to take the port lock anyway. This may result in a
deadlock.

Fix this by splitting sysrq handling into two parts. We use the prepare
helper under the port lock and defer handling until we release the lock.

Fixes: 74ea66d4ca06 ("tty: xuartps: Improve sysrq handling")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Cc: <stable@vger.kernel.org> # c980248179d: serial: xilinx_uartps: Use port lock wrappers
---

 drivers/tty/serial/xilinx_uartps.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index beb151be4d32..92ec51870d1d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -287,7 +287,7 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 				continue;
 		}
 
-		if (uart_handle_sysrq_char(port, data))
+		if (uart_prepare_sysrq_char(port, data))
 			continue;
 
 		if (is_rxbs_support) {
@@ -495,7 +495,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	    !(readl(port->membase + CDNS_UART_CR) & CDNS_UART_CR_RX_DIS))
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
-	uart_port_unlock(port);
+	uart_unlock_and_check_sysrq(port);
 	return IRQ_HANDLED;
 }
 
@@ -1380,9 +1380,7 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 	unsigned int imr, ctrl;
 	int locked = 1;
 
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
+	if (oops_in_progress)
 		locked = uart_port_trylock_irqsave(port, &flags);
 	else
 		uart_port_lock_irqsave(port, &flags);
-- 
2.35.1.1320.gc452695387.dirty


