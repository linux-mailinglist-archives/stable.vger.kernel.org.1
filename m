Return-Path: <stable+bounces-213204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONO6NBzvgWlAMwMAu9opvQ
	(envelope-from <stable+bounces-213204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:50:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F542D9547
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6487D30E629F
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722A340A63;
	Tue,  3 Feb 2026 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mur9Kms/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2EC1C69D
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122577; cv=none; b=VmX8QMhD+hsuHYSK7omI7gX1053x/3eyMAnUq6B60/GMkqE3wcOd0JPd1b28M6aRbw7Z+bN36qQ9r9m2K7+WCO+lTOm1T/WcO6L9/h8H8Fzxef1jyNAPm8BUW+dzVe4uxQeOb87GSo+v6RI3THgl2Oens8VAe/vOwPtexZajG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122577; c=relaxed/simple;
	bh=KOBFcUykY4TWu3W5vdF2k7NxtjRsJ0Etta+h+BpJTeQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nuI9NhzbfWFga/gXbgdDyk0Zb4V7LGrQ1FrbTNd48/lsbxxRSYFiSd5Yecp7odJ0Ax8jot6nE0hZdO8R+i9418oiHJKyF2SUKeo/bsUwwUBOToutWPELa2brFjzHqtJHlxT5EnaiMHR9sQYFSpksEHZhUkwLUpbn84Pp/nE96Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mur9Kms/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8919C116D0;
	Tue,  3 Feb 2026 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770122577;
	bh=KOBFcUykY4TWu3W5vdF2k7NxtjRsJ0Etta+h+BpJTeQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Mur9Kms/DXsjs4pweRkcqca2789AJrjqmSgeyrj1w1Cb3givBHcJ/ZxpWonXKirZn
	 DP3r3dl0mbX1MXThwCfa2XG0Omltm9U2XWB/2O3uJbgtrjYTtwYMXGkg9BekFytsig
	 amcmvCra9wuncqqSsEhfaSY9CHDO48YQSUy+KhGo=
Subject: FAILED: patch "[PATCH] pinctrl: qcom: sm8350-lpass-lpi: Merge with SC7280 to fix" failed to apply to 6.6-stable tree
To: krzysztof.kozlowski@oss.qualcomm.com,bartosz.golaszewski@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 13:42:46 +0100
Message-ID: <2026020346-reappoint-divided-0018@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213204-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 2F542D9547
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1fbe3abb449c5ef2178e1c3e3e8b9a43a7a410ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020346-reappoint-divided-0018@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1fbe3abb449c5ef2178e1c3e3e8b9a43a7a410ac Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 11:07:22 +0100
Subject: [PATCH] pinctrl: qcom: sm8350-lpass-lpi: Merge with SC7280 to fix
 I2S2 and SWR TX pins

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

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 45288ec9eaf7..35e9eb180c9a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -670,7 +670,6 @@ CONFIG_PINCTRL_LPASS_LPI=m
 CONFIG_PINCTRL_SC7280_LPASS_LPI=m
 CONFIG_PINCTRL_SM6115_LPASS_LPI=m
 CONFIG_PINCTRL_SM8250_LPASS_LPI=m
-CONFIG_PINCTRL_SM8350_LPASS_LPI=m
 CONFIG_PINCTRL_SM8450_LPASS_LPI=m
 CONFIG_PINCTRL_SC8280XP_LPASS_LPI=m
 CONFIG_PINCTRL_SM8550_LPASS_LPI=m
diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index c480e8b78503..f56592411cf6 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -61,13 +61,14 @@ config PINCTRL_LPASS_LPI
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
 
 config PINCTRL_SDM660_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SDM660 LPASS LPI pin controller driver"
@@ -106,16 +107,6 @@ config PINCTRL_SM8250_LPASS_LPI
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
index 748b17a77b2c..4269d1781015 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -64,7 +64,6 @@ obj-$(CONFIG_PINCTRL_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
 obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
-obj-$(CONFIG_PINCTRL_SM8350_LPASS_LPI) += pinctrl-sm8350-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
 obj-$(CONFIG_PINCTRL_SM8450_LPASS_LPI) += pinctrl-sm8450-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8550) += pinctrl-sm8550.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
index 1161f0a91a00..750f410311a8 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
@@ -131,6 +131,9 @@ static const struct of_device_id lpi_pinctrl_of_match[] = {
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
index 7b146b4acfdf..000000000000
--- a/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
+++ /dev/null
@@ -1,151 +0,0 @@
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


