Return-Path: <stable+bounces-172103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B9DB2FAD7
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542FA1893018
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD842EDD7C;
	Thu, 21 Aug 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVHKDqW1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF652EDD7D
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783166; cv=none; b=iTlZBHPMqt7SxSQAcdCKFGwrbpmNF3bta2cEKZBbUQ+LTuL9xrh78ejp2wM3Fs4Utc/rmSaBySGEfKcrCvT/QUUjbHIMh3uwb8DR3+kBu+ERIqLG4Fj4JsFhPnTcGFIS3lpKw80qOUED7aH67bzeIwpc4hB7ZPR3weT6IsMmYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783166; c=relaxed/simple;
	bh=p/gJWG+6PqK0auJxPdyrRc8yHpb4rOqAqBVZXMrOFDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPcwdAr2t5zhkk/aTsKQuZFkKDYugVx1NTqYLwEhgRJRLnCAtfYzRUu0sPsa7dQ9deP0BHKo/SJohrAoaSqEQuZ7oxAujzakCLmxJb9J5ywFUXsYwfhG/0TA/hLX+qHV/9PhhDozWMfeiMK/KXwFP0/jzFslIqSW5CB6M4InEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVHKDqW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC66DC4CEED;
	Thu, 21 Aug 2025 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755783166;
	bh=p/gJWG+6PqK0auJxPdyrRc8yHpb4rOqAqBVZXMrOFDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVHKDqW1ih8mozy9ZubbAAYWjr9luAj+qE7xf0kt1HM5qJUMYyl1cJh8fWTQ+u3EM
	 EgUnLQsw8QgZO1hOTkuxHxsqPm6AbCT7rly+fFpVAU6/v74+EBqrK4CbcDy+hzhDJA
	 laZ+3akN9Pl72+qrT9UQA3cjpxLrCT+qBt24kc169hxAqtE5XBphMLFelxLhG8ecr4
	 zLDvI/l9zAlYdwcNIAAJsrK8IMLsDfjRLoWXW2cq+/hp9px+X2vPZg6QCW4oDORpxf
	 v5guEZkZgmeSSAoJQmjAmOluxUoQIWRbYikkGqCFzVqAMFSf+Wm3i9lspBy/tyGuQr
	 sa+lkS5F0NbRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] usb: musb: omap2430: Convert to platform remove callback returning void
Date: Thu, 21 Aug 2025 09:32:42 -0400
Message-ID: <20250821133244.715359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082154-deferred-sneak-f740@gregkh>
References: <2025082154-deferred-sneak-f740@gregkh>
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
index 44a21ec865fb..b9ab0c48e2ee 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -471,14 +471,12 @@ static int omap2430_probe(struct platform_device *pdev)
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
@@ -610,7 +608,7 @@ MODULE_DEVICE_TABLE(of, omap2430_id_table);
 
 static struct platform_driver omap2430_driver = {
 	.probe		= omap2430_probe,
-	.remove		= omap2430_remove,
+	.remove_new	= omap2430_remove,
 	.driver		= {
 		.name	= "musb-omap2430",
 		.pm	= DEV_PM_OPS,
-- 
2.50.1


