Return-Path: <stable+bounces-36076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B637D899A89
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F932282770
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12319161908;
	Fri,  5 Apr 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2S1cL+TC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF416133F
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312198; cv=none; b=g7Q6VFoSaiqXhbG2IqnTnds6Bo42C4bnbWJx3V2wqJu8DiVlSKaSLjVW4DDCPUhLd0n+GQMRdSXcXMrxYvFcMQNez3cthKTDHaCz3Yn/4FYpH7VuHCzYn0UxY040UKVSApJ7BBPM2ZM2bxAY8w2mVMXKyLHEbMXjpT4risJUSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312198; c=relaxed/simple;
	bh=Nq374zjnUp56nzVG2Yt5yE8OpuHw3C3UrL/Tntq/wKE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C9HdIeqd3pHHrGezAZMB+g9jaQw+SnLUWR3COEx7dWqa6U50TtgQQuqn4eH6Vzk761AHyhbueMjJUQVuzB26qPgtwuf0E6kazn2a1KxkwM/alBPhBhtk//lV2jvPrcDYwzqCTq1C3JK0XZqyKnub36XG9xWdpv/1K1wpNbvzgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2S1cL+TC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF822C433F1;
	Fri,  5 Apr 2024 10:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712312198;
	bh=Nq374zjnUp56nzVG2Yt5yE8OpuHw3C3UrL/Tntq/wKE=;
	h=Subject:To:Cc:From:Date:From;
	b=2S1cL+TCdDeIe9rID6Uo8SJXdkSIBdmK3V3Rxn79GfJcWKFTaa6qfJy5JHT0ljIh9
	 vDcX++hJ1l7FHD/HdB7kUM+ehHMMuZsvfyMvwMmLdjgT7ZxnhBNyxsSO9cN8Tdvz00
	 gWn1evBp/hCxR7IsaTanNhClh8loRXwhRPCjTGnc=
Subject: FAILED: patch "[PATCH] net: fec: Set mac_managed_pm during probe" failed to apply to 5.15-stable tree
To: wei.fang@nxp.com,john.ernberg@actia.se,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 12:16:27 +0200
Message-ID: <2024040527-action-late-9749@gregkh>
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
git cherry-pick -x cbc17e7802f5de37c7c262204baadfad3f7f99e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040527-action-late-9749@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cbc17e7802f5de37c7c262204baadfad3f7f99e5 Mon Sep 17 00:00:00 2001
From: Wei Fang <wei.fang@nxp.com>
Date: Thu, 28 Mar 2024 15:59:29 +0000
Subject: [PATCH] net: fec: Set mac_managed_pm during probe

Setting mac_managed_pm during interface up is too late.

In situations where the link is not brought up yet and the system suspends
the regular PHY power management will run. Since the FEC ETHEREN control
bit is cleared (automatically) on suspend the controller is off in resume.
When the regular PHY power management resume path runs in this context it
will write to the MII_DATA register but nothing will be transmitted on the
MDIO bus.

This can be observed by the following log:

    fec 5b040000.ethernet eth0: MDIO read timeout
    Microchip LAN87xx T1 5b040000.ethernet-1:04: PM: dpm_run_callback(): mdio_bus_phy_resume+0x0/0xc8 returns -110
    Microchip LAN87xx T1 5b040000.ethernet-1:04: PM: failed to resume: error -110

The data written will however remain in the MII_DATA register.

When the link later is set to administrative up it will trigger a call to
fec_restart() which will restore the MII_SPEED register. This triggers the
quirk explained in f166f890c8f0 ("net: ethernet: fec: Replace interrupt
driven MDIO with polled IO") causing an extra MII_EVENT.

This extra event desynchronizes all the MDIO register reads, causing them
to complete too early. Leading all reads to read as 0 because
fec_enet_mdio_wait() returns too early.

When a Microchip LAN8700R PHY is connected to the FEC, the 0 reads causes
the PHY to be initialized incorrectly and the PHY will not transmit any
ethernet signal in this state. It cannot be brought out of this state
without a power cycle of the PHY.

Fixes: 557d5dc83f68 ("net: fec: use mac-managed PHY PM")
Closes: https://lore.kernel.org/netdev/1f45bdbe-eab1-4e59-8f24-add177590d27@actia.se/
Signed-off-by: Wei Fang <wei.fang@nxp.com>
[jernberg: commit message]
Signed-off-by: John Ernberg <john.ernberg@actia.se>
Link: https://lore.kernel.org/r/20240328155909.59613-2-john.ernberg@actia.se
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d7693fdf640d..8bd213da8fb6 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2454,8 +2454,6 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 	fep->link = 0;
 	fep->full_duplex = 0;
 
-	phy_dev->mac_managed_pm = true;
-
 	phy_attached_info(phy_dev);
 
 	return 0;
@@ -2467,10 +2465,12 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	bool suppress_preamble = false;
+	struct phy_device *phydev;
 	struct device_node *node;
 	int err = -ENXIO;
 	u32 mii_speed, holdtime;
 	u32 bus_freq;
+	int addr;
 
 	/*
 	 * The i.MX28 dual fec interfaces are not equal.
@@ -2584,6 +2584,13 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 		goto err_out_free_mdiobus;
 	of_node_put(node);
 
+	/* find all the PHY devices on the bus and set mac_managed_pm to true */
+	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
+		phydev = mdiobus_get_phy(fep->mii_bus, addr);
+		if (phydev)
+			phydev->mac_managed_pm = true;
+	}
+
 	mii_cnt++;
 
 	/* save fec0 mii_bus */


