Return-Path: <stable+bounces-66476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E2E94EBFD
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC07B2164D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E805176AD1;
	Mon, 12 Aug 2024 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RSy2hTiv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465616A948
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462941; cv=none; b=hratz/s2UrwEI9y7tloxEKjS6l6AzvUIxsXjmuUbj8HL7oSNwbkIi3Rlh3QtH4NaXgtAmerD5bOQ3OOhcQSYlr6iWkDEiuh2TRGH8tZH3cfgAyS97HzHTNG83mTHqVH7V7rL1ZxhW/r0hSfgzxAJMwP7X/pL1eFripK7c+Ygm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462941; c=relaxed/simple;
	bh=fWqyXeD6XXHszg/1sS/wIeN7KRNzKBP7jUd33bCozns=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MdZPeHRgoaNqAZaR5CBgWVRNeYQZ+jH3sB9lh92jpwG+1HF5GJ20MRVpITm/Tv7RADmLy0HG5zwWPWkxJGjS4UzBrQjN/U+vugdDSieJVXjHXDQDPAmdVKjZS2HQS/tsKEg/1ZDvHsi+VBFMOkZkM6uiJbR0S17kUuag1E8eQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RSy2hTiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DDAC32782;
	Mon, 12 Aug 2024 11:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723462941;
	bh=fWqyXeD6XXHszg/1sS/wIeN7KRNzKBP7jUd33bCozns=;
	h=Subject:To:Cc:From:Date:From;
	b=RSy2hTiv8sZWBV8SawqxdBba0pP+VDvm6fr97pQVIMedhm0u44WB4FU7paLa1+UZW
	 kBiGCTpi+r2/oVSXGLmnYur8QseXJvWuS42jIjU5otjS3xzRkd0F9rbmegOIaJRVrL
	 ZbZXPNVePt3BAQ3S+/OIKaNh6K77pisISQ0Yg6Zg=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix invalid FIFO access with special" failed to apply to 5.4-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 13:42:17 +0200
Message-ID: <2024081216-unreal-cape-7729@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7d3b793faaab1305994ce568b59d61927235f57b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081216-unreal-cape-7729@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
6e124e58ae2e ("sc16is7xx: Set AUTOCTS and AUTORTS bits")
21144bab4f11 ("sc16is7xx: Handle modem status lines")
cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
d4ab5487cc77 ("Merge 5.17-rc6 into tty-next")

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
 


