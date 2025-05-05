Return-Path: <stable+bounces-141287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E78AAB669
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE3A7B3A71
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D04E2D5D02;
	Tue,  6 May 2025 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYeM8YiQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22B2D6428;
	Mon,  5 May 2025 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485687; cv=none; b=jjw92hkH+yF85q92xqvn74/47M1fg3mXCqVp8doWYH++fkkdWBmq85+pedYC4R3qzt1ILB+XB3PeiCFHzJk+vzCQvge1oKPE/8YLZLH3xCrxtKl7lpnPqZIx+uHFEuzlBsWKWAQIPalDh24Ncd/qYFqCF8a0M21H+9X/d1tFPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485687; c=relaxed/simple;
	bh=osP0ihuA2a2KT+E2b04p7xGK//ugo7dnULKRtcI0zus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dlv4s7kOTN9ETa6RUpWJPMHKcSU9tGnEB13JetWB06gHIqc4dS0aI2O298Tdsigs+CyjT6VtqY7mkiqALjrgoT4uP1Bcp8ak4fGpsZDliWFq/dE+/FmGqNit6n15x1umh33ia6nOIo1Jf/zNiJF5Ym5TDDuxwllbJFdkvL0HTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYeM8YiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA19C4CEEF;
	Mon,  5 May 2025 22:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485686;
	bh=osP0ihuA2a2KT+E2b04p7xGK//ugo7dnULKRtcI0zus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYeM8YiQvRgUA/vhdbr8F8e1nJff4KE0qY6/rNVgbdki3xFSUbPXWi54gD0/vrjFx
	 tvVcPUvQQ3UkT6XshlsieyLlTS1GRc43d6eln7Hg0nosm2lOdwOyIP5z8eLXYbA6ik
	 U537g0Om2MJTN1DinAt6BkoMlN44BzMzA4Y1EW+zo9OSr8DxuDpC+T1omFwkDBn37m
	 LmoIrV7cPjRtK+ZA50QR+9mkAeUcx6AuaWuPEbLzwTNW2P8vQAhS0IQ+AR+1mHdWNV
	 gq+12XgTdwnH9Zw5LJW55LR2a/z1WZKqkoXX4lkHVqDpQGMjzPOkAWCmUUe4N5sBD5
	 OjxWA7P4V+4ew==
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
Subject: [PATCH AUTOSEL 6.12 426/486] r8169: don't scan PHY addresses > 0
Date: Mon,  5 May 2025 18:38:22 -0400
Message-Id: <20250505223922.2682012-426-sashal@kernel.org>
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
index 3420b6cf8189f..85bb5121cd245 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5258,6 +5258,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
 	new_bus->irq[0] = PHY_MAC_INTERRUPT;
+	new_bus->phy_mask = GENMASK(31, 1);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
 		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
 
-- 
2.39.5


