Return-Path: <stable+bounces-227877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IAsGWeowGm6JgQAu9opvQ
	(envelope-from <stable+bounces-227877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 03:41:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F08412EBF90
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 03:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69C3300877C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 02:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B2C248166;
	Mon, 23 Mar 2026 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="TO0MjWsd"
X-Original-To: stable@vger.kernel.org
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC522B8AB
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233660; cv=none; b=m8f1SppO231up+R4PTvJQUw3drcHRA+qLhkSD3+fbU8JZ3npaY0638zY65IB4UV0cI9Thq31lqgHWhnKMvs1WYOnfzsK9APD/lh2meh2HgxVIx3FsHQRLQVnoe8+Gw7wvDfVtbO2gucjdn896UOLG1gjsmtmYCMnuR6c/kPLcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233660; c=relaxed/simple;
	bh=hglrARk+G4S1A9SIvuYIKMOw6G8JyaErvJJVq79ULzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tIKSl7xSUpTae6FcWPkEVFiA84/y/gxobjJhx/ql46xKXpD4gPy5R3AOHHmyYpLxOUz0BqbkCX8FhdzVjSwgeGTCl4E7hEI7n3iFVBPjED2sh4VNIh3odJ5iXBLUC1uHrJhiFqXGO/W7HHcN1emIzjDNbVjVRwIzN2he7BpKL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=TO0MjWsd; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1774233653;
	bh=6y/PzUO23BdXJACJHrA53tpnwFYEb82yoDUp59wM7q4=;
	h=From:Subject:Date:Message-Id;
	b=TO0MjWsdF5gdQyJeF5be7yXJLXXvM8skY+SAnOwVHD8ttq6rU72Wa9n7/WpJuLvKY
	 4tdSKcm77CRdQOALePLcS0QzYp3D1SJV23I55+QFj4RamiVA3vak4a+rrG2ED2Xq7o
	 9nkauicTR03nRroeU9lzUr8pQSvo2SCsub0Wn25g=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.21) with ESMTP
	id 69C0A80B000003B8; Mon, 23 Mar 2026 10:40:14 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 1703113408658
X-SMAIL-UIID: BDE1985B73A3483CB67EC241A8A3DFC3-20260323-104014-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemb@google.com>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 6.1.y] net: clear the dst when changing skb protocol
Date: Mon, 23 Mar 2026 10:40:06 +0800
Message-Id: <20260323024006.1764018-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,iogearbox.net,sina.com];
	TAGGED_FROM(0.00)[bounces-227877-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,iogearbox.net:email]
X-Rspamd-Queue-Id: F08412EBF90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit ba9db6f907ac02215e30128770f85fbd7db2fcf9 ]

A not-so-careful NAT46 BPF program can crash the kernel
if it indiscriminately flips ingress packets from v4 to v6:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
    ip6_rcv_core (net/ipv6/ip6_input.c:190:20)
    ipv6_rcv (net/ipv6/ip6_input.c:306:8)
    process_backlog (net/core/dev.c:6186:4)
    napi_poll (net/core/dev.c:6906:9)
    net_rx_action (net/core/dev.c:7028:13)
    do_softirq (kernel/softirq.c:462:3)
    netif_rx (net/core/dev.c:5326:3)
    dev_loopback_xmit (net/core/dev.c:4015:2)
    ip_mc_finish_output (net/ipv4/ip_output.c:363:8)
    NF_HOOK (./include/linux/netfilter.h:314:9)
    ip_mc_output (net/ipv4/ip_output.c:400:5)
    dst_output (./include/net/dst.h:459:9)
    ip_local_out (net/ipv4/ip_output.c:130:9)
    ip_send_skb (net/ipv4/ip_output.c:1496:8)
    udp_send_skb (net/ipv4/udp.c:1040:8)
    udp_sendmsg (net/ipv4/udp.c:1328:10)

The output interface has a 4->6 program attached at ingress.
We try to loop the multicast skb back to the sending socket.
Ingress BPF runs as part of netif_rx(), pushes a valid v6 hdr
and changes skb->protocol to v6. We enter ip6_rcv_core which
tries to use skb_dst(). But the dst is still an IPv4 one left
after IPv4 mcast output.

Clear the dst in all BPF helpers which change the protocol.
Try to preserve metadata dsts, those may carry non-routing
metadata.

Cc: stable@vger.kernel.org
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Fixes: d219df60a70e ("bpf: Add ipip6 and ip6ip decap support for bpf_skb_adjust_room()")
Fixes: 1b00e0dfe7d0 ("bpf: update skb->protocol in bpf_skb_net_grow")
Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20250610001245.1981782-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ The context change is due to the commit d219df60a70e
("bpf: Add ipip6 and ip6ip decap support for bpf_skb_adjust_room()")
in v6.3 which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 net/core/filter.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index c177e40e7077..5360fef468b7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3232,6 +3232,13 @@ static const struct bpf_func_proto bpf_skb_vlan_pop_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
+static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
+{
+	skb->protocol = htons(proto);
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+}
+
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
 	/* Caller already did skb_cow() with len as headroom,
@@ -3328,7 +3335,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 		}
 	}
 
-	skb->protocol = htons(ETH_P_IPV6);
+	bpf_skb_change_protocol(skb, ETH_P_IPV6);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3358,7 +3365,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
 		}
 	}
 
-	skb->protocol = htons(ETH_P_IP);
+	bpf_skb_change_protocol(skb, ETH_P_IP);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3545,10 +3552,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		/* Match skb->protocol to new outer l3 protocol */
 		if (skb->protocol == htons(ETH_P_IP) &&
 		    flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
-			skb->protocol = htons(ETH_P_IPV6);
+			bpf_skb_change_protocol(skb, ETH_P_IPV6);
 		else if (skb->protocol == htons(ETH_P_IPV6) &&
 			 flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
-			skb->protocol = htons(ETH_P_IP);
+			bpf_skb_change_protocol(skb, ETH_P_IP);
 	}
 
 	if (skb_is_gso(skb)) {
-- 
2.34.1


