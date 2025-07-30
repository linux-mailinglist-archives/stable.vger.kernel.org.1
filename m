Return-Path: <stable+bounces-165522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007CEB16222
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939BA3A67CC
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CCB2C3252;
	Wed, 30 Jul 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4zdTuIp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3819E97A
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884013; cv=none; b=r1xJD1hF0n5u/j9R/8enzNE4kntNkGtL5Ia/zgBYJcYEz5KsFavnKXygxZBOWKzxyKXNMUDy+nmqY0+VkvT0yQBOrWX7rMK9SflmWFWt4vaSJQ48NDtOO0KgY4aLzyPs9UYXCso23Zzbys1k2CxqoMe5IFyDEkyzLKK3mrRkphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884013; c=relaxed/simple;
	bh=mmUIy7G6GVPQ/4ABS+zz9/k6r1NK+olXBLC198V55Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ti0hl7m4zZKfcND6R8IN/uvPnBc7PCM3Vs1ZE/8hv5OSJZKyyrFdFtQeyNpHCYrczbA+VqK5zL6twlENonamx9hvOcQ0sKpcFPJC6etcXQyetN6Krrb17hspzRjvY8aRDZT2WXTCm4E9zm+KE7bvKJG6nAqSfMet1L3IjMC0z1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4zdTuIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB16C4CEE3;
	Wed, 30 Jul 2025 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753884013;
	bh=mmUIy7G6GVPQ/4ABS+zz9/k6r1NK+olXBLC198V55Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4zdTuIpx6wOtVIyHzQbfEo8QIQFHJ4IZsz/fH15TpUA7HYamZepal7bGPzmA8kP6
	 d7HbjsQ7vWNkE9CeN68UY4OzVPOt6WYWOtxek8Lf/vH1i/L7oKDvSZoMYZ6JIgGZ6U
	 ZLcZaxv4cXYgRE4ZkqgNenbpPhp6wFlhZ4rjOGrh6/TM4X9ChZ08yTLmId2qpdVVdp
	 N/PP5rT5xb1KZkqkp8fCaBivddZQm6ACpj0SZLtwqrrYT+S94LtXcERwNmfd+B0WR6
	 xArFq7k/NmA2X7ngu23+wv7UeqajWwuRqPh2OPsPS2bBFHrBkenPgPMGZ+wnSQq0xw
	 236FcNk0OqWwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y v2 5/5] i2c: stm32f7: unmap DMA mapped buffer
Date: Wed, 30 Jul 2025 10:00:02 -0400
Message-Id: <20250730140002.3814528-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730140002.3814528-1-sashal@kernel.org>
References: <2025072104-bacteria-resend-dcff@gregkh>
 <20250730140002.3814528-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Clément Le Goffic <clement.legoffic@foss.st.com>

[ Upstream commit 6aae87fe7f180cd93a74466cdb6cf2aa9bb28798 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-stm32f7.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index cc76c71666e5..956803ba6c1e 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -726,10 +726,11 @@ static void stm32f7_i2c_disable_dma_req(struct stm32f7_i2c_dev *i2c_dev)
 
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
@@ -1525,7 +1526,6 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 {
 	struct stm32f7_i2c_dev *i2c_dev = data;
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
-	struct stm32_i2c_dma *dma = i2c_dev->dma;
 	void __iomem *base = i2c_dev->base;
 	u32 status, mask;
 	int ret;
@@ -1540,10 +1540,8 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
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
 
@@ -1561,8 +1559,7 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 			ret = wait_for_completion_timeout(&i2c_dev->dma->dma_complete, HZ);
 			if (!ret) {
 				dev_dbg(i2c_dev->dev, "<%s>: Timed out\n", __func__);
-				stm32f7_i2c_disable_dma_req(i2c_dev);
-				dmaengine_terminate_async(dma->chan_using);
+				stm32f7_i2c_dma_callback(i2c_dev);
 				f7_msg->result = -ETIMEDOUT;
 			}
 		}
@@ -1604,7 +1601,6 @@ static irqreturn_t stm32f7_i2c_isr_error_thread(int irq, void *data)
 	u16 addr = f7_msg->addr;
 	void __iomem *base = i2c_dev->base;
 	struct device *dev = i2c_dev->dev;
-	struct stm32_i2c_dma *dma = i2c_dev->dma;
 	u32 status;
 
 	status = readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
@@ -1648,10 +1644,8 @@ static irqreturn_t stm32f7_i2c_isr_error_thread(int irq, void *data)
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
-- 
2.39.5


