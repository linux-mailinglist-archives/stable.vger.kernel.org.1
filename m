Return-Path: <stable+bounces-230566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKaWDjnkxWkeCwUAu9opvQ
	(envelope-from <stable+bounces-230566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:58:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C452233E074
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5107301495B
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 01:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9134C6D;
	Fri, 27 Mar 2026 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="JVoBqhgB"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870178F59;
	Fri, 27 Mar 2026 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576406; cv=none; b=axgPqbXHf7M5MkhuzsJq6NfzCHvZwGmR2WQg3q5FnOyA7HiR/H255XTCiI3jNLxFfYR9m5VC5jLvXRiV7f5/JYuhSkHWwVuTmvI2P8M1hbKQDWp4NfJK6c/4SY1I6rmtCA2trvnr6P2AfQfDpBT3qtEXx1J6b6oem2o9QPLrXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576406; c=relaxed/simple;
	bh=/eB1/rf/CU2pvZVuVrWldNffSXGURHHOo9QBNHEohe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F1PuLWZh1BKrU/N+ImEqpZ+oUwk37D97hcbqPyVb2UYyLszlW8EoNexWZz2LCa5lM/YLSkI6mVhP+yT8ZpM0d0ZXm+Yol0d8/yDXOhsl/RXFGw5ya07sQTcYIuw8/TMVextMXbpwHOF3ET+KKKHNjj/z9HQTT6FeACf8iergzPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=JVoBqhgB; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=JVoBqhgBWEtkybUwaYzrDk2dTYsUbfYBp95J5ZDNnBZly69MW0GGAF273QckNAfPOdAyijUp04tsB
	 yJHl/YdQNpTk2DNZ/T58k8PLd/IFp6/cjV3QolSJkM4fJwaAVKoyjjTs3GIbtOpjeYbKdQVJDRD+7U
	 puc7nsaHdHrrvRWw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-08-12086 (RichMail) with SMTP id 2f3669c5e305cda-01cff;
	Fri, 27 Mar 2026 09:53:14 +0800 (CST)
X-RM-TRANSID:2f3669c5e305cda-01cff
From: Rajani Kantha <681739313@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	rmk+kernel@armlinux.org.uk
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	xu.yang_2@nxp.com
Subject: [PATCH 6.1.y 3/3] net: phy: fix phy_uses_state_machine()
Date: Fri, 27 Mar 2026 09:53:16 +0800
Message-Id: <20260327015316.1713133-1-681739313@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[139.com];
	TAGGED_FROM(0.00)[bounces-230566-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,nxp.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,armlinux.org.uk:email,139.com:email,139.com:mid]
X-Rspamd-Queue-Id: C452233E074
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit e0d1c55501d377163eb57feed863777ed1c973ad ]

The blamed commit changed the conditions which phylib uses to stop
and start the state machine in the suspend and resume paths, and
while improving it, has caused two issues.

The original code used this test:

	phydev->attached_dev && phydev->adjust_link

and if true, the paths would handle the PHY state machine. This test
evaluates true for normal drivers that are using phylib directly
while the PHY is attached to the network device, but false in all
other cases, which include the following cases:

- when the PHY has never been attached to a network device.
- when the PHY has been detached from a network device (as phy_detach()
   sets phydev->attached_dev to NULL, phy_disconnect() calls
   phy_detach() and additionally sets phydev->adjust_link NULL.)
- when phylink is using the driver (as phydev->adjust_link is NULL.)

Only the third case was incorrect, and the blamed commit attempted to
fix this by changing this test to (simplified for brevity, see
phy_uses_state_machine()):

	phydev->phy_link_change == phy_link_change ?
		phydev->attached_dev && phydev->adjust_link : true

However, this also incorrectly evaluates true in the first two cases.

Fix the first case by ensuring that phy_uses_state_machine() returns
false when phydev->phy_link_change is NULL.

Fix the second case by ensuring that phydev->phy_link_change is set to
NULL when phy_detach() is called.

Reported-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20250806082931.3289134-1-xu.yang_2@nxp.com
Fixes: fc75ea20ffb4 ("net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/E1uvMEz-00000003Aoe-3qWe@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/net/phy/phy_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index fd49616c6608..9b0c88c19795 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -270,8 +270,7 @@ static bool phy_uses_state_machine(struct phy_device *phydev)
 	if (phydev->phy_link_change == phy_link_change)
 		return phydev->attached_dev && phydev->adjust_link;
 
-	/* phydev->phy_link_change is implicitly phylink_phy_change() */
-	return true;
+	return !!phydev->phy_link_change;
 }
 
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
@@ -1791,6 +1790,8 @@ void phy_detach(struct phy_device *phydev)
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
 	}
+
+	phydev->phy_link_change = NULL;
 	phydev->phylink = NULL;
 
 	if (phydev->mdio.dev.driver)
-- 
2.34.1



