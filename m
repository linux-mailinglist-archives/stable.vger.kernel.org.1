Return-Path: <stable+bounces-204398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D4CECA3F
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 23:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22AF03006446
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74A30AAD0;
	Wed, 31 Dec 2025 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBvv9+Y3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBA1A239A
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221070; cv=none; b=nMGL/g23ipPMkZ2mR4skZ81C6lmSpNfC9b2y4i1aKk6mFVjPwSatRmCF4eVvVm7hszVZHxczSiiIsT/qT2Td/uwhRQ7+Pf2DT6GnR9YPH+I1vS+nIqRGH2ZNiphyUIqrrHm1fRwDsgkVbqbO1s7bU9duOHjrkcr9qgau7H1oz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221070; c=relaxed/simple;
	bh=aPihWfI2QBRrp0PgkgrpRLE0bUx33oXFWsvZ7w67vlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNTim1O0hVvEnJzXk1kPBnNGUS379EllR42q/InVzPhuLuLO74lmFu74KpmZA5C+NK+Tqg4SuOFk9ZLKJnBZz/UtrTlMITxS8i2d9qrjrh1Fl19k+xveQr3w4DvPCs/mdm0/g3CzjSvxSPG40doaCfGgYM75PxZ1iFWR9hm1GH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBvv9+Y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B98C113D0;
	Wed, 31 Dec 2025 22:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767221070;
	bh=aPihWfI2QBRrp0PgkgrpRLE0bUx33oXFWsvZ7w67vlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBvv9+Y3Z+oGArM3aMScV5fyAw6TE6AYUDCeuFPf0vJr18S7XWXsuHe4q+dzxdYB7
	 lk7Cp1W8enc1iF/4zlIpo2Mq4q3+A5DeiouIFItAEEplbyw78kYxP69689pnu1HnQh
	 Z93A6qsXlUzdZqwUQbRJLxeHQq3yxWlgH/ftKqWrYv3+mG+YSIYMz84TbtURoRUCfJ
	 72fc2J2EJcuQ8ojb4gwt+pIKaJaFy3e4wyoXNgTgBFKZMHJDE4nZYGOSF0Hfdv6RtY
	 lJP7VfUQvbL07kCGaJmckHnxbxFY0mFAXmeYB3cgps+SEdeN0nHD+SEtjTGnElou0J
	 02dtRRAbHUC+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ARM: dts: microchip: sama7g5: fix uart fifo size to 32
Date: Wed, 31 Dec 2025 17:44:27 -0500
Message-ID: <20251231224427.3631376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122900-ripple-expert-4378@gregkh>
References: <2025122900-ripple-expert-4378@gregkh>
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
index a63a8e768654..eaf52c455653 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -375,7 +375,7 @@ uart4: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};
@@ -400,7 +400,7 @@ uart7: serial@200 {
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


