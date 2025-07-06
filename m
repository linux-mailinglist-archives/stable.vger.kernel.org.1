Return-Path: <stable+bounces-160307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ED7AFA4F7
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63548189F2A3
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B220A5F2;
	Sun,  6 Jul 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s3yJ2MSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196CC17BCE
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802693; cv=none; b=JX7BYWDumDoCurCncBe/tEIxK7uZ/ShUo/UuUW4RuWF1i51ycb0iui1Wbcyu2fM5MfkxXy7MuxGEltA9Fzsktujg2XG4j3aHkp+ILzQ5bMxXIiGgW4ki/hMz/qeX1ftVY+C6qBZSQqHdlxT4NrDsLoUlcWeCzzGl2Kq/Yz9vWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802693; c=relaxed/simple;
	bh=yI5/UBfFA4yP3ljCc1P7Wcf6ka5UHWXSpVZhEcANG38=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TYGITCnqqQqpAjlPtUNsUVLZdc2HqH6oy1C1wwlOTibqNkCfREhGlhETGPzh8ZKULCgCClweGbyNkkPoqeCECYfCfkXVdwKk2LxVHcTYh3oabgeTEOExXKxOrIxxsoy2/6HLHjKbHXGBSzQlfUyzunsC0TetVScs0TeW3p3SYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s3yJ2MSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CB6C4CEED;
	Sun,  6 Jul 2025 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802693;
	bh=yI5/UBfFA4yP3ljCc1P7Wcf6ka5UHWXSpVZhEcANG38=;
	h=Subject:To:Cc:From:Date:From;
	b=s3yJ2MShsZug3q3uQZYWo2xwL3UmrHoAWwxNSyHXceCyA2tZQBC4GxleKxHBZBPPk
	 MXNKTeIv7f+6L9nAgw88Bz2FpWwmNH1CT2rBxgZwZahM7GAygelAlT4WqbiKCjHtaa
	 p2VFEN1H7IcRogW5o6uNrxXZhNUXWFuAD/GHPIHY=
Subject: FAILED: patch "[PATCH] regulator: gpio: Fix the out-of-bounds access to" failed to apply to 5.4-stable tree
To: mani@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:51:20 +0200
Message-ID: <2025070620-snippet-reunite-9081@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x c9764fd88bc744592b0604ccb6b6fc1a5f76b4e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070620-snippet-reunite-9081@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


