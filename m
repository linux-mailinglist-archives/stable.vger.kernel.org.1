Return-Path: <stable+bounces-141663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221FDAAB54E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8349D7B9E30
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CBA49B48E;
	Tue,  6 May 2025 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZidAebA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F62F6629;
	Mon,  5 May 2025 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487070; cv=none; b=q5jkpGWZYC/vNQN0XKZtp5SMm0x7pdbQh044TqaXsJT4cLwrSKkXWVqf6PBZ7O8s6YUFXgJWC98b/BJBvsB0cfRy8NPZQm7M81DPOGHHC2oyHlutoxiNxlKIA7MwJ78HbLW/MjDuuUJH922RG3TZFkOsI9UN/MtB6hsUP8MCgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487070; c=relaxed/simple;
	bh=cSfRCzCLDEZTuW95DIGVbAQ2BKTmosIiG0HWDVaiP1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmkuGwsmcO3Eawp1hkdE90UpPKCSByfe/a7PieA/yogwLzv7dqGt8Q7etXR+LMmW/+DEYxpRuBsscCUDUJpw8A/OaTFSGY7P9QtZLizd/x1CI1UDfssR2Zp09nD0i5bFdnh/jgs8tnhkmjPatlszTU6lyVHG2tlLId5ADiqmvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZidAebA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4A6C4CEE4;
	Mon,  5 May 2025 23:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487069;
	bh=cSfRCzCLDEZTuW95DIGVbAQ2BKTmosIiG0HWDVaiP1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZidAebASXUdHwywDBApw0+mzF0/kTJB1Ad6XdCN35ZpD4sHC5iYYiG4EIO+sG0l3
	 3ZY857I4iv/kIGhrmCfJpOHdJlRtiHJHb6u37aDapTEvUyP28X1kPxkUyk36WjvOXP
	 Zs8kEU8J6Cp115CkkXUuCl3w7Tt2AYSzT8QqJ/3YwqRVFGmsHTIiMW8syg0FqS3eF9
	 +XRs4yHA0qiYR0GgzJlehjDpvO9RSdLkJEyMtKqKLV71HjTrZaCAdnAEcKhiMC/gM/
	 dqb+lNrU39Lxwo9O472oLpkADk9KsiKlwoLRGF+CqGkkj2oTljuIfx0YjnjznV/7hr
	 xkfZ2uH2S3YAQ==
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
Subject: [PATCH AUTOSEL 5.15 137/153] r8169: don't scan PHY addresses > 0
Date: Mon,  5 May 2025 19:13:04 -0400
Message-Id: <20250505231320.2695319-137-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index d9d19ea77d20b..1ea30c9b8c07c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5185,6 +5185,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
 	new_bus->irq[0] = PHY_MAC_INTERRUPT;
+	new_bus->phy_mask = GENMASK(31, 1);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
 		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
 
-- 
2.39.5


