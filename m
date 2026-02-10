Return-Path: <stable+bounces-215667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC0YEEY+i2mfRwAAu9opvQ
	(envelope-from <stable+bounces-215667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:18:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A546711BCAB
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB68B302DF51
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9404371066;
	Tue, 10 Feb 2026 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5MzrZGD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F536A038
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733105; cv=none; b=HEs/AKdWxytRuONfaTaqnB7YgPKHc01+x7ew6bBzlJ7OIbHZX4d5YvbG1i6OHn+clcS5zD5JvjmbYBxihB3QgJg1H2OVc5hv7W7pg3vms94PT9pcTtniBOu5xMwpgvZnzbNT28hpA0HvHHdcEhfU5jeej6lz7kh1GN0OnKlwf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733105; c=relaxed/simple;
	bh=HEOQEWVYnT6ejgfAe9G48kh2adGxslVvXKlbi+Q3qQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PWbeejVWBSbSpXzfLmzrLGUCRePBoPVp1KKauGO3Pj1mv6+3TVdEHAaiDN6TzjU03rqAMwT7Tc8H8UdRXOdRAwnxn+7Srv2gI4cs/RdQmpMgGxSIjyHayxyeNPvJnR2GxlJScme6oJGqcV+Cvi/EN++zbyTX77gPihovzIfi1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5MzrZGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58ABC16AAE;
	Tue, 10 Feb 2026 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770733104;
	bh=HEOQEWVYnT6ejgfAe9G48kh2adGxslVvXKlbi+Q3qQY=;
	h=From:To:Cc:Subject:Date:From;
	b=s5MzrZGDqo9zAPwyKInqcM3UCZwdQSdRcTV4cBcYAc8+pBeyexMIwHBbnHZ+hWzQ/
	 poB3dBpYFytj8pEcjKPy6wzZ51Og4Trtm7EpGMC+UoTdEgZABybyTJYL2OBCPZ6Wxt
	 nzmcPGl95ab0MV+8X2CVlBnmjU+l5Q6UyK/0wgfzgRseAMc3/O2GlWpWa3+KyWhzX7
	 7Dxo9HVRfTE+nwCLjawYAaFKqxWwdxJCe/jbxmQSotVMnHu0x4XXHJc82gE2oi9Ucc
	 nHdksKD5sogjBHzRLRUTkXSSxW4Ui0zF5ZtwgwhwsOAdkUQxlLQwKEvvHJvP4uVqbi
	 15jfbcomuLOaw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP module
Date: Tue, 10 Feb 2026 15:18:19 +0100
Message-ID: <20260210141819.8558-1-kabel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-215667-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,bootlin.com:email]
X-Rspamd-Queue-Id: A546711BCAB
X-Rspamd-Action: no action

[ Upstream commit adcbadfd8e05d3558c9cfaa783f17c645181165f ]

Commit fd580c9830316eda ("net: sfp: augment SFP parsing with
phy_interface_t bitmap") did not add augumentation for the interface
bitmap in the quirk for Ubiquiti U-Fiber Instant.

The subsequent commit f81fa96d8a6c7a77 ("net: phylink: use
phy_interface_t bitmaps for optical modules") then changed phylink code
for selection of SFP interface: instead of using link mode bitmap, the
interface bitmap is used, and the fastest interface mode supported by
both SFP module and MAC is chosen.

Since the interface bitmap contains also modes faster than 1000base-x,
this caused a regression wherein this module stopped working
out-of-the-box.

Fix this.

Fixes: fd580c9830316eda ("net: sfp: augment SFP parsing with phy_interface_t bitmap")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20260129082227.17443-1-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index dc62f141f403..ff438be4c186 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -431,6 +431,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 	 */
 	linkmode_zero(modes);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, modes);
+	phy_interface_zero(interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, interfaces);
 }
 
 #define SFP_QUIRK(_v, _p, _m, _f) \
-- 
2.52.0


