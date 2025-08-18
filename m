Return-Path: <stable+bounces-169964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D66B29EB6
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF003A332E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570AE310656;
	Mon, 18 Aug 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XjFg0cQs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710031064B
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511267; cv=none; b=i2fb/nffdNNWROlT9glMS6pfl9i7te8gcULXpwXte8EL5y11CR6OZwVLvJ4XJD0DEwaQor0/Ll7xl+mDglbzpuPRbgMPk/LXXjEGwU1tccB+HlzCyS6W3b+4+PhEc922SRVohqIV+ERyIU4minBSDleNKjthe8gNzUKhgLxKY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511267; c=relaxed/simple;
	bh=bRc5SMHz2pFxhg81TOYBH2noxb7tNZHOobcOvNdCv3w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dxdO8Yw0ifkM9J/VD1D2uI1WDAY2ro+SlHlP32/R8WqQWo8GXs8Im69z95ht9JU1ve++mHcmXy0p3xwlxiaqganBpEOLTa7wbUqmd/V7TfqqMnAm+SpHwznTzTolmBSj5xwK46XCiw0pF+T3jjzxw+8meZ37Vj7mz1TTkzNfVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XjFg0cQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABEAC4CEEB;
	Mon, 18 Aug 2025 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755511265;
	bh=bRc5SMHz2pFxhg81TOYBH2noxb7tNZHOobcOvNdCv3w=;
	h=Subject:To:Cc:From:Date:From;
	b=XjFg0cQs+6W9KJvmZGqa7wnowWdfR0S4t6XlGP52dWXoXXFp3odhOzlD/MSvDm9Jc
	 Id0HMkyGa3VuWFUQ0lwjkYw/cqUyAXuZ8ro1S9VcF1b2Y+5KkSPoEfTA55CPSXO1CS
	 Fm4vgRCW9sUImPJI2vrs6rrikKsOOD/+hOStNlZk=
Subject: FAILED: patch "[PATCH] serial: 8250: fix panic due to PSLVERR" failed to apply to 5.15-stable tree
To: cuiyunhui@bytedance.com,gregkh@linuxfoundation.org,john.ogness@linutronix.de,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:00:48 +0200
Message-ID: <2025081848-charter-handcart-4eda@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7f8fdd4dbffc05982b96caf586f77a014b2a9353
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081848-charter-handcart-4eda@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


