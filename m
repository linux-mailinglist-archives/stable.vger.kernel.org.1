Return-Path: <stable+bounces-160305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E64BAFA4F5
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88A517E927
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3251E8345;
	Sun,  6 Jul 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2YVEMur"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26814A0A8
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802682; cv=none; b=HpgfzYauUSxbbaGvX+IEzJJOcLwo7BN1j9gmYOWpTEtFMu4v1wQoC4U/H2UnZBHu5ynUbRhGdx4WRkp/3TOd4Im+RjnJTLbrM/LO/KGAwZUopw3HEb46+54/DQRrhpeF7d7blmHwfRUQ3g8O+4NWaZVc46bam77NIVVCAdFAC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802682; c=relaxed/simple;
	bh=cOM3xxYL5Ok0bGXyP08pWrCrSOwHBej5i0OPmjwyW7g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PD7cEjiO2gxxWX1tB+ba3d1j51H/2qb6Z/QvZlNtqJALnVXsgKDeqxG97SE7K3NwfftfPN1Wk0wdUzQ9ym6c3stKDdv9EXFT1sCIv8dhCICDIrXg0QX9pP5RGyrXSlhnHaXKW97ICxEy6rcAVUCOQxwIHoKjn+4vGc2+NxbyrBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2YVEMur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8559BC4CEED;
	Sun,  6 Jul 2025 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802682;
	bh=cOM3xxYL5Ok0bGXyP08pWrCrSOwHBej5i0OPmjwyW7g=;
	h=Subject:To:Cc:From:Date:From;
	b=N2YVEMurObV1vsrKAb6bmhGLru8SSCVw4n6ahKeaPzc8GzhaAWL9Se3IyV+0gTX45
	 +5azUeboBiz0XtOrHmJadX2at06OVH+wiVm+ONoTiEkuERND5hdNkUxMASQGfA6tJQ
	 2w4sjfkq0ESB3BI4wNMTVAmelfIZMDgvATa2sH8Y=
Subject: FAILED: patch "[PATCH] regulator: gpio: Fix the out-of-bounds access to" failed to apply to 5.15-stable tree
To: mani@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:51:19 +0200
Message-ID: <2025070619-marauding-shivering-f78b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c9764fd88bc744592b0604ccb6b6fc1a5f76b4e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070619-marauding-shivering-f78b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9764fd88bc744592b0604ccb6b6fc1a5f76b4e3 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Thu, 3 Jul 2025 16:05:49 +0530
Subject: [PATCH] regulator: gpio: Fix the out-of-bounds access to
 drvdata::gpiods

drvdata::gpiods is supposed to hold an array of 'gpio_desc' pointers. But
the memory is allocated for only one pointer. This will lead to
out-of-bounds access later in the code if 'config::ngpios' is > 1. So
fix the code to allocate enough memory to hold 'config::ngpios' of GPIO
descriptors.

While at it, also move the check for memory allocation failure to be below
the allocation to make it more readable.

Cc: stable@vger.kernel.org # 5.0
Fixes: d6cd33ad7102 ("regulator: gpio: Convert to use descriptors")
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20250703103549.16558-1-mani@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 75bd53445ba7..6351ceefdb3e 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -260,8 +260,10 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	drvdata->gpiods = devm_kzalloc(dev, sizeof(struct gpio_desc *),
-				       GFP_KERNEL);
+	drvdata->gpiods = devm_kcalloc(dev, config->ngpios,
+				       sizeof(struct gpio_desc *), GFP_KERNEL);
+	if (!drvdata->gpiods)
+		return -ENOMEM;
 
 	if (config->input_supply) {
 		drvdata->desc.supply_name = devm_kstrdup(&pdev->dev,
@@ -274,8 +276,6 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (!drvdata->gpiods)
-		return -ENOMEM;
 	for (i = 0; i < config->ngpios; i++) {
 		drvdata->gpiods[i] = devm_gpiod_get_index(dev,
 							  NULL,


