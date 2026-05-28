Return-Path: <stable+bounces-255906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ICsG2enGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F75F91CB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BA3C3104DEB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFF03346BE;
	Thu, 28 May 2026 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g4rE0L+I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C02833F390;
	Thu, 28 May 2026 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000211; cv=none; b=SK9d3k69zIiUgTdihiB9es+dMuqyAFbBL8cPnkPFW66d62h7BMevbwljTJgvkpQ2RifCY49fsVFgg+q6megDblJ6zV500trroBpjJcjuh1qdG6BqHgLmYN8IgSxvpyrdy7S6q/f3S0Uv7q1evgQxpm7gdncTEZ/ZcLlGBUnWyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000211; c=relaxed/simple;
	bh=mAhRxLHXTfuoQbO5WRJIjUeRb8SVr7zygBCuscugs0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPX5mbXPgzjniw6XeAjFOGykLWOr76xC06zXnn4cLyvFqL1lU8aNY4GldIYiJDOk4c0F09U9LsaopTwCUqF/3bdPlgEPf09yOHQaa6ALTJdDG/sYzJuVHn53bg5+lEmQuO5cXcDbnm0e7F9WMs8uMtQ5S1zNsWDsRktqrMGov2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g4rE0L+I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544791F00A3A;
	Thu, 28 May 2026 20:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000209;
	bh=HRp+OZzTzyVbi51o+qIimiQSR8m8su3XBA1tFn1Sptk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g4rE0L+I/KrjFNoSiiw+PDYui9KcGlMi1DGGxKKhwqx49r97n3YE5u9XOntAg2fxm
	 tYwGVcpDgS7r6zY++1vKms8XH6J1SUBFLdp3bqzyeOFeEEtCQU8WT+TgDQOn11/YBv
	 f6cCP490Ji5rV9ot3efLjMeHP8bF3aqetZJjDP7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 340/377] net: phy: honor eee_disabled_modes in phy_support_eee()
Date: Thu, 28 May 2026 21:49:38 +0200
Message-ID: <20260528194648.267915588@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255906-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,tipi-net.de:email]
X-Rspamd-Queue-Id: 238F75F91CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolai Buchwitz <nb@tipi-net.de>

[ Upstream commit 3655063e083889ed4b79b7dda9cec65478dce09a ]

phy_support_eee() copies supported_eee into advertising_eee
unconditionally, overwriting any filtering applied during phy_probe()
based on DT eee-broken-* properties or driver-populated
eee_disabled_modes. MAC drivers that call phy_support_eee() after
probe (e.g. bcmgenet, fec, lan743x, lan78xx, r8169) then cause the PHY
to advertise EEE for modes the user marked as broken.

The symptom is that ethtool --show-eee on the local interface reports
"not supported" (supported & ~eee_disabled_modes is empty) while the
link partner sees EEE negotiated and active.

phy_probe() already filters advertising_eee via eee_disabled_modes
after calling of_set_phy_eee_broken(). Apply the same mask in
phy_support_eee() so the filtering survives the copy.

Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20260518-devel-phy-support-eee-fix-v2-1-05b52626fa68@tipi-net.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index dea8b94286d15..5d76bd1ffe279 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2818,7 +2818,8 @@ EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
  */
 void phy_support_eee(struct phy_device *phydev)
 {
-	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
+	linkmode_andnot(phydev->advertising_eee, phydev->supported_eee,
+			phydev->eee_disabled_modes);
 	phydev->eee_cfg.tx_lpi_enabled = true;
 	phydev->eee_cfg.eee_enabled = true;
 }
-- 
2.53.0




