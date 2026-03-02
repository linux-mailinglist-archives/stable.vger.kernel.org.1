Return-Path: <stable+bounces-222522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FWTJjQ0pWmh5gUAu9opvQ
	(envelope-from <stable+bounces-222522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 07:54:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C0F1D39AC
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 07:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FABE3012BC6
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 06:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D655F37F74F;
	Mon,  2 Mar 2026 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="vLKDTric"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D13242D4;
	Mon,  2 Mar 2026 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772434478; cv=none; b=fLCogdy22Mq2PimfSWyvpgfFm5rse/j28ksFINsKv6Dc8HO0+WuHBMwkW8plD/tDdtOCzlFsWadjE7qRQz/vVYmKUvII/HNKc/SGcpK2eOL5lx2ZqP2uyMhs4dS4h7HHuS/hXx2oGJDatSZOlL0+yN4G3OBZADmr92RQsidq7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772434478; c=relaxed/simple;
	bh=jNCSBsHBmO66pMF/wFVUrcW5VqDqG8tQLdhbY4qjysY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sUmsnEmrCLdi91RMSzvkfDKi1nlB99AwZWSTrYPT3T5QeekK4K/bxHv6uR8EbfUl5hZR5QxNfUTVgA+2Qzg9F6cb72OPCnpxYBDvYyvYdbNTElgPWMbZfGP4wDV7TB7pwL4+L7/1GBlmeCMYFz4fztuOiYCLPGz6I+y0PP10DVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=vLKDTric; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vLKDTricHCg+/6AYueKWp5gi+6D37G/xj4PfIH17+MxNUOk6xiTXOR8ADk6Gny4K2wvSh26oe6lDd
	 mkxzpV8sU8vj+TQeVA0EW0lsdTVeWbljYdTJG3H2/SkPoM5Jr3u7NpNfXJooUka+BAgM6dLEZ1Ildo
	 FsapyK8RC/OxkwpU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-27-12032 (RichMail) with SMTP id 2f0069a5341d688-016a5;
	Mon, 02 Mar 2026 14:54:29 +0800 (CST)
X-RM-TRANSID:2f0069a5341d688-016a5
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	jibin.zhang@mediatek.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	matthias.bgg@gmail.com,
	willemb@google.com,
	steffen.klassert@secunet.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 6.1.y 3/3] net: fix segmentation of forwarding fraglist GRO
Date: Mon,  2 Mar 2026 14:54:27 +0800
Message-Id: <20260302065427.2695392-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[139.com];
	TAGGED_FROM(0.00)[bounces-222522-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,fb.com,gmail.com,google.com,davemloft.net,redhat.com,linux-ipv6.org,secunet.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,139.com:mid,139.com:email,mediatek.com:email]
X-Rspamd-Queue-Id: 40C0F1D39AC
X-Rspamd-Action: no action

From: Jibin Zhang <jibin.zhang@mediatek.com>

[ Upstream commit 426ca15c7f6cb6562a081341ca88893a50c59fa2 ]

This patch enhances GSO segment handling by properly checking
the SKB_GSO_DODGY flag for frag_list GSO packets, addressing
low throughput issues observed when a station accesses IPv4
servers via hotspots with an IPv6-only upstream interface.

Specifically, it fixes a bug in GSO segmentation when forwarding
GRO packets containing a frag_list. The function skb_segment_list
cannot correctly process GRO skbs that have been converted by XLAT,
since XLAT only translates the header of the head skb. Consequently,
skbs in the frag_list may remain untranslated, resulting in protocol
inconsistencies and reduced throughput.

To address this, the patch explicitly sets the SKB_GSO_DODGY flag
for GSO packets in XLAT's IPv4/IPv6 protocol translation helpers
(bpf_skb_proto_4_to_6 and bpf_skb_proto_6_to_4). This marks GSO
packets as potentially modified after protocol translation. As a
result, GSO segmentation will avoid using skb_segment_list and
instead falls back to skb_segment for packets with the SKB_GSO_DODGY
flag. This ensures that only safe and fully translated frag_list
packets are processed by skb_segment_list, resolving protocol
inconsistencies and improving throughput when forwarding GRO packets
converted by XLAT.

Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>
Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260126152114.1211-1-jibin.zhang@mediatek.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 net/core/filter.c        | 2 ++
 net/ipv4/tcp_offload.c   | 3 ++-
 net/ipv4/udp_offload.c   | 3 ++-
 net/ipv6/tcpv6_offload.c | 3 ++-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e19bf63ad9a4..d8facc927337 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3326,6 +3326,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 			shinfo->gso_type &= ~SKB_GSO_TCPV4;
 			shinfo->gso_type |=  SKB_GSO_TCPV6;
 		}
+		shinfo->gso_type |=  SKB_GSO_DODGY;
 	}
 
 	skb->protocol = htons(ETH_P_IPV6);
@@ -3356,6 +3357,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
 			shinfo->gso_type &= ~SKB_GSO_TCPV6;
 			shinfo->gso_type |=  SKB_GSO_TCPV4;
 		}
+		shinfo->gso_type |=  SKB_GSO_DODGY;
 	}
 
 	skb->protocol = htons(ETH_P_IP);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 9fbb70312159..b0e62c081998 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -106,7 +106,8 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
 		struct tcphdr *th = tcp_hdr(skb);
 
-		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
+		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
 			return __tcp4_gso_segment_list(skb, features);
 
 		skb->ip_summed = CHECKSUM_NONE;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 593108049ab7..58cabb2bb32a 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -351,7 +351,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 
 	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
 		 /* Detect modified geometry and pass those to skb_segment. */
-		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
+		if ((skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size) &&
+		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY))
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
 
 		ret = __skb_linearize(gso_skb);
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 81959fd6fe36..976608aa049b 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -108,7 +108,8 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
 		struct tcphdr *th = tcp_hdr(skb);
 
-		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
+		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
 			return __tcp6_gso_segment_list(skb, features);
 
 		skb->ip_summed = CHECKSUM_NONE;
-- 
2.34.1



