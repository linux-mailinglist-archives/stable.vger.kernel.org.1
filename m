Return-Path: <stable+bounces-43677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98398C42B3
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1465D1C21015
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D61153587;
	Mon, 13 May 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e5/fWUwH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346414EC7A
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608716; cv=none; b=IjiKiCeLt+calwqfk72LYM7bYe7gqnp80wWQyLfx9HyUD+c2I+UBWihP/i5R/8M7nzzZS0fhNRAg2T7djF7AxraSj8+Nq5vx7cTagdWyupG+ubQYh69+mh6eV0u+rTj06sFYdJ95h7mGnnXbXEf8S5s3BaqeiEOJ/HK3LP0+y+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608716; c=relaxed/simple;
	bh=7s6CRWrRSwrTCmboj+ENhRqVG28W9jDOsHTscVFo/Mo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FgVIphxsFIGkoPegvBuACF+T9XJK/bYaB4GSNCRTHJo4ykVXQDnacpatuCBVlV4vGCqJkGxQhLTJgt5mPdkSVCWz1bAcUw7FifgX6puDrinGiZUcfgoxA7WR6xH0v1VAkxpixrD7rd1j+285/mQ7nQWhRJLwe/mr6i5hJSe430c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e5/fWUwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2C0C113CC;
	Mon, 13 May 2024 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715608716;
	bh=7s6CRWrRSwrTCmboj+ENhRqVG28W9jDOsHTscVFo/Mo=;
	h=Subject:To:Cc:From:Date:From;
	b=e5/fWUwH9wCiuPTLZ8r/wHP5lCh6Z9i7Qn1MUO3o3Kj48IC2JH4gCWqZsg9iscDAl
	 WRdQ8zFICvyYGt9AMzxaZR7SuWzlBDh9fZhYKd06e2C11yJpccCSwn4bs0Lr4jBsyE
	 1/2lZYiSZWRSJ6quBi/MfrW6PO9J2eHNYxe8TUFw=
Subject: FAILED: patch "[PATCH] net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()" failed to apply to 4.19-stable tree
To: opendmb@gmail.com,davem@davemloft.net,florian.fainelli@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:58:24 +0200
Message-ID: <2024051323-tinfoil-decoy-9476@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 2dbe5f19368caae63b1f59f5bc2af78c7d522b3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051323-tinfoil-decoy-9476@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

2dbe5f19368c ("net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()")
1a1d5106c1e3 ("net: bcmgenet: move clk_wol management to bcmgenet_wol")
6f7689057a0f ("net: bcmgenet: Fix WoL with password after deep sleep")
72f96347628e ("net: bcmgenet: set Rx mode before starting netif")
99d55638d4b0 ("net: bcmgenet: enable NETIF_F_HIGHDMA flag")
d7ee287827ef ("Merge tag 'blk-dim-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2dbe5f19368caae63b1f59f5bc2af78c7d522b3a Mon Sep 17 00:00:00 2001
From: Doug Berger <opendmb@gmail.com>
Date: Thu, 25 Apr 2024 15:27:20 -0700
Subject: [PATCH] net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()

The ndo_set_rx_mode function is synchronized with the
netif_addr_lock spinlock and BHs disabled. Since this
function is also invoked directly from the driver the
same synchronization should be applied.

Fixes: 72f96347628e ("net: bcmgenet: set Rx mode before starting netif")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b1f84b37032a..5452b7dc6e6a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET (Gigabit Ethernet) controller driver
  *
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)				"bcmgenet: " fmt
@@ -3334,7 +3334,9 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	/* Start the network engine */
+	netif_addr_lock_bh(dev);
 	bcmgenet_set_rx_mode(dev);
+	netif_addr_unlock_bh(dev);
 	bcmgenet_enable_rx_napi(priv);
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);


