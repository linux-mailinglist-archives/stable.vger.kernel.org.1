Return-Path: <stable+bounces-154847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5503AE10D0
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 03:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7A84A03EF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 01:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F81B960;
	Fri, 20 Jun 2025 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="PoYffyj0"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A89944E
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750383913; cv=none; b=lUqJGrBRX9IYYQj33tlgf+tQwYI4EjU6xBKfJ79sTngvh+FSJcgD7VVMN9dswVJ6E3axP3sQYEjJlDOdNVfBefSX3cIAkoZTzEFg5rCBaP6r9uI+6gEDqf+7Rvg8KALz1c3YXeQC11xiqGuIIRh3mLCWLBdmL6BLrH6NGz/xAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750383913; c=relaxed/simple;
	bh=FhRKMKy05lVhxnfWHm0ZMgiK7k34GCLaWDFii4P6do8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOkOeljIbdAsWJ8ue6WD+2fAD5T5Qn28Fp2DDzd427RMeMYpDiIDw9HDEq0x1Gd9XAXjK129M6W0NCN3jE0JVoKPEwqli7gajah/KGXGOR11FE6Y1yLbHSwfuhVH0Qk0vrui5TJClhD3tbuE3uk6j+bfu9RM85BAQhMyFXG7pt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=PoYffyj0; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 55K1DWbB2909542; Fri, 20 Jun 2025 10:13:32 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1750381994;x=1751591594;bh=FhRKMKy05lVhxnfWHm0ZMgiK7k34GCLaWDFii4P6do8=;b=PoY
	ffyj0r0st2vuklIbUlo9cweVsHcrTPSuv+AR0mhROOHW/ZxpOkcmQUoMYPSKxHImKPNbn+/hUIpQD
	596AGqa42Vu6kqJZbvF3Sn18Kj4UdL+XJaC3ro46SjTch5U8YbB81+cwcbW3tsBexMStSUdlveTwA
	EepKkz4/YbkbZwOw9CUQpv+qB4uQBz7Jz4mUOEraTnEPRPC7Q40cvDsNj45mi/BG2bsAQD5oOlcbp
	sP+ZXqK4UxI9WFez3uSpVV0FRmljpbz4RHLdkNmB1yXpETqG1fo2BzFABaairV2NeWMN2cBK1pgS8
	R4aLdYF4P4HmwhBmr9ks8PYunklEaUg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 55K1DD2C3089032; Fri, 20 Jun 2025 10:13:14 +0900
X-Iguazu-Qid: 2rWhMjEQLsOAC1MWsF
X-Iguazu-QSIG: v=2; s=0; t=1750381993; q=2rWhMjEQLsOAC1MWsF; m=oVBygeYAFUgJDtA21ONfH+Ai2IIZkDYvtYTC7HrnQLw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 55K1DB8J1124427
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 10:13:12 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: cip-dev@lists.cip-project.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.4 - 6.1 3/3] ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms
Date: Fri, 20 Jun 2025 10:13:07 +0900
X-TSB-HOP2: ON
Message-Id: <1750381987-6825-3-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1750381987-6825-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1750381987-6825-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 929d8490f8790164f5f63671c1c58d6c50411cb2 upstream.

Commit b9bf5612610aa7e3 ("ARM: dts: am335x-bone-common: Increase MDIO
reset deassert time") already increased the MDIO reset deassert delay
from 6.5 to 13 ms, but this may still cause Ethernet PHY probe failures:

    SMSC LAN8710/LAN8720 4a101000.mdio:00: probe with driver SMSC LAN8710/LAN8720 failed with error -5

On BeagleBone Black Rev. C3, ETH_RESETn is controlled by an open-drain
AND gate.  It is pulled high by a 10K resistor, and has a 4.7µF
capacitor to ground, giving an RC time constant of 47ms.  As it takes
0.7RC to charge the capacitor above the threshold voltage of a CMOS
input (VDD/2), the delay should be at least 33ms.  Considering the
typical tolerance of 20% on capacitors, 40ms would be safer.  Add an
additional safety margin and settle for 50ms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/9002a58daa1b2983f39815b748ee9d2f8dcc4829.1730366936.git.geert+renesas@glider.be
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index b58b8b76724b..bfd26ebd7b9e 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -384,7 +384,7 @@
 		/* Support GPIO reset on revision C3 boards */
 		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <300>;
-		reset-deassert-us = <13000>;
+		reset-deassert-us = <50000>;
 	};
 };
 
-- 
2.25.1



