Return-Path: <stable+bounces-146027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCBCAC0413
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 07:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8899D1BA037A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 05:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDFD198A1A;
	Thu, 22 May 2025 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrQ1of7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FAEC5;
	Thu, 22 May 2025 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747892319; cv=none; b=Z1lRylQwJwopsl2v/YvWxtILoQ0YGbRQ/tfMxAcXrCb0CT5U8n7mVEKc3Ik3k0ZPqA8UGx1be4q/LiUNv4B965N328yk/X2syyeLQg1F81PDKI6QvyZEiybtW57O2rzqwGDCWvHSDM4put8ChHUP5bP6rx29EKFK3MijQG3kO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747892319; c=relaxed/simple;
	bh=481ZVxxTo5dXKCVkxl2xr5q+32AF7hLX13yJEq0GEZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhIbPuwJpaBnTPhCACDw4zCdcBxN54Af4XzUTodvFsA0DEziPIXWPFX/ayF6cAFiEcIQH7jt90FS3N0JqO04FDvjA6b/XIukLSqC38RQrcUGSgDjxgRnTV70T4/kt5QntT3hINETyoR591eRTNKsDypDoA3CuYFHzm67pU+/C6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrQ1of7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95945C4CEE4;
	Thu, 22 May 2025 05:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747892319;
	bh=481ZVxxTo5dXKCVkxl2xr5q+32AF7hLX13yJEq0GEZE=;
	h=From:To:Cc:Subject:Date:From;
	b=RrQ1of7oY9ZI7DFvM19xgamNmeIcPQi6nki9ee6Yti6ux55zj6LgVUGvQQEQuruGh
	 mF0/d4DQuSN5urwy0wgxQpw15ijB4G+NVKKNYvTIlIcB8K0BIyAbXI4TkUW89YIsfO
	 17U886zK5xC4y46r8HlHbAA6kkGe8hBntPJmbto8fulWTyojxLxskvMt7rDjkI8h/8
	 JW0GiXT78jgXLYPtVHGBDv5/rWJ8xoUL24PhlPRhW2gmOek9+yNNfurT5W2LmwSw9d
	 IVK7mrGrW7SQPv//HzDm3z9uL+rCVD3fJ6+7cLoCdcLxGmEu+lwhMnXmP8Q6p+Nj+d
	 nd3mLr2oXTUzA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Mans Rullgard <mans@mansr.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] tty: serial: 8250_omap: fix TX with DMA for am33xx
Date: Thu, 22 May 2025 07:38:35 +0200
Message-ID: <20250522053835.3495975-1-jirislaby@kernel.org>
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

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Link: https://lore.kernel.org/all/20250506150748.3162-1-mans@mansr.com/
Reported-by: Mans Rullgard <mans@mansr.com>
Cc: stable@vger.kernel.org

---
[v2] S-O-B added
---
 drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 2a0ce11f405d..72ae08d6204f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1173,16 +1173,6 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
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
@@ -1207,18 +1197,22 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
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
@@ -1228,6 +1222,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 		goto err;
 	}
 
+	dma->tx_size = sg_dma_len(&sg);
 	dma->tx_running = 1;
 
 	desc->callback = omap_8250_dma_tx_complete;
-- 
2.49.0


