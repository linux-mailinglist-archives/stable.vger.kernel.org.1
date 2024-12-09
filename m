Return-Path: <stable+bounces-100218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794929E9A72
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 16:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681602822A6
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6371BEF8E;
	Mon,  9 Dec 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="OWHt5Gna"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01D23312A;
	Mon,  9 Dec 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757989; cv=none; b=WgeIPii3AkpD85wx+woaHHmxtV8/BBqPViKEnGO6LxV4rnoHc8pY1rCTTKYttBymiH4VuPtb7trXYRAv6LBIVay6pUy4uorNFFWBLBTHrK+el8oVxQR8hK7Fa+zLdhm1RGTyWDsOgVdbPLdAcJWtIEfqOtZX9l98/oQT3sPSn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757989; c=relaxed/simple;
	bh=xebOi1XlHeh4LAmYKKcle4p15EamH5o0sECxF93R5y4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttPFBdQasoHXVl/PWrHsEo5tiwvW+q8BMZb2l8RH30bnH8/W6umV39CF+wkCE+3LYW74ojfmLrAFs/NOcVwlFvy1Cijf8R2ootuuvUigXv0EbfdR5nq4Zma3mqRkcDd/0P3M2AQSubi86aQzuxDeafd/fRmmAgHhzqNh9BH+yfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=OWHt5Gna; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id 89370407675D;
	Mon,  9 Dec 2024 15:26:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 89370407675D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1733757975;
	bh=ZZYGiPSFc8Es0PelroCNMFsOw5U0eQOvjKrfEJuBauM=;
	h=From:To:Cc:Subject:Date:From;
	b=OWHt5GnaW1vHa61gNxVhvVJOoQBd3vEptzFh13zCp1aQiBphfXKmx1+dGQFtQwsIZ
	 m6KXnyRoUK/3hiszqMeO02PttexHOkLz1tcRL3fGIFbbcgcfwWoeBv5qnUOKCh03vr
	 +XylmSKI62mCCYLSbw8pGAbfpjzEXc5BmjRgT0CE=
From: Vitalii Mordan <mordan@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH] usb: phy-tahvo: fix call balance for tu->ick handling routines
Date: Mon,  9 Dec 2024 18:26:04 +0300
Message-Id: <20241209152604.1918882-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock tu->ick was not enabled in tahvo_usb_probe,
it may still hold a non-error pointer, potentially causing
the clock to be incorrectly disabled later in the function.

Use the devm_clk_get_enabled helper function to ensure proper call balance
for tu->ick.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: 9ba96ae5074c ("usb: omap1: Tahvo USB transceiver driver")
Cc: stable@vger.kernel.org
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/usb/phy/phy-tahvo.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index ae7bf3ff89ee..d393308d23d4 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -341,9 +341,11 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 
 	mutex_init(&tu->serialize);
 
-	tu->ick = devm_clk_get(&pdev->dev, "usb_l4_ick");
-	if (!IS_ERR(tu->ick))
-		clk_enable(tu->ick);
+	tu->ick = devm_clk_get_enabled(&pdev->dev, "usb_l4_ick");
+	if (!IS_ERR(tu->ick)) {
+		dev_err(&pdev->dev, "failed to get and enable clock\n");
+		return PTR_ERR(tu->ick);
+	}
 
 	/*
 	 * Set initial state, so that we generate kevents only on state changes.
@@ -353,15 +355,14 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 	tu->extcon = devm_extcon_dev_allocate(&pdev->dev, tahvo_cable);
 	if (IS_ERR(tu->extcon)) {
 		dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
-		ret = PTR_ERR(tu->extcon);
-		goto err_disable_clk;
+		return PTR_ERR(tu->extcon);
 	}
 
 	ret = devm_extcon_dev_register(&pdev->dev, tu->extcon);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register extcon device: %d\n",
 			ret);
-		goto err_disable_clk;
+		return ret;
 	}
 
 	/* Set the initial cable state. */
@@ -384,7 +385,7 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cannot register USB transceiver: %d\n",
 			ret);
-		goto err_disable_clk;
+		return ret;
 	}
 
 	dev_set_drvdata(&pdev->dev, tu);
@@ -405,9 +406,6 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 
 err_remove_phy:
 	usb_remove_phy(&tu->phy);
-err_disable_clk:
-	if (!IS_ERR(tu->ick))
-		clk_disable(tu->ick);
 
 	return ret;
 }
@@ -418,8 +416,6 @@ static void tahvo_usb_remove(struct platform_device *pdev)
 
 	free_irq(tu->irq, tu);
 	usb_remove_phy(&tu->phy);
-	if (!IS_ERR(tu->ick))
-		clk_disable(tu->ick);
 }
 
 static struct platform_driver tahvo_usb_driver = {
-- 
2.25.1


