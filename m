Return-Path: <stable+bounces-207230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBA0D09A31
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B99D930DB525
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAEA359FA0;
	Fri,  9 Jan 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JdIgpT75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6A1531E8;
	Fri,  9 Jan 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961463; cv=none; b=GbkvlUUB01iTtXrfk8OQQfUaS6Z1SNy6ECSix0GHesCrm9tLbF0UkSHo+cxGXq0Nv4nERU9o9dYUuCOt2s7tg15dmu8D7z/YbqF5c69ZxP0Dk9jhmiUxzmWwNdi6P6wuI4glXLM67N+R/lKwOp30hXK+vUso3XcCtym+/LXu4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961463; c=relaxed/simple;
	bh=8lZuutloRg8uvbdGGUS1AUCoGSdKHsL0hTja4BPufHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMHMSjL8eARykUAak6DLI+3cvBr1SfK40gi/YG64di/cUOLF8A8D7w8RIuuoUBcycjfoRqDi6Nniw7rtUp6/rLNom1Hyo9xT+9CdmMTwPwUSGU2aLYd1tc9hQcmKdPNwiLOpTzaKyNoGn6ZQVoiHK9GVQJ/ioDYfDv5+Gpk5KNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JdIgpT75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1329C16AAE;
	Fri,  9 Jan 2026 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767961463;
	bh=8lZuutloRg8uvbdGGUS1AUCoGSdKHsL0hTja4BPufHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdIgpT75UuY2/5xcWtxrxf/YTDOzPmJ68LpjeNzEigCfmfn83HRb1kgaw31muV+Mg
	 HBazQ4xMoqfNbPYH+B5dy0dgFpNQqu0T4cCmwLRmKVWaLagTva3xlVhTeqvvmErWG9
	 WmVYT9KtIiYRC0qSvsEb7sw5SzoPqWOAlJq8llNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carlos Song <carlos.song@nxp.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 023/634] spi: imx: keep dma request disabled before dma transfer setup
Date: Fri,  9 Jan 2026 12:35:01 +0100
Message-ID: <20260109112118.318195678@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Robin Gong <yibin.gong@nxp.com>

[ Upstream commit 86d57d9c07d54e8cb385ffe800930816ccdba0c1 ]

Since sdma hardware configure postpone to transfer phase, have to disable
dma request before dma transfer setup because there is a hardware
limitation on sdma event enable(ENBLn) as below:

"It is thus essential for the Arm platform to program them before any DMA
 request is triggered to the SDMA, otherwise an unpredictable combination
 of channels may be started."

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Link: https://patch.msgid.link/20251024055320.408482-1-carlos.song@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 13a6ebef01894..e929a5af38eea 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -503,9 +503,15 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 {
 	u32 reg;
 
-	reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
-	reg |= MX51_ECSPI_CTRL_XCH;
-	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+	if (spi_imx->usedma) {
+		reg = readl(spi_imx->base + MX51_ECSPI_DMA);
+		reg |= MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN;
+		writel(reg, spi_imx->base + MX51_ECSPI_DMA);
+	} else {
+		reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+		reg |= MX51_ECSPI_CTRL_XCH;
+		writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+	}
 }
 
 static void mx51_disable_dma(struct spi_imx_data *spi_imx)
@@ -689,7 +695,6 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
 		MX51_ECSPI_DMA_TX_WML(tx_wml) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
-		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
 }
 
@@ -1449,6 +1454,8 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	reinit_completion(&spi_imx->dma_tx_completion);
 	dma_async_issue_pending(controller->dma_tx);
 
+	spi_imx->devtype_data->trigger(spi_imx);
+
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
 	/* Wait SDMA to finish the data transfer.*/
-- 
2.51.0




