Return-Path: <stable+bounces-62375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76193EEE8
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2B81C21AAF
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB1D126F2A;
	Mon, 29 Jul 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XXsV0q4Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084484A2F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239286; cv=none; b=J9amoP4BMD25BX8Eh86Pa9tSuJ5eHAbZDpho3P/PDMkruVcAhfqkyKePVUteq1OSTVQG+oxvYnrCuxCgCZopl15nZiWZ2cvx7uSZVRAychr2OZfdAlm5W7KHQGDDNQ9ex8ZcmXonsziS2LW4I6ImZHObz51xeCT9ikMEW6sogyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239286; c=relaxed/simple;
	bh=EhaNaHqsjVS22qWPEqZB3fXiAnfJnWKtyCRYSCKbwtw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dd48t9f/4HESy2bQsblRV2jUCjbj9BUUHdXq1srVP1bKPyUcFrkjBOtZ1ER48fOTSbXFTGDDSiCSCBtEzD29qcaZ0CpqG5FlWZ0xm3u6tp+o/Bt6JQHKnKfgytQB67c27XbGyTXoJxZKkDgVmSy1X1XH+H46MHjkkpFNI3iOfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XXsV0q4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AE2C32786;
	Mon, 29 Jul 2024 07:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239285;
	bh=EhaNaHqsjVS22qWPEqZB3fXiAnfJnWKtyCRYSCKbwtw=;
	h=Subject:To:Cc:From:Date:From;
	b=XXsV0q4YHRtIwarG8KdM6KzQzy2Xuiz3HmmzBpM6P54L4gLNJ30w9G3Y6IcTMpG3V
	 LKcWX3jeHGasKrxQZZNx3i5MqaIGqkOSQ2wXd7owsMtJSEPKbDitLdYt24ukylrfdp
	 g6AgswGUE5iqq1J+UBSCiv06CvNtHffCaLsR/5Z8=
Subject: FAILED: patch "[PATCH] thermal/drivers/broadcom: Fix race between removal and clock" failed to apply to 6.6-stable tree
To: krzysztof.kozlowski@linaro.org,daniel.lezcano@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:48:02 +0200
Message-ID: <2024072901-rare-engaging-abb3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e90c369cc2ffcf7145a46448de101f715a1f5584
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072901-rare-engaging-abb3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e90c369cc2ff ("thermal/drivers/broadcom: Fix race between removal and clock disable")
f29ecd3748a2 ("thermal: bcm2835: Convert to platform remove callback returning void")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e90c369cc2ffcf7145a46448de101f715a1f5584 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 9 Jul 2024 14:59:31 +0200
Subject: [PATCH] thermal/drivers/broadcom: Fix race between removal and clock
 disable

During the probe, driver enables clocks necessary to access registers
(in get_temp()) and then registers thermal zone with managed-resources
(devm) interface.  Removal of device is not done in reversed order,
because:
1. Clock will be disabled in driver remove() callback - thermal zone is
   still registered and accessible to users,
2. devm interface will unregister thermal zone.

This leaves short window between (1) and (2) for accessing the
get_temp() callback with disabled clock.

Fix this by enabling clock also via devm-interface, so entire cleanup
path will be in proper, reversed order.

Fixes: 8454c8c09c77 ("thermal/drivers/bcm2835: Remove buggy call to thermal_of_zone_unregister")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240709-thermal-probe-v1-1-241644e2b6e0@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 5c1cebe07580..3b1030fc4fbf 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -185,7 +185,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	data->clk = devm_clk_get(&pdev->dev, NULL);
+	data->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(data->clk)) {
 		err = PTR_ERR(data->clk);
 		if (err != -EPROBE_DEFER)
@@ -193,10 +193,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = clk_prepare_enable(data->clk);
-	if (err)
-		return err;
-
 	rate = clk_get_rate(data->clk);
 	if ((rate < 1920000) || (rate > 5000000))
 		dev_warn(&pdev->dev,
@@ -211,7 +207,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Failed to register the thermal device: %d\n",
 			err);
-		goto err_clk;
+		return err;
 	}
 
 	/*
@@ -236,7 +232,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Not able to read trip_temp: %d\n",
 				err);
-			goto err_tz;
+			return err;
 		}
 
 		/* set bandgap reference voltage and enable voltage regulator */
@@ -269,17 +265,11 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	 */
 	err = thermal_add_hwmon_sysfs(tz);
 	if (err)
-		goto err_tz;
+		return err;
 
 	bcm2835_thermal_debugfs(pdev);
 
 	return 0;
-err_tz:
-	devm_thermal_of_zone_unregister(&pdev->dev, tz);
-err_clk:
-	clk_disable_unprepare(data->clk);
-
-	return err;
 }
 
 static void bcm2835_thermal_remove(struct platform_device *pdev)
@@ -287,7 +277,6 @@ static void bcm2835_thermal_remove(struct platform_device *pdev)
 	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(data->debugfsdir);
-	clk_disable_unprepare(data->clk);
 }
 
 static struct platform_driver bcm2835_thermal_driver = {


