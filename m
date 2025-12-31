Return-Path: <stable+bounces-204388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFB8CEC8D8
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF7A300C6DC
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBCE2C0F6E;
	Wed, 31 Dec 2025 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zpgix2BV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C072242D72
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767215163; cv=none; b=PbyEbaVmuqDVP/YcUCdl+dIZ/comhLaxKpz0UChWqc6TbVbYkeKkdbi03Y/r7KdfpHNeXapQ9tRcPiKuT7phPRrLpL3avhFXJ0JG7LGBMwuH793SyyIL0K/Xms12MvaN/o+E1MdkvJqoXGvH5Qhcgu7ZfDEZVXZShNKkah66i1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767215163; c=relaxed/simple;
	bh=/Cwgtmd0sB1DttfGGIM2pxAnS2pU7zgi4/SnQ92ocH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlBmXoLayJNQStDD9WzUrZqPas17Xn4GC0DMb/d1qpSt1PAvsLmFdovi/lwOcI86hewVQzJmZ09EhWa2177WHOC7VI5MT69zF1kOmOq6msq9jkh+XKMR6R6vRNm1UG2DrzJrMNlShtaVHjQZBKGTxvgqcamq+dwEOzx5PJEFL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zpgix2BV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DD9C113D0;
	Wed, 31 Dec 2025 21:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767215163;
	bh=/Cwgtmd0sB1DttfGGIM2pxAnS2pU7zgi4/SnQ92ocH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zpgix2BVxs6rLdsFIwxO9iqdRL4T6zEVuWSid2FiL/l+17iEsbksa1Uj6EdCejwUT
	 snln8ITicWAwGMPeXLobo1aHKW32A/032tu0uzwuu1lW6p1Ol1YMOxJiLkrsYWaH7C
	 vx5IwPswKyJM+1+//nOUjmB9xGBW3eGaQpbOsDx6Tb4cWy4pxxsRFwpTIm4pyjxe44
	 GjaBgeoC3h5zb3bmiQ1qNBQzWSRawX9sm46tgzp/klP/GYMMQyZdHErVNom3ACvxHA
	 UrZ7YN4SoeeAAWsll9xXrj514pSKIlstVXGOr28j0ZscjiuJKIlOLpsGBmiv0NYpij
	 Lny6OirAIQTDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ARM: dts: microchip: sama7g5: fix uart fifo size to 32
Date: Wed, 31 Dec 2025 16:06:00 -0500
Message-ID: <20251231210600.3501075-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122958-dingbat-canary-d44c@gregkh>
References: <2025122958-dingbat-canary-d44c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Ferre <nicolas.ferre@microchip.com>

[ Upstream commit 5654889a94b0de5ad6ceae3793e7f5e0b61b50b6 ]

On some flexcom nodes related to uart, the fifo sizes were wrong: fix
them to 32 data.

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20251114103313.20220-2-nicolas.ferre@microchip.com
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/microchip/sama7g5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 17bcdcf0cf4a..086e1d402421 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -811,7 +811,7 @@ uart4: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};
@@ -837,7 +837,7 @@ uart7: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};
-- 
2.51.0


