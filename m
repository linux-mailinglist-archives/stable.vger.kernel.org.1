Return-Path: <stable+bounces-163511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAECB0C026
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974BB3A2108
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD3828A1D5;
	Mon, 21 Jul 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gn2UKnUp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A928C036
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089847; cv=none; b=Lzfm+wIiax/g0Tln9PERihNlANBxTM9/6aQVY+G7iHUx5WTbl7EX0RKaojMQEBQ9Y/z6SqmPAJ4UWQxmfyxvQ10OfUMWCEw+/qs4YicSjA73f19LxtGIwBgfbA1oxWJYNAxRCR/Y5u2y2RHt2RUeIWBrGSdhULTsOcJrFKt05v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089847; c=relaxed/simple;
	bh=9ceQJuGYTZ68rzDOW9oVCV1s3ilEtx4Gln+N0SnLG6M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WsGt/mAu/Iib0gKNMwiO/XGfUfGR1+M/fifpaHYSW2y+E7Y0ALBbFHWfSeegCP6P1PngS6gZ3YdpaqQfqrA3cb/gSPdphaJZqTk28Vk/b6X6nCAcGXJoBpuJ9BhWXE3WB8d2ZIVIE+446W5Rq0YzT2sB9c92rnc0bNVjtVXaJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gn2UKnUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41218C4CEED;
	Mon, 21 Jul 2025 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753089847;
	bh=9ceQJuGYTZ68rzDOW9oVCV1s3ilEtx4Gln+N0SnLG6M=;
	h=Subject:To:Cc:From:Date:From;
	b=gn2UKnUp4VERE4X+8UEMQVz/YmjVnQGE8ikfUEfkgFyoaz4SSjhypFlcLmKasp98r
	 Lapkia14OCd0CzhZHKN2a0UoKUKBPpg/b1YfX+S/n1c04ZjqchuLKH1HA4gYRj2d9E
	 eg20isTLnPSZzknuugVzZUV8jtwpymXiqkegKD28=
Subject: FAILED: patch "[PATCH] i2c: stm32f7: unmap DMA mapped buffer" failed to apply to 6.6-stable tree
To: clement.legoffic@foss.st.com,alain.volmat@foss.st.com,andi.shyti@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:24:04 +0200
Message-ID: <2025072104-bacteria-resend-dcff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6aae87fe7f180cd93a74466cdb6cf2aa9bb28798
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072104-bacteria-resend-dcff@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6aae87fe7f180cd93a74466cdb6cf2aa9bb28798 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>
Date: Fri, 4 Jul 2025 10:39:15 +0200
Subject: [PATCH] i2c: stm32f7: unmap DMA mapped buffer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Before each I2C transfer using DMA, the I2C buffer is DMA'pped to make
sure the memory buffer is DMA'able. This is handle in the function
`stm32_i2c_prep_dma_xfer()`.
If the transfer fails for any reason the I2C buffer must be unmap.
Use the dma_callback to factorize the code and fix this issue.

Note that the `stm32f7_i2c_dma_callback()` is now called in case of DMA
transfer success and error and that the `complete()` on the dma_complete
completion structure is done inconditionnally in case of transfer
success or error as well as the `dmaengine_terminate_async()`.
This is allowed as a `complete()` in case transfer error has no effect
as well as a `dmaengine_terminate_async()` on a transfer success.

Also fix the unneeded cast and remove not more needed variables.

Fixes: 7ecc8cfde553 ("i2c: i2c-stm32f7: Add DMA support")
Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Cc: <stable@vger.kernel.org> # v4.18+
Acked-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20250704-i2c-upstream-v4-2-84a095a2c728@foss.st.com

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 817d081460c2..73a7b8894c0d 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -739,10 +739,11 @@ static void stm32f7_i2c_disable_dma_req(struct stm32f7_i2c_dev *i2c_dev)
 
 static void stm32f7_i2c_dma_callback(void *arg)
 {
-	struct stm32f7_i2c_dev *i2c_dev = (struct stm32f7_i2c_dev *)arg;
+	struct stm32f7_i2c_dev *i2c_dev = arg;
 	struct stm32_i2c_dma *dma = i2c_dev->dma;
 
 	stm32f7_i2c_disable_dma_req(i2c_dev);
+	dmaengine_terminate_async(dma->chan_using);
 	dma_unmap_single(i2c_dev->dev, dma->dma_buf, dma->dma_len,
 			 dma->dma_data_dir);
 	complete(&dma->dma_complete);
@@ -1510,7 +1511,6 @@ static irqreturn_t stm32f7_i2c_handle_isr_errs(struct stm32f7_i2c_dev *i2c_dev,
 	u16 addr = f7_msg->addr;
 	void __iomem *base = i2c_dev->base;
 	struct device *dev = i2c_dev->dev;
-	struct stm32_i2c_dma *dma = i2c_dev->dma;
 
 	/* Bus error */
 	if (status & STM32F7_I2C_ISR_BERR) {
@@ -1551,10 +1551,8 @@ static irqreturn_t stm32f7_i2c_handle_isr_errs(struct stm32f7_i2c_dev *i2c_dev,
 	}
 
 	/* Disable dma */
-	if (i2c_dev->use_dma) {
-		stm32f7_i2c_disable_dma_req(i2c_dev);
-		dmaengine_terminate_async(dma->chan_using);
-	}
+	if (i2c_dev->use_dma)
+		stm32f7_i2c_dma_callback(i2c_dev);
 
 	i2c_dev->master_mode = false;
 	complete(&i2c_dev->complete);
@@ -1600,7 +1598,6 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 {
 	struct stm32f7_i2c_dev *i2c_dev = data;
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
-	struct stm32_i2c_dma *dma = i2c_dev->dma;
 	void __iomem *base = i2c_dev->base;
 	u32 status, mask;
 	int ret;
@@ -1619,10 +1616,8 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 		dev_dbg(i2c_dev->dev, "<%s>: Receive NACK (addr %x)\n",
 			__func__, f7_msg->addr);
 		writel_relaxed(STM32F7_I2C_ICR_NACKCF, base + STM32F7_I2C_ICR);
-		if (i2c_dev->use_dma) {
-			stm32f7_i2c_disable_dma_req(i2c_dev);
-			dmaengine_terminate_async(dma->chan_using);
-		}
+		if (i2c_dev->use_dma)
+			stm32f7_i2c_dma_callback(i2c_dev);
 		f7_msg->result = -ENXIO;
 	}
 
@@ -1640,8 +1635,7 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 			ret = wait_for_completion_timeout(&i2c_dev->dma->dma_complete, HZ);
 			if (!ret) {
 				dev_dbg(i2c_dev->dev, "<%s>: Timed out\n", __func__);
-				stm32f7_i2c_disable_dma_req(i2c_dev);
-				dmaengine_terminate_async(dma->chan_using);
+				stm32f7_i2c_dma_callback(i2c_dev);
 				f7_msg->result = -ETIMEDOUT;
 			}
 		}


