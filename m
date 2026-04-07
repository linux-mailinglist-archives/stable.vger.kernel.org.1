Return-Path: <stable+bounces-233514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFzSBFG81GlRwwcAu9opvQ
	(envelope-from <stable+bounces-233514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:12:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDDE3AB220
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE7863023524
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338C381B1B;
	Tue,  7 Apr 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk796t56"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B34381C4
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549480; cv=none; b=gAtwt7QLFhv20fzR4P57YV1rxephvxLLabJa4sCgRr1iWoi4yl0EXBq7EXeKrLqTdFAKispGF8Octcr5QOC2i4RNy5N1gp97kY3XIg3hlUrlB0d8zbyQKqp6QQy+r8atbdbmgfL12fqlDL6Dk9a941Ok5FDHnLP/MHlkxAA0ItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549480; c=relaxed/simple;
	bh=ahCOoL0cvVnRH2E2Rw4pgbfaaqltYX+hlf9WdMU1vMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqPdD26dwKSRQiG/eG1MGjhGwA+r5RQESbilqoftKV2hiwRD41qOWhwGhm1jTK78c2qRp30VsJVWn8Qsovcff+C713/avO76QXCeEMn0q5cBvihpwwbQAGQjb3rgTjyGaKDXNRRy59uvrbNvy7YrOdrSFQ+2QNH2SvZX6A/KFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk796t56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60319C116C6;
	Tue,  7 Apr 2026 08:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775549479;
	bh=ahCOoL0cvVnRH2E2Rw4pgbfaaqltYX+hlf9WdMU1vMQ=;
	h=From:To:Cc:Subject:Date:From;
	b=uk796t564Wn9OpD41xc1TUePJCLgoQvGbCzp28WLGAzdHCMfipR02MToI7JQ3BD7t
	 XRbhsmg1MqALYZW9DHWBtc6E4BlxewK4Z0fcPNB2t86qgnauZDFmtPsgssVGuBa8vQ
	 caDcMxlJY3ydx9+nORLuup0vnrj22I5WINieoH4zF35nRFjc4laDTDjp1RBbT9h+Bh
	 IUzVs3IDAm7W6T4AiFpakXFKO73jUV9HXzXmtJXXua7RAxOlweyee4Ei0VUPmws8ZZ
	 xIvRGtCofj+3no+6psu4kkRGXus78C6PoanmUNcOFDmsEpKA2jDEt/GJLgS0lb+INs
	 Pf5hzJ9uAmiyw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] net: sfp: Fix Ubiquiti U-Fiber Instant SFP module on mvneta
Date: Tue,  7 Apr 2026 10:11:15 +0200
Message-ID: <20260407081115.2830361-1-kabel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-233514-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 5CDDE3AB220
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit eeee5a710f26ce57807024ef330fe5a850eaecd8 ]

In commit 8110633db49d7de2 ("net: sfp-bus: allow SFP quirks to override
Autoneg and pause bits") we moved the setting of Autoneg and pause bits
before the call to SFP quirk when parsing SFP module support.

Since the quirk for Ubiquiti U-Fiber Instant SFP module zeroes the
support bits and sets 1000baseX_Full only, the above mentioned commit
changed the overall computed support from
  1000baseX_Full, Autoneg, Pause, Asym_Pause
to just
  1000baseX_Full.

This broke the SFP module for mvneta, which requires Autoneg for
1000baseX since commit c762b7fac1b249a9 ("net: mvneta: deny disabling
autoneg for 802.3z modes").

Fix this by setting back the Autoneg, Pause and Asym_Pause bits in the
quirk.

Fixes: 8110633db49d7de2 ("net: sfp-bus: allow SFP quirks to override Autoneg and pause bits")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20260326122038.2489589-1-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/phy/sfp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 00bbe20b0b43..165c624c985f 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -465,10 +465,15 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 {
 	/* Ubiquiti U-Fiber Instant module claims that support all transceiver
 	 * types including 10G Ethernet which is not truth. So clear all claimed
-	 * modes and set only one mode which module supports: 1000baseX_Full.
+	 * modes and set only one mode which module supports: 1000baseX_Full,
+	 * along with the Autoneg and pause bits.
 	 */
 	linkmode_zero(modes);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, modes);
+
 	phy_interface_zero(interfaces);
 	__set_bit(PHY_INTERFACE_MODE_1000BASEX, interfaces);
 }
-- 
2.52.0


