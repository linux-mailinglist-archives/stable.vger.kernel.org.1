Return-Path: <stable+bounces-144330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC03BAB63FE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 09:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47644168752
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FDC2063F3;
	Wed, 14 May 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFM3h+X/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6220468E;
	Wed, 14 May 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747207240; cv=none; b=DWn68eZSfMyjLGeM2nCdK/vf/hgDLVFUKuTsMu5tsK0g81TQClKaJUBjID/2hN57HFoLLEMHuCNPZ8R7ajsky3S837jWOWH8sjJ2we8fiFJrNIukxt0xn+tvnWtLrqB2esb1a0s+Tgc0hDtjMmGlrcrrRBr95RxGFCoJqAnZ6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747207240; c=relaxed/simple;
	bh=YhVPnz7x2+6fbhYqBsQFdZJpHMREgWV1ZUsd3Ba4Ci4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C18mQ8xQmVqPuzPVq/2CSzWmKQkX7GbJ6MLH8AT3jKC5SVseN40N/5JGR/wnNqXWbNem+V31Rx1lPIY1W9cR8Y3NS+qTnkBs8+9c16FnaqrjnN/gFiuRD22oNaHjW4dcdWFvVSFZwkmH9yUAYXRoGb5sz+dNxUFlvyMY8SAfuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFM3h+X/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D74C4CEF0;
	Wed, 14 May 2025 07:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747207238;
	bh=YhVPnz7x2+6fbhYqBsQFdZJpHMREgWV1ZUsd3Ba4Ci4=;
	h=From:To:Cc:Subject:Date:From;
	b=rFM3h+X/5dUH6f0ex5ygM/hRowk8UY8U5w32F9VXaadtNfPbOkowHV8SglQnI92EL
	 8uzBNifdN/aeKkTnNVmxU6X03JpRNG7qCwICH0ShTTAQ6BufwsU99cwiuYLSqvLoJs
	 A116VZsYBntcMtBwGA8LV8zLQ0Q1dX59iTD/0XfdfbXEXeQil3WSLRsvahxLdLoD7i
	 ItNWXWdEMdVqQ+wYKLjO/Pe4e/MpRUky+kVScWQiJ0Ow6Wia/SAUBaX5ZwhnPLfuLy
	 8VStqq+I5I7AHN5MvGeyIR5OoXCeiJeSBinZR+WRyzgqLhaw7/9/vZX6nl6LGEXiII
	 fFgNAMfSptfLg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Mans Rullgard <mans@mansr.com>,
	stable@vger.kernel.org
Subject: [PATCH] tty: serial: 8250_omap: fix TX with DMA for am33xx
Date: Wed, 14 May 2025 09:20:35 +0200
Message-ID: <20250514072035.2757435-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
introduced an error in the TX DMA handling for 8250_omap.

When the OMAP_DMA_TX_KICK flag is set, the "skip_byte" is pulled from
the kfifo and emitted directly in order to start the DMA. While the
kfifo is updated, dma->tx_size is not decreased. This leads to
uart_xmit_advance() called in omap_8250_dma_tx_complete() advancing the
kfifo by one too much.

In practice, transmitting N bytes has been seen to result in the last
N-1 bytes being sent repeatedly.

This change fixes the problem by moving all of the dma setup after the
OMAP_DMA_TX_KICK handling and using kfifo_len() instead of the DMA size
for the 4-byte cutoff check. This slightly changes the behaviour at
buffer wraparound, but it still transmits the correct bytes somehow.

Now, the "skip_byte" would no longer be accounted to the stats. As
previously, dma->tx_size included also this skip byte, up->icount.tx was
updated by aforementioned uart_xmit_advance() in
omap_8250_dma_tx_complete(). Fix this by using the uart_fifo_out()
helper instead of bare kfifo_get().

Based on patch by Mans Rullgard <mans@mansr.com>

Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Reported-by: Mans Rullgard <mans@mansr.com>
Cc: stable@vger.kernel.org

---
The same as for the original patch, I would appreaciate if someone
actually tests this one on a real HW too.

A patch to optimize the driver to use 2 sgls is still welcome. I will
not add it without actually having the HW.
---
 drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index c9b1c689a045..bb23afdd63f2 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1151,16 +1151,6 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 		return 0;
 	}
 
-	sg_init_table(&sg, 1);
-	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
-					   UART_XMIT_SIZE, dma->tx_addr);
-	if (ret != 1) {
-		serial8250_clear_THRI(p);
-		return 0;
-	}
-
-	dma->tx_size = sg_dma_len(&sg);
-
 	if (priv->habit & OMAP_DMA_TX_KICK) {
 		unsigned char c;
 		u8 tx_lvl;
@@ -1185,18 +1175,22 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 			ret = -EBUSY;
 			goto err;
 		}
-		if (dma->tx_size < 4) {
+		if (kfifo_len(&tport->xmit_fifo) < 4) {
 			ret = -EINVAL;
 			goto err;
 		}
-		if (!kfifo_get(&tport->xmit_fifo, &c)) {
+		if (!uart_fifo_out(&p->port, &c, 1)) {
 			ret = -EINVAL;
 			goto err;
 		}
 		skip_byte = c;
-		/* now we need to recompute due to kfifo_get */
-		kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
-				UART_XMIT_SIZE, dma->tx_addr);
+	}
+
+	sg_init_table(&sg, 1);
+	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1, UART_XMIT_SIZE, dma->tx_addr);
+	if (ret != 1) {
+		ret = -EINVAL;
+		goto err;
 	}
 
 	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1, DMA_MEM_TO_DEV,
@@ -1206,6 +1200,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 		goto err;
 	}
 
+	dma->tx_size = sg_dma_len(&sg);
 	dma->tx_running = 1;
 
 	desc->callback = omap_8250_dma_tx_complete;
-- 
2.49.0


