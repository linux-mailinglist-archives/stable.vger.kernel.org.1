Return-Path: <stable+bounces-45342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9063C8C7DF1
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 23:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D86282DEF
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 21:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141AC158A32;
	Thu, 16 May 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDE6e53A"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FDA1586DB;
	Thu, 16 May 2024 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715893954; cv=none; b=rm7keCuSWRE6xr8w1x7A5/nNKkqNeT6NjThcjQE3JA5bTfn0qwIQq9NRhpHB9RPoS4Vf5PtZNg48gGgfRyfr9StNvQlGASF19kDtkLKjw+aUONr9pjTAe0FwEMpny4iWkkj2vWtseJQ0BUGOBwJoruUdwbiHnPdqFTFaJOnD5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715893954; c=relaxed/simple;
	bh=we9weee/JaV4Vp7YJEKnES+bZmUID0P2SZEqnOi/knc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJwGkYpLhvAoL/kdOZk6rnC7gcCdxkjyR+aFY6wR4rkTukxfqHw5X/1TRFZL3Iqe9ra0bxf2E2aTddga945X88+uwy/nH+uWIqrZp7FFYAwcjXlHGN4OnXH1USuxkjrBKlBWJWfMaBoxMkst/xSV2jojuIi/TXNBX2yaYpgBVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDE6e53A; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso463169a12.2;
        Thu, 16 May 2024 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715893952; x=1716498752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJD1FQA2D1Smtm7463pP0IFT3MI0WmcYycw6S//0twI=;
        b=DDE6e53Aq/qRh8xvgBgAmt2aFUTw+JJuS6oBCi+jbfq9IBpGXn1Hfa5Ka0CZ+t3nac
         caP49jmFsMFRtzIGt4S1AnjfrZYjBW/oq2zKKOmUT3hu0JNLU2pLyN6NFJpJjGQwpMtr
         PknmAxWTIjEA/4VYI69HyvFRV3g38MkB3tPjMfRlcEXoK5RtG154db9BSNC5a/WXIxGD
         GMf9akna9IfeMTAOd8c/7KLZ3b9sivFaSD0dhePyD9KysUld9BF51Vx6i4DcmEebrUZ1
         hcwz9+c0fWO5Knt3O6SwtQpXSFgadQIStZ8vp66EBwc75bkREDgp0OBZPr2Ouh3he4sw
         RXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715893952; x=1716498752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJD1FQA2D1Smtm7463pP0IFT3MI0WmcYycw6S//0twI=;
        b=Uf6wjaUa6T5aghNiteC2LoV25oC4HtVtgm5+wGQUYoUTXUmagyQYtQAYts4wLSzNIo
         YA2B5fQ22K5+V6ewCKQ93CFs0zbLyBPot3+L+uOSAqOEI2U86aJGA7rVVNUHswhQzGFj
         pJG3DrFhBauBaV/nL7pfV3Lz8bqxhv+e2bkvOjRjQGzI0dD9qu+XqthEaY6JdSXbT/0r
         yLNmKDVpnMwmLq3jO8m73TdfEXlJI7pjaQm86wfVLm0fG5jhnV9u1ZyjXHnFktXHhPi2
         XQE6eGuHkOoe1GGNkE1JLztnnjG1b1B0ttt0ywwbt8S2kr/p/203bhJbOKwaSkcMI4M4
         vDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmnp0NTO4R5c0lMqjzKNNSrxOS8W4V+KIudjOko1mvtbwSMLmzOVzzk0D8hY87oEgRWJhDM9g6upjiOGb6tZ2xBVfGW7bUooJaNUhVcH1aPb/YrwqhFV+XmD3168GKtEpKtLew
X-Gm-Message-State: AOJu0YysLi2woNKQbqye48aeQ+z8docFr/1ZHoZX/yYgPHi1lsgBz8Wd
	OoYrT6npPeQjb2AiGPvM5FKNGjEtc7h0yhWtySFxKqHSDWmkqhhvTFVFRg==
X-Google-Smtp-Source: AGHT+IFHoa0Y6j1jY2owaUpg9KLpsukud/n/1x0HI3JElMooj9GsS/8alvC1sCkJxkQVTSbUUBoAaw==
X-Received: by 2002:a17:90a:2d8b:b0:2b2:bccc:5681 with SMTP id 98e67ed59e1d1-2b6ccd6bb21mr18407189a91.33.1715893951892;
        Thu, 16 May 2024 14:12:31 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca5279sm16116918a91.41.2024.05.16.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 14:12:31 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH stable 5.4 2/2] net: bcmgenet: keep MAC in reset until PHY is up
Date: Thu, 16 May 2024 14:11:53 -0700
Message-Id: <20240516211153.140679-3-opendmb@gmail.com>
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

[ Upstream commit 88f6c8bf1aaed5039923fb4c701cab4d42176275 ]

As noted in commit 28c2d1a7a0bf ("net: bcmgenet: enable loopback
during UniMAC sw_reset") the UniMAC must be clocked at least 5
cycles while the sw_reset is asserted to ensure a clean reset.

That commit enabled local loopback to provide an Rx clock from the
GENET sourced Tx clk. However, when connected in MII mode the Tx
clk is sourced by the PHY so if an EPHY is not supplying clocks
(e.g. when the link is down) the UniMAC does not receive the
necessary clocks.

This commit extends the sw_reset window until the PHY reports that
the link is up thereby ensuring that the clocks are being provided
to the MAC to produce a clean reset.

One consequence is that if the system attempts to enter a Wake on
LAN suspend state when the PHY link has not been active the MAC
may not have had a chance to initialize cleanly. In this case, we
remove the sw_reset and enable the WoL reception path as normal
with the hope that the PHY will provide the necessary clocks to
drive the WoL blocks if the link becomes active after the system
has entered suspend.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 10 ++++------
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  6 +++++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  6 ++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 2afd056056fb..bf52bd643846 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1991,6 +1991,8 @@ static void umac_enable_set(struct bcmgenet_priv *priv, u32 mask, bool enable)
 	u32 reg;
 
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
+	if (reg & CMD_SW_RESET)
+		return;
 	if (enable)
 		reg |= mask;
 	else
@@ -2010,13 +2012,9 @@ static void reset_umac(struct bcmgenet_priv *priv)
 	bcmgenet_rbuf_ctrl_set(priv, 0);
 	udelay(10);
 
-	/* disable MAC while updating its registers */
-	bcmgenet_umac_writel(priv, 0, UMAC_CMD);
-
-	/* issue soft reset with (rg)mii loopback to ensure a stable rxclk */
-	bcmgenet_umac_writel(priv, CMD_SW_RESET | CMD_LCL_LOOP_EN, UMAC_CMD);
+	/* issue soft reset and disable MAC while updating its registers */
+	bcmgenet_umac_writel(priv, CMD_SW_RESET, UMAC_CMD);
 	udelay(2);
-	bcmgenet_umac_writel(priv, 0, UMAC_CMD);
 }
 
 static void bcmgenet_intr_disable(struct bcmgenet_priv *priv)
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index a2da09da4907..8ebca6bf300e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -132,8 +132,12 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 		return -EINVAL;
 	}
 
-	/* disable RX */
+	/* Can't suspend with WoL if MAC is still in reset */
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
+	if (reg & CMD_SW_RESET)
+		reg &= ~CMD_SW_RESET;
+
+	/* disable RX */
 	reg &= ~CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
 	mdelay(10);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 213434aaf07f..56fad34461f7 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -96,6 +96,12 @@ void bcmgenet_mii_setup(struct net_device *dev)
 			       CMD_HD_EN |
 			       CMD_RX_PAUSE_IGNORE | CMD_TX_PAUSE_IGNORE);
 		reg |= cmd_bits;
+		if (reg & CMD_SW_RESET) {
+			reg &= ~CMD_SW_RESET;
+			bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+			udelay(2);
+			reg |= CMD_TX_EN | CMD_RX_EN;
+		}
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
 
 		priv->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
-- 
2.34.1


