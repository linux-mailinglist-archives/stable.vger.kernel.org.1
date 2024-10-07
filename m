Return-Path: <stable+bounces-81416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E7D993459
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA211F23C57
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D001D9691;
	Mon,  7 Oct 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b+q+kXTu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A981DC07D
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320664; cv=none; b=M1AdIAwx2TE+CG5BHTnqR/YUdyM83bXbnZvgyzYrEBP78VR9qTNAXhgS2XMa5tN6cuUoOP4XM7lhPouMKEciUab5EC5Jfdllst0orsX2+2LkbG/d2s0k2eY7rE0qqGBnskgmTDOQefPzGXGkLQOxhsM4Mfyn6vLU/YHHzrTsCck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320664; c=relaxed/simple;
	bh=CAaY0JKH9m+B1ErvsWBsy8m6tKSMaU1ZxO3f2LpKb7o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pp5NyOgYxsVHOW2w6GWkktHcdsQWUmZN59B6hBboAY2YlrN5aOGbxxOo0NsBWg5c3n+lZ2wrvQ+oyIf44WkSE6lk1fog9yamDiLeG4PuJ2vNtKR1XynIifkBViM/Lk8i2RX2W69mfdoaQ1EZAGMxF6m00FacY5n0C7mN3BHxHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b+q+kXTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FE1C4CEC6;
	Mon,  7 Oct 2024 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728320664;
	bh=CAaY0JKH9m+B1ErvsWBsy8m6tKSMaU1ZxO3f2LpKb7o=;
	h=Subject:To:Cc:From:Date:From;
	b=b+q+kXTuQ5yDTfbgo1dkahG/foIXFd8mHL8eTWKQ0LzSpSod777dmtRKqMrXZU4BF
	 CLk+jynvuf6Q3JLFkMvvJmYHVFUbJ7DIQ5xhIFZb86TA3ppITqg6GTctP9h6pkuwbG
	 5z+gc5BAhoSlvwLUSviPwBdYsp/Aa0M8KI+D23sk=
Subject: FAILED: patch "[PATCH] gso: fix udp gso fraglist segmentation after pull from" failed to apply to 5.10-stable tree
To: willemb@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:03:26 +0200
Message-ID: <2024100726-unlocking-handled-41bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a1e40ac5b5e9077fe1f7ae0eb88034db0f9ae1ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100726-unlocking-handled-41bb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

a1e40ac5b5e9 ("gso: fix udp gso fraglist segmentation after pull from frag_list")
9840036786d9 ("gso: fix dodgy bit handling for GSO_UDP_L4")
c3df39ac9b0e ("udp: ipv4: manipulate network header of NATed UDP GRO fraglist")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a1e40ac5b5e9077fe1f7ae0eb88034db0f9ae1ab Mon Sep 17 00:00:00 2001
From: Willem de Bruijn <willemb@google.com>
Date: Tue, 1 Oct 2024 13:17:46 -0400
Subject: [PATCH] gso: fix udp gso fraglist segmentation after pull from
 frag_list

Detect gso fraglist skbs with corrupted geometry (see below) and
pass these to skb_segment instead of skb_segment_list, as the first
can segment them correctly.

Valid SKB_GSO_FRAGLIST skbs
- consist of two or more segments
- the head_skb holds the protocol headers plus first gso_size
- one or more frag_list skbs hold exactly one segment
- all but the last must be gso_size

Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
modify these skbs, breaking these invariants.

In extreme cases they pull all data into skb linear. For UDP, this
causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
udp_hdr(seg->next)->dest.

Detect invalid geometry due to pull, by checking head_skb size.
Don't just drop, as this may blackhole a destination. Convert to be
able to pass to regular skb_segment.

Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20241001171752.107580-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index d842303587af..a5be6e4ed326 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -296,8 +296,26 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		return NULL;
 	}
 
-	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
+		 /* Detect modified geometry and pass those to skb_segment. */
+		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
+			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+
+		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
+		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
+		gso_skb->csum_offset = offsetof(struct udphdr, check);
+		gso_skb->ip_summed = CHECKSUM_PARTIAL;
+
+		uh = udp_hdr(gso_skb);
+		if (is_ipv6)
+			uh->check = ~udp_v6_check(gso_skb->len,
+						  &ipv6_hdr(gso_skb)->saddr,
+						  &ipv6_hdr(gso_skb)->daddr, 0);
+		else
+			uh->check = ~udp_v4_check(gso_skb->len,
+						  ip_hdr(gso_skb)->saddr,
+						  ip_hdr(gso_skb)->daddr, 0);
+	}
 
 	skb_pull(gso_skb, sizeof(*uh));
 


