Return-Path: <stable+bounces-261049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z8MbL9lDJWp9FQIAu9opvQ
	(envelope-from <stable+bounces-261049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CC964F634
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=PGl0DnTW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261049-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261049-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9FB13005E94
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4B72E2DDD;
	Sun,  7 Jun 2026 10:11:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C02E739E;
	Sun,  7 Jun 2026 10:11:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827093; cv=none; b=H8fPFdhUuUr+wu7hQ+4/s6hycA5YUQ0y07jKVgEbyPdCnK2pOpEg1WCgDifn1pMTG8/HWHB2qVSHOiNWsOSN/6+Mz8+nlCDOWU+5jbKb11AdctxKjO/WFrtHjBmReI9jyDzffKRBYvdh4VILUs6CoyxXFEXkOTyr6xOlxB0l1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827093; c=relaxed/simple;
	bh=Ov1CTaHwhM/CRWD5fR7ud62UtTPAESDI3yYpicGJlMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGcEJSZOGVKRhFZwYnYHckx7dgUYluqjji8gov44Zv0q4508aridjJ7oi6Uh1w4ZVYrJvcQO+1lp9/88MnDrEXcCdjHTu5nzxPspJYD+GQ18XLSyXbt2VClS0p24fCMzNjCCNxZ8DmhU07Y7H9+KCSjCEE1ttW2JstMoRfRPBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGl0DnTW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5DA1F00893;
	Sun,  7 Jun 2026 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827092;
	bh=OWkL5N3MfN5yXsd22M5FmHvSkZ+XUF4LgjQ5qNu1Snw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PGl0DnTWwMC1T8596qeCf7ldEVq4Yb2UPtBVkOJN3tqmgvJAsI0Hh0+JqS6wDvMWq
	 09pBnKzezSoVXKc+zpSjSEJCmvfHBC30NQL01aX/hEDEfghSYiLbbHRyOxCEx2Psne
	 pvXuoluTB2OIFH2tRwCobiffyCzoTIDkEJGM5Ed8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 039/315] ethtool: rss: add missing errno on RSS context delete
Date: Sun,  7 Jun 2026 11:57:06 +0200
Message-ID: <20260607095728.984954761@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261049-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31CC964F634

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 3e6c6e9782ff8a8d8ded774b07ad4590cd61d04c ]

Remember to set ret before jumping out if someone tries
to delete a context on a device which doesn't support
contexts.

Fixes: fbe09277fa63 ("ethtool: rss: support removing contexts via Netlink")
Link: https://patch.msgid.link/20260522230647.1705600-3-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/rss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 926be5698ba4cc..688c0e4bba69db 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -1160,8 +1160,10 @@ int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	dev = req.dev;
 	ops = dev->ethtool_ops;
 
-	if (!ops->create_rxfh_context)
+	if (!ops->create_rxfh_context) {
+		ret = -EOPNOTSUPP;
 		goto exit_free_dev;
+	}
 
 	rtnl_lock();
 	netdev_lock_ops(dev);
-- 
2.53.0




