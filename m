Return-Path: <stable+bounces-270551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cZ6+Nl2CRmpBXgsAu9opvQ
	(envelope-from <stable+bounces-270551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 17:23:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83B6F958D
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 17:23:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CDfrVnvu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270551-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270551-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AF96301AB4B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBC3199920;
	Thu,  2 Jul 2026 15:11:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F53353A69
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:11:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005067; cv=none; b=phYT1rxeZgntyITx5VSd8a29/j7Bi54YpZy92AfA27lH2onlFqC/AuZ3cTLfvKB7Gfx3mL2+zYlHfJ6z6J9TCrnbEpB+LfPDYLBtU11jm7l1JTpzVA28tOWhjOk9y1ciMVaaR+/vy/WC7GVkXm1E50K2CGKsw90lmylUmwoyh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005067; c=relaxed/simple;
	bh=OaS5jdR6a3zwejP3LIaPmc7V7w788YjYyPyjzR8phEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlYFoCF0bYHdVdWrm+3lWPohPQBH91vM9RxBtIovgaJaUIcY9Y47QgtDjzclyglxBxqZ+CKUl7iViBfYiOU/kueN/HQ3Z6V7aIoQ1/uXNy+TyxXwpabB0sbQ8yh2ldX+rJihEt7558W8dFIscy4a7Y7LRENzckfwHfkAK6XptXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDfrVnvu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37961F000E9;
	Thu,  2 Jul 2026 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005066;
	bh=SVpVf9myb59VQm0mlMhKgh0sPf4gBupxxUt5SrM4PFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDfrVnvu1G1TlkyY1ib0mjl7jlcJGEUuQVKhd5JreOaIqHCXn6JI1m2PlyLwaufZ4
	 ggzxlvMN0B+oK6prA2tHdt1BdNPQursI65QyW7t3cnD8KY4M03rKap9MNH6FjFcfq+
	 K9oTd+5cG/rHO3+edrWR7bcYBC6rb0fCenNyOj1jXmDNZUufYaUpJ+kZs+nLj2uuOt
	 NARKoxxUR9u3+D82Wi0Yn7xrALuABuLhl7kuPYASm+vhC1GRmqtW6fNiyaPmAVZcGn
	 S2W7fW+2D1uTbivRDQOFiAMEgglfg2DZ6DUvw+QKs8cDCUVtEvVu9GCGvRilKyLrMq
	 /lG9S8Uuk/8VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu,  2 Jul 2026 11:11:04 -0400
Message-ID: <20260702151104.3512866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070221-oblivious-crayfish-1017@gregkh>
References: <2026070221-oblivious-crayfish-1017@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270551-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:maoyixie.tju@gmail.com,m:shaw.leon@gmail.com,m:kuniyu@google.com,m:kuba@kernel.org,m:sashal@kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC83B6F958D

From: Maoyi Xie <maoyixie.tju@gmail.com>

[ Upstream commit 8165f7ff57d9667d2bb477ef6af83ede7fed4ad7 ]

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the tunnel link netns t->net. They differ once the device is created in
or moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Add rtnl_dev_link_net_capable() next to rtnl_get_net_ns_capable() in
net/core/rtnetlink.c. It requires CAP_NET_ADMIN in the link netns and is
skipped when the link netns is dev_net(dev), where the rtnl path already
checked it. The other patches in this series use the same helper.

Gate ipgre_changelink() and erspan_changelink() with it, at the top of
the op before any attribute is parsed, because the parsers update live
tunnel fields first. ipgre_netlink_parms() sets t->collect_md before
ip_tunnel_changelink() runs.

Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
vti6_siocdevprivate().") added the same check on the ioctl path. This
adds it on RTM_NEWLINK.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: b57708add314 ("gre: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260612085941.3158249-2-maoyixie.tju@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/rtnetlink.h | 2 ++
 net/core/rtnetlink.c    | 8 ++++++++
 net/ipv4/ip_gre.c       | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 0bd400be3f8d9f..983f01bf1bd6ba 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -210,6 +210,8 @@ int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
 			     struct netlink_ext_ack *exterr);
 struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid);
+bool rtnl_dev_link_net_capable(const struct net_device *dev,
+			       const struct net *link_net);
 
 #define MODULE_ALIAS_RTNL_LINK(kind) MODULE_ALIAS("rtnl-link-" kind)
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a4e017c2cbf213..b97d348a5b2a93 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2110,6 +2110,14 @@ struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid)
 }
 EXPORT_SYMBOL_GPL(rtnl_get_net_ns_capable);
 
+bool rtnl_dev_link_net_capable(const struct net_device *dev,
+			       const struct net *link_net)
+{
+	return net_eq(link_net, dev_net(dev)) ||
+	       ns_capable(link_net->user_ns, CAP_NET_ADMIN);
+}
+EXPORT_SYMBOL_GPL(rtnl_dev_link_net_capable);
+
 static int rtnl_valid_dump_ifinfo_req(const struct nlmsghdr *nlh,
 				      bool strict_check, struct nlattr **tb,
 				      struct netlink_ext_ack *extack)
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 2c1228ddaa22f7..b635d2fedd2dbd 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1406,6 +1406,9 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm p;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
@@ -1435,6 +1438,9 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm p;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
-- 
2.53.0


