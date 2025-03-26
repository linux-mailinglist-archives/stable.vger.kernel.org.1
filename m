Return-Path: <stable+bounces-126759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 420ADA71BB8
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634247A58EE
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD51F8BC9;
	Wed, 26 Mar 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="SRaiq7bV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB71F6664
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006236; cv=none; b=J0Mg9+Q3QNLh9EdC2b+D6j34kfPcUwEZXyeS2TIE69IK2bYjvUWjQ+YaL5Wjn+Sc0Pcdkl2x0m5UYi11RYBruL3c2KZ3NGcz8t4i6OfiKCLM4J4hgZU4eHKAVY3MZMF0p+T8lK195Z1Y8o0UtJsYJsHBza09+0Z+duGXioQZvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006236; c=relaxed/simple;
	bh=Xyyjf1iVpsBKHBeKbA3NYgJgRAsD7ncLZzoytlF9COg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sGAbcegGezk0xk4DtiA0W6dtT3b63yTvIQ3XYqOL5Kn4z8LSF39TT1nhmbRQyta1eydr1gt0z3eIuwiyZTeNz7UXSpHtM4qmJPPzO2lNPaSMYJfp1891mNnqnrJr43GkmTsiEa7Zz6ckDCqc4sjCgh23EtydolgoqFiGf12hAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=SRaiq7bV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so1492766b.0
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1743006232; x=1743611032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDeO2nIfMOICmbdN4iB492bLj9a77KMSQWKqvg2E0aY=;
        b=SRaiq7bVYUgs2L8R3vlFonRrbUENE5holF9mpWbPXwWNurc+TZ00EF9oPPa9csnlwz
         iUJ/1bReYeEoU8BjG3WZPeygIoIPaKRYja//oDhx6bCTpTbs4FrEL5fY+7oRVLAga/5f
         7wLL3K4s+IXOxLAi1cWYo+7OjGm4Fy61GucasgLu/znPcEunI4Pi2RMNkzId0EW0X37/
         BK0Jn/kjf5CjVgLqy2pq341IIAInb60PIng6XnmGC8/BT8UQZyBZWqKKjgibfvzR2TaB
         s9VRmUew2mcv7WL9MTpDBgNOye5+ZJsHw0kFsXpdit5IldPysWo6wgnJNZlulAf64fwd
         3lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743006232; x=1743611032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDeO2nIfMOICmbdN4iB492bLj9a77KMSQWKqvg2E0aY=;
        b=KNvnKVlocUVMJ6PY7L7WzcKgLlmKaYVXySOrjbT0XA+4e2u0+fOPryYTGcKkc4NHW/
         LIlHt1SGLm6EokIQ4ZwOBI5IyohZEkiHysWJHtZnGDvL6Uzn5gFOU0ub1+pVIE2PQrPn
         RKrzTkFnZ9z0E9Qv/TGkg1O6Ol1uzDHRpaG4SQophsu0hnqOizOf+PuURf1S4Ce1mNZH
         nmDfPfSZc0Zed5Z4KpOUywvFXP+ZsRx3mB+peTUDVb12BD1ET60VgN4Qt339IqqYSWjI
         ngdgbLaLBvFfIwshCYL7Sk/N7qAJV3DYTSTPBH6u9AmSML1g4z574FiFEUQpapMhfHvl
         OyVA==
X-Forwarded-Encrypted: i=1; AJvYcCXW1ojBqayY1+ST/l1/c2axTA8mE/1J5cUkDsKOMJw74BuiXJXhyyuHwliDfUzSJhWcDf+Nnjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+DvB2ZQVgr8IKwTxvj8Dfg1tN5tFTP+yvtSqATRKptUPJbeW
	5MiAN85CtNfga9fvjegEVYLeCdYXSfPxrIbQjD7jKX8+B+c40FyU1eLlzP2r1hw=
X-Gm-Gg: ASbGncuya7p99Iw3pgtqv8r5t6pZ6yoW4E1VQQrixNQFQ5fdAvBlJq6RwhJHXXHMVKf
	nHLwucq6guG68k9/49UhdPYe/jX2V8fEI0iBnfX7jA61i9dCmtg349s8G4ZU64b0LsoLZqw1HVt
	GESJVDg88MqrC/LQfCjXPukGX4CwbQMP8TkGUPZMakbL/g6m5KjuR6ykCMbFFYwD1HfBFyXrICg
	oBOWFEHu/z3VhN50Oi/HF/KHtMEq7395GLbq7DsZAmqmxLVm3t+vtgxALzGzG3aOb9RLl2OlkrH
	yp4Hh2e7BxNhyA5KjTrUMoZp7q07my2D8e3VJ1nZ9EHqQ/Gs6hO/KryTIg==
X-Google-Smtp-Source: AGHT+IEc7BN+I9AuEBYkJp/jaWFUpD0J6wfKpFX9npNAzocR2TXh01hPKMJxC/w2Hwxq2f61h0F3IQ==
X-Received: by 2002:a17:906:6a04:b0:ac0:6e7d:cd0b with SMTP id a640c23a62f3a-ac6faf0b809mr4040966b.34.1743006232177;
        Wed, 26 Mar 2025 09:23:52 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6f0f498ecsm76678866b.135.2025.03.26.09.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:23:51 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Wed, 26 Mar 2025 17:22:58 +0100
Subject: [PATCH 3/5] arm64: dts: rockchip: fix internal USB hub instability
 on RK3399 Puma
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-onboard_usb_dev-v1-3-a4b0a5d1b32c@thaumatec.com>
References: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
In-Reply-To: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
To: Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 quentin.schulz@cherry.de, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Currently, the onboard Cypress CYUSB3304 USB hub is not defined in
the device tree, and hub reset pin is provided as vcc5v0_host
regulator to usb phy. This causes instability issues, as a result
of improper reset duration.

The fixed regulator device requests the GPIO during probe in its
inactive state (except if regulator-boot-on property is set, in
which case it is requested in the active state). Considering gpio
is GPIO_ACTIVE_LOW for Puma, it means it’s driving it high. Then
the regulator gets enabled (because regulator-always-on property),
which drives it to its active state, meaning driving it low.

The Cypress CYUSB3304 USB hub actually requires the reset to be
asserted for at least 5 ms, which we cannot guarantee right now
since there's no delay in the current config, meaning the hub may
sometimes work or not. We could add delay as offered by
fixed-regulator but let's rather fix this by using the proper way
to model onboard USB hubs.

Define hub_2_0 and hub_3_0 nodes, as the onboard Cypress hub
consist of two 'logical' hubs, for USB2.0 and USB3.0.
Use the 'reset-gpios' property of hub to assign reset pin instead
of using regulator. Rename the vcc5v0_host regulator to
cy3304_reset to be more meaningful.
The vdd-supply and vdd2-supply properties in hub nodes were
skipped, because hub power supplies are always enabled based
on HW design.

Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
Cc: stable@vger.kernel.org # 6.6
Cc: stable@vger.kernel.org # Backport of the patch in this series fixing product ID in onboard_dev_id_table and onboard_dev_match in drivers/usb/misc/onboard_usb_dev.{c,h} driver
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 33 ++++++++++++++++-----------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 995b30a7aae0..3a9049372e12 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -60,16 +60,6 @@ vcc3v3_sys: regulator-vcc3v3-sys {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc5v0_host: regulator-vcc5v0-host {
-		compatible = "regulator-fixed";
-		gpio = <&gpio4 RK_PA3 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_host_en>;
-		regulator-name = "vcc5v0_host";
-		regulator-always-on;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
 	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
@@ -521,8 +511,8 @@ pmic_int_l: pmic-int-l {
 		};
 	};
 
-	usb2 {
-		vcc5v0_host_en: vcc5v0-host-en {
+	usb {
+		cy3304_reset: cy3304-reset {
 			rockchip,pins =
 			  <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
@@ -591,7 +581,6 @@ u2phy1_otg: otg-port {
 	};
 
 	u2phy1_host: host-port {
-		phy-supply = <&vcc5v0_host>;
 		status = "okay";
 	};
 };
@@ -603,6 +592,24 @@ &usbdrd3_1 {
 &usbdrd_dwc3_1 {
 	status = "okay";
 	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cy3304_reset>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	hub_2_0: hub@1 {
+		compatible = "usb4b4,6502";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb4b4,6500";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &usb_host1_ehci {

-- 
2.43.0


