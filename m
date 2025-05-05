Return-Path: <stable+bounces-141222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8EAAAB1B6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E413ABAEF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7C8364338;
	Tue,  6 May 2025 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQG9QLLT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726332D0AA0;
	Mon,  5 May 2025 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485517; cv=none; b=cquAeAhnTNzsd4am1mv0RI8jbfUxiCWezTWVB9zT+SzWYAif8JX8Zwc5iyiBtgWWgW03LxOD6SVsuuOzdYVw94sSeGH/QBG1Nt5C6iAd5cV3qYhvn0R6BAHvA8C/J28SljbPAvxrqPSi3d8Um7626aHzuT/Xe/62vF+7AuKngbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485517; c=relaxed/simple;
	bh=8Tzr5t+i7b+QkNadODBiccJKXrTWX5gnoQuN05CbYhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzjTO0yNp9qPGacEgAzuLJFeBQJ0+b3wYAkDormGuyWUt1+9oejBI6U/zp4ybJwtvV9hmjnRtI+ZzeYa7Nc2R/IWRcdFuomWP7gauT/YVmTfzx9WLHwM8/9l5aULK/oHNdPGE3cclI0KwIfLY3l7nLCSb+48Xg+6b6jYAs59K6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQG9QLLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A91C4CEE4;
	Mon,  5 May 2025 22:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485516;
	bh=8Tzr5t+i7b+QkNadODBiccJKXrTWX5gnoQuN05CbYhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQG9QLLTwv83ss5/YyVzrOyhgFyudhdF/pel4sfc1iqVjIpAIEXb/7S2xEgX5T6w6
	 OtDjF4Wr036xIJGSTlQpagR8BpdUe2H1GZTZhA21xBwha6ueSglZ+1BtGIxdYM9VuR
	 l/1J7VQHheFCqCoRqzRU2m8a5FIXh8TfR/zpn29lzA/XRS4mGRrwQQGRs/B2HdcA13
	 CNlf3+wksMSHt/pP359ClrYoB15I6qvGYDJFbRFksGfDtTuZehxP5NniAeVtT9zfyt
	 JqjxQ453muPgRmwaKbcTOyvsFdlIbkD+qg0iBObnIumudsoo9SOBatITBbG53YMkmx
	 TTu65DqGfwCdg==
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
Subject: [PATCH AUTOSEL 6.12 356/486] phy: exynos5-usbdrd: fix EDS distribution tuning (gs101)
Date: Mon,  5 May 2025 18:37:12 -0400
Message-Id: <20250505223922.2682012-356-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


