Return-Path: <stable+bounces-154368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1A1ADD9D2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C3019E5A88
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16802DFF0B;
	Tue, 17 Jun 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aGc+4W6d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B12FA65D;
	Tue, 17 Jun 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178971; cv=none; b=dhjlpELrs4L4EAhBB+JxsOizQQrzOzdIUwyPrnNOciK7EBgqvCax7tURhf4NkdHpZRRw47JoeWrcALKL6SSq6zs2w8UsLCJXLZRJNDC2Sdi7XEx3y9NabAuJlE2Xe7vVGvqag596uOCxvwehYl4qtHb+5Cs7lXtFTNDmwwndCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178971; c=relaxed/simple;
	bh=6606mQYbC17H9PL1cE/rOjGbEjhS/105n3VfS2otA9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbDSjiapC4GLOGlppvSknNQVo2vxeO11Q1sAHzzVgoZBBd0VO5L8KqfeXx06nKlVqrF0YUmW7dAJxOFw0YueRu9Uh3Qz8n9ckjtsr/aPWZXKOseI78brollB2+ntJoGG3M3TpLjFUvZkVPmWl8JhQNG1hp5edWbOg8KnYgPXaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aGc+4W6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4C1C4CEE7;
	Tue, 17 Jun 2025 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178971;
	bh=6606mQYbC17H9PL1cE/rOjGbEjhS/105n3VfS2otA9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGc+4W6dQkddT+EV0APK2ACYrjPtztSbZwPy9agSJk12qVzZjuZtDwkgNIC59Qyou
	 Z2vtaZlgmPGNni5bNGMRb7Iv9hOjUTQ6UVIAR2Oi76PslCj2wq5jv4/YhzQ7rbSJ/b
	 i9Q8FZZ1Klllezgz8960TfA3pKNyqNjcelXaY0mM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 579/780] net: Fix checksum update for ILA adj-transport
Date: Tue, 17 Jun 2025 17:24:47 +0200
Message-ID: <20250617152515.063247026@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Chaignon <paul.chaignon@gmail.com>

[ Upstream commit 6043b794c7668c19dabc4a93c75b924a19474d59 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/checksum.h    | 2 +-
 net/core/filter.c         | 2 +-
 net/core/utils.c          | 4 ++--
 net/ipv6/ila/ila_common.c | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/checksum.h b/include/net/checksum.h
index 243f972267b8d..be9356d4b67a1 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -164,7 +164,7 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
 			       const __be32 *from, const __be32 *to,
 			       bool pseudohdr);
 void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
-				     __wsum diff, bool pseudohdr);
+				     __wsum diff, bool pseudohdr, bool ipv6);
 
 static __always_inline
 void inet_proto_csum_replace2(__sum16 *sum, struct sk_buff *skb,
diff --git a/net/core/filter.c b/net/core/filter.c
index 577a4504e26fa..3c93765742c9c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1987,7 +1987,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 		if (unlikely(from != 0))
 			return -EINVAL;
 
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
+		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
 		break;
 	case 2:
 		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
diff --git a/net/core/utils.c b/net/core/utils.c
index 27f4cffaae05d..b8c21a859e27b 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -473,11 +473,11 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
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
diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
index 95e9146918cc6..b8d43ed4689db 100644
--- a/net/ipv6/ila/ila_common.c
+++ b/net/ipv6/ila/ila_common.c
@@ -86,7 +86,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&th->check, skb,
-							diff, true);
+							diff, true, true);
 		}
 		break;
 	case NEXTHDR_UDP:
@@ -97,7 +97,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
 				diff = get_csum_diff(ip6h, p);
 				inet_proto_csum_replace_by_diff(&uh->check, skb,
-								diff, true);
+								diff, true, true);
 				if (!uh->check)
 					uh->check = CSUM_MANGLED_0;
 			}
@@ -111,7 +111,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
-							diff, true);
+							diff, true, true);
 		}
 		break;
 	}
-- 
2.39.5




