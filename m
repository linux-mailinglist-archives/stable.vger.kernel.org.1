Return-Path: <stable+bounces-212512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN2MObc6emlN4wEAu9opvQ
	(envelope-from <stable+bounces-212512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:35:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4064EA5D62
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A8A31EE62C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256993033C4;
	Wed, 28 Jan 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QEqYUhTl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E02F25EF;
	Wed, 28 Jan 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615765; cv=none; b=q2KVU4d9RSZL2uXPtmbq4HiGCSm9BYWirSXnp2nu4QijklsNNaVxsReSMJmR5YZBNlRlDsQp0eOF5fG9lcGryEWVNjJH9HGNLZoJY9rydG7uRN+z4FJzefMlJi1DeEv+FgiBocumA2wn6vZvPUDUE23M+F6OFN76+xh1sAoCTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615765; c=relaxed/simple;
	bh=adJxAiNQQmtDH4ADAERrcAQAuYD2hGP++GFXgPQB3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe3yzYj2ecno3sHwy0JHd6Fk1KYjP5CYAFGmYmThWibqoGyQ9MV9DSWTofV93XzfkRvDrAOwkk+wPv8OLj1gNWUJq6BcVjrxm5Pden7CV1Xp3zaRVYLkB1GGU0ZuVuYZHNj6gg8zDYxhnaTUoHM4TpLpajX8Z4a1m8/vyOMVioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QEqYUhTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4CEC4CEF1;
	Wed, 28 Jan 2026 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615765;
	bh=adJxAiNQQmtDH4ADAERrcAQAuYD2hGP++GFXgPQB3Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEqYUhTl8W+CrOt+BD9npDk0WvaJ6woxHphliPmcXuCvri2mIjQAZxA+67E7Bau3B
	 4zJHNHqx5rri0pUr02RMUBTV2Jmwe9LASfKNvJwfICC6mDXWEpGFzgxlahFtfkgS5C
	 He9qs2ImFtYcyWJ3TeJKKqC7oEDGd3/rzdWu45DY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 108/227] net: phy: intel-xway: fix OF node refcount leakage
Date: Wed, 28 Jan 2026 16:22:33 +0100
Message-ID: <20260128145348.356401162@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212512-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 4064EA5D62
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 79912b256e14054e6ba177d7e7e631485ce23dbe ]

Automated review spotted am OF node reference count leakage when
checking if the 'leds' child node exists.

Call of_put_node() to correctly maintain the refcount.

Link: https://netdev-ai.bots.linux.dev/ai-review.html?id=20f173ba-0c64-422b-a663-fea4b4ad01d0
Fixes: 1758af47b98c1 ("net: phy: intel-xway: add support for PHY LEDs")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://patch.msgid.link/e3275e1c1cdca7e6426bb9c11f33bd84b8d900c8.1768783208.git.daniel@makrotopia.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/intel-xway.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index 9766dd99afaa0..12ff4c1f285d2 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -277,7 +277,7 @@ static int xway_gphy_init_leds(struct phy_device *phydev)
 
 static int xway_gphy_config_init(struct phy_device *phydev)
 {
-	struct device_node *np = phydev->mdio.dev.of_node;
+	struct device_node *np;
 	int err;
 
 	/* Mask all interrupts */
@@ -286,7 +286,10 @@ static int xway_gphy_config_init(struct phy_device *phydev)
 		return err;
 
 	/* Use default LED configuration if 'leds' node isn't defined */
-	if (!of_get_child_by_name(np, "leds"))
+	np = of_get_child_by_name(phydev->mdio.dev.of_node, "leds");
+	if (np)
+		of_node_put(np);
+	else
 		xway_gphy_init_leds(phydev);
 
 	/* Clear all pending interrupts */
-- 
2.51.0




