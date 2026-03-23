Return-Path: <stable+bounces-229351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFZ7JRxewWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:37:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DD02F6915
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7835308A06B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC743B19B8;
	Mon, 23 Mar 2026 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HPnczLwl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADF3B0AE2;
	Mon, 23 Mar 2026 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278844; cv=none; b=OAbjBZ0d9lUryy/jWtHtPVhemgADi3Mgx8JTBxXyttQEMfwxgMn+HvBAwQW8ZRHniDni+xyUiC4/hKQrAy3eL2HV49dvi6Mf5JDrNftPpUYfACXmnrwIrwPHD6+4FqsQP/dqnGUcIjlB2Vau7qF4+ymvD32Hcbk3qX6hle7RYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278844; c=relaxed/simple;
	bh=+5Aqn9ru7qfiHkYJaSnmhWSw7PAlElXSHFFeHRBexhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvEMHcbSWoCYaFyi4u7w3v+GX9hq7zI51260ADEKYYHsOwtsOQO/Nza9AOhkn5/Igb/9vrj3/2cVSIzvlGGtsX9DuSjWIetHn0Y/63lf9cGXK8sWJguCXK4eQwp8PMmDKW+6yz0js+Bx/gea9HW9a/Ob6t+CQPV9e0ArzerqjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HPnczLwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCCCC2BCB1;
	Mon, 23 Mar 2026 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278844;
	bh=+5Aqn9ru7qfiHkYJaSnmhWSw7PAlElXSHFFeHRBexhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPnczLwlUhmH+E5irKJZaX9378uZ9VcFZGJaLzrbCqHResNL4cbT/eUb++Yh0c5o7
	 DlOWd+d4o8+IokpadBwUeHSrwTGKA+OLLXGs4uzcCCDEgIOT9FO6tKiNKxxGgmcEJW
	 MyvlwWNPfpyXFM7gwjaYUXbXmOBIf/wXVFRJ78So=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"edumazet@google.com, kuniyu@google.com, kuba@kernel.org, dsahern@kernel.org, netdev@vger.kernel.org, Ruohan Lan" <ruohanlan@aliyun.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.6 437/567] net: dst: introduce dst->dev_rcu
Date: Mon, 23 Mar 2026 14:45:57 +0100
Message-ID: <20260323134544.765373628@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-229351-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,aliyun.com,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 32DD02F6915
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/dst.h |   16 +++++++++++-----
 net/core/dst.c    |    2 +-
 net/ipv4/route.c  |    4 ++--
 3 files changed, 14 insertions(+), 8 deletions(-)

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
@@ -571,9 +574,12 @@ static inline void skb_dst_update_pmtu_n
 
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
@@ -598,7 +604,7 @@ static inline struct net *skb_dst_dev_ne
 
 static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
 {
-	return dev_net_rcu(skb_dst_dev(skb));
+	return dev_net_rcu(skb_dst_dev_rcu(skb));
 }
 
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -153,7 +153,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	WRITE_ONCE(dst->dev, blackhole_netdev);
+	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
 }
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1042,7 +1042,7 @@ static void __ip_rt_update_pmtu(struct r
 		return;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1340,7 +1340,7 @@ static unsigned int ipv4_default_advmss(
 	struct net *net;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dst_dev_net_rcu(dst);
 	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
 				   net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();



