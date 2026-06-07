Return-Path: <stable+bounces-260996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7+ecMTtDJWo3FQIAu9opvQ
	(envelope-from <stable+bounces-260996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:08:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 798F864F59D
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:08:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tClJrsYO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260996-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260996-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CC2D3012BDB
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEFF2E3709;
	Sun,  7 Jun 2026 10:08:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D21DE8AE;
	Sun,  7 Jun 2026 10:08:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826908; cv=none; b=E4mrZgtRJJPrtFjybSWM8TTs5jpzDKSZBvXsowpVFPsJYsT3s/oj3GwHONMcUDG+4VsoJGtUXY1m/QUc4ifkMCEfqdfd6kN7QQ7MWzyEJB4OYwWqg0tQEdgfBhsHJelrNntNjr8nqRUBOVe/jGyextmRKUGTAR+qe/OWOVCsLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826908; c=relaxed/simple;
	bh=g26Ri4mUkbTTDViQ4AHLKqtnr6EbX4r1AONdkXCgPho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UF+YEd+HqnC8lieViYVeKLS9oJECr4oU7HkKYfhnYzXy7epb9NuFoLojS/eRLqF5LpKkW08+U9HxuYAp/d0kxw3uNFbG2PLtO7FGh2lCxwkrzdLFP8g4HEJ2MBxIrBqxPh5LWB+b7w9dk3eaw3+UJs8PoUvakBM/SoR+8freG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tClJrsYO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23521F00893;
	Sun,  7 Jun 2026 10:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826907;
	bh=KpL63wh3M1nQBrvHU8SyOAJ5GJZDkqEDcWLBcISo0xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tClJrsYOPG4h/gAtbuIb8no+KsjRhkTBIXnCCayQzBX3ewMdlmN0k6gdr0/jgNq6l
	 EnbWXqd8uDxRemj1Wu8sgCYkJiU0nB+4DqAy3VnggK/KxIX86QV+UAsFnZnTn8cht2
	 2RGSZrtIBYdIXSDWNVeXEvR0gN9TG13N6Z7WA9UE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 042/332] ethtool: rss: add missing errno on RSS context delete
Date: Sun,  7 Jun 2026 11:56:51 +0200
Message-ID: <20260607095729.660978250@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260996-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 798F864F59D

7.0-stable review patch.  If anyone has any objections, please let me know.

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




