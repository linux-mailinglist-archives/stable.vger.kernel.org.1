Return-Path: <stable+bounces-172185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB870B2FFC0
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3EC47BEE2B
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3592D2384;
	Thu, 21 Aug 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKp4EUhF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24D269D18
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792880; cv=none; b=LHU2C63zRGXuj+OmqdeBpLuVSKWUdOOfXcD0iGdA9BRwhuoIMPasrWgy7/LeJLTuAahyuO4YIyLqxBdCTr4JKirseKiFAIm7IVYp2j49SdTK5X9Tv23pd+1TMDp2FPeV7U23Yi2RtAu8tINPlyeNTix2mXAmqbcccEfe27Lxjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792880; c=relaxed/simple;
	bh=lzB0JLYPdUHBxOU3eHp0NUkpAsz+injlmBdxVrH3xE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2XKYtT/8cNpAHmSyWU/jczdSxGTgpo7bOSIZliHEwArqb54o1c2kM0rD9RXcURDBChhXu7U+lQSkZDf5SX1rWOWjNRUsndBTMaYgVeQ4lFCgbHNG3enTOF5t5ByMazm6Yj9JSFKiPys1bEADiN57k1DbvVUVnwf0x2Sc3wlcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKp4EUhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DB8C4CEEB;
	Thu, 21 Aug 2025 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755792879;
	bh=lzB0JLYPdUHBxOU3eHp0NUkpAsz+injlmBdxVrH3xE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKp4EUhF+KmvNdyayOxyjaqSKPaqz/iaBfAgRXmu3uKCa0pSEMYr613AzfSC25adB
	 Ekvmq6fi5xg4bwNqj4Z86mG9cSp7powlsrvCau2Iyuh+ssYg3rlzQ2Pb69/4ajQiVv
	 ioFbZ8fLMt4aBYF4VWcSc5+SNHJ7Y7/xBbRv6bPm3C0ZvBmjaxBWtCvHYdGEUQd6CK
	 SyIhnPAbtZFsvxwGt1wEZiWsnaddmZDMduijxWRRLXbtp+u/4RL2k5/g08bO6mBgGd
	 LzIM3vCgstRi1m9Ap8m2EyTEUOOMTX43paYEKSluvS0ZyUB5Kys5cesp5udLFk8T9i
	 KyndDlXsVO4jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Guenter Roeck <groeck@chromium.org>,
	Lee Jones <lee.jones@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] platform/chrome: cros_ec: Make cros_ec_unregister() return void
Date: Thu, 21 Aug 2025 12:14:34 -0400
Message-ID: <20250821161437.775522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082112-segment-delta-e613@gregkh>
References: <2025082112-segment-delta-e613@gregkh>
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
index 5a622666a075..826ca3a4feb8 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -285,13 +285,11 @@ EXPORT_SYMBOL(cros_ec_register);
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
index e69fc1ff68b4..8ed455edbaeb 100644
--- a/drivers/platform/chrome/cros_ec.h
+++ b/drivers/platform/chrome/cros_ec.h
@@ -9,7 +9,7 @@
 #define __CROS_EC_H
 
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
index f9df218fc2bb..2f2c07e8f95a 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -791,7 +791,9 @@ static int cros_ec_spi_remove(struct spi_device *spi)
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


