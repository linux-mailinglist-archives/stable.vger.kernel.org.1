Return-Path: <stable+bounces-220363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKN3MKQzo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEAD1C5D0E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DA1A312E9C9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183F3A1270;
	Sat, 28 Feb 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQOPiLq/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241203A1268;
	Sat, 28 Feb 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300260; cv=none; b=Qq/FeSfcScfMI2/B45EiZZ2BHX67sNKfdlDGZStVKvdsmNMc9qQIs7k5wXmK2vBTBrh5+pk3VZUrPatvgDM9NX6Zk9Av2i8iX72o/nk3ZEAjZq7evBf3aEgNZpkdjnmEtqYJZWfXCfjMwkuPAevL/8SANEKZckENPXwMdoXk6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300260; c=relaxed/simple;
	bh=BS2TOG+Wj/1JLc3EtCMlB5kiFK4v3d8bC635VveQl0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0hALcwSYPrkmkesR7kAYhFotp+N3J77nfveh4Xf0CzWTbPZR4yruGLP1R06BkgP1kwRLe/YGcY//2Eqlv5BWC/bHUOTs0L+rMrJ9RpiJnHOmztL8YJPuK9OlFZmVC2JuMtxCcCUCAzwTJEr+LK0KIVIdXtPXBNhch8o59uN6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQOPiLq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBE1C116D0;
	Sat, 28 Feb 2026 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300260;
	bh=BS2TOG+Wj/1JLc3EtCMlB5kiFK4v3d8bC635VveQl0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQOPiLq/9le/cXbDdctWCaTmnvdW2vhJ6pXI1ELVwsLv15GA+Q3KvhMQeRFr9FvnO
	 FgiQVwnyEIZT0MOXfrUnP2pJXOL5siy9CZQ6lt0HFLne+Wio8iwthIXITQ4i47jdto
	 fc5KL6a+N7lC8byUZfXMkZbKSF+Uqh34TDuRyafA/KFEuF3S8sh0ZzGMJBDSfBKxtf
	 UFFiGnkixm9QWPUw5FO3Y+X91uHu6BrRjinvCkNaiYSa3fsPzw9036UFfPKCCzDy80
	 FewJZiaW9Uu2P0U/jclwtX61FDOC4vp5p3mDEgrbWXWJ6N9fOeXB/Wvjf3IbJiHuI2
	 vMtY0d0PVRuuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 285/844] ipv6: annotate data-races in net/ipv6/route.c
Date: Sat, 28 Feb 2026 12:23:18 -0500
Message-ID: <20260228173244.1509663-286-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220363-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9EEAD1C5D0E
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f062e8e25102324364aada61b8283356235bc3c1 ]

sysctls are read while their values can change,
add READ_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260115094141.3124990-9-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/route.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index e3a260a5564ba..cd229974b7974 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2895,7 +2895,7 @@ static void rt6_do_update_pmtu(struct rt6_info *rt, u32 mtu)
 
 	dst_metric_set(&rt->dst, RTAX_MTU, mtu);
 	rt->rt6i_flags |= RTF_MODIFIED;
-	rt6_update_expires(rt, net->ipv6.sysctl.ip6_rt_mtu_expires);
+	rt6_update_expires(rt, READ_ONCE(net->ipv6.sysctl.ip6_rt_mtu_expires));
 }
 
 static bool rt6_cache_allowed_for_pmtu(const struct rt6_info *rt)
@@ -3256,8 +3256,8 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 	rcu_read_lock();
 
 	net = dst_dev_net_rcu(dst);
-	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
-		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
+	mtu = max_t(unsigned int, mtu,
+		    READ_ONCE(net->ipv6.sysctl.ip6_rt_min_advmss));
 
 	rcu_read_unlock();
 
@@ -3359,10 +3359,10 @@ struct dst_entry *icmp6_dst_alloc(struct net_device *dev,
 static void ip6_dst_gc(struct dst_ops *ops)
 {
 	struct net *net = container_of(ops, struct net, ipv6.ip6_dst_ops);
-	int rt_min_interval = net->ipv6.sysctl.ip6_rt_gc_min_interval;
-	int rt_elasticity = net->ipv6.sysctl.ip6_rt_gc_elasticity;
-	int rt_gc_timeout = net->ipv6.sysctl.ip6_rt_gc_timeout;
-	unsigned long rt_last_gc = net->ipv6.ip6_rt_last_gc;
+	int rt_min_interval = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_min_interval);
+	int rt_elasticity = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_elasticity);
+	int rt_gc_timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_timeout);
+	unsigned long rt_last_gc = READ_ONCE(net->ipv6.ip6_rt_last_gc);
 	unsigned int val;
 	int entries;
 
@@ -5008,7 +5008,7 @@ void rt6_sync_down_dev(struct net_device *dev, unsigned long event)
 	};
 	struct net *net = dev_net(dev);
 
-	if (net->ipv6.sysctl.skip_notify_on_dev_down)
+	if (READ_ONCE(net->ipv6.sysctl.skip_notify_on_dev_down))
 		fib6_clean_all_skip_notify(net, fib6_ifdown, &arg);
 	else
 		fib6_clean_all(net, fib6_ifdown, &arg);
@@ -6408,6 +6408,7 @@ void fib6_rt_update(struct net *net, struct fib6_info *rt,
 void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 			    bool offload, bool trap, bool offload_failed)
 {
+	u8 fib_notify_on_flag_change;
 	struct sk_buff *skb;
 	int err;
 
@@ -6419,8 +6420,9 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 	WRITE_ONCE(f6i->offload, offload);
 	WRITE_ONCE(f6i->trap, trap);
 
+	fib_notify_on_flag_change = READ_ONCE(net->ipv6.sysctl.fib_notify_on_flag_change);
 	/* 2 means send notifications only if offload_failed was changed. */
-	if (net->ipv6.sysctl.fib_notify_on_flag_change == 2 &&
+	if (fib_notify_on_flag_change == 2 &&
 	    READ_ONCE(f6i->offload_failed) == offload_failed)
 		return;
 
@@ -6432,7 +6434,7 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 		 */
 		return;
 
-	if (!net->ipv6.sysctl.fib_notify_on_flag_change)
+	if (!fib_notify_on_flag_change)
 		return;
 
 	skb = nlmsg_new(rt6_nlmsg_size(f6i), GFP_KERNEL);
@@ -6529,7 +6531,7 @@ static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
 		return ret;
 
 	net = (struct net *)ctl->extra1;
-	delay = net->ipv6.sysctl.flush_delay;
+	delay = READ_ONCE(net->ipv6.sysctl.flush_delay);
 	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
 	return 0;
 }
-- 
2.51.0


