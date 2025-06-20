Return-Path: <stable+bounces-155126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D191AE1A17
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9322E3AAF3E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F04928A1F5;
	Fri, 20 Jun 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BohbTiIb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA25F21A425;
	Fri, 20 Jun 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419381; cv=none; b=noJDnQogdlzccvjsDb7T0mLzbBJ6BwBn9VrzXC5mSIAZjDLGSoQukX2pX9VluyPJS7ROT4rgY9tyB9TKj1lUt/80wDVwQYn9Xf5dMMtPVzYpc4teYQDhcz5WcVXxAef1XMHyVTR2D47bHFYt7D+GQwcn/s+vNDON/iIeDJV4Zqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419381; c=relaxed/simple;
	bh=181XCfZFeoCqzP3BHsr5DlF2rNauxT+33Un4k812hxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Lxk+EwGk0duUTnSMmxyJYofvIsXQNVSeiKKMQO7HZr3L2bRkE+G/N8yJmdlNQbXP2oQkDsZ0kN9bO3ze/chGy6GVn4J6gWmMH20zaI4mp3BrMsPFrQr1dvZ4p78rczXcN1YSvib0FpswE1eTI10aZZ2UdxCogFnnGHUJwIuxQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BohbTiIb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso3050547a12.0;
        Fri, 20 Jun 2025 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750419377; x=1751024177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcgXI/SwiX/bwD34wkRIbcjhA4z+lQnGQOUOu85+vT8=;
        b=BohbTiIbrLrhkym6CKHl6sk6t5yijSWsU4OJj667QvSlmkNHKZ5ZeVLHMokSp9pKHo
         uQuOx++ZOC0Z4n/PtoEjZbA91O6fexPa6am6Y+QGREF/5rCJZlzCNQgfZl3+oA4gglXH
         xyl1aSD0UjJHjUwsLlV/p29e5M6JkYB3hUOe2WrIroPrsiRvTkDhWzszwhOuCx30iLt/
         etMpx4xV9trZP2ezRxcd3oKimtKMK27JRR1Yf68I1ltYxXSdUVCfHtT+lZjn1yMU7YJ9
         wSQdiorvb+2QFygla+NH7VcHPZdc3IKXp4EaWI3UTi4uYpBOz7y6zNMEjgDCWBmFbgRV
         riOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750419377; x=1751024177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcgXI/SwiX/bwD34wkRIbcjhA4z+lQnGQOUOu85+vT8=;
        b=LuxtKIV09/zzYgv3CV6jBSiahWC+SB386ku2LykZRBOceGpYlENt0CfLu4wKZC97Qv
         16+wwWVtjQkwZAMdqO2VFwM6fPbCnbH972L+MG4pB8XRrc5cz0aI0MrQ9slNkOz6C64k
         cI7JzM2jsWB8zcKtxWGSprmtppyKykG5vSpvJA+x3GZBLnEDcN7RS+yPWs9UG1w3myro
         IjE/g4PPYrFmTgCuaxzfanPbbVTG7/BOEGNnNG/DgO7FVf3CpayZ+JTnkKcScg1PPdSw
         JJg3LdBAZfPCovoi03Tmr1hY3bZ1PQhwbF8DrfabJFzMLQPBNgnDOimATnGQhlyJAcu4
         4fnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB01RgIku8YsWWIQG6M0jOH04AywBIKcUV6aE9oOavV+R0Ulk5bBXeTXybVn1Yot2MvdW5QgKy0/Q3@vger.kernel.org, AJvYcCXcVT4WeyO8ORmwpO/7SJLKamm+b3H7c11+S30XMPxqilXQ+c9U37tblcTrNrp0UzM1btQG3ph06T2ACnFZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/22kxHJxIMYnJwzydRJwbDYybcIeeuNeAd8WYYD+lEci/JgB0
	ZUFOZq7u1CE8190LYL821q3eYeKDuJ6GfZmbvOjU81FLFzxMH2KG0AVp
X-Gm-Gg: ASbGncvy5KZ5vFaO4IjCRefF2eHv7sTCaqJNZ5wZTzKbxEyQ4jAGaCc0hgUBSf/DFk+
	vaEZKKVpKYbIM455fi+edcxKq1wNiJDjAlQ1qaBm29nXlQs6oak+ZamzMOXFUj0/pEXpOd0tX9S
	jYE4Begl6GHROdW7kkkkcl+tOKvfypqHxzagH/S2TtFspGJWZft+WNaq177ttuN0zOtOKvcVGWb
	KDig6BxChAFzcgxu/aMa3+9Y3xoueXnUTg+8WDMInSr9GR9yiSKjkuE3ZJDbM17DG+EwyOECLXu
	LoGaHkXCqX9uMPnYV4j6PumdnJNGUp6MR7bgCyuzXEs8umWFP0HkQYzTd1vji61td0mi/2orXwz
	xCy7od85YaSKybA3drDsWRgzCvDyH8/bDTijfXSD2
X-Google-Smtp-Source: AGHT+IHBoM3zuM2+rcjourKLd9oqU11oDVF2zMJ82/RpbVFFdMzcRAVeWNOk+uMVQHC4Dg6qq0mMDA==
X-Received: by 2002:a05:6402:2749:b0:608:42f9:a5cb with SMTP id 4fb4d7f45d1cf-60a1cd314aemr2249040a12.10.1750419376882;
        Fri, 20 Jun 2025 04:36:16 -0700 (PDT)
Received: from localhost.localdomain (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18504e95sm1302003a12.4.2025.06.20.04.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 04:36:16 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Johan Jonker <jbx6244@gmail.com>
Cc: stable@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: use cs-gpios for spi1 on ringneck
Date: Fri, 20 Jun 2025 13:35:46 +0200
Message-Id: <20250620113549.2900285-1-jakob.unterwurzacher@cherry.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

Hardware CS has a very slow rise time of about 6us,
causing transmission errors when CS does not reach
high between transaction.

It looks like it's not driven actively when transitioning
from low to high but switched to input, so only the CPU
pull-up pulls it high, slowly. Transitions from high to low
are fast. On the oscilloscope, CS looks like an irregular sawtooth
pattern like this:
                         _____
              ^         /     |
      ^      /|        /      |
     /|     / |       /       |
    / |    /  |      /        |
___/  |___/   |_____/         |___

With cs-gpios we have a CS rise time of about 20ns, as it should be,
and CS looks rectangular.

This fixes the data errors when running a flashcp loop against a
m25p40 spi flash.

With the Rockchip 6.1 kernel we see the same slow rise time, but
for some reason CS is always high for long enough to reach a solid
high.

The RK3399 and RK3588 SoCs use the same SPI driver, so we also
checked our "Puma" (RK3399) and "Tiger" (RK3588) boards.
They do not have this problem. Hardware CS rise time is good.

Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Cc: stable@vger.kernel.org
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
 .../boot/dts/rockchip/px30-ringneck.dtsi      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index ab232e5c7ad6..dcc62dd9b894 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -379,6 +379,18 @@ pmic_int: pmic-int {
 				<0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	spi1 {
+		spi1_csn0_gpio: spi1-csn0-gpio {
+			rockchip,pins =
+				<3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
+		};
+
+		spi1_csn1_gpio: spi1-csn1-gpio {
+			rockchip,pins =
+				<3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
+		};
+	};
 };
 
 &pmu_io_domains {
@@ -396,6 +408,16 @@ &sdmmc {
 	vqmmc-supply = <&vccio_sd>;
 };
 
+&spi1 {
+	/*
+	 * Hardware CS has a very slow rise time of about 6us,
+	 * causing transmission errors.
+	 * With cs-gpios we have a rise time of about 20ns.
+	 */
+	cs-gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_LOW>, <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&spi1_clk &spi1_csn0_gpio &spi1_csn1_gpio &spi1_miso &spi1_mosi>;
+};
+
 &tsadc {
 	status = "okay";
 };
-- 
2.39.5


