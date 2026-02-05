Return-Path: <stable+bounces-214409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMHuKUBMhGm82QMAu9opvQ
	(envelope-from <stable+bounces-214409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:52:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFB6EF9CD
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9983F303DA99
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB035FF42;
	Thu,  5 Feb 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SYfEq2pT"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05C35F8B8
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277858; cv=none; b=UZpIGS9PvXwKn03s9CpdWby+yauMEDYqTwoqT27YLGybgrNpt08mRiz/By234wipguL2WqMLRS3Wiw9bZC4CB3s5M1SHwqlRbskH/3lm/XzNnIQnpkAXsVdc4V1/eGL1gmXTf1P59KM05bdbtePYZGI8xdtbxGAIKP0rEitHAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277858; c=relaxed/simple;
	bh=JyGRnFnWXYKREoWVJoTjnH8Ki9I7rBqgCKkWILXrJ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdPbI+ZWjavHJUCBcfKfIOaLSQOO5amycDCAM//kTZGjcST11Pw22IBavXWxsROgFUsIdS2cTuAd5pGqNwP+0gsXCqdjDVXfq4OnYUsjhQ+TPLLrN0BQYBOl69ScRvdwk7I3ImYt1XItcn33UK4EZFVMO2CEQOcnL98PF+E9ReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SYfEq2pT; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-649c77606f9so93126d50.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 23:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277857; x=1770882657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TSEFqGFDtEPF0mGKcpvzCirZypCr4KunIPUFFgq2YU=;
        b=IKSBmlTYLbnB2RImDjNaNOe2fmMyIjXpytbiBmd5AlglKlyEJqLGl2qJNCEa+865dr
         5QKz86FAEuFUv86tiC6dNIuMat9+WBm9pwoEao5GUhN2JD5acqILURe/nji9FITY/Vmt
         NR6hDc/mtATXCxsNQMJrvaNHIplZTEfA1RjSj+qCM0nq75Jcm3/IUe5TJVaXOQlM6Mlm
         Cn6m1YBfHRy0/Rhg+rWvpIQ4BGzIXZUZ++6KzqrPRCejg4A7e3/fDgouyiSH6ahOoChA
         VHMHOb9/fL+29C5ipqpc4lX/SZabTW73aLnSOqZ5b8TZa5czC4qah7pT25aZA7pXgs2M
         XgYA==
X-Gm-Message-State: AOJu0Yx2Xqilf60TmtaB6ry+KWs4PD15WCYM4g5kKou2WUw//4zl+oc7
	8vpxLpWcI7WUuCRxV6IYwnZk24631Da40l2afKFcZ8cFMADgeoxtAihp3JTYxePVc8d+NGhE6e6
	Xv2Jc/G5vbhb8BXQxCEGpOWduO1j8qGGMgB2Qj7FZZ3cLPjoFcoDUOUjLWoE0KREfDcRik7mRqK
	2V9jcYdQCcUBtaOEE3S3hUE9AKkcmbZJ8TxuDpbQfnTxxjXJn/OcPZWBvIjnoHbX8oNJJDXR30p
	zgA5A3G+HIsLVB1MEsGD3lKZrgicWk=
X-Gm-Gg: AZuq6aLaVZYQW28qOxOW4umCKsxjYuzs1Z+N2SgYvmsuiqJJhPKFxvf/W87xDwPy8Ri
	xt5FkfRX4nfTeZvP4A97z/G8EMD+thILqITdkbVCnDi7X/1+Unjm1OD/auWmeLeUbHfo53TkcAp
	eOmMsm7oLV33BEIAkH7oPInhK8fUknPxCJ+4NsId/ofoOssxsucunL7VfcgI+2CxHpCQhQgtd6C
	GMwAMuH10FxmdyAcd36/YyJfFGiWjapGk2w/6kmfFSHruVpnud6NSN7xy6aX1skBOHk5m3Ham7k
	9uiIJ21T1O9UrjDko86Tkx4Dw7fTEXT/26xaNECwLHpQArR/xkaCKcPYlIFOlc8YIuqTIp9dJRJ
	1bCuSNhkMy5DBGX2n5lt45xNbxeVdBGe1yWMSav24z8gImwaxIphjmDV+Nw+xT1mwhdgVvW7vhT
	wqbaTJdqeGvRsET9NVl1gtPQTOKPY2q+Cm6P3peGBDIdw0YzKyOAHMXfoPm0A=
X-Received: by 2002:a05:690c:1e:b0:794:c0c7:43e8 with SMTP id 00721157ae682-79501fd4a77mr34615787b3.3.1770277857186;
        Wed, 04 Feb 2026 23:50:57 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-794fee9a0dbsm2247537b3.11.2026.02.04.23.50.56
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:50:57 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b796c874a9so27080eec.2
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 23:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770277855; x=1770882655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TSEFqGFDtEPF0mGKcpvzCirZypCr4KunIPUFFgq2YU=;
        b=SYfEq2pTMsYznxj/Te7raCN+W7usL29BRXO1urFFPPwvLfYkiaY2W2Ik0l1S60TW3n
         Nm7DBxQd6rhHctK4aHdwJf+KG+aw0ZhX/WnJwhUn/vCkvtEJJ5sTnHvutK87QeIVH3cG
         84n1jOpzu13zQiQqNZb4ZCOaZeGMpuIXoCkxw=
X-Received: by 2002:a05:7022:50e:b0:119:e56a:4fff with SMTP id a92af1059eb24-126f60ba802mr1109952c88.4.1770277855340;
        Wed, 04 Feb 2026 23:50:55 -0800 (PST)
X-Received: by 2002:a05:7022:50e:b0:119:e56a:4fff with SMTP id a92af1059eb24-126f60ba802mr1109932c88.4.1770277854649;
        Wed, 04 Feb 2026 23:50:54 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e10935sm3383959c88.6.2026.02.04.23.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:50:53 -0800 (PST)
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
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10-v5.15 ] ipv6: use RCU in ip6_xmit()
Date: Thu,  5 Feb 2026 07:46:44 +0000
Message-ID: <20260205074644.2091266-1-keerthana.kalyanasundaram@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-214409-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0EFB6EF9CD
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


