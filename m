Return-Path: <stable+bounces-139319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76433AA60E4
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368261BA4F4E
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB913201262;
	Thu,  1 May 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0MgWd06+"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BADF1BF37
	for <Stable@vger.kernel.org>; Thu,  1 May 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114545; cv=none; b=ujlEbEo2ZAekTVmwhjTz/NjjJRTXAtAopd76xnfMyM4uQucmzFyFSGCF8iqIoHD2mwTItpTwcFrK4/8tEZM7wX6jTT0hfUdJ0HsMSvho+ZLmFEiCvNeadSL+vCTy4K8hM2mZNJhNwNlGsIOLpKiED87SX1PHt7qRFvAhl3m3el4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114545; c=relaxed/simple;
	bh=/sIdDAcXjKFAYTMaBkCjTJ80gvjgmIl9/N/bFAUG0Ts=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Y+dqhg4EqTb/YsuZZ+IlOU6LpImSDG6uXz41vokJpiZToG/9iinZJodYQkYfsJHRI+otQDZ+p+jiJNPr/POCJsgNHdEeviQR/7ikMDobXTSfdmNJrxZGgWTJ9MU2CLbzQC2UjxuVqTP4+m5wX7bRL1lO770dxfmS6fdWjoDTG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0MgWd06+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A48C4CEE3;
	Thu,  1 May 2025 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114545;
	bh=/sIdDAcXjKFAYTMaBkCjTJ80gvjgmIl9/N/bFAUG0Ts=;
	h=Subject:To:From:Date:From;
	b=0MgWd06+SZLcns6rCcKdGvHHCM+FPPoKb0+0xha7drxdA9fswdWeHeyMyf9Fq1o73
	 kVZrwI43qHj9zeEHS+pir5dpd/8/bYicUcmQVPUxkqhvpyGEr94HN0DoVfRmhjN2xc
	 h25QSIR5HcsbCFI35J+ZRpiGid3+n1Pte8hahvWs=
Subject: patch "iio: adc: rockchip: Fix clock initialization sequence" added to char-misc-linus
To: xxm@rock-chips.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,heiko@sntech.de
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 17:48:54 +0200
Message-ID: <2025050154-atlantic-truth-0ac3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: rockchip: Fix clock initialization sequence

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 839f81de397019f55161c5982d670ac19d836173 Mon Sep 17 00:00:00 2001
From: Simon Xue <xxm@rock-chips.com>
Date: Wed, 12 Mar 2025 14:20:16 +0800
Subject: iio: adc: rockchip: Fix clock initialization sequence

clock_set_rate should be executed after devm_clk_get_enabled.

Fixes: 97ad10bb2901 ("iio: adc: rockchip_saradc: Make use of devm_clk_get_enabled")
Signed-off-by: Simon Xue <xxm@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20250312062016.137821-1-xxm@rock-chips.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rockchip_saradc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 9a099df79518..5e28bd28b81a 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -520,15 +520,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (info->reset)
 		rockchip_saradc_reset_controller(info->reset);
 
-	/*
-	 * Use a default value for the converter clock.
-	 * This may become user-configurable in the future.
-	 */
-	ret = clk_set_rate(info->clk, info->data->clk_rate);
-	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to set adc clk rate\n");
-
 	ret = regulator_enable(info->vref);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
@@ -555,6 +546,14 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
 				     "failed to get adc clock\n");
+	/*
+	 * Use a default value for the converter clock.
+	 * This may become user-configurable in the future.
+	 */
+	ret = clk_set_rate(info->clk, info->data->clk_rate);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to set adc clk rate\n");
 
 	platform_set_drvdata(pdev, indio_dev);
 
-- 
2.49.0



