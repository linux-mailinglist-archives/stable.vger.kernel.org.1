Return-Path: <stable+bounces-151599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD50BACFEA9
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450D817801C
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 09:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3938F2857F0;
	Fri,  6 Jun 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b6IJU0qV"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11281FECDD
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200498; cv=none; b=pdp59YVO1VhMNE6EPSTS1PqcL0DFaRERQ0xe0YYJRX/8dkk42F9z72BH+rtBzWs8903lRR5lkohlTrOPMBa0hDcvrnQCPAF8PhpVeKe1cQfLXxL0GFZh9cr9zJqGQMiEg113rhkv6TExI7oYPHk6ad8DeVuc9ZTCkb6n825lwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200498; c=relaxed/simple;
	bh=OKp7Yv6MZSZRPCG8+sLBY7EacAUODYT77uVM6j/ZnWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQvSYQ0qji4edZcAAzlRhKBcp9BWuqe5dQJud+cCHJPaXQrubeH18saLMjasQB8lVGBOC2gLl9sSa9NuReqLgOfVyy7dYGwbDWQn62Fv97UmXgYpe5MUnxIKdwH3bUPZ1pB1uX7WtZLG9J/xncGd6EIBMy9S4E6cAF0rJwUZyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b6IJU0qV; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55691YQL169131
	for <stable@vger.kernel.org>; Fri, 6 Jun 2025 04:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749200494;
	bh=nS145VBWHkFKVTiQwI5/s4TUvCQw+LFwqvQo0D3Ni7A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=b6IJU0qVreAAcVrHoEEHrueT66My5HWJVEVlztcFrLiJkR9QCu83r3ufly6Brbk+X
	 ubC2fFBl4ugcDk8tDTfHX+ItVeSWthIyT50QcrhJNvBgHMT059KczUb5Mj8xe8FVeY
	 gEZm6rmRugTv+AGfDQA0uxaVcasKusUpFKFne02g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55691YCr1458769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
	for <stable@vger.kernel.org>; Fri, 6 Jun 2025 04:01:34 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Jun 2025 04:01:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Jun 2025 04:01:33 -0500
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55691Vpq725155;
	Fri, 6 Jun 2025 04:01:32 -0500
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <stable@vger.kernel.org>
CC: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 6.6.y] arm64: dts: ti: k3-j721e-sk: Add DT nodes for power regulators
Date: Fri, 6 Jun 2025 14:31:28 +0530
Message-ID: <20250606090128.2268237-1-y-abhilashchandra@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025060241-numbly-remarry-d1a6@gregkh>
References: <2025060241-numbly-remarry-d1a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add device tree nodes for two power regulators on the J721E SK board.
vsys_5v0: A fixed regulator representing the 5V supply output from the
LM61460 and vdd_sd_dv: A GPIO-controlled TLV71033 regulator.

J721E-SK schematics: https://www.ti.com/lit/zip/sprr438

Fixes: 1bfda92a3a36 ("arm64: dts: ti: Add support for J721E SK")
Cc: stable@vger.kernel.org
Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Link: https://lore.kernel.org/r/20250415111328.3847502-2-y-abhilashchandra@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
(cherry picked from commit 97b67cc102dc2cc8aa39a569c22a196e21af5a21)
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index ccacb65683b5..ced64f070140 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -183,6 +183,17 @@ vsys_3v3: fixedregulator-vsys3v3 {
 		regulator-boot-on;
 	};
 
+	vsys_5v0: fixedregulator-vsys5v0 {
+		/* Output of LM61460 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vusb_main>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vdd_mmc1: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -210,6 +221,20 @@ vdd_sd_dv_alt: gpio-regulator-tps659411 {
 			 <3300000 0x1>;
 	};
 
+	vdd_sd_dv: gpio-regulator-TLV71033 {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-name = "tlv71033";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vsys_5v0>;
+		gpios = <&main_gpio0 118 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
 	dp_pwr_3v3: fixedregulator-dp-prw {
 		compatible = "regulator-fixed";
 		regulator-name = "dp-pwr";
@@ -511,6 +536,12 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
 		>;
 	};
 
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
+		>;
+	};
+
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
-- 
2.34.1


