Return-Path: <stable+bounces-192045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E23C28FBF
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91E80347BEC
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DADE1547C9;
	Sun,  2 Nov 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sFxpIfgM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077E22615
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091178; cv=none; b=PYEjoTYXVW6VrQcQTyZawcfkTeQzNThfbzpyubgC4XfIGSasal1gKPk0PQKIt6+dChfPDNYoYQdsy2wW2y7mVi6HBH8Jp5a7nnxNKCkd5qXiUfohKRfVFli4eafh71kzQlv0KDzdfHvUSA/uh8+BLBa7099NhtKPXJMS+hkHXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091178; c=relaxed/simple;
	bh=Z6Vk9G4lCXYl1hPeDPyIqzqGLvvMwygowu4GYnY0gk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bnFrEPklqcorssJjNzF0qIRhwI8StcRk1p1yEpvcYCm0HAQ8SiOmPt5oxl+AgLTArJGiGKTAsM2S+ZvIlToOi6Wq+3mtKq+YxM6Vvr/oWTJ5C6iHt/ne3E8qqt6KylcZFBs+JKL2zVY/ztaFH9/3I5kLuy7l+w2Uk6cAvt19O1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sFxpIfgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF07C4CEFD;
	Sun,  2 Nov 2025 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762091177;
	bh=Z6Vk9G4lCXYl1hPeDPyIqzqGLvvMwygowu4GYnY0gk0=;
	h=Subject:To:Cc:From:Date:From;
	b=sFxpIfgMjU34tpuprkVl38Pi88m8h99QHW05MhlsEVAdE0bgps1QsBx7+62tjH1m9
	 LFj62coHXSbKEQofCV5cvajaijpVzU599STJfHkOo+79/B3oB5N2Q7JWLI06U545EK
	 ZLM8lPTlh55yMq62zoXNgOQa6XjG8E/pF6CLepDQ=
Subject: FAILED: patch "[PATCH] net: phy: dp83867: Disable EEE support as not implemented" failed to apply to 5.4-stable tree
To: emanuele.ghidoli@toradex.com,andrew@lunn.ch,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:46:05 +0900
Message-ID: <2025110205-customer-qualifier-2030@gregkh>
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
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110205-customer-qualifier-2030@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


