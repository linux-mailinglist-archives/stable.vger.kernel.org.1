Return-Path: <stable+bounces-194779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BF0C5CA02
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 11:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDC9734847A
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8FF3081A7;
	Fri, 14 Nov 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fyXooem/"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928FB2F5A22;
	Fri, 14 Nov 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116450; cv=none; b=PLXHPVMVMFJJBxB1jZ3V+7kfhiLXmnZHqqhMa403MRmraSg1sgsAEf/B/UTpcG/NVP0cQmY+Hngm5YfuIZc0hdi17XGJU93RHhFEjjlFW9FCRZTsRiXgVNoH7Hcabkw2mN2/yx+fI6JebYOk3Fo2G6gDrv1U4sasn5tsK+D13Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116450; c=relaxed/simple;
	bh=D9cxNLkNziaEdzUnkoYLDeMaPHjBAxKPggl+Zh8QZpU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKdn4kP/uiUVVag6+Wddf0IgoBev4WUalT7A8CFnXvLD+Q/Ejw8jEZztk43Xws+TBAPZ/h3vD0+hSf9mE7WJss2VJTPtKBs/hgXCenZIE+xtfXNY1edVWVbvDBQ+lJNtx5uC2+2A4BLbnT8kJQQG0VCwhHC8C8WmNkg8bs4sIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fyXooem/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763116448; x=1794652448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D9cxNLkNziaEdzUnkoYLDeMaPHjBAxKPggl+Zh8QZpU=;
  b=fyXooem/B7wzDuUzoRYbJRKkZF7XfxPR6kP34zTSwVfMIpRKe9kiZgYe
   +761DG9XKknaHYAKbSNXPHt+zivdxaY9UQeso4lgPKa4wI8VNvsMEpvR7
   BMEgN2mK37z0G1F+1WumL2IouJOne+uQCWbMYgI5OFnIauhRAfLsidCoH
   j6IS59CoVnegafbbdNEcPU7IOM8Yj+9Xb3UAcHE2ozDvspgeNZazNlZBc
   sHy7ciydksJA8HVmT0N8ZX2xdErxYeVA6CWGRvgllerk2bY+qdCbZk454
   iocCMTsUgBVn4qis7IBXG5c7fHMSJzOZ3WAuTIvSDXobWtQcoRY91qixr
   w==;
X-CSE-ConnectionGUID: Bmgk/fX/QBGabdIqtVBXBQ==
X-CSE-MsgGUID: wIk1cWa8SLKfj1V6vLzLuw==
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="49627358"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 03:34:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 14 Nov 2025 03:33:30 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 14 Nov 2025 03:33:29 -0700
From: <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Ryan Wanner <ryan.wanner@microchip.com>, Cristian Birsan
	<cristian.birsan@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/2] ARM: dts: microchip: sama7d65: fix uart fifo size to 32
Date: Fri, 14 Nov 2025 11:33:12 +0100
Message-ID: <20251114103313.20220-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

On some flexcom nodes related to uart, the fifo sizes were wrong: fix
them to 32 data.  Note that product datasheet is being reviewed to fix
inconsistency, but this value is validated by product's designers.

Fixes: 261dcfad1b59 ("ARM: dts: microchip: add sama7d65 SoC DT")
Fixes: b51e4aea3ecf ("ARM: dts: microchip: sama7d65: Add FLEXCOMs to sama7d65 SoC")
Cc: <stable@vger.kernel.org> # 6.16+
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index e53e2dd6d530..cd2cf9a6f40b 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -557,7 +557,7 @@ uart4: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				status = "disabled";
 			};
@@ -618,7 +618,7 @@ uart6: serial@200 {
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
 				clock-names = "usart";
 				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};
@@ -643,7 +643,7 @@ uart7: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				status = "disabled";
 			};
-- 
2.43.0


