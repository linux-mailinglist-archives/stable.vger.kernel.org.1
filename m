Return-Path: <stable+bounces-217731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APF0IZI5nGlCBgQAu9opvQ
	(envelope-from <stable+bounces-217731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:27:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 280651757D9
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C5F305F644
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668B13612E4;
	Mon, 23 Feb 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q2lb2ihs"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47D35CB8F
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845839; cv=none; b=u4x+9k58P5IYMarjSR071U6DzYdbEazjBzzkTZwk0qTdL9bpW2evHfNyQOz3In02TpnGxgfg8gdJoZw1YJHpjz8kGo3kIrTqBBFf6Q2b3VZ2SBBUSM+GClw1gfgpr4o+GxZulWINFYWlKxHR40laeIhB8qULQeOxJZ2ca3noo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845839; c=relaxed/simple;
	bh=JPgultTIWgbNYxA4vXArnqWlMkM/RR4GlNiyDYUXKLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNCY8fsrBRQBSMDKjeYVLtyQ8L608SJrdPKh2m0oqJ1o8VZxSHF7qbmAyQBNuV41YuFgLPKuCrN7Fu13zMRJRKWgZ4c6Jhwn2C9RS+AGVl3Y0EPD4tzqFH/YSETAYpHXUCXuaZCr0MAPa+dtZUGc1dWMRZ8Ul2n57Rg8ye7KaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q2lb2ihs; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8959dd02f04so2972866d6.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 03:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845837; x=1772450637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9EWl9Y2Ycs1HrHu15KRF0sV4Ewn7s/wLLI95hZv0i4=;
        b=aRPgVqjje3OOflZ4u9NSZPp/FGGEtxTh8PbUbQs4brsd/aGUF1kfW8m+WfP2TPONEj
         Mr6m6KpmVJVcRQvcDJlhRpHL1MEiKAQHxmy5erTlNyrw8ZzDSFlP+Fmc8bIQ7RTsEyzZ
         WsgcpdeBXpyZvfqKls8ew49A3M0oqxBDBwqiBEnv2WkvK26gbq1wjN+m/zkPWBENhDlS
         f0EFJwLqeamjnPBLlF89ENNjlzY4CT+1vPb2iyPWOdS458sBwlZP8NP9v/JM6kCC4liS
         me9uI1mga2f3iWN08lZA7sPl0QIrdpS+M/YLlfl/9YpXRLeUadZi/lx/wYJGlde4Lb5Y
         O/nQ==
X-Gm-Message-State: AOJu0YwtgBdV/koDqwWGXH5srGmZLlBaTiBXZW3hv+sit3GU5QelMJ2A
	7jdsryhhr/vs3IR6qHwVvS+m62ahwZ+yW4hJpCawDdWIKeQLS1JyDtwHtLJGKK7QoWTtF7cxu8E
	LWOImXt7utn76XXuntEtFovh5rRECxr1lX9Uv4wyF8ciS/3b/f/kuq/wogUpXybuWey1211bGYt
	Pk4D1tuKQIJrBMP2wkAL2PzKm5pEfK3PlzeFVjCpqa14yYGJwB5BvSh9SvbD9QIBdNX0DtEd0cC
	L1dB5N//OtkGIZRIwdnwodTHQcGVPw=
X-Gm-Gg: ATEYQzyYLtilHdrHAEuA+UjjvZAo93bZQk+JFQMwusRrkorhaxPAPoZhNi21GaMYtV4
	Rm8DwsrCf8SQX3mRALUgOKo39AdShNR/WawiJEhPIKW8lBVah+Qg47kc/m+iQGNCXWKCPe52pMI
	rYMmQJT0+wD1YI2bSfSrE0T74JQaEPBu8z3d8p2drnnYgMuS0HtL/deyWJJFW5fHvdGk350YDRn
	t2tpvlXr4Oa/y0BRAR7EGlFYm5n8IUUX/MbT8FnDM9XFH06cAd6RT5d4iZUfWWgcLtwZ3rEcOQ6
	ba6nlulZvuWmqL+PzOTy0QgQFTgeryZsBa+te8onu/EdNWl+y7MW09K5t8A9P2wLP/ozQDZo8za
	DLXHEf2QYiTeuUkoQXixXEVfFl66f2553XDZfeemNzo6vFhvIPwRXrMcjvsApMbJZ0SpQ11EKRc
	uyq/DkvwLRiYA4ZLhfwuN7hpUsNbBbZqn/k2t78bmpnNjRR7lBHrzQ2f7Uy2fzZLameRB7r57ld
	fUC
X-Received: by 2002:a05:6214:6015:b0:894:9f0a:7a69 with SMTP id 6a1803df08f44-89979c5eeb4mr85484556d6.2.1771845836855;
        Mon, 23 Feb 2026 03:23:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8997e1426cesm8355556d6.15.2026.02.23.03.23.56
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 03:23:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-895375da74bso46814666d6.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 03:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771845835; x=1772450635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9EWl9Y2Ycs1HrHu15KRF0sV4Ewn7s/wLLI95hZv0i4=;
        b=Q2lb2ihssqbq6RlsYb0F/fBARy8lHelBo04AIS1+osNQR0AJBBfbGcRfdnu+eJUcEY
         Zy37Wa8DL+zO6fyDJanKNJMUuaSie0kAk/voTgMDNI4pyWlbnVZOPzYzP3UoilYN+zOH
         XsaYlfP+zN4F1wSD7RS+VCfo8DC65ZsR5mxIM=
X-Received: by 2002:a05:6214:4f1a:b0:897:1d50:2336 with SMTP id 6a1803df08f44-89979d74070mr82436716d6.6.1771845835547;
        Mon, 23 Feb 2026 03:23:55 -0800 (PST)
X-Received: by 2002:a05:6214:4f1a:b0:897:1d50:2336 with SMTP id 6a1803df08f44-89979d74070mr82436216d6.6.1771845834866;
        Mon, 23 Feb 2026 03:23:54 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d1224f6sm682922385a.46.2026.02.23.03.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:23:54 -0800 (PST)
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
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v6.12] ipv6: use RCU in ip6_xmit()
Date: Mon, 23 Feb 2026 11:18:50 +0000
Message-ID: <20260223111850.4165186-1-keerthana.kalyanasundaram@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-217731-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 280651757D9
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
---
Changes in v2:
- Modified to apply on latest v6.12.y

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


