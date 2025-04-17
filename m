Return-Path: <stable+bounces-133166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7226A91E97
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDC28A0DF7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A923F420;
	Thu, 17 Apr 2025 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s//qos4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36728E37
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897602; cv=none; b=J6CLoLn1w9RmpQu1CQI0Q5jwfgXU7493pAiIzjywq+1dYKh5y0+yPQLquz2OFEpZfpLEH1OMbrqUGV49quHJEh4joF4j4+sPGV52reLiFQiVg1CtvB8B09NzUB8rTuXlWq1o2eJd/L79RlFhxSUxClR72pfNQgQBZAGHJGasuTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897602; c=relaxed/simple;
	bh=6F9xIPRWinMZxgnlIGP2tI8O5iB9jzoaTd40sQcpEIE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JCRlhSUy3MECb0UdrADCA3RJvCpB5sFBdEPW8WlVKMekwppWd1V54kLv9L4S6v6mIl6VxhqViUc2svB6318J1BV7KTJOD6hXcb0xeHekBv6f67um0F0duob4ujK43B0ZcBHofb6VjunoMj892J4Bsgd9mULERSozOi2Uqwxf0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s//qos4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1481FC4CEE4;
	Thu, 17 Apr 2025 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897602;
	bh=6F9xIPRWinMZxgnlIGP2tI8O5iB9jzoaTd40sQcpEIE=;
	h=Subject:To:Cc:From:Date:From;
	b=s//qos4hXn8WkADevRpN8uCtecE7BDlBS/RGLw3Q3cE5JYDuWmj45/KXsX0CN6sxb
	 iNcnq3r3dVoB86dp9JZfBFda09gSASkoklpV4GWvlIO+HoiUIxoJGqkjtzJi8t10kK
	 AoyNFY2kPhICGZh9GSVjPKZf6zu7Rlo0+GHHJo+o=
Subject: FAILED: patch "[PATCH] spi: fsl-qspi: use devm function instead of driver remove" failed to apply to 5.15-stable tree
To: han.xu@nxp.com,Frank.Li@nxp.com,broonie@kernel.org,haokexin@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:46:25 +0200
Message-ID: <2025041725-unpack-salt-80eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 40369bfe717e96e26650eeecfa5a6363563df6e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041725-unpack-salt-80eb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40369bfe717e96e26650eeecfa5a6363563df6e4 Mon Sep 17 00:00:00 2001
From: Han Xu <han.xu@nxp.com>
Date: Wed, 26 Mar 2025 17:41:51 -0500
Subject: [PATCH] spi: fsl-qspi: use devm function instead of driver remove

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

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 355e6a39fb41..5c59fddb32c1 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -844,6 +844,19 @@ static const struct spi_controller_mem_caps fsl_qspi_mem_caps = {
 	.per_op_freq = true,
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
@@ -934,6 +947,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
+	ret = devm_add_action_or_reset(dev, fsl_qspi_cleanup, q);
+	if (ret)
+		goto err_destroy_mutex;
+
 	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
@@ -953,19 +970,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
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
@@ -1003,7 +1007,6 @@ static struct platform_driver fsl_qspi_driver = {
 		.pm =   &fsl_qspi_pm_ops,
 	},
 	.probe          = fsl_qspi_probe,
-	.remove		= fsl_qspi_remove,
 };
 module_platform_driver(fsl_qspi_driver);
 


