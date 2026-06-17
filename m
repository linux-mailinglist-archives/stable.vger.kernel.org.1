Return-Path: <stable+bounces-266794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cwAWMEawMmqf3gUAu9opvQ
	(envelope-from <stable+bounces-266794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:33:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BDF69A943
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:33:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cmTRoar7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266794-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-266794-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00F87302EDEC
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EB83F5BFD;
	Wed, 17 Jun 2026 14:33:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA33F0ABE
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:33:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706818; cv=none; b=OfEFO1pT/325afsVJTBSiizZYJzm6Df73vQCMsLxCxsMelEyN4LyRNgpSr95AHhk2TDsjbWt6LdwkFfBSljBvvftxGZXGfGgYxw2gcRHqAaqkgO+7f3jWZyY1LMTrDDoCz15Qyhl6hZIwDCtov/cqjZ61c6HgF0fg3EoFKmrsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706818; c=relaxed/simple;
	bh=u6za2pQomzjrHXKVrEnhsnuXJe/YhTUfdNJ6xViSwJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqH6R96u8md6/0/xWHlHRphIaNXEPEMqNnM/Iro84OS3GMlkYKZblUPWrCx0+iPmT9gyVPE2swqWtxAwhb3pSSNJaCsbnZmVq1Sg3lwdKYga6bwPyURi/6iZw41WT81ZFZce6xG7ypfF201qpLzDB4iaD5qAQbUa4+Acq3hvoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmTRoar7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8351F000E9;
	Wed, 17 Jun 2026 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706817;
	bh=n85baoOzuqnd+rVQs1BoTnxrQgBaBFs5Wg1Dp2HgvfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cmTRoar7Vx2d66vbYC41F1ScWf7roWnk0qByn8YUFpnDbRZljOFzoEqz5ZM4w20hC
	 vL85X81wb1OE2BzgO4UUP6vA/WtjgrZyLtRRjii5cTslufvcdE0uqmrRW9vae8l9x1
	 bXbVeyfyDLZVg2GkKH7XKyQCAxUHpX5DV/rg+DVttdzGfx5jC7WvHNL5pEHHzQdbFm
	 DRYmFv8VEQ+Ji/FaVysnhrmbk3c550+v51dX6WsBseGCdpnJPR7S7aPhTSOHvecThZ
	 itZZvWihEUy4KZfiuHWDh4DUwVZtTHxBEij4MCIb5lrNdyaitHd/8vosW+/zD2pASo
	 paALIPMUhelmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] phonet: Pass ifindex to fill_addr().
Date: Wed, 17 Jun 2026 10:33:33 -0400
Message-ID: <20260617143335.3942705-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061544-output-dreamt-c938@gregkh>
References: <2026061544-output-dreamt-c938@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266794-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87BDF69A943

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
index 894e5c72d6bfff..3205d24574779f 100644
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


