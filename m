Return-Path: <stable+bounces-172400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86272B31AA1
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080A35E0C63
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A72FDC3B;
	Fri, 22 Aug 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9Js6Vh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E0265CC0
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871184; cv=none; b=Hw/DpHA72UyoSjfc2r/0nYgihFmQfXluMMc5WQm5yX7A8MAQFTJBFSOYR4+dODqMfK6AKmq3Pg6uFbIIDlnE++XqigCmXkw5iU9aYqxN6eOdSKp2RKBrigIBvm+Cd+MDBqAdF78FBw6k5Z3sPW7YKuehbtdsiMmLQ1BwGbCBxts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871184; c=relaxed/simple;
	bh=bpxTczpst9pmchE/bZui6MC+CydWpAKaNuJKvCsoq68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0XTaDZ/4N71zFaMnAIr2jyCa4jlcPs5tzIrz/37uYHJzyjPdJLR1qIXwV/w+jTgs85xwkEqLlQmVWcfGCh5olA/mA5Xf9bmKFgMcX6nptE8oHj3KPkQuK4wHZ5UNpcKAevA4272pYWYYAnBTk1YtDtPh9pF+yDT/XEU9Qv7zMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9Js6Vh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FE5C4CEED;
	Fri, 22 Aug 2025 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871184;
	bh=bpxTczpst9pmchE/bZui6MC+CydWpAKaNuJKvCsoq68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9Js6Vh08gC0FxjmjL7AuqSae3Z4w/VhyEel/9BST2E3se26qVvDGChpl7lQguCQr
	 As91ZOPtmQofA0AwNns8t2SYrm/hhgtDcGk7+cHnthbIL/pQ3SoR4Tw7I1nT1ueXgu
	 6jQHmvhmsK6h3zXn0PXpNjIpBiV3QmLKq6i0ceit8AIicyz4LGwx6V8/W0KGfDRISd
	 yB70xU+NQTqNP+vy7aK9/J8CxmQdGiY2ph9LM7Yyq66KuSDLKHdqwn2m92hc/8qeMA
	 la/Bu2Ztmu5PivQclg967QerTSO9luOoqhr/5Ud1EnpwaYacAKyBACH0F+6kZWc7kA
	 upvG+6bMREUCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support
Date: Fri, 22 Aug 2025 09:59:41 -0400
Message-ID: <20250822135941.1245318-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082118-blend-penniless-0629@gregkh>
References: <2025082118-blend-penniless-0629@gregkh>
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
index f156167b4e8a..3f74767d63ab 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -531,7 +531,6 @@ sdhci0: mmc@fa10000 {
 		clock-names = "clk_ahb", "clk_xin";
 		assigned-clocks = <&k3_clks 57 6>;
 		assigned-clock-parents = <&k3_clks 57 8>;
-		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
 		ti,trm-icp = <0x2>;
 		bus-width = <8>;
-- 
2.50.1


