Return-Path: <stable+bounces-266797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A1E2Ow+zMmoI3wUAu9opvQ
	(envelope-from <stable+bounces-266797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:45:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D2B69AA2B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:45:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f2OPlIRp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266797-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266797-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90DDD3055DCD
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338D43DA25;
	Wed, 17 Jun 2026 14:45:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD044CAF8
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:45:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707508; cv=none; b=m/4vK5sy/zNdBaCZWAYD3SwQ9Cdymked70mmzEK5N+qaA74++UZUToWemp9POIScvw697P+j+IIwNBI+krmr3uNlehh3yxj8BU1E4ea5QucrL01CiSr/4ZP4WibfB6Hxl3Ul6d96yXrc2wWs/Yxdksk94UH1TBKInsKm6/HhnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707508; c=relaxed/simple;
	bh=2mEWhKkYvCoxqAV4EaE/XMBtHtdRFtluNxbU7PsVflM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7zlNxXsgWcVbv/Y9g08YZZHhYfku+htEHZnS+bmuKbtt+aQd0AljMH5KFStg3XYp+ANc2L96ao4pVsLLBf1NkZdzoiWjdZfnUQfN225SiqsLJ1Jc9KTbUzC4TmH/Fn6JB376lrHykSQEoTh6VUIpPxVr1zkktF5E0EOaiCNggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2OPlIRp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86861F00A3A;
	Wed, 17 Jun 2026 14:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707507;
	bh=SFBxBAhgXrRXmyfBFo/Vgy59o9Ged79mpgVK9YU+rgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2OPlIRpUtOeeTz0P/xTXZMFUwogg71hT4UQF5/sgkSAd0htMP0sGMVJsATWVranx
	 n1BejYfmaTgzNJHv6QXM+AN1IBBpuqOgHdGTih0bVAwQREYt5wS3Ml0SUR8P+PiWrj
	 uHEE6ftEhqz0N+4E9geqTYzqtMxgN47XBH18u8u0QWtlILZXVl2fAsE//6ef30NVyO
	 xqbaGeTU4MUuirmzUXkNZQphnb3pLEAxw2uiqeQJ8N5PLr3m6rqtodjmu/5LT3ebwX
	 U8A1JS1ZdkXvPI1j4J+QI4KXoMG7a/yWejdVCcCcUm7cVGcFbSAOUi45wfBQgqru+L
	 JQDKN8fejoDnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] phonet: Pass ifindex to fill_addr().
Date: Wed, 17 Jun 2026 10:45:02 -0400
Message-ID: <20260617144504.4144644-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061545-rival-anything-e56f@gregkh>
References: <2026061545-rival-anything-e56f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266797-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:kuniyu@amazon.com,m:edumazet@google.com,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77D2B69AA2B

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 08a9572be36819b5d9011604edfa5db6c5062a7a ]

We will convert addr_doit() and getaddr_dumpit() to RCU, both
of which call fill_addr().

The former will call phonet_address_notify() outside of RCU
due to GFP_KERNEL, so dev will not be available in fill_addr().

Let's pass ifindex directly to fill_addr().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 71de0177b28d ("net: phonet: free phonet_device after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/phonet/pn_netlink.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index dd4c7e9a634fbe..6b50e4d526682f 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -19,7 +19,7 @@
 
 /* Device address handling */
 
-static int fill_addr(struct sk_buff *skb, struct net_device *dev, u8 addr,
+static int fill_addr(struct sk_buff *skb, u32 ifindex, u8 addr,
 		     u32 portid, u32 seq, int event);
 
 void phonet_address_notify(int event, struct net_device *dev, u8 addr)
@@ -31,7 +31,8 @@ void phonet_address_notify(int event, struct net_device *dev, u8 addr)
 			nla_total_size(1), GFP_KERNEL);
 	if (skb == NULL)
 		goto errout;
-	err = fill_addr(skb, dev, addr, 0, 0, event);
+
+	err = fill_addr(skb, dev->ifindex, addr, 0, 0, event);
 	if (err < 0) {
 		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
@@ -92,8 +93,8 @@ static int addr_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-static int fill_addr(struct sk_buff *skb, struct net_device *dev, u8 addr,
-			u32 portid, u32 seq, int event)
+static int fill_addr(struct sk_buff *skb, u32 ifindex, u8 addr,
+		     u32 portid, u32 seq, int event)
 {
 	struct ifaddrmsg *ifm;
 	struct nlmsghdr *nlh;
@@ -107,7 +108,7 @@ static int fill_addr(struct sk_buff *skb, struct net_device *dev, u8 addr,
 	ifm->ifa_prefixlen = 0;
 	ifm->ifa_flags = IFA_F_PERMANENT;
 	ifm->ifa_scope = RT_SCOPE_LINK;
-	ifm->ifa_index = dev->ifindex;
+	ifm->ifa_index = ifindex;
 	if (nla_put_u8(skb, IFA_LOCAL, addr))
 		goto nla_put_failure;
 	nlmsg_end(skb, nlh);
@@ -140,7 +141,7 @@ static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			if (addr_idx++ < addr_start_idx)
 				continue;
 
-			if (fill_addr(skb, pnd->netdev, addr << 2,
+			if (fill_addr(skb, pnd->netdev->ifindex, addr << 2,
 					 NETLINK_CB(cb->skb).portid,
 					cb->nlh->nlmsg_seq, RTM_NEWADDR) < 0)
 				goto out;
-- 
2.53.0


