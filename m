Return-Path: <stable+bounces-164041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC8B0DCE6
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31006167629
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCD328B7EA;
	Tue, 22 Jul 2025 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qh+VZBpf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD12C9A;
	Tue, 22 Jul 2025 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193055; cv=none; b=Zsu3XqeI4GNbjN/HCjOgJKzc8xFQv6+XY6vn+bcTYKLb5XVUWK/0870nO04a7eh+ZiIZ4lnQ+gBpCpeo5BuOYswpSj6dR3Ok1oBcqR2k3bRt7PRcRfqRz9VVwe1tyybL3lEtPBPEbO2K877uo2ag/h/qbl8r2sWRGSwhaDt6O1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193055; c=relaxed/simple;
	bh=28a6Unym1sm4zdQ/l6nQAY+F2GG8N4Q9HIkoR7aVffY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epX5tHymGRTYHfpMJjC926xZlz35TQPAJQB/K1vypG5ekAnDg0HXxya/zHxtoHh1hJMgxBdJZaKaWasTqgezdccFyu03C9HzeXe6CeCn2WnF+YsY1bKL26MfIHF+LpotBHvxg32cg64mUT0qUYdzZXpHLxxVAeB5YvVRjoPwItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qh+VZBpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558BAC4CEF5;
	Tue, 22 Jul 2025 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193054;
	bh=28a6Unym1sm4zdQ/l6nQAY+F2GG8N4Q9HIkoR7aVffY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qh+VZBpfu9C24oNEYcfM9ke6L+t0O51x8e1Iq73MzfRMlsrpNgyxh7ZJU60U2lVFF
	 q3yjBzPochlfcLUir6rxyq3epoPzFstRUKKfRIABqMKwLrOTse2wJumO103xeEkra9
	 PWeak992hnGATMRCqbvw8oGcv3CiK2B4O0GaYCiU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brett Werling <brett.werling@garmin.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 104/158] can: tcan4x5x: fix reset gpio usage during probe
Date: Tue, 22 Jul 2025 15:44:48 +0200
Message-ID: <20250722134344.625032471@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brett Werling <brett.werling@garmin.com>

[ Upstream commit 0f97a7588db7a545ea07ee0d512789bfad4931d8 ]

Fixes reset GPIO usage during probe by ensuring we retrieve the GPIO and
take the device out of reset (if it defaults to being in reset) before
we attempt to communicate with the device. This is achieved by moving
the call to tcan4x5x_get_gpios() before tcan4x5x_find_version() and
avoiding any device communication while getting the GPIOs. Once we
determine the version, we can then take the knowledge of which GPIOs we
obtained and use it to decide whether we need to disable the wake or
state pin functions within the device.

This change is necessary in a situation where the reset GPIO is pulled
high externally before the CPU takes control of it, meaning we need to
explicitly bring the device out of reset before we can start
communicating with it at all.

This also has the effect of fixing an issue where a reset of the device
would occur after having called tcan4x5x_disable_wake(), making the
original behavior not actually disable the wake. This patch should now
disable wake or state pin functions well after the reset occurs.

Signed-off-by: Brett Werling <brett.werling@garmin.com>
Link: https://patch.msgid.link/20250711141728.1826073-1-brett.werling@garmin.com
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Fixes: 142c6dc6d9d7 ("can: tcan4x5x: Add support for tcan4552/4553")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 61 ++++++++++++++++++---------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 7062a2939f501..e8995738cf996 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -335,21 +335,19 @@ static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
 		of_property_read_bool(cdev->dev->of_node, "ti,nwkrq-voltage-vio");
 }
 
-static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
-			      const struct tcan4x5x_version_info *version_info)
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
 	int ret;
 
-	if (version_info->has_wake_pin) {
-		tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
-							    GPIOD_OUT_HIGH);
-		if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-			if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
+	tcan4x5x->device_wake_gpio = devm_gpiod_get_optional(cdev->dev,
+							     "device-wake",
+							     GPIOD_OUT_HIGH);
+	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
+		if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 
-			tcan4x5x_disable_wake(cdev);
-		}
+		tcan4x5x->device_wake_gpio = NULL;
 	}
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
@@ -361,14 +359,31 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 	if (ret)
 		return ret;
 
-	if (version_info->has_state_pin) {
-		tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
-								      "device-state",
-								      GPIOD_IN);
-		if (IS_ERR(tcan4x5x->device_state_gpio)) {
-			tcan4x5x->device_state_gpio = NULL;
-			tcan4x5x_disable_state(cdev);
-		}
+	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
+							      "device-state",
+							      GPIOD_IN);
+	if (IS_ERR(tcan4x5x->device_state_gpio))
+		tcan4x5x->device_state_gpio = NULL;
+
+	return 0;
+}
+
+static int tcan4x5x_check_gpios(struct m_can_classdev *cdev,
+				const struct tcan4x5x_version_info *version_info)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
+	int ret;
+
+	if (version_info->has_wake_pin && !tcan4x5x->device_wake_gpio) {
+		ret = tcan4x5x_disable_wake(cdev);
+		if (ret)
+			return ret;
+	}
+
+	if (version_info->has_state_pin && !tcan4x5x->device_state_gpio) {
+		ret = tcan4x5x_disable_state(cdev);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -459,15 +474,21 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_m_can_class_free_dev;
 	}
 
+	ret = tcan4x5x_get_gpios(mcan_class);
+	if (ret) {
+		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
+		goto out_power;
+	}
+
 	version_info = tcan4x5x_find_version(priv);
 	if (IS_ERR(version_info)) {
 		ret = PTR_ERR(version_info);
 		goto out_power;
 	}
 
-	ret = tcan4x5x_get_gpios(mcan_class, version_info);
+	ret = tcan4x5x_check_gpios(mcan_class, version_info);
 	if (ret) {
-		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
+		dev_err(&spi->dev, "Checking gpios failed %pe\n", ERR_PTR(ret));
 		goto out_power;
 	}
 
-- 
2.39.5




