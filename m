Return-Path: <stable+bounces-32996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B688E8F9
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1541F32B3E
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345DC12E1CE;
	Wed, 27 Mar 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wSkheWkr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA0280C00
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553016; cv=none; b=Kpd92Rq26r8ZSmH8ApReLfcVmmyFmethbWig55dy+m2TgKOFT9/HQQCJ9c6uE6ptie2doWq5pyH0TmSvbizg4gNZNSYQ1mzfKcENs0MBzRh/Taz91VFscKHgQwiOaikTJEMVyPiFqdrvCiuRrp6aDq8hdD6+1HW9CZem3SDGV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553016; c=relaxed/simple;
	bh=oL3UBZ25mYPBl1ql37GWniNnVLxNJz5jJ1UFnn4hja4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jUPD+E/o+9A2KxBJ3hqz0pZuEVM/0wLL1kH7Wk75r18EIfeu4PNAzR2IgBrSHgPe1XZUmv+ePtsylxCRJIPDqp/E9WdcXqmFmbqFj7oxPn8KxSVhBo3V7U9WJ6Fn/t5sFZ5BqwszsOdj0d1/Sao3kylBAJ6MAcqx99EVY2/EzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wSkheWkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70801C433C7;
	Wed, 27 Mar 2024 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711553015;
	bh=oL3UBZ25mYPBl1ql37GWniNnVLxNJz5jJ1UFnn4hja4=;
	h=Subject:To:Cc:From:Date:From;
	b=wSkheWkrjeNcuVXl1cqj4yS2J0eBWpwtRj29RmjcGuTzy0ju8LsKWVTO8ua1rEA4q
	 s+CMt6i5MIrkN4z+HosHVEPJ0vHXWC8t5srCz0Suj1niQIQTEU17/Iog8vKJVRaPk/
	 pLggMi8oxloqqLFDh+LtImv5G8c3FrCumFGShQJE=
Subject: FAILED: patch "[PATCH] i2c: i801: Avoid potential double call to" failed to apply to 5.10-stable tree
To: hkallweit1@gmail.com,andi.shyti@kernel.org,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:23:32 +0100
Message-ID: <2024032732-luckiness-repackage-f6f8@gregkh>
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
git cherry-pick -x ceb013b2d9a2946035de5e1827624edc85ae9484
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032732-luckiness-repackage-f6f8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

ceb013b2d9a2 ("i2c: i801: Avoid potential double call to gpiod_remove_lookup_table")
5581b4167c0f ("i2c: i801: Refactor mux code since platform_device_unregister() is NULL aware")
926e6b2cd1ca ("i2c: i801: Drop duplicate NULL check in i801_del_mux()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ceb013b2d9a2946035de5e1827624edc85ae9484 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon, 4 Mar 2024 21:31:06 +0100
Subject: [PATCH] i2c: i801: Avoid potential double call to
 gpiod_remove_lookup_table

If registering the platform device fails, the lookup table is
removed in the error path. On module removal we would try to
remove the lookup table again. Fix this by setting priv->lookup
only if registering the platform device was successful.
In addition free the memory allocated for the lookup table in
the error path.

Fixes: d308dfbf62ef ("i2c: mux/i801: Switch to use descriptor passing")
Cc: stable@vger.kernel.org
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 9a0a77383ca8..274e987e4cfa 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1416,7 +1416,6 @@ static void i801_add_mux(struct i801_priv *priv)
 		lookup->table[i] = GPIO_LOOKUP(mux_config->gpio_chip,
 					       mux_config->gpios[i], "mux", 0);
 	gpiod_add_lookup_table(lookup);
-	priv->lookup = lookup;
 
 	/*
 	 * Register the mux device, we use PLATFORM_DEVID_NONE here
@@ -1430,7 +1429,10 @@ static void i801_add_mux(struct i801_priv *priv)
 				sizeof(struct i2c_mux_gpio_platform_data));
 	if (IS_ERR(priv->mux_pdev)) {
 		gpiod_remove_lookup_table(lookup);
+		devm_kfree(dev, lookup);
 		dev_err(dev, "Failed to register i2c-mux-gpio device\n");
+	} else {
+		priv->lookup = lookup;
 	}
 }
 


