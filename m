Return-Path: <stable+bounces-6418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E180E680
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF311C213AB
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B382554C;
	Tue, 12 Dec 2023 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nCmrgDRH"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841F199D1
	for <Stable@vger.kernel.org>; Tue, 12 Dec 2023 08:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F95DC433C8;
	Tue, 12 Dec 2023 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702370649;
	bh=Po5kKV0TFEQi7s/3ozYRiV7toJZC/d+wbzBUQ149srM=;
	h=Subject:To:From:Date:From;
	b=nCmrgDRHAs1hW+YsqJ+bU0EPBO3upLXvgQ+hsf/mvn6Qdya2+T0YOn2tk+lAMwK24
	 +0VoFPgwM7Qivcjk4euzvG8KolU4zWkDxncJgk85aX56VOc0MMrJt2h9d3QbtLe/Eh
	 hwlo2KWm5kTGZ1T8zt8mspPjdGelcm2Q7m6IHopI=
Subject: patch "iio: adc: ti_am335x_adc: Fix return value check of" added to char-misc-linus
To: w.egorov@phytec.de,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,b-kapoor@ti.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:43:46 +0100
Message-ID: <2023121246-hassle-balsamic-07d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ti_am335x_adc: Fix return value check of

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 60576e84c187043cef11f11d015249e71151d35a Mon Sep 17 00:00:00 2001
From: Wadim Egorov <w.egorov@phytec.de>
Date: Mon, 25 Sep 2023 15:44:27 +0200
Subject: iio: adc: ti_am335x_adc: Fix return value check of
 tiadc_request_dma()

Fix wrong handling of a DMA request where the probing only failed
if -EPROPE_DEFER was returned. Instead, let us fail if a non -ENODEV
value is returned. This makes DMAs explicitly optional. Even if the
DMA request is unsuccessfully, the ADC can still work properly.
We do also handle the defer probe case by making use of dev_err_probe().

Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Bhavya Kapoor <b-kapoor@ti.com>
Link: https://lore.kernel.org/r/20230925134427.214556-1-w.egorov@phytec.de
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index c755e8cd5220..95fa857e8aad 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -670,8 +670,10 @@ static int tiadc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 
 	err = tiadc_request_dma(pdev, adc_dev);
-	if (err && err == -EPROBE_DEFER)
+	if (err && err != -ENODEV) {
+		dev_err_probe(&pdev->dev, err, "DMA request failed\n");
 		goto err_dma;
+	}
 
 	return 0;
 
-- 
2.43.0



