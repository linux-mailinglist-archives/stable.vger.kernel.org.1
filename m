Return-Path: <stable+bounces-9413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22284823242
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45701C2152D
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8D1C287;
	Wed,  3 Jan 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="drrO6XSl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD861BDFD;
	Wed,  3 Jan 2024 17:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C35FC433C9;
	Wed,  3 Jan 2024 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301468;
	bh=28/c+rYXGquU2l7qF4ZQmFe1M8O5ltMV01W17CLpR84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=drrO6XSl4BFbRWDdJcMh3Z7Ht5WDv5oHQYvZlkwXqMjtl4kQNnpXEpoHvzR6gUP5O
	 0T1DdFptipDx8oPJm2523BDj+TD6A25tLL4BwJm7XbvlALgZO9wKZG0VQp31mbYx1m
	 x9MqC3+QpxGnaEdpcusqRZTF3zsrX4Z+Z1QY5Zrc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wadim Egorov <w.egorov@phytec.de>,
	Bhavya Kapoor <b-kapoor@ti.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 41/95] iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()
Date: Wed,  3 Jan 2024 17:54:49 +0100
Message-ID: <20240103164900.309918946@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
References: <20240103164853.921194838@linuxfoundation.org>
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

From: Wadim Egorov <w.egorov@phytec.de>

commit 60576e84c187043cef11f11d015249e71151d35a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ti_am335x_adc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -632,8 +632,10 @@ static int tiadc_probe(struct platform_d
 	platform_set_drvdata(pdev, indio_dev);
 
 	err = tiadc_request_dma(pdev, adc_dev);
-	if (err && err == -EPROBE_DEFER)
+	if (err && err != -ENODEV) {
+		dev_err_probe(&pdev->dev, err, "DMA request failed\n");
 		goto err_dma;
+	}
 
 	return 0;
 



