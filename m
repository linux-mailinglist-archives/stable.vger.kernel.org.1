Return-Path: <stable+bounces-140199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB99AAA64D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C749B7ACA2C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D2531E17A;
	Mon,  5 May 2025 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/F3AWL5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33B31E171;
	Mon,  5 May 2025 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484321; cv=none; b=Zpg6It6RFqDSlDK5JQDYZNyEratRD4jbDGnju23885pbo6EY9A+goTLvAF7h1PQOZVB8yuQrgKBRch5dYxnyyDQBbvVl2QE6eLCwMXOPKuyJy2zg2m37dBpI/Mr0oTcB2Rrc/HaOLfhXVa04ZcJdfSvwW5XGVVGY05QNTWkuXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484321; c=relaxed/simple;
	bh=8Tzr5t+i7b+QkNadODBiccJKXrTWX5gnoQuN05CbYhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4IV4Z7fSCXseuOzDOp2gyvqB093gplKW7vsVWfT1zUb5X7Qn+XAl0fviQ5sRpaGEQO48JGvTTswf6Cbad6dvrfdM3z38SraKkpxDhqKDSYQl6ec9DckCWbwquVacOpTSzq5DvMt+6UlHRKS0u7Sa2viAel1kboq9L/JRZDPi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/F3AWL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746ABC4CEE4;
	Mon,  5 May 2025 22:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484321;
	bh=8Tzr5t+i7b+QkNadODBiccJKXrTWX5gnoQuN05CbYhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/F3AWL5/HSennV+a4gwS2R2ZnpHs1+EnkPG+ak355JUqodW2bzy56TC+wGmaHTpC
	 QwiGBjI3eg9J7yzmwnY7w4raxCkfltF1B2Uo/23kFcSFTKcKz/8fJcGknxBb8gjo2e
	 Jx4cqF/OUoX0JXS/CqtvUQ2P8ScsIdGos+Nqg04J8lMctyg849LhJJmmJHvQ6p1x9M
	 XtxZuqjJ3ZecMh8W4S9wFVyKGQqSZlWQ9AU1HDjRL7NFRctD4LCUWrQCRR5tXMcLqo
	 TngDztBNtwykfZvhtgYo8PYSo8d22EzWHMa6v6GNMju2ZzZqcFt4mTljjNFavx71OK
	 vAbWbwQmNOuyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	krzk@kernel.org,
	semen.protsenko@linaro.org,
	dan.carpenter@linaro.org,
	kauschluss@disroot.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 452/642] phy: exynos5-usbdrd: fix EDS distribution tuning (gs101)
Date: Mon,  5 May 2025 18:11:08 -0400
Message-Id: <20250505221419.2672473-452-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: André Draszik <andre.draszik@linaro.org>

[ Upstream commit 21860f340ba76ee042e5431ff92537f89bc11476 ]

This code's intention is to configure lane0 and lane2 tunings, but for
lane2 there is a typo and it ends up tuning something else.

Fix the typo, as it doesn't appear to make sense to apply different
tunings for lane0 vs lane2.

The same typo appears to exist in the bootloader, hence we restore the
original value in the typo'd registers as well. This can be removed
once / if the bootloader is updated.

Note that this is incorrect in the downstream driver as well - the
values had been copied from there.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Tested-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20241206-gs101-phy-lanes-orientation-phy-v4-4-f5961268b149@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 46b8f6987c62c..28d02ae60cc14 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1513,8 +1513,11 @@ static const struct exynos5_usbdrd_phy_tuning gs101_tunes_pipe3_preinit[] = {
 	PHY_TUNING_ENTRY_PMA(0x09e0, -1, 0x00),
 	PHY_TUNING_ENTRY_PMA(0x09e4, -1, 0x36),
 	PHY_TUNING_ENTRY_PMA(0x1e7c, -1, 0x06),
-	PHY_TUNING_ENTRY_PMA(0x1e90, -1, 0x00),
-	PHY_TUNING_ENTRY_PMA(0x1e94, -1, 0x36),
+	PHY_TUNING_ENTRY_PMA(0x19e0, -1, 0x00),
+	PHY_TUNING_ENTRY_PMA(0x19e4, -1, 0x36),
+	/* fix bootloader bug */
+	PHY_TUNING_ENTRY_PMA(0x1e90, -1, 0x02),
+	PHY_TUNING_ENTRY_PMA(0x1e94, -1, 0x0b),
 	/* improve LVCC */
 	PHY_TUNING_ENTRY_PMA(0x08f0, -1, 0x30),
 	PHY_TUNING_ENTRY_PMA(0x18f0, -1, 0x30),
-- 
2.39.5


