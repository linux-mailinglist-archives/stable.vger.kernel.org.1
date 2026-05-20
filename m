Return-Path: <stable+bounces-251421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPsOBdD8DWok5QUAu9opvQ
	(envelope-from <stable+bounces-251421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F34359624A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B68032025F1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1573FA5D5;
	Wed, 20 May 2026 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TKZzcgcK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470C3FB05D;
	Wed, 20 May 2026 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297937; cv=none; b=q2Sz+BSJKZq+yzM+waEfMg4tlHgKwdEFjX6WJDcPzGBPEfaYx2N/k6c1xk3Oy7Oa7EWoS8WtRE014x/9kT+iSzEVgRPiprXZCKeT1gmeaxC3Nv9diUGhXi7oCO4Cfi5eoT0v3nGJN3KctgGh05RIH03cWD6v6okcqvcPEy/AzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297937; c=relaxed/simple;
	bh=UUJmlwRZ+L9bHlNHMy/1RC+oS+S2ZXl5IHpATPkKC1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtylqXngpjMX2OHfEq8yVDJKg/JMEZ1FQpA/YQbx/85HhaHjcsYMu/+P1tn8MvwJrIljQhp+MTT2JiGWfzrEQ1ga9+q41YabrPUenlVll7fRlThCN8R2fg+peIIH+XgEdr0aMuENHVUK7tprXE3BwD9J7azSXLMRfFWyGkYStJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TKZzcgcK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0C71F000E9;
	Wed, 20 May 2026 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297935;
	bh=HMqr7uhtItlOb60p0XUn6zm/mH6owk/W+NEKFjN+k00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TKZzcgcKR8vWaUbzbBygtHmYsAaRdOnRCZ9wPUsNd0JktjNeHMN+MLejUvckbb7Vr
	 uetUweH+ljSZ2yOK/MIOKV9hpWSbBWg/KFSUoCj7HxrqaVrD6QECdo1SopvAd4ZaY0
	 UtTl8mWBy5cIDMQzf2Tywe0dJCm8RG1PaTk3FnqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 179/957] net: phy: qcom: at803x: Use the correct bit to disable extended next page
Date: Wed, 20 May 2026 18:11:02 +0200
Message-ID: <20260520162138.435133685@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251421-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,bootlin.com:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: 3F34359624A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit e7a62edd34b1b4bc5f979988efc2f81c075733fd ]

As noted in the blamed commit, the AR8035 and other PHYs from this
family advertise the Extended Next Page support by default, which may be
understood by some partners as this PHY being multi-gig capable.

The fix is to disable XNP advertising, which is done by setting bit 12
of the Auto-Negotiation Advertisement Register (MII_ADVERTISE).

The blamed commit incorrectly uses MDIO_AN_CTRL1_XNP, which is bit 13 as per
802.3 : 45.2.7.1 AN control register (Register 7.0)

BIT 12 in MII_ADVERTISE is wrapped by ADVERTISE_RESV, used by some
drivers such as the aquantia one. 802.3 Clause 28 defines bit 12 as
Extended Next Page ability, at least in recent versions of the standard.

Let's add a define for it and use it in the at803x driver.

Fixes: 3c51fa5d2afe ("net: phy: ar803x: disable extended next page bit")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20260410171021.1277138-1-maxime.chevallier@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/qcom/at803x.c | 2 +-
 include/uapi/linux/mii.h      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 338acd11a9b65..023c1fe0cd14b 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -524,7 +524,7 @@ static int at803x_config_init(struct phy_device *phydev)
 	 * behaviour but we still need to accommodate it. XNP is only needed
 	 * for 10Gbps support, so disable XNP.
 	 */
-	return phy_modify(phydev, MII_ADVERTISE, MDIO_AN_CTRL1_XNP, 0);
+	return phy_modify(phydev, MII_ADVERTISE, ADVERTISE_XNP, 0);
 }
 
 static void at803x_link_change_notify(struct phy_device *phydev)
diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 39f7c44baf535..61d6edad4b94a 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -82,7 +82,8 @@
 #define ADVERTISE_100BASE4	0x0200	/* Try for 100mbps 4k packets  */
 #define ADVERTISE_PAUSE_CAP	0x0400	/* Try for pause               */
 #define ADVERTISE_PAUSE_ASYM	0x0800	/* Try for asymetric pause     */
-#define ADVERTISE_RESV		0x1000	/* Unused...                   */
+#define ADVERTISE_XNP		0x1000  /* Extended Next Page */
+#define ADVERTISE_RESV		ADVERTISE_XNP /* Used to be reserved */
 #define ADVERTISE_RFAULT	0x2000	/* Say we can detect faults    */
 #define ADVERTISE_LPACK		0x4000	/* Ack link partners response  */
 #define ADVERTISE_NPAGE		0x8000	/* Next page bit               */
-- 
2.53.0




