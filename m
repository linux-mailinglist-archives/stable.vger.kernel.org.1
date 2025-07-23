Return-Path: <stable+bounces-164325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A3FB0E78B
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 02:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB3617D9C2
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2491BC41;
	Wed, 23 Jul 2025 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa8uThCl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C392E36FA
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230008; cv=none; b=gkGYB4mZ7oYW3cICyQ03EEmWmY761WnnzY8+fo24VjC1ofrP42UduzWaiESu3zazkT6LmA0giX5S7Ts60vSsRfPhtGSVx/MqlSsKj2Si/ubx2b5RocK2kjzHm94joIc6E63LO71oHp/IHPTmLesAzE4VfVqEtcchAAr6VrUQ+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230008; c=relaxed/simple;
	bh=iJiV2HnAVlkhJYF2ndHYq4a1Z3DDqV7bWx4SZFqRSRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIpVenclS1CDjoxDRuA2hY1ys6EeT6r/wuzEkSdsr1dO1oTaK9Tyw9UzE5PEuIIG7EPasfZdyGNEknDbLd7VrxEwN9ijBWKLVR4iI0bGAKwtu0ugUd5DTvef7GehAA5syDh28idStPfPCXeLxJ6x//yw+HkEkmFiljaq2mrQTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa8uThCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D00C4CEEB;
	Wed, 23 Jul 2025 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753230008;
	bh=iJiV2HnAVlkhJYF2ndHYq4a1Z3DDqV7bWx4SZFqRSRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sa8uThClNvIO06vMnYtv5hujmTAaUdovvWgHfIAeIjd8Ibc01JKHy4fZHLdQmoAi9
	 UyELnGc1mM7DVj8+TF4Qm3g8e3B+rHS0BS0OYGAT+44/u0GDAqFg03iXfZqLan0Fk5
	 6IkyzafSSjtnP2Gtgd7TOIS7p0AhB/SMMxZ+LVsOHDV8NKGt1oyRZbaZK9wj08AQDU
	 FpoIurxANEhkW4FF1dpbtsoi7UpsYrw0J8ehGddnIXt4grdc9V/2FrNUiOl7UTKxWV
	 euVNXMofzp2JDvyh7wMDxbfVluelGPGvYhKlWUZyqVliEnKvCmmTwVX3+0/zSey34e
	 CJnc6U7NHhpzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/6] i2c: stm32f7: perform most of irq job in threaded handler
Date: Tue, 22 Jul 2025 20:19:39 -0400
Message-Id: <20250723001942.1010722-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723001942.1010722-1-sashal@kernel.org>
References: <2025072104-bacteria-resend-dcff@gregkh>
 <20250723001942.1010722-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alain Volmat <alain.volmat@foss.st.com>

[ Upstream commit e6103cd45ef0e14eb02f0666bc6b494902cfe821 ]

The irq handling is currently split between the irq handler
and the threaded irq handler.  Some of the handling (such as
dma related stuffs) done within the irq handler might sleep or
take some time leading to issues if the kernel is built with
realtime constraints.  In order to fix that, perform an overall
rework to perform most of the job within the threaded handler
and only keep fifo access in the non threaded handler.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 6aae87fe7f18 ("i2c: stm32f7: unmap DMA mapped buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-stm32f7.c | 126 ++++++++++++++-----------------
 1 file changed, 56 insertions(+), 70 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 11dd6fe9c26c7..d4b765d11b645 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1496,17 +1496,11 @@ static irqreturn_t stm32f7_i2c_slave_isr_event(struct stm32f7_i2c_dev *i2c_dev)
 static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 {
 	struct stm32f7_i2c_dev *i2c_dev = data;
-	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
-	struct stm32_i2c_dma *dma = i2c_dev->dma;
-	void __iomem *base = i2c_dev->base;
-	u32 status, mask;
-	int ret = IRQ_HANDLED;
+	u32 status;
 
-	/* Check if the interrupt if for a slave device */
-	if (!i2c_dev->master_mode) {
-		ret = stm32f7_i2c_slave_isr_event(i2c_dev);
-		return ret;
-	}
+	/* Check if the interrupt is for a slave device */
+	if (!i2c_dev->master_mode)
+		return IRQ_WAKE_THREAD;
 
 	status = readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
 
@@ -1518,6 +1512,29 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 	if (status & STM32F7_I2C_ISR_RXNE)
 		stm32f7_i2c_read_rx_data(i2c_dev);
 
+	/* Wake up the thread if other flags are raised */
+	if (status &
+	    (STM32F7_I2C_ISR_NACKF | STM32F7_I2C_ISR_STOPF |
+	     STM32F7_I2C_ISR_TC | STM32F7_I2C_ISR_TCR))
+		return IRQ_WAKE_THREAD;
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
+{
+	struct stm32f7_i2c_dev *i2c_dev = data;
+	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	struct stm32_i2c_dma *dma = i2c_dev->dma;
+	void __iomem *base = i2c_dev->base;
+	u32 status, mask;
+	int ret;
+
+	if (!i2c_dev->master_mode)
+		return stm32f7_i2c_slave_isr_event(i2c_dev);
+
+	status = readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
+
 	/* NACK received */
 	if (status & STM32F7_I2C_ISR_NACKF) {
 		dev_dbg(i2c_dev->dev, "<%s>: Receive NACK (addr %x)\n",
@@ -1530,33 +1547,28 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 		f7_msg->result = -ENXIO;
 	}
 
-	/* STOP detection flag */
-	if (status & STM32F7_I2C_ISR_STOPF) {
-		/* Disable interrupts */
-		if (stm32f7_i2c_is_slave_registered(i2c_dev))
-			mask = STM32F7_I2C_XFER_IRQ_MASK;
+	if (status & STM32F7_I2C_ISR_TCR) {
+		if (f7_msg->smbus)
+			stm32f7_i2c_smbus_reload(i2c_dev);
 		else
-			mask = STM32F7_I2C_ALL_IRQ_MASK;
-		stm32f7_i2c_disable_irq(i2c_dev, mask);
-
-		/* Clear STOP flag */
-		writel_relaxed(STM32F7_I2C_ICR_STOPCF, base + STM32F7_I2C_ICR);
-
-		if (i2c_dev->use_dma && !f7_msg->result) {
-			ret = IRQ_WAKE_THREAD;
-		} else {
-			i2c_dev->master_mode = false;
-			complete(&i2c_dev->complete);
-		}
+			stm32f7_i2c_reload(i2c_dev);
 	}
 
 	/* Transfer complete */
 	if (status & STM32F7_I2C_ISR_TC) {
+		/* Wait for dma transfer completion before sending next message */
+		if (i2c_dev->use_dma && !f7_msg->result) {
+			ret = wait_for_completion_timeout(&i2c_dev->dma->dma_complete, HZ);
+			if (!ret) {
+				dev_dbg(i2c_dev->dev, "<%s>: Timed out\n", __func__);
+				stm32f7_i2c_disable_dma_req(i2c_dev);
+				dmaengine_terminate_async(dma->chan_using);
+				f7_msg->result = -ETIMEDOUT;
+			}
+		}
 		if (f7_msg->stop) {
 			mask = STM32F7_I2C_CR2_STOP;
 			stm32f7_i2c_set_bits(base + STM32F7_I2C_CR2, mask);
-		} else if (i2c_dev->use_dma && !f7_msg->result) {
-			ret = IRQ_WAKE_THREAD;
 		} else if (f7_msg->smbus) {
 			stm32f7_i2c_smbus_rep_start(i2c_dev);
 		} else {
@@ -1566,47 +1578,18 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
 		}
 	}
 
-	if (status & STM32F7_I2C_ISR_TCR) {
-		if (f7_msg->smbus)
-			stm32f7_i2c_smbus_reload(i2c_dev);
+	/* STOP detection flag */
+	if (status & STM32F7_I2C_ISR_STOPF) {
+		/* Disable interrupts */
+		if (stm32f7_i2c_is_slave_registered(i2c_dev))
+			mask = STM32F7_I2C_XFER_IRQ_MASK;
 		else
-			stm32f7_i2c_reload(i2c_dev);
-	}
-
-	return ret;
-}
-
-static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
-{
-	struct stm32f7_i2c_dev *i2c_dev = data;
-	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
-	struct stm32_i2c_dma *dma = i2c_dev->dma;
-	u32 status;
-	int ret;
-
-	/*
-	 * Wait for dma transfer completion before sending next message or
-	 * notity the end of xfer to the client
-	 */
-	ret = wait_for_completion_timeout(&i2c_dev->dma->dma_complete, HZ);
-	if (!ret) {
-		dev_dbg(i2c_dev->dev, "<%s>: Timed out\n", __func__);
-		stm32f7_i2c_disable_dma_req(i2c_dev);
-		dmaengine_terminate_async(dma->chan_using);
-		f7_msg->result = -ETIMEDOUT;
-	}
+			mask = STM32F7_I2C_ALL_IRQ_MASK;
+		stm32f7_i2c_disable_irq(i2c_dev, mask);
 
-	status = readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
+		/* Clear STOP flag */
+		writel_relaxed(STM32F7_I2C_ICR_STOPCF, base + STM32F7_I2C_ICR);
 
-	if (status & STM32F7_I2C_ISR_TC) {
-		if (f7_msg->smbus) {
-			stm32f7_i2c_smbus_rep_start(i2c_dev);
-		} else {
-			i2c_dev->msg_id++;
-			i2c_dev->msg++;
-			stm32f7_i2c_xfer_msg(i2c_dev, i2c_dev->msg);
-		}
-	} else {
 		i2c_dev->master_mode = false;
 		complete(&i2c_dev->complete);
 	}
@@ -1614,7 +1597,7 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t stm32f7_i2c_isr_error(int irq, void *data)
+static irqreturn_t stm32f7_i2c_isr_error_thread(int irq, void *data)
 {
 	struct stm32f7_i2c_dev *i2c_dev = data;
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
@@ -2201,8 +2184,11 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to request irq event\n");
 
-	ret = devm_request_irq(&pdev->dev, irq_error, stm32f7_i2c_isr_error, 0,
-			       pdev->name, i2c_dev);
+	ret = devm_request_threaded_irq(&pdev->dev, irq_error,
+					NULL,
+					stm32f7_i2c_isr_error_thread,
+					IRQF_ONESHOT,
+					pdev->name, i2c_dev);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to request irq error\n");
 
-- 
2.39.5


