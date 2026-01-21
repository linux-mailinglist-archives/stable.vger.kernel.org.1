Return-Path: <stable+bounces-210966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPn6KvMncWniewAAu9opvQ
	(envelope-from <stable+bounces-210966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:24:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3F75C1A2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24ABDA4F875
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8F3806C0;
	Wed, 21 Jan 2026 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FUnPQ/uz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08653A89B8;
	Wed, 21 Jan 2026 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019984; cv=none; b=juos5SZXnraBhZbcVrCotx2BFRcsOchmw3yvDl8TosDRG1jT+uqPMeNG6k/z3tbyqbS6ouGhHPWiMCtx3oLlhuvJQpKPrhQZtICgQdYeO9qwAhNBM8dgThYlm7ZCtivOrJkgd9ajkcpQMJSerKSoQqbs/cX8kttmvw4B5jEOtBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019984; c=relaxed/simple;
	bh=O6VtRZrDH9UpkBMlVG9R23vK2GhxrPK/VAu48xZHYsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVJi5+/VOLQ1I1maVgstArvjKYtdunQSr2BGcLjQhmO010TFC+Rrt9DDMcQJ5XMo0G7DdXAbpsZas9fFxTkPzIGm6hU4KFupPxuhSL3jJ7f95JF36hTapMx1jqzhw8cmxLyxpu97SndVrOHmG2Pg6wCQxthpN8KpyJJYQQKz3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FUnPQ/uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B2FC4CEF1;
	Wed, 21 Jan 2026 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019984;
	bh=O6VtRZrDH9UpkBMlVG9R23vK2GhxrPK/VAu48xZHYsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUnPQ/uzUOtJzcYhbNju1uYVf+/P0eU3SxTfwDmudX4SKqCp83Q3df0PQ7OXWxCEH
	 uJIVnNxxzaPg30jHb0F4/4iPPFNQI/LqkYmDAWmKzN1VbTeVA124s0srTcZp3oSiJv
	 9sONQOPRxWvp43B84BPATulKdcycg4bWNo8gJEvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1240b33467289f5ab50b@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 025/198] ipv4: ip_tunnel: spread netdev_lockdep_set_classes()
Date: Wed, 21 Jan 2026 19:14:13 +0100
Message-ID: <20260121181419.460433123@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210966-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,1240b33467289f5ab50b];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 1F3F75C1A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 872ac785e7680dac9ec7f8c5ccd4f667f49d6997 ]

Inspired by yet another syzbot report.

IPv6 tunnels call netdev_lockdep_set_classes() for each tunnel type,
while IPv4 currently centralizes netdev_lockdep_set_classes() call from
ip_tunnel_init().

Make ip_tunnel_init() a macro, so that we have different lockdep
classes per tunnel type.

Fixes: 0bef512012b1 ("net: add netdev_lockdep_set_classes() to virtual drivers")
Reported-by: syzbot+1240b33467289f5ab50b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/695d439f.050a0220.1c677c.0347.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260106172426.1760721-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip_tunnels.h | 13 ++++++++++++-
 net/ipv4/ip_tunnel.c     |  5 ++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index ecae35512b9b4..4021e6a73e32b 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -19,6 +19,7 @@
 #include <net/rtnetlink.h>
 #include <net/lwtunnel.h>
 #include <net/dst_cache.h>
+#include <net/netdev_lock.h>
 
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6.h>
@@ -372,7 +373,17 @@ static inline void ip_tunnel_init_flow(struct flowi4 *fl4,
 	fl4->flowi4_flags = flow_flags;
 }
 
-int ip_tunnel_init(struct net_device *dev);
+int __ip_tunnel_init(struct net_device *dev);
+#define ip_tunnel_init(DEV)			\
+({						\
+	struct net_device *__dev = (DEV);	\
+	int __res = __ip_tunnel_init(__dev);	\
+						\
+	if (!__res)				\
+		netdev_lockdep_set_classes(__dev);\
+	__res;					\
+})
+
 void ip_tunnel_uninit(struct net_device *dev);
 void  ip_tunnel_dellink(struct net_device *dev, struct list_head *head);
 struct net *ip_tunnel_get_link_net(const struct net_device *dev);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 158a30ae7c5f2..50d0f5fe4e4c6 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1281,7 +1281,7 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_changelink);
 
-int ip_tunnel_init(struct net_device *dev)
+int __ip_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct iphdr *iph = &tunnel->parms.iph;
@@ -1308,10 +1308,9 @@ int ip_tunnel_init(struct net_device *dev)
 
 	if (tunnel->collect_md)
 		netif_keep_dst(dev);
-	netdev_lockdep_set_classes(dev);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ip_tunnel_init);
+EXPORT_SYMBOL_GPL(__ip_tunnel_init);
 
 void ip_tunnel_uninit(struct net_device *dev)
 {
-- 
2.51.0




