Return-Path: <stable+bounces-172190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90945B2FFED
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D20B6106C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF012DCF52;
	Thu, 21 Aug 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hf18rQW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE302DA76C
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793227; cv=none; b=s0p7jckCl8T2aHmQI0PxEbpyxKQ1L4yNSyTzpncrcG+tvClmSGvxOaCY3k601Gd93eO9oPZEbGDRP3CpnusgMqC1YFtNKr2Hnu5GSFgUc8KT/OAkUWmBkE9TIhHdjP5efUWc5gl2Cc+OYJOw3Cvlnclcvr2DRgJwwcnc9SfSKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793227; c=relaxed/simple;
	bh=frkYYLRV7hOpuijocyFqUVWEBMOWb4ro1H7vcpTVRbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWR1o5Y9eIZgmv0DTNZtKz2fPL1ga3kvyGF2Qv7V74IgngqwSVqb3p692vajw/dxD/f7SCAPc4KrNfLB/4sd54zklI8xBN6m+RHHKRUU0TYK1csCnfnAYKagWyFYppkAO1xS2FemnlfMzLKWDXer1CzR62lJ+xKmpSFAv/xIjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hf18rQW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA3AC4CEEB;
	Thu, 21 Aug 2025 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755793227;
	bh=frkYYLRV7hOpuijocyFqUVWEBMOWb4ro1H7vcpTVRbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hf18rQW2ZenpgPuNwL05eGjrSfSI9kCBk85tjZcXpwpouNXmt1cI4Exsz8+7+vOUm
	 zQBkT+YEQqgjLui4dHeFOGToXhE06jL++swBbrSlmmxWyl6yAWONx6a4onh3NwP9vy
	 qV3fwfmGYhsBK+Dh5yCNuHWX8AGJizB5pJA0FSuhwOR8+DTd8VmhYjoHvv4p603gOV
	 B35n6wB05naX9U3E/alJ46IMsdn1T05+LtJ243coUmskht2kcVquJEvZkFu5tQbnsH
	 W5bzx3UtDU/acIb4CmMbYOHY3VVx0M+jMwG3Fma6iY148K8YSD+0fXLqux3QOCgGG/
	 ElIAMt7g7N5aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] usb: musb: omap2430: Convert to platform remove callback returning void
Date: Thu, 21 Aug 2025 12:20:24 -0400
Message-ID: <20250821162025.780036-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082155-sympathy-finally-e1ad@gregkh>
References: <2025082155-sympathy-finally-e1ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit cb020bf52253327fe382e10bcae02a4f1da33c04 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230405141009.3400693-8-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1473e9e7679b ("usb: musb: omap2430: fix device leak at unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/omap2430.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 8def19fc5025..56f4fa411e27 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -505,14 +505,12 @@ static int omap2430_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap2430_remove(struct platform_device *pdev)
+static void omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue *glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -579,7 +577,7 @@ MODULE_DEVICE_TABLE(of, omap2430_id_table);
 
 static struct platform_driver omap2430_driver = {
 	.probe		= omap2430_probe,
-	.remove		= omap2430_remove,
+	.remove_new	= omap2430_remove,
 	.driver		= {
 		.name	= "musb-omap2430",
 		.pm	= DEV_PM_OPS,
-- 
2.50.1


