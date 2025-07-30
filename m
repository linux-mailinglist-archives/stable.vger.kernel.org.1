Return-Path: <stable+bounces-165521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFC3B16221
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC591AA0960
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8EC2C17A3;
	Wed, 30 Jul 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2SwacF3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E972D94BE
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884011; cv=none; b=i//NBbMoSIQK5rGkozZO8+fAcGKq4kzBHAsknwxBqBI7eqN+Rjc+z939jQiRG1HA3O64cx85HRwHg94x/C/gAP1swpp3hlqQjHRLy4LwxmST3zgYIuB7RARUM8eq2e5uy7UPZoeT4tr1Yq8ULa4t7oAisKAkQVQ6/7r9hAVOUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884011; c=relaxed/simple;
	bh=Xz7/K4hUldYXBK2i3wEVuMCHwTvisR7AqGGT2svrzKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1wIsxVLgiP9ztnQQINOt4J71rWq5+HmuhypoKvgZyXLxEoxuDvW9ymxf6aCu0eof00t3iLcW+chfUsIbCZ5V0dY2vEAB69L8bJ242mHwgXmA9lvZ9F97koCe/U1tz4bu5G5AnSvrS+bSOB18cbIwE6Oy+S4dNJq7Mc9sIV22/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2SwacF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75A9C4CEF6;
	Wed, 30 Jul 2025 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753884011;
	bh=Xz7/K4hUldYXBK2i3wEVuMCHwTvisR7AqGGT2svrzKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2SwacF3chamUuk99mUpiy/y8Cn/OVAfmVbyJ6dkP96xp8JU3tcSdPdN5Wq+KaD2E
	 viKgZ4gDLPJR3kr+c8z+dAfU1vYOZ0pJBpVmGMJBuhUovjFyj9QF+SyQi9RFPJ1CMQ
	 c5coUInhy9Fg+kn59POI/Bz1IYoNVke3NJUMcT8blpE6QBT9aFHa6AKWBK3PhImP49
	 g79PiCnp8DpNmqMDMaUWA0msWxNzg9q6wR2shov8ZvauEbPStWQPyk+SzjmA00D4KT
	 N5kivMpsVfhT6+oTEXxwKPhGRbjB7k9lTCy4K28RCCBwZhJ3PGgXT3pRVrm3ai3Tgg
	 syRMSRywhdxUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y v2 4/5] i2c: stm32f7: simplify status messages in case of errors
Date: Wed, 30 Jul 2025 10:00:01 -0400
Message-Id: <20250730140002.3814528-4-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Alain Volmat <alain.volmat@foss.st.com>

[ Upstream commit 33a00d919253022aabafecae6bc88a6fad446589 ]

Avoid usage of __func__ when reporting an error message
since dev_err/dev_dbg are already providing enough details
to identify the source of the message.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 6aae87fe7f18 ("i2c: stm32f7: unmap DMA mapped buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-stm32f7.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 74fef11fd18a..cc76c71666e5 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1601,6 +1601,7 @@ static irqreturn_t stm32f7_i2c_isr_error_thread(int irq, void *data)
 {
 	struct stm32f7_i2c_dev *i2c_dev = data;
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
+	u16 addr = f7_msg->addr;
 	void __iomem *base = i2c_dev->base;
 	struct device *dev = i2c_dev->dev;
 	struct stm32_i2c_dma *dma = i2c_dev->dma;
@@ -1610,8 +1611,7 @@ static irqreturn_t stm32f7_i2c_isr_error_thread(int irq, void *data)
 
 	/* Bus error */
 	if (status & STM32F7_I2C_ISR_BERR) {
-		dev_err(dev, "<%s>: Bus error accessing addr 0x%x\n",
-			__func__, f7_msg->addr);
+		dev_err(dev, "Bus error accessing addr 0x%x\n", addr);
 		writel_relaxed(STM32F7_I2C_ICR_BERRCF, base + STM32F7_I2C_ICR);
 		stm32f7_i2c_release_bus(&i2c_dev->adap);
 		f7_msg->result = -EIO;
@@ -1619,21 +1619,19 @@ static irqreturn_t stm32f7_i2c_isr_error_thread(int irq, void *data)
 
 	/* Arbitration loss */
 	if (status & STM32F7_I2C_ISR_ARLO) {
-		dev_dbg(dev, "<%s>: Arbitration loss accessing addr 0x%x\n",
-			__func__, f7_msg->addr);
+		dev_dbg(dev, "Arbitration loss accessing addr 0x%x\n", addr);
 		writel_relaxed(STM32F7_I2C_ICR_ARLOCF, base + STM32F7_I2C_ICR);
 		f7_msg->result = -EAGAIN;
 	}
 
 	if (status & STM32F7_I2C_ISR_PECERR) {
-		dev_err(dev, "<%s>: PEC error in reception accessing addr 0x%x\n",
-			__func__, f7_msg->addr);
+		dev_err(dev, "PEC error in reception accessing addr 0x%x\n", addr);
 		writel_relaxed(STM32F7_I2C_ICR_PECCF, base + STM32F7_I2C_ICR);
 		f7_msg->result = -EINVAL;
 	}
 
 	if (status & STM32F7_I2C_ISR_ALERT) {
-		dev_dbg(dev, "<%s>: SMBus alert received\n", __func__);
+		dev_dbg(dev, "SMBus alert received\n");
 		writel_relaxed(STM32F7_I2C_ICR_ALERTCF, base + STM32F7_I2C_ICR);
 		i2c_handle_smbus_alert(i2c_dev->alert->ara);
 		return IRQ_HANDLED;
-- 
2.39.5


