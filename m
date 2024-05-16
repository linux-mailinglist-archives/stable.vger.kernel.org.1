Return-Path: <stable+bounces-45341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C338C7DEE
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 23:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6000C1F2151B
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C6A1586F2;
	Thu, 16 May 2024 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRMVl+LP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B3158202;
	Thu, 16 May 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715893953; cv=none; b=p+b/f54d5E92/SJlmUnsAnb7h//tGky4LbgtxLWRT44BnqOkRZFZ1nTS4JAwdOUhXrReRXPlJ/NpW7e+LYXmVUpC3dzmI+xx6CYK/R19XEssSn+njrstjKBrMekxf3KfBovwzQy/HwBEWyc/5F3rCQ2E0D/8Y97Zs70um8WJRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715893953; c=relaxed/simple;
	bh=1o11Mx+hN3YEAxxf3v2SYf20qJsgk0EksHe5sNU0Tl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=thTAeiHlqsChE0jGCrs16XvVzUH00KIoOolCuGvGNnnPS/YfBTzQf9fe1NRIBsmA8xeoER9REkifvY2cFiQIOJbxYmLSOgFMhsQV47HHc+hNvXGqXc1lqIc6pk6pc3ISwfElkly2bBholRg3zWKxm3sj2XHHxiq9tn0Iy3IsrSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRMVl+LP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b33e342c03so597963a91.0;
        Thu, 16 May 2024 14:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715893950; x=1716498750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFtOdCDDS8pWsU5ibi88uExXYYlil4P3yRNei2oTBUs=;
        b=mRMVl+LPw8uZyh/IY7zdZHtGzqWDIUwJjcaumqEk1140pwshN23sdaTBz99foXZxAV
         2/C2BKOj1T2b2pMZA1kQv4RG59emv0EsMDhI3r6kh9nuPkR+Xz3wT3vIGf4GkMgM2iwd
         c0STCnAnBgx7ygDL441z2RXIgLTbsnoOhqvL3I9OXiWAftyB8iYExH5ePSjB6i1rQ//N
         wANu/01IDmvEijIVFF8HfgmWNhtN/i/IM+TqofPd3Ls36DgIW2hZAURCqqkQdlbks/jp
         lWmvwVF6H12hAYYLn9a6knQeKPaWgJeNc4uLUS5h2xFiJ4ckPfTMFiGjObI38LtFMo4t
         vJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715893950; x=1716498750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFtOdCDDS8pWsU5ibi88uExXYYlil4P3yRNei2oTBUs=;
        b=CRSDPPCIn+IAgDHS7ptp5Oi7uq5ETzRjAsyhVh4/BzbKfMZBKRzuR6FylP2BG8VJc9
         odUWs7oKtwzBfHnIyrE6V9cx2wojzlfqyCgqILLSHf9bnbDFPRJxe21Gn5ZuaWWVC2mx
         0QSN34UR7BF7hc3XyQA8K8X1NHj4ER0kpI06QPoIEKofajp2SjdGR/IaYu0/nI+ghgjX
         Fb/ZKq8FtGvtNnb8Wb645QjLUHHgF+9c6iF2s1jELWLkjgMYjANxbJaXIecsPDk96OWh
         ZpbVSz5j3pxoF4B4XNQjGhq+t9irIVyU8Uz7CQU732bK8ZRXKVL0CTITO+ETVgfHmxB+
         i2ew==
X-Forwarded-Encrypted: i=1; AJvYcCWMznDNUH4w9EoHl94qIC5Xsvpj717Eg6LeFX/Od7yhIT1DiSJec7xhDgUDKzLXCK5gQ9UDwXGH9WQzSiew7E/MFgbi+Zp043nLixA4WtXuGrHErf+uCGlIMja053pstsoUvuEU
X-Gm-Message-State: AOJu0YxNT/xD8XDLIu1XwR5a9qqpG6vPF3ojWGPrvD6ueZOrbTpVcRPs
	i7VjClVvoi4/YLfTiCsUu4e0jzyKGfwZA8kVkFoqS8wba/n1eIke3LZnfA==
X-Google-Smtp-Source: AGHT+IExhfu/u94b4vM7u9H/fv9s4GDAFHntuZSICPi8lvFLfEgazxxH3ohuG+GDrWxK2KDVCAUNCw==
X-Received: by 2002:a17:90b:1d01:b0:2b6:22ab:7b05 with SMTP id 98e67ed59e1d1-2b6ccd9cea1mr16888138a91.49.1715893950269;
        Thu, 16 May 2024 14:12:30 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca5279sm16116918a91.41.2024.05.16.14.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 14:12:29 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH stable 5.4 1/2] Revert "net: bcmgenet: use RGMII loopback for MAC reset"
Date: Thu, 16 May 2024 14:11:52 -0700
Message-Id: <20240516211153.140679-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516211153.140679-1-opendmb@gmail.com>
References: <20240516211153.140679-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 612eb1c3b9e504de24136c947ed7c07bc342f3aa ]

This reverts commit 3a55402c93877d291b0a612d25edb03d1b4b93ac.

This is not a good solution when connecting to an external switch
that may not support the isolation of the TXC signal resulting in
output driver contention on the pin.

A different solution is necessary.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Adjusted to accommodate lack of commit 4f8d81b77e66]
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  2 ++
 drivers/net/ethernet/broadcom/genet/bcmmii.c  | 33 -------------------
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 380bf7a328ba..2afd056056fb 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2015,6 +2015,8 @@ static void reset_umac(struct bcmgenet_priv *priv)
 
 	/* issue soft reset with (rg)mii loopback to ensure a stable rxclk */
 	bcmgenet_umac_writel(priv, CMD_SW_RESET | CMD_LCL_LOOP_EN, UMAC_CMD);
+	udelay(2);
+	bcmgenet_umac_writel(priv, 0, UMAC_CMD);
 }
 
 static void bcmgenet_intr_disable(struct bcmgenet_priv *priv)
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 026f00ccaa0c..213434aaf07f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -187,38 +187,8 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 	const char *phy_name = NULL;
 	u32 id_mode_dis = 0;
 	u32 port_ctrl;
-	int bmcr = -1;
-	int ret;
 	u32 reg;
 
-	/* MAC clocking workaround during reset of umac state machines */
-	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
-	if (reg & CMD_SW_RESET) {
-		/* An MII PHY must be isolated to prevent TXC contention */
-		if (priv->phy_interface == PHY_INTERFACE_MODE_MII) {
-			ret = phy_read(phydev, MII_BMCR);
-			if (ret >= 0) {
-				bmcr = ret;
-				ret = phy_write(phydev, MII_BMCR,
-						bmcr | BMCR_ISOLATE);
-			}
-			if (ret) {
-				netdev_err(dev, "failed to isolate PHY\n");
-				return ret;
-			}
-		}
-		/* Switch MAC clocking to RGMII generated clock */
-		bcmgenet_sys_writel(priv, PORT_MODE_EXT_GPHY, SYS_PORT_CTRL);
-		/* Ensure 5 clks with Rx disabled
-		 * followed by 5 clks with Reset asserted
-		 */
-		udelay(4);
-		reg &= ~(CMD_SW_RESET | CMD_LCL_LOOP_EN);
-		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
-		/* Ensure 5 more clocks before Rx is enabled */
-		udelay(2);
-	}
-
 	priv->ext_phy = !priv->internal_phy &&
 			(priv->phy_interface != PHY_INTERFACE_MODE_MOCA);
 
@@ -250,9 +220,6 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 		phy_set_max_speed(phydev, SPEED_100);
 		bcmgenet_sys_writel(priv,
 				    PORT_MODE_EXT_EPHY, SYS_PORT_CTRL);
-		/* Restore the MII PHY after isolation */
-		if (bmcr >= 0)
-			phy_write(phydev, MII_BMCR, bmcr);
 		break;
 
 	case PHY_INTERFACE_MODE_REVMII:
-- 
2.34.1


