Return-Path: <stable+bounces-160306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B099FAFA4F6
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC70189F195
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F271FDA9E;
	Sun,  6 Jul 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYbABwF6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0C14A0A8
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802690; cv=none; b=rqy/BYgxQ12QFeUTP30/Ors0pfY/+rtT7Flp43kAGzt2d8A0Tgaxn3RRpJjsPoILiN8mfWHPm0SoyA98VXiGE1krJNqiOIC4VdN/GbOQeV2kMQGMkfx3Y2J+tXXp9AJX4ke0GlcuEv+QpXt15bQNdAniL2vLx4+fmYzEHiXxGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802690; c=relaxed/simple;
	bh=+ESH98rtdw9q4WYjljUsOJkao+2vI5ex5yLAu9JM00w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FVSZF1A6aUUfPiFDqf/cyxGCQ/jlo9r/hD3LDvNUi5Xc3oyyU7PBMBMuG4iPdrKdGc5aLBe0XD1f3uTMJ8DiogDBeEzJMgoML3wVh63UefIiXtHrLxUJIfIEIfPkOeZdURSbMqam09Mni9ndrzcEqbJdiZMjLcciS7kua2TDOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYbABwF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2667C4CEED;
	Sun,  6 Jul 2025 11:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802690;
	bh=+ESH98rtdw9q4WYjljUsOJkao+2vI5ex5yLAu9JM00w=;
	h=Subject:To:Cc:From:Date:From;
	b=JYbABwF6fKsVqd0/cQF+D3IeOvXw7dQRWHLWTtv1bgiyr/gfGSMmzAwvqHBliPvTW
	 2kugQPClbqnXqJu2YsRXJMFwB/YzjuX99Afpv53z7/l/5NZ2OItnleI0FIglY4sYhe
	 uLy1hW1HYXabHfCOHqeJdpVh4g+w3hrmCS2sH4Kg=
Subject: FAILED: patch "[PATCH] regulator: gpio: Fix the out-of-bounds access to" failed to apply to 5.10-stable tree
To: mani@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:51:19 +0200
Message-ID: <2025070619-hexagon-plow-24d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c9764fd88bc744592b0604ccb6b6fc1a5f76b4e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070619-hexagon-plow-24d5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


