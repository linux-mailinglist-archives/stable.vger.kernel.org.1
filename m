Return-Path: <stable+bounces-43676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD658C42B0
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4C81F22285
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55598153576;
	Mon, 13 May 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KuSJDPPD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB014EC7A
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608705; cv=none; b=TMPkRmvMntzRkF5LwwhNrTIQsCX3tVKOoJvnjWEmyIoYhlvxgfuHVTGmT76eJ3AWmMaGe25ou/Xdlu/DQh+ZSvDZhStCIFdRaFOn9RoAn+Elc6yr07ohZTDawYGjrLH19xJVOe0vgEdQRNVnAgkDUivpeIziIcWjENLIgUs8tzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608705; c=relaxed/simple;
	bh=xzNm4PUtCIBRWHbWif1XznMmbShRm2GT0oRaQRLG3ow=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ph0kqAFMdY/ShpZXoSA2sLTFZbDC+T2QUpExTswJS+I/+vj1IM+X2LCeeH0uO0iCMTpD42qzCXDTxhjx2236XPYmJOM2ErviqVGDIIWckRCiAaGKXu7/YU6R6QNiLH3HzG3MLnWyEVlmG1Hb4nLBlgswJNVQQqCD8m2Q0byPcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KuSJDPPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696CDC4AF0F;
	Mon, 13 May 2024 13:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715608704;
	bh=xzNm4PUtCIBRWHbWif1XznMmbShRm2GT0oRaQRLG3ow=;
	h=Subject:To:Cc:From:Date:From;
	b=KuSJDPPDJabh4TIMXO4YOEdH+WUeVQvtdR0BQECgTtr+c1oLoEqoCXJkd8qjn/q65
	 sqhd4aF5eh1Yknr1WqJY4dOqKuN4AXHsXguat5yJOT00FdPUfKCbsBvZSVxgPia97o
	 SCrkb4nhPiPANuUMRQTYP8qDPS1K+6yfJXH7qDvU=
Subject: FAILED: patch "[PATCH] net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()" failed to apply to 5.4-stable tree
To: opendmb@gmail.com,davem@davemloft.net,florian.fainelli@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:58:21 +0200
Message-ID: <2024051321-oval-cruelness-c028@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2dbe5f19368caae63b1f59f5bc2af78c7d522b3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051321-oval-cruelness-c028@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

2dbe5f19368c ("net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()")
1a1d5106c1e3 ("net: bcmgenet: move clk_wol management to bcmgenet_wol")
6f7689057a0f ("net: bcmgenet: Fix WoL with password after deep sleep")
72f96347628e ("net: bcmgenet: set Rx mode before starting netif")
99d55638d4b0 ("net: bcmgenet: enable NETIF_F_HIGHDMA flag")

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


