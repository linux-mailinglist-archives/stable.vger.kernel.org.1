Return-Path: <stable+bounces-140297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EBDAAA75D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9724F3A4E5D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F772D43F2;
	Mon,  5 May 2025 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbOSK7YG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E12D43E0;
	Mon,  5 May 2025 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484585; cv=none; b=Lqp5InF23bVKDLirfthU799nuYJfxWJiDML2p/aHPkZPBaL7/iaoIl1w3luBphIeB/qs7ijTO5zeLCMhw+xi0pyiSagMaeTp8ai1nyS8fZ67Llgd6pPR+aLbvEqSPEE3NLgEvfHniKhbK7G88RrAI7PT4MtXTkeYl75pdkU8LzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484585; c=relaxed/simple;
	bh=kqvnS9JAqpXjJpCYbialDxXbFsQW8+5HogJYXPD+cso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pMJ0fQOZZSioShKLQ3dpaLbRk9F3v73u53RDzyGg3Cjn5buYUKGniRVietjFxYGccBDyR399Uvv+caRjhvcQGfQ/v/qQx0w52PJewWaUx1mpYH0NfJmod517bme/rk8tV1DE1GYGuzDqCNh21HH2vkBN6wrcL6n0JgguHIqdk8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbOSK7YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B638DC4CEF1;
	Mon,  5 May 2025 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484585;
	bh=kqvnS9JAqpXjJpCYbialDxXbFsQW8+5HogJYXPD+cso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbOSK7YGqixVj97Q9LiQ9tnDbadfm9Wc+qPiBbxvgno0LEZhCAZyJ4XXsTfOsVAYo
	 e4916tJmDboqT56KjsBn6rq7DAzTTLB5UniggE+M3mFG+AzoNI2SFtzAqkwVVEOh+J
	 nbRDGGi/AMMn6f1NPN3I0vq8XW7tJNhbpmLzCX9tf4+8EJshKsz55vKNqBKZ4dRpWu
	 /6pwokDFFEaFUNzFEF7rjgpBe69StrLTXaOC02rxDYAUv9UTN9pHGliGu0bk0OinsV
	 M3e8c/iN+B6SUcSetZaUAMYQk8O8nEmrzUht6PuQplC7aYLqSWu5J6AFGrePv3UmOi
	 aDPdKFM4ASm/A==
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
Subject: [PATCH AUTOSEL 6.14 549/642] r8169: don't scan PHY addresses > 0
Date: Mon,  5 May 2025 18:12:45 -0400
Message-Id: <20250505221419.2672473-549-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 485ecd62e585d..267105ba92744 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5250,6 +5250,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
 	new_bus->irq[0] = PHY_MAC_INTERRUPT;
+	new_bus->phy_mask = GENMASK(31, 1);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
 		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
 
-- 
2.39.5


