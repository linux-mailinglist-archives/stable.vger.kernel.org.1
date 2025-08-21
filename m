Return-Path: <stable+bounces-172168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50107B2FE01
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4461C1C2185D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB6287276;
	Thu, 21 Aug 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xaooh0dW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9228726F
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789001; cv=none; b=Sl3Z48ZD5OF3q5suh/QRKWuG5ONM7XPToMYsGD+jL84DJ2ALjNQu8f0tVoZRlvlDGItU+52Sv+7N7HG8QiP/L0r3ZMSYJdT/93uCtubUOahc3x3sYw6mOiFoROvaw4eh0EalTQyNEVKreoZQnCYXcobxbX7vMlqMga6uZcPINtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789001; c=relaxed/simple;
	bh=mRtSx8g1LbqTFV1gOVVyUv97GPIzNFWNXBB2BlcHyxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kE3TiJae4IsWWa5F+V6R5f5X433eYo4wS3ehbEQLfa/jifc8AWFkMxYwKzduEGH2NwRwfX1PwcJTZ6BqOD/hVyF1jAIctNpMGMDnZ0djhEU4SragveE5tjNhxHuU8T0vijJe0NSARzueTcWhNDieQLrkSUPEzGoAmR2aMLViHcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xaooh0dW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FD2C4CEEB;
	Thu, 21 Aug 2025 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789000;
	bh=mRtSx8g1LbqTFV1gOVVyUv97GPIzNFWNXBB2BlcHyxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xaooh0dWA829Bop3GlA6IMPVBJlieUhkCyN0nb9O2HCmVnoAJgft4OXV7LXh6Y315
	 cAVbgxH2BRBMvtlCoRiXmB2XZ2F26yWz1jT2wZEwkm2ZA9HRiOa0BugfXPde4fKfTX
	 lJyiCzwjwjXObrcEN2EH0XjlYpEmM6KqyoDYeATVkAc13bp3aagceh+5+06mIb8c+/
	 IKakpVK02fOoyl6BdVZAiW0LJT7ezMl9Eny8M+WVSxAghT7VLz/cOrhFZXMK1t0HEF
	 spZE4fyV+DQPyFj/6UBLmfIqqbqS+KZAnSKgmnzfoIkRxYmYHgckdfovnXjrh+l4GO
	 vaUThsPCTsxOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] usb: musb: omap2430: Convert to platform remove callback returning void
Date: Thu, 21 Aug 2025 11:09:56 -0400
Message-ID: <20250821150957.756147-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082154-mutate-utilize-26d0@gregkh>
References: <2025082154-mutate-utilize-26d0@gregkh>
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
index bd1de5c4c434..5f5d9b59ce7e 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -435,14 +435,12 @@ static int omap2430_probe(struct platform_device *pdev)
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
@@ -574,7 +572,7 @@ MODULE_DEVICE_TABLE(of, omap2430_id_table);
 
 static struct platform_driver omap2430_driver = {
 	.probe		= omap2430_probe,
-	.remove		= omap2430_remove,
+	.remove_new	= omap2430_remove,
 	.driver		= {
 		.name	= "musb-omap2430",
 		.pm	= DEV_PM_OPS,
-- 
2.50.1


