Return-Path: <stable+bounces-194780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23877C5CA11
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 11:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33DCD359820
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197673128DC;
	Fri, 14 Nov 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OXLYGZwD"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449B3054FD;
	Fri, 14 Nov 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116451; cv=none; b=ZrMMovVgY8XPJx5bi0qjk5jhNgh+1LeMmbsBUxD8+vaOWfcfC0d6a1xeHWDuVSOVA7/9fTYfz6NGj7sxR1ZjHrDYkWsAjMWoydef+JODyyYKCsfsVtkjdJJ3UPOQPJPuEf6r+FyAKP9j/uyaQY639n3khlb7QtYYnorYhqBF0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116451; c=relaxed/simple;
	bh=KPMD6p9uhlCxkQRs7hFiFLlZgxILwM9Wd1Kk2DwCaLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bN4cyPy7QZ7gJSzGKBB4yhttRC9kawyxap0IfazOdsjgnF8cD7i7/buz3HF9qt+xOdb7Fs7sme86Nxnak58YdwEbxh+jNFqmc8zftv3HQvs7hLEEncrwMbvpEcSajJTUlatFMGnWRWASs0t5Sg7osnmaK7O/v4vZ/LAD26LkxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OXLYGZwD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763116450; x=1794652450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KPMD6p9uhlCxkQRs7hFiFLlZgxILwM9Wd1Kk2DwCaLw=;
  b=OXLYGZwDfrhvcQLyhN//HJ+Bv4QXnI5btHiUnPUCx+rPfN51+bVGtD25
   6aInxBxhdiR566UaFwg/7TAuiefJ+mN7ouWdVZJOLzmP2wCboydHoBUPI
   vLAZW1BozOqllE18Wf8VBU7DV13OoFk9xm+FV7txwKwLR4gG7kS68EQsY
   yBdF89dNz1o6zgN5FznobrG6YedygRVoO1JlAxeuZVjBaw0TY0q3zke6l
   GbfKK2gkTVppxyUgKs2XVQpu4zT572nfKdzFH2Fk8U9QMv2Nv46AQOuBg
   ALxoAMHWxEoG8yXsEwRJpIN8mHu970yJ7lymknJ0S6WXdNw0l2kMHyM20
   Q==;
X-CSE-ConnectionGUID: BJd5VjbhRg+8Cp44sya7Mw==
X-CSE-MsgGUID: V7oXaPY0R4WzV6ZtHHKvIw==
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="49627364"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2025 03:34:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 14 Nov 2025 03:33:38 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 14 Nov 2025 03:33:36 -0700
From: <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Ryan Wanner <ryan.wanner@microchip.com>, Cristian Birsan
	<cristian.birsan@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] ARM: dts: microchip: sama7g5: fix uart fifo size to 32
Date: Fri, 14 Nov 2025 11:33:13 +0100
Message-ID: <20251114103313.20220-2-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114103313.20220-1-nicolas.ferre@microchip.com>
References: <20251114103313.20220-1-nicolas.ferre@microchip.com>
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
them to 32 data.

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Cc: <stable@vger.kernel.org> # 5.15+
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7g5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 381cbcfcb34a..03ef3d9aaeec 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -824,7 +824,7 @@ uart4: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};
@@ -850,7 +850,7 @@ uart7: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};
-- 
2.43.0


