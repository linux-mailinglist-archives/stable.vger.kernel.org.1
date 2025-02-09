Return-Path: <stable+bounces-114420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C7A2DB61
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 07:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583EC1887C23
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 06:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8622A8831;
	Sun,  9 Feb 2025 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KuE8Zxwd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9410F4
	for <stable@vger.kernel.org>; Sun,  9 Feb 2025 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739083733; cv=none; b=lqYEQFrqWsbaIVvchDzQ0YuRbk8r2pf9HuzQzVtX8kREpPH1548d/c5mtbLLz4Jx5pSamJlPpXHHnyg0uR683zkH5DEtCcGLzZswTO8UXtMs71x1EI0uMPhc527KaMnvSrWbzddjopn+YDzFbyurwGrDT70QSNt/aOMpr8JAqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739083733; c=relaxed/simple;
	bh=Lroqw0ec1NeMQ05ioKeMou4lf0rliNSciMYGD51/bJk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FR1CMHmKrfmpviLcblJOetEmLvte6rvodghfBLprsHPsI9c06ECgT9viuMUQ/ZaXEUAY2zx84uf1Bri8FBtU+SeGZLGajU/rFZsg5UI4AlEsaMC9E0Igb+BGmerSR1jas0+HM3mqLAYw9aIEITw7YnK3g82ktt5vL0GgCiPSrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KuE8Zxwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD49C4CEDD;
	Sun,  9 Feb 2025 06:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739083732;
	bh=Lroqw0ec1NeMQ05ioKeMou4lf0rliNSciMYGD51/bJk=;
	h=Subject:To:Cc:From:Date:From;
	b=KuE8Zxwdtj73CVsW89hwKC6UJTUIZi5HfEuWKjq6shB3Um+ZcuIxHx4WEI197c8ks
	 YJ5xJQqRdVFRgL3ZqqFltP+cUJKyQZcCTEdZPlYQE4+v76Ou7SqBFbjBj+dYFqZbKL
	 CigzQtdttsFx4xVRqVAbZFtsNL030dj+Dvaxz0gU=
Subject: FAILED: patch "[PATCH] tty: xilinx_uartps: split sysrq handling" failed to apply to 6.6-stable tree
To: sean.anderson@linux.dev,gregkh@linuxfoundation.org,john.ogness@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Feb 2025 07:48:49 +0100
Message-ID: <2025020949-press-evolve-b900@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b06f388994500297bb91be60ffaf6825ecfd2afe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020949-press-evolve-b900@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b06f388994500297bb91be60ffaf6825ecfd2afe Mon Sep 17 00:00:00 2001
From: Sean Anderson <sean.anderson@linux.dev>
Date: Fri, 10 Jan 2025 16:38:22 -0500
Subject: [PATCH] tty: xilinx_uartps: split sysrq handling

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
Cc: stable@vger.kernel.org # c980248179d: serial: xilinx_uartps: Use port lock wrappers
Acked-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20250110213822.2107462-1-sean.anderson@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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


