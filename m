Return-Path: <stable+bounces-45204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88A88C6B35
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826A11F21998
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0A5482C3;
	Wed, 15 May 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BL3kQwea"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11238FA0;
	Wed, 15 May 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792559; cv=none; b=ag38/6gcQ5UoT7vh/3VtWBD3BVa0SLZPposSg/0ov/kgpE8LLg3DPF8WPp+xwWC0kgUeac/7qlISOnhkOOAfoqwzN4IAC73017FWNLizjCKze7AKU4//AXGM1jU0zf2e4fpDRFqNspmFYsWVSEEXC/CeoAksz2AkgWF8Xo7gqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792559; c=relaxed/simple;
	bh=wfpDHIRJQm5gfTfqfa13pyUDBBZ0QpYN48zGNn2baqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1zx1M1T7OYIAhbb0riiPZ4m7ICKFh2jteiXq+OWVT3pGoZeWO7CMWz/EByAkYVaPBAGuDvzbghwthhOFAu7WML2P+LB+NAHNiezgMR7kibPdwUtADllpEHPHKWUu3f6E0gHqOtrfX+45xLPKCA2JHWPcTpx6eqdeq5F9s7QFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BL3kQwea; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5FC50C0000F1;
	Wed, 15 May 2024 10:02:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5FC50C0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715792551;
	bh=wfpDHIRJQm5gfTfqfa13pyUDBBZ0QpYN48zGNn2baqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BL3kQweaKBHbSmufdV4U5fMWg1V9v1uHBiRp72cvbeLVQdSJKFcVkJtjTDievyOtc
	 N8jHEnMPUOdSH5sApWTFdR1N1FfoLfWv1MI/8hdba29JC18YX8Wwf6vVm8b1JCgmww
	 UmsyFkj+vbW4EBW8IpjuIDkONP/aGR3TUkkiFQL4=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 6188918041CAC7;
	Wed, 15 May 2024 10:02:29 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: broonie@kernel.org,
	Doug Berger <opendmb@gmail.com>,
	stable@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:BROADCOM GENET ETHERNET DRIVER),
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH stable 6.1 2/4] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
Date: Wed, 15 May 2024 10:02:25 -0700
Message-Id: <20240515170227.1679927-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515170227.1679927-1-florian.fainelli@broadcom.com>
References: <d52e7e4a-2b60-4fdf-9006-12528a91dabf@broadcom.com>
 <20240515170227.1679927-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doug Berger <opendmb@gmail.com>

commit d85cf67a339685beae1d0aee27b7f61da95455be upstream

The EXT_RGMII_OOB_CTRL register can be written from different
contexts. It is predominantly written from the adjust_link
handler which is synchronized by the phydev->lock, but can
also be written from a different context when configuring the
mii in bcmgenet_mii_config().

The chances of contention are quite low, but it is conceivable
that adjust_link could occur during resume when WoL is enabled
so use the phydev->lock synchronizer in bcmgenet_mii_config()
to be sure.

Fixes: afe3f907d20f ("net: bcmgenet: power on MII block for all MII modes")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index cc3afb605b1e..07bb7a4e517c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET MDIO routines
  *
- * Copyright (c) 2014-2017 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #include <linux/acpi.h>
@@ -274,6 +274,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 	 * block for the interface to work, unconditionally clear the
 	 * Out-of-band disable since we do not need it.
 	 */
+	mutex_lock(&phydev->lock);
 	reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 	reg &= ~OOB_DISABLE;
 	if (priv->ext_phy) {
@@ -285,6 +286,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 			reg |= RGMII_MODE_EN;
 	}
 	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+	mutex_unlock(&phydev->lock);
 
 	if (init)
 		dev_info(kdev, "configuring instance for %s\n", phy_name);
-- 
2.34.1


