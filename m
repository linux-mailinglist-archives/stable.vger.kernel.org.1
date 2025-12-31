Return-Path: <stable+bounces-204389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C359CEC8E1
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2381C300C0E3
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409692E22BA;
	Wed, 31 Dec 2025 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnxNz0Xo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C80242D72
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767215260; cv=none; b=n+sv4EWLpZKMVKQ3yGjEx/q97mr3E8f4GTQM+2EHzsnVrglFIZTkL1rtObyNJDd/t2hk3wUN/b/fmIeowmeGiBPj/GuoLKEuGZphvPg9hDPfl7foBAB6kWgRnEbxPnegnkfIdkFonfxB8sWH6aCxBbfzzY2dRoOGGIamHabS7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767215260; c=relaxed/simple;
	bh=qfa16RAXhB6RSWrdIw54VIsg/gpoSvwWubQALfJWfm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzIaK19EaKdncPDAxcVT/xLvZIsgYTczDrNOz4ePBFzNfVufBEFI8dQ9t2+gTBGCpx/DPGOzr/TvXj5jmOHJPqvjvefFZLXtdiW9gDTmA17SgdM+6hvt3WpY7p+2IT12cPJUC8w24OIhbswGzNmGpAhT/SztEQb6QJKFn9TKhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnxNz0Xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18441C16AAE;
	Wed, 31 Dec 2025 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767215259;
	bh=qfa16RAXhB6RSWrdIw54VIsg/gpoSvwWubQALfJWfm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnxNz0Xoeqh0SVAgOWAVKQmjhugrjrs2/TC6ZEO0LAWXSpkV4fPDDUzFCVWuCQmCp
	 RvUrbWhLTr1WEzehtOY8u2N6AOzwCPU6NewDQwobTlTR8/ayKgYI9DiiA6Cm/kJ89f
	 70X6jVlcgSpKl5K2SaUBZ7Pf7B2pivc5y0SFq++RTLGaberL8l+0B7wlkka3W6xnAA
	 G15sCvWeLe1d9/yVpSIyIL420LcI5DvmvJK3G6a43GfiRrh8HBUxXpZ8gx1Qd9i5t5
	 UZ4sBwpXb8gUCXAgIq5RapXl+cmjR41E90vAepowvCp/v9pJtIPURXfFTeajPgn0CT
	 SkFH/xW10OXFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ARM: dts: microchip: sama5d2: fix spi flexcom fifo size to 32
Date: Wed, 31 Dec 2025 16:07:37 -0500
Message-ID: <20251231210737.3501550-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122920-probably-crystal-786e@gregkh>
References: <2025122920-probably-crystal-786e@gregkh>
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
index 14c35c12a115..c399609d8e2b 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -568,7 +568,7 @@ AT91_XDMAC_DT_PERID(11))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(12))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -639,7 +639,7 @@ AT91_XDMAC_DT_PERID(13))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(14))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -852,7 +852,7 @@ AT91_XDMAC_DT_PERID(15))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(16))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -923,7 +923,7 @@ AT91_XDMAC_DT_PERID(17))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(18))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -995,7 +995,7 @@ AT91_XDMAC_DT_PERID(19))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(20))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
-- 
2.51.0


