Return-Path: <stable+bounces-112746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D56A28E31
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595D7168249
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349441547D8;
	Wed,  5 Feb 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LulIBExB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574DFC0B;
	Wed,  5 Feb 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764610; cv=none; b=J9zk1yJDCoQ4KFsXrkL2thDp3aMzbXnNq2N+kFIlWYaFTUuAnkyLMHZePA3x7ydLz4Cf32oLI4+tCN74Sev6Tqm0Ho0rZ7xyAWAqVvkVvsZ/NRJzgzOQ5NznIvroqgcE9diMTsQ5CBthTr8KjYzL6dzl38MeBl/ewjIBtq0vdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764610; c=relaxed/simple;
	bh=VmpiPjwupaaNBwzjo4NljZ87Z8GxLzBwfpd5IOI7oNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx7YXzrqpUC8Vs4zfuzaXF+IRvY1V3rrKwww/OqUKC83x7xDtMT9J7JN3OUo153rBFN3ekIqoJwsVyW1YKTmGes0zGnX3VSMFCfUoJI53m+Pscrs4Ig8jYiJtXKWWy6E8Bmp3z4SDv+OWUYF9t0v99LaL5b8lJp4o9kW5T7L6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LulIBExB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521B5C4CED1;
	Wed,  5 Feb 2025 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764609;
	bh=VmpiPjwupaaNBwzjo4NljZ87Z8GxLzBwfpd5IOI7oNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LulIBExByhQyXXqKKB1nLme9RCvhqVuHWek6dWvRm4R5uQF5h4Cms/QNcjE5qSmSX
	 1BZfdtExXvCTHvpAZXbYRMQDXelAEn2+9wuSwIWxszliNPO7H1sPX0eJ5A2evP8xcR
	 8i2csg5ty3RZABDY7kdiNJqdlloZWgpW7eCGA9AI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 142/590] leds: cht-wcove: Use devm_led_classdev_register() to avoid memory leak
Date: Wed,  5 Feb 2025 14:38:17 +0100
Message-ID: <20250205134500.703458839@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit 417cad5dc782096350e6a967ee5dd3417a19a24e ]

cht_wc_leds_probe() leaks memory when the second led_classdev_register()
call in the for-loop fails as it does not call the cleanup function
led_classdev_unregister() on the first device. Avoid this leak by
calling devm_led_classdev_register().

Fixes: 047da762b9a9 ("leds: Add Intel Cherry Trail Whiskey Cove PMIC LED driver")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20241220085346.533675-1-joe@pf.is.s.u-tokyo.ac.jp
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-cht-wcove.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/leds/leds-cht-wcove.c b/drivers/leds/leds-cht-wcove.c
index b4998402b8c6f..711ac4bd60580 100644
--- a/drivers/leds/leds-cht-wcove.c
+++ b/drivers/leds/leds-cht-wcove.c
@@ -394,7 +394,7 @@ static int cht_wc_leds_probe(struct platform_device *pdev)
 		led->cdev.pattern_clear = cht_wc_leds_pattern_clear;
 		led->cdev.max_brightness = 255;
 
-		ret = led_classdev_register(&pdev->dev, &led->cdev);
+		ret = devm_led_classdev_register(&pdev->dev, &led->cdev);
 		if (ret < 0)
 			return ret;
 	}
@@ -406,10 +406,6 @@ static int cht_wc_leds_probe(struct platform_device *pdev)
 static void cht_wc_leds_remove(struct platform_device *pdev)
 {
 	struct cht_wc_leds *leds = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < CHT_WC_LED_COUNT; i++)
-		led_classdev_unregister(&leds->leds[i].cdev);
 
 	/* Restore LED1 regs if hw-control was active else leave LED1 off */
 	if (!(leds->led1_initial_regs.ctrl & CHT_WC_LED1_SWCTL))
-- 
2.39.5




