Return-Path: <stable+bounces-154844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0A2AE1090
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 03:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB34189C654
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F75C1754B;
	Fri, 20 Jun 2025 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="xwdWGhte"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612430E831
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750381828; cv=none; b=B9iI7QJ0FJUDPlXX8I4j0b4Eh6Ye4tuS4e3wfRY4+EB+yD1C6R17F1T9G2NS3S2/nDEuVr40YMxnYAZftCqYT66WtudGOipqhuhMHCUEZDBekt+kW5lR60XmN+keURXmVP4ZOrig6jEHu9NttN47hRuqUcgs8RJHrqYC7EPL68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750381828; c=relaxed/simple;
	bh=pRpjLzaDNQia2HV5nrTBtjzyGA3g7X7KMR1a3Kr/jO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQXoD4B73+FnFBCLCTQ3oNlUe9nelFmvjLPU0QMsQ07z7ajndm+k3r8tDditN3UxKdMtaDpi3+i3nuhr2s6lkMwHdoG5hwFaXfq4sXBJzhUEOcmXqqFFmJq63SlilKExDMVCoQtRN1XMJU3Eei1Et/XomBcBgHc9SiBPJe73fEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=xwdWGhte; arc=none smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1750381803;x=1751591403;bh=pRpjLzaDNQia2HV5nrTBtjzyGA3g7X7KMR1a3Kr/jO0=;b=xwd
	WGhte1G5wj1xzedbNWKeyxtCSdVvI1HDlRgjlX3EeD6c52wwz5xPqxsu+yUWAniSbenx0ct54qE/U
	akBF0ZTUEYE9y6/TQQFSjuDASqRs8lcvBIddN193CrYOIs6gmWL3XAq1GSEgB0GFF+AOqjntToIlu
	RcNbgNPMbxqu2u9Kt69EStBY3wQdr1wqouSU3hp5kWr5gTyjbPE81gxgfRJbIrkSboN1+g+UWddcz
	bQ2XnJYarpPTfk7MMmdq6P5pTs2f1V5Sd3BGKs5WA6AW6WNwjjCXsPdRmJOMAvJnbw6RlUWBAFk4o
	tp7FGpSdSdPyF45pPyT3naOst0MWTVA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 55K1A2ee028458; Fri, 20 Jun 2025 10:10:03 +0900
X-Iguazu-Qid: 2rWhWAeBn5ajNtr3aP
X-Iguazu-QSIG: v=2; s=0; t=1750381802; q=2rWhWAeBn5ajNtr3aP; m=HK/zbaNcpy4GWO+YGRXgVsiug2xIMBuyG5FUkTjBUF8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 55K1A0oB1115216
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 10:10:01 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org
Cc: cip-dev@lists.cip-project.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 6.6 2/2] ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms
Date: Fri, 20 Jun 2025 10:09:56 +0900
X-TSB-HOP2: ON
Message-Id: <1750381796-6607-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1750381796-6607-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1750381796-6607-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
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
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index 4867ff28c97e..27e73e745e25 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -385,7 +385,7 @@
 		/* Support GPIO reset on revision C3 boards */
 		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <300>;
-		reset-deassert-us = <13000>;
+		reset-deassert-us = <50000>;
 	};
 };
 
-- 
2.25.1



