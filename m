Return-Path: <stable+bounces-133283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D704AA924F9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC12465809
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0E26138F;
	Thu, 17 Apr 2025 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WtkKYMIV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768A25FA0F;
	Thu, 17 Apr 2025 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912613; cv=none; b=LG9N5mEnFVaFl98lWlsgKlC5/GgrGzZPZA+DqCvqvKfzprlD2xYfERcSOVGMYKGfvQ8WGr+7c2rom69P2jDPAYtAA9iYtL2P9DLFkeWQkkYHh0hDphkhqgpAceF9DmkGMnUbzf5Grw2HA9Jy7Xzj0aK90hPxAdo6hkBIslS6PBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912613; c=relaxed/simple;
	bh=87Oqp63J5GzIlQRAOxeeOhVxGxOcVAG8P0aPqgdVlag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nn0S83lwvpmhW52JxaOtNfha3T95auCQ9DWmdszhBJAHZYQ2nCCy4IMcE06+69NAVFcpf0HRgT5kDnWeO1vTKa5ETZGQVqb9jdPH5HpCK4vB66sYL7L4wVqm/FW+m9bXB2/todsvC5YGrJI15dvhSvJoRPF7VUeJzFuFyxzVISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WtkKYMIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B65DC4CEE4;
	Thu, 17 Apr 2025 17:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744912613;
	bh=87Oqp63J5GzIlQRAOxeeOhVxGxOcVAG8P0aPqgdVlag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtkKYMIVbIQM6Th/TSH8VDdXN8KtiHo1oVV7oStS0apVKB9q0PjV5nX/RrR9EjKyt
	 fmaElHgWWGkb3lZejLA4aulclmj8b8vSDwEVkiU4vMz8Gsi4g9VEfPq9e13JOmYCGP
	 HYwtpegpuzLVWfX+2jH4iA3iRv3WO9EsGEkAgxeY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Fang <wei.fang@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 039/449] net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY
Date: Thu, 17 Apr 2025 19:45:27 +0200
Message-ID: <20250417175119.565162864@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit fc75ea20ffb452652f0d4033f38fe88d7cfdae35 ]

DSA has 2 kinds of drivers:

1. Those who call dsa_switch_suspend() and dsa_switch_resume() from
   their device PM ops: qca8k-8xxx, bcm_sf2, microchip ksz
2. Those who don't: all others. The above methods should be optional.

For type 1, dsa_switch_suspend() calls dsa_user_suspend() -> phylink_stop(),
and dsa_switch_resume() calls dsa_user_resume() -> phylink_start().
These seem good candidates for setting mac_managed_pm = true because
that is essentially its definition [1], but that does not seem to be the
biggest problem for now, and is not what this change focuses on.

Talking strictly about the 2nd category of DSA drivers here (which
do not have MAC managed PM, meaning that for their attached PHYs,
mdio_bus_phy_suspend() and mdio_bus_phy_resume() should run in full),
I have noticed that the following warning from mdio_bus_phy_resume() is
triggered:

	WARN_ON(phydev->state != PHY_HALTED && phydev->state != PHY_READY &&
		phydev->state != PHY_UP);

because the PHY state machine is running.

It's running as a result of a previous dsa_user_open() -> ... ->
phylink_start() -> phy_start() having been initiated by the user.

The previous mdio_bus_phy_suspend() was supposed to have called
phy_stop_machine(), but it didn't. So this is why the PHY is in state
PHY_NOLINK by the time mdio_bus_phy_resume() runs.

mdio_bus_phy_suspend() did not call phy_stop_machine() because for
phylink, the phydev->adjust_link function pointer is NULL. This seems a
technicality introduced by commit fddd91016d16 ("phylib: fix PAL state
machine restart on resume"). That commit was written before phylink
existed, and was intended to avoid crashing with consumer drivers which
don't use the PHY state machine - phylink always does, when using a PHY.
But phylink itself has historically not been developed with
suspend/resume in mind, and apparently not tested too much in that
scenario, allowing this bug to exist unnoticed for so long. Plus, prior
to the WARN_ON(), it would have likely been invisible.

This issue is not in fact restricted to type 2 DSA drivers (according to
the above ad-hoc classification), but can be extrapolated to any MAC
driver with phylink and MDIO-bus-managed PHY PM ops. DSA is just where
the issue was reported. Assuming mac_managed_pm is set correctly, a
quick search indicates the following other drivers might be affected:

$ grep -Zlr PHYLINK_NETDEV drivers/ | xargs -0 grep -L mac_managed_pm
drivers/net/ethernet/atheros/ag71xx.c
drivers/net/ethernet/microchip/sparx5/sparx5_main.c
drivers/net/ethernet/microchip/lan966x/lan966x_main.c
drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
drivers/net/ethernet/freescale/ucc_geth.c
drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
drivers/net/ethernet/marvell/mvneta.c
drivers/net/ethernet/marvell/prestera/prestera_main.c
drivers/net/ethernet/mediatek/mtk_eth_soc.c
drivers/net/ethernet/altera/altera_tse_main.c
drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
drivers/net/ethernet/tehuti/tn40_phy.c
drivers/net/ethernet/mscc/ocelot_net.c

Make the existing conditions dependent on the PHY device having a
phydev->phy_link_change() implementation equal to the default
phy_link_change() provided by phylib. Otherwise, we implicitly know that
the phydev has the phylink-provided phylink_phy_change() callback, and
when phylink is used, the PHY state machine always needs to be stopped/
started on the suspend/resume path. The code is structured as such that
if phydev->phy_link_change() is absent, it is a matter of time until the
kernel will crash - no need to further complicate the test.

Thus, for the situation where the PM is not managed by the MAC, we will
make the MDIO bus PM ops treat identically the phylink-controlled PHYs
with the phylib-controlled PHYs where an adjust_link() callback is
supplied. In both cases, the MDIO bus PM ops should stop and restart the
PHY state machine.

[1] https://lore.kernel.org/netdev/Z-1tiW9zjcoFkhwc@shell.armlinux.org.uk/

Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
Reported-by: Wei Fang <wei.fang@nxp.com>
Tested-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250407094042.2155633-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 27d61d95933fa..92161af788afd 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -253,6 +253,33 @@ static void phy_link_change(struct phy_device *phydev, bool up)
 		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
 }
 
+/**
+ * phy_uses_state_machine - test whether consumer driver uses PAL state machine
+ * @phydev: the target PHY device structure
+ *
+ * Ultimately, this aims to indirectly determine whether the PHY is attached
+ * to a consumer which uses the state machine by calling phy_start() and
+ * phy_stop().
+ *
+ * When the PHY driver consumer uses phylib, it must have previously called
+ * phy_connect_direct() or one of its derivatives, so that phy_prepare_link()
+ * has set up a hook for monitoring state changes.
+ *
+ * When the PHY driver is used by the MAC driver consumer through phylink (the
+ * only other provider of a phy_link_change() method), using the PHY state
+ * machine is not optional.
+ *
+ * Return: true if consumer calls phy_start() and phy_stop(), false otherwise.
+ */
+static bool phy_uses_state_machine(struct phy_device *phydev)
+{
+	if (phydev->phy_link_change == phy_link_change)
+		return phydev->attached_dev && phydev->adjust_link;
+
+	/* phydev->phy_link_change is implicitly phylink_phy_change() */
+	return true;
+}
+
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -319,7 +346,7 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	 * may call phy routines that try to grab the same lock, and that may
 	 * lead to a deadlock.
 	 */
-	if (phydev->attached_dev && phydev->adjust_link)
+	if (phy_uses_state_machine(phydev))
 		phy_stop_machine(phydev);
 
 	if (!mdio_bus_phy_may_suspend(phydev))
@@ -373,7 +400,7 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 		}
 	}
 
-	if (phydev->attached_dev && phydev->adjust_link)
+	if (phy_uses_state_machine(phydev))
 		phy_start_machine(phydev);
 
 	return 0;
-- 
2.39.5




