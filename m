Return-Path: <stable+bounces-205636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BAACFA493
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA9C342CF33
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1492F659C;
	Tue,  6 Jan 2026 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="daSZBtie"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF582F6918;
	Tue,  6 Jan 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721350; cv=none; b=rwWTxlFNrUB8bQ/WHnLtGxsmukEnNu6gZYbED+BKsfVHu4e/imOG4l6FucMrAMc0ScrMjAIqu466ThoeH+mmhVCiOhv9Mp9AExTSYw60FcS2gLq/s/XWjATt8jSeaRdW8g6x+LVEkepoKNG/5XNXdy8tRMIv9HJo1puQcPA5CvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721350; c=relaxed/simple;
	bh=WkeOKlQbY4IZ0R9XxPqs9ui4YACUgKCuhNe0NSsjdiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLWWTHYxpBGC3KI3oyuWL1914vgEaqNm+80a+Qz6CLePsUIpcu21bg42KDrTTeIyygLUAe953WPBDA5/rZtCFHaL3cyuu1DVf2E8qv8a5MvGgBJCckGWiuPnrZlynPbRiyCutYo1N1TWNYk77RMf9MVSCrk9/2G7ydNdGNGpzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=daSZBtie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C14C19423;
	Tue,  6 Jan 2026 17:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721350;
	bh=WkeOKlQbY4IZ0R9XxPqs9ui4YACUgKCuhNe0NSsjdiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daSZBtiexNr7Eez3nygIZWUFmk15qbKnZ1ZlH2K+2kDfAARgCBb+AAynxqtypxGt1
	 KdF4Pm8RHeVHdwEsDwXUNgQ/aBj5zExYh/40/feqX54ACgw7WDL2osp73+vrka9MNj
	 B/3wpguqyJ+YOEJci1zFojkxA1hAtjEnk+ANiUc4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 510/567] serial: xilinx_uartps: Use helper function hrtimer_update_function()
Date: Tue,  6 Jan 2026 18:04:52 +0100
Message-ID: <20260106170510.242569225@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/xilinx_uartps.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -454,7 +454,7 @@ static void cdns_uart_handle_tx(void *de
 
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
 	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
-		cdns_uart->tx_timer.function = &cdns_rs485_rx_callback;
+		hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
 		hrtimer_start(&cdns_uart->tx_timer,
 			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
 	}
@@ -734,7 +734,7 @@ static void cdns_uart_start_tx(struct ua
 
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
 		if (!cdns_uart->rs485_tx_started) {
-			cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
+			hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_tx_callback);
 			cdns_rs485_tx_setup(cdns_uart);
 			return hrtimer_start(&cdns_uart->tx_timer,
 					     ms_to_ktime(port->rs485.delay_rts_before_send),



