Return-Path: <stable+bounces-141573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20B4AAB4D5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6146A3AC256
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801E847ED6F;
	Tue,  6 May 2025 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwwZf7P9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D12F0BB5;
	Mon,  5 May 2025 23:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486759; cv=none; b=FNy8oWkQbIfMXJFzgSaNbxtyMVj+rA8Xojh46iFCwqSWUi/3jJX7bnGOZxgpVbO/9XfP0gptUsJo2Yj3GEEuz4R0k45GiyMqhjc2Tb0eRKvZamt0gBJm0OXTfRlTCBeTXg/9108rMGUSnv3I2K1PgKvTX8kGaTRpiy7CpnLQItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486759; c=relaxed/simple;
	bh=2MhPMJolL3bzf0hpny7AO0Glle1RNAMi1eEnNaXcDZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8mpPRiy1SyLxd/gWEGivK21BkzAQsJD8Q87GcsfZ1nQba1eEWLQgymlK8MAqHqcIiAZbRiqRRoVKWt6Av1dgg8a9IBZSzp7aJrC/e1wJZ4aBBwpdSC1d/yojbXPjenBA1+FOYpkPmywDXUg60WCwndyivmZ6Kei+sA02pH3Hw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwwZf7P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F84CC4CEEE;
	Mon,  5 May 2025 23:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486759;
	bh=2MhPMJolL3bzf0hpny7AO0Glle1RNAMi1eEnNaXcDZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwwZf7P9smrhSyYQxigbdDOObpT/rDs4oTcKaU6yI/8OnE6WlD5CZxs/GgEmcC5M2
	 Uyc0iSRV1bMlsfY251IUilzaaqI8otmgZMqyeZNMQEAEFVBzfCxpbzyg4cIPp2x1yO
	 8vyhxzWoG+lBggIhMwc8A/jVNxqaEywl4IWLWkHXYijyrnZnDhsiBRgaoS8D9Zppv8
	 V+35DrbEuAC91O8O4jak8TmMng0NBziIXjfJgU9f1uaXSaKrD4EjVALZJeV0+GTRff
	 elY2+6I9kVhsu/MA4r6w3eKWDf9Pv/ak4juke4bvWDefOewltqQP7DlpHFjeS64de+
	 phQfxev2wpi7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 188/212] r8169: don't scan PHY addresses > 0
Date: Mon,  5 May 2025 19:06:00 -0400
Message-Id: <20250505230624.2692522-188-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit faac69a4ae5abb49e62c79c66b51bb905c9aa5ec ]

The PHY address is a dummy, because r8169 PHY access registers
don't support a PHY address. Therefore scan address 0 only.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/830637dd-4016-4a68-92b3-618fcac6589d@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4b461e93ffe9d..6346821d480bd 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5156,6 +5156,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
 	new_bus->irq[0] = PHY_MAC_INTERRUPT;
+	new_bus->phy_mask = GENMASK(31, 1);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
 		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
 
-- 
2.39.5


