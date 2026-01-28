Return-Path: <stable+bounces-212240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLVKLn8wemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:51:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8922A48FB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8DBF31876D8
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773612FF164;
	Wed, 28 Jan 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQWVmVqF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC932F361A;
	Wed, 28 Jan 2026 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614853; cv=none; b=jRmlzpx1AxqmczbRs5o+0k+k/Ksp2e8nM7FwTyhkO86TGb6ZHdGB9diDzJnCQOGs6h5uSiUtlmG43CYRV5RHTBpW15Kb7o3jI7baOt9a97dyT9eor+hr8rUqD8G1U8ydW8AczRvsoIkzSrqz4AFZvB3KKq88VqYELnaLiX42a6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614853; c=relaxed/simple;
	bh=Ar47heN5uPIP8FNc/0yBfLd8d7B0Zwf4ojEFjbrHR9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCum1E9IqtTDXcwA1ef57LQD1YZ9uCCSZU4DHfI6XseN4eSC35aTcuXqTQJnhVP4uFVpDlufEwNBQ6fnp3aoiBLTr9g6ig+QPWzYWkDF3J33NZvdK+HemRnXbz5sOBvwvEr5fIn82SKH2MksX+KV8J4N8XMc562AouGHmeXB98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQWVmVqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9997CC4CEF1;
	Wed, 28 Jan 2026 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614853;
	bh=Ar47heN5uPIP8FNc/0yBfLd8d7B0Zwf4ojEFjbrHR9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQWVmVqFmGVhCt1OZi4xT/GNxNsRHEuD4aW12M/4CUvvwzC51424RVVZ8iTS216BZ
	 eogL7UE8WxmXBXjcNMal6x+35Xi91Ej/8bzBSYd7uN18ZVSlqlznyoCTFO22T0b5Zm
	 KYGJVvdZbmKztSIfdUdGVU9GqKIs+HD9Op1o46ZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Rajani Kantha <681739313@139.com>
Subject: [PATCH 6.6 252/254] net: phy: move phy_link_change() prior to mdio_bus_phy_may_suspend()
Date: Wed, 28 Jan 2026 16:23:48 +0100
Message-ID: <20260128145353.866904730@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-212240-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,nxp.com,armlinux.org.uk,kernel.org,139.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[139.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D8922A48FB
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit f40a673d6b4a128fe95dd9b8c3ed02da50a6a862 ]

In an upcoming change, mdio_bus_phy_may_suspend() will need to
distinguish a phylib-based PHY client from a phylink PHY client.
For that, it will need to compare the phydev->phy_link_change() function
pointer with the eponymous phy_link_change() provided by phylib.

To avoid forward function declarations, the default PHY link state
change method should be moved upwards. There is no functional change
associated with this patch, it is only to reduce the noise from a real
bug fix.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20250407093900.2155112-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Minor context change fixed ]
Signed-off-by: Rajani Kantha <681739313@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -268,6 +268,19 @@ static struct phy_driver genphy_driver;
 static LIST_HEAD(phy_fixup_list);
 static DEFINE_MUTEX(phy_fixup_lock);
 
+static void phy_link_change(struct phy_device *phydev, bool up)
+{
+	struct net_device *netdev = phydev->attached_dev;
+
+	if (up)
+		netif_carrier_on(netdev);
+	else
+		netif_carrier_off(netdev);
+	phydev->adjust_link(netdev);
+	if (phydev->mii_ts && phydev->mii_ts->link_state)
+		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
+}
+
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -1069,19 +1082,6 @@ struct phy_device *phy_find_first(struct
 }
 EXPORT_SYMBOL(phy_find_first);
 
-static void phy_link_change(struct phy_device *phydev, bool up)
-{
-	struct net_device *netdev = phydev->attached_dev;
-
-	if (up)
-		netif_carrier_on(netdev);
-	else
-		netif_carrier_off(netdev);
-	phydev->adjust_link(netdev);
-	if (phydev->mii_ts && phydev->mii_ts->link_state)
-		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
-}
-
 /**
  * phy_prepare_link - prepares the PHY layer to monitor link status
  * @phydev: target phy_device struct



