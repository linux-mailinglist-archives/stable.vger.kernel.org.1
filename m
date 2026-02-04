Return-Path: <stable+bounces-213894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFIvLpdkg2l1mQMAu9opvQ
	(envelope-from <stable+bounces-213894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:24:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D73E8719
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9883095C83
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD634218A1;
	Wed,  4 Feb 2026 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xgam0dkh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44962C026F;
	Wed,  4 Feb 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217869; cv=none; b=eR9vgvK1eDz57RoNMREwpYXytsgffEwvVuolurLS7IvWA7dD+KLJzXTAzJJdSVEihs/76x2m0VPiNBKmJGGk5coeRwgeqWqgYFF2pzxknO7xQDwiyTlkrr34FTW1IwI0/zaZquz93yp0hzCEHEzeY2pjdcHQnpgnaLznqyjXR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217869; c=relaxed/simple;
	bh=9/G2++abNGG+3JPzr8a0Qmvq2jzIYVEKRep9gwny0GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP5GiP/JMDWKXTKqSOSKgt3jia9QOq64kZVZI4yJu9ZXlRv7uIg4Tqg9PitR7jfYpcvJ7+/QA8j3aqaSwTlGEqvJnJfRl4Sbkb2to3fGySBYIeV7uRgFoeNfRfgBPCVLP53+3cSpZHgIJkCfkDbxNyzVyPMjLtelCh3HWaNh3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xgam0dkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D96C4CEF7;
	Wed,  4 Feb 2026 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217868;
	bh=9/G2++abNGG+3JPzr8a0Qmvq2jzIYVEKRep9gwny0GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xgam0dkhIGi6iGiMxzHcz7fAnrGiNZrhcjLrVxBypSb1it9C3QktL0RddHcXZnEuM
	 ZhBsy8kSG3eQggAv+1xwKBbEx4ZUbVNWZJ4YcfzFDRZvNbLKJ/eaQtGkKDnRTimlI1
	 QpyZLNQO1q1p9IYfGs8C3Bi4ODwQigh5BVAO5GHk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Rocco Yue <rocco.yue@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 143/280] ipv6: annotate data-race in ndisc_router_discovery()
Date: Wed,  4 Feb 2026 15:38:37 +0100
Message-ID: <20260204143914.782071219@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213894-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,googlegroups.com:email,mediatek.com:email]
X-Rspamd-Queue-Id: 37D73E8719
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9a063f96d87efc3a6cc667f8de096a3d38d74bb5 ]

syzbot found that ndisc_router_discovery() could read and write
in6_dev->ra_mtu without holding a lock [1]

This looks fine, IFLA_INET6_RA_MTU is best effort.

Add READ_ONCE()/WRITE_ONCE() to document the race.

Note that we might also reject illegal MTU values
(mtu < IPV6_MIN_MTU || mtu > skb->dev->mtu) in a future patch.

[1]
BUG: KCSAN: data-race in ndisc_router_discovery / ndisc_router_discovery

read to 0xffff888119809c20 of 4 bytes by task 25817 on cpu 1:
  ndisc_router_discovery+0x151d/0x1c90 net/ipv6/ndisc.c:1558
  ndisc_rcv+0x2ad/0x3d0 net/ipv6/ndisc.c:1841
  icmpv6_rcv+0xe5a/0x12f0 net/ipv6/icmp.c:989
  ip6_protocol_deliver_rcu+0xb2a/0x10d0 net/ipv6/ip6_input.c:438
  ip6_input_finish+0xf0/0x1d0 net/ipv6/ip6_input.c:489
  NF_HOOK include/linux/netfilter.h:318 [inline]
  ip6_input+0x5e/0x140 net/ipv6/ip6_input.c:500
  ip6_mc_input+0x27c/0x470 net/ipv6/ip6_input.c:590
  dst_input include/net/dst.h:474 [inline]
  ip6_rcv_finish+0x336/0x340 net/ipv6/ip6_input.c:79
...

write to 0xffff888119809c20 of 4 bytes by task 25816 on cpu 0:
  ndisc_router_discovery+0x155a/0x1c90 net/ipv6/ndisc.c:1559
  ndisc_rcv+0x2ad/0x3d0 net/ipv6/ndisc.c:1841
  icmpv6_rcv+0xe5a/0x12f0 net/ipv6/icmp.c:989
  ip6_protocol_deliver_rcu+0xb2a/0x10d0 net/ipv6/ip6_input.c:438
  ip6_input_finish+0xf0/0x1d0 net/ipv6/ip6_input.c:489
  NF_HOOK include/linux/netfilter.h:318 [inline]
  ip6_input+0x5e/0x140 net/ipv6/ip6_input.c:500
  ip6_mc_input+0x27c/0x470 net/ipv6/ip6_input.c:590
  dst_input include/net/dst.h:474 [inline]
  ip6_rcv_finish+0x336/0x340 net/ipv6/ip6_input.c:79
...

value changed: 0x00000000 -> 0xe5400659

Fixes: 49b99da2c9ce ("ipv6: add IFLA_INET6_RA_MTU to expose mtu value")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Rocco Yue <rocco.yue@mediatek.com>
Link: https://patch.msgid.link/20260118152941.2563857-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ndisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 1a6408a24d21c..affbf12d44f57 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1572,8 +1572,8 @@ static void ndisc_router_discovery(struct sk_buff *skb)
 		memcpy(&n, ((u8 *)(ndopts.nd_opts_mtu+1))+2, sizeof(mtu));
 		mtu = ntohl(n);
 
-		if (in6_dev->ra_mtu != mtu) {
-			in6_dev->ra_mtu = mtu;
+		if (READ_ONCE(in6_dev->ra_mtu) != mtu) {
+			WRITE_ONCE(in6_dev->ra_mtu, mtu);
 			send_ifinfo_notify = true;
 		}
 
-- 
2.51.0




