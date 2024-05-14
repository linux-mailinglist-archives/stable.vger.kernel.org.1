Return-Path: <stable+bounces-44429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4478C52D2
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994241F22739
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9094130E45;
	Tue, 14 May 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2qQ4ZPem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0B84A46;
	Tue, 14 May 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686136; cv=none; b=h556ZcfVcBLVUMy2uunC4QlF5mglRqCzYgfidXqliWXKEkA+DE/Ozwc7xmN3MnHXH5GD1m6hteXTojV32Mu41oeIjLfiERpMMV51KJQ6+Ae+AxWNDlWPI8dD7W8+c2oiQLW4BH2C0Z0H7PfnJRGILqHAjFuI32d9bJH7Zzs1faQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686136; c=relaxed/simple;
	bh=QpVbmwto88mTxwyMvxD/kQWx/qYcVHaGR7jxYYEpmic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpHjjMZhP05qlaQe7hPSzmOTVTU+tuNXgM+9M6aBpqeVfIvGGpFLPrFEohBYz/bOr78CAfgXJsuln+gA3t1qlNP4oyQZT4MqOJmM4OdTAgUyNulCf7wqDY66wUSO+gwgBSAIaWWeWclD5lhmjV0gVfaQ9AmFqT5GiAgjAnpLed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2qQ4ZPem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29241C2BD10;
	Tue, 14 May 2024 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686136;
	bh=QpVbmwto88mTxwyMvxD/kQWx/qYcVHaGR7jxYYEpmic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2qQ4ZPemjT7BRYwux1zT+tEdBldbQgIaCkgvLyChqSd97FZ+p+8m3MoYdcVa9WCAN
	 ynq/9ZyPBFkMnq1DHHcWAuNa02auaWZ4wnSfhNGLo1FQZTcspoEvIeYRkgA5lZ9vGU
	 vwaelomTqPSSDvUeEJSLbW2030i1EAmEfU3UnddU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/236] pinctrl: baytrail: Fix selecting gpio pinctrl state
Date: Tue, 14 May 2024 12:16:35 +0200
Message-ID: <20240514101021.599144469@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit fed6d9a8e6a60ecf6506d0ea004040fbaa109927 ]

For all the "score" pin-groups all the intel_pingroup-s to select
the non GPIO function are re-used for byt_score_gpio_groups[].

But this is incorrect since a pin-group includes the mode setting,
which for the non GPIO functions generally is 1, where as to select
the GPIO function mode must be set to 0.

So the GPIO function needs separate intel_pingroup-s with their own mode
value of 0.

Add a new PIN_GROUP_GPIO macro which adds a foo_gpio entry to each
pin-group defined this way and update byt_score_gpio_groups[] to point
to the new foo_gpio entries.

The "sus" usb_oc_grp usb_ulpi_grp and pcu_spi_grp pin-groups are special
because these have a non 0 mode value to select the GPIO functions and
these already have matching foo_gpio pin-groups, leave these are unchanged.

The pmu_clk "sus" groups added in commit 2f46d7f7e959 ("pinctrl: baytrail:
Add pinconf group + function for the pmu_clk") do need to use the new
PIN_GROUP_GPIO macro.

Fixes: 2f46d7f7e959 ("pinctrl: baytrail: Add pinconf group + function for the pmu_clk")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 74 ++++++++++++------------
 drivers/pinctrl/intel/pinctrl-intel.h    |  4 ++
 2 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 67db79f380510..a0b7b16cb4de3 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -276,33 +276,33 @@ static const unsigned int byt_score_plt_clk5_pins[] = { 101 };
 static const unsigned int byt_score_smbus_pins[] = { 51, 52, 53 };
 
 static const struct intel_pingroup byt_score_groups[] = {
-	PIN_GROUP("uart1_grp", byt_score_uart1_pins, 1),
-	PIN_GROUP("uart2_grp", byt_score_uart2_pins, 1),
-	PIN_GROUP("pwm0_grp", byt_score_pwm0_pins, 1),
-	PIN_GROUP("pwm1_grp", byt_score_pwm1_pins, 1),
-	PIN_GROUP("ssp2_grp", byt_score_ssp2_pins, 1),
-	PIN_GROUP("sio_spi_grp", byt_score_sio_spi_pins, 1),
-	PIN_GROUP("i2c5_grp", byt_score_i2c5_pins, 1),
-	PIN_GROUP("i2c6_grp", byt_score_i2c6_pins, 1),
-	PIN_GROUP("i2c4_grp", byt_score_i2c4_pins, 1),
-	PIN_GROUP("i2c3_grp", byt_score_i2c3_pins, 1),
-	PIN_GROUP("i2c2_grp", byt_score_i2c2_pins, 1),
-	PIN_GROUP("i2c1_grp", byt_score_i2c1_pins, 1),
-	PIN_GROUP("i2c0_grp", byt_score_i2c0_pins, 1),
-	PIN_GROUP("ssp0_grp", byt_score_ssp0_pins, 1),
-	PIN_GROUP("ssp1_grp", byt_score_ssp1_pins, 1),
-	PIN_GROUP("sdcard_grp", byt_score_sdcard_pins, byt_score_sdcard_mux_values),
-	PIN_GROUP("sdio_grp", byt_score_sdio_pins, 1),
-	PIN_GROUP("emmc_grp", byt_score_emmc_pins, 1),
-	PIN_GROUP("lpc_grp", byt_score_ilb_lpc_pins, 1),
-	PIN_GROUP("sata_grp", byt_score_sata_pins, 1),
-	PIN_GROUP("plt_clk0_grp", byt_score_plt_clk0_pins, 1),
-	PIN_GROUP("plt_clk1_grp", byt_score_plt_clk1_pins, 1),
-	PIN_GROUP("plt_clk2_grp", byt_score_plt_clk2_pins, 1),
-	PIN_GROUP("plt_clk3_grp", byt_score_plt_clk3_pins, 1),
-	PIN_GROUP("plt_clk4_grp", byt_score_plt_clk4_pins, 1),
-	PIN_GROUP("plt_clk5_grp", byt_score_plt_clk5_pins, 1),
-	PIN_GROUP("smbus_grp", byt_score_smbus_pins, 1),
+	PIN_GROUP_GPIO("uart1_grp", byt_score_uart1_pins, 1),
+	PIN_GROUP_GPIO("uart2_grp", byt_score_uart2_pins, 1),
+	PIN_GROUP_GPIO("pwm0_grp", byt_score_pwm0_pins, 1),
+	PIN_GROUP_GPIO("pwm1_grp", byt_score_pwm1_pins, 1),
+	PIN_GROUP_GPIO("ssp2_grp", byt_score_ssp2_pins, 1),
+	PIN_GROUP_GPIO("sio_spi_grp", byt_score_sio_spi_pins, 1),
+	PIN_GROUP_GPIO("i2c5_grp", byt_score_i2c5_pins, 1),
+	PIN_GROUP_GPIO("i2c6_grp", byt_score_i2c6_pins, 1),
+	PIN_GROUP_GPIO("i2c4_grp", byt_score_i2c4_pins, 1),
+	PIN_GROUP_GPIO("i2c3_grp", byt_score_i2c3_pins, 1),
+	PIN_GROUP_GPIO("i2c2_grp", byt_score_i2c2_pins, 1),
+	PIN_GROUP_GPIO("i2c1_grp", byt_score_i2c1_pins, 1),
+	PIN_GROUP_GPIO("i2c0_grp", byt_score_i2c0_pins, 1),
+	PIN_GROUP_GPIO("ssp0_grp", byt_score_ssp0_pins, 1),
+	PIN_GROUP_GPIO("ssp1_grp", byt_score_ssp1_pins, 1),
+	PIN_GROUP_GPIO("sdcard_grp", byt_score_sdcard_pins, byt_score_sdcard_mux_values),
+	PIN_GROUP_GPIO("sdio_grp", byt_score_sdio_pins, 1),
+	PIN_GROUP_GPIO("emmc_grp", byt_score_emmc_pins, 1),
+	PIN_GROUP_GPIO("lpc_grp", byt_score_ilb_lpc_pins, 1),
+	PIN_GROUP_GPIO("sata_grp", byt_score_sata_pins, 1),
+	PIN_GROUP_GPIO("plt_clk0_grp", byt_score_plt_clk0_pins, 1),
+	PIN_GROUP_GPIO("plt_clk1_grp", byt_score_plt_clk1_pins, 1),
+	PIN_GROUP_GPIO("plt_clk2_grp", byt_score_plt_clk2_pins, 1),
+	PIN_GROUP_GPIO("plt_clk3_grp", byt_score_plt_clk3_pins, 1),
+	PIN_GROUP_GPIO("plt_clk4_grp", byt_score_plt_clk4_pins, 1),
+	PIN_GROUP_GPIO("plt_clk5_grp", byt_score_plt_clk5_pins, 1),
+	PIN_GROUP_GPIO("smbus_grp", byt_score_smbus_pins, 1),
 };
 
 static const char * const byt_score_uart_groups[] = {
@@ -330,12 +330,14 @@ static const char * const byt_score_plt_clk_groups[] = {
 };
 static const char * const byt_score_smbus_groups[] = { "smbus_grp" };
 static const char * const byt_score_gpio_groups[] = {
-	"uart1_grp", "uart2_grp", "pwm0_grp", "pwm1_grp", "ssp0_grp",
-	"ssp1_grp", "ssp2_grp", "sio_spi_grp", "i2c0_grp", "i2c1_grp",
-	"i2c2_grp", "i2c3_grp", "i2c4_grp", "i2c5_grp", "i2c6_grp",
-	"sdcard_grp", "sdio_grp", "emmc_grp", "lpc_grp", "sata_grp",
-	"plt_clk0_grp", "plt_clk1_grp", "plt_clk2_grp", "plt_clk3_grp",
-	"plt_clk4_grp", "plt_clk5_grp", "smbus_grp",
+	"uart1_grp_gpio", "uart2_grp_gpio", "pwm0_grp_gpio",
+	"pwm1_grp_gpio", "ssp0_grp_gpio", "ssp1_grp_gpio", "ssp2_grp_gpio",
+	"sio_spi_grp_gpio", "i2c0_grp_gpio", "i2c1_grp_gpio", "i2c2_grp_gpio",
+	"i2c3_grp_gpio", "i2c4_grp_gpio", "i2c5_grp_gpio", "i2c6_grp_gpio",
+	"sdcard_grp_gpio", "sdio_grp_gpio", "emmc_grp_gpio", "lpc_grp_gpio",
+	"sata_grp_gpio", "plt_clk0_grp_gpio", "plt_clk1_grp_gpio",
+	"plt_clk2_grp_gpio", "plt_clk3_grp_gpio", "plt_clk4_grp_gpio",
+	"plt_clk5_grp_gpio", "smbus_grp_gpio",
 };
 
 static const struct intel_function byt_score_functions[] = {
@@ -454,8 +456,8 @@ static const struct intel_pingroup byt_sus_groups[] = {
 	PIN_GROUP("usb_oc_grp_gpio", byt_sus_usb_over_current_pins, byt_sus_usb_over_current_gpio_mode_values),
 	PIN_GROUP("usb_ulpi_grp_gpio", byt_sus_usb_ulpi_pins, byt_sus_usb_ulpi_gpio_mode_values),
 	PIN_GROUP("pcu_spi_grp_gpio", byt_sus_pcu_spi_pins, byt_sus_pcu_spi_gpio_mode_values),
-	PIN_GROUP("pmu_clk1_grp", byt_sus_pmu_clk1_pins, 1),
-	PIN_GROUP("pmu_clk2_grp", byt_sus_pmu_clk2_pins, 1),
+	PIN_GROUP_GPIO("pmu_clk1_grp", byt_sus_pmu_clk1_pins, 1),
+	PIN_GROUP_GPIO("pmu_clk2_grp", byt_sus_pmu_clk2_pins, 1),
 };
 
 static const char * const byt_sus_usb_groups[] = {
@@ -467,7 +469,7 @@ static const char * const byt_sus_pmu_clk_groups[] = {
 };
 static const char * const byt_sus_gpio_groups[] = {
 	"usb_oc_grp_gpio", "usb_ulpi_grp_gpio", "pcu_spi_grp_gpio",
-	"pmu_clk1_grp", "pmu_clk2_grp",
+	"pmu_clk1_grp_gpio", "pmu_clk2_grp_gpio",
 };
 
 static const struct intel_function byt_sus_functions[] = {
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 46f5f7d1565fe..0d45063435ebc 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -160,6 +160,10 @@ struct intel_community {
 		.modes = __builtin_choose_expr(__builtin_constant_p((m)), NULL, (m)),	\
 	}
 
+#define PIN_GROUP_GPIO(n, p, m)						\
+	 PIN_GROUP(n, p, m),						\
+	 PIN_GROUP(n "_gpio", p, 0)
+
 #define FUNCTION(n, g)							\
 	{								\
 		.func = PINCTRL_PINFUNCTION((n), (g), ARRAY_SIZE(g)),	\
-- 
2.43.0




