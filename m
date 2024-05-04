Return-Path: <stable+bounces-43064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A488BBD4F
	for <lists+stable@lfdr.de>; Sat,  4 May 2024 18:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B208D1F215A5
	for <lists+stable@lfdr.de>; Sat,  4 May 2024 16:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813C3D971;
	Sat,  4 May 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSIQin0l"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5757B1E871
	for <Stable@vger.kernel.org>; Sat,  4 May 2024 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714841832; cv=none; b=VboiUPszaIyKWonfZRJhg6o0yrZKfFS/ybxS/VVqQ9Oi5HDDTYDGaycp2IH7fxOEWqCdQqh6MswiEoo1l3Zqve9v5C4tjxjFIoaG7pHGWq7VJyf09fV4jPHOFFTTTRagDjbc9clVWrDSPjDmO2acviRNmVrQbAZg5dC9lSaERC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714841832; c=relaxed/simple;
	bh=8h6VtIYV36peudAg9wz8l+CDsl7T/RvpjS2r9qFO9hQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=McWf0fLmrIQp+ePfKz7OUYgFvx8AoeCdCzvMx9UbeJOT1y0HXMZIN9aHWJNWWEbgHtk+mzt9A+2jBBctO9nqjITph8tUaCdro+ZUxZ1OeY6GC4L0cJDhIXIU167b9Hg8pxCedJuWFXDsttbkX7Pgh19jxDHIkYkT2dZQc0ORrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jSIQin0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1C1C072AA;
	Sat,  4 May 2024 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714841831;
	bh=8h6VtIYV36peudAg9wz8l+CDsl7T/RvpjS2r9qFO9hQ=;
	h=Subject:To:From:Date:From;
	b=jSIQin0lJ61K6u0lWhMd/BY43GuVDScRwZ1oL8uvF64fGo4qns8e/i8b0b8ONpkxC
	 u44W/21YSXTRreSPpNbDVCCYqfLKLLFyy3ZkmiS/bIX4hTs2nd6ZQVLpKvNktlZEUM
	 Z25DxwkLEpcHigTzLc/EEEPHYcSpxsy0Y4pJFoI4=
Subject: patch "iio: adc: axi-adc: make sure AXI clock is enabled" added to char-misc-next
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sat, 04 May 2024 18:56:23 +0200
Message-ID: <2024050423-lunchroom-overfull-2063@gregkh>
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
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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



