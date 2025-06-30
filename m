Return-Path: <stable+bounces-158899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E770AED885
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C277A755D
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E423C39A;
	Mon, 30 Jun 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cslU2f6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2977220680
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275276; cv=none; b=G6m9uOKWweR6SghJ71QZnaWd8ZfsNRAMhlAGVBRrTn1MV/Ld+gMR4m3aYTQ7RV9cdFUIO4Az12IOPOihSR51XBX5KdX520R+ibP84co5MbQYCOUeEdd57JF6rCgQ9gtSNa7rgyhJ3GvD7+aEgbOkTO3EG+wLhI9JBQChTYUjZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275276; c=relaxed/simple;
	bh=JnQl7POTOPMAN7Pasu9v9C+a+v/fbMDc3zGciG2hcRc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UulwjMv4jNVTg97JTQkKIEputbFaIUGOks1ShBSw/t+11kRhcjasuXJLZpX66ygKPTIZDMlmQv7PE9TBk+RuB8swvquk1CackbKTj42qowLNVK8eK855BXfVuwRofkbNKM4HZ3uKTmXH9JlccXKgTfgUSkYUE1gnnoFucjI0Hgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cslU2f6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1578C4CEEF;
	Mon, 30 Jun 2025 09:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275276;
	bh=JnQl7POTOPMAN7Pasu9v9C+a+v/fbMDc3zGciG2hcRc=;
	h=Subject:To:Cc:From:Date:From;
	b=cslU2f6/Ij116StrivYQ0RqwqqijZOpLt6/sXNZSvhgd5oB3BqE7KT+D1x9mEJNxo
	 9hCgGTEPu5cJuuopuC4ounLnLRZRLBE/gEdZ673sxHDiosTzjCfi3Y2eDp59p/lxSF
	 +g8qhbU2Ph61eFu7u3507ZKW3W2ZvbzA/Hr9fRds=
Subject: FAILED: patch "[PATCH] spi: spi-cadence-quadspi: Fix pm runtime unbalance" failed to apply to 5.10-stable tree
To: khairul.anuar.romli@altera.com,broonie@kernel.org,matthew.gerlach@altera.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:21:08 +0200
Message-ID: <2025063008-celibacy-lukewarm-7bc5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b07f349d1864abe29436f45e3047da2bdd476462
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063008-celibacy-lukewarm-7bc5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b07f349d1864abe29436f45e3047da2bdd476462 Mon Sep 17 00:00:00 2001
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Date: Mon, 16 Jun 2025 09:13:53 +0800
Subject: [PATCH] spi: spi-cadence-quadspi: Fix pm runtime unbalance

Having PM put sync in remove function is causing PM underflow during
remove operation. This is caused by the function, runtime_pm_get_sync,
not being called anywhere during the op. Ensure that calls to
pm_runtime_enable()/pm_runtime_disable() and
pm_runtime_get_sync()/pm_runtime_put_sync() match.

echo 108d2000.spi > /sys/bus/platform/drivers/cadence-qspi/unbind
[   49.644256] Deleting MTD partitions on "108d2000.spi.0":
[   49.649575] Deleting u-boot MTD partition
[   49.684087] Deleting root MTD partition
[   49.724188] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!

Continuous bind/unbind will result in an "Unbalanced pm_runtime_enable" error.
Subsequent unbind attempts will return a "No such device" error, while bind
attempts will return a "Resource temporarily unavailable" error.

[   47.592434] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   49.592233] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   53.232309] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   55.828550] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   57.940627] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   59.912490] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   61.876243] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   61.883000] platform 108d2000.spi: Unbalanced pm_runtime_enable!
[  532.012270] cadence-qspi 108d2000.spi: probe with driver cadence-qspi failed1

Also, change clk_disable_unprepare() to clk_disable() since continuous
bind and unbind operations will trigger a warning indicating that the clock is
already unprepared.

Fixes: 4892b374c9b7 ("mtd: spi-nor: cadence-quadspi: Add runtime PM support")
cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Link: https://patch.msgid.link/4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index fe0f122f07b0..aa1932ba17cb 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1958,10 +1958,10 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	ret = devm_pm_runtime_enable(dev);
-	if (ret) {
-		if (cqspi->rx_chan)
-			dma_release_channel(cqspi->rx_chan);
+	pm_runtime_enable(dev);
+
+	if (cqspi->rx_chan) {
+		dma_release_channel(cqspi->rx_chan);
 		goto probe_setup_failed;
 	}
 
@@ -1981,6 +1981,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
+	pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -1999,7 +2000,8 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	clk_disable_unprepare(cqspi->clk);
+	if (pm_runtime_get_sync(&pdev->dev) >= 0)
+		clk_disable(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);


