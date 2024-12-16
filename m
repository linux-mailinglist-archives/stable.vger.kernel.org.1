Return-Path: <stable+bounces-104356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 706AB9F3319
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAEE77A1CFF
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4E204585;
	Mon, 16 Dec 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ASG6K8Ln"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22AF1E87B;
	Mon, 16 Dec 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359100; cv=none; b=Y76/+/bx+tPBCWfDJFSuGAO+6ZtElPjoIhrMYpU+c7dHue/IWy2QDTv0dZdYznqa7zS1JNk2m2xM6mHEQXATBoiQC10Lcx+RdE9QLJdhdJt+E6IWcpI7pR+SAVNjnQethyi9c78tCwXf+DB9sp5bADvZrJy/CpugnaBp8QKsycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359100; c=relaxed/simple;
	bh=hl1NZL68ZB5FnrnEybP69KYMS4J1xDdmM+P/exug8jE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZrMsT9Jc41bftuJv046OKBwfTXCM+hkd1ObmAhk/JSeSvp/DCV+C/KBbBdiP4b5kQM+KalxOHFU/hmYvSodn7zpYS+QS87cf98qK4EykgxxQAST0jofIAum2zSM3518XJVM44NUEHCLAHsJn8/wzfv8cZ7bl52ArJNaizO656/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ASG6K8Ln; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id A15184076735;
	Mon, 16 Dec 2024 14:24:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A15184076735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1734359096;
	bh=LlvSfZAo1SMRkgfgawBITp8XZZSbyWqpruAeVRVltmg=;
	h=From:To:Cc:Subject:Date:From;
	b=ASG6K8Ln7DEr7G1zGsf9hwUQgGp1QBFpDOTmIP9tdmKYD0C1KEYCZFTO0R1SBknAM
	 cn7yoQWcvUWmEmLfGalwiv0aZkgzNjlGRE7chCJ6pJhTIvWf8kdqP3c4OLDTsvFNMi
	 l2vxKg/TFwjIlGuOqLDQ5jFX+kRV5i6LQhojcycM=
From: Vitalii Mordan <mordan@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH] usb: phy-tahvo: fix call balance for tu->ick handling routines
Date: Mon, 16 Dec 2024 17:24:39 +0300
Message-Id: <20241216142439.3682719-1-mordan@ispras.ru>
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
v2: Corrected a typo in the error handling of the devm_clk_get_enabled
call. This issue was reported by Dan Carpenter <dan.carpenter@linaro.org>.
 drivers/usb/phy/phy-tahvo.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index ae7bf3ff89ee..4182e86dc450 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -341,9 +341,11 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 
 	mutex_init(&tu->serialize);
 
-	tu->ick = devm_clk_get(&pdev->dev, "usb_l4_ick");
-	if (!IS_ERR(tu->ick))
-		clk_enable(tu->ick);
+	tu->ick = devm_clk_get_enabled(&pdev->dev, "usb_l4_ick");
+	if (IS_ERR(tu->ick)) {
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


