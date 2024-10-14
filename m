Return-Path: <stable+bounces-83997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8137699CD9D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068281F21600
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3E1AB517;
	Mon, 14 Oct 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0PoawDhn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C51A76AC;
	Mon, 14 Oct 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916452; cv=none; b=iIv2dvR4/Eo07V2LQJdbY9Bjsnztg0T44a9vlQafK8j5TdNtNH2D1DSQnFtFcyw7IlEHR01NKPQTBduoLrfIZY9riFqM01w1e8CPzeDL/6kV9no5MJDjCVzycXLrTEf/ykmwCrdY9XRH1iB2S/MFhUOyEUmDLloio2Uc1uzpogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916452; c=relaxed/simple;
	bh=K5P0aLlg02oXiyW3uS/nobHsS9DtkHaBPbetZ7Vc8OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoa7aF8SQWvNNq11H7c/8rTxjAbGAbUCkUl1rRbTnnDx2I6jjRakQiwkP+eRZNP/kxMBKRYgflI65zO/eLedQP/YsEcCdWF2f8ULimv2msv4VhuCj/t34AtnDIngDxPdoLubRTHfJtnlcD5G7X1YezjPHVrvkRyJzbDp3AUEwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0PoawDhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9738EC4CEC3;
	Mon, 14 Oct 2024 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916452;
	bh=K5P0aLlg02oXiyW3uS/nobHsS9DtkHaBPbetZ7Vc8OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0PoawDhnQk63bqmILHnnNKx6P6UtKfWOWwtYmcb78HIrX0RWNPcWOuX9YpE7ycqLo
	 JHPKSPd2TtnMy+qgPK/+w7yMCxrv1VuCU45qFfdwxIxt6WqMkclabCKZ49FFaz2sQh
	 3uE1TYmGn+77GaxzT98iOl67nbxUeHcMFWDI0BII=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charlie <g4sra@protonmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.11 187/214] Revert "mmc: mvsdio: Use sg_miter for PIO"
Date: Mon, 14 Oct 2024 16:20:50 +0200
Message-ID: <20241014141052.276410344@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 5b35746a0fdc73063a4c7fc6208b7abd644f9ef5 upstream.

This reverts commit 2761822c00e8c271f10a10affdbd4917d900d7ea.

When testing on real hardware the patch does not work.
Revert, try to acquire real hardware, and retry.
These systems typically don't have highmem anyway so the
impact is likely zero.

Cc: stable@vger.kernel.org
Reported-by: Charlie <g4sra@protonmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20240927-kirkwood-mmc-regression-v1-1-2e55bbbb7b19@linaro.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/mvsdio.c | 71 ++++++++++-----------------------------
 1 file changed, 18 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index af7f21888e27..ca01b7d204ba 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -38,9 +38,8 @@ struct mvsd_host {
 	unsigned int xfer_mode;
 	unsigned int intr_en;
 	unsigned int ctrl;
-	bool use_pio;
-	struct sg_mapping_iter sg_miter;
 	unsigned int pio_size;
+	void *pio_ptr;
 	unsigned int sg_frags;
 	unsigned int ns_per_clk;
 	unsigned int clock;
@@ -115,18 +114,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 		 * data when the buffer is not aligned on a 64 byte
 		 * boundary.
 		 */
-		unsigned int miter_flags = SG_MITER_ATOMIC; /* Used from IRQ */
-
-		if (data->flags & MMC_DATA_READ)
-			miter_flags |= SG_MITER_TO_SG;
-		else
-			miter_flags |= SG_MITER_FROM_SG;
-
 		host->pio_size = data->blocks * data->blksz;
-		sg_miter_start(&host->sg_miter, data->sg, data->sg_len, miter_flags);
+		host->pio_ptr = sg_virt(data->sg);
 		if (!nodma)
-			dev_dbg(host->dev, "fallback to PIO for data\n");
-		host->use_pio = true;
+			dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
+				host->pio_ptr, host->pio_size);
 		return 1;
 	} else {
 		dma_addr_t phys_addr;
@@ -137,7 +129,6 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 		phys_addr = sg_dma_address(data->sg);
 		mvsd_write(MVSD_SYS_ADDR_LOW, (u32)phys_addr & 0xffff);
 		mvsd_write(MVSD_SYS_ADDR_HI,  (u32)phys_addr >> 16);
-		host->use_pio = false;
 		return 0;
 	}
 }
@@ -297,8 +288,8 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 {
 	void __iomem *iobase = host->base;
 
-	if (host->use_pio) {
-		sg_miter_stop(&host->sg_miter);
+	if (host->pio_ptr) {
+		host->pio_ptr = NULL;
 		host->pio_size = 0;
 	} else {
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
@@ -353,12 +344,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 static irqreturn_t mvsd_irq(int irq, void *dev)
 {
 	struct mvsd_host *host = dev;
-	struct sg_mapping_iter *sgm = &host->sg_miter;
 	void __iomem *iobase = host->base;
 	u32 intr_status, intr_done_mask;
 	int irq_handled = 0;
-	u16 *p;
-	int s;
 
 	intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 	dev_dbg(host->dev, "intr 0x%04x intr_en 0x%04x hw_state 0x%04x\n",
@@ -382,36 +370,15 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 	spin_lock(&host->lock);
 
 	/* PIO handling, if needed. Messy business... */
-	if (host->use_pio) {
-		/*
-		 * As we set sgm->consumed this always gives a valid buffer
-		 * position.
-		 */
-		if (!sg_miter_next(sgm)) {
-			/* This should not happen */
-			dev_err(host->dev, "ran out of scatter segments\n");
-			spin_unlock(&host->lock);
-			host->intr_en &=
-				~(MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W |
-				  MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W);
-			mvsd_write(MVSD_NOR_INTR_EN, host->intr_en);
-			return IRQ_HANDLED;
-		}
-		p = sgm->addr;
-		s = sgm->length;
-		if (s > host->pio_size)
-			s = host->pio_size;
-	}
-
-	if (host->use_pio &&
+	if (host->pio_size &&
 	    (intr_status & host->intr_en &
 	     (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
-
+		u16 *p = host->pio_ptr;
+		int s = host->pio_size;
 		while (s >= 32 && (intr_status & MVSD_NOR_RX_FIFO_8W)) {
 			readsw(iobase + MVSD_FIFO, p, 16);
 			p += 16;
 			s -= 32;
-			sgm->consumed += 32;
 			intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 		}
 		/*
@@ -424,7 +391,6 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 				put_unaligned(mvsd_read(MVSD_FIFO), p++);
 				put_unaligned(mvsd_read(MVSD_FIFO), p++);
 				s -= 4;
-				sgm->consumed += 4;
 				intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 			}
 			if (s && s < 4 && (intr_status & MVSD_NOR_RX_READY)) {
@@ -432,13 +398,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 				val[0] = mvsd_read(MVSD_FIFO);
 				val[1] = mvsd_read(MVSD_FIFO);
 				memcpy(p, ((void *)&val) + 4 - s, s);
-				sgm->consumed += s;
 				s = 0;
 				intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 			}
-			/* PIO transfer done */
-			host->pio_size -= sgm->consumed;
-			if (host->pio_size == 0) {
+			if (s == 0) {
 				host->intr_en &=
 				     ~(MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W);
 				mvsd_write(MVSD_NOR_INTR_EN, host->intr_en);
@@ -450,10 +413,14 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
+		host->pio_ptr = p;
+		host->pio_size = s;
 		irq_handled = 1;
-	} else if (host->use_pio &&
+	} else if (host->pio_size &&
 		   (intr_status & host->intr_en &
 		    (MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W))) {
+		u16 *p = host->pio_ptr;
+		int s = host->pio_size;
 		/*
 		 * The TX_FIFO_8W bit is unreliable. When set, bursting
 		 * 16 halfwords all at once in the FIFO drops data. Actually
@@ -464,7 +431,6 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 			mvsd_write(MVSD_FIFO, get_unaligned(p++));
 			mvsd_write(MVSD_FIFO, get_unaligned(p++));
 			s -= 4;
-			sgm->consumed += 4;
 			intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 		}
 		if (s < 4) {
@@ -473,13 +439,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 				memcpy(((void *)&val) + 4 - s, p, s);
 				mvsd_write(MVSD_FIFO, val[0]);
 				mvsd_write(MVSD_FIFO, val[1]);
-				sgm->consumed += s;
 				s = 0;
 				intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 			}
-			/* PIO transfer done */
-			host->pio_size -= sgm->consumed;
-			if (host->pio_size == 0) {
+			if (s == 0) {
 				host->intr_en &=
 				     ~(MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W);
 				mvsd_write(MVSD_NOR_INTR_EN, host->intr_en);
@@ -487,6 +450,8 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
+		host->pio_ptr = p;
+		host->pio_size = s;
 		irq_handled = 1;
 	}
 
-- 
2.47.0




