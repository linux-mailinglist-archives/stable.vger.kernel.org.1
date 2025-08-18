Return-Path: <stable+bounces-169962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AC9B29EAA
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8135E5E0008
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4831064A;
	Mon, 18 Aug 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yowTLxxR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24931063C
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511258; cv=none; b=YlxQP46olzkTFcmD0kmKAJI6AxBKvYKikuiNXvki5SFy8uE8i52sbI9LblfxRY7TLiAvenmIKHoJrwLWxxT9MsS28HLwWo2ac0qVA79UlKkY13hHGWPyRQJAF9LkRB4QJTiK7R7+dU522d/BII6u26esqpZ216rEuSY7pyoc588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511258; c=relaxed/simple;
	bh=4hWx9I/e0gfmo1lWoA6k/8xPvcp245+uN3ZYgZmHiK0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y0tSoJeNhHNXsqMr9d90+9S2kmzPPUtHh9AexPMjvBMIawtGV3rm/GdL8wKohqOPXk1PxtTL2bFjN47nSZ7UIOQRy9Ss7+dwmBV5y/r5w8CTN3QPPvizRZEyocKeNbO/zDCV8vJ2E0tXEMAIAOBOuMQps79bWBCCvukQx/+XbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yowTLxxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CECFC4CEEB;
	Mon, 18 Aug 2025 10:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755511257;
	bh=4hWx9I/e0gfmo1lWoA6k/8xPvcp245+uN3ZYgZmHiK0=;
	h=Subject:To:Cc:From:Date:From;
	b=yowTLxxR9TbtGujfMkaUs5L2ihV0vGXDl8ESi88pDP5bc7NkbI1L+FGqq/Z1HdyQy
	 uX3WWTT2oETEjvG8Igxkq5mJiHLSKVxY6gnw51EFuZJDdLvobBctn0yz5ASq9dZIRE
	 evrehI7xnzdp+OP3G+ZKEjgo+j+TmA+Na8VY2PfA=
Subject: FAILED: patch "[PATCH] serial: 8250: fix panic due to PSLVERR" failed to apply to 6.12-stable tree
To: cuiyunhui@bytedance.com,gregkh@linuxfoundation.org,john.ogness@linutronix.de,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:00:46 +0200
Message-ID: <2025081846-vanquish-fastball-b7d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7f8fdd4dbffc05982b96caf586f77a014b2a9353
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081846-vanquish-fastball-b7d1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f8fdd4dbffc05982b96caf586f77a014b2a9353 Mon Sep 17 00:00:00 2001
From: Yunhui Cui <cuiyunhui@bytedance.com>
Date: Wed, 23 Jul 2025 10:33:22 +0800
Subject: [PATCH] serial: 8250: fix panic due to PSLVERR

When the PSLVERR_RESP_EN parameter is set to 1, the device generates
an error response if an attempt is made to read an empty RBR (Receive
Buffer Register) while the FIFO is enabled.

In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
Execution proceeds to the serial_port_in(port, UART_RX).
This satisfies the PSLVERR trigger condition.

When another CPU (e.g., using printk()) is accessing the UART (UART
is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
(lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
dw8250_force_idle().

Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
to fix this issue.

Panic backtrace:
[    0.442336] Oops - unknown exception [#1]
[    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
[    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
...
[    0.442416] console_on_rootfs+0x26/0x70

Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20250723023322.464-2-cuiyunhui@bytedance.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7eddcab318b4..2da9db960d09 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2269,9 +2269,9 @@ static void serial8250_initialize(struct uart_port *port)
 {
 	unsigned long flags;
 
+	uart_port_lock_irqsave(port, &flags);
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
-	uart_port_lock_irqsave(port, &flags);
 	serial8250_init_mctrl(port);
 	serial8250_iir_txen_test(port);
 	uart_port_unlock_irqrestore(port, flags);


