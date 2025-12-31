Return-Path: <stable+bounces-204395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F1CECA1B
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 23:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF36F3010990
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D06A16EB42;
	Wed, 31 Dec 2025 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twJvfASe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C342AE99
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767220324; cv=none; b=s/lRAGY8jVquH2oBCY7gWN5iF9bEgumZ/4aizcGuR3DlNViE2jaYPXw+RSDh7LG20vMjg19j3hR3z7mw/v8b2xZdatbple25TUw8FfS5IWN/LLbL6kIhzTVQcK6isRaMHpgrQhqn2k59ymWF8sNPla60jbpQ7Y32Z+xggXDZSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767220324; c=relaxed/simple;
	bh=tcHzF9L624aLNH5ME771Z3qRCK71zgL+CY7Z7MgUdhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsglHd2Iob3AOOmIThnFZxd8NSqBh+rBcyWTzUNZmfJFlCXM9ibgM1yGvf7Izh9B2ajTzCa/pxZxL1pfhg+41TquuAwAPDGupQ0J2yU7bZCDuuggtfUoyGJ2sNJyodZJrdbFw1Wg9IAFrA+4Vpb7s3BPpMjVH0HwuCjWXhrrLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twJvfASe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CA2C113D0;
	Wed, 31 Dec 2025 22:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767220324;
	bh=tcHzF9L624aLNH5ME771Z3qRCK71zgL+CY7Z7MgUdhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twJvfASeQxgEynlS0hxP509PXInMyTINIzWlOCMfr/xMiakBbDGxHqz28ULGWnIr1
	 Gzf/hHzU5w8eMvQaQ/SLA+sxTdBnk3bXso6c1wJs2KrFI6M4gUmN5yPXL25gGPr8iq
	 4h+Fvf8Sc8ChEBPirminHaOiUUuU766GZBT5KDB0B+sHxWcgm3hSDO4n9Mlvhs8+oa
	 evldRVbClbqxA65eewMldADllAQxNhVJlIy0wyLSQDaefL59j0kFvqL863nGyTCosJ
	 BA3jb6y4WMiHnimspn8sQI2koTw1eair2xu78O8r+7xjzCFRM3UBSsonhqrJ6wF98d
	 rk66t+ZRFJRuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ARM: dts: microchip: sama5d2: fix spi flexcom fifo size to 32
Date: Wed, 31 Dec 2025 17:32:02 -0500
Message-ID: <20251231223202.3548026-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122920-backside-viscosity-3aee@gregkh>
References: <2025122920-backside-viscosity-3aee@gregkh>
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
index 33f76d14341e..7713ee74bf3b 100644
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


