Return-Path: <stable+bounces-214410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH+EH51MhGm82QMAu9opvQ
	(envelope-from <stable+bounces-214410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:54:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03034EF9F4
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EAFA3039CB8
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 07:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3528360727;
	Thu,  5 Feb 2026 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dKV+Ih1+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537135FF60
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277898; cv=none; b=BM5I6EhxtAajPiC6Kv/cZg32UY/wNZV9wPNGb0x+5zFong1NOHO84dWVktPUPTKAnAqKUYK2b4N3WYvDpouhT0pIMsaXm8nvuv9Bcj3s9Mqn9XLI2f70kIEkM78XhLr8wqitsOmntjIIftG8dKUJoxQOgYAXYhTnZNH27NpXIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277898; c=relaxed/simple;
	bh=tdJMXTTIfYvuzZKJx1Ev9/Jj2HH5TbX6pMoSiVeoY5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2Z4clB9hixV03sc2JDTVnNr7Q+A7HKWlxg04VpjbVNm8Qd0QfNojro/IxBjOqlvLmLVBl03Bl5jb9OfB0dT28e7Sc32wOC/9xRGwfhSSOjokrpQqGxJDIYjDROxOy6IhnQdBtG9XY3/eOLWaoCucpS1aEAC9ahtxMv0ehY9xXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dKV+Ih1+; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7d189de4577so93348a34.2
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 23:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277897; x=1770882697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDNp96WCVrv/qI9QGPf7v2+3I3uNz6J8WTAmDy+jP8g=;
        b=JqpUZWmb8fFs3V4Fls09EuEknwwQb1DECiDVK3f9nWEUU2rFuSLjgQDOpj7H7zxxi4
         klJkhPCq3wMILglSPd5+a9sS7FlYX8DGIUNmu+QmC/vCbMPWLkOYGVydGTOcIXK+W5a+
         eUozOG5L42ozgVDnuL+26AGC6lx2TS0tHETyAGhaVIM/MS2PCMvgPVeAQtEQ4vXTvIB6
         tTtxOewBQjPcpjlDlDILNpiZdx9YBn9kaAw3P40ExeV0UuPuINIbdK1+9Qrtxl39qU6D
         AiijtxsgOoefZ11M94pJgN0w7RcdlykFWOFrtR0a0m9RBHe7x2AhYuxXox28EeQxniPc
         E9Hw==
X-Gm-Message-State: AOJu0YxcULnUcXMTtxS5PBF6JOHJKQV0o3baWo1SPMy5kiTLMRyBAbWC
	R/WEAAtxMlENN+Ux5g9mqnZuMfnm1Iw1od8V498LQaYuLimnnvT4hShkGidBnMVP+VRs3B25uLy
	MAdmChPt7klCuyU8hcXhd5Iceav9UEBFClGBbBdkHB7Ii2Aax/weKWLOb5otS+Ah21pyaRGTdjW
	VazV01WF8s6tQQ31VmZj9sLOs58NhqtxFBH4TrE7daAUuTqzF1a63sOnb+GZYiJXvAD1aHxUeLb
	QEe4AaguFZvS6u5kgXmBT/PfTg9
X-Gm-Gg: AZuq6aLduIoE8rcLUqOT+2ELuKwY78u0hc0qIDz78802foqA15nDYqSPPeiav86PuZ8
	d3iFJn89via6CJ0l3x311e2m2Qn0NNo0+w62Av50R+anMw1YOxVz2INcF1ZF6/wAd4BHz4IMuyO
	TnYU69nDKR19NpSnKldBpIP07sEILOqalarR+hrDws/cBtwHS/MMWU6ddOcwVzik90Rxf1WNDub
	Knkw0IkDiRznOy5IqUcNHRBBhcWEaUWmlFYiIJJMSG8/Mf3vn8suujyA+gM1wQBAI5nywlBnVFQ
	ZkMnCHhCwiXPVxHxmnR+mSGbnnaY+j1CSFRSoz1WMglx8/jCnEqy9wapE8feWHtDvWKI9VS5ENa
	nVGXOggcrTisCrMjI36M25FxkaK4egnEzeVK1I2Cv6/LXKnweujpMmES+pnWCnP86Ds/uH7N3BG
	TRKWr1WCPTXvEjVSecVrZQPsLh07F02OxbaXWhlHI2g9984q921ke2WGdbGKg=
X-Received: by 2002:a05:6871:823:b0:3fd:c70c:3f0b with SMTP id 586e51a60fabf-40a5bd9dc17mr2364086fac.1.1770277897254;
        Wed, 04 Feb 2026 23:51:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-40a5447ec99sm509688fac.12.2026.02.04.23.51.36
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:51:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b82b2635e5so22470eec.3
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 23:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770277894; x=1770882694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDNp96WCVrv/qI9QGPf7v2+3I3uNz6J8WTAmDy+jP8g=;
        b=dKV+Ih1+iDcYcHcdpSr/0vpzNupqNUsXCVlUzipa6orFmxAUcmLAa+0ulk6pf4jqK9
         c1sn+JRqhzi1IOh5Ys9vXRFoVchJCvHDUnZbcjPzG9S1POysEdmALN32cvHx4YQMcobS
         QRi8btgUTICxxTfiJ3qySCNkoXKiBoAF1mpCk=
X-Received: by 2002:a05:7300:5794:b0:2ab:ca55:8940 with SMTP id 5a478bee46e88-2b837421026mr955942eec.7.1770277893975;
        Wed, 04 Feb 2026 23:51:33 -0800 (PST)
X-Received: by 2002:a05:7300:5794:b0:2ab:ca55:8940 with SMTP id 5a478bee46e88-2b837421026mr955927eec.7.1770277893210;
        Wed, 04 Feb 2026 23:51:33 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e4cd26sm3047244eec.12.2026.02.04.23.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:51:32 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
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
Subject: [PATCH v6.1-v6.12 ] ipv6: use RCU in ip6_xmit()
Date: Thu,  5 Feb 2026 07:47:22 +0000
Message-ID: <20260205074722.2091297-1-keerthana.kalyanasundaram@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-214410-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
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
X-Rspamd-Queue-Id: 03034EF9F4
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


