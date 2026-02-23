Return-Path: <stable+bounces-217730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E47GG45nGlCBgQAu9opvQ
	(envelope-from <stable+bounces-217730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:26:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB61757CB
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76D1304EA99
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD793612FA;
	Mon, 23 Feb 2026 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WYfSxzD9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3E361644
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845824; cv=none; b=PP50pl/hb9zlnZ+4f7hI/Ki5thOUUCb/1hQdIJmXSmLXCSkZbnMN12Si3YE4UMQwZe+kAah+CKFQg3l5zvyKGDi8aURANvpGYWEWBowJXwJRph2o/k6lBf8QvU+BzV+MdJLEeFkYV90G8KthQpIuoepxmiHVUk0ugcovtos7wao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845824; c=relaxed/simple;
	bh=lvTW1+OHeoqBwGRfC687Y/+rOdge+5sxdrNLssMANaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjOqBwJXTp8PIaouN3p/iMvkHEJrT6jLAzPBJq1MoDwDxDBFVKOdamOWbYPYk//sbDz6FW3gGwm66pGEFYz59HmHLXSj23qi4wxQ3kRXEUcc39FIY6n+r6zne2+a4Tpbb7f828phpBNCaoYUmebjWUU9CNS67JIVhYWUeUm+UWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WYfSxzD9; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a9633ef0d6so6152325ad.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 03:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845823; x=1772450623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCb3mGAPKai1Hpobl7lKadHZ3M3yFOIt6q/w7eisnl8=;
        b=M8yav4LB+jKkfTG91r4m+us3fPDtMOKcI73jwLk4FlSJDhRU0Bfj+j9FDn/v/C/Xo2
         vJgzR2ymG69aWIcU8C+dZg5zarZ68JJbf8tsEBnGKNNFn+tfnnm9IxpppELvSPdBRVHN
         UX1+g42/pEJQR59w6Drct+G8Pa3Ts0vgu0GKdMpoKt+xwUmSPooN3pCTbAorUJRFimp7
         wo+uT/SUYyWYcukQD0m1j7XsywsSqtLIqdnD6nkV9eqFMCaMeiCUTU1XkZwLKZlwUDAe
         2tuFnhc4TMaWWMrzFLWLN9QBLG6j91KSSxim1JuzKl54qgV5HMRldMFo9rdKXstHLeqW
         k2DQ==
X-Gm-Message-State: AOJu0YzpXpnJ+461rCmiFZ3GddRL5RJqjmmSx3XxnBeCZy8mYkTN3enj
	Lia880XvmQBm6Dw9TyPYg6bIU9TaBPM4w5hsFp2p6rN6Mkzxg8DBoqMKY3AkMRSXnK9LKSa2Yel
	l1Nw0FEnIJv3qsCyyHjj1crmwwJde52lMsiJcV2Fbw5NeYjIpUnl1RvmWPNXjdb6QyUKi5DwCdd
	3mdPZhQGJTcLB/goaHMkGEUkXKVZNzNg/v1HYncZTsguMi6ODTMnfUqNEFsYuQIlYHGOY0IdoJs
	BLsGOsaBJGx+usCPcLGaTZS8vECWfo=
X-Gm-Gg: ATEYQzz1H5EtFdwGAyI1qNHSHf6DDs1gfsPGbE7+ewGpz0w04Fs2Bt3+PaMe2UeEJmI
	mudWV5LFb8fUh+oKVX1tx5EnxnX6qp4oTZkh4loM0AqfE9V8HI3XapBX/leYkoVwFm2A11SCiVU
	a9ww7ojeLMpKdB41fpOWDTZ2xkiVCeY2T43A6YhbU/1/QnkHZKM604vSsX1N3ntmARcORyjR0Br
	CqQ9JEpS54NM839Hr//Rm30u9BxRQzIFOQTG+VZ6u3i5wuX/jZ62E+mBj8f9gEBDI8RPP063aM1
	Q0tpQuiq+buRBSj8oCAuRcWjUcVU1pmqDCaVXc4vTFlcNPREZXkTfFAq1ovnQiEle5vN+wDWU1J
	BoRcwg2KW3TaNsfAAU1VZkn2Ta5ciSsdrJOCqe/vhQ+OejeqM3o2FBF2PYXnXfny2t7PJjozQHj
	cN+fkXnIvHF91Yu9ETSnGUVM1+B8bMPEE/0AJ/p86CNqkt+bvIBcoXaZu94SMV1oAmX3hnVmrqX
	hEu
X-Received: by 2002:a17:90b:3b84:b0:352:d19c:684f with SMTP id 98e67ed59e1d1-358ae8d294dmr5435705a91.8.1771845822639;
        Mon, 23 Feb 2026 03:23:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3589d837bfbsm1516224a91.6.2026.02.23.03.23.40
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 03:23:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-506a633ce06so56470221cf.3
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 03:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771845819; x=1772450619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCb3mGAPKai1Hpobl7lKadHZ3M3yFOIt6q/w7eisnl8=;
        b=WYfSxzD9NnFJRZmYfaFZ3t8C0UTmSfIhB4+DORLfNh8M7uJMxwG8X6Vo44/KrOal1g
         h1DQC//mPiYOMZWiElU/Q+B72Wp21GKd172Z86L55a6KDAJ1HE8ZqS0Qk1VwyU4ImQO4
         t6xO9PAzrDJbo0ss0/c6oX+achzDKlkvcY3HI=
X-Received: by 2002:a05:622a:1990:b0:4f1:b3c1:20f8 with SMTP id d75a77b69052e-5070bbd7824mr89593971cf.4.1771845818857;
        Mon, 23 Feb 2026 03:23:38 -0800 (PST)
X-Received: by 2002:a05:622a:1990:b0:4f1:b3c1:20f8 with SMTP id d75a77b69052e-5070bbd7824mr89593571cf.4.1771845818162;
        Mon, 23 Feb 2026 03:23:38 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d059502sm685245285a.11.2026.02.23.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:23:37 -0800 (PST)
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
Subject: [PATCH v2 v6.1-v6.6] ipv6: use RCU in ip6_xmit()
Date: Mon, 23 Feb 2026 11:18:34 +0000
Message-ID: <20260223111834.4165169-1-keerthana.kalyanasundaram@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217730-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BBAB61757CB
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
- None

 net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f7a225da8525..4ea4da0e71c9 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -258,35 +258,36 @@ bool ip6_autoflowlabel(struct net *net, const struct ipv6_pinfo *np)
 int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	     __u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority)
 {
-	struct net *net = sock_net(sk);
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
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
@@ -348,17 +349,21 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
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
@@ -367,7 +372,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
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


