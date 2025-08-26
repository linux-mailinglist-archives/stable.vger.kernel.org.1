Return-Path: <stable+bounces-176255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6B3B36CA5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BED585D11
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34043570A7;
	Tue, 26 Aug 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sRmNUm8M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D342350855;
	Tue, 26 Aug 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219180; cv=none; b=PMz5GRUFbts7B8oUkmSS5MBlVINDuui/qIgy7fyRrNCKHuKm2R4dei1drEnQRxv1akkp7POmJeJJXrCjf0dJmFDrSWPaDBzOYsBE7RD6fsDJdsI4XtLZ4F+hj6iSUavYC4Fwfnf4B55dnP8tE0QGA9WiXuQLLLVYZC9jVZV3y/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219180; c=relaxed/simple;
	bh=unl/ms9Yi/3355658KJlJTYUvOdTKzYhQWcoyaDUiZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X31DKTMNJVq1atDRPGTzBuVmuhei1OATuZQLoi3YZKlINQbtRMx1vU3CQo9BpkhjSTkCNjCXQLj03ulbcDGhTeYsIpOuXdZ6iIAmqT81+J3Wm8psDR7wOBLX2jk99inBMSck0q0OjEeXP7D3fQPito5aFVwFxqv27isFjY6Lnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sRmNUm8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6CDC4CEF1;
	Tue, 26 Aug 2025 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219180;
	bh=unl/ms9Yi/3355658KJlJTYUvOdTKzYhQWcoyaDUiZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sRmNUm8Mz6C/+b9TMGCxgHMZ1a4F8jObzDDEA7xmxkW7UGbVlipxND8MZCrU8SBSp
	 1fKNt+3rR4sdja5gbhbZqNLDkgaDbmQP+2G5SPP8z4MoHRhXISNKMYryFeROX+Q/Ch
	 JRDiY/1v1u0P14Sg0kBoFw5pkwK5eA2y4VRCPZEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	John Ogness <john.ogness@linutronix.de>,
	stable <stable@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 282/403] serial: 8250: fix panic due to PSLVERR
Date: Tue, 26 Aug 2025 13:10:08 +0200
Message-ID: <20250826110914.595070414@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunhui Cui <cuiyunhui@bytedance.com>

commit 7f8fdd4dbffc05982b96caf586f77a014b2a9353 upstream.

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
[ Applied fix to serial8250_do_startup() instead of serial8250_initialize() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_port.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2296,9 +2296,8 @@ int serial8250_do_startup(struct uart_po
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
-
 	spin_lock_irqsave(&port->lock, flags);
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;



