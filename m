Return-Path: <stable+bounces-222533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKQpIO8+pWm36gUAu9opvQ
	(envelope-from <stable+bounces-222533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 08:40:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E71C1D4103
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 08:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 631C0303E2F6
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E05E38553D;
	Mon,  2 Mar 2026 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="Yu6lHSvH"
X-Original-To: stable@vger.kernel.org
Received: from out30-76.freemail.mail.aliyun.com (out30-76.freemail.mail.aliyun.com [115.124.30.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98420383C84;
	Mon,  2 Mar 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437041; cv=none; b=PZRI2lvaxU6OcSb8aimVYIXUyu+JMjdMIL/Ry9QbUrRID85AiiNfiRrCMasyG9IiPaJhlVXGnw2w2kJT7oY6Qz13P5zRoGy9hOvSXIr2J1QpphchES7emgeggWSsEQ5XCtzGTVZrX/SMVKV6drBKxJSj5wa6rCunBXyc9I+ajPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437041; c=relaxed/simple;
	bh=/Ak/8butzfWPVAMmnWQ+bEf9wyueuDou4auueWLjXlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+zGBeeOxfGirp8bvLnJ3qMqV3Q3sLLK/R8WtY6Z0YyESfBzfXGMVu6ngJGpS022g4N9kXBJuaPYmCUPg3OFNDWZBewf41l71RnC4BY3vVjYXBD+4efhdvXJk/7gp3aDb49dY+JfYfZlvKziVfjTdzJLh+4rJFM/tMbq5I4pK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=Yu6lHSvH; arc=none smtp.client-ip=115.124.30.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1772437036; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2juYv6kGAaXC300qzkC93wjo3j/CiglNV95eZLqzBhs=;
	b=Yu6lHSvHFx6awE7CLMCWgTuI9otZBzFhZhqpsgy8ZFBlIaj9CT6BWNFqXCKa454Hqf84aRqLri5lrLGBXLyQdJzR1xB9RrMxlIatqKJSAaMU9/5Pr9IzWroVDY/2MdDGDkqu8pO5PEUZWVLFsaKNoqhEnYEr03HwQhYAp3cROUs=
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X-2840U_1772437035 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 15:37:16 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: edumazet@google.com,
	kuniyu@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.6.y 2/3] net: dst: introduce dst->dev_rcu
Date: Mon,  2 Mar 2026 15:36:29 +0800
Message-Id: <20260302073630.988982-3-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302073630.988982-1-ruohanlan@aliyun.com>
References: <20260302073630.988982-1-ruohanlan@aliyun.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222533-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,aliyun.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[aliyun.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruohanlan@aliyun.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aliyun.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliyun.com:mid,aliyun.com:dkim,aliyun.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 0E71C1D4103
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit caedcc5b6df1b2e2b5f39079e3369c1d4d5c5f50 ]

Followup of commit 88fe14253e18 ("net: dst: add four helpers
to annotate data-races around dst->dev").

We want to gradually add explicit RCU protection to dst->dev,
including lockdep support.

Add an union to alias dst->dev_rcu and dst->dev.

Add dst_dev_net_rcu() helper.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Minor context conflict resolved. ]
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 include/net/dst.h | 16 +++++++++++-----
 net/core/dst.c    |  2 +-
 net/ipv4/route.c  |  4 ++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index ea3b050f8b38..af2a0810f23d 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -24,7 +24,10 @@
 struct sk_buff;
 
 struct dst_entry {
-	struct net_device       *dev;
+	union {
+		struct net_device       *dev;
+		struct net_device __rcu *dev_rcu;
+	};
 	struct  dst_ops	        *ops;
 	unsigned long		_metrics;
 	unsigned long           expires;
@@ -571,9 +574,12 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 
 static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 {
-	/* In the future, use rcu_dereference(dst->dev) */
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return READ_ONCE(dst->dev);
+	return rcu_dereference(dst->dev_rcu);
+}
+
+static inline struct net *dst_dev_net_rcu(const struct dst_entry *dst)
+{
+	return dev_net_rcu(dst_dev_rcu(dst));
 }
 
 static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
@@ -598,7 +604,7 @@ static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
 
 static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
 {
-	return dev_net_rcu(skb_dst_dev(skb));
+	return dev_net_rcu(skb_dst_dev_rcu(skb));
 }
 
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
diff --git a/net/core/dst.c b/net/core/dst.c
index ac67706e5f87..744592cbbd24 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -152,7 +152,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	WRITE_ONCE(dst->dev, blackhole_netdev);
+	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fcabacec89c7..a4f8cd48ca45 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1042,7 +1042,7 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		return;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1340,7 +1340,7 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 	struct net *net;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dst_dev_net_rcu(dst);
 	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
 				   net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
-- 
2.43.0


