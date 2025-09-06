Return-Path: <stable+bounces-178005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923CDB4772C
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 22:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F81581B6C
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10261283686;
	Sat,  6 Sep 2025 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDnoGKjQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEE27EFE7
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757192003; cv=none; b=aAtOvK3Ro9s3OJ8iJQVwX1i/vVI41sCKDezcGIrZuqTqFjwLQkb8i9vGO+O8YJOZcsvZWAsRuYgEspw5XZmGtQ16zuva5IGU2MJzqc2cAH+IHs5ygNN86aSWUoh9JRE8yByovOYh2sE/t/Cw0bKVRHm6t7cZv1m81gnuhUnY0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757192003; c=relaxed/simple;
	bh=0249P8GNZoeB7AAJOUzcfFNcXwJXOGPySw0Xij1YU2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOHF58Mfx9CP7O0TmibrDyuFRLD4OwvR+c3rHz8l9tnYqeEwovh6v8tWabxAo5w4JuEtIQAarubYugWBN49LJw/Ekoj+YhJGXQeeFy8liC1mWr1qvGNshLS3jkTr6e4GpGUp3d1HkGmVZS58dRBIJoPLbewrR+PS1FWvnrSrnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDnoGKjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68DBC4CEE7;
	Sat,  6 Sep 2025 20:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757192002;
	bh=0249P8GNZoeB7AAJOUzcfFNcXwJXOGPySw0Xij1YU2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDnoGKjQcxrCrgep0ONz79jxKwkxeOvG5qWq5S3FbBsEvUTBkoBPsZoNgFqmL78Gr
	 u1J1MHFPeRsXcWKIvUUIJk79HflF3GzaYAw/P3scOE6Bz5nWrKsUWMh747qnYk7wlo
	 f39kZMhMYaz3+IgB9hajXB/WdeggvgUv0qfoOXOo9X6X/eWTAL7yACpY43Q2wjJ1pC
	 9OFPV9EXbtC3VnsViKF83HMwg4tJxoHVCQcoI/QWBr8wBlDKyLjfpJweFeMET1uAni
	 q6lpXsFVFlRRaj9PGu1CgGzNGfogO7vfH6rV+VmSAO6TQF+L++VvR1lRshkfyeils8
	 IkfgUxmrQesjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>,
	Kevin Hao <haokexin@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] spi: fsl-qspi: use devm function instead of driver remove
Date: Sat,  6 Sep 2025 16:53:20 -0400
Message-ID: <20250906205320.288349-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041724-sectional-germless-279b@gregkh>
References: <2025041724-sectional-germless-279b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Xu <han.xu@nxp.com>

[ Upstream commit 40369bfe717e96e26650eeecfa5a6363563df6e4 ]

Driver use devm APIs to manage clk/irq/resources and register the spi
controller, but the legacy remove function will be called first during
device detach and trigger kernel panic. Drop the remove function and use
devm_add_action_or_reset() for driver cleanup to ensure the release
sequence.

Trigger kernel panic on i.MX8MQ by
echo 30bb0000.spi >/sys/bus/platform/drivers/fsl-quadspi/unbind

Cc: stable@vger.kernel.org
Fixes: 8fcb830a00f0 ("spi: spi-fsl-qspi: use devm_spi_register_controller")
Reported-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250326224152.2147099-1-han.xu@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-qspi.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 79bac30e79af6..310350d2c5302 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -839,6 +839,19 @@ static const struct spi_controller_mem_ops fsl_qspi_mem_ops = {
 	.get_name = fsl_qspi_get_name,
 };
 
+static void fsl_qspi_cleanup(void *data)
+{
+	struct fsl_qspi *q = data;
+
+	/* disable the hardware */
+	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
+	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
+
+	fsl_qspi_clk_disable_unprep(q);
+
+	mutex_destroy(&q->lock);
+}
+
 static int fsl_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -928,6 +941,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
+	ret = devm_add_action_or_reset(dev, fsl_qspi_cleanup, q);
+	if (ret)
+		goto err_destroy_mutex;
+
 	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
@@ -947,19 +964,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void fsl_qspi_remove(struct platform_device *pdev)
-{
-	struct fsl_qspi *q = platform_get_drvdata(pdev);
-
-	/* disable the hardware */
-	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
-	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
-
-	fsl_qspi_clk_disable_unprep(q);
-
-	mutex_destroy(&q->lock);
-}
-
 static int fsl_qspi_suspend(struct device *dev)
 {
 	return 0;
@@ -997,7 +1001,6 @@ static struct platform_driver fsl_qspi_driver = {
 		.pm =   &fsl_qspi_pm_ops,
 	},
 	.probe          = fsl_qspi_probe,
-	.remove_new	= fsl_qspi_remove,
 };
 module_platform_driver(fsl_qspi_driver);
 
-- 
2.51.0


