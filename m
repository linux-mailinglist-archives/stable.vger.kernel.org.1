Return-Path: <stable+bounces-215920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG6aE6KIjWnq3wAAu9opvQ
	(envelope-from <stable+bounces-215920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:00:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3063512B129
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B10963066BFE
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5901A2C11E5;
	Thu, 12 Feb 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="hmnTMcCG"
X-Original-To: stable@vger.kernel.org
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7272C0F89
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770883206; cv=none; b=oOtz+YpkvxzsH4adADdz6eXB7X4PsocqSRpTUNY/GRsOcWZrwuWkCC5HV1+Y/IUO+NIu+C732UYhTbmaMskMqlv7yHkV9MWpKgkQLMqQdrByNn5NvA0T1bwresVaFbStOmxEfse7W3R6TrqA0iYOuUXWq4oL9savU+Cqm6InKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770883206; c=relaxed/simple;
	bh=cDiJfmK7nejwc3B71L8GKkfgl5K22jlvJ1U8mU/mAoI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BLy1etnEy3q/gtzpwIH6gMUDWzctvnp5NzaWurTsCNEKhOzSumFahMKyiNVohTm1xqV7M8bj46Vc5D3dCtRECwZ9UlAeql3WXQSDFbs8qMd/D3mey3pb+NWdmX+Ba4rKPSsiC+vl2duzKD3cPrScxNxgqjQV6HucQ7sK1kBZJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=hmnTMcCG; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1770883202;
	bh=0eS9CDxrjjb86nc0j8o1OjGATdd8QACo8dcR1z05iL8=;
	h=From:Subject:Date:Message-Id;
	b=hmnTMcCGzrLZrdzU9+ZTZe46vLWcnaCEGvGxr4NoJbegZgF9QGg7fdPLVg7aoC+E8
	 BCheyU+3QmQOBaK7DICupp6ZKmCiJb7g4g2p4tF3iqCJU4VY7iaD5P4YGh4MexfFOv
	 qIKCTYtL4/y49GWsGGs2hQ6a7wJ0gmLUwr3gjrpE=
X-SMAIL-HELO: sina-kernel-team
Received: from unknown (HELO sina-kernel-team)([117.129.7.232])
	by sina.cn (10.54.253.34) with ESMTP
	id 698D88520000101A; Thu, 12 Feb 2026 15:59:17 +0800 (CST)
X-Sender: xnguchen@sina.cn
X-Auth-ID: xnguchen@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=xnguchen@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=xnguchen@sina.cn
X-SMAIL-MID: 5084566291752
X-SMAIL-UIID: CCF59B2A08544A97B879F914C0DD8AA3-20260212-155917-1
From: Chen Yu <xnguchen@sina.cn>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6] tcp: use dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check()
Date: Thu, 12 Feb 2026 15:59:09 +0800
Message-Id: <20260212075909.2952-1-xnguchen@sina.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215920-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[sina.cn];
	FROM_NEQ_ENVFROM(0.00)[xnguchen@sina.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.cn:mid,sina.cn:dkim,sina.cn:email,msgid.link:url]
X-Rspamd-Queue-Id: 3063512B129
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b62a59c18b692f892dcb8109c1c2e653b2abc95c ]

Use RCU to avoid a pair of atomic operations and a potential
UAF on dst_dev()->flags.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-8-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Minor changed due to 6.6 doesn't have
commit:a74fc62eec15 ("ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]") ]
Signed-off-by: Chen Yu <xnguchen@sina.cn>
---
 net/ipv4/tcp_fastopen.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 408985eb74ee..27339cc7342c 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -574,10 +574,11 @@ void tcp_fastopen_active_disable_ofo_check(struct sock *sk)
 		}
 	} else if (tp->syn_fastopen_ch &&
 		   atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_times)) {
-		dst = sk_dst_get(sk);
+		rcu_read_lock();
+		dst = __sk_dst_get(sk);
 		if (!(dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK)))
 			atomic_set(&sock_net(sk)->ipv4.tfo_active_disable_times, 0);
-		dst_release(dst);
+		rcu_read_unlock();
 	}
 }
 
-- 
2.17.1


