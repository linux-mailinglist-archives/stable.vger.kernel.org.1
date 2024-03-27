Return-Path: <stable+bounces-32997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA3288E8FA
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4B41F32B5F
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B25C12EBCF;
	Wed, 27 Mar 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RfifqHaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89A12D774
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553020; cv=none; b=A13T8CGRm4j99uGbAFaLp4eRLFS7cDk8VHp/JiB4zUO/CIlQNr3BOrH35W+Q31LX1uNX3o44cevmT2/szBnHcqZmhNZOTR6Mt8vekVn40AdglSLZX4ahHgmuRt8QrAeh2kHi6DTJiWaxu/6faFqHbNy3S1AAkAKGwtf0xQvlMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553020; c=relaxed/simple;
	bh=fx1IoSVlDAXmgcZS2DF/li8u1F/GuDk94jEXcdRWj8A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JDDtqtfD4AomOyon7Btk7Bgli91g4H8CsI0idzF3XP+EinPH1lZct5LonMiyIlO6xk/TMEugQKav5GcOF9hC6YKacS9/wKa12vTjJuYoE2SaVx4tsmAkf5Wehgb6IAbUQwd2Q5vGXG2R6MH4gv7WLhaN4tODRBM1ZUz67DToGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RfifqHaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D30C433F1;
	Wed, 27 Mar 2024 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711553019;
	bh=fx1IoSVlDAXmgcZS2DF/li8u1F/GuDk94jEXcdRWj8A=;
	h=Subject:To:Cc:From:Date:From;
	b=RfifqHaNA41Caz0hIMkCj5kRb6QkbKh5c3ryPbAOowQuyadtY+THjmK15tawPspJ/
	 kByoICmObMRLCEmpLhaKKYk17DDvJKuTkkFDqppQnAe24GVtqKoYj4807t/3DBNoMT
	 ox2rriBWdB0nGmQhTOTQJB42aru5EhIRWIv9vInM=
Subject: FAILED: patch "[PATCH] i2c: i801: Avoid potential double call to" failed to apply to 5.4-stable tree
To: hkallweit1@gmail.com,andi.shyti@kernel.org,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:23:36 +0100
Message-ID: <2024032735-angling-payback-8e99@gregkh>
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
git cherry-pick -x ceb013b2d9a2946035de5e1827624edc85ae9484
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032735-angling-payback-8e99@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


