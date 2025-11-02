Return-Path: <stable+bounces-192030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0670C28F98
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 605044E6210
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9757E1B87EB;
	Sun,  2 Nov 2025 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TBA99fut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56445163
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762090934; cv=none; b=GfcN9b3qNaDRe9y4pDu5HnQHoyS9ZyvBfzwU3o3CfTeB5ohFjj1nDvs3i7HoxVotEmmXTkRHAiu3w27WiMuZXJVO0W1P/jSELpj4PCY8ENwey9//ZqW2hLo6SA7VAIt7+LagVHi0q9ECeve1GdWLWPn3TXhuFElO7FIuMrjcaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762090934; c=relaxed/simple;
	bh=VnUlUaJMhxA255A4b1JlIpPtx+3EjgYLzLZ521Fabak=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b1u3HHoiNXBg21Lt0Nt7RgqAELKz1WWRdz14Rn5aC5ex2igxxhlpTeebaT+wfAwt5nXEYzpB3n3CjP8Ism6yfINyu3/yIe1noqjgnG2x7gdC6q72CGXTP7JDqkAX8HaX5HGHIlhGuCmD4iFku9RweVvzw0azT5deGwBZilGHmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TBA99fut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933D1C4CEF7;
	Sun,  2 Nov 2025 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762090933;
	bh=VnUlUaJMhxA255A4b1JlIpPtx+3EjgYLzLZ521Fabak=;
	h=Subject:To:Cc:From:Date:From;
	b=TBA99futCEBpehBQ5Nn8yHtlSGVIwXvkNcb2wHG2J1PAnWIfc8GMoWELgNjoGZPSk
	 ulmxYV6GhZbjk5lnOSF92LYyDN5CcIE7o+0sEy89P09qDIF4ikgteVPeM6FNeE0Ilm
	 Z8UfJz8VyIZWWj6JOlzz1AQwhNddB4Osb5ab/itw=
Subject: FAILED: patch "[PATCH] net: phy: dp83867: Disable EEE support as not implemented" failed to apply to 5.4-stable tree
To: emanuele.ghidoli@toradex.com,andrew@lunn.ch,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:42:11 +0900
Message-ID: <2025110211-badly-cut-6b14@gregkh>
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
git cherry-pick -x 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110211-badly-cut-6b14@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


