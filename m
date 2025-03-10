Return-Path: <stable+bounces-123052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E60A5A296
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FA2189536C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51691C3F34;
	Mon, 10 Mar 2025 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OFaYQUsI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAD2236E4;
	Mon, 10 Mar 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630907; cv=none; b=U4dUzsePYdswLksLU09coT5hu91yVimRJVLLy1xpZfewAoOVkLbOB7w9AwGaUw1CnNYW4vhd4rXL/VK1rrmqPcmMSDfkUBYhj+49u3Tw25RksCXXndPtvLUo5mZ/H9e2WfM7BXGrrGQ9Tl83J9Xx4/h+2o7+N121voH98zi1g4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630907; c=relaxed/simple;
	bh=2/yz5PFu+QUCqMbgQeFFGs+cWEeLw9oq9SWWlxgQkX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUiZSdbo6lvnI5+3TYM9mxKR+jKZXia4Yz2Yqq15ynIwSYCyMEFeWcPumE39Vgbg+OQkGTOLsURV2tOSgltQ3QXdm/H8/ttHqeMw4Xv6TNXvd6FqTm3Gw7wC50Xx5qswCdd00OySbnfiPb25a42oYzMPek5QBpg0HQ0Zf1mEoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OFaYQUsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76556C4CEE5;
	Mon, 10 Mar 2025 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741630906;
	bh=2/yz5PFu+QUCqMbgQeFFGs+cWEeLw9oq9SWWlxgQkX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFaYQUsIDOvaYkGjU/iqEuOdSgSuSAC6vu6ttDrXHqNZTbMCk7uVHLj67Doe11mq5
	 YiU+Tc3olofWhB/g99X37McEcKJigeLTCqL5kAPD7gsWk3xAPwJ5oO8LxMo+IX85ao
	 KamiuGpM2/A0bHz1bSGf/lpoMXK5qOlUYzuj94JA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 575/620] net-timestamp: support TCP GSO case for a few missing flags
Date: Mon, 10 Mar 2025 18:07:01 +0100
Message-ID: <20250310170608.239172036@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Xing <kerneljasonxing@gmail.com>

[ Upstream commit 3c9231ea6497dfc50ac0ef69fff484da27d0df66 ]

When I read through the TSO codes, I found out that we probably
miss initializing the tx_flags of last seg when TSO is turned
off, which means at the following points no more timestamp
(for this last one) will be generated. There are three flags
to be handled in this patch:
1. SKBTX_HW_TSTAMP
2. SKBTX_BPF
3. SKBTX_SCHED_TSTAMP
Note that SKBTX_BPF[1] was added in 6.14.0-rc2 by commit
6b98ec7e882af ("bpf: Add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback")
and only belongs to net-next branch material for now. The common
issue of the above three flags can be fixed by this single patch.

This patch initializes the tx_flags to SKBTX_ANY_TSTAMP like what
the UDP GSO does to make the newly segmented last skb inherit the
tx_flags so that requested timestamp will be generated in each
certain layer, or else that last one has zero value of tx_flags
which leads to no timestamp at all.

Fixes: 4ed2d765dfacc ("net-timestamp: TCP timestamping")
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_offload.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 357d3be04f84c..20267290f555c 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -11,12 +11,15 @@
 #include <net/tcp.h>
 #include <net/protocol.h>
 
-static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
+static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_skb,
 			   unsigned int seq, unsigned int mss)
 {
+	u32 flags = skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
+	u32 ts_seq = skb_shinfo(gso_skb)->tskey;
+
 	while (skb) {
 		if (before(ts_seq, seq + mss)) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_SW_TSTAMP;
+			skb_shinfo(skb)->tx_flags |= flags;
 			skb_shinfo(skb)->tskey = ts_seq;
 			return;
 		}
@@ -118,8 +121,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	th = tcp_hdr(skb);
 	seq = ntohl(th->seq);
 
-	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
-		tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss);
+	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP))
+		tcp_gso_tstamp(segs, gso_skb, seq, mss);
 
 	newcheck = ~csum_fold((__force __wsum)((__force u32)th->check +
 					       (__force u32)delta));
-- 
2.39.5




