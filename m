Return-Path: <stable+bounces-140802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA72AAAB6F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE5C7AE9DB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A193B11DE;
	Mon,  5 May 2025 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNH7OAdB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FB22D9FB;
	Mon,  5 May 2025 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486321; cv=none; b=iolmVnChuH8hNlhSWfvHtak6p4YiIgJFx3Dkt41R3kBeLrMF97gFzf6IJyexlAzSARrwDqMauAn3CinN6nTlR8Dd8l4fQ9S8BJtcVhCund0gzCSdbLCr7FlE2GQZAkfoukNCHO++FrZpg3+r5O/ELQtgQsLNiU8NE2EXVWXLsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486321; c=relaxed/simple;
	bh=J+K0fq+oSO6ukMR9+4dy0cKhnVJb8creVGAE7cYNVHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5+pcDK+K55NJav20KCE8rc115s3pt/MwLVFux9b4ZTYkCb78JpSp34IvXDDnyHuglqs2bHLDno6khx0Jb3vJxY3AiQ1O81uij86qgaK0O2aqoN4zo9XMQKmesxw0dzGLsr9d0zP9MjV6Nl/yW5HvhRSeaEEwV0W/ZKYJv+R/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNH7OAdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423A2C4CEEE;
	Mon,  5 May 2025 23:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486320;
	bh=J+K0fq+oSO6ukMR9+4dy0cKhnVJb8creVGAE7cYNVHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNH7OAdB3vZqEGvMpk9wH5eACLTebuLHkvc48zTAr5GalwmN0ONmHaCjkRREfwMQn
	 s04fnPB58zLuQMQ9NzBLFbWpu+1nPWia4XU2TWaJvzsCI2gyDQ8HxpM/V99yxgSgzG
	 7065neYALtaJY4Ex34jRfpUfQhjt0czF9fNEPCZt8KQ85Y+yBCwsGf8XyU0qp4FUQT
	 dPyxRSQrMPtDxl8v+xoZaFX1SWBKLhqx76aKM+w/N0PXu19wn77E3kxh4prPpjwU3Z
	 3a2aN+904dCbq27I/14kuYdYSP5WJkiZZm7MjHV82D6+DxkDCLS3YdXNNADST6Hw0L
	 NWZ59r/tig+Uw==
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
Subject: [PATCH AUTOSEL 6.6 258/294] r8169: don't scan PHY addresses > 0
Date: Mon,  5 May 2025 18:55:58 -0400
Message-Id: <20250505225634.2688578-258-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 7e5258b2c4290..5af932a5e70c4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5125,6 +5125,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
 	new_bus->irq[0] = PHY_MAC_INTERRUPT;
+	new_bus->phy_mask = GENMASK(31, 1);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
 		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
 
-- 
2.39.5


