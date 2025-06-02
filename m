Return-Path: <stable+bounces-150634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02E4ACBD53
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 00:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A383E3A39C9
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E6227E92;
	Mon,  2 Jun 2025 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mzLKaXl3"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC741C3BEB
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903311; cv=none; b=Qliva1/Oe6xylJhzl05xvpiUiyAOI0cSN0Oa9VCukX1ofrwwEnCjs/0pA5GLyFFtdkbENV1TK7ivx3c4G1opI6tRa6QNzs0VkKQy47+4nUgrv0Mo5bzEmwMVZCOqLD461cH2xqMmHX6mLp0ipXlcYByMVexY5Ioh1su0Tmz/5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903311; c=relaxed/simple;
	bh=5iAAecQzuywCKDy4jty7JO7m1NSq4Tfq05NT23Jh/3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0z4225Ai70dQldbjuUk3DmzMrm+hZNRmsxB7b0zd3RleaPhRVQAY3YtSdpNONoB58Rq9L27hAgd0JkhfIYiCI1TQ1c3o28gr8kYiLWCKAoeQAkqYnMl2GVudvTxA9EXw1AOQVfam3m/p5BfGfO33N05P4P5Y7hCeYx/wVn18h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mzLKaXl3; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552MSSSH3337430
	for <stable@vger.kernel.org>; Mon, 2 Jun 2025 17:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748903308;
	bh=ExrIZsqt/m5GMQKKzG08y522zwwT/R63g1pkb9R7vfs=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=mzLKaXl3HB4XfLYTEDFbpCCWoaRFg7rWMRet3fS5AGpIawR+c1X7r6X+pUWQ7hlW3
	 koU0S/j/gQnsKTMK5w62R9sdxNzEEODh936uUJrUO51WHL4R3S1037ixXqIedi1USO
	 TYoNsEmqoVgNz0AoIXrGjP13S81h5E78jqIPXmj8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552MSSiP3278075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
	for <stable@vger.kernel.org>; Mon, 2 Jun 2025 17:28:28 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 17:28:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 17:28:28 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552MSRWv3688935
	for <stable@vger.kernel.org>; Mon, 2 Jun 2025 17:28:28 -0500
From: Judith Mendez <jm@ti.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 6.6.y] arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
Date: Mon, 2 Jun 2025 17:28:27 -0500
Message-ID: <20250602222827.86162-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025060218-subdivide-smashing-0ef7@gregkh>
References: <2025060218-subdivide-smashing-0ef7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

For am65x, add missing ITAPDLYSEL values for Default Speed and High
Speed SDR modes to sdhci0 node according to the device datasheet [0].

[0] https://www.ti.com/lit/gpn/am6548

Fixes: eac99d38f861 ("arm64: dts: ti: k3-am654-main: Update otap-del-sel values")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://lore.kernel.org/r/20250429173009.33994-1-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 57befcce93b9..2e5f4f1af52f 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -447,6 +447,9 @@ sdhci0: mmc@4f80000 {
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x5>;
 		ti,otap-del-sel-hs400 = <0x0>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-mmc-hs = <0x1>;
+		ti,itap-del-sel-ddr52 = <0x0>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
 	};
-- 
2.49.0


