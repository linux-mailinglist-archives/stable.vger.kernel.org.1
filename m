Return-Path: <stable+bounces-204394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E2CECA18
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 23:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D176E300E3FC
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0816EB42;
	Wed, 31 Dec 2025 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaH4ZE9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19712AE99
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767220309; cv=none; b=WeTuFIkv9Dvx19blaiPtQSHNfCpiZ3k04QUdcg51XO4oJlI+7WhDGA3RiQR32888ntgVSc4dMSzcPk0pWCqrR/ZvBQP17MIvzXq4vpmS8j7RDotKmJ6r47P7U6RUQvDzNeQuwZm69uiMn/iAddgjc47hkcUrSkEU5sP8JCDe5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767220309; c=relaxed/simple;
	bh=gvfXhmXR267XU9Z/JdjEJXAaSmYRPAFUj4gfD9E526A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qz2Nq/XaMxDcMbsIU2JHJwNweUjkR0AhHxt8VEeddsCJTdv68AGLq7YXJ+2wej1dCzUP6dPYQE33CN3zlfAtI56qUZ5CVO2WzC7Zh3+duzgqXCZLumngbEGnJiTHjhOCfmseIRlwyWBLmUd5VtDqsj0CoFYlXFmiQj+6IkTAN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaH4ZE9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A857EC113D0;
	Wed, 31 Dec 2025 22:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767220309;
	bh=gvfXhmXR267XU9Z/JdjEJXAaSmYRPAFUj4gfD9E526A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SaH4ZE9EObyj8bI5PTSTurTAML6ceF1h93JS62RCZEp87RTcQtSSSGyYPYzHocRU3
	 ToTLC1yjdmHEzS7ILIiRJxcmRrKZjaDWuV2f0klzPyz1nyn8DSUSk5ROHWqmmferLT
	 Mz3NstzSHsXnUQQCQPYgEJH4HGhkgZ6HkX46bhCLuQ5MenN+kanVuxvP1d9MzQZy9W
	 jI1gUhSZIBhkVvYvXh6VhtRdTnb3swg6Rgsn9/CnKuuLg0BqJyMEmkOy83bnKelFk3
	 K/gcd/rNJuNt20TfdjcTeAmlD8yDdH6nut+z1cTuMAFSkQtm5qiUyI3zIQ9Sd1JDAy
	 OQdWqRct779dQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ARM: dts: microchip: sama7g5: fix uart fifo size to 32
Date: Wed, 31 Dec 2025 17:31:46 -0500
Message-ID: <20251231223146.3547624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122959-siding-astound-c864@gregkh>
References: <2025122959-siding-astound-c864@gregkh>
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
 arch/arm/boot/dts/sama7g5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 9cc0e86544ad..265f273aa06a 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -706,7 +706,7 @@ uart4: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};
@@ -732,7 +732,7 @@ uart7: serial@200 {
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


