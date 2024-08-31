Return-Path: <stable+bounces-71688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3C9670B7
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 12:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D93B1C214B4
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF2117BB2A;
	Sat, 31 Aug 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joxfg+wU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A2A170A37
	for <stable@vger.kernel.org>; Sat, 31 Aug 2024 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099097; cv=none; b=p9lJGsQT/q5G7y7B9BPptoCt4+xKue3MwM/p76rExVybDHSG5HcB66vxMF46CgU2GZYpcQxuXbSt7a1uuYMItxdxuEEa12AOqFDlwOmZ1ePg2NCWPqL1/B7tUU7C9t9F1q8cIn7wYVYRbye48v40AhZT//cL3sN5V16lXWDCCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099097; c=relaxed/simple;
	bh=eK9lwHTGrE9nYN6gnIQ8mYnUNzrrnjm32O0cFnJTIKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7nhx2qxopEGja5qiuthk8a/sKXmIj1YvJYmHCf5An4PyQr+Cn47pqS+MDnDllgXEhwS8lPglx1F0cvINC+s+F79Pt3cZX52XIvVt5tWG+Ye13a23CD5DscKofUNk4BGHb+QRNSQsuMZc9Q/pLlFb8h4xbMqj6A/W4HB11U6kNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joxfg+wU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c245580f5cso71620a12.0
        for <stable@vger.kernel.org>; Sat, 31 Aug 2024 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725099093; x=1725703893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HB1tlgukKY1KvsXWQTxeELXSE2pe2uY+begkTD0612E=;
        b=joxfg+wUU8v1TZmwm1Rf9r9TdPBUNw4ZFrQ10iw8LjTng1TLE4FjUT2TZ1xU20Qvdz
         WHklzz+SzIspxoYGBbrzsYOnqYQ2Gipgoi5q0gcf4Rqq/ulRmPK8X6Wyagovn6kMeGLU
         wf4/K7hcLyP5sTer+tUIxjjMOV3BpTxBef+lE1PBeQ8D8PkRfQdq9g+zQUG7RN6xZb/w
         FoSjfqgdZdrN1n0bUkVCR5Y3gh0u3d4aLty8YHOFwAtYMPz8mAY/ilYP53OZnEV1rD31
         UcyhPIfRVMNWIsTfT9G+SP5ZR+AdxM6j0o1aDreNrQ+cP+qfC4IPCpIBx0Fu38eewhJA
         DYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725099093; x=1725703893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HB1tlgukKY1KvsXWQTxeELXSE2pe2uY+begkTD0612E=;
        b=tHzKDbOvWpCpKZhvnqfMpmBjMaRe1Q4qBgyMpDNlynpFjd7gYE/PQydxwztNDFABEr
         2izg1uBH6PmTOSV2IhVZVFeeP5ZPdoR04EVvDj//bg0dxO5M1PdW1BG6FqdkuHTHo8zq
         qhpYaz46DQYU7j9GZETTAONe9pBF1c5EiG+CIU8mUCtfnrtB2zSRbfjMxvt/tId4tG3d
         pnRUArhJWT2bIovh1pDZ+SPXWwY3LnKDWyS1pbmkjckd0mstH8+O/7ciFVJPNvLpWPHv
         qx6MYXY4I/Kg39W5WPcP95mTT0t/xTKm8CMkdAxzwCmu+VnRIE86KSJZfsFoDDzSUpj2
         GcoA==
X-Forwarded-Encrypted: i=1; AJvYcCXyQ9RcgjGNWsw/75m+EGhhFrpg5btmJr6P6FhB+hWcRzgwvK6G9yA2spip725DaP43VSnw/Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCf1jmle6yKa3omMLayP850BMGRMG8OeCHzQyHQYm7JVzixn/v
	NwTbpFsFnKb4Y7wqQDNUo6L7usMPmzIzWOMfrr/4y/M8XN8cHOhiE0/Js2+h6mg=
X-Google-Smtp-Source: AGHT+IFwVGnm/EKQ8MW41lLfc+/EkRKkHINcUVfO3ryyMSVQwViKKq7XhFYFirZ0oz/oMNb/3Yf2CQ==
X-Received: by 2002:a17:907:3f87:b0:a80:ed7a:c114 with SMTP id a640c23a62f3a-a89a2ff7874mr144197666b.0.1725099092826;
        Sat, 31 Aug 2024 03:11:32 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feae4dsm311707266b.31.2024.08.31.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 03:11:32 -0700 (PDT)
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
Subject: [PATCH 1/2] ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp pinctrl
Date: Sat, 31 Aug 2024 12:11:28 +0200
Message-ID: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The property is "fsl,pins", not "fsl,pin".  Wrong property means the pin
configuration was not applied.  Fixes dtbs_check warnings:

  imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pins' is a required property
  imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pin' does not match any of the regexes: 'pinctrl-[0-9]+'

Cc: <stable@vger.kernel.org>
Fixes: a58e4e608bc8 ("ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL initial support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
index cdbb8c435cd6..601d89b904cd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
@@ -365,7 +365,7 @@ MX6UL_PAD_ENET1_RX_ER__PWM8_OUT   0x110b0
 	};
 
 	pinctrl_tsc: tscgrp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
 			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
 			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
-- 
2.43.0


