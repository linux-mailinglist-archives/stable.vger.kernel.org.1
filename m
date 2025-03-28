Return-Path: <stable+bounces-126910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F576A74338
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 06:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17160189EB2E
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 05:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F404A201039;
	Fri, 28 Mar 2025 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="EyWVG6Mh"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C81A0BCA
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 05:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743139424; cv=none; b=aSs8X5TbH5dhBOq3r3qtzZSkCTb60xpqL080GSFqmqVLhIBsykMrKvVnvbUfxX5oxEnYn3CygI+DZk+d3Rr4iyUGJOiOVmtzfPSnowipuvLJT7WqhcQ9f9I9dLtk6w5vvQ19wyapbgztmpeDbZsOp3SKhINt9Ok6uDKDcNLCmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743139424; c=relaxed/simple;
	bh=rjm2kyFJM/oTTcUQkAvPohHlHqu5acUnY1JM2jMRNdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2yYibRxQIg0qN3QVpwqvev6I8i8zIBB+euNkyaRvmCcMPxsvqlR5+QKAN4pKjOPq3yNx+InOeWfYl9eI91rCEkk7a1Dq/VLuvy1SLCEK8J9sXNm/Rgzz42EQZDVOHHTW5ieeHIZ5uyqdegwas6LR4WQu0BpoU/7Pink1+C3y5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=EyWVG6Mh; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id C0C391C2444
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 08:23:32 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1743139412; x=
	1744003413; bh=rjm2kyFJM/oTTcUQkAvPohHlHqu5acUnY1JM2jMRNdQ=; b=E
	yWVG6MhWMvTC458TpU4m9ssSnpD5WQFZ9+KlkiZfk1CdH3lnw8UAW57H3/8ZtH50
	688Rq+F5k9pEQ9alpGenSANhDJPw/b1EBvMak7soVb9+T6PM9LCnbaXqcOClTHwj
	AdrnilfKVXReNCuDNQbA+3yb1NwKf3IQvluNOICgUw=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KN1ZAa76LKYB for <stable@vger.kernel.org>;
	Fri, 28 Mar 2025 08:23:32 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id D49A21C0872;
	Fri, 28 Mar 2025 08:23:20 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 5.10] gso: fix udp gso fraglist segmentation after pull from frag_list
Date: Fri, 28 Mar 2025 05:23:13 +0000
Message-ID: <20250328052315.1205798-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

commit a1e40ac5b5e9077fe1f7ae0eb88034db0f9ae1ab upstream.

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
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 net/ipv4/udp_offload.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index b6952b88b505..515d591d00b9 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -8,6 +8,7 @@
 
 #include <linux/skbuff.h>
 #include <net/udp.h>
+#include <net/ip6_checksum.h>
 #include <net/protocol.h>
 #include <net/inet_common.h>
 
@@ -269,8 +270,26 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	__sum16 check;
 	__be16 newlen;
 
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
 
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
-- 
2.43.0


