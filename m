Return-Path: <stable+bounces-261857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aNPFNcdPJWpFGwIAu9opvQ
	(envelope-from <stable+bounces-261857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:02:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 482216503FF
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:02:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=L5uiyxTI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261857-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261857-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43352301BEDB
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7158131ED80;
	Sun,  7 Jun 2026 11:02:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CC224D6;
	Sun,  7 Jun 2026 11:01:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830120; cv=none; b=uF6kD/m4K2J87BN0YQEaH8waY3wu4V3gDnhVVEAwMmwNOgI0Dwpo9sIYOkTgIn7irk/AJEl3Rf3R/xT444jfSy1w/rxkR53d+LzWQoxz0CZJjV5eB05TyGijeZDKU+t0IGFRoosiqI7z9Yni4LoMVg0k9i4hyCFKnD/DBy9EF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830120; c=relaxed/simple;
	bh=Jlv0QWXDQ/08qgsYEYc1lyYazB40MHM/jJsfBuBYcew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq7oY5WsJ2Pg89e3q5EV2JrQju5kuCw62vMVnDWAqexGorft7BPih4IYSBmTtz0Q6zP4e98cZJU3/Rn3BJVz5ObBd871HASjEpkqzNQTE0JbHdhCqvjhWzoiU1F3u3PY95bvky16dPPFt4Bxvpa7cNLoMRNpBRyl1AbSNOJVX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L5uiyxTI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EED21F00893;
	Sun,  7 Jun 2026 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780830119;
	bh=PrET5f2WenRvJV667oiH1mczoWBsPO1x8CSllXbQCD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5uiyxTIx8LnS31FrCGvRtJQz/Eo31w85PCQ59xcikG4KYqT768CKfuUsm8YKqsss
	 yyrz1ZIEScCVYHsEPs5osrdyeWENjcL/TFBHaixgQLThaHPq/05gF1k+fhZcLzLSWC
	 GEsBwlFAySi5nmZmZvhoYyA6Jw77MxzgZkvAgzZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Marko <robert.marko@sartura.hr>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 311/315] net: phy: micrel: fix LAN8814 QSGMII soft reset
Date: Sun,  7 Jun 2026 12:01:38 +0200
Message-ID: <20260607095739.044948139@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261857-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:robert.marko@sartura.hr,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 482216503FF

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Marko <robert.marko@sartura.hr>

[ Upstream commit e027c218c482c6a0ae1948129ccda3b0a2033368 ]

LAN8814 QSGMII soft reset was moved into the probe function to avoid
triggering it for each of 4 PHY-s in the package.

However, that broke QSGMII link between the MAC and PHY on most LAN8814
PHY-s, specificaly for us on the Microchip LAN969x switch.
Reading the QSGMII status registers it was visible that lanes were only
partially synced.

It looks like the reset timing is crucial, so lets move the reset back
into the .config_init function but guard it with phy_package_init_once()
to avoid it being triggered on each of 4 PHY-s in the package.
Change the probe function to use phy_package_probe_once() for coma and PtP
setup.

Fixes: 96a9178a29a6 ("net: phy: micrel: lan8814 fix reset of the QSGMII interface")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Link: https://patch.msgid.link/20260428134138.1741253-1-robert.marko@sartura.hr
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/micrel.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index bc19880107ae42..e6f00aa9a99010 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4389,6 +4389,13 @@ static int lan8814_config_init(struct phy_device *phydev)
 {
 	struct kszphy_priv *lan8814 = phydev->priv;
 
+	if (phy_package_init_once(phydev))
+		/* Reset the PHY */
+		lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				       LAN8814_QSGMII_SOFT_RESET,
+				       LAN8814_QSGMII_SOFT_RESET_BIT,
+				       LAN8814_QSGMII_SOFT_RESET_BIT);
+
 	/* Disable ANEG with QSGMII PCS Host side */
 	lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
 			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
@@ -4473,13 +4480,7 @@ static int lan8814_probe(struct phy_device *phydev)
 	devm_phy_package_join(&phydev->mdio.dev, phydev,
 			      addr, sizeof(struct lan8814_shared_priv));
 
-	if (phy_package_init_once(phydev)) {
-		/* Reset the PHY */
-		lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
-				       LAN8814_QSGMII_SOFT_RESET,
-				       LAN8814_QSGMII_SOFT_RESET_BIT,
-				       LAN8814_QSGMII_SOFT_RESET_BIT);
-
+	if (phy_package_probe_once(phydev)) {
 		err = lan8814_release_coma_mode(phydev);
 		if (err)
 			return err;
-- 
2.53.0




