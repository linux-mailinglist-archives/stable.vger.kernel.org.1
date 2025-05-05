Return-Path: <stable+bounces-140568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F43FAAAE30
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4131881918
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511B527815C;
	Mon,  5 May 2025 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caE9VaaU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0BE3635F9;
	Mon,  5 May 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485163; cv=none; b=AUddOKM0v01BstM8p9qmKFmpqje+M4ssNMp9KLAdmxA/8rCjl1TPOWG7UPhhtxNM7fgFcQyPsItmpdTjYhvI2T2hCpTAbR8QvHGLVf/Z+XS4T9+5xGD89SnVUE3/+lsonydmNrpfwzC7XIMXbLxo3xdF/Ho5lf/aettE81Y/4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485163; c=relaxed/simple;
	bh=V8ig1lRsGtwoWBZKNn2Wr9A2FUXJGFgMfFPPKD6vL54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjOgy+o+JEfSLS9WTpgS3EyXEHMYeyZqbMVxXKipiOn6T2SDi9CnTzJstjyaTKC/hNa5dpzPeXclTViTYfcmi+2rELX6Mb7bt5nZlZ8aEyn+un+FEItrdq9CdawqB1MNv3zSK4EoqfLz25eYTDeCqc7tWjMnck1NSOS1IrYdhFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caE9VaaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFCFC4CEF2;
	Mon,  5 May 2025 22:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485161;
	bh=V8ig1lRsGtwoWBZKNn2Wr9A2FUXJGFgMfFPPKD6vL54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caE9VaaUcxmwbMfZhhTclvG21Uu6yJO78fN1SDr2GM08zkbDCLFnDW5mUAOvFyXmT
	 /ot1qG5HqZUMBwWTxceSrJYSsskftwzqcffTAV0mtdpZO68NCB+R1VPNeDDWqSuf0R
	 BlFVdLWownbL39ItOlOqyI+7/7HHTixTgGveilWkf5UmRXQsxCYokva8BmVo2tt9su
	 Y9Kamq27YyS9JYheREokZHOwjZDljoZisk+C+y+qoyTmimQK5eMR3HBetTSO0Xp7uY
	 Wd9u/SOah3xZlnjyZhFOpfseFsKGEvtyzItRvc+Ne/PXfFFl0rN7gEmOb/7mWejjry
	 iZxprAFAavsTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 193/486] net: phylink: use pl->link_interface in phylink_expects_phy()
Date: Mon,  5 May 2025 18:34:29 -0400
Message-Id: <20250505223922.2682012-193-sashal@kernel.org>
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

From: Choong Yong Liang <yong.liang.choong@linux.intel.com>

[ Upstream commit b63263555eaafbf9ab1a82f2020bbee872d83759 ]

The phylink_expects_phy() function allows MAC drivers to check if they are
expecting a PHY to attach. The checking condition in phylink_expects_phy()
aims to achieve the same result as the checking condition in
phylink_attach_phy().

However, the checking condition in phylink_expects_phy() uses
pl->link_config.interface, while phylink_attach_phy() uses
pl->link_interface.

Initially, both pl->link_interface and pl->link_config.interface are set
to SGMII, and pl->cfg_link_an_mode is set to MLO_AN_INBAND.

When the interface switches from SGMII to 2500BASE-X,
pl->link_config.interface is updated by phylink_major_config().
At this point, pl->cfg_link_an_mode remains MLO_AN_INBAND, and
pl->link_config.interface is set to 2500BASE-X.
Subsequently, when the STMMAC interface is taken down
administratively and brought back up, it is blocked by
phylink_expects_phy().

Since phylink_expects_phy() and phylink_attach_phy() aim to achieve the
same result, phylink_expects_phy() should check pl->link_interface,
which never changes, instead of pl->link_config.interface, which is
updated by phylink_major_config().

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Link: https://patch.msgid.link/20250227121522.1802832-2-yong.liang.choong@linux.intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3e9957b6aa148..b78dfcbec936c 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1811,7 +1811,7 @@ bool phylink_expects_phy(struct phylink *pl)
 {
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
 	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_config.interface)))
+	     phy_interface_mode_is_8023z(pl->link_interface)))
 		return false;
 	return true;
 }
-- 
2.39.5


