Return-Path: <stable+bounces-41674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D668B56E2
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0A41F26112
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BC9481A8;
	Mon, 29 Apr 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z7b/pKDm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC9644C87
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390561; cv=none; b=MLM2CYeSz5O3LJNzripgDxJyy5lcV/YOrCc4GETjf0//qdbLZa+KM/razt7NbPO0bxwKJxQtQaIKISkn7foeDFLsypIE74CQeqpu0Wa2SgRY5qUbSy3QrFYOKi++ewe6erxcKx4AKF9epdGcaahlqpGR1zXdobGWXp/9FBpnGK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390561; c=relaxed/simple;
	bh=mMcPr8SR4QsAeYYxAjWAbSctOInLUa5SCsZhIFARAPA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YKunCYU0YTwdmpR2bbIh2SbbobV3jgsVyDI8t8eqn0V+f74KOjuwWquMzPPtnp7G/rcnQG3qyDnJ1KEyOi1FECUTLj3BzK5Iutwc7Y9nQJpKOXO2Bhj8zgxpNKDFUkfSwG9PiFdXgtjxobhsL0YR1Fac/9DlCst14NjWc4z3wR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z7b/pKDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134E5C113CD;
	Mon, 29 Apr 2024 11:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714390561;
	bh=mMcPr8SR4QsAeYYxAjWAbSctOInLUa5SCsZhIFARAPA=;
	h=Subject:To:Cc:From:Date:From;
	b=z7b/pKDmNHL324zbGzXclNuwKqy6zI/IyfdLP8WI+2qwgzC6dlMhey1FM8LscNViE
	 KKu9QAaOeDcp0NGsxveAbLe0MQRuRkZhK+9TGT+ExjlBRQjUcVYi2YwZ1uay6YiN7D
	 lxjF4gEWEKF0irNKx0ajVnLgQxWi+GYuXjL7FMOY=
Subject: FAILED: patch "[PATCH] eeprom: at24: fix memory corruption race condition" failed to apply to 5.10-stable tree
To: dtokazaki@google.com,bartosz.golaszewski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:35:43 +0200
Message-ID: <2024042942-headboard-dweeb-a026@gregkh>
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
git cherry-pick -x f42c97027fb75776e2e9358d16bf4a99aeb04cf2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042942-headboard-dweeb-a026@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

f42c97027fb7 ("eeprom: at24: fix memory corruption race condition")
caba40ec3531 ("eeprom: at24: Probe for DDR3 thermal sensor in the SPD case")
a3c10035d12f ("eeprom: at24: Use dev_err_probe for nvmem register failure")
2962484dfef8 ("misc: eeprom: at24: check suspend status before disable regulator")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f42c97027fb75776e2e9358d16bf4a99aeb04cf2 Mon Sep 17 00:00:00 2001
From: Daniel Okazaki <dtokazaki@google.com>
Date: Mon, 22 Apr 2024 17:43:36 +0000
Subject: [PATCH] eeprom: at24: fix memory corruption race condition

If the eeprom is not accessible, an nvmem device will be registered, the
read will fail, and the device will be torn down. If another driver
accesses the nvmem device after the teardown, it will reference
invalid memory.

Move the failure point before registering the nvmem device.

Signed-off-by: Daniel Okazaki <dtokazaki@google.com>
Fixes: b20eb4c1f026 ("eeprom: at24: drop unnecessary label")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240422174337.2487142-1-dtokazaki@google.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 572333ead5fb..4bd4f32bcdab 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -758,15 +758,6 @@ static int at24_probe(struct i2c_client *client)
 	}
 	pm_runtime_enable(dev);
 
-	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
-	if (IS_ERR(at24->nvmem)) {
-		pm_runtime_disable(dev);
-		if (!pm_runtime_status_suspended(dev))
-			regulator_disable(at24->vcc_reg);
-		return dev_err_probe(dev, PTR_ERR(at24->nvmem),
-				     "failed to register nvmem\n");
-	}
-
 	/*
 	 * Perform a one-byte test read to verify that the chip is functional,
 	 * unless powering on the device is to be avoided during probe (i.e.
@@ -782,6 +773,15 @@ static int at24_probe(struct i2c_client *client)
 		}
 	}
 
+	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
+	if (IS_ERR(at24->nvmem)) {
+		pm_runtime_disable(dev);
+		if (!pm_runtime_status_suspended(dev))
+			regulator_disable(at24->vcc_reg);
+		return dev_err_probe(dev, PTR_ERR(at24->nvmem),
+				     "failed to register nvmem\n");
+	}
+
 	/* If this a SPD EEPROM, probe for DDR3 thermal sensor */
 	if (cdata == &at24_data_spd)
 		at24_probe_temp_sensor(client);


