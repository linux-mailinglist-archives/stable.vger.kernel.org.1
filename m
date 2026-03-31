Return-Path: <stable+bounces-232085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA8nJiYEzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:28:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F66536EC24
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82AE73070AFE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541A64218A4;
	Tue, 31 Mar 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O2eCYU4R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796C2C15B2;
	Tue, 31 Mar 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975837; cv=none; b=RZRosPfbEB7rjWMGsESEZayuHvMdSDsb3YscnnmMB3B+7xsOCGaEQi641MbK7OnU8SdohsmkNHvKGvxXtcLaf+DFJ0xp3aF6jePKY4K/T88H9+eGPiEW17h8zlnfJPipkFX5WQ8ZZJIhgBFG5po61TQlVoRujYDGop3HOoaXLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975837; c=relaxed/simple;
	bh=VMN0Lx7FcABMsEwitBEyCb1Ge5OTV/JuH3gFoRhyf6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XixHpxXisZvpoVCv4w9c2J+GRhk3MLVVFwF+B0u9b8kUoAm7n7nIeWkG8PiG9nGnfhQZ+PDwOz0+OPcqBMq6ntVDx0LdbqYpp66m/09AChhm632LCbAod1EYNVpGhWkIFN0xq818jdM4fKXCWFJB9VRtCcKGQiuQGFa6iYmRd3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O2eCYU4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16C9C19423;
	Tue, 31 Mar 2026 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975837;
	bh=VMN0Lx7FcABMsEwitBEyCb1Ge5OTV/JuH3gFoRhyf6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2eCYU4ReZQy2vlCC4dBpBbMgf1gLNe7vsynztAUEW1+CDnSSgziG/sn1/KfQkbj1
	 tKiWJiIVHqOEbH/2mYaneRlZKdFxCcFIlQuR5UT4rN9IfSB84RfHHYpfxDY2lkHy+G
	 j6TaN4dcN7EFHUofmgsgwGqq7v8IrQ9LqvEA2qkA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 073/244] net: bcm: asp2: remove tx_lpi_enabled
Date: Tue, 31 Mar 2026 18:20:23 +0200
Message-ID: <20260331161744.383117448@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-232085-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,broadcom.com:email,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 9F66536EC24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit df8017e8a19d72b48abfe02b8611a5c8c7f89e22 ]

Phylib maintains a copy of tx_lpi_enabled, which will be used to
populate the member when phy_ethtool_get_eee(). Therefore, writing to
this member before phy_ethtool_get_eee() will have no effect. Remove
it. Also remove setting our copy of info->eee.tx_lpi_enabled which
becomes write-only.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/E1tXk7w-000r4r-Pq@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: cbfa5be2bf64 ("net: bcmasp: fix double free of WoL irq")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 256577f0f2170..73334ab526136 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -364,14 +364,9 @@ void bcmasp_eee_enable_set(struct bcmasp_intf *intf, bool enable)
 
 static int bcmasp_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
-	struct bcmasp_intf *intf = netdev_priv(dev);
-	struct ethtool_keee *p = &intf->eee;
-
 	if (!dev->phydev)
 		return -ENODEV;
 
-	e->tx_lpi_enabled = p->tx_lpi_enabled;
-
 	return phy_ethtool_get_eee(dev->phydev, e);
 }
 
@@ -394,7 +389,6 @@ static int bcmasp_set_eee(struct net_device *dev, struct ethtool_keee *e)
 			return ret;
 		}
 
-		intf->eee.tx_lpi_enabled = e->tx_lpi_enabled;
 		bcmasp_eee_enable_set(intf, true);
 	}
 
-- 
2.51.0




