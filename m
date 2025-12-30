Return-Path: <stable+bounces-204236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A42ECEA1CD
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 961C2302411C
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A012C15AA;
	Tue, 30 Dec 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyUovBd/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95086277
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110159; cv=none; b=ad/rEWajcvo+FQ6Q17B38SJmb/CbaK3sTf/AB+htaupQN1PSMYX3siV5qwjBLyGrL5gwMJuI9rW+SNP33d3pRO5CNU+Rf39u3w27eOM0umapaZdzGRmWWKnMj6MDysVWkNiSG5JHYRcshwnOUDmiZYUM/lqMlwr41lfMviNP5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110159; c=relaxed/simple;
	bh=SexZO5PIYOOUIObfP9m/7gGDmLboxpzuNREUwzWp8ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzMaWZblV8nHMcdsZaG5h+NNV1qqX4s1V+KzBtVYoUosSxhD0LSNAHe8me9liTl7WGDzQ7O59DZhnzNBTqEcV41xM7mdajKIfRAkrsTM2Fdjqtj6+JOfAzbuCZNzkHPAxM8qxH2zikSckmNiVOCqag2uhMatM2hBz5N04tf//gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyUovBd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA59CC116C6;
	Tue, 30 Dec 2025 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767110159;
	bh=SexZO5PIYOOUIObfP9m/7gGDmLboxpzuNREUwzWp8ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyUovBd/ms0EjYx+Bn9JXFEHPJSptXrrXwqMrqrAuoN9D6MLTuE3pp19pXDAp7nBI
	 uQhWlYR9gbqsEr/u5E3Kn+VS2r3gswqojpq0bzumRuW9rzUbkjob3ctOO/6doXyR/1
	 /WJnIOpZO3BhJCiuNekG9UgALN6I5wWIUbWqXoXHbEfQEuxfEnD5hPcTvwQlxm0kSL
	 Rs+2vmTDbe0vi+HSgQV3c+QP0KFCvQZIQyu2U4wy7UmpK74oXiNfc/n3px/UAssYbF
	 xLM4WMIZiv4KE5N7Hp0tnKd825bn7ZMSPubcyR156HRDd554vC5wiX7/DKsC0Lv1Xb
	 UycNVNpRP6KBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] serial: xilinx_uartps: Use helper function hrtimer_update_function()
Date: Tue, 30 Dec 2025 10:55:55 -0500
Message-ID: <20251230155556.2289800-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230155556.2289800-1-sashal@kernel.org>
References: <2025122923-amaretto-output-f3dc@gregkh>
 <20251230155556.2289800-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nam Cao <namcao@linutronix.de>

[ Upstream commit eee00df8e1f1f5648ed8f9e40e2bb54c2877344a ]

The field 'function' of struct hrtimer should not be changed directly, as
the write is lockless and a concurrent timer expiry might end up using the
wrong function pointer.

Switch to use hrtimer_update_function() which also performs runtime checks
that it is safe to modify the callback.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/af7823518fb060c6c97105a2513cfc61adbdf38f.1738746927.git.namcao@linutronix.de
Stable-dep-of: 267ee93c417e ("serial: xilinx_uartps: fix rs485 delay_rts_after_send")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 1d636578c1ef..1d4646c40855 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -454,7 +454,7 @@ static void cdns_uart_handle_tx(void *dev_id)
 
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
 	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
-		cdns_uart->tx_timer.function = &cdns_rs485_rx_callback;
+		hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
 		hrtimer_start(&cdns_uart->tx_timer,
 			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
 	}
@@ -734,7 +734,7 @@ static void cdns_uart_start_tx(struct uart_port *port)
 
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
 		if (!cdns_uart->rs485_tx_started) {
-			cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
+			hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_tx_callback);
 			cdns_rs485_tx_setup(cdns_uart);
 			return hrtimer_start(&cdns_uart->tx_timer,
 					     ms_to_ktime(port->rs485.delay_rts_before_send),
-- 
2.51.0


