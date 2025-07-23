Return-Path: <stable+bounces-164326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41765B0E78C
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 02:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E80517F867
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA6B2E403;
	Wed, 23 Jul 2025 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw08BRK2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F42E36FA
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230010; cv=none; b=OZh9kPHUXldimD0mshw1dFaUwivMFNd+hvvfS1F/MBpfUowwVgqU5sP6Iqw3BekSlVy0iwujTrXEqusr4r3GgQlIcSjh72fyrF0iYbfRAlsyuuI5/ro7pT3TEAhFuBlFo2boYE1ooOznrMJZgxy+LagJ5/aU2GupXSREFD+F1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230010; c=relaxed/simple;
	bh=B0yyfFWWPiucwsi889qCC2oHhiUpHkQhZ4ag2K25LLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=frIdjhLKakFXzmlKP1Nld0v+jl39CQZaL6vSASYRDZvrfI3JcryW2NNUYFXQrpEEWeITbwvujhPcLoOCPoci7K3fbJW52kxeqF6c4qHl8tlOupbhyzBhx5crSzFIzHzcCv2PWIY0XMS3hPsyp3UiNCAj3CyIBJjcnMPob47Dyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw08BRK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C87C4CEF7;
	Wed, 23 Jul 2025 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753230009;
	bh=B0yyfFWWPiucwsi889qCC2oHhiUpHkQhZ4ag2K25LLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kw08BRK2m4K7A+DxphgygQVrQPaPnyEYmvmfDL8l5+23yc4MtQdSGKb6RiluEoDSx
	 1csJF/AwjZ90/akQUIv8XOydnL5Gsn64/o0cj2XX+QmBzZcDD0GOWV3KIkt0nfd0mC
	 YllmTxRfRWsCaTeilWna9rrEQIeS7PoTVJIkZneFGgZk0qYqlakvzlXJod8j6YkQhT
	 6KdXksZfWR/qVFW/hsWQdnm94bO3Cdxm1ndvi5O1BhBJ+Gdj4IF/LBQKOcnTBcDXn9
	 ar6z4o7S1mwem28GsRcru3I0E3CZvksBqh7nEOO6y1R2nyzgk8TcAurQxr5QwBtgn8
	 NRjve7UQ+ZaFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/6] i2c: stm32f7: simplify status messages in case of errors
Date: Tue, 22 Jul 2025 20:19:40 -0400
Message-Id: <20250723001942.1010722-4-sashal@kernel.org>
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
index d4b765d11b645..5aec7bed109eb 100644
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


