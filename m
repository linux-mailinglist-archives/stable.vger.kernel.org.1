Return-Path: <stable+bounces-215670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMbHKLw+i2mfRwAAu9opvQ
	(envelope-from <stable+bounces-215670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:20:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B216011BD26
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF45C300602C
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0E328B61;
	Tue, 10 Feb 2026 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT4yu+tm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB431B394F
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733239; cv=none; b=M0goEA6N83n2DuQhH8c7kswC7af9NegdLeRJYJDWEKyj4J2SZLZfl3RqnrI5LAe+l4ngXWcGlTOAyGO4kQsY1uqXtxlQ7Ku4g0VBm63hQkv2AysvC4LXDqbcqdrES4cVvElcmPHw3DQH3EhQZRdHlwbn+PikL0dWEmduVbixxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733239; c=relaxed/simple;
	bh=SUGiEfZ3fHXPWVOgTjgLB566Tb3Wxd2PtqPRcr8k9MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OkXse3YWxMnP6tY5mz4L8QY7hGtYw1nm6ChS3jGIiNs5yZHVSwo5s01McP/KHehmJGcZmVOTWcBQ1sDHBWqvDMXOEFNxW3b0cPRMBgH/wIttyo4VSLRlEF87ypEiKllcFlqihK+mvkHIIC4DLUGxGMmufVF8ZGvsilbqC7TSdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT4yu+tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D2CC116C6;
	Tue, 10 Feb 2026 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770733239;
	bh=SUGiEfZ3fHXPWVOgTjgLB566Tb3Wxd2PtqPRcr8k9MM=;
	h=From:To:Cc:Subject:Date:From;
	b=gT4yu+tmD5rydLu1gDKq8elNIncFWSOILJvaw9TJAPf7CxADe4X7q1CiCgZG8jHRu
	 z7b+QRshFSjME23IGvBfd8aRYJMrEUmOVzI1qxe12iGvZWMn91tbrkL9EabeUbNzDn
	 9vg0L2uaR51SzrBL+OVV7jkoaqdswBu/eAi9+vFqH20ELXW7wR8t51MS2YgEmz0Glk
	 dJJ9pUfDTxRVizoFRHuVj7DevFml2O6jJ/RMgsCQqDwgZVatbz2BXNQEdO/OxHROv2
	 yEGklJmO181nHjzUigumv1TjNNLWFWg2R278fH8JYc6E9sfvhWyoCVO0zu3/MqS6SM
	 P0sIeEB1k1/qw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP module
Date: Tue, 10 Feb 2026 15:20:34 +0100
Message-ID: <20260210142034.13606-1-kabel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-215670-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,bootlin.com:email]
X-Rspamd-Queue-Id: B216011BD26
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
index 0666a39dc485..5cc3d53bbf66 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -376,6 +376,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 	 */
 	linkmode_zero(modes);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, modes);
+	phy_interface_zero(interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, interfaces);
 }
 
 #define SFP_QUIRK(_v, _p, _m, _f) \
-- 
2.52.0


