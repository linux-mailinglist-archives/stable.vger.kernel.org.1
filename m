Return-Path: <stable+bounces-171664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B1B2B430
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B713B70E3
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70705FDA7;
	Mon, 18 Aug 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rpxk4KOV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4C41C63
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557168; cv=none; b=e/Dasi1mcLE54XdTEXdh79ylZ/O7yyfDyLywdeimFW4Ka/QwxOaYo8movMlt58Go7M8/Qls1hOuAYQTV4HP9cppU+p3ULiO0jmaqYWS46XNQ5xm+ddfi1/t97qzKj6IpX5J5zVdOys4uGNeocFWyLmo1nkEBmhw3fV3VEHKxTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557168; c=relaxed/simple;
	bh=YpCJMFuodpldlN43bcblMMwjjQbHgAuQrjtG0GvRNoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDcUtCPzsTZh/vFPpp/njWNNXmEuQuD0XguE4lKx7X3P/PtThtXACZwZx4XZx8UkxjVLLWqdVhJXa1lEO2vOAk6+Lt2ornTDx0PXWBzApaGz6eq8WARB4BNqV3SvXns8wmASk+zMdf6NnuzC3wDXb/lkjswMz6Sbp3FDzzko9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rpxk4KOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDC1C4CEEB;
	Mon, 18 Aug 2025 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755557168;
	bh=YpCJMFuodpldlN43bcblMMwjjQbHgAuQrjtG0GvRNoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rpxk4KOV4WVY3zevVFxiGKjdANGbjkVQvK7SHzJyLHXu9YK7AgVjKwZyWL8oy/5c7
	 QTbR9GwkCWmVqvzwXBVUb1CJ76l5MmAo+kaRKrHlwqTeDWQQPmAm2m8EfdK7HG7xGK
	 r3/bODIAi5ZYkQubnoshvct0WqPOXXNw27Qqsdtr7DFMthktCpIOgx3nJkRRLPsAL+
	 uEYgRl4gq77E5kKzIaIDC4muuy/7hEr7BO8bDP+wDQ/8Rgv5ovA7dJNDn29K9nwLfd
	 mcHyAkVs9HEGGxY1KKTOyIEGcSqrS6KwyHsjcFL0CZ6vrwZwiug+pVyFgTVkkZdEfC
	 8bPqfu+3uSrfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	John Ogness <john.ogness@linutronix.de>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] serial: 8250: fix panic due to PSLVERR
Date: Mon, 18 Aug 2025 18:46:05 -0400
Message-ID: <20250818224605.124262-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081849-trio-prepay-4247@gregkh>
References: <2025081849-trio-prepay-4247@gregkh>
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
index 6b3ff20a0656..010c6be83ae1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2296,9 +2296,8 @@ int serial8250_do_startup(struct uart_port *port)
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


