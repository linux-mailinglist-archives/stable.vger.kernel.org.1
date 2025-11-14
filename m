Return-Path: <stable+bounces-194796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAEDC5D783
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 15:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15E834E250F
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6817A23EA90;
	Fri, 14 Nov 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1cF2MjEp"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD0235045;
	Fri, 14 Nov 2025 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129006; cv=none; b=J3LmoroQ/oz3MWX0il0LCVpXLRX5K9e0Q43rzn/CB/jzXxqpF8l51Aae9UtZ48jukx//ldUVPQgOWuWpiI01Z7jVrY4TUO2sZr6nbN54jLKLM+23irebDlKTljHm76e3h31MwvRqpGqF6SJX2WE6tKeKWMr4+nm5ARYZii9o1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129006; c=relaxed/simple;
	bh=MF6lEcNrnbfIGxvdoroFyYqa+YDisNyeVAqwm+WGhoU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s7yTBSSnzbySQ+0AoHU6q4mTLWZU83Zo/hfv+8au5NNe5mUhvjMgdTyNpJzOZ9tAhzGv93nfYe/EE5PbtcE5TNYsP1cjVuXSQ33aG0ZtxhjU6vF/6Hn5/fqR3btblrL8EUtqsIgHgsZ+L/Z3HZkA0m1bGPmQ+a66e5pf0vnVDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1cF2MjEp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763129003; x=1794665003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MF6lEcNrnbfIGxvdoroFyYqa+YDisNyeVAqwm+WGhoU=;
  b=1cF2MjEpcPHwQ8UUwOMRBfG4+2IfJNZWK8NglNxljuIrKqO5Ps+jKpTo
   eymMhh0lpQpYwvGWyUVB+rwEXlZJFJ391rS+F3AK9xO0q3zkZaqHjzlE0
   ylT+lvEr8KcAhbeIHOQO1OanBq35h4v7adUo0BidKugpsjba++/gTQXwl
   MpLjV9ZediugynE/BnzpZUvXipj/7FvOG99bdDIE8mxfsytFRiXQzt7NF
   3mjT0uqIaF5+EqAijojD6FHIJM1pwxX8BAnKr65rLu1E+q9Rz0lIuUhQO
   ooZfm2WV+tkzsQwO4of0EZSHxbudfnLc1orluI85xlVoxjLdha0Kt8FyZ
   g==;
X-CSE-ConnectionGUID: l9mv0GkxTh+6KMovRGk/tw==
X-CSE-MsgGUID: 1qnqnpunTi65aAGenUQSgA==
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="216469338"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2025 07:03:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 14 Nov 2025 07:02:42 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 14 Nov 2025 07:02:40 -0700
From: <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Ryan Wanner <ryan.wanner@microchip.com>, Cristian Birsan
	<cristian.birsan@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] ARM: dts: microchip: sama5d2: fix spi flexcom fifo size to 32
Date: Fri, 14 Nov 2025 15:02:25 +0100
Message-ID: <20251114140225.30372-1-nicolas.ferre@microchip.com>
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

Unlike standalone spi peripherals, on sama5d2, the flexcom spi have fifo
size of 32 data. Fix flexcom/spi nodes where this property is wrong.

Fixes: 6b9a3584c7ed ("ARM: dts: at91: sama5d2: Add missing flexcom definitions")
Cc: <stable@vger.kernel.org> # 5.8+
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/microchip/sama5d2.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sama5d2.dtsi b/arch/arm/boot/dts/microchip/sama5d2.dtsi
index 17430d7f2055..fde890f18d20 100644
--- a/arch/arm/boot/dts/microchip/sama5d2.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d2.dtsi
@@ -571,7 +571,7 @@ AT91_XDMAC_DT_PERID(11))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(12))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -642,7 +642,7 @@ AT91_XDMAC_DT_PERID(13))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(14))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -854,7 +854,7 @@ AT91_XDMAC_DT_PERID(15))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(16))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -925,7 +925,7 @@ AT91_XDMAC_DT_PERID(17))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(18))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -997,7 +997,7 @@ AT91_XDMAC_DT_PERID(19))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(20))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
-- 
2.43.0


