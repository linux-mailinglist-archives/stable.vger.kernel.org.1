Return-Path: <stable+bounces-226586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ0HDgGRuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:36:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CC02AFD54
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF563229675
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB743F7897;
	Tue, 17 Mar 2026 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EQ4mhFx/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26083F54DE;
	Tue, 17 Mar 2026 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767348; cv=none; b=pL3CxbbkOl3rS7XVyLQ5BhdlMSWfwN4tshrYHM53yAQsiqjmrZI19szJsq05CmsoUzOuL6qMzpyob4KNFXI2p83Lrlu3juVlSW8eFPA8GEa/myrrgjGhDDFViC9VkP2R0dTMjST/T4dcGLPRNGebGryyM7niNw6yu9OZBSHc4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767348; c=relaxed/simple;
	bh=rctog8/12so7nUHboPwJhvC5kWXPW6WFOETRIQ40RX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRf5dUlXVbE03SJmqWrTmP1J0CJHxj55kx0+jI7olEtpmTEKXWTHH35k7gnEK/aMiOc3qiNNztzxAKMRNhYrKb5IOz8IAHUrrCI5scZo3TU5cJrpdza8yD1gvwG8RP1Q7YcnvW1kOxoLfs9SvKQe5tHoBpQ93JzhJfVxUs73oko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EQ4mhFx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C24C4CEF7;
	Tue, 17 Mar 2026 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767348;
	bh=rctog8/12so7nUHboPwJhvC5kWXPW6WFOETRIQ40RX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQ4mhFx/GtQLbdwnuBRCcuBf5bPPWIOX+mL/ayfhceUQ0roeDt1BlkxK2zq0IXqnh
	 k0JdTF4G+si9AxGxFD0qiNnGnu1eahnQBYTMmBTIacNATPDW1mMO1P4+MMCYfZe0Kc
	 7HNkeILBETiOq1e31YRqN9BAPmGbzUESXD3Tz+G4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	syzbot+bb9127e278fa198e110c@syzkaller.appspotmail.com,
	Helen Koike <koike@igalia.com>,
	Phil Sutter <phil@nwl.cc>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 066/333] netfilter: nf_tables: Fix for duplicate device in netdev hooks
Date: Tue, 17 Mar 2026 17:31:35 +0100
Message-ID: <20260317163001.820166866@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-226586-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,bb9127e278fa198e110c];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,igalia.com:email]
X-Rspamd-Queue-Id: 85CC02AFD54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit b7cdc5a97d02c943f4bdde4d5767ad0c13cad92b ]

When handling NETDEV_REGISTER notification, duplicate device
registration must be avoided since the device may have been added by
nft_netdev_hook_alloc() already when creating the hook.

Suggested-by: Florian Westphal <fw@strlen.de>
Reported-by: syzbot+bb9127e278fa198e110c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bb9127e278fa198e110c
Fixes: a331b78a5525 ("netfilter: nf_tables: Respect NETDEV_REGISTER events")
Tested-by: Helen Koike <koike@igalia.com>
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c    | 2 +-
 net/netfilter/nft_chain_filter.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 598a9fe03fb0b..ed1d639fe34d7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9841,7 +9841,7 @@ static int nft_flowtable_event(unsigned long event, struct net_device *dev,
 			break;
 		case NETDEV_REGISTER:
 			/* NOP if not matching or already registered */
-			if (!match || (changename && ops))
+			if (!match || ops)
 				continue;
 
 			ops = kzalloc(sizeof(struct nf_hook_ops),
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index b16185e9a6dd7..041426e3bdbf1 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -344,7 +344,7 @@ static int nft_netdev_event(unsigned long event, struct net_device *dev,
 			break;
 		case NETDEV_REGISTER:
 			/* NOP if not matching or already registered */
-			if (!match || (changename && ops))
+			if (!match || ops)
 				continue;
 
 			ops = kmemdup(&basechain->ops,
-- 
2.51.0




