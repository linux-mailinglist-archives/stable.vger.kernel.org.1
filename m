Return-Path: <stable+bounces-219749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJwJOLvFn2kRdwQAu9opvQ
	(envelope-from <stable+bounces-219749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 05:02:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB151A0BFC
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 05:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77B6430A1545
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 04:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B561B38947D;
	Thu, 26 Feb 2026 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nji0txb6"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0373815C4
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078445; cv=none; b=V55sH8m0tz81D2ip5/rFvNHw9E+DML+C3jFo9YDvia6PSv00i1dnw4SAny397fGLdalYhefCFKnawnC2CLpMAr0YDt6bdwctU9XGNiGDBUD7wqYTY0wL7PockqZYKqPuSmYww9rptB1qDBIvQOORjLWLjRIvUnYw6poPGdPD29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078445; c=relaxed/simple;
	bh=OCwdj7Oh5C+efhQCrlN1d+zmPFTrH4fhSIEXXLkQ4sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhfTBRXAutY0E2KVw+bwNeb/yoHQ29bJZDD8RQwZQS2q6ZS+Kamg0BYAv027H9wqmcWAgsyElWq/VKOJ/pQxaiN09lXeteeLZl09cMhCDAPCMjcHg8u3B5AXfpzhQ4JvyGVltp4xn08YX2qGU3LX25o7UVHSBNPbFyHz2xBF0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nji0txb6; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-56a96ef0feaso4770e0c.2
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 20:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078443; x=1772683243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygNO1gCaOojuV3uvydJE9/w7V+rMBG5fJx8eoEfJcQI=;
        b=uFSJ1DJJK/QBtwhQKLKOPe7v1D6ctF9QrVnhEfNX4uWvBYNp0KMpQldnWbvzdnXxgn
         pwqBNu8/OlHUU3jAiUmLKWo9/s7+Qd0FKOGA8ygmokfPsE3/k3QxNv6FDtag/6bAueVC
         MRZKg3qxsJCyRXQIMTPOEx2D2L7iNG24tf/ntBFOyl8tN10u6jYdE3TDw334uNHo7Q5U
         qC0CDimrDkaCCcUKawB8RrEUMDrvBJz0qQByiAeF/2PfM8lI5iy55YLfwVAJY9iHKOiI
         Kd5yIwEWHiQT8oGn4wowUJrqanuD0LDf7G7TBs7fRuXF8J1vGxkWLPCpXXWrWG+pMNfp
         PGgQ==
X-Gm-Message-State: AOJu0YzoORtFq0WmIxjql9d7s0Cf9vzRGUTuW+CPnQ61r4obkRdGnk0F
	FYeTLCmLbXPhZU+5fdoOqcxm//lRU7XikYayd+twbqY8Uwfd79VWN8kH4KxUBPe3cvfueHarzrj
	VIMU5rfFajp6te4nOp6L3nUVhsAkr5FllWxczFYlsBBkZzFdeMoPtfpNCtSNzuF/neJm/GbmGrY
	YnxlEBKqx7Fr7ZhiKhQwm+TnQTK/TpGJpbg8LKK2cIahO4X+nHGD8ejU/JyeQ1fLeaR7ne0O5gZ
	owFR0i/xL3ANnkmkBMqOPQF/1CZ6gQ=
X-Gm-Gg: ATEYQzzfARa7dca72BI/SEd1Dt8grxzF1dagFcSa48FvOuN4TEwvE0M4ocVCBXfOgGF
	Fvfbj3ustUoT+t6K/S5a/V2zo1CsxPhyy1B9yNCHz05yEIR65yJO8C7mQV8pPUloFr+5Eeq573O
	iXzujwsBn9nIpkLROZmjDNxWUI7DEAOBswvfVNWRRUj3AZ/hVfqyYj0DOw/fB7CfdzXXoBSuYTn
	Zlq93UvZzu5coPdJcgVlfs1ZBBMkJb+NgNn2GKhKVh3H46+cU9CZlU023evWVXu1wQyv0y22e8q
	dnjuim3/cl2Xk0KxuYLJ07Vmal1qsmezUhHjGz9MnymPkfUCu0leqq4ZVZUqkR4V3jM+eb+riGY
	ESaXMym7pADtmvgtNUPvxvCsHfOxo5Znr9whx4muQgUWl/doeuedrDB41YVz/Pfws7z0cvIUKVX
	JD0BFUaDlGuy8+dquV9OOhssTYbwXNDavjliduINsx2Lyo8IX9CsZ3C+A4nTsMh/n/yIoJ3yEjM
	05b
X-Received: by 2002:a05:6122:680d:10b0:566:3608:f8db with SMTP id 71dfb90a1353d-568e486959amr3209072e0c.2.1772078442578;
        Wed, 25 Feb 2026 20:00:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56a91b8c47fsm143286e0c.2.2026.02.25.20.00.41
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 20:00:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8954937be97so5114686d6.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 20:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772078441; x=1772683241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygNO1gCaOojuV3uvydJE9/w7V+rMBG5fJx8eoEfJcQI=;
        b=Nji0txb62+D4NDlmPaxgOitqy7XSmkh0f7umFdeip6Y+5CkGbR3UDVyM5PuP9EKNAw
         rSOCfgcT/pmppZWKjNLdkxP6BnjiKDXQqu1YC9ypEuTz2FZBkRgejdchvfitCTgnsZVv
         d6moqnDNnhZ2sHHHxC96Flhk/fOYmqZipiRwc=
X-Received: by 2002:a05:6214:8011:b0:899:b749:d40b with SMTP id 6a1803df08f44-899b749d509mr48891356d6.0.1772078440681;
        Wed, 25 Feb 2026 20:00:40 -0800 (PST)
X-Received: by 2002:a05:6214:8011:b0:899:b749:d40b with SMTP id 6a1803df08f44-899b749d509mr48890886d6.0.1772078439948;
        Wed, 25 Feb 2026 20:00:39 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf67814bsm118473585a.17.2026.02.25.20.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:00:39 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kafai@fb.com,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v3 v5.10-v5.15 ] ipv6: use RCU in ip6_xmit()
Date: Thu, 26 Feb 2026 03:55:28 +0000
Message-ID: <20260226035528.3222150-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219749-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5FB151A0BFC
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9085e56501d93af9f2d7bd16f7fcfacdde47b99c ]

Use RCU in ip6_xmit() in order to use dst_dev_rcu() to prevent
possible UAF.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
Changes in v2:
- None

 net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 426330b8d..3411da42a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -255,33 +255,34 @@ bool ip6_autoflowlabel(struct net *net, const struct ipv6_pinfo *np)
 int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	     __u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority)
 {
-	struct net *net = sock_net(sk);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
 	struct inet6_dev *idev = ip6_dst_idev(dst);
+	struct net *net = sock_net(sk);
 	unsigned int head_room;
+	struct net_device *dev;
 	struct ipv6hdr *hdr;
 	u8  proto = fl6->flowi6_proto;
 	int seg_len = skb->len;
-	int hlimit = -1;
+	int ret, hlimit = -1;
 	u32 mtu;
 
+	rcu_read_lock();
+
+	dev = dst_dev_rcu(dst);
 	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dev);
 	if (opt)
 		head_room += opt->opt_nflen + opt->opt_flen;
 
 	if (unlikely(head_room > skb_headroom(skb))) {
-		/* Make sure idev stays alive */
-		rcu_read_lock();
+		/* idev stays alive while we hold rcu_read_lock(). */
 		skb = skb_expand_head(skb, head_room);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
-			rcu_read_unlock();
-			return -ENOBUFS;
+			ret = -ENOBUFS;
+			goto unlock;
 		}
-		rcu_read_unlock();
 	}
 
 	if (opt) {
@@ -329,17 +330,21 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		 * skb to its handler for processing
 		 */
 		skb = l3mdev_ip6_out((struct sock *)sk, skb);
-		if (unlikely(!skb))
-			return 0;
+		if (unlikely(!skb)) {
+			ret = 0;
+			goto unlock;
+		}
 
 		/* hooks should never assume socket lock is held.
 		 * we promote our socket to non const
 		 */
-		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-			       net, (struct sock *)sk, skb, NULL, dev,
-			       dst_output);
+		ret = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
+			      net, (struct sock *)sk, skb, NULL, dev,
+			      dst_output);
+		goto unlock;
 	}
 
+	ret = -EMSGSIZE;
 	skb->dev = dev;
 	/* ipv6_local_error() does not require socket lock,
 	 * we promote our socket to non const
@@ -348,7 +353,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
 	kfree_skb(skb);
-	return -EMSGSIZE;
+unlock:
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_xmit);
 
-- 
2.40.4


