Return-Path: <stable+bounces-172406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D620B31AFF
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B213B5CED
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C372FF17D;
	Fri, 22 Aug 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGrOceCl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186E2FFDDA
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871833; cv=none; b=THhtniuus93ybTsVNuB528LXhJ7utPKsJlgfoyp6WZTW3dqk7JBBf315IWMFaRjA9tQoUY/YR0C/h0SFWysYOmXZAyUuAQBNGZ8xSRzQuDex5kNZ25S8cNL/QYnsXqw1RDAD1RyEqUiRVjZkkiv2x4miT09KFltQlP6MCnSvPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871833; c=relaxed/simple;
	bh=TUAWTLxwDDWiqaX6skqIN8pAinXASuzuWS63/pzjNGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+95G8FqNEzOE60uyOmCRyT3RWE/pOBxHjp3VVgw4JPe9X9FHkisUvn6OzVSrDuw/2S2CgFj/g0C5f/fx2heiggc+HgoVoupUjXwarPnFaggd0ZBlFpgoQx7QEkr5uaWZ2kXNA2ph9/KbhYM8q6mkZSrsxYAaDRNDTHzuusgzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGrOceCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF91C4CEED;
	Fri, 22 Aug 2025 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871833;
	bh=TUAWTLxwDDWiqaX6skqIN8pAinXASuzuWS63/pzjNGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGrOceClku2EFktnOXuDLVeD4Tl4u7w8Q6430kzLTiP/0Jbf+XKFOngd+AdLz6P3V
	 AdJyTMPqf2ekj/kPT718DUH8ozdMqDsIiAd0UZLrNc6Phuy2a68WwmZayRMhvEUN7w
	 l8hh38IIo44QlvDAiseVaA3FLyynZ0VnHHtbt2UzHAlETmOiItXznI1PhpQ3eM5v/S
	 UjPkIfBCMvEEKpV/vCYehKEoGBZ1S3ZgBUr/SxOjXb8lX12FVSRb3q7PPdWa+II/iu
	 VymWUx2Mt/XQX7YNJ2j2yzdTCQ/3/4/N7uEiwijlEOGUpN/ysJlH4HFy5hXrkIz0MZ
	 s4FpS2H+rM9aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support
Date: Fri, 22 Aug 2025 10:10:30 -0400
Message-ID: <20250822141031.1253096-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082119-deafness-faster-0127@gregkh>
References: <2025082119-deafness-faster-0127@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Judith Mendez <jm@ti.com>

[ Upstream commit 265f70af805f33a0dfc90f50cc0f116f702c3811 ]

For eMMC, High Speed DDR mode is not supported [0], so remove
mmc-ddr-1_8v flag which adds the capability.

[0] https://www.ti.com/lit/gpn/am625

Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Link: https://lore.kernel.org/r/20250707191250.3953990-1-jm@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[ adapted context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 04222028e53e..c05efc0f0ce7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -386,7 +386,6 @@ sdhci0: mmc@fa10000 {
 		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 57 6>;
 		assigned-clock-parents = <&k3_clks 57 8>;
-		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
 		ti,trm-icp = <0x2>;
 		bus-width = <8>;
-- 
2.50.1


