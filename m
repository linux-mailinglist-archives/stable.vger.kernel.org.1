Return-Path: <stable+bounces-163375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602E1B0A5E1
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 16:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6F4189B142
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAA2196C7C;
	Fri, 18 Jul 2025 14:10:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92E15E5C2
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847845; cv=none; b=dDXNopHjT7lcI8Sn/D1qSaJHHolLVmvLo2elY6eNxfw+aurm9y7uJV4meml6ekkV2frKK1ha+97EN5a/LGaPb725QhHS0DuW05IXeGAIfcR9SOD9EgdgoO+/Z1FhO3VIF4+c/vXrFRFOKfEvyTHJArLjLFkkuKHC1hnypMPQ+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847845; c=relaxed/simple;
	bh=UJ0RCJ8sLtlbjoDbTLq9Whawyn/7yPbNVEbt7kmpjAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=di9BoSPWOQTEcEwEu6EQ73+qlKjJiIgZ9jd2g0pz6zBN6VebT2VZr9VmkbvizAjohi0aK6EfUdxbcs7moczNUR6gB3Cnu6+4BymwxM/oLohBvR8l51E+fInyz8bCFFknv7HHr0Qyn+ylQ3O61vNHZ11cGRM8KDuJkEYhJ7/9sSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c823aba8;
	Fri, 18 Jul 2025 22:10:39 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Mark Brown <broonie@kernel.org>,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 6.6.y 2/2] regulator: pwm-regulator: Manage boot-on with disabled PWM channels
Date: Fri, 18 Jul 2025 22:10:16 +0800
Message-Id: <20250718141016.312952-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718141016.312952-1-amadeus@jmu.edu.cn>
References: <20250718141016.312952-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a981ddf71f103a2kunmb1387368da9c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHk4aVhgdSR9OTE5OSkpOQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit b3cbdcc191819b75c04178142e2d0d4c668f68c0 ]

Odroid-C1 uses a Monolithic Power Systems MP2161 controlled via PWM for
the VDDEE voltage supply of the Meson8b SoC. Commit 6b9352f3f8a1 ("pwm:
meson: modify and simplify calculation in meson_pwm_get_state") results
in my Odroid-C1 crashing with memory corruption in many different places
(seemingly at random). It turns out that this is due to a currently not
supported corner case.

The VDDEE regulator can generate between 860mV (duty cycle of ~91%) and
1140mV (duty cycle of 0%). We consider it to be enabled by the bootloader
(which is why it has the regulator-boot-on flag in .dts) as well as
being always-on (which is why it has the regulator-always-on flag in
.dts) because the VDDEE voltage is generally required for the Meson8b
SoC to work. The public S805 datasheet [0] states on page 17 (where "A5"
refers to the Cortex-A5 CPU cores):
  [...] So if EE domains is shut off, A5 memory is also shut off. That
  does not matter. Before EE power domain is shut off, A5 should be shut
  off at first.

It turns out that at least some bootloader versions are keeping the PWM
output disabled. This is not a problem due to the specific design of the
regulator: when the PWM output is disabled the output pin is pulled LOW,
effectively achieving a 0% duty cycle (which in return means that VDDEE
voltage is at 1140mV).

The problem comes when the pwm-regulator driver tries to initialize the
PWM output. To do so it reads the current state from the hardware, which
is:
  period: 3666ns
  duty cycle: 3333ns (= ~91%)
  enabled: false
Then those values are translated using the continuous voltage range to
860mV.
Later, when the regulator is being enabled (either by the regulator core
due to the always-on flag or first consumer - in this case the lima
driver for the Mali-450 GPU) the pwm-regulator driver tries to keep the
voltage (at 860mV) and just enable the PWM output. This is when things
start to go wrong as the typical voltage used for VDDEE is 1100mV.

Commit 6b9352f3f8a1 ("pwm: meson: modify and simplify calculation in
meson_pwm_get_state") triggers above condition as before that change
period and duty cycle were both at 0. Since the change to the pwm-meson
driver is considered correct the solution is to be found in the
pwm-regulator driver. Update the duty cycle during driver probe if the
regulator is flagged as boot-on so that a call to pwm_regulator_enable()
(by the regulator core during initialization of a regulator flagged with
boot-on) without any preceding call to pwm_regulator_set_voltage() does
not change the output voltage.

[0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://msgid.link/r/20240113224628.377993-4-martin.blumenstingl@googlemail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 drivers/regulator/pwm-regulator.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index d27b9a7a30c9..60cfcd741c2a 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -323,6 +323,32 @@ static int pwm_regulator_init_continuous(struct platform_device *pdev,
 	return 0;
 }
 
+static int pwm_regulator_init_boot_on(struct platform_device *pdev,
+				      struct pwm_regulator_data *drvdata,
+				      const struct regulator_init_data *init_data)
+{
+	struct pwm_state pstate;
+
+	if (!init_data->constraints.boot_on || drvdata->enb_gpio)
+		return 0;
+
+	pwm_get_state(drvdata->pwm, &pstate);
+	if (pstate.enabled)
+		return 0;
+
+	/*
+	 * Update the duty cycle so the output does not change
+	 * when the regulator core enables the regulator (and
+	 * thus the PWM channel).
+	 */
+	if (pstate.polarity == PWM_POLARITY_INVERSED)
+		pstate.duty_cycle = pstate.period;
+	else
+		pstate.duty_cycle = 0;
+
+	return pwm_apply_might_sleep(drvdata->pwm, &pstate);
+}
+
 static int pwm_regulator_probe(struct platform_device *pdev)
 {
 	const struct regulator_init_data *init_data;
@@ -382,6 +408,13 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = pwm_regulator_init_boot_on(pdev, drvdata, init_data);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to apply boot_on settings: %d\n",
+			ret);
+		return ret;
+	}
+
 	regulator = devm_regulator_register(&pdev->dev,
 					    &drvdata->desc, &config);
 	if (IS_ERR(regulator)) {
-- 
2.25.1


