Return-Path: <stable+bounces-173989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABCCB360B1
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20AC2A056C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E58122157B;
	Tue, 26 Aug 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qC/N4K7B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD504CA5A;
	Tue, 26 Aug 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213197; cv=none; b=iFoHlZ+cJ+FiBJSzzjO9qESQMGTFldA9dPGQfKNpaPrSPLpO47uxMXsYRuMgAIHSRj+rloCRgWyI54e3uWtznLfUcq2Lf2DJEiX/T3YYAHTVwkgK4aBW6cv5VxNB3OAOqAGLv0UcaQihX3eJy9S+IDzQjcosCAcNyGobBXqPAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213197; c=relaxed/simple;
	bh=U0W1/f83JiC2po/QrTN/idoO96LplUqtiQtl+Lal7cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtyVXr4h6jpseybodD7S8aSKwje3sfoM50SBNBv0gwSBUeGYlQPwU42wnrk98Z7HwCMVxBUN0iIX1A1GCqkKqso03TSNjWLFHcWEcuRvCHe/cdxEF+xfccxFIvJ7abqaPumE4g4rnbR1PlJv6BsHPHkwl+yWKDcB8JWrbhtnVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qC/N4K7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B929C4CEF1;
	Tue, 26 Aug 2025 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213197;
	bh=U0W1/f83JiC2po/QrTN/idoO96LplUqtiQtl+Lal7cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qC/N4K7Bw1mFMArLxQZ9i51eJMCTntd+Dr85+wuQS2IFBtXHgSIaC9f/FHfPo74I5
	 MwfWbR846iRBsheuRRAFQ+bp3i1a8cKJJ+lnl1moPm+BT0vDd1+8HSKDh8XzKkMzYn
	 c0Pn2EK34U7yZTWKj3nZCZCuoEcIe2OOR7qbkRWg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 226/587] phy: rockchip-pcie: Properly disable TEST_WRITE strobe signal
Date: Tue, 26 Aug 2025 13:06:15 +0200
Message-ID: <20250826110958.684501034@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geraldo Nascimento <geraldogabriel@gmail.com>

[ Upstream commit 25facbabc3fc33c794ad09d73f73268c0f8cbc7d ]

pcie_conf is used to touch TEST_WRITE strobe signal. This signal should
be enabled, a little time waited, and then disabled. Current code clearly
was copy-pasted and never disables the strobe signal. Adjust the define.
While at it, remove PHY_CFG_RD_MASK which has been unused since
64cdc0360811 ("phy: rockchip-pcie: remove unused phy_rd_cfg function").

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
Link: https://lore.kernel.org/r/d514d5d5627680caafa8b7548cbdfee4307f5440.1751322015.git.geraldogabriel@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 8234b83fdd88..cbf3c140a138 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -31,9 +31,8 @@
 #define PHY_CFG_ADDR_SHIFT    1
 #define PHY_CFG_DATA_MASK     0xf
 #define PHY_CFG_ADDR_MASK     0x3f
-#define PHY_CFG_RD_MASK       0x3ff
 #define PHY_CFG_WR_ENABLE     1
-#define PHY_CFG_WR_DISABLE    1
+#define PHY_CFG_WR_DISABLE    0
 #define PHY_CFG_WR_SHIFT      0
 #define PHY_CFG_WR_MASK       1
 #define PHY_CFG_PLL_LOCK      0x10
-- 
2.39.5




