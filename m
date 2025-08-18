Return-Path: <stable+bounces-171648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0ADB2B1D9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 21:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6731D1B63E5C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA0223DD9;
	Mon, 18 Aug 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8hLF3+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E40786349
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546414; cv=none; b=X3pU1MaGiDkHaYyteuoqH+1AR2jxarlzeOVZbNUGGmqkB596srrciP7kTzb4ALPvvhJDoWbYtbJwCckP0xOYcX+ZlSxFzyeyzHWq4fsfCS/iiBcEBLTmlBhoIkiToKWat0qP1oGPcLQbfPm68tV2oVZIDmdLXmBufJWFSEt/QpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546414; c=relaxed/simple;
	bh=xK/jJG7ngut4zPJ7OqgODrD7nhhLaEgafTvEGdYVHKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9M/CmI0xtUNHWXBjdJArJVqvwGGlC19QT4bnJx02KECiG3DcfVTN0C9ElHXeI7K48vgkQGKWBUmwNBnm5Hkq/MEn0hB7kFIFPXhVDuP5kb/fHaSMbtZvTUmbsMG8B97L6cDdiN7gmle64BKdGJkmRP5ID6vySorbisJI3zNPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8hLF3+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74006C4CEEB;
	Mon, 18 Aug 2025 19:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755546414;
	bh=xK/jJG7ngut4zPJ7OqgODrD7nhhLaEgafTvEGdYVHKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8hLF3+2a5FxuI5ViD7CeiFT8PbOXgCbFQ0qBQbEIgdb+tBBgCjKufOdwSDSby+X1
	 fVS8Y6Y4woqHwaWwKZ+xGPJ9/xT+nNjXx3lJDppx0iNTGiWhPbWDzQ/JJmttQ3JUx/
	 8Mv1krPwUEOC3nj9+Irv7S/2kOp5X85zKlBbZxRpljYobIDX00kb+HGuCiMTU02tTe
	 uwpnNJxWMqs0jPLys5lcM0yMzlA2r0rEhVAutqF3d0i9WAEUqn/rN375YUjd0GCljy
	 OnkC/x/lEZcvbApX30+n+sdyEYVuBBl+U1uuU3CSaKnEubhnXZXWlBl4kvA4sz+IRC
	 i3frHzo6FVPGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	John Ogness <john.ogness@linutronix.de>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] serial: 8250: fix panic due to PSLVERR
Date: Mon, 18 Aug 2025 15:46:51 -0400
Message-ID: <20250818194651.56144-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081846-exquisite-previous-f76e@gregkh>
References: <2025081846-exquisite-previous-f76e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunhui Cui <cuiyunhui@bytedance.com>

[ Upstream commit 7f8fdd4dbffc05982b96caf586f77a014b2a9353 ]

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
[ Applied fix to serial8250_do_startup() instead of serial8250_initialize() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d5ad6cae6b65..23aed9e89e30 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2375,9 +2375,8 @@ int serial8250_do_startup(struct uart_port *port)
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
-- 
2.50.1


