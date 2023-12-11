Return-Path: <stable+bounces-6209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D680D967
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09001C216FC
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7164D51C44;
	Mon, 11 Dec 2023 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ji8elG09"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF251C38;
	Mon, 11 Dec 2023 18:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA443C433C8;
	Mon, 11 Dec 2023 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320806;
	bh=IZgKXJL3yZuBbw3/jRxfyuLdk37hfC13rp7EGB1IQ1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ji8elG09dWX+qh9iChtYjTZW7mp91cNKQVIIBIReS8VAZ5f6Kn0V4UdZxnDoOHbpl
	 u/fpg1ipanoapbc0oFl4GAuspcLah/nxc8/bzaJTVYuxyQzuj/NnrvZcFo0AIZRzpw
	 24dPFd4p55bbmtsj3pCzE7m6cmtKgwHKc8AU8MH8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 6.1 175/194] serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit
Date: Mon, 11 Dec 2023 19:22:45 +0100
Message-ID: <20231211182044.476592351@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronald Wahl <ronald.wahl@raritan.com>

commit 8973ab7a2441b286218f4a5c4c33680e2f139996 upstream.

This fixes commit 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX
interrupt after DMA enable") which unfortunately set the
UART_HAS_RHR_IT_DIS bit in the UART_OMAP_IER2 register and never
cleared it.

Cc: stable@vger.kernel.org
Fixes: 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX interrupt after DMA enable")
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Link: https://lore.kernel.org/r/20231031110909.11695-1-rwahl@gmx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_omap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -825,7 +825,7 @@ static void __dma_rx_do_complete(struct
 	if (priv->habit & UART_HAS_RHR_IT_DIS) {
 		reg = serial_in(p, UART_OMAP_IER2);
 		reg &= ~UART_OMAP_IER2_RHR_IT_DIS;
-		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
+		serial_out(p, UART_OMAP_IER2, reg);
 	}
 
 	dmaengine_tx_status(rxchan, cookie, &state);
@@ -967,7 +967,7 @@ static int omap_8250_rx_dma(struct uart_
 	if (priv->habit & UART_HAS_RHR_IT_DIS) {
 		reg = serial_in(p, UART_OMAP_IER2);
 		reg |= UART_OMAP_IER2_RHR_IT_DIS;
-		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
+		serial_out(p, UART_OMAP_IER2, reg);
 	}
 
 	dma_async_issue_pending(dma->rxchan);



