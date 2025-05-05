Return-Path: <stable+bounces-141219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31055AAB1B7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122C33A8AAE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B7335201;
	Tue,  6 May 2025 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLZAJxLL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22422D903F;
	Mon,  5 May 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485513; cv=none; b=n6XfsXdY777iNO/rLb+VpGU0QmzontLk6RS0rfpWr4A7vMvvv0JOoCuyXvtmnyWNMd8Hn8W3WoPJAxnchSK1yQa1kRa16wqix8NP085dinrcDRM0Hl338xO90uEdmh8x+3TjHblwJltFerORQJDRPx5t1z4HBbnFP5saNmnafRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485513; c=relaxed/simple;
	bh=M1+XwD4TJBCVTfUVrmJnm/z+U5fuYjwArQdwgfIsMrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bvA36OAWumX5vR0Uy0h1VyUq0OSwWW6BCp/Eq/UxTNWVBQ6h8rKZxcfRMHejiiKn0MVphYajZX2bqwUjdeD413KwlYfkz0w504MdMOfkG2awWOxvgtD3vLqynGSX5r5No9SXE1aiADZYGDZfmr9tb3vqcMzGVn0YxqrYpB5rJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLZAJxLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E77C4CEE4;
	Mon,  5 May 2025 22:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485512;
	bh=M1+XwD4TJBCVTfUVrmJnm/z+U5fuYjwArQdwgfIsMrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hLZAJxLL2TVk9MbW3+FAVQKeE2d2S7lcO8m5kXGd0DJb7HZaogYP2odc5guo9HCF/
	 RC9cT1djMb0izRNbxwn6xlyf6FBE5VBiX/FHfRBhrI4EvE8uJysrAlxWQEJnxRd9JG
	 y5PBO9mhWMr/AlXAVlAyXPrj4dUj/OUz+QlOSklLzZar13NsO7icVjcp81zEcINZkW
	 V9wQhXhScIZ6uYkNCMYZBEZmAakMaPGMJNBnNo3Mzjcs5aH+mdgywQ0FEfhgkuW752
	 +XmYl1h9QI+b7ksjOKi1J74LSQZQKEm32Mkdo20aAuy8lXv6EHPPKDQgk+0i2uxWlE
	 w0Zu+17OQgw3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damon Ding <damon.ding@rock-chips.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 354/486] phy: phy-rockchip-samsung-hdptx: Swap the definitions of LCPLL_REF and ROPLL_REF
Date: Mon,  5 May 2025 18:37:10 -0400
Message-Id: <20250505223922.2682012-354-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Damon Ding <damon.ding@rock-chips.com>

[ Upstream commit 2947c8065e9efdd3b6434d2817dc8896234a3fc0 ]

According to the datasheet, setting the dig_clk_sel bit of CMN_REG(0097)
to 1'b1 selects LCPLL as the reference clock, while setting it to 1'b0
selects the ROPLL.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20250205105157.580060-2-damon.ding@rock-chips.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index be6f1ca9095aa..dc6e01dff5c74 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -94,8 +94,8 @@
 #define LCPLL_ALONE_MODE		BIT(1)
 /* CMN_REG(0097) */
 #define DIG_CLK_SEL			BIT(1)
-#define ROPLL_REF			BIT(1)
-#define LCPLL_REF			0
+#define LCPLL_REF			BIT(1)
+#define ROPLL_REF			0
 /* CMN_REG(0099) */
 #define CMN_ROPLL_ALONE_MODE		BIT(2)
 #define ROPLL_ALONE_MODE		BIT(2)
-- 
2.39.5


