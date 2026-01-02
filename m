Return-Path: <stable+bounces-204497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D47CEF057
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 18:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0393730380EA
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE403248893;
	Fri,  2 Jan 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AIKbvIxx"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928425392D;
	Fri,  2 Jan 2026 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767373380; cv=none; b=feGW7ByR7iks+/y+CANV1MnBSkFbOYSIOvYnjXAOrZZsFga6d1ppcnH1DC1rRsCIQt8zg87PEYONQESDdIFxLnj0QKarMGEdhedKtuEVb1jn2C5D1VIcejxdBSiqvb4oq2RmtAdnpJmDR2tUbpCfrhRVxZ4zKr8WiU7TiF625vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767373380; c=relaxed/simple;
	bh=ZY+Hrf2RDJpz96DFkZH7AD1GmvyE3tVeKZ338mKSv/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRcCDuwaUhhGmQXh3xWtHNhwiFyRcZz44WazJZ01o8OwvVjTZ5R/RVFWgOBLZTN10D11N/tpTn2i68RzwlIBf23F9kmFBs9ThZUTLO2U4SfwVtC+QQxeDS7Si5R3IQFMXYUs3//ZlV7yQRSnV2bfWKB78ntyf371S/mqFnJT2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AIKbvIxx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1767373378; x=1798909378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZY+Hrf2RDJpz96DFkZH7AD1GmvyE3tVeKZ338mKSv/g=;
  b=AIKbvIxxFoaSFYaxptcrQZe27PeetMMINJcuYCF9e3bU1LV5CQlV6ENB
   s+lb7LdQIScwnFJPdPpBUzDxec50yek4/GtHvZFeXNWJxMXVTSmbnAKXV
   RPzP99nIfMnSJUFsDKnAusLtKomHvqC+tmsl7c7reCmMHgxpeKQAnHAMt
   TLBV6COUx1Yse80OtbuDRamAdZD2zleVSrQmUajxGNBAff0Uh48tHtdPU
   NUVC5bTxhUim4sG0Ild/Lf410iMpmFVeyGFmanx8ScI6J9m1mjWVZlIfL
   9Uv8kr0JEOMHKRm9dP5+t0J75tP4fxcnq1LhRG0+YrLS2ddP9Fek1iSJR
   Q==;
X-CSE-ConnectionGUID: dCrVUlstT/WCgDlJ76zoeQ==
X-CSE-MsgGUID: bmfnSXGJRcikdFj1WZvODw==
X-IronPort-AV: E=Sophos;i="6.21,197,1763449200"; 
   d="scan'208";a="58167746"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 10:01:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 2 Jan 2026 10:01:40 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 2 Jan 2026 10:01:38 -0700
From: <nicolas.ferre@microchip.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Balamanikandan Gunasundar
	<balamanikandan.gunasundar@microchip.com>, Ryan Wanner
	<ryan.wanner@microchip.com>, Conor Dooley <conor.dooley@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/5] ARM: dts: microchip: sama7d65: fix size-cells property for i2c3
Date: Fri, 2 Jan 2026 18:01:31 +0100
Message-ID: <20260102170135.70717-3-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102170135.70717-1-nicolas.ferre@microchip.com>
References: <20260102170135.70717-1-nicolas.ferre@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Fix the #size-cells property for i2c3 node and remove the dtbs_check
error telling that "#size-cells: 0 was expected" from schema
atmel,at91sam-i2c.yaml and i2c-controller.yaml.

Fixes: b51e4aea3ecf ("ARM: dts: microchip: sama7d65: Add FLEXCOMs to sama7d65 SoC")
Cc: <stable@vger.kernel.org> # 6.16+
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 5f3a7b178aa7..868045c650a7 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -527,7 +527,7 @@ i2c3: i2c@600 {
 				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 37>;
 				#address-cells = <1>;
-				#size-cells = <1>;
+				#size-cells = <0>;
 				dmas = <&dma0 AT91_XDMAC_DT_PERID(12)>,
 				       <&dma0 AT91_XDMAC_DT_PERID(11)>;
 				dma-names = "tx", "rx";
-- 
2.43.0


