Return-Path: <stable+bounces-71689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD4A9670B8
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 12:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393271F22FFB
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2DC170A37;
	Sat, 31 Aug 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBEdoZ69"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36E17BB08
	for <stable@vger.kernel.org>; Sat, 31 Aug 2024 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099098; cv=none; b=Fwq5TTVYLnVYA1FsrkAQ0B1xLfze4f04bz4xWEMBeysOT6Wtpwp7qhGP89bmjRwKxinBMuk+pyN1uVDrUJTx4SW6l8ezMQZtwStqu78tN+ePFka0kUbUPkJGg8vnrllyr97q8mD6voeGZjBTM/nHP/o3r/5Y8oBXAF9rl71Bs90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099098; c=relaxed/simple;
	bh=6A/KZXl0SOszbMPxJ54MyjSi/j4NMy3w33LDYgwEuUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBiBp8Odf9o1BxtBI/g19BGCcG+rBNlgBXll/hBu9p8CSGVoGDkm3Lec2u6Ay4I5ZQRLrgs7Gga+f581UQ2LU8UTTq+ihSvOAVtdaa6ii58AI4HcfvAPUa8Hmd9dVjYIAOJoXQWkFgs7UB0GjVtjJKuJKe8WV++kbFaz8reLzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IBEdoZ69; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5befecad20eso426674a12.2
        for <stable@vger.kernel.org>; Sat, 31 Aug 2024 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725099094; x=1725703894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAA/88jUmPoX8j9EzkHuwxEf+0bfdEcorfVyfMeqjt0=;
        b=IBEdoZ690OOzBbuySs8tCMVkCUqFMIUxQx81sIn/QchJS+bh25iezZacv/xCgizvN0
         kOrPULkPtPyYEM2lz/pkaWD+t/lpbWNGuBQxIV9YRgLmV28Epqxba3g5ioMm85fyziJg
         +1MAPgzz5O0y11l4W50AtMAP7HE2sMk0ugTfS8c90BseI046ApdU3C3dfJ38HKfMhukb
         m4FWWkTuV4PY1+TVYlIKsGaSkGMtp2tdiUTwkp2woZo/OheYbR3WLmhwWBP8SYzO7xvI
         jbMRgC4t5WWyF7izgphNDIw/3BdY3l8Sm0Pvoo/N7BS9lIaTkr6eoYBTHq9W29THFfx/
         aylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725099094; x=1725703894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAA/88jUmPoX8j9EzkHuwxEf+0bfdEcorfVyfMeqjt0=;
        b=tiZOMsx/bSXPBbm0hyXq744jli74fpTTne+dkFbEHPsbQersb1br9NJ7OGbPQVT854
         BSG3L1b20mHQ7ZMjcPQ/0b/Da6M3gQMyELQ4yYlmSzJi3JM6s3hLspil0OHD/d44Yine
         SK3WIJ2s6UT/OsksUzspQ9XxYq0Z04CwMPa+N3aK6wnLBkGggl88PSumOk5qYYxswcqU
         bYAvrb/uMvVJ8Gy8GGzKYjGy6lFBe6lpB8GviNlDIIjLvy/mwCnTf4J72f7Ok3veE2+j
         kjLvYgPRQPyjXFQHe32kh9sdPmuO5NnOTHckH4YsohWpr603SjgtyUTaKsC30hddxIbP
         iKJw==
X-Forwarded-Encrypted: i=1; AJvYcCWl9ZmoqDM6hgSOsoecMaIvgfGu2Xx8A2HB9ObEyYhPUWLmKyM1zF7DBPoeTrDIElo5m5BhSsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydWcykDDdOz1kKQgST3LK8+p00bNdv2I2DlynuOe9NMDmEBdx1
	rKj5aY323ipSjOXDN5VL7qBt2DOotFmCRp6dDhe3R0cgdm+p/ZU9XU7dtZGbfBI=
X-Google-Smtp-Source: AGHT+IFlB45dEul3ujIqmq8Dxo7h/2KpPUUyuM2NL5Hz0hrjeccIA1n0Q+AYQl2uee/M95VUlejx1g==
X-Received: by 2002:a17:907:7f06:b0:a83:70d0:7a1e with SMTP id a640c23a62f3a-a89a37f673dmr133763166b.9.1725099094557;
        Sat, 31 Aug 2024 03:11:34 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feae4dsm311707266b.31.2024.08.31.03.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 03:11:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: imx6ull-seeed-npi: fix fsl,pins property in tscgrp pinctrl
Date: Sat, 31 Aug 2024 12:11:29 +0200
Message-ID: <20240831101129.15640-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
References: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The property is "fsl,pins", not "fsl,pin".  Wrong property means the pin
configuration was not applied.  Fixes dtbs_check warnings:

  imx6ull-seeed-npi-dev-board-emmc.dtb: pinctrl@20e0000: uart1grp: 'fsl,pins' is a required property
  imx6ull-seeed-npi-dev-board-emmc.dtb: pinctrl@20e0000: uart1grp: 'fsl,pin' does not match any of the regexes: 'pinctrl-[0-9]+'

Cc: <stable@vger.kernel.org>
Fixes: e3b5697195c8 ("ARM: dts: imx6ull: add seeed studio NPi dev board")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi     | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
index 6bb12e0bbc7e..50654dbf62e0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
@@ -339,14 +339,14 @@ MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x120b0
 	};
 
 	pinctrl_uart1: uart1grp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
 			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
@@ -355,7 +355,7 @@ MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
 	};
 
 	pinctrl_uart3: uart3grp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
 			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
@@ -364,21 +364,21 @@ MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
 	};
 
 	pinctrl_uart4: uart4grp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
 		>;
 	};
 
 	pinctrl_uart5: uart5grp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX	0x1b0b1
 			MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX	0x1b0b1
 		>;
 	};
 
 	pinctrl_usb_otg1_id: usbotg1idgrp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x17059
 		>;
 	};
-- 
2.43.0


