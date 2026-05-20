Return-Path: <stable+bounces-250234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEiUHF3tDWpZ4wUAu9opvQ
	(envelope-from <stable+bounces-250234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:20:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7591F5935F7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0220304E2D2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955F372EDE;
	Wed, 20 May 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wg1FAIA0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214C367B8D;
	Wed, 20 May 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294881; cv=none; b=q6hBxCQJPagxvJsLxImGVDbGZphSA/XgGsv6xOL0oJQi17wDBFEtRUNnMXZuRcIhuPz86JMOPXCIgn/Lxmv9LIoqYk0XKJMuEDCzZVyBtRQuHZyHxF/bIliNIEG74uBJICf0t3Q80egGQuo7fivpNkedyHHpAOn62Gu3aUU0MI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294881; c=relaxed/simple;
	bh=UPaaKVUDtjqMvl8IAohcu7f9AG5ULhPgR6J0bM2Jpo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcCFOSdKiKA6MFLFApnulxBhctOwdQBx+ildzwppb6tKNjniEBKvQ+kiL468c5y+IG0zR0AyiOowC+jgRCJAQMxrfQNrYxZcvOUuEZPg61r7af6fvBGfEWJ753cldLgT3xnFZDmx4P3RKr0F0A5QlSkdh+ky+ax1TF0GFlRyF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wg1FAIA0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE201F000E9;
	Wed, 20 May 2026 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294879;
	bh=LBtdGqqXwHLd7hu3nqvWTHDAeLnKLIgdlSomAodRM/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wg1FAIA0jVRLgN9KUSAgPWLDMRb1Xqx8J3vgkXBtoKmi8wj0cJwxaQBvIeKhRdx1T
	 kyoPG5NETGFOf40loqNnDDfQbK0XeOhFFN19himVZW/hM2hNUf4sOE1tspr4IFQwLS
	 bSdfc/HwGNzLMZOPW146SDAYen2eFtoO4EPTZQ/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Perry <charles.perry@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0205/1146] net: phy: fix a return path in get_phy_c45_ids()
Date: Wed, 20 May 2026 18:07:35 +0200
Message-ID: <20260520162152.908074527@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-250234-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,lunn.ch:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Queue-Id: 7591F5935F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Perry <charles.perry@microchip.com>

[ Upstream commit 6f533abe7bbad2eef1e42c639b6bb9dad2b02362 ]

The return value of phy_c45_probe_present() is stored in "ret", not
"phy_reg", fix this. "phy_reg" always has a positive value if we reach
this return path (since it would have returned earlier otherwise), which
means that the original goal of the patch of not considering -ENODEV
fatal wasn't achieved.

Fixes: 17b447539408 ("net: phy: c45 scanning: Don't consider -ENODEV fatal")
Signed-off-by: Charles Perry <charles.perry@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20260409133654.3203336-1-charles.perry@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3bd415710bf3f..f3696d9819d35 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -927,8 +927,8 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 				/* returning -ENODEV doesn't stop bus
 				 * scanning
 				 */
-				return (phy_reg == -EIO ||
-					phy_reg == -ENODEV) ? -ENODEV : -EIO;
+				return (ret == -EIO ||
+					ret == -ENODEV) ? -ENODEV : -EIO;
 
 			if (!ret)
 				continue;
-- 
2.53.0




