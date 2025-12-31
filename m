Return-Path: <stable+bounces-204390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A30CEC924
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 22:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABE7B30071B9
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6B1C32FF;
	Wed, 31 Dec 2025 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCtPCU1y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78F9463
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767216039; cv=none; b=SoU/5nc1ekuUKrlnPXBT78710+55JlVunMcyzdUTxUcI9frvJbOrLTrV6lpXepu1uPOw1ovcH3sQByii08JwsqDB+mygkdS9Dpn+/w3kETdGrmNeM9XriteCpIjmVdoIoUAEA+4tlZNBi8ZN5kSJdiGJ/ut95AasWld/l3tGEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767216039; c=relaxed/simple;
	bh=bgyZMvF9yzZtRWnxoK1q0rCdVXYtFzV0447pVcqAspo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/MqI9IZptCESizpdNXEXnSgTR2Fyqf4E+WWeIt9g0AbCpXlk6pwxmp6M5NdBK5c2V7tCCJ6jLEuLxWzxy4JjMEmJoWuT02pbVl/DcajNvITAqPozNHkKqE+Xu6gbah7mOjBxlkYlZzD7zuTEmxA7G6mXFidco950Lpq68izfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCtPCU1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90AAC113D0;
	Wed, 31 Dec 2025 21:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767216039;
	bh=bgyZMvF9yzZtRWnxoK1q0rCdVXYtFzV0447pVcqAspo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCtPCU1yqCAHbsopVakpGJv0C3tClfJlmMVBwAsMaeq2sIlF6KYGbvjk2+hr4Go8+
	 ajuAxyJfeb4NXNkA+Nn1FMBM9Azuw3dpQEZEGplNSK3MCfHi47E+bHfZeACe2fDomo
	 CMZLSQmpUQVFEG1ExwPf8nuI3KA/Atroh+8MXwRKsfd4toW8NNkXceHNNdjDYbonxe
	 NwKaQyxww9jF2+2gMl2FHGystmS5esitZ/yGTRS+zgavYhjqqKLzdhUHAcjw2ROEWj
	 rLSs1UvghQUbLM2xCNthymDs4gzEq96fwVEIW5T7gEZPiTQJ4ppVJbLD40ZxgwPbO+
	 AEvEBpE4Mek6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ARM: dts: microchip: sama7g5: fix uart fifo size to 32
Date: Wed, 31 Dec 2025 16:20:37 -0500
Message-ID: <20251231212037.3504979-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122959-rumor-work-1d89@gregkh>
References: <2025122959-rumor-work-1d89@gregkh>
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
index 7a95464bb78d..fc59f4e0b5aa 100644
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


