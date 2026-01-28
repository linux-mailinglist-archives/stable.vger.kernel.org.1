Return-Path: <stable+bounces-212356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECYIF8gwemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:52:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE5DA49DE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1132D308C7B5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC1308F1D;
	Wed, 28 Jan 2026 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dTUo26fg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C62EA172;
	Wed, 28 Jan 2026 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615245; cv=none; b=sDE6EMhd4dTc9qUuJcels9skGw02uFsdwC2esWy2s9VGiL+f+1tKFOdCMHpx+wfeOR+z9cFZzLJp1cCalIgObgnCy67WQDZbqf2d1J3krToDPVnerEKgtyGSPTbD2JXXNl8GwfP1vjGweQC0r96XiEXJRKPvjJwaNXBUXS629cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615245; c=relaxed/simple;
	bh=zNbL+W2fDm569IkeMRZq2dPgWTPFz5DHp7ehtEuFI1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo4/Dz+QXKCjrSLRkfiT61lM2cWHvZxLqGTeMa5ZBFhqfpp/Es74aWRKQQkrgeYCSiZf8mUGSNwrzKmimxHG+hcwckmqav40avY1W9jI3ws2OW83hxAoE9DI/s1kvdolLfbsJyWgvfNZCB6ECsUK7tbcBPmZbs7VaEkQq90iHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dTUo26fg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BF0C4CEF7;
	Wed, 28 Jan 2026 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615245;
	bh=zNbL+W2fDm569IkeMRZq2dPgWTPFz5DHp7ehtEuFI1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTUo26fgK7Tc18OFY4bp5S6FkPbW3kxDddSTi2lOqhiEDdt5CwjzT6iURXa3c96Rk
	 N+AWy1feotVOtzh+jYu/l4lek1RIEHeN3GkEmhKOx85RlZ11LO5mXlAjpiYtC2aGZP
	 DNnYOA6By7jOuS8S4q7A1BMr8/+ypdYRxuUH0qos=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Rocco Yue <rocco.yue@mediatek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 079/169] ipv6: annotate data-race in ndisc_router_discovery()
Date: Wed, 28 Jan 2026 16:22:42 +0100
Message-ID: <20260128145336.849640508@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212356-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CAE5DA49DE
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index d961e6c2d09d7..480c906cb374c 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1582,8 +1582,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
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




