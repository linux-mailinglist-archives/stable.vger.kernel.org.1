Return-Path: <stable+bounces-43246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82988BF08A
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6528A1F21D83
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09485639;
	Tue,  7 May 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/sKD1uo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF738528F;
	Tue,  7 May 2024 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122795; cv=none; b=cJ6WDc6zZsXXoiwBNDnn5HL0DiwzQTfRMXZ/+zorw/mKmAkj5N3K2m567dntR/+7tKqCkSDEDx/58tb39hckouylDAg4Bk9aRA8bswYG96GjuqcR4AYMB+H9xY/C+K6znp0atAeCR0EDglBoylXcXSCyABSQ4yK9UU/SgcXZNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122795; c=relaxed/simple;
	bh=DFx0z+J5KJFX0Qtlc6Mj6uTNJMiJKW1ypGh4X/48LpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvDPUiKsKu+vBe0pLhILjUqQILoyWLz5oKQo0wi2A9ILqPmGjU5unYy9b5MTK7gsswiPzWR+4EFhunMvKwL65JFggUR5hAgaBgPQAnDIEcckzsrA9W05TE1l1jkfUO3w6KB4xoBY+02U9r0LK5fOrI1KMhnunCQMDx5b6w8Cbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/sKD1uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B1BC3277B;
	Tue,  7 May 2024 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122795;
	bh=DFx0z+J5KJFX0Qtlc6Mj6uTNJMiJKW1ypGh4X/48LpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/sKD1uoszVf3QW3W0l26Q3PzacPLvyyRseQr6nIjvPWYN/vNNR2MY//RLzlhbFLW
	 yLKns72emcHS7Gl+RLs7fJC1ppSCiPuwnIoc6l81zboErFc+++L0Jwx0UtZvb4q40C
	 cQN/YRBXcbfBF7A1jFTEuTr6bOET54AxTTVV3JgWOBaVROkstPphvpqQkF39VGHfFY
	 fRmR9yvweyyj0E3itS2ghmH/RdRXlDYANQsr4mabdypmSo5L+bakD8WEKy5RZMjsga
	 8w2wtpr4FGrlPS2DATRnEaDpC9+/ccdLniqzzCNgbf7SmvsnyYAmK7sB/ycuuLl404
	 qNkycioHu16Tw==
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
Subject: [PATCH AUTOSEL 6.6 13/19] Revert "net: txgbe: fix i2c dev name cannot match clkdev"
Date: Tue,  7 May 2024 18:58:35 -0400
Message-ID: <20240507225910.390914-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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
index ad5c213dac077..e457ac9ae6d88 100644
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
@@ -553,8 +551,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "%s.%d",
-		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
+	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
+		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
 	if (IS_ERR(clk))
@@ -616,7 +614,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
 
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
-	info.name = TXGBE_I2C_CLK_DEV_NAME;
+	info.name = "i2c_designware";
 	info.id = pci_dev_id(pdev);
 
 	info.res = &DEFINE_RES_IRQ(pdev->irq);
-- 
2.43.0


