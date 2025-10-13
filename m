Return-Path: <stable+bounces-184291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BDFBD3C63
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C88234DDC1
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF23090F5;
	Mon, 13 Oct 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ngjbr1W6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E95826B742;
	Mon, 13 Oct 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367012; cv=none; b=R8WZuI6Ltuet/3tOaVaPQ8d7EOn3iyV5nBTpw4JcC494W8mq+yYNGxWb9zUbSb/7gZ8mmgbn7FfJkmA2D4wkuH+DuwS7W+3rPh3l8go8C3A+CMRjrmwu5SxU1y2jxmxUeiUNblu57pP3CtF0KHUz9+Jm1Tcas2Mt3pfGcovpXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367012; c=relaxed/simple;
	bh=zzIu59kSMjBqH5sOL4eqg1iSnIRIOK5MC0bNXdIji+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPgYfHic0FmOpvtzn1/jO3qIHU0VXa++jorfTa8r7wXmYq+0lroBeSfkJAKxdtx6RZq4T0/j1GPxomIoQRIodGiqTvbodOMCkXcBs8KQ/j6Nr+STEA3eRvd2FO+13IxD4+OJNlx7xSsg7NBEJNOM9fT5HecjEf9T9QVxlIs0LtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ngjbr1W6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B215EC4CEFE;
	Mon, 13 Oct 2025 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367012;
	bh=zzIu59kSMjBqH5sOL4eqg1iSnIRIOK5MC0bNXdIji+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ngjbr1W6zMvNOcnMwudbgBhaK/B0YSSc+nlONn2L+drNaw1GIR7CW1TEPx4OWHu6Z
	 inXsJK2k+r1ZKRb7j9BTdHWbaN5RJONqt6tnlBnHrkE3eY2w7dG01mRDDMFsxDPq0D
	 thUJwMiiAgayShHRL51KzrNVQYz1/JG527DsUF2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Da Xue <da@libre.computer>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/196] pinctrl: meson-gxl: add missing i2c_d pinmux
Date: Mon, 13 Oct 2025 16:43:55 +0200
Message-ID: <20251013144316.824618617@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Da Xue <da@libre.computer>

[ Upstream commit d8c2a9edd181f0cc4a66eec954b3d8f6a1d954a7 ]

Amlogic GXL has 4 I2C attached to gpio-periphs. I2C_D is on GPIOX_10/11.

Add the relevant func 3 pinmux per the datasheet for S805X/S905X/S905D.

Fixes: 0f15f500ff2c ("pinctrl: meson: Add GXL pinctrl definitions")
Signed-off-by: Da Xue <da@libre.computer>
Link: https://lore.kernel.org/20250821233335.1707559-1-da@libre.computer
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 51408996255bd..e2601e45935e6 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -187,6 +187,9 @@ static const unsigned int i2c_sda_c_pins[]	= { GPIODV_28 };
 static const unsigned int i2c_sck_c_dv19_pins[] = { GPIODV_19 };
 static const unsigned int i2c_sda_c_dv18_pins[] = { GPIODV_18 };
 
+static const unsigned int i2c_sck_d_pins[]	= { GPIOX_11 };
+static const unsigned int i2c_sda_d_pins[]	= { GPIOX_10 };
+
 static const unsigned int eth_mdio_pins[]	= { GPIOZ_0 };
 static const unsigned int eth_mdc_pins[]	= { GPIOZ_1 };
 static const unsigned int eth_clk_rx_clk_pins[] = { GPIOZ_2 };
@@ -411,6 +414,8 @@ static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIO_TEST_N),
 
 	/* Bank X */
+	GROUP(i2c_sda_d,	5,	5),
+	GROUP(i2c_sck_d,	5,	4),
 	GROUP(sdio_d0,		5,	31),
 	GROUP(sdio_d1,		5,	30),
 	GROUP(sdio_d2,		5,	29),
@@ -651,6 +656,10 @@ static const char * const i2c_c_groups[] = {
 	"i2c_sck_c", "i2c_sda_c", "i2c_sda_c_dv18", "i2c_sck_c_dv19",
 };
 
+static const char * const i2c_d_groups[] = {
+	"i2c_sck_d", "i2c_sda_d",
+};
+
 static const char * const eth_groups[] = {
 	"eth_mdio", "eth_mdc", "eth_clk_rx_clk", "eth_rx_dv",
 	"eth_rxd0", "eth_rxd1", "eth_rxd2", "eth_rxd3",
@@ -777,6 +786,7 @@ static struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(i2c_a),
 	FUNCTION(i2c_b),
 	FUNCTION(i2c_c),
+	FUNCTION(i2c_d),
 	FUNCTION(eth),
 	FUNCTION(pwm_a),
 	FUNCTION(pwm_b),
-- 
2.51.0




