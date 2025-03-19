Return-Path: <stable+bounces-125191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D6CA69240
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC41B871A1
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC5213232;
	Wed, 19 Mar 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UwPmIiaw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BFA1DFDB8;
	Wed, 19 Mar 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395018; cv=none; b=grxuwE2fMgkDiocAp/8aOuDL30EMdBXLLR8iVUmeMUIGPkky3z/8tRLtIUbBeNhWxxm4qRMMujK5t9Ymx3qoGON7oV0AD/uWswAbenUjMAaYoUy0j7J/QeW0NKcYpBajJ5gki/3T/GUaY30fVbzy1HRKaCY9JfoftSXfpHQDYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395018; c=relaxed/simple;
	bh=9ER5j6Bh2Gs66JrZjvOca0fPR+MCh+wvZQ2F9+SbveU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJRDPiqQqfkFKgdfonVEk9vSim/RHi5yiS7xkUcAzuEZA0Rd3E14jZ7ID5+z5IXsUE8riBmCcIwS++0aul6L6KVCSssUspaz8tk85/w7bA5AvNP0SHXSLvMJa9dyh7QF+Xq8VY0MgA+Kdyj/jYUJEirzcz3f1wvC1t1EBTyCb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UwPmIiaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086BCC4CEE8;
	Wed, 19 Mar 2025 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395018;
	bh=9ER5j6Bh2Gs66JrZjvOca0fPR+MCh+wvZQ2F9+SbveU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UwPmIiawIfAN8QEBJ/qDYz7J8O29QlVA2oXD5xajUwgBc0M+drhH8F0hHu23qebY6
	 8uVlpjUXkfF0IhRi1JF5ajW799DauUFJo0JVKrIjZhWNk3KiM/QjFH6zxDZuci8n6R
	 jV+oCRCuLU64LWLfFM7tUgdL2y6yqH6PPPf96pN8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taehee Yoo <ap420073@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 030/231] eth: bnxt: fix truesize for mb-xdp-pass case
Date: Wed, 19 Mar 2025 07:28:43 -0700
Message-ID: <20250319143027.563469189@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
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

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 9f7b2aa5034e24d3c49db73d5f760c0435fe31c2 ]

When mb-xdp is set and return is XDP_PASS, packet is converted from
xdp_buff to sk_buff with xdp_update_skb_shared_info() in
bnxt_xdp_build_skb().
bnxt_xdp_build_skb() passes incorrect truesize argument to
xdp_update_skb_shared_info().
The truesize is calculated as BNXT_RX_PAGE_SIZE * sinfo->nr_frags but
the skb_shared_info was wiped by napi_build_skb() before.
So it stores sinfo->nr_frags before bnxt_xdp_build_skb() and use it
instead of getting skb_shared_info from xdp_get_shared_info_from_buff().

Splat looks like:
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 0 at net/core/skbuff.c:6072 skb_try_coalesce+0x504/0x590
 Modules linked in: xt_nat xt_tcpudp veth af_packet xt_conntrack nft_chain_nat xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_coms
 CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 6.14.0-rc2+ #3
 RIP: 0010:skb_try_coalesce+0x504/0x590
 Code: 4b fd ff ff 49 8b 34 24 40 80 e6 40 0f 84 3d fd ff ff 49 8b 74 24 48 40 f6 c6 01 0f 84 2e fd ff ff 48 8d 4e ff e9 25 fd ff ff <0f> 0b e99
 RSP: 0018:ffffb62c4120caa8 EFLAGS: 00010287
 RAX: 0000000000000003 RBX: ffffb62c4120cb14 RCX: 0000000000000ec0
 RDX: 0000000000001000 RSI: ffffa06e5d7dc000 RDI: 0000000000000003
 RBP: ffffa06e5d7ddec0 R08: ffffa06e6120a800 R09: ffffa06e7a119900
 R10: 0000000000002310 R11: ffffa06e5d7dcec0 R12: ffffe4360575f740
 R13: ffffe43600000000 R14: 0000000000000002 R15: 0000000000000002
 FS:  0000000000000000(0000) GS:ffffa0755f700000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f147b76b0f8 CR3: 00000001615d4000 CR4: 00000000007506f0
 PKRU: 55555554
 Call Trace:
  <IRQ>
  ? __warn+0x84/0x130
  ? skb_try_coalesce+0x504/0x590
  ? report_bug+0x18a/0x1a0
  ? handle_bug+0x53/0x90
  ? exc_invalid_op+0x14/0x70
  ? asm_exc_invalid_op+0x16/0x20
  ? skb_try_coalesce+0x504/0x590
  inet_frag_reasm_finish+0x11f/0x2e0
  ip_defrag+0x37a/0x900
  ip_local_deliver+0x51/0x120
  ip_sublist_rcv_finish+0x64/0x70
  ip_sublist_rcv+0x179/0x210
  ip_list_rcv+0xf9/0x130

How to reproduce:
<Node A>
ip link set $interface1 xdp obj xdp_pass.o
ip link set $interface1 mtu 9000 up
ip a a 10.0.0.1/24 dev $interface1
<Node B>
ip link set $interfac2 mtu 9000 up
ip a a 10.0.0.2/24 dev $interface2
ping 10.0.0.1 -s 65000

Following ping.py patch adds xdp-mb-pass case. so ping.py is going to be
able to reproduce this issue.

Fixes: 1dc4c557bfed ("bnxt: adding bnxt_xdp_build_skb to build skb from multibuffer xdp_buff")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Link: https://patch.msgid.link/20250309134219.91670-2-ap420073@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 8 ++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 603e9c968c44b..39a5ea4d3b4ea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2025,6 +2025,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	struct rx_cmp_ext *rxcmp1;
 	u32 tmp_raw_cons = *raw_cons;
 	u16 cons, prod, cp_cons = RING_CMP(tmp_raw_cons);
+	struct skb_shared_info *sinfo;
 	struct bnxt_sw_rx_bd *rx_buf;
 	unsigned int len;
 	u8 *data_ptr, agg_bufs, cmp_type;
@@ -2151,6 +2152,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 							     false);
 			if (!frag_len)
 				goto oom_next_rx;
+
 		}
 		xdp_active = true;
 	}
@@ -2160,6 +2162,12 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			rc = 1;
 			goto next_rx;
 		}
+		if (xdp_buff_has_frags(&xdp)) {
+			sinfo = xdp_get_shared_info_from_buff(&xdp);
+			agg_bufs = sinfo->nr_frags;
+		} else {
+			agg_bufs = 0;
+		}
 	}
 
 	if (len <= bp->rx_copy_thresh) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index dc51dce209d5f..f9e7e71b89485 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -472,7 +472,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 	}
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
-				   BNXT_RX_PAGE_SIZE * sinfo->nr_frags,
+				   BNXT_RX_PAGE_SIZE * num_frags,
 				   xdp_buff_is_frag_pfmemalloc(xdp));
 	return skb;
 }
-- 
2.39.5




