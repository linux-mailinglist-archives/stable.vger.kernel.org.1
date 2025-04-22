Return-Path: <stable+bounces-135202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F1AA979FD
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 00:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934091B60109
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D51270563;
	Tue, 22 Apr 2025 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gNp86gIo"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF422BE102;
	Tue, 22 Apr 2025 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359531; cv=none; b=ECyLamuFSXhO7RTYXNkqJqzRzJPBNa2OnYTdhJMoEapoM0g38waX81q+YLNw7FxqpTFzOuDQr0c/X+4thpzm7oWQB4Cpr4W2HEW+ZFkopKLOyNjL5tP4t5DZq6B+/RsMEEylQIO4GT4uAQntfGfC6iYpzzoQXPs/4VLQDW/n16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359531; c=relaxed/simple;
	bh=dROXq7MGD8SnzKaeA5JRhYPc0bHQiWBBS3c+LKff70g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8TAWJvfx2GUNVVeMVVRs6EFJQwm9QhSJxKru9AWDmBKSZA6yhmKZVhYbRE1sSs6/8ahlqKU9hdZYWXWFEdQz+JMet14uYrDX9COe3czhVmexLeHAthjK3ixTods5sl3XQvnqn7WIPpfS89b6Nx7gYJ5qt18GZR9y9SOdkgt4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gNp86gIo; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MM5D4Z1353991
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 17:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745359513;
	bh=x4pJOvfSWdXFtA3Vu2W/bJKu8o1yhDi/KoiZOv1/400=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gNp86gIo41eHZK7MT4wJNhBRrzGhnHD/ECqfOOpsysyhxk2XxACKcvwyUoAMi/jLq
	 8l8SYADl4Zx3ZeyYMFJ83/ryo5cOL13Q6o+G8eMuZdbPgdtva3PkSUnR4SQVE0ip2G
	 h9zQFzwQfSP/1vK0CXs8OmF0AevHkBe23gJTEHzA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MM5Dm6019162
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 17:05:13 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 17:05:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 17:05:12 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MM5Crf012605;
	Tue, 22 Apr 2025 17:05:12 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth
 Menon <nm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Hiago De Franco
	<hiagofranco@gmail.com>, Moteen Shah <m-shah@ti.com>,
        <stable@vger.kernel.org>
Subject: [PATCH RESEND v3 3/3] arm64: dts: ti: k3-am62*: add ti,suppress-v1p8-ena
Date: Tue, 22 Apr 2025 17:05:12 -0500
Message-ID: <20250422220512.297396-4-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422220512.297396-1-jm@ti.com>
References: <20250422220512.297396-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add ti,suppress-v1p8-ena flag to sdhci1 nodes to suppress
V1P8_SIGNAL_ENA.

On am62x, am62ax, and am62px SoCs, there is no internal LDO
tied to sdhci1 interface so V1P8_SIGNAL_ENA only affects timing.
Suppress V1P8_SIGNAL_ENA since it causes init failures across
Microcenter/Patriot SD cards and Kingston eMMC on am62* SK boards.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi               | 1 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi              | 1 +
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 7d355aa73ea2..a61153b0af32 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -586,6 +586,7 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,suppress-v1p8-ena;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index a1daba7b1fad..44d973caf200 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -606,6 +606,7 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,suppress-v1p8-ena;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 6e3beb5c2e01..c4304dae9757 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -604,6 +604,7 @@ sdhci1: mmc@fa00000 {
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
 		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,suppress-v1p8-ena;
 		status = "disabled";
 	};
 
-- 
2.49.0


