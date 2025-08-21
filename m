Return-Path: <stable+bounces-172164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE52B2FDF8
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EF517BE50
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E581281378;
	Thu, 21 Aug 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soM5dGFA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0F275B06
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788928; cv=none; b=hKFLTHIteGq/IwLzps0rVCqnCBDo1xuZ0BFI6RMAJnVyYj7OW/uwfOcavQSxa6bRRJQIA9fIf7Xo8J2eIpmFeXObYJdKsk5PIig7OrlMQ+KDAzYzq59jeBTh6NXjUcXzmL7pEG6PQkR3eh/TXwXoSyt1ZFPE73qBAOy2uwrKAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788928; c=relaxed/simple;
	bh=HtloGYaeytyDJkCzYUkjkt7Pocffe/qKzi16/tE/PiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kP6rD3bhcGXsjt5vcCIXmFUVwg4vodcSL/mIy6JP10Ja7sJQYo4tL6f3Ai9UOKYae+jMduOQhPHsKIW1jit207czWuXBv+1yY6Kii2eLOqZySyfLuzwsijE8ryf4qIhcwB0TiTaXtd6GGImBg0YbADw0MQThLA4LVS/GNVitjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soM5dGFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0670C4CEEB;
	Thu, 21 Aug 2025 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788928;
	bh=HtloGYaeytyDJkCzYUkjkt7Pocffe/qKzi16/tE/PiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=soM5dGFA5O389J5+tzWuE0pJuGXi2GZEJYaNVVWHh6+sfVUP2RVV9fmOnWoWtinM8
	 wImUHTgqEUqIHCRjAM0OVj1wdpMFWRycfp0xXJiwIdwtZNxccAE7BbIMHi1hSJ5Ckt
	 fGfAEz08345/UIL3Ey1jlV4k/4eHNU07nqiUizv4g8+Y9FR3F6g7d0WKvJblsL8pDP
	 k9+dHMpZdt5Xcp1jQAmojYPRVVqOB4w6BeBKrMr8ro9ZxH0slvF7gDLUm09dAWT2Qf
	 SOK73bJsm7s6xcp5kZvkVQfdo3uPxRUWCm9WpRAJtabXoS6AEwVwz48pdY4i3AzIeZ
	 40+swzgwJD1nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Guenter Roeck <groeck@chromium.org>,
	Lee Jones <lee.jones@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] platform/chrome: cros_ec: Make cros_ec_unregister() return void
Date: Thu, 21 Aug 2025 11:08:41 -0400
Message-ID: <20250821150844.754065-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082112-freight-pesticide-c276@gregkh>
References: <2025082112-freight-pesticide-c276@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit afb0a80e63d67e957b5d0eb4ade301aff6e13c8c ]

Up to now cros_ec_unregister() returns zero unconditionally. Make it
return void instead which makes it easier to see in the callers that
there is no error to handle.

Also the return value of i2c, platform and spi remove callbacks is
ignored anyway.

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Link: https://lore.kernel.org/r/20211020071753.wltjslmimb6wtlp5@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Lee Jones <lee.jones@linaro.org>
Link: https://lore.kernel.org/r/20220123175201.34839-5-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: e23749534619 ("platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec.c     | 4 +---
 drivers/platform/chrome/cros_ec.h     | 2 +-
 drivers/platform/chrome/cros_ec_i2c.c | 4 +++-
 drivers/platform/chrome/cros_ec_lpc.c | 4 +++-
 drivers/platform/chrome/cros_ec_spi.c | 4 +++-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 9664e13ded59..ea2296104634 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -306,13 +306,11 @@ EXPORT_SYMBOL(cros_ec_register);
  *
  * Return: 0 on success or negative error code.
  */
-int cros_ec_unregister(struct cros_ec_device *ec_dev)
+void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
 	if (ec_dev->pd)
 		platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
-
-	return 0;
 }
 EXPORT_SYMBOL(cros_ec_unregister);
 
diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/cros_ec.h
index 78363dcfdf23..bbca0096868a 100644
--- a/drivers/platform/chrome/cros_ec.h
+++ b/drivers/platform/chrome/cros_ec.h
@@ -11,7 +11,7 @@
 #include <linux/interrupt.h>
 
 int cros_ec_register(struct cros_ec_device *ec_dev);
-int cros_ec_unregister(struct cros_ec_device *ec_dev);
+void cros_ec_unregister(struct cros_ec_device *ec_dev);
 
 int cros_ec_suspend(struct cros_ec_device *ec_dev);
 int cros_ec_resume(struct cros_ec_device *ec_dev);
diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 30c8938c27d5..22feb0fd4ce7 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -313,7 +313,9 @@ static int cros_ec_i2c_remove(struct i2c_client *client)
 {
 	struct cros_ec_device *ec_dev = i2c_get_clientdata(client);
 
-	return cros_ec_unregister(ec_dev);
+	cros_ec_unregister(ec_dev);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 1f7861944044..8527a1bac765 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -439,7 +439,9 @@ static int cros_ec_lpc_remove(struct platform_device *pdev)
 		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   cros_ec_lpc_acpi_notify);
 
-	return cros_ec_unregister(ec_dev);
+	cros_ec_unregister(ec_dev);
+
+	return 0;
 }
 
 static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] = {
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 14c4046fa04d..713c58687721 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -790,7 +790,9 @@ static int cros_ec_spi_remove(struct spi_device *spi)
 {
 	struct cros_ec_device *ec_dev = spi_get_drvdata(spi);
 
-	return cros_ec_unregister(ec_dev);
+	cros_ec_unregister(ec_dev);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.50.1


