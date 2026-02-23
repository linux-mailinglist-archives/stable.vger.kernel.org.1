Return-Path: <stable+bounces-217729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNc2G6A4nGlCBgQAu9opvQ
	(envelope-from <stable+bounces-217729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:23:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9029B1756D9
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB703301083D
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE463612D5;
	Mon, 23 Feb 2026 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Giec4etg"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79234D922
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845785; cv=none; b=vGJElEmRpFYScOXw3qsQKlVxDFDw9q4U72P9HhE0UOitPLGAqEkq8gbtUo4vCBLKGeDPMVZHoYHT/f7PwPKq2kOst0/2o6N5zQDM/0QLL+eE1yaKa9xqVbeLMEq9CCAbEdMZDkL4lz+6j3N/beecyPA9KOM6S79EWYM6cuhM8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845785; c=relaxed/simple;
	bh=OCwdj7Oh5C+efhQCrlN1d+zmPFTrH4fhSIEXXLkQ4sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIFcZPq8u1fcg7kDJ9+cK5J1rg2K1q9qQTn7Ua/AT0ejYlV6j7GNym8wX+K9tbgyqfEVQYS6XovCzTODX9o5xfWbkqxwgTEarMgUBj8B3RB/wVyQrzzZl9vNWmWjLyC3EFrhsnaz3SnNN4osztbceLpop1GQpVXGe1DQqXye2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Giec4etg; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-649d4cdb22cso612702d50.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 03:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845783; x=1772450583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygNO1gCaOojuV3uvydJE9/w7V+rMBG5fJx8eoEfJcQI=;
        b=At4re+/4VId4I2520fyMPU2wVjQnIx0vFQjNRQ6XZwmrUla1uKtiXKF5hJGMstHjia
         Zk2ictZpD+TsBLIRjVuyWrrZWrUDqnnMsyNicpxZrx2HCh1qmI5cJvU/VFKPmiWlhche
         EQuJ7Qsvpmi1RPmw6pbuVOe4evS1Vh6NanQMWzVegt5mmF4WxbTl6xVcbE2WBcbGDoqg
         h7be34I+K2H/t/VtM7URS8CXCP9O1oxv0iDvMRi28S/GcnwHMq58CNV01Qy7+ViF4/6r
         U0HZ7bbAwhleP5ScBK0qCfxpQ6UC0UoUfq2e8qeSJEK14wF7eTi8I2aFUTywaGbzKeoG
         vtXg==
X-Gm-Message-State: AOJu0YzEymVNrw37TTIwTwRkfiOhZz6IP1ZuBab6QwCyxTwPJpFbLth2
	3tza6Ea6pf6YiVmp4Y7tUYJAam1cm+J09yfZ1GXNtF9GTyRAcdJmqSMIzLiz0mdjp7aC8+qJJH7
	wBp0wTK5jx/t0svhDrbYv9AmJGJOwTz98aoZ/saXBgS9rPl09tnAIwevjEpgBVFCJZhX4Ue78ZB
	0TnwR1tZW1Ltv+HGBGL2+ITDNc9/ycAO0HnLfNZRLOh/xQpCOhHQSfoYJdOn1N4Y2FdhZDPW1oo
	NcgJ3g+r0gPAuDcls0+wA9UblAN4q0=
X-Gm-Gg: ATEYQzwZzhleLK54qMAplVH6kwhhj04H36lXL80hXrSzFu6LAHUVwWM9mcAOBz40UAF
	jgjnnn4GlN57HFYaz6CBXnBjIKroCCUU14wg8ckCue79MFiqUcEunCsFO6A20YIzT4mGEpHVRS6
	pORKl9AQVVHIdW3Pt/A7ClsJIb9FChyWmjC7se1I0WqRjFNB3ejWKTrwTeOHTOBBEWdlDh8+keh
	hy/PRvWituPDiht/IhmKPM+uqkxW4NX4Bm+Oy3lrCNNtR6+qUit/5kywhPXWWa9JSLFvdc8SAd3
	qhWdzQGc4AMHiT/dZ6srFFRBflsJ4cLtqiWH2NBrG6PeVtGoCfj52d30rl2THJD9L2opK3kxwbI
	L23eJTzzvCD7EDERBTnGyL0T62SJJZnDcQWn/OOO148tcZaO342sMeI2KxfTu1hPWt/1KNCNTHQ
	kwRE6FqK5PRhlgzBGzKrpVMcMdUkrvrS13be6x6plw+rcpJ0AhPerGINh2BuyWZaqrtDi/VNbZU
	iMu
X-Received: by 2002:a05:690c:d8a:b0:797:a52d:85cb with SMTP id 00721157ae682-7982913fd0dmr55452197b3.7.1771845782766;
        Mon, 23 Feb 2026 03:23:02 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7982de1ef6bsm8663997b3.30.2026.02.23.03.23.02
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 03:23:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89545f12461so45860116d6.2
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 03:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771845781; x=1772450581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygNO1gCaOojuV3uvydJE9/w7V+rMBG5fJx8eoEfJcQI=;
        b=Giec4etgaBfzJsz8gJhbAe8qhQrsjK5KBYgKGBPRRTCkdNCYUw37f6Ob1iiauNYSiF
         zwmRYKO8hL2eebPBwBSvHWqTn1A4s0s8Jt6P0UR1A8yjQDTsDKZQy6EEqFunNhoISD0C
         WBogVR7HFL0kyv1PgXjGCS3zMa5okgz8lCLWs=
X-Received: by 2002:a05:6214:4c8a:b0:897:3f5:6a9a with SMTP id 6a1803df08f44-89979df1e45mr83323556d6.6.1771845781556;
        Mon, 23 Feb 2026 03:23:01 -0800 (PST)
X-Received: by 2002:a05:6214:4c8a:b0:897:3f5:6a9a with SMTP id 6a1803df08f44-89979df1e45mr83323186d6.6.1771845780975;
        Mon, 23 Feb 2026 03:23:00 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e242fb8sm67106496d6.33.2026.02.23.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:23:00 -0800 (PST)
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
Subject: [PATCH v2 v5.10-v5.15 ] ipv6: use RCU in ip6_xmit()
Date: Mon, 23 Feb 2026 11:17:55 +0000
Message-ID: <20260223111755.4165135-1-keerthana.kalyanasundaram@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217729-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9029B1756D9
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


