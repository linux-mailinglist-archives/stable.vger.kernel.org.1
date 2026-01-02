Return-Path: <stable+bounces-204496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED141CEF051
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 18:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 664693017F30
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A975259CAF;
	Fri,  2 Jan 2026 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v9PIpiBM"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDD1D88A4;
	Fri,  2 Jan 2026 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767373355; cv=none; b=IIk14HGImNjWthYeddrCu4QthYKY3YLtfxii9NcpbtbIGfXZiToexUTbxXDbjm989qHWz0rjs0MUl7SeWRJI4kY9p4YzGHYJxL/HQwwOQKj+m8WyXxloO4yyAAqw9tKYmQXmV9xh9xZixQnIDuN+oZHHR3/s+rKMiPVCzXYccU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767373355; c=relaxed/simple;
	bh=b2FcMDI/Onb6TJ2aAIjlXHZ4EvhM59xQTjBh6PFYK+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn/+w+83p5gT/fe1uDI4V+653mY5k11Pvh3ND/gkoGvGRJ7ioPiI7DED6ESpSnOPIUVBZnXxsBTkmFfPRbVg1qVu4aMgQrJTTPd04gH2sDOt+ZSjtFs+iYO6ZuUBpuQQRi/KpZUDNjYFjCXTtgo4qzgF5t7J6tsdamTCPUmNOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=v9PIpiBM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1767373352; x=1798909352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b2FcMDI/Onb6TJ2aAIjlXHZ4EvhM59xQTjBh6PFYK+8=;
  b=v9PIpiBMXIEb4wuyuC6usniS/opNy2qSA6WapTg8iXlE4SAigQ8UlsdI
   yRbsVkh8Z5tY1JH5OiJ78dU0FFcHBIDiweHRnljFT0xbgoE2s9adDslmc
   ec0mbF5P3Z6KYLc8nX+9taxp+dkchvr4bmQoKm8WnsWohPtnlcPz/EURQ
   5x5TuzTuUbEVkWcsDn7BJ8ZqdEpOdgL/Jj9XPBkHeLMaimjogYXJ2Evq8
   giUi1ApQM1Ut9vxKxFDIv87cL+IyAzSCKoeTHVodlXSZKty3q9se2K5cT
   ic9uzN4dIq5G7wvcVNwqNqv79LTx9YK7g39j0Y8qG8SAjHVBc3PS/LgUJ
   w==;
X-CSE-ConnectionGUID: AQIGzmznQ9aRzmgEiLNGFw==
X-CSE-MsgGUID: C2HUDPFbRKOMTMajxM987w==
X-IronPort-AV: E=Sophos;i="6.21,197,1763449200"; 
   d="scan'208";a="282656849"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2026 10:02:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 2 Jan 2026 10:01:38 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 2 Jan 2026 10:01:35 -0700
From: <nicolas.ferre@microchip.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Balamanikandan Gunasundar
	<balamanikandan.gunasundar@microchip.com>, Ryan Wanner
	<ryan.wanner@microchip.com>, Conor Dooley <conor.dooley@microchip.com>, "Hari
 Prasath Gujulan Elango" <hari.prasathge@microchip.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/5] ARM: dts: microchip: sama7d65: fix the ranges property for flx9
Date: Fri, 2 Jan 2026 18:01:30 +0100
Message-ID: <20260102170135.70717-2-nicolas.ferre@microchip.com>
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

From: Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>

Update the ranges property for the flexcom9 as per the datasheet and
align with the reg property.

Fixes: b51e4aea3ecf ("ARM: dts: microchip: sama7d65: Add FLEXCOMs to sama7d65 SoC")
Cc: <stable@vger.kernel.org> # 6.16+
Signed-off-by: Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Note: Hari's email address will bounce. Change to whichever suits you.


 arch/arm/boot/dts/microchip/sama7d65.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index cd2cf9a6f40b..5f3a7b178aa7 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -676,7 +676,7 @@ i2c8: i2c@600 {
 		flx9: flexcom@e2820000 {
 			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
 			reg = <0xe2820000 0x200>;
-			ranges = <0x0 0xe281c000 0x800>;
+			ranges = <0x0 0xe2820000 0x800>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 43>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.43.0


