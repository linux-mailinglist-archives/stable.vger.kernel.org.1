Return-Path: <stable+bounces-75931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593B7975F5D
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 04:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC1F1F223A9
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 02:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DE9126C12;
	Thu, 12 Sep 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="a30FGlsg"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9CB126C00;
	Thu, 12 Sep 2024 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109785; cv=none; b=TTMckPJftfMI2SaDRN0WsOPxIhf6jRuTDQKDN2mjJQ8TcthihXsB3RJSPzo5oBAkEGbd61eZI9q7Bzvvnzni2MoGuw9lSrqZ4WQm0DFmwX6u6iVIDdetlZmdRwbAxGOBsKgdCqEhMUfLJDWji1P1uaKcO7Vf/SyxPTUW7oOvKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109785; c=relaxed/simple;
	bh=hzQLSexYJUTVNwfwScwzXWQ5Pr5/awzQW9UMQZUybwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY2ZB1vFsPcKWRWRI7mM8kCukLRY5eJL/6MMLBBbt5RRNpdlpjH/oCY85BP+kd+soLXU8H2HpJEL3/Q5CBrIbF0K6fzfSIpam3ngoTF2OBgu6DzP+H3qUSdyyCZ8XtNRjzt5hgML8ZQ9+A6i1aoc+xyO4rtC8R+7sEYdyh4RAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=a30FGlsg; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726109772;
	bh=fuJldeFwoBfDtWnj6iOEtuABcrF6h38R0IgDAihTt+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=a30FGlsgJH+vgLeyzbnDJtEvuz5DUcDRt48d0ud0+y6kuWcBLlFf2SCXR76RZAqrw
	 HuV9c7zVqUtRy2zvFPAlj9W1x/p0YNEczPVl9J8m1f80M0mbe1ixntJAr+EFmbaLfq
	 Dy5wfCNOn9dADKY/HtxQqIF9++K5I6ucnrfVMm4o=
X-QQ-mid: bizesmtp81t1726109767twoddh5u
X-QQ-Originating-IP: rsJS78F8Lxt9WZcr11/PxrwMaQy1gfDbNwUdwXxhx/o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Sep 2024 10:56:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17950901985423376830
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	william.qiu@starfivetech.com,
	emil.renner.berthing@canonical.com,
	conor.dooley@microchip.com,
	wangyuli@uniontech.com,
	xingyu.wu@starfivetech.com,
	walker.chen@starfivetech.com,
	robh@kernel.org,
	hal.feng@starfivetech.com
Cc: kernel@esmil.dk,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 6.6 v2 4/4] riscv: dts: starfive: Add JH7110 PWM-DAC support
Date: Thu, 12 Sep 2024 10:55:08 +0800
Message-ID: <FEB1C345F6214D57+20240912025539.1928223-4-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240912025539.1928223-1-wangyuli@uniontech.com>
References: <20240912025539.1928223-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Hal Feng <hal.feng@starfivetech.com>

[ Upstream commit be326bee09374a2ebd18cb5af8fcd6f1e7825260 ]

Add PWM-DAC support for StarFive JH7110 SoC.

Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 49 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 13 +++++
 2 files changed, 62 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index caa59b9b2f19..0e077f2f02d1 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -40,6 +40,33 @@ gpio-restart {
 		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
 		priority = <224>;
 	};
+
+	pwmdac_codec: pwmdac-codec {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
+	sound-pwmdac {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "left_j";
+			bitclock-master = <&sndcpu0>;
+			frame-master = <&sndcpu0>;
+
+			sndcpu0: cpu {
+				sound-dai = <&pwmdac>;
+			};
+
+			codec {
+				sound-dai = <&pwmdac_codec>;
+			};
+		};
+	};
 };
 
 &dvp_clk {
@@ -253,6 +280,12 @@ &mmc1 {
 	status = "okay";
 };
 
+&pwmdac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwmdac_pins>;
+	status = "okay";
+};
+
 &qspi {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -463,6 +496,22 @@ GPOEN_SYS_SDIO1_DATA3,
 		};
 	};
 
+	pwmdac_pins: pwmdac-0 {
+		pwmdac-pins {
+			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>,
+				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <2>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
 	spi0_pins: spi0-0 {
 		mosi-pins {
 			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 621b68c02ea8..9f31dec57c0d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -536,6 +536,19 @@ i2srx: i2s@100e0000 {
 			status = "disabled";
 		};
 
+		pwmdac: pwmdac@100b0000 {
+			compatible = "starfive,jh7110-pwmdac";
+			reg = <0x0 0x100b0000 0x0 0x1000>;
+			clocks = <&syscrg JH7110_SYSCLK_PWMDAC_APB>,
+				 <&syscrg JH7110_SYSCLK_PWMDAC_CORE>;
+			clock-names = "apb", "core";
+			resets = <&syscrg JH7110_SYSRST_PWMDAC_APB>;
+			dmas = <&dma 22>;
+			dma-names = "tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		usb0: usb@10100000 {
 			compatible = "starfive,jh7110-usb";
 			ranges = <0x0 0x0 0x10100000 0x100000>;
-- 
2.43.4



