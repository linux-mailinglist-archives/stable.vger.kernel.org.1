Return-Path: <stable+bounces-5922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0298980D7DC
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345A91C20970
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC6537E0;
	Mon, 11 Dec 2023 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P7y/2rwA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6EBFC06;
	Mon, 11 Dec 2023 18:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90177C433C8;
	Mon, 11 Dec 2023 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320027;
	bh=axGR5D+ytNInIND0jmNsuQuMjPG1cTo4KBKJuh3k7iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7y/2rwAYYR993Awum4wnlLfDuV3OB6cpbK9Ra+vcQ3nqmiaJXkYl2HM9NUbPgrH5
	 SNvRF81v9mAeLN5pF/5Cu726gokKw5SInmf9N6ilnr7O49ge+TwReDbyVcXv60CVOn
	 NkB40l9qG3aJL16ZTefv0SU8EfFFBWzluoG85m+4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 5.10 76/97] serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
Date: Mon, 11 Dec 2023 19:22:19 +0100
Message-ID: <20231211182023.049069373@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronald Wahl <ronald.wahl@raritan.com>

commit c6bb057418876cdfdd29a6f7b8cef54539ee8811 upstream.

Starting RX DMA on THRI interrupt is too early because TX may not have
finished yet.

This change is inspired by commit 90b8596ac460 ("serial: 8250: Prevent
starting up DMA Rx on THRI interrupt") and fixes DMA issues I had with
an AM62 SoC that is using the 8250 OMAP variant.

Cc: stable@vger.kernel.org
Fixes: c26389f998a8 ("serial: 8250: 8250_omap: Add DMA support for UARTs on K3 SoCs")
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Link: https://lore.kernel.org/r/20231101171431.16495-1-rwahl@gmx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_omap.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1209,10 +1209,12 @@ static int omap_8250_dma_handle_irq(stru
 
 	status = serial_port_in(port, UART_LSR);
 
-	if (priv->habit & UART_HAS_EFR2)
-		am654_8250_handle_rx_dma(up, iir, status);
-	else
-		status = omap_8250_handle_rx_dma(up, iir, status);
+	if ((iir & 0x3f) != UART_IIR_THRI) {
+		if (priv->habit & UART_HAS_EFR2)
+			am654_8250_handle_rx_dma(up, iir, status);
+		else
+			status = omap_8250_handle_rx_dma(up, iir, status);
+	}
 
 	serial8250_modem_status(up);
 	if (status & UART_LSR_THRE && up->dma->tx_err) {



