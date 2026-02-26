Return-Path: <stable+bounces-219747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBCsA2HFn2kRdwQAu9opvQ
	(envelope-from <stable+bounces-219747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 05:00:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 886991A0BB7
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 05:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF4BA306824D
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 04:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E035389459;
	Thu, 26 Feb 2026 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A+zqachk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836838945F
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078407; cv=none; b=XN0K/j0KJhyD4WQNo0ihGaUIXZSApHO5jOlLiw1ZHlEe1LSoETS0esWXSDEUAXRmDiuG8RZiviRnPhW2jWXgGpChuhJ+OX0hibyN5ypDMDZ+kkhPR8DmCWjabCQ+T1jsBvVv6GsnbCjbPRXCTufeBMb2AyA6A4opkZ8+dyyELA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078407; c=relaxed/simple;
	bh=yUL8W7q3973HgXkMv9YNfI6lkImeogNMi/pAL3ytizw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8KueaMeQrM8TUp5sGHebIdG4xCioibclhaxgIEUyMKHODJamlm4LEedvpGt5Td4NDMVYVT+yqqRbhsfhWFd0zM3PSBuqk5WwwwAlIrgcz9UiSDN+ebtGv39LqlWqi8uP3sLCRicSAFHXffX8qmLOPH6UAH4m0PLndGaaiRRRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A+zqachk; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-64cb01feedbso60601d50.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 20:00:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078404; x=1772683204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2vekJc+TZLbqZ8ynAz/dWVNNz4zBmku0WGBUmEYr8g=;
        b=P9i6MTIStRFpKdRaOOy4B6AfwYBQ0wbOrp78pH1baPezUrRwrn8gOeHFpPiP3YDztp
         /Zlk/Qn1TDrJDxbh+TFu0c1g4UeCpCfRSBDHpD6XLWqNYvejebeLlS5LC8F1zoko7PR3
         4B2FmcK7wbqNbCykdlbYIWHaeb7LmDoHqGFCu8pk2uWWBbAYbpSjsNhT24f6fiPYf5DQ
         jiYBwyb0Fwua7Y2hGBSxjyIJ3ZGpfQs6h+b4NupCmo941Vyuumc7Rvzhe3i1Az6HwcGX
         i18pYMPnpKVNmd83n/rJj84cBj1Ig5/GySy23b3zKfTzBygVQdGX8HSnUB1sWRHBaLwt
         FRoQ==
X-Gm-Message-State: AOJu0YxalHwyrNGlrw+801/esBMjB0FHls4zabbtTIfNirGQB+rDgjcy
	KqB+RcNF0qUYFMfAoIdJ/cee9RWpyHeDRJ5gXRz92l0J9fZLd+fqau9rkMpoOqXyFYVzu4c/N4r
	pT8S/2rIjtON7QUMRqTbDbDX64ZNaqKuQm0cJYt7VONT7G9AwY6Olc8RXOjv1/gIli3Aej6p4FT
	D19k2sTP3/cNS4W9mxEJlTmKWx24/Oet0oSA5SACguxZetlfeWk+OzTssngcjrSEF7TC6FhUi9f
	V+f6v1y4igs+74VIM5rEPKRcQiTCJY=
X-Gm-Gg: ATEYQzxyzBE9CnNPRNEIMH8SE6up/kg0H7WHnExjSiFJ7kok1c7zgY19TL1cUlYf6R7
	KkTyuqtLRcIUWdHP98s5Y8fpuRePA0q0uolEqZXvZqE6pbqB2VJZrQ5YlrE2y8b9NNkjoQQl0Ck
	CRuCbhBYau9FrE6RGv79efPSKm7BpGyGF/+HyUVK2PL1ai4Lz94ZzkaT2HhT4sbj3qPzpj7i/qa
	7mNlZrAl6/vKXX/x+3QwIWAweYk0Nr/VafIu/tSm6QbouqnZS99hDXzzhxS9tYNsGR7FJ6k6qM0
	Vv2w525g+nZMpUI3A7woJztcYz2zRas4bLBJxz/1IStGGfbRdcqvFn3b02ZRqnZM+Fu6aCgU3W8
	oqKJqW91lQNdtdi6+pA/2aVwmesxG8zq6inu5msxdusqwKOuk3NMIho2hs5JOgajI2GoEy84EQn
	hi/I3ceFnpMnYHMh6A2fe794Bdz9lD86amkze6JUnYEH3UvNN/m84VEMus5jwQOf/hDd8hRd7mb
	MLb
X-Received: by 2002:a05:690c:6e84:b0:798:5ce8:f46a with SMTP id 00721157ae682-7985ce90508mr61405327b3.3.1772078404333;
        Wed, 25 Feb 2026 20:00:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79876aeaf2esm892037b3.12.2026.02.25.20.00.03
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 20:00:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50698374e33so4249981cf.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 20:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772078402; x=1772683202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i2vekJc+TZLbqZ8ynAz/dWVNNz4zBmku0WGBUmEYr8g=;
        b=A+zqachk6matRI+5fpEXHmXfKlrqdfM2yLcDcfZrVAJlykTS3cBbzB1kRSoKbOpV6v
         +yqH1rukCpOspQEFGDe8Lrz7Ke8VEn3dyDcJI1ROQInOKpHQgOsaGO6kvQuw/oPhRe8x
         8MKBnPVhwJmqiIpj2phFecaTOQUYifxQLDA5c=
X-Received: by 2002:a05:622a:34d:b0:502:a1bb:632a with SMTP id d75a77b69052e-5070ba7b201mr197204611cf.0.1772078402270;
        Wed, 25 Feb 2026 20:00:02 -0800 (PST)
X-Received: by 2002:a05:622a:34d:b0:502:a1bb:632a with SMTP id d75a77b69052e-5070ba7b201mr197204271cf.0.1772078401594;
        Wed, 25 Feb 2026 20:00:01 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074496300fsm10415161cf.2.2026.02.25.19.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:00:00 -0800 (PST)
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
Subject: [PATCH v3 v6.12] ipv6: use RCU in ip6_xmit()
Date: Thu, 26 Feb 2026 03:54:49 +0000
Message-ID: <20260226035449.3222120-1-keerthana.kalyanasundaram@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-219747-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
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
X-Rspamd-Queue-Id: 886991A0BB7
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
Changes in v3:
- Updated authors

 net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 24b68e996..0aedb2007 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -267,35 +267,36 @@ bool ip6_autoflowlabel(struct net *net, const struct sock *sk)
 int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	     __u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority)
 {
-	struct net *net = sock_net(sk);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst_dev(dst);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	struct hop_jumbo_hdr *hop_jumbo;
 	int hoplen = sizeof(*hop_jumbo);
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
 	head_room = sizeof(struct ipv6hdr) + hoplen + LL_RESERVED_SPACE(dev);
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
@@ -357,17 +358,21 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
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
@@ -376,7 +381,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
 	kfree_skb(skb);
-	return -EMSGSIZE;
+unlock:
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_xmit);
 
-- 
2.43.7


