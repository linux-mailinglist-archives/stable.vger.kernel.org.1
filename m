Return-Path: <stable+bounces-43672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B28C42AC
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A3F1F223C5
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7731A153585;
	Mon, 13 May 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l5pDDQ1P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD8153580
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608668; cv=none; b=U+wyhE56gTj9iuU84n30fkQBHrmTvV+amC4s9UzP2OsWkc1E2V8ngB5/Eq2zvzWMWOzduNM0kdUriusA6UwohctOF1UsS1Bub4A7erAVCro4zkSTQcDbnXJnHDIPQZ6bYVYlFFQLhb2rzt0Yj42R4hxE8qsT+V6zSOCg5HRbrjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608668; c=relaxed/simple;
	bh=ognlrjetEmwDxBFmIUhlmXN7Si/ypGSVopNFzJQdeF8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HhtHiDkkrB5p0+LxFXLdqsbEFhmtTJPVKB5LHz7KoRN7Elv0SVyC4DAhLflwG3V9ksbMj6c9dzbD2Y1t5ZGHMUU3D4yvgFz8n4Ke/ENZY2cn8oznl4e6lrsD9+o1f+w0ku8jjUAKgzbhpsAmUZK3fY/6ByRoipg3muvraCUhJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l5pDDQ1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F50FC4AF10;
	Mon, 13 May 2024 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715608668;
	bh=ognlrjetEmwDxBFmIUhlmXN7Si/ypGSVopNFzJQdeF8=;
	h=Subject:To:Cc:From:Date:From;
	b=l5pDDQ1PmmR3xrAZaAE0GMfWZJfhO/5x44wtEAR0Twx9+0xPvcx361rApQz3nZLko
	 MCmNAbrVmhbUvM9U15/utORP1w7O3k0vkWjbcEv9xgRgN/Cq4SAyL+zyAnQBstbzrd
	 e0nDbHNfmuyHLrQf7eygkVrNlMcXZ4OO4iW/FvXU=
Subject: FAILED: patch "[PATCH] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access" failed to apply to 5.15-stable tree
To: opendmb@gmail.com,davem@davemloft.net,florian.fainelli@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:57:44 +0200
Message-ID: <2024051343-casket-astride-c192@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d85cf67a339685beae1d0aee27b7f61da95455be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051343-casket-astride-c192@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d85cf67a3396 ("net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access")
696450c05181 ("net: bcmgenet: Clear RGMII_LINK upon link down")
fc13d8c03773 ("net: bcmgenet: pull mac_config from adjust_link")
fcb5dfe7dc40 ("net: bcmgenet: remove old link state values")
50e356686fa9 ("net: bcmgenet: remove netif_carrier_off from adjust_link")
b972b54a68b2 ("net: bcmgenet: Patch PHY interface for dedicated PHY driver")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d85cf67a339685beae1d0aee27b7f61da95455be Mon Sep 17 00:00:00 2001
From: Doug Berger <opendmb@gmail.com>
Date: Thu, 25 Apr 2024 15:27:19 -0700
Subject: [PATCH] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access

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

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 9ada89355747..86a4aa72b3d4 100644
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
@@ -275,6 +275,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 	 * block for the interface to work, unconditionally clear the
 	 * Out-of-band disable since we do not need it.
 	 */
+	mutex_lock(&phydev->lock);
 	reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 	reg &= ~OOB_DISABLE;
 	if (priv->ext_phy) {
@@ -286,6 +287,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 			reg |= RGMII_MODE_EN;
 	}
 	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+	mutex_unlock(&phydev->lock);
 
 	if (init)
 		dev_info(kdev, "configuring instance for %s\n", phy_name);


