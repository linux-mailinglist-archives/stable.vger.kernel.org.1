Return-Path: <stable+bounces-192063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DB7C2907F
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 15:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DCE188B2B0
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27AA1A3A80;
	Sun,  2 Nov 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDCKP1Kr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF281732
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762094810; cv=none; b=sIGhFbIYWl/YXaFBvsZkQ7+7bmiGSnHCF+noxRgSwfvvDen7x8uxxni0GURIuplJfJ7HwIimNKjn9y7iEDhvOBSTot1NP6DJ9v2tkAg/dWgVz3WZiZYoIS33evgpn0c4m2Rk8pddfmXgZKtW6UIoHfGEc9gsuW8Xd6rbRd7zHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762094810; c=relaxed/simple;
	bh=5TuyXZabTge4FBF8Qa7AQAh9PUdUMHoj7D/yzIysxe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isSmTECJalxaxHo97ulIcA0W2l0oADYN7UdhMY183tAkd/nF2yxNp96l45Hfpm79NO05GlXEJ2nnriA1JdImuvyDzkkmgAFQkYKNRehkN30fIeOfe+9MqF2ZzPP2yeBZgJLPrKfznydsexU66FRB9DaJGoUP91TDIyzfm2aGtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDCKP1Kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E814C4CEF7;
	Sun,  2 Nov 2025 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762094809;
	bh=5TuyXZabTge4FBF8Qa7AQAh9PUdUMHoj7D/yzIysxe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDCKP1Krv9ByTueRLmX55ZgqdCTw64DAaYxbhTwbtydU0PweQwD05feUQtB+ZN5bU
	 E5yZmTXoyOE+1sqpz/dLMgBJmrul9oCl82sHsTzHdkgBX8DTvfF53HPq9x+tUu4Ycw
	 F85QIZQRpfAn2WwamIOueNNTP8BFlfSf20/7MhrOc8NpeR9oz3UlJYXnVnVtwhCLs3
	 p9/AyS+b0/STTt6F1EbfdUaZ5K8Y05SF7zHbKS2dUbTNOzVojq7uiNZ6cGerthvmBV
	 /LoUXGh/Yuh8nHb0k0L8McSls+YtwhOcXq9LSHw4CQKkYU76xDcxb0DR7/3rdYmhlm
	 tvw+6XuIGsziA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] net: phy: add phy_disable_eee
Date: Sun,  2 Nov 2025 09:46:45 -0500
Message-ID: <20251102144646.3457653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110212-wavy-support-eaec@gregkh>
References: <2025110212-wavy-support-eaec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit b55498ff14bd14860d48dc8d2a0b6889b218c408 ]

If a MAC driver doesn't support EEE, then the PHY shouldn't advertise it.
Add phy_disable_eee() for this purpose.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/fd51738c-dcd6-4d61-b8c5-faa6ac0f1026@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 84a905290cb4 ("net: phy: dp83867: Disable EEE support as not implemented")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 16 ++++++++++++++++
 include/linux/phy.h          |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 834624a61060e..1a0c51a7702e5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3045,6 +3045,22 @@ void phy_support_eee(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_support_eee);
 
+/**
+ * phy_disable_eee - Disable EEE for the PHY
+ * @phydev: Target phy_device struct
+ *
+ * This function is used by MAC drivers for MAC's which don't support EEE.
+ * It disables EEE on the PHY layer.
+ */
+void phy_disable_eee(struct phy_device *phydev)
+{
+	linkmode_zero(phydev->supported_eee);
+	linkmode_zero(phydev->advertising_eee);
+	phydev->eee_cfg.tx_lpi_enabled = false;
+	phydev->eee_cfg.eee_enabled = false;
+}
+EXPORT_SYMBOL_GPL(phy_disable_eee);
+
 /**
  * phy_support_sym_pause - Enable support of symmetrical pause
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index dfc7b97f9648d..1888924bca77d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2030,6 +2030,7 @@ void phy_advertise_eee_all(struct phy_device *phydev);
 void phy_support_sym_pause(struct phy_device *phydev);
 void phy_support_asym_pause(struct phy_device *phydev);
 void phy_support_eee(struct phy_device *phydev);
+void phy_disable_eee(struct phy_device *phydev);
 void phy_set_sym_pause(struct phy_device *phydev, bool rx, bool tx,
 		       bool autoneg);
 void phy_set_asym_pause(struct phy_device *phydev, bool rx, bool tx);
-- 
2.51.0


