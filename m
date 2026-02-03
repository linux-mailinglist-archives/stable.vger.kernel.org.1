Return-Path: <stable+bounces-213282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EXxLtwrgmlFQAMAu9opvQ
	(envelope-from <stable+bounces-213282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:09:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA72DC893
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5F9C30595BC
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDCF30CDBB;
	Tue,  3 Feb 2026 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFQinO4C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9CB318EF0
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138242; cv=none; b=pABEP/8pmF2sxFhSXYx7oYyNk73OQCVMdwLNTLspjpmR/xiiKlanrSjLuAnh+zecWPDVynzbB2bFmQaLtdpJtYaaztCQo1s3KoaM0lQSFNpT0OQa4ArMew09BLb6DqGxXavgQnSHmL/Qp4apdVVMHlaWDt4Wcn+xooBCmohaEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138242; c=relaxed/simple;
	bh=BKMFY+dssvaqAizOX/dyAgQmGZnrdF4D/pPPwJWD+Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkZRf8FTwTPmaQn4V8g44xTIP819vK412sDBmg4n8JtnENhdCg0pIjDguk1rvg2VfFO/EMBMrrgWfEJwZLUww3JEqsaGQMqubeZjCnbNpx+cky/2YajZvQjZ3lPMZv5okUO53eZPr1oV7ncVSxKQ4x6phP2aDp6Iy1sYa2s1Dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFQinO4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A90C116D0;
	Tue,  3 Feb 2026 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770138242;
	bh=BKMFY+dssvaqAizOX/dyAgQmGZnrdF4D/pPPwJWD+Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFQinO4Caa5T6JglfCptcaaIhAQcHLex56OR+jfrZUPw17Yu1ChF2ujoHhpQ8gasS
	 96lxaW+rOEFazbsYI2URf1HRrinRKgfJxekcxLGuOtrUyfilL0fYWs5mjbFoSsLGjv
	 lPXwoinC/N4C929v8ZMKXi7+ch+iRr1VgIWqrmDxavQyojuo/0A6S5L7MUZVUm89Gc
	 sYrOiWxxW5sE5lKPFUUCJ8emy2X7ZQpYXPE6aES+/rbreKErDKp/I1uwruaGYhWTam
	 byqDQbMjdHkhOoKgQmByny0eGlyILRq9SYNzAubzIwDXx85PnkWGkmF9UcpQE6b0Sx
	 5cDh1oMzWUZkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] pinctrl: qcom: sm8350-lpass-lpi: Merge with SC7280 to fix I2S2 and SWR TX pins
Date: Tue,  3 Feb 2026 12:04:00 -0500
Message-ID: <20260203170400.1324051-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020346-reappoint-divided-0018@gregkh>
References: <2026020346-reappoint-divided-0018@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213282-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CFA72DC893
X-Rspamd-Action: no action

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit 1fbe3abb449c5ef2178e1c3e3e8b9a43a7a410ac ]

Qualcomm SC7280 and SM8350 SoCs have slightly different LPASS audio
blocks (v9.4.5 and v9.2), however the LPASS LPI pin controllers are
exactly the same.  The driver for SM8350 has two issues, which can be
fixed by simply moving over to SC7280 driver which has them correct:

1. "i2s2_data_groups" listed twice GPIO12, but should have both GPIO12
   and GPIO13,

2. "swr_tx_data_groups" contained GPIO5 for "swr_tx_data2" function, but
   that function is also available on GPIO14, thus listing it twice is
   not necessary.  OTOH, GPIO5 has also "swr_rx_data1", so selecting
   swr_rx_data function should not block  the TX one.

Fixes: be9f6d56381d ("pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS TLMM")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
[ Context, no dedicated config option ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/Kconfig                  |  15 +-
 drivers/pinctrl/qcom/Makefile                 |   1 -
 .../pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c   |   3 +
 .../pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c   | 167 ------------------
 4 files changed, 6 insertions(+), 180 deletions(-)
 delete mode 100644 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index f84c0d3b79517..36d7ef4097c0f 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -60,13 +60,14 @@ config PINCTRL_LPASS_LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SoCs.
 
 config PINCTRL_SC7280_LPASS_LPI
-	tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller driver"
+	tristate "Qualcomm Technologies Inc SC7280 and SM8350 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
-	  (Low Power Island) found on the Qualcomm Technologies Inc SC7280 platform.
+	  (Low Power Island) found on the Qualcomm Technologies Inc SC7280
+	  and SM8350 platforms.
 
 config PINCTRL_SM6115_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM6115 LPASS LPI pin controller driver"
@@ -86,16 +87,6 @@ config PINCTRL_SM8250_LPASS_LPI
 	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SM8250 platform.
 
-config PINCTRL_SM8350_LPASS_LPI
-	tristate "Qualcomm Technologies Inc SM8350 LPASS LPI pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_LPASS_LPI
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
-	  (Low Power Island) found on the Qualcomm Technologies Inc SM8350
-	  platform.
-
 config PINCTRL_SM8450_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8450 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 5910e08c84cec..d1179d8b2c42b 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_PINCTRL_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
 obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
-obj-$(CONFIG_PINCTRL_SM8350_LPASS_LPI) += pinctrl-sm8350-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
 obj-$(CONFIG_PINCTRL_SM8450_LPASS_LPI) += pinctrl-sm8450-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8550) += pinctrl-sm8550.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
index d615b6c55b891..74cc5b4ac9820 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
@@ -147,6 +147,9 @@ static const struct of_device_id lpi_pinctrl_of_match[] = {
 	{
 	       .compatible = "qcom,sc7280-lpass-lpi-pinctrl",
 	       .data = &sc7280_lpi_data,
+	}, {
+	       .compatible = "qcom,sm8350-lpass-lpi-pinctrl",
+	       .data = &sc7280_lpi_data,
 	},
 	{ }
 };
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
deleted file mode 100644
index f889c779bccd5..0000000000000
--- a/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
+++ /dev/null
@@ -1,167 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2020-2023 Linaro Ltd.
- */
-
-#include <linux/gpio/driver.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-
-#include "pinctrl-lpass-lpi.h"
-
-enum lpass_lpi_functions {
-	LPI_MUX_dmic1_clk,
-	LPI_MUX_dmic1_data,
-	LPI_MUX_dmic2_clk,
-	LPI_MUX_dmic2_data,
-	LPI_MUX_dmic3_clk,
-	LPI_MUX_dmic3_data,
-	LPI_MUX_i2s1_clk,
-	LPI_MUX_i2s1_data,
-	LPI_MUX_i2s1_ws,
-	LPI_MUX_i2s2_clk,
-	LPI_MUX_i2s2_data,
-	LPI_MUX_i2s2_ws,
-	LPI_MUX_qua_mi2s_data,
-	LPI_MUX_qua_mi2s_sclk,
-	LPI_MUX_qua_mi2s_ws,
-	LPI_MUX_swr_rx_clk,
-	LPI_MUX_swr_rx_data,
-	LPI_MUX_swr_tx_clk,
-	LPI_MUX_swr_tx_data,
-	LPI_MUX_wsa_swr_clk,
-	LPI_MUX_wsa_swr_data,
-	LPI_MUX_gpio,
-	LPI_MUX__,
-};
-
-static int gpio0_pins[] = { 0 };
-static int gpio1_pins[] = { 1 };
-static int gpio2_pins[] = { 2 };
-static int gpio3_pins[] = { 3 };
-static int gpio4_pins[] = { 4 };
-static int gpio5_pins[] = { 5 };
-static int gpio6_pins[] = { 6 };
-static int gpio7_pins[] = { 7 };
-static int gpio8_pins[] = { 8 };
-static int gpio9_pins[] = { 9 };
-static int gpio10_pins[] = { 10 };
-static int gpio11_pins[] = { 11 };
-static int gpio12_pins[] = { 12 };
-static int gpio13_pins[] = { 13 };
-static int gpio14_pins[] = { 14 };
-
-static const struct pinctrl_pin_desc sm8350_lpi_pins[] = {
-	PINCTRL_PIN(0, "gpio0"),
-	PINCTRL_PIN(1, "gpio1"),
-	PINCTRL_PIN(2, "gpio2"),
-	PINCTRL_PIN(3, "gpio3"),
-	PINCTRL_PIN(4, "gpio4"),
-	PINCTRL_PIN(5, "gpio5"),
-	PINCTRL_PIN(6, "gpio6"),
-	PINCTRL_PIN(7, "gpio7"),
-	PINCTRL_PIN(8, "gpio8"),
-	PINCTRL_PIN(9, "gpio9"),
-	PINCTRL_PIN(10, "gpio10"),
-	PINCTRL_PIN(11, "gpio11"),
-	PINCTRL_PIN(12, "gpio12"),
-	PINCTRL_PIN(13, "gpio13"),
-	PINCTRL_PIN(14, "gpio14"),
-};
-
-static const char * const swr_tx_clk_groups[] = { "gpio0" };
-static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5", "gpio14" };
-static const char * const swr_rx_clk_groups[] = { "gpio3" };
-static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5" };
-static const char * const dmic1_clk_groups[] = { "gpio6" };
-static const char * const dmic1_data_groups[] = { "gpio7" };
-static const char * const dmic2_clk_groups[] = { "gpio8" };
-static const char * const dmic2_data_groups[] = { "gpio9" };
-static const char * const i2s2_clk_groups[] = { "gpio10" };
-static const char * const i2s2_ws_groups[] = { "gpio11" };
-static const char * const dmic3_clk_groups[] = { "gpio12" };
-static const char * const dmic3_data_groups[] = { "gpio13" };
-static const char * const qua_mi2s_sclk_groups[] = { "gpio0" };
-static const char * const qua_mi2s_ws_groups[] = { "gpio1" };
-static const char * const qua_mi2s_data_groups[] = { "gpio2", "gpio3", "gpio4" };
-static const char * const i2s1_clk_groups[] = { "gpio6" };
-static const char * const i2s1_ws_groups[] = { "gpio7" };
-static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
-static const char * const wsa_swr_clk_groups[] = { "gpio10" };
-static const char * const wsa_swr_data_groups[] = { "gpio11" };
-static const char * const i2s2_data_groups[] = { "gpio12", "gpio12" };
-
-static const struct lpi_pingroup sm8350_groups[] = {
-	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
-	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
-	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
-	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
-	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
-	LPI_PINGROUP(5, 12, swr_tx_data, swr_rx_data, _, _),
-	LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
-	LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
-	LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
-	LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, _, _),
-	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
-	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
-	LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s2_data, _, _),
-	LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s2_data, _, _),
-	LPI_PINGROUP(14, 6, swr_tx_data, _, _, _),
-};
-
-static const struct lpi_function sm8350_functions[] = {
-	LPI_FUNCTION(dmic1_clk),
-	LPI_FUNCTION(dmic1_data),
-	LPI_FUNCTION(dmic2_clk),
-	LPI_FUNCTION(dmic2_data),
-	LPI_FUNCTION(dmic3_clk),
-	LPI_FUNCTION(dmic3_data),
-	LPI_FUNCTION(i2s1_clk),
-	LPI_FUNCTION(i2s1_data),
-	LPI_FUNCTION(i2s1_ws),
-	LPI_FUNCTION(i2s2_clk),
-	LPI_FUNCTION(i2s2_data),
-	LPI_FUNCTION(i2s2_ws),
-	LPI_FUNCTION(qua_mi2s_data),
-	LPI_FUNCTION(qua_mi2s_sclk),
-	LPI_FUNCTION(qua_mi2s_ws),
-	LPI_FUNCTION(swr_rx_clk),
-	LPI_FUNCTION(swr_rx_data),
-	LPI_FUNCTION(swr_tx_clk),
-	LPI_FUNCTION(swr_tx_data),
-	LPI_FUNCTION(wsa_swr_clk),
-	LPI_FUNCTION(wsa_swr_data),
-};
-
-static const struct lpi_pinctrl_variant_data sm8350_lpi_data = {
-	.pins = sm8350_lpi_pins,
-	.npins = ARRAY_SIZE(sm8350_lpi_pins),
-	.groups = sm8350_groups,
-	.ngroups = ARRAY_SIZE(sm8350_groups),
-	.functions = sm8350_functions,
-	.nfunctions = ARRAY_SIZE(sm8350_functions),
-};
-
-static const struct of_device_id lpi_pinctrl_of_match[] = {
-	{
-	       .compatible = "qcom,sm8350-lpass-lpi-pinctrl",
-	       .data = &sm8350_lpi_data,
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
-
-static struct platform_driver lpi_pinctrl_driver = {
-	.driver = {
-		   .name = "qcom-sm8350-lpass-lpi-pinctrl",
-		   .of_match_table = lpi_pinctrl_of_match,
-	},
-	.probe = lpi_pinctrl_probe,
-	.remove = lpi_pinctrl_remove,
-};
-module_platform_driver(lpi_pinctrl_driver);
-
-MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>");
-MODULE_DESCRIPTION("QTI SM8350 LPI GPIO pin control driver");
-MODULE_LICENSE("GPL");
-- 
2.51.0


