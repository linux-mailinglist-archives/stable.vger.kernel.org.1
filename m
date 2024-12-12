Return-Path: <stable+bounces-102643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9019EF39A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99571941127
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B2D237FD3;
	Thu, 12 Dec 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lC5lDFn0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9081237FCC;
	Thu, 12 Dec 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021969; cv=none; b=mh9KCbiHhivm1833Mx67m8wOJN9OTkNClU6otajazAz+SCW9RjFGiKQIIw1LTNfl7B5Vz5806XZejtby3meXU+6oF30zgaF26OXf6BZrcuZnGN0AnP8N/hO0AIKYlkkuCOeWrivklyJuxTBO2ZDhtD61ZebfjjdLgEV4fib63Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021969; c=relaxed/simple;
	bh=L3bHHGuCRiP7hk6kN/fdEGJy62K1VQSXY+EVoB6zSrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng8ql3uE4/dd03v5YB57jVa95QjW+yuO2crlQz1GXCDZehB1HwLhiRv7wyKsuznDN7umSe1EMMau2rPhEM2PLqFBVcE33WxCl3z0pFjQwP6H9g8I9JCTJUpbPdpv6m0bgj95T/j5Anz4byRI+1sTCKBU3gemT5x9L5Va3WaOi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lC5lDFn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66E6C4CECE;
	Thu, 12 Dec 2024 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021969;
	bh=L3bHHGuCRiP7hk6kN/fdEGJy62K1VQSXY+EVoB6zSrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lC5lDFn04VazBIyuE3VEUdZf5A7NjI1Ah+FIQG0ULTbbb0OOt1spV2qfzFYM2uIQM
	 H9L8lRoaVhCzWHVIHmBQJHicMgQL7zBvXw1yZWA0tvUYWmfsahFbkS7K8spFxm8Xei
	 edSggtSFJCeWW9FsDVN9W5ldbUSXBNZsQiRceWgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 111/565] spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Thu, 12 Dec 2024 15:55:06 +0100
Message-ID: <20241212144315.866210285@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 003c7e01916c5e2af95add9b0cbda2e6163873e8 ]

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable when request IRQ.

Fixes: 9728fb3ce117 ("spi: lpspi: disable lpspi module irq in DMA mode")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://patch.msgid.link/20240906022828.891812-1-ruanjinjie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index efd2a9b6a9b26..bf3f600bdd2c8 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -871,7 +871,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		goto out_controller_put;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, 0,
+	ret = devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, IRQF_NO_AUTOEN,
 			       dev_name(&pdev->dev), fsl_lpspi);
 	if (ret) {
 		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
@@ -908,14 +908,10 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
 	if (ret == -EPROBE_DEFER)
 		goto out_pm_get;
-	if (ret < 0)
+	if (ret < 0) {
 		dev_warn(&pdev->dev, "dma setup error %d, use pio\n", ret);
-	else
-		/*
-		 * disable LPSPI module IRQ when enable DMA mode successfully,
-		 * to prevent the unexpected LPSPI module IRQ events.
-		 */
-		disable_irq(irq);
+		enable_irq(irq);
+	}
 
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
-- 
2.43.0




