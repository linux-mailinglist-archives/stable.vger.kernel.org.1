Return-Path: <stable+bounces-219748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNhoDYvFn2kRdwQAu9opvQ
	(envelope-from <stable+bounces-219748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 05:01:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4AA1A0BE6
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 05:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C31F53042B5F
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 04:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815E38947D;
	Thu, 26 Feb 2026 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VMAceVJ2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502630F927
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 04:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078426; cv=none; b=oecSs5H3oJWankUJHEoPf7SNHxC8UW6lmZ5w1fFqQXMO5L87iKAj6ec30u+0W8NoZA/gZQCbD+l7tZoNJ9TdmAvtnlAMTEuB/IGi1B63VrGFHac+QjB+MiwcUbV6LLPBl3d5fr3CK0aEXFmqB9PzhcL/7tcjH39yM+rUATF2fvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078426; c=relaxed/simple;
	bh=p4ObQhsGaquv0/UOLFNM3wnBoRUtCqhdQS05+BaaZZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWDvQHY8GC2BOuAL4t/I92yxThqOBnGTMS3JUm1bV15bHrUP2X1e+quMSUJ4QjP8ig5tIgDFOsM8Gy6uR7/dQkBVWccWnJGlGd2E2PzuyiQNnJ6WmNB2TxTvuxUgT0bVZM+65kp01qVUOlb2WCLwjdrBCCRD8Mb0jWnFqZ7mpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VMAceVJ2; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2aae38670daso268875ad.3
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 20:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078425; x=1772683225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95I2cawC7z6ZKTb4xOnbEbjbg0EhuyvB5ErtjRNQPtM=;
        b=dHHQfVJcTkyNjNY2TxveUIDfgiqwHAKuQHrpEKmsE/v2DzW+S0EGiefVHWbbqh9Whn
         0jenN6WHe5h0pn4oNTiDFcUG3RxKtOrY8E/wA4ltZf4XWs4cACk728iL2oPnaP9l8Pw8
         Wksr1McH5o+hUuPO+Vw6FrzsG88xhzH4Hsb4p5yQJohx08+pyC5SQrcyRcm4ee1UiBsu
         xFL7wOn9IounAuxAapaCWwcj2pWBgFcYBbxDqTqgc0L7V9yLHxwXSDJiWnyhY7RcVB0D
         v5OSW6tAyzuEoralAPrnYLiAluCdIERY0SaOVeZ/C3pMF7+l5MjHoknuncCFcWARY+57
         xjiQ==
X-Gm-Message-State: AOJu0YwxSuBSl2yM3zzNyUxdx9Id3uzpKYUFr/+TaExpJVw01LGbeGvL
	kOCxNzUXX5W6VSXk//2pJTGqsqsBSlwJ9cI1YQRkNP2w1p4koHXuUllEdc//Tr0HippPVUSDE+R
	v5VDdFAyKlbzb0cqo4cCIYA5EtDKbVAFtQBrDWt9P8rv+nr4FMDJ9XEJ6PCBoypOVNnpvWthQBw
	t1oSTjDP0N9fRoMsLfQwcAQLBa+2SxxQDgIm5VjaK2DDMeJV4eWTeu7O0j2exPuAMZYINEbyind
	E4JjzgRuKeJGqbfje495jqcMSejFUI=
X-Gm-Gg: ATEYQzxol40/Wua22S//bc+rV8UXtScxzOPFrIBMVdUu7zIC6HX7axXoVGKVLfgI6TQ
	6kwT5gZauQYwAaanZToJcRCOx5G3xj/Rgiia3GBg8GHh8VFc5OPSAMAGn+c9hUyDedAH3N9aBLs
	CntTD2QeOmAiFV0DYyKDooOx+HuTVIvnDce0+uW4SImPnHd9km41COrFaLr8ufd6NVQIyEZSj9c
	JIHf6SBD+lNMU5SxWGXovQKRuKlteToxL8AagXJAdGzHw3tBUPTUNmM9d4WLNuO+2q5tU4qe4Vk
	Du5+xlaDliX9Q6KqwLMepWZpQHX40KlPQF6H5MC3P3U+nginYDAwwWpPOP44dicnX54pw0lhygj
	HoqXK+HscFBeEnpsExkXpeMARFLNHyaLTAa2cNuVo7h0k0FvVi4akpH5hOFHHQjOsVSlMDc3eYz
	H4Tfn5TkY7ZEGpdWVxeqyYcvmaqSYMwdwCh/t/oRA5+HFKiSuqgAquvfeAAsgLbujlHLLAjbHAQ
	LQR
X-Received: by 2002:a17:903:234e:b0:2a9:5fa7:3d9b with SMTP id d9443c01a7336-2ad7452f60emr110624765ad.7.1772078424646;
        Wed, 25 Feb 2026 20:00:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5dbafesm1249385ad.34.2026.02.25.20.00.24
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 20:00:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb50fb0abdso33280585a.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 20:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772078423; x=1772683223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95I2cawC7z6ZKTb4xOnbEbjbg0EhuyvB5ErtjRNQPtM=;
        b=VMAceVJ28AOsolKJpepNBUmjjVV/MQuJa++lYVe9qCwmjLZsQOSzYOYppv7AlJ01TL
         U60lmM1ZCC8lFJ+eMj+lCJguR5SCzFOqJpgEJQm0KPReNybP4T2/ZdwGAuV6DKMnP7xW
         jxuEzEKRSOFkpNaxkGbYP41bxxFlhxGfyX0d0=
X-Received: by 2002:a05:620a:6910:b0:8cb:52c2:6f19 with SMTP id af79cd13be357-8cb8ca764b3mr1787884085a.7.1772078422581;
        Wed, 25 Feb 2026 20:00:22 -0800 (PST)
X-Received: by 2002:a05:620a:6910:b0:8cb:52c2:6f19 with SMTP id af79cd13be357-8cb8ca764b3mr1787874285a.7.1772078421559;
        Wed, 25 Feb 2026 20:00:21 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6541f1sm103331185a.3.2026.02.25.20.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:00:20 -0800 (PST)
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
Subject: [PATCH v3 v6.1-v6.6] ipv6: use RCU in ip6_xmit()
Date: Thu, 26 Feb 2026 03:55:08 +0000
Message-ID: <20260226035508.3222136-1-keerthana.kalyanasundaram@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-219748-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7E4AA1A0BE6
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


