Return-Path: <stable+bounces-261130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UJfbH+VEJWoBFgIAu9opvQ
	(envelope-from <stable+bounces-261130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:16:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB0864F73F
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:16:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=zp9bk0UW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261130-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261130-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 546FF300360B
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE06175A75;
	Sun,  7 Jun 2026 10:16:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E32DB7A3;
	Sun,  7 Jun 2026 10:16:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827362; cv=none; b=eCktxT699y+DLmFQB4ux0UjGFuGVKLKdJdtzqqkMgkXyN+lMYW5u/DC0uxCAtv4951yBrX+ur/HDbyvW+TyBL4IVDwqYiTMkcZMtkcvmsI8NYog4c4q1Xqog0MoA3MAIy5DR5gNXul96LoNRAHWCJuGZ9tlp4NH4EQVL2THUElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827362; c=relaxed/simple;
	bh=mofzdPcuOSy5bc7EYV5tIs9g6CpK+xyEwVPZnnbKFrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTMSB6J0l5CcqmzayWlSm+zpQnSkqIJdlik3UbC2kMsBQ6u367fjl1+zS1l4IEQk4e7h7K34mkY6jUffbVnn4ovntVUQR3Si3vWOC9YSutjxzt18c3+6zQ5UEJhJdwLfYNEMwhjDDp9iRl0gJy3FUYSstUeY8GAoL2Ahk8COWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zp9bk0UW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23BF1F00893;
	Sun,  7 Jun 2026 10:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827361;
	bh=17lJEl5vNYP9TDsomidzSgCJLpU60Q/SERjlBPhxmKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zp9bk0UWPvcPDtpHGUd1peNTgXuRVjn5gu4ZWzm/AF9IiUTMGClfcCM2M8+CwyyyQ
	 XXbVjJjwZdYfi2VGXaRdc2yd4taKUPDSF/klAFAafMfS5dPR/3K3JodrLtbHlji0gC
	 cNFtHqNVOg4kDt7QoL4cmc0e0+nyqLeIHLjop9fo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 067/315] ethtool: pse-pd: fix missing ethnl_ops_complete()
Date: Sun,  7 Jun 2026 11:57:34 +0200
Message-ID: <20260607095730.074982055@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261130-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,bootlin.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CB0864F73F

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit ab5bf428fb6bd361163c7247b92750d1d24ca2ed ]

pse_prepare_data() is missing ethnl_ops_complete() if
ethnl_req_get_phydev() returned an error. Move getting
phydev up so that we don't have to worry about this
(similar order to linkstate_prepare_data()).

Note that phydev may still be NULL (this is checked in
pse_get_pse_attributes()), the goal isn't really to avoid
the _begin() / _complete() calls, only to simplify the error
handling.

While at it propagate the original error. Why this code
overrides the error with -ENODEV but !phydev generates
-EOPNOTSUPP is unclear to me...

Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260526153533.2779187-5-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/pse-pd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 24def9c9dd54bf..aa4514333d13bd 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -61,14 +61,14 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	ret = ethnl_ops_begin(dev);
-	if (ret < 0)
-		return ret;
-
 	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev))
-		return -ENODEV;
+		return PTR_ERR(phydev);
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
 
 	ret = pse_get_pse_attributes(phydev, info->extack, data);
 
-- 
2.53.0




