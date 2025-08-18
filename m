Return-Path: <stable+bounces-169961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D02EB29EAE
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E91963402
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC02310644;
	Mon, 18 Aug 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EDhWZjdQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEFB3101CC
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511255; cv=none; b=bMf+fAJXt4aKf2fG+E2j8gvg44bVHzVDNp07fujD05W3w3LoBsM/I0l2l+eTVSz4lY5FcxbjrCa5CIY6sQy/MrXg7hHGe+Eqb04C5a1ycJDAgaEfYlt/BlXmWFhGCUcHbeDInmKC4hc57Do8qaO9hd/6Pt+F9BiG+4UCTxLQbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511255; c=relaxed/simple;
	bh=l/mNlcuKBDAMVvywxTmTZZgbN4uMK8xwUVGODvB36oU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iGDC63TkhBHwwMaf7L26IuU6TKatu/ctpVJlUzvbf7bKfjlmRzyZ3kAa3SZ6SJR+PONpMNZe0tpp5e2+PNaCUuXKHondFMenG5qIPI5lZVJF65Ku3syt9YxZWLqVRNMP4lJGy3I3QkXQLcstUd9CBmtPm99ASxFKRv6qQqUjykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EDhWZjdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18106C4CEEB;
	Mon, 18 Aug 2025 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755511254;
	bh=l/mNlcuKBDAMVvywxTmTZZgbN4uMK8xwUVGODvB36oU=;
	h=Subject:To:Cc:From:Date:From;
	b=EDhWZjdQOGZsB8rj23/Q4xUPE9IDrT/O+89bhJl1V58NH+UoOpoUjQjengYXqCuJ6
	 02Y5qQVynOIkUJTIu2V+kqbgRlODynrL+6rszP4gV40OdHEzvPULsLBF1sVrcyJHHy
	 u+VBdoi4XxOrFW1ZkLXIcJb3AUDYU3BaogsSfPuU=
Subject: FAILED: patch "[PATCH] serial: 8250: fix panic due to PSLVERR" failed to apply to 6.6-stable tree
To: cuiyunhui@bytedance.com,gregkh@linuxfoundation.org,john.ogness@linutronix.de,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:00:46 +0200
Message-ID: <2025081846-exquisite-previous-f76e@gregkh>
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
git cherry-pick -x 7f8fdd4dbffc05982b96caf586f77a014b2a9353
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081846-exquisite-previous-f76e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


