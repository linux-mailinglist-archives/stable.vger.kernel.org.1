Return-Path: <stable+bounces-43052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655B8BB9DE
	for <lists+stable@lfdr.de>; Sat,  4 May 2024 09:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C520B21825
	for <lists+stable@lfdr.de>; Sat,  4 May 2024 07:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868E279C4;
	Sat,  4 May 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OEmpvQAU"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F604C9A
	for <Stable@vger.kernel.org>; Sat,  4 May 2024 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714809048; cv=none; b=KEqvMkPcjv1q2Wzbfwl7abZMGy/BpyeC4/vA6q3wZJdzbRsv9ulnzMpYDpqgEynX29vuErD1+yYrzjVhE7fT0mKY/VF4th05cXn3iOavgl/c8pyyZ1sxo3Mz9P9tcot6V3JMrYesWx23c2ha69XvehwgQJzT0nAbaJCbYvrtJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714809048; c=relaxed/simple;
	bh=5xWrhDN6MMEzs8h9EXMxDXmGroEK4H557ydc42B/taY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=JN4m81aYxKjePu9lIFIKA6mRnMD7XM0FQ0g9XJlR1VxCVhchnOAwAds5HMjwcgDGrqycgrcuxW3jUxYc1hlpIqFJ3hzGMHlq7QOJUjc7F/2QWA7zpMIrkIcGua50kIsB5dFUj0zaHgnfTCt255/X3vptPY8GGRVZXDQAxkLiy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OEmpvQAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DB6C072AA;
	Sat,  4 May 2024 07:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714809047;
	bh=5xWrhDN6MMEzs8h9EXMxDXmGroEK4H557ydc42B/taY=;
	h=Subject:To:From:Date:From;
	b=OEmpvQAUB8RKwmTbe1WWyohlDhWmHm1QpHNzqwGwamFoOn9A9pL984tD+6Eh9cMtj
	 GsWvWETpTf6C56UI38k3HGCFe08BPI7exgOTb9QKMdOoh7OrSE1hDmxRD0dnBGzgQN
	 +FO7QTYmzOryGHfXEuwWU2WCYVv0N5LJzd/oPNEw=
Subject: patch "iio: adc: axi-adc: make sure AXI clock is enabled" added to char-misc-testing
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sat, 04 May 2024 09:50:00 +0200
Message-ID: <2024050459-slightly-hypnotize-e99a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: axi-adc: make sure AXI clock is enabled

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 80721776c5af6f6dce7d84ba8df063957aa425a2 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 26 Apr 2024 17:42:13 +0200
Subject: iio: adc: axi-adc: make sure AXI clock is enabled

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
---
 drivers/iio/adc/adi-axi-adc.c | 5 +++++
 1 file changed, 5 insertions(+)

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
-- 
2.45.0



