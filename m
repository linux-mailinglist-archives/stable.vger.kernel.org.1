Return-Path: <stable+bounces-164579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99461B105A1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A53C7AB396
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CEB274B2F;
	Thu, 24 Jul 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIx00lE9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884B259CBA;
	Thu, 24 Jul 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348771; cv=none; b=oMHjHxHp3mF2PYcs/Wnr0hcKoUdxiZ9GHWuquD+2029HPBZyMcyi864a82MKqxiOsuM5C+3N+63Fg7jW0tKVOGf7ZBjJOHhUj/E887Eqh3EF8DYTK4R3icdxG1+p/BjSBkKiytCtoxlmp/Xf27LjpI4lwaZ16JDGPdI3ut4/Ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348771; c=relaxed/simple;
	bh=heZubNRf2SjBNIuw2Atw10HonqmFi54G/HKy4mFRFIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCs+S8MlgG17l9zqUIsiwQ7e0JlncJaTj5HIx9teG2nP5mnay6CLMYrYBeA7LUtjB3ZaqheROkWCgrcNKz5ydf2MI8rZiBQn1Q8VDEvQ23w3WfDw1nwSso3WmltRHd6vyiq0ArfNHtTe/DWyOFL2NF71sEnznrshXcaYIdV6+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIx00lE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15A2C4CEFA;
	Thu, 24 Jul 2025 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753348771;
	bh=heZubNRf2SjBNIuw2Atw10HonqmFi54G/HKy4mFRFIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIx00lE9oSnUaRBc7WEcZvhZSzTfjC3CH99QmbfDDQLZoKxZjJ/qfAMtf8d2lyriV
	 n/te2CxDcO9q58DUXBsSXmtbkK4su6+Wa1PZ2MjuL7pOvlEpzkoGMkpQQ2+KsjYitx
	 H09hPPDKUxo1D9gjUjs9XpNYqL/W+YmHVH8XVTjTktO8NGQIxFCVU0sYSFFg/bUxVH
	 Y/qiOt+UmHGiADEvZDiLYuUrBYukCAScTEnWxRNQREYghINN4B+5Em/jMVLi7FLLcv
	 O9d5zoOCTja7kwkdFwcwCzm0oH7MDrbGAgsWSTurKxFtByi5vxJ0mbc3bF+CDjKfRT
	 NNgUwLsG+Cf5w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ues6n-000000005V1-3sbp;
	Thu, 24 Jul 2025 11:19:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Bin Liu <b-liu@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 4/5] usb: musb: omap2430: fix device leak at unbind
Date: Thu, 24 Jul 2025 11:19:09 +0200
Message-ID: <20250724091910.21092-5-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250724091910.21092-1-johan@kernel.org>
References: <20250724091910.21092-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference to the control device taken by
of_find_device_by_node() during probe when the driver is unbound.

Fixes: 8934d3e4d0e7 ("usb: musb: omap2430: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/musb/omap2430.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 2970967a4fd2..36f756f9b7f6 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -400,7 +400,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	if (populate_irqs) {
@@ -413,7 +413,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!res) {
 			ret = -EINVAL;
-			goto err2;
+			goto err_put_control_otghs;
 		}
 
 		musb_res[i].start = res->start;
@@ -441,14 +441,14 @@ static int omap2430_probe(struct platform_device *pdev)
 		ret = platform_device_add_resources(musb, musb_res, i);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to add IRQ resources\n");
-			goto err2;
+			goto err_put_control_otghs;
 		}
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	pm_runtime_enable(glue->dev);
@@ -463,7 +463,9 @@ static int omap2430_probe(struct platform_device *pdev)
 
 err3:
 	pm_runtime_disable(glue->dev);
-
+err_put_control_otghs:
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 err2:
 	platform_device_put(musb);
 
@@ -477,6 +479,8 @@ static void omap2430_remove(struct platform_device *pdev)
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 }
 
 #ifdef CONFIG_PM
-- 
2.49.1


