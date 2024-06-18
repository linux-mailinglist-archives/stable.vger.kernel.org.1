Return-Path: <stable+bounces-53646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ACD90D550
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127441C20DD8
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F3B14036D;
	Tue, 18 Jun 2024 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KR2hEGwg"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384872139A2
	for <Stable@vger.kernel.org>; Tue, 18 Jun 2024 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720267; cv=none; b=Xk45tuctGWpd7H7TfYbmTlyA8F65M6LS7xW0KE+Hiani2zMJyUewSkvCVP1y0qgnpttriYDQdLuYeX7nZFC4NirBDT8y61FrVkQ6UhziCyCwMSIVHaH4HAplyHoW5d/DWc8fbzIyzY9HWWRFrqppVf2TXa3/ouP2fEDYJYRAOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720267; c=relaxed/simple;
	bh=PwN3TE49BjCa/xicRRhGS6FGqy1enXbxbHZxe3vnv6o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=io+mb0Dqf3jqjN9TqRa0SmT/tDkPsU4VT0BMrs98LX2kHGu47e8Vyut0rrPQ7jwDuXXJnCalyr07UEMK0OE3UJ2o7ukR5VhriI3rLKD+iOKQLqN/KQ7OYuAyGq3Xu2iXkdPaAfGc3/i7O6wWm162aNal5y209SsWuyfp8bfKsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KR2hEGwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFB1C3277B;
	Tue, 18 Jun 2024 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718720267;
	bh=PwN3TE49BjCa/xicRRhGS6FGqy1enXbxbHZxe3vnv6o=;
	h=Subject:To:Cc:From:Date:From;
	b=KR2hEGwg/CCFh/7T0v2fQqJRNDOao5d4VTYVtYcrALwBpRlD258e3digxZ13AWr1o
	 BrFnIh2sXhsCJOZqRKbA2bqXbtHa41eYAHvLYKJ1a+9oijl23mW3PD7ZRQAe8wQMyV
	 JkMIPv6bPtRkO1Z5lRccTotagAtNt6GJntb0FEog=
Subject: FAILED: patch "[PATCH] iio: adc: axi-adc: make sure AXI clock is enabled" failed to apply to 6.1-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 16:17:44 +0200
Message-ID: <2024061844-retiree-walrus-8589@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 80721776c5af6f6dce7d84ba8df063957aa425a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061844-retiree-walrus-8589@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

80721776c5af ("iio: adc: axi-adc: make sure AXI clock is enabled")
794ef0e57854 ("iio: adc: adi-axi-adc: move to backend framework")
9c446288d7b3 ("iio: buffer-dmaengine: export buffer alloc and free functions")
21aa971d3e29 ("iio: adc: adi-axi-adc: convert to regmap")
b73f08bb7fe5 ("iio: adc: ad9467: fix scale setting")
1240c94ce819 ("iio: adc: Explicitly include correct DT includes")
4c077429b422 ("iio: mlx90614: Sort headers")
a99544c6c883 ("iio: adc: palmas: add support for iio threshold events")
2d48dbdfc7d4 ("iio: adc: palmas: move eventX_enable into palmas_adc_event")
7501a3a97e4f ("iio: adc: palmas: use iio_event_direction for threshold polarity")
d2ab4eea732d ("iio: adc: palmas: replace "wakeup" with "event"")
79d9622d622d ("iio: adc: palmas: remove adc_wakeupX_data")
6d52b0e70698 ("iio: adc: palmas: Take probe fully device managed.")
49f76c499d38 ("iio: adc: palmas_gpadc: fix NULL dereference on rmmod")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80721776c5af6f6dce7d84ba8df063957aa425a2 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 26 Apr 2024 17:42:13 +0200
Subject: [PATCH] iio: adc: axi-adc: make sure AXI clock is enabled

We can only access the IP core registers if the bus clock is enabled. As
such we need to get and enable it and not rely on anyone else to do it.

Note this clock is a very fundamental one that is typically enabled
pretty early during boot. Independently of that, we should really rely on
it to be enabled.

Fixes: ef04070692a2 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240426-ad9467-new-features-v2-4-6361fc3ba1cc@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 9444b0c5a93c..f54830658da8 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -161,6 +161,7 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	struct adi_axi_adc_state *st;
 	void __iomem *base;
 	unsigned int ver;
+	struct clk *clk;
 	int ret;
 
 	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
@@ -181,6 +182,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (!expected_ver)
 		return -ENODEV;
 
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
 	/*
 	 * Force disable the core. Up to the frontend to enable us. And we can
 	 * still read/write registers...


