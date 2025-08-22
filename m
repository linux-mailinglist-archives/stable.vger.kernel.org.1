Return-Path: <stable+bounces-172419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1ADB31B2E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB763B517E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A22FFDEB;
	Fri, 22 Aug 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcS03B7p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C93054EB
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872179; cv=none; b=doNifh2GEt+cNdtK5g62NtFjI2B5K55UPtFYaof3+pklB93XCIMI4b1yL1duRfp862Z8c2Xibl6TutOcUfBZRuS3SQ9PpQvHDX5xtwhHWSiyhYEs/rTr5BCwlMD5BzM7jONGI5/TDuJ5bZKIM+2QvHR7jdeQssXsxU2ADGQPQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872179; c=relaxed/simple;
	bh=5XQ2J6j2oqIOEp14rW+09oT3KM4XVNyUBfSY8gyDm18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwgEPtgh6VP9WqEr2RGQFvSavn6eYCmVzOHmOi1eWz6g1hB8hDvgd3If0IUWOPpUlWpq8z0x9uDj5hwPXv2pS56n5dfpmxRN2bt7RO88loYzeSlFHxtyDOK4Gy/BFfWeuY8HtKMullSGtusySHulR60VXqmrTwpfD3ZoYggOLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcS03B7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31C7C4CEED;
	Fri, 22 Aug 2025 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872179;
	bh=5XQ2J6j2oqIOEp14rW+09oT3KM4XVNyUBfSY8gyDm18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HcS03B7p/ynakr3gFL2/0F1+FEUXBbMDGcejdDIR95duQCypBVToxb+DXcXKvBUr7
	 aE/hQ0QNATAaVBwqSQT9qRdbXRktvZXOkeT2e1Vju/md1BJZiJObbzQeK1gjVxxg15
	 NrgIwbWTj9XcNB8lJDQYbRIgeB96YmCmJOYagDpavYSKkCRU5IsAtX6rHNuZbz2BPC
	 v1JMos355RRUG0hY5zOZkaJkTi42DX18wvzlcSPGEBomrroY1V07GDuNhM7SCeAF8l
	 HXC33HJIW9yIDzrZHyDnImzorEyOQf8VKAbAiqAVHlLHXE20BTj9NzV/ypf0QjYklT
	 zULMfEYYfw0Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Moteen Shah <m-shah@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] arm64: dts: ti: k3-am6*: Add boot phase flag to support MMC boot
Date: Fri, 22 Aug 2025 10:16:12 -0400
Message-ID: <20250822141615.1255693-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082104-undermost-dispute-929c@gregkh>
References: <2025082104-undermost-dispute-929c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Judith Mendez <jm@ti.com>

[ Upstream commit db3cd905b8c8cd40f15a34e30a225704bb8a2fcb ]

The bootph-all flag was introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across
different boot phases.

For eMMC and SD boot modes, voltage regulator nodes, io-expander
nodes, gpio nodes, and MMC nodes need to be present in all boot
stages, so add missing bootph-all phase flag to these nodes to
support SD boot and eMMC boot.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://lore.kernel.org/r/20250429151454.4160506-2-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Stable-dep-of: a0b8da04153e ("arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts  |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 8e9fc00a6b3c..aafdb90c0eb7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -69,6 +69,7 @@ vddshv_sdio: regulator-4 {
 		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
+		bootph-all;
 	};
 };
 
@@ -77,12 +78,14 @@ vddshv_sdio_pins_default: vddshv-sdio-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
 		>;
+		bootph-all;
 	};
 
 	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (C13) UART0_RTSn.GPIO1_23 */
 		>;
+		bootph-all;
 	};
 
 	pmic_irq_pins_default: pmic-irq-default-pins {
@@ -118,6 +121,7 @@ exp1: gpio@22 {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
+		bootph-all;
 	};
 
 	exp2: gpio@23 {
@@ -229,6 +233,14 @@ &tlv320aic3106 {
 	DVDD-supply = <&buck2_reg>;
 };
 
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_gpio1 {
+	bootph-all;
+};
+
 &gpmc0 {
 	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 67faf46d7a35..212119959dfd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -301,6 +301,7 @@ AM62AX_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
 			AM62AX_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
 			AM62AX_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
 		>;
+		bootph-all;
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
@@ -603,6 +604,7 @@ &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
 	disable-wp;
+	bootph-all;
 };
 
 &sdhci1 {
-- 
2.50.1


