Return-Path: <stable+bounces-220535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA2eF8Q5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C770E1C6618
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9633335F564
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7043D05E1;
	Sat, 28 Feb 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfxjbzNQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA83CF365;
	Sat, 28 Feb 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300418; cv=none; b=Ez0blI+IIMAX2FalRQgbVMNHAH4RUx8vSZCzXbKlj8z7wvaypFq8q8J6VJT4CPJVJaINOsMLDTUxCFo006Y+AtgV4XTyQCtw+jzg4OpvwjL8j4oL4eRmo7vOtx3BEYeC2ri2lnkpHaJEU7DLLMX2rPFVqw+wjTf48EkXeR8K1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300418; c=relaxed/simple;
	bh=zaLi0pMp0bWbvEXHJsbhu3SFVHOuKzj/+3rDcft9+5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYgK3hfX+bSg52KBxmaO2uAm793xLd3RPFXs2rBdNJS7ZYSlF7RNdefeusl/I76VOdef32C7gbNdSgR/NsSZq6vmje0ZSNn2qogbMpK16fA6qYpqylFk/oRuxx9Dh68IZsI/pb0ipgHUL4bamuVwk26ZTn3KHjmyUhHkdfRzYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfxjbzNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B779CC116D0;
	Sat, 28 Feb 2026 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300418;
	bh=zaLi0pMp0bWbvEXHJsbhu3SFVHOuKzj/+3rDcft9+5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfxjbzNQsMErFZ4wFVW7OAwGjjqa6gx0Yhw+rU6VHZ3OwsiR4aGSDQtOkn9aoS8HE
	 8ttYIaxDCSP4IUBJfiY+PuiDxY1Wjm3oO9PdSj5hhWVNu/kfZUCP8jrBffZB1kj/e1
	 uE2N1Zg2waeBsLM/eVd3cBiEpnHm1WyaORR2Mfpo7YkBwxgYxizLq9VVgFQ6dSOO8F
	 d4SE+Tj73y9QG9i43qAuJqEh4WzVfvTlpyJigj3naDyvVzXqUfKFbnoxhMOoG/KH/L
	 wT4c+aTBhd7jp6a5LGo+QoKXhdXPR/2L4Sb8uktuE3IcAdBctEvfjrB+0CLBvtutJ0
	 +Dwdd1igYg1Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Martin=20P=C3=A5lsson?= <martin@poleshift.se>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 456/844] net: usb: lan78xx: scan all MDIO addresses on LAN7801
Date: Sat, 28 Feb 2026 12:26:09 -0500
Message-ID: <20260228173244.1509663-457-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220535-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: C770E1C6618
X-Rspamd-Action: no action

From: Martin Pålsson <martin@poleshift.se>

[ Upstream commit f1e2f0ce704e4a14e3f367d3b97d3dd2d8e183b7 ]

The LAN7801 is designed exclusively for external PHYs (unlike the
LAN7800/LAN7850 which have internal PHYs), but lan78xx_mdio_init()
restricts PHY scanning to MDIO addresses 0-7 by setting phy_mask to
~(0xFF). This prevents discovery of external PHYs wired to addresses
outside that range.

One such case is the DP83TC814 100BASE-T1 PHY, which is typically
configured at MDIO address 10 via PHYAD bootstrap pins and goes
undetected with the current mask.

Remove the restrictive phy_mask assignment for the LAN7801 so that the
default mask of 0 applies, allowing all 32 MDIO addresses to be
scanned during bus registration.

Fixes: 02dc1f3d613d ("lan78xx: add LAN7801 MAC only support")
Signed-off-by: Martin Pålsson <martin@poleshift.se>
Link: https://patch.msgid.link/0110019c6f388aff-98d99cf0-4425-4fff-b16b-dea5ad8fafe0-000000@eu-north-1.amazonses.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 00397a8073934..065588c9cfa65 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2094,8 +2094,6 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
 		dev->mdiobus->phy_mask = ~(1 << 1);
 		break;
 	case ID_REV_CHIP_ID_7801_:
-		/* scan thru PHYAD[2..0] */
-		dev->mdiobus->phy_mask = ~(0xFF);
 		break;
 	}
 
-- 
2.51.0


