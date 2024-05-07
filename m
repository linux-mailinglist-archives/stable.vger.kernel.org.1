Return-Path: <stable+bounces-43225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E698BF04B
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A8A1C20BE2
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE787FBCF;
	Tue,  7 May 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW+b1Qcu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC780026;
	Tue,  7 May 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122695; cv=none; b=HYrWGX/C4EQ5AMo37U44EAcM8rYg6gksygiAUwbnTx7w/Xpj+MpRBWhgwWgAHg6iyksM2CI90nwVuLk+B2cV1z3b+o3/RYysaFqbeslPfsj9KdvvBYolTbKBg7YxuFfgfL7W/+QhKRLUWFH7B1tyTdfR66qW7Rg5wzfm//qNEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122695; c=relaxed/simple;
	bh=Z+B83y+GREhQK4EQiOuqx47Q13BwPkKg4GAEVOkLClk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F97KJhxlNZKWkNNFd8+bZ1zWJbKJq34M/wT6PQHzssft4d4LMm9ksbHFnexEtQeytWKl6pfj+bOLYF3hP7ckxa1iwFNbFN5y6iBtuNO2tjg/piNx7J+HryTKcJTKbEjNWgCpa5NtsuxUGcP+l12YlDdg//eE9X+Y/ZywOfo0QvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW+b1Qcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA747C2BBFC;
	Tue,  7 May 2024 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122695;
	bh=Z+B83y+GREhQK4EQiOuqx47Q13BwPkKg4GAEVOkLClk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MW+b1QcuEllnqWQrZfNYXza5jJWN7tK6oUF2L8GWBc8p2xq2FV8OqcQ3dm47wpV6Z
	 kVZtd2MplyGjRXwDjG/4oaxTxFNfzmTH50bKTL8x6AELVxfGiwA1aDAQKqBwxW4jlk
	 ozzLc83Q6JDOpdBx4CiEimk4TiMUapqFwBPnZADzEfENqmi0gfaZBE+BnZnBmo5TFa
	 nSzweSS5CcUezGgLe0MkwiNv9VNncN1s85AIaSc02/zv62YId49NOyZLFPM+PkQq8n
	 8hf9RXhvbOsr7UenPS6Zu+izTg3m+gjThTt/rBBIGo4nm/fUDJuAfc6/kI0f61lGPK
	 0oU3dpPDZcXXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 15/23] Revert "net: txgbe: fix i2c dev name cannot match clkdev"
Date: Tue,  7 May 2024 18:56:41 -0400
Message-ID: <20240507225725.390306-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Duanqiang Wen <duanqiangwen@net-swift.com>

[ Upstream commit 8d6bf83f6740ba52a59e25dad360e1e87ef47666 ]

This reverts commit c644920ce9220d83e070f575a4df711741c07f07.
when register i2c dev, txgbe shorten "i2c_designware" to "i2c_dw",
will cause this i2c dev can't match platfom driver i2c_designware_platform.

Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/r/20240422084109.3201-1-duanqiangwen@net-swift.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 8cddc9ddb3392..29997e4b2d6ca 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -20,8 +20,6 @@
 #include "txgbe_phy.h"
 #include "txgbe_hw.h"
 
-#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
-
 static int txgbe_swnodes_register(struct txgbe *txgbe)
 {
 	struct txgbe_nodes *nodes = &txgbe->nodes;
@@ -558,8 +556,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "%s.%d",
-		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
+	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
+		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
 	if (IS_ERR(clk))
@@ -621,7 +619,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
 
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
-	info.name = TXGBE_I2C_CLK_DEV_NAME;
+	info.name = "i2c_designware";
 	info.id = pci_dev_id(pdev);
 
 	info.res = &DEFINE_RES_IRQ(pdev->irq);
-- 
2.43.0


