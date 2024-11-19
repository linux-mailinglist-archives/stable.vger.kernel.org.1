Return-Path: <stable+bounces-93914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718DF9D1F63
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC67B24583
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CF114E2DA;
	Tue, 19 Nov 2024 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHzrH2PN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87485149C57
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991009; cv=none; b=F26FUzVgNZv4U59M8nQHMgyI3OdLPlQg/vUh2OcRQXHtriKGLfXlFAD9NZ7oe8CW54oJ2XQ4+D0jR2gNw0DBZ8MMfGj8FvR0MSbjTAKSbj/xqk8ALPIufv1meO531dq6qmVDjZHB1jISpFzO6XyoG229bTnb0x1ll2C7SBPFKCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991009; c=relaxed/simple;
	bh=FtSgMEojX8E1mt2CnEAYS/Hjli6PL7gYgD+GLTrRXo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5kHCiAlyNIhN5rc0/vJw+J0r9btDnqh8Q1ECgpE3mhMpN6ES3bkXOCq0hO7CiL3wraf8GO+JvTUmr1xltwh92346pMuUHtE7hvOlSXsu0JuUeOMwsHaSFSJD6s2FzdL6+Kah/rzsWu4TwyBooUhnRK4OkZXYsEG+O0D7GORJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHzrH2PN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38B0C4CECF;
	Tue, 19 Nov 2024 04:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731991009;
	bh=FtSgMEojX8E1mt2CnEAYS/Hjli6PL7gYgD+GLTrRXo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHzrH2PNudUs5yKDaTqPI0Ih8icvu5JP0ksbb/gBSpK/KPvbr/pU/bPke2az4Rr7R
	 VH16jbcC3bSPkuEwOdwb3VSL0qxjKdxaCq+KFfJc8JJO7adTYRR3G6aM13RcfHUudJ
	 Y0ia7Nyuiz1Bv48OXgF5T+lHaq7JV06dj8d3zHElvPCNs9jKO9L6Jclc+vAehJIQJW
	 d0whGHbB7baJmiZbQ1hjH+KZ1M3AqaEFlf7bRiwenX6SMqSWa8tBexaJ+VJ93jnWO2
	 RhEY3KfHEuMNJexXHuazCKhX10f1YtXCCBfj5ba0FV2ALTv4hPJgfWRE+N6TdCnmxX
	 eF000zUsSDCCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net: phy: phy_device: Prevent nullptr exceptions on ISR
Date: Mon, 18 Nov 2024 23:36:47 -0500
Message-ID: <20241118060625.937010-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118060625.937010-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 61c81872815f46006982bb80460c0c80a949b35b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Andre Werner <andre.werner@systec-electronic.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Present (different SHA1: 7a71f61ebf95)      |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 16:38:01.483389153 -0500
+++ /tmp/tmp.SYoIAckoNK	2024-11-18 16:38:01.476295468 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 61c81872815f46006982bb80460c0c80a949b35b ]
+
 If phydev->irq is set unconditionally, check
 for valid interrupt handler or fall back to polling mode to prevent
 nullptr exceptions in interrupt service routine.
@@ -6,15 +8,17 @@
 Reviewed-by: Andrew Lunn <andrew@lunn.ch>
 Link: https://lore.kernel.org/r/20240129135734.18975-2-andre.werner@systec-electronic.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/net/phy/phy_device.c | 13 ++++++++-----
  1 file changed, 8 insertions(+), 5 deletions(-)
 
 diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
-index dd778c7fde1dd..52828d1c64f7a 100644
+index f25b0d338ca8..b165f92db51c 100644
 --- a/drivers/net/phy/phy_device.c
 +++ b/drivers/net/phy/phy_device.c
-@@ -1413,6 +1413,11 @@ int phy_sfp_probe(struct phy_device *phydev,
+@@ -1378,6 +1378,11 @@ int phy_sfp_probe(struct phy_device *phydev,
  }
  EXPORT_SYMBOL(phy_sfp_probe);
  
@@ -26,9 +30,9 @@
  /**
   * phy_attach_direct - attach a network device to a given PHY device pointer
   * @dev: network device to attach
-@@ -1527,6 +1532,9 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
- 	if (phydev->dev_flags & PHY_F_NO_IRQ)
- 		phydev->irq = PHY_POLL;
+@@ -1487,6 +1492,9 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
+ 
+ 	phydev->interrupts = PHY_INTERRUPT_DISABLED;
  
 +	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
 +		phydev->irq = PHY_POLL;
@@ -36,7 +40,7 @@
  	/* Port is set to PORT_TP by default and the actual PHY driver will set
  	 * it to different value depending on the PHY configuration. If we have
  	 * the generic PHY driver we can't figure it out, thus set the old
-@@ -2992,11 +3000,6 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
+@@ -2926,11 +2934,6 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
  }
  EXPORT_SYMBOL(phy_get_internal_delay);
  
@@ -45,6 +49,9 @@
 -	return phydrv->config_intr && phydrv->handle_interrupt;
 -}
 -
- static int phy_led_set_brightness(struct led_classdev *led_cdev,
- 				  enum led_brightness value)
- {
+ /**
+  * fwnode_mdio_find_device - Given a fwnode, find the mdio_device
+  * @fwnode: pointer to the mdio_device's fwnode
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

