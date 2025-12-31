Return-Path: <stable+bounces-204391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C3CCEC927
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91CD3300EE5B
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 21:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861861C32FF;
	Wed, 31 Dec 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx0U70El"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446069463
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767216059; cv=none; b=Wsu4RpAu9nwmOO4+8CcAlub0ZYTbZyflhJkH8XJ8jt3ivVPPw+5VU+/DHCVVJjr6HQJvFw5wuAitz3SjASRC66KU2rPoZJWlGSvh0w+U6m1sfzIiYCQJS85TNwvtzJD18oxncvpw2/6KIe2f7jQ1yM1gjlC6jPRCYIYsEiHlECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767216059; c=relaxed/simple;
	bh=XzAKfKMGPSbvN95D85YXD4hOz5umO4QvHuBf3eqiqfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agUVkniReCrVljoiZ6Y0+LoWruUMPTZV+CLL1JpSp4egW5GgDoRNtlcVD3NQR3oAX3suMEmEE3niVWYZsIvmtu4MdeEU/AQvuKVMXoWELf4ob/3fcN5f9MCwwJjaP7pBWPEst7tuS46GWDjuzc/axfuiHnkYxYpo3YOlK9kHnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx0U70El; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F49C113D0;
	Wed, 31 Dec 2025 21:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767216059;
	bh=XzAKfKMGPSbvN95D85YXD4hOz5umO4QvHuBf3eqiqfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kx0U70ElweZ6fGR2ypbic5LP2+aNMBk4uyPlbRw/5GAXTjT4F8fSxWA+J1JiZ05o5
	 wGK0wF1jM92HQeUjg6os7e+PmoIXOLQoPju6WpItYkbk6JDsD4Cc1l48v4HSEPVoy+
	 BNvRzRqWcY0nXNED4GLOfqI6qfNabs2FQdac5nDFuh1HIYKMtrFAsK/ghHZ6mSC24H
	 EIbmrZ+eZ0Nh6mCu8Ogq0c4Ts0CWCbh9lGLpK/8q0VdeSWYTH9Xiur5GOd0X5dmRkw
	 8Uj886s4h0vDkpYqC/vptg21fnqs7aDVmNN9nTtkeQb6Zh1hXYKUvY6TfSPR3Ju5Ka
	 LTDjdNonlBlcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ARM: dts: microchip: sama5d2: fix spi flexcom fifo size to 32
Date: Wed, 31 Dec 2025 16:20:57 -0500
Message-ID: <20251231212057.3505425-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122920-atop-frisk-5877@gregkh>
References: <2025122920-atop-frisk-5877@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Ferre <nicolas.ferre@microchip.com>

[ Upstream commit 7d5864dc5d5ea6a35983dd05295fb17f2f2f44ce ]

Unlike standalone spi peripherals, on sama5d2, the flexcom spi have fifo
size of 32 data. Fix flexcom/spi nodes where this property is wrong.

Fixes: 6b9a3584c7ed ("ARM: dts: at91: sama5d2: Add missing flexcom definitions")
Cc: stable@vger.kernel.org # 5.8+
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20251114140225.30372-1-nicolas.ferre@microchip.com
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sama5d2.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 4c87c2aa8fc8..da10678a52d1 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -555,7 +555,7 @@ AT91_XDMAC_DT_PERID(11))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(12))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -625,7 +625,7 @@ AT91_XDMAC_DT_PERID(13))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(14))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -835,7 +835,7 @@ AT91_XDMAC_DT_PERID(15))>,
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
 
@@ -976,7 +976,7 @@ AT91_XDMAC_DT_PERID(19))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(20))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
-- 
2.51.0


