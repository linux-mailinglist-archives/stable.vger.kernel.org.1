Return-Path: <stable+bounces-261235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id doTwCgdIJWrAFwIAu9opvQ
	(envelope-from <stable+bounces-261235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 876DB64FB2D
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=x0tf43ht;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261235-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261235-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58FC4303AAAE
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6724531F993;
	Sun,  7 Jun 2026 10:22:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE7E31F983;
	Sun,  7 Jun 2026 10:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827770; cv=none; b=SQZtzo3uemxZ779d4BxHOBoJdWDQoBhZei2Ze11O9W3jszJnzIBEpIqUpDTQYq4GxkwCVTkfiplypOuFUwkhya8OLNBuwKuuSylGd7Knr5gSSU/postGQRGXUg23EpGYkl6xaqucgXRsrGaDH6ti7UTn1Q4jd37wjfmBDWT/bHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827770; c=relaxed/simple;
	bh=Nl+uz67fJVInqqpv9Q2+1NWiWVsxMTr1CnNYwP/Lh3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPHA0WjgpKdMT6AIl3vDLEaqbX3pTS1y9UBVjltcrJ1wQZEM37KaZz2jifrXAZV35cYeVYV5/t1bT8lubUCYmZPeikK0m59etURbgQdKZarKaaTiKHwRz6RIInELeT2GAUJPZq5aYQ6RK3fdu0LR+/0pwjM900GhnL7z1qbBO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0tf43ht; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE8E1F00893;
	Sun,  7 Jun 2026 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827769;
	bh=LuJtZrrL6YTGsmaY7u8tJsuJDZOgcOVUuV3Mhfifx+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x0tf43htFbAHwZDXZqlvfxbS8peLv2q5712pfw6s98LK0jXkbLL1H+Z8p3bpg2Lvv
	 ejLJTxGEK1Lp+PubCGskr1JdXTAB7a9kFWATxrAPsWcbCbbJHJ6mWoZvnmdxkBUYQc
	 Hs5iQtztc1zOJs7iECeYeeb1JadhxSd+6Ocr2qIs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 067/307] ethtool: linkstate: fix unbalanced ethnl_ops_complete() on PHY lookup error
Date: Sun,  7 Jun 2026 11:57:44 +0200
Message-ID: <20260607095730.217923685@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261235-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 876DB64FB2D

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 596c51ed9e125b12c4d85b4530dfd4c7847634b7 ]

linkstate_prepare_data() calls ethnl_req_get_phydev() before
ethnl_ops_begin(), but routes its error path through "goto out"
which calls ethnl_ops_complete().

Fixes: fe55b1d401c6 ("ethtool: linkstate: migrate linkstate functions to support multi-PHY setups")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260526153533.2779187-4-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/linkstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 05a5f72c99fab1..3dc52a39d34525 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -105,10 +105,8 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 
 	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_LINKSTATE_HEADER,
 				      info->extack);
-	if (IS_ERR(phydev)) {
-		ret = PTR_ERR(phydev);
-		goto out;
-	}
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
-- 
2.53.0




