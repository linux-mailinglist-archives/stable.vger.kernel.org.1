Return-Path: <stable+bounces-157995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B3AE567E
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045491C21DCB
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AB02192EC;
	Mon, 23 Jun 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KBDJYZLT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461D19F120;
	Mon, 23 Jun 2025 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717227; cv=none; b=gzBRej9QtBbKSP0DlqAFG+e8AN2DkMRs/TDBH44x7n1HvBR052sF/cOzgOx2Gutut3ODS+WpCk8RynhAD0sxJF85Fj/bzD9ypLodyCGYgwPdqV/AAr+xOD6F7kmffo8dVjNtUgKStFnKopQ6zPrJsEzavoYKWRsCSADPvsgBZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717227; c=relaxed/simple;
	bh=HQUJOfGtfN19qQ8fv+E8ZMaJ/CfkaVxfcj/buqQbvc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgBcMU8KHN+XuGFvsI/uM60qltYaD7Yc9gyZPPP/PGNLSRCFqNNwKg92fSiZZbw/PWVltYHsPtB57FAx1NCkYDYatZZHFVTUb4LwoF7HBHGozguRbhUH2CFhvpKy9o1L0EseaSHfJA9S37hiigVqLuBvtqs4RiR5YGn+zZBIyqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KBDJYZLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A20C4CEEA;
	Mon, 23 Jun 2025 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717226;
	bh=HQUJOfGtfN19qQ8fv+E8ZMaJ/CfkaVxfcj/buqQbvc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBDJYZLT8qCh+Kr/uYX2x3zTRHoOpwiLVLa0Xo2KV0qSBh+0EaVE9HkKIWr7dAJqC
	 35GwUZ2bo17kWp/4wZnMv/DZjF1xAKSDBGgOKl2S23uBvV6zvUZqmMdJy9OGU9JoIL
	 LKKcDQvHs+lgmv4efmOzVxAD1WtAZjKGo6XnV5eA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 342/414] net: Fix checksum update for ILA adj-transport
Date: Mon, 23 Jun 2025 15:07:59 +0200
Message-ID: <20250623130650.529992392@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Chaignon <paul.chaignon@gmail.com>

commit 6043b794c7668c19dabc4a93c75b924a19474d59 upstream.

During ILA address translations, the L4 checksums can be handled in
different ways. One of them, adj-transport, consist in parsing the
transport layer and updating any found checksum. This logic relies on
inet_proto_csum_replace_by_diff and produces an incorrect skb->csum when
in state CHECKSUM_COMPLETE.

This bug can be reproduced with a simple ILA to SIR mapping, assuming
packets are received with CHECKSUM_COMPLETE:

  $ ip a show dev eth0
  14: eth0@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
      link/ether 62:ae:35:9e:0f:8d brd ff:ff:ff:ff:ff:ff link-netnsid 0
      inet6 3333:0:0:1::c078/64 scope global
         valid_lft forever preferred_lft forever
      inet6 fd00:10:244:1::c078/128 scope global nodad
         valid_lft forever preferred_lft forever
      inet6 fe80::60ae:35ff:fe9e:f8d/64 scope link proto kernel_ll
         valid_lft forever preferred_lft forever
  $ ip ila add loc_match fd00:10:244:1 loc 3333:0:0:1 \
      csum-mode adj-transport ident-type luid dev eth0

Then I hit [fd00:10:244:1::c078]:8000 with a server listening only on
[3333:0:0:1::c078]:8000. With the bug, the SYN packet is dropped with
SKB_DROP_REASON_TCP_CSUM after inet_proto_csum_replace_by_diff changed
skb->csum. The translation and drop are visible on pwru [1] traces:

  IFACE   TUPLE                                                        FUNC
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ipv6_rcv
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ip6_rcv_core
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  nf_hook_slow
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  inet_proto_csum_replace_by_diff
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_early_demux
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_route_input
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input_finish
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_protocol_deliver_rcu
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     raw6_local_deliver
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ipv6_raw_deliver
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_rcv
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     __skb_checksum_complete
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skb_reason(SKB_DROP_REASON_TCP_CSUM)
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_head_state
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_data
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_free_head
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skbmem

This is happening because inet_proto_csum_replace_by_diff is updating
skb->csum when it shouldn't. The L4 checksum is updated such that it
"cancels" the IPv6 address change in terms of checksum computation, so
the impact on skb->csum is null.

Note this would be different for an IPv4 packet since three fields
would be updated: the IPv4 address, the IP checksum, and the L4
checksum. Two would cancel each other and skb->csum would still need
to be updated to take the L4 checksum change into account.

This patch fixes it by passing an ipv6 flag to
inet_proto_csum_replace_by_diff, to skip the skb->csum update if we're
in the IPv6 case. Note the behavior of the only other user of
inet_proto_csum_replace_by_diff, the BPF subsystem, is left as is in
this patch and fixed in the subsequent patch.

With the fix, using the reproduction from above, I can confirm
skb->csum is not touched by inet_proto_csum_replace_by_diff and the TCP
SYN proceeds to the application after the ILA translation.

Link: https://github.com/cilium/pwru [1]
Fixes: 65d7ab8de582 ("net: Identifier Locator Addressing module")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://patch.msgid.link/b5539869e3550d46068504feb02d37653d939c0b.1748509484.git.paul.chaignon@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/checksum.h    |    2 +-
 net/core/filter.c         |    2 +-
 net/core/utils.c          |    4 ++--
 net/ipv6/ila/ila_common.c |    6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -158,7 +158,7 @@ void inet_proto_csum_replace16(__sum16 *
 			       const __be32 *from, const __be32 *to,
 			       bool pseudohdr);
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr);
+				     __wsum diff, bool pseudohdr, bool ipv6);
 
 static __always_inline
 void inet_proto_csum_replace2(__sum16 *sum, struct sk_buff *skb,
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1999,7 +1999,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct s
 		if (unlikely(from != 0))
 			return -EINVAL;
 
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
+		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
 		break;
 	case 2:
 		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -473,11 +473,11 @@ void inet_proto_csum_replace16(__sum16 *
 EXPORT_SYMBOL(inet_proto_csum_replace16);
 
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr)
+				     __wsum diff, bool pseudohdr, bool ipv6)
 {
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		csum_replace_by_diff(sum, diff);
-		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
+		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr && !ipv6)
 			skb->csum = ~csum_sub(diff, skb->csum);
 	} else if (pseudohdr) {
 		*sum = ~csum_fold(csum_add(diff, csum_unfold(*sum)));
--- a/net/ipv6/ila/ila_common.c
+++ b/net/ipv6/ila/ila_common.c
@@ -86,7 +86,7 @@ static void ila_csum_adjust_transport(st
 
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&th->check, skb,
-							diff, true);
+							diff, true, true);
 		}
 		break;
 	case NEXTHDR_UDP:
@@ -97,7 +97,7 @@ static void ila_csum_adjust_transport(st
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
 				diff = get_csum_diff(ip6h, p);
 				inet_proto_csum_replace_by_diff(&uh->check, skb,
-								diff, true);
+								diff, true, true);
 				if (!uh->check)
 					uh->check = CSUM_MANGLED_0;
 			}
@@ -111,7 +111,7 @@ static void ila_csum_adjust_transport(st
 
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
-							diff, true);
+							diff, true, true);
 		}
 		break;
 	}



