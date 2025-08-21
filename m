Return-Path: <stable+bounces-172183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9FDB2FFD0
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0FD5A1730
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA22D0628;
	Thu, 21 Aug 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcnWSxAu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA489285CB6
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792856; cv=none; b=XmI0/a1A1qjFu1HBrf9TrSXSCwpNutDaXDJ+4LwC/v3v/JmmphWNVkKrUTl4meUJlglRRam8XeD2hedceHtmaoFlpyvLyOxthg9pBr8cNXsvXwQ28nH8wbiteT9yFrzYqvYW6RHi5Uj/u6jZPiJZwg2aDDhqvORzUz5U3wfAQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792856; c=relaxed/simple;
	bh=ENWBPedOvBfZJPM3ePCiVmqU7FgDSTLbiEgCEgEJYfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9PR6EyILDTuI9/Uw/XC+bODmBcsBLO8M7RK2NrZbYDw6Iyo60SsXBD+t8xfjT6406Cb1e1mDt2Jzz9QCC9Kl6i95C91uTvGYED/xoDJiR0BbmZjIkhdsnTcWeFurwUB6MM4fkhwir8Li2ZeQqnYBHw//E40jGJ9KiidJY2XatU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcnWSxAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98294C4CEEB;
	Thu, 21 Aug 2025 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755792856;
	bh=ENWBPedOvBfZJPM3ePCiVmqU7FgDSTLbiEgCEgEJYfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcnWSxAuRpsq8yFvjaRvqXhzNJ40WlqgWE4KBxdbdd4ChjckyTA/DTT+Ss3XhAv2d
	 ALOJ6KD0DytmwO9d+HuuJonGlI4qYrbIlmF3W4O7t/ECvcELqtk5ZkYDhjRuuUqKDd
	 N7ouwjSknBdTM4o1qmdkC27U0xsQ6sn27vkCGW/RHIsPPNj5lUj5CcRHB+TwUdRTa9
	 ou2G64RFgmz5KOF1joQ325Prowq/c2/8eqc3kT2OT3Uul3MLaszjafAoTBtJ1jUelC
	 Y7A36+tvHXS50wT05V1694++rsA6H+x/xyCuRGE1QrJPNFaY+yHGSGI8qEdXXYmMMa
	 flpNVwRJiUwgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] usb: musb: omap2430: Convert to platform remove callback returning void
Date: Thu, 21 Aug 2025 12:14:12 -0400
Message-ID: <20250821161413.775044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082155-easing-flavorful-b21d@gregkh>
References: <2025082155-easing-flavorful-b21d@gregkh>
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
index 1d435e4ee857..95cfd6ef3041 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -432,14 +432,12 @@ static int omap2430_probe(struct platform_device *pdev)
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
@@ -509,7 +507,7 @@ MODULE_DEVICE_TABLE(of, omap2430_id_table);
 
 static struct platform_driver omap2430_driver = {
 	.probe		= omap2430_probe,
-	.remove		= omap2430_remove,
+	.remove_new	= omap2430_remove,
 	.driver		= {
 		.name	= "musb-omap2430",
 		.pm	= DEV_PM_OPS,
-- 
2.50.1


