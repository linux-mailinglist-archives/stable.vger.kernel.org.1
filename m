Return-Path: <stable+bounces-66473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F5394EBF7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412D228131C
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E32A176FA5;
	Mon, 12 Aug 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BdaM5aV8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85416A948
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462929; cv=none; b=VK66sN967O4xcWipKrVzeN0roITQfAyb9iVpV/FnGcDyBjjtLFF5Tj4eFQlAVrdJ4V0pxvtKVKczCayuB17PQ8fsOspKx5Ann5pwwY1WWD1D8kxbmmNlFPtxgxVucRPDe/eoPDuoAOlpVG6Qdsu71XfQQOhbixH7DhQl3X2gNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462929; c=relaxed/simple;
	bh=aotD6jDn3M29QhtMODqMBQtb4E0t9zgK99XGhJ0pXfc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LWKZG+WzaFMiUXaz8zXRccOHv2MVRTz5fgINV+ECw8W63jNrcnxhRzZ1XuBFeR2CKOT4+TeFBvr1+mkYHJYLHyJfbz8B6rSNr7Z106sKCwJZ4XV+8/DRWB9l6nby0CEf3XJNc8jq2q9z2DboSnbZRTHeoK8C0XtjNj3axC8B1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BdaM5aV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D684C32782;
	Mon, 12 Aug 2024 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723462929;
	bh=aotD6jDn3M29QhtMODqMBQtb4E0t9zgK99XGhJ0pXfc=;
	h=Subject:To:Cc:From:Date:From;
	b=BdaM5aV8vXLZHys4yeg0tldRbpBlFWwqzKYAL96npILoIoG6U/dXvD68wZZqbFplp
	 2sBLBWDmoZhYUbyHKzOszJ3E7OkgEN7MaIB2V5xSOIT9ILyZ3jLq5NBvFxnZnwPoTe
	 mH1IOIXB4UdBhX/SI1DTxpVtJowmra2GZukcgpU4=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix invalid FIFO access with special" failed to apply to 6.1-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 13:42:05 +0200
Message-ID: <2024081204-deserving-flanked-a918@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7d3b793faaab1305994ce568b59d61927235f57b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081204-deserving-flanked-a918@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

7d3b793faaab ("serial: sc16is7xx: fix invalid FIFO access with special register set")
8492bd91aa05 ("serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using prescaler")
0c84bea0cabc ("serial: sc16is7xx: refactor EFR lock")
2de8a1b46756 ("serial: sc16is7xx: reorder code to remove prototype declarations")
2e57cefc4477 ("serial: sc16is7xx: replace hardcoded divisor value with BIT() macro")
4409df5866b7 ("serial: sc16is7xx: change EFR lock to operate on each channels")
3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
22a048b07493 ("serial: sc16is7xx: remove unused to_sc16is7xx_port macro")
b4a778303ea0 ("serial: sc16is7xx: add missing support for rs485 devicetree properties")
049994292834 ("serial: sc16is7xx: fix regression with GPIO configuration")
dabc54a45711 ("serial: sc16is7xx: remove obsolete out_thread label")
c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later in probe")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d3b793faaab1305994ce568b59d61927235f57b Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 23 Jul 2024 08:53:01 -0400
Subject: [PATCH] serial: sc16is7xx: fix invalid FIFO access with special
 register set

When enabling access to the special register set, Receiver time-out and
RHR interrupts can happen. In this case, the IRQ handler will try to read
from the FIFO thru the RHR register at address 0x00, but address 0x00 is
mapped to DLL register, resulting in erroneous FIFO reading.

Call graph example:
    sc16is7xx_startup(): entry
    sc16is7xx_ms_proc(): entry
    sc16is7xx_set_termios(): entry
    sc16is7xx_set_baud(): DLH/DLL = $009C --> access special register set
    sc16is7xx_port_irq() entry            --> IIR is 0x0C
    sc16is7xx_handle_rx() entry
    sc16is7xx_fifo_read(): --> unable to access FIFO (RHR) because it is
                               mapped to DLL (LCR=LCR_CONF_MODE_A)
    sc16is7xx_set_baud(): exit --> Restore access to general register set

Fix the problem by claiming the efr_lock mutex when accessing the Special
register set.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240723125302.1305372-3-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 58696e05492c..b4c1798a1df2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -592,6 +592,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			      SC16IS7XX_MCR_CLKSEL_BIT,
 			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
+	mutex_lock(&one->efr_lock);
+
 	/* Backup LCR and access special register set (DLL/DLH) */
 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
@@ -606,6 +608,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Restore LCR and access to general register set */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
+	mutex_unlock(&one->efr_lock);
+
 	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
 


