Return-Path: <stable+bounces-172169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8777BB2FE02
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE5C627111
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106882E040D;
	Thu, 21 Aug 2025 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJpIFvL/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238D28726F
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789001; cv=none; b=U7FI5Ux7+jowuhR09uM1/qmDFZ56QclKQZ66xgwIRVJll6LzN4v6kWqUvYSSpfMKfAa5IdSoHSQd3VsKX2uGgVYeqYJraNWivgF2VCsGHq8hknYV0xXSaQ5Xn7X3CyRCVFAs/aW/MIKfFKm1pGQyGZ6yK2gpU3GE5yxPKxh3cR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789001; c=relaxed/simple;
	bh=7NjPBJGbjwwoX9smE0JtSAqoqLJsPKhLIbAixvyCrRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTtRujjqGWo0M5r3rmjmZtpi4AssRzHxMHey/oz/h39PqPtr/NjiUoVftM9boK5WVyx1BXWd81XTWogD4eqtkZEenfAyurrCljn7w+Zc5Zcu/LvVIJPt8LKG64xEWlqhEFRnIpbzk6D3rV7ExBPueJ90JDCXZUW8sPUDJqcK0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJpIFvL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B5BC4CEED;
	Thu, 21 Aug 2025 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789001;
	bh=7NjPBJGbjwwoX9smE0JtSAqoqLJsPKhLIbAixvyCrRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJpIFvL/xgkaP5hI2HKNUDsZioifeh/PXfRXa1H1E9oBg78cLMLjU0oTGu5G80PUo
	 2+3egUTRECKYcOa1fDWsWVH/+nMmhjr2CI1eSBMKVPc/552jN3Y9xyjd9ZP/THYZcE
	 CzYJx1SOjH1uU+tsM52yeOWm3awE95zvCDxfjUjQkxldftl2E1Hmx8XsytmplZOQQl
	 hqkX05TjxYjaWqZLWaYubmGWIF7Rf0dDE+u0x0s2l+8m2TxWuWHUzIMS5iqcnqLBdq
	 z38bW+mAZ/420LKjBH/FMetabFakccXjpcEbbX/TzXAZ+aIKHFjtppHbAS0TxetBVS
	 gagM+jtB4Wi9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] usb: musb: omap2430: fix device leak at unbind
Date: Thu, 21 Aug 2025 11:09:57 -0400
Message-ID: <20250821150957.756147-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821150957.756147-1-sashal@kernel.org>
References: <2025082154-mutate-utilize-26d0@gregkh>
 <20250821150957.756147-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 1473e9e7679bd4f5a62d1abccae894fb86de280f ]

Make sure to drop the reference to the control device taken by
of_find_device_by_node() during probe when the driver is unbound.

Fixes: 8934d3e4d0e7 ("usb: musb: omap2430: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250724091910.21092-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Removed populate_irqs-related goto changes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/omap2430.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 5f5d9b59ce7e..10ff09680798 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -406,13 +406,13 @@ static int omap2430_probe(struct platform_device *pdev)
 			ARRAY_SIZE(musb_resources));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	pm_runtime_enable(glue->dev);
@@ -427,7 +427,9 @@ static int omap2430_probe(struct platform_device *pdev)
 
 err3:
 	pm_runtime_disable(glue->dev);
-
+err_put_control_otghs:
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 err2:
 	platform_device_put(musb);
 
@@ -441,6 +443,8 @@ static void omap2430_remove(struct platform_device *pdev)
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 }
 
 #ifdef CONFIG_PM
-- 
2.50.1


