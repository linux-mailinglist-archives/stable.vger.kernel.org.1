Return-Path: <stable+bounces-192042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F85C28FC2
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFED3AE4CD
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D40B1E5B60;
	Sun,  2 Nov 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ntk5w7fG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF912566
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091168; cv=none; b=Si1uz72M7nKhWDvEdauQjA3KOrZ2YV2yc5CbYVLEfdLlwB8MGkVAIKCP8ITQVf3lFsadxAUChhQVQZrvZOxOTlQncL/mZxE4j8Hf3j1ix/zCYXT5SoRzu09zPNsnoIAbM156Z/MUfbC3B99rET3jss4RRjMiTx53FaEcHAq0Z1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091168; c=relaxed/simple;
	bh=93S1fjeyAXPC9Lj2oDBA308F7PxK0bOlWl96YPH4+6k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=saK7Vk+jk/0wu9YnuTq2jPeJ+M4T8dWSPi6ObkC7VsL3R7ZMFXzUATjgh8EaHwyiuizhxVhRQZmSnQig5SkFXm1TAlsmMWNtIpunYIJtuS9yVP4Gf+IA5Rm8XmWUkrsVz13nLoUFaFqEtrOQlU8n9hHf91YuqvAPdOooKJvbphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ntk5w7fG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417A5C4CEF7;
	Sun,  2 Nov 2025 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762091165;
	bh=93S1fjeyAXPC9Lj2oDBA308F7PxK0bOlWl96YPH4+6k=;
	h=Subject:To:Cc:From:Date:From;
	b=ntk5w7fGkV01U9NQap6rtOkSNnETSktW17c50EZ00V1vMUEHgIe2cMGyof3D/jQHk
	 x4mHebdjNcqqUoFe4vLuTpaai0XOwkjFJTzIXycLhPHmezqo2rzwTyWTXiHLSr9is8
	 N23zDdUFuC1g1HeNtic+EKIyTIFdbhF9jFVVPzW8=
Subject: FAILED: patch "[PATCH] net: phy: dp83867: Disable EEE support as not implemented" failed to apply to 6.1-stable tree
To: emanuele.ghidoli@toradex.com,andrew@lunn.ch,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:46:02 +0900
Message-ID: <2025110202-hamstring-ended-9680@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110202-hamstring-ended-9680@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f Mon Sep 17 00:00:00 2001
From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Date: Thu, 23 Oct 2025 16:48:53 +0200
Subject: [PATCH] net: phy: dp83867: Disable EEE support as not implemented

While the DP83867 PHYs report EEE capability through their feature
registers, the actual hardware does not support EEE (see Links).
When the connected MAC enables EEE, it causes link instability and
communication failures.

The issue is reproducible with a iMX8MP and relevant stmmac ethernet port.
Since the introduction of phylink-managed EEE support in the stmmac driver,
EEE is now enabled by default, leading to issues on systems using the
DP83867 PHY.

Call phy_disable_eee during phy initialization to prevent EEE from being
enabled on DP83867 PHYs.

Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/1445244/dp83867ir-dp83867-disable-eee-lpi
Link: https://e2e.ti.com/support/interface-group/interface/f/interface-forum/658638/dp83867ir-eee-energy-efficient-ethernet
Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20251023144857.529566-1-ghidoliemanuele@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index deeefb962566..36a0c1b7f59c 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -738,6 +738,12 @@ static int dp83867_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Although the DP83867 reports EEE capability through the
+	 * MDIO_PCS_EEE_ABLE and MDIO_AN_EEE_ADV registers, the feature
+	 * is not actually implemented in hardware.
+	 */
+	phy_disable_eee(phydev);
+
 	if (phy_interface_is_rgmii(phydev) ||
 	    phydev->interface == PHY_INTERFACE_MODE_SGMII) {
 		val = phy_read(phydev, MII_DP83867_PHYCTRL);


