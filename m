Return-Path: <stable+bounces-253947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMM8Laa6EWo5pQYAu9opvQ
	(envelope-from <stable+bounces-253947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:33:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4E55BF631
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B83301BF4D
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3313A2DF155;
	Sat, 23 May 2026 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZUMtojX"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE562D7DEF
	for <stable@vger.kernel.org>; Sat, 23 May 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546776; cv=none; b=ICRdOX6z16v/p8uFS2jisQnB1ttd88CuX5X5mCfPM/xfCb43rJzCz7B/RLppobATp1hkmZPUvGI06ci7aY0jFmYJUi4MLKV7ySkLKN2tI+ESVnVwcBPBO6EO1U58z2o89ctYIaOHa8SLMje9bFCO7nQueRLUtH/GpdYqrFyA9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546776; c=relaxed/simple;
	bh=FJ2NvquqsOVLxpxqr4TmzmMr3EuyXiQiCVyAvDUqTnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGrkfbEPUH7f0pCMmCkKHJ1PKigG3iiMDtpx397T6NzZCzZQEqZu1I89wotT6+bGlXTOvu9Kh0OHQQfPV8eBGCdmFdPOrt6bWSz8b9RzcVGeKnfI1CsChyGDSmbbH+bJF8Em4yIZ4qv6pAQm+ULiWqfWXEI/uy6sCvuNG9gLlcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZUMtojX; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f7020a928eso12011465eec.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779546773; x=1780151573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bW1xa01RcVBDp9rxJa1g3HLHeABv0J4kQClbtMfYkqc=;
        b=pZUMtojXu/5YU62R1OVcZKciuDZELJax1LKaYEaj2u1ErUO2onXkrNx5RTDX1LTVrW
         3svvZqB3x6ez39jFqgpIwQWlnLcp9GRnZFyxCa4b01aMTCKPM2SZblmwEJuv9sVslowJ
         TYxnV811LMibaTorgFSNgswjPh82uJU5vRLyZ61JoA3771kshRyKSpXh2PuPtwAzmaxc
         K0U4rcOH5n20UKckUcLonA5bXpY7HyAhkBs3gb04AMhmp82LRhXrzMl/Aruh0h9WwhCp
         Mb5eX9cDETl7qwzl4O0MR0/te3EUd6hfi8w4VVqL6w4BWgc7dOTF7qyP+4GjOgeYVNza
         hWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779546773; x=1780151573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW1xa01RcVBDp9rxJa1g3HLHeABv0J4kQClbtMfYkqc=;
        b=Mjm+nXE4AqUgTmENOilUihVNmSZwK7CbIqi561rVVD6PksQ4pTHHaeqjSbB2RKCRaK
         pm6cVOoHexM5rszG7TGAUCsF7Hjkk4PfAGpBS5WQh7TONiD05Ew+VBfVTUbr5wBORbp6
         u9zG4VwSVpF7Get0gsnN3HrQdcU59L1vjaoYCkOzcAiyOfCpiKWCTMy2YA5p5VBcMotG
         /fvbyCp+UPpD4ohdQm6k3yHx0vDmV2k0xefVif8VtMy0wlCYVpfiEBQeG66MnX/N0NtJ
         G6AiOgR9Vsr0J9Nae1SgDRs7qBWKU9FTVCmp3A/ZdbUsSLxsNGbjwgHMRygLnzfVeIzL
         qMXg==
X-Forwarded-Encrypted: i=1; AFNElJ8si8H3fSub/TGgrsvJJer6APZQpyNQ5dAF/R2T+u+ZZprchTOO8yAq2obWTghQrNBfevRjIAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkzjIVQUw5hIHuLIt1P+L9Wl5zljYH3xo1L/tD5iJA6kvCSlHY
	M9YnyrNbWjS+ZZ+oB/KRI+C4s3AgH/jnCKdRFQpb9kIyE/r1K4h99GuF
X-Gm-Gg: Acq92OEVtrbccRBcq4AdU0+oPl+xJNv4Lj2uCYuDxF0oTUdgjfJgVuf+mx1SU+a7V00
	atuRmM3F7z3Rb5G3W19tz0jzSlx2zO2jDG0YRLo6ESeHv6w8MUXumIyWhnZE6vY5HAZ4LqzQ62L
	G3ZQSE3Q251S0BlmemER3n/efsV0LGZ6/vsLiZHAFNt2lT5l7jJVeQsHFgpgNgh5nEA1TE3sC85
	VxrLiL7eSM9gRGUzm9HePjgdbfCvLaOl6lcIiS+Bwups9UyUi8Jo1mLkfKrJSSLDiU8TGDNeAsD
	lIdmALrUuptiW5W27SfzA//ZFi4L1aBs70MvohtjCcy9i/x/tb23ZS7EYJS6Mo7BygTuIbtFTr6
	MiYCr+K+XhjQHDOrOP8moTbNk9rfqiaXIuoVOxHWqooLMih5knnRZPKOShwUPyV8E2hVr8pwtZC
	XZNy5EZLXQxpai2HKGqJDtpqtjmvAJOfebHQ==
X-Received: by 2002:a05:7300:f196:b0:2d9:6f2f:9f6f with SMTP id 5a478bee46e88-304491d13f9mr3468524eec.24.1779546772574;
        Sat, 23 May 2026 07:32:52 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304522314a4sm3415815eec.18.2026.05.23.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 07:32:52 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v5] ipv6: validate extension header length before copying to cmsg
Date: Sat, 23 May 2026 22:32:45 +0800
Message-ID: <20260523143245.2281415-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253947-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0F4E55BF631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip6_datagram_recv_specific_ctl() builds IPV6_{HOPOPTS,DSTOPTS,RTHDR}
cmsgs (and their IPV6_2292* legacy counterparts) by trusting the
on-wire hdrlen byte (ptr[1]) when computing the put_cmsg() length.
The length was validated only at parse time (ipv6_parse_hopopts(),
etc.).  An nftables payload-write expression can rewrite hdrlen after
parsing and before the skb reaches recvmsg; the write itself is
in-bounds but put_cmsg() then reads up to ((hdrlen+1) << 3) = 2040
bytes from an 8-byte header.  nftables is reachable from an
unprivileged user namespace, so this is an unprivileged
slab-out-of-bounds read:

  BUG: KASAN: slab-out-of-bounds in put_cmsg+0x3ac/0x540
   put_cmsg+0x3ac/0x540
   udpv6_recvmsg+0xca0/0x1250
   sock_recvmsg+0xdf/0x190
   ____sys_recvmsg+0x1b1/0x620

Add ipv6_get_exthdr_len() which validates that at least two bytes
are accessible before reading the hdrlen field, then checks the
computed length against skb_tail_pointer(skb), returning 0 on
failure.  Extension headers are kept in the linear skb area by
pskb_may_pull() during input, so skb_tail_pointer() is the correct
bound.

Use ipv6_get_exthdr_len() at all non-AH call sites: the five
standalone cmsg blocks (HbH, 2292HbH, 2292DSTOPTS x2, 2292RTHDR)
and the three standard cases in the extension-header walk loop
(DSTOPTS, ROUTING, default).  AH retains an inline bounds check
because its length formula differs ((ptr[1]+2)<<2).

The walk loop also gets a pre-read bounds check at the top to
validate ptr before any case accesses ptr[0] or ptr[1].

When the walk loop detects a corrupted header, return from the
function instead of continuing to process later socket options.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
Changes v4 -> v5 (Jakub Kicinski):
  - Switch (ptr + len <= tail) to (len <= tail - ptr) form in
    ipv6_get_exthdr_len() to avoid pointer arithmetic concerns.

Changes v3 -> v4 (Paolo Abeni / Sashiko):
  - Validate ptr + 2 <= skb_tail_pointer(skb) before reading ptr[1]
    in ipv6_get_exthdr_len()
  - Add matching pre-read bounds check at the top of the walk loop

Changes v2 -> v3:
  - Resend as new thread (v2 was incorrectly sent as reply to v1)

Changes v1 -> v2 (Paolo Abeni):
  - Factor repeated bounds-check + put_cmsg into ipv6_get_exthdr_len()
  - Return from the function on corrupted walk-loop entry instead of
    goto + empty label

v4: https://lore.kernel.org/netdev/20260514035802.1540395-1-tpluszz77@gmail.com/
v3: https://lore.kernel.org/netdev/20260423103238.3987364-1-tpluszz77@gmail.com/
v2: https://lore.kernel.org/netdev/20260423102255.3752004-1-tpluszz77@gmail.com/
v1: https://lore.kernel.org/netdev/20260419150344.624673-1-tpluszz77@gmail.com/
 net/ipv6/datagram.c | 54 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 972bf0426d599..f9ee1bf97f206 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -617,6 +617,18 @@ void ip6_datagram_recv_common_ctl(struct sock *sk, struct msghdr *msg,
 	}
 }
 
+static u16 ipv6_get_exthdr_len(const struct sk_buff *skb, const u8 *ptr)
+{
+	u16 len;
+
+	if (ptr + 2 > skb_tail_pointer(skb))
+		return 0;
+
+	len = (ptr[1] + 1) << 3;
+
+	return (len <= skb_tail_pointer(skb) - ptr) ? len : 0;
+}
+
 void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 				    struct sk_buff *skb)
 {
@@ -643,7 +655,10 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 	/* HbH is allowed only once */
 	if (np->rxopt.bits.hopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
 		u8 *ptr = nh + sizeof(struct ipv6hdr);
-		put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, len, ptr);
 	}
 
 	if (opt->lastopt &&
@@ -664,26 +679,37 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 			unsigned int len;
 			u8 *ptr = nh + off;
 
+			if (ptr + 2 > skb_tail_pointer(skb))
+				return;
+
 			switch (nexthdr) {
 			case IPPROTO_DSTOPTS:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				if (np->rxopt.bits.dstopts)
 					put_cmsg(msg, SOL_IPV6, IPV6_DSTOPTS, len, ptr);
 				break;
 			case IPPROTO_ROUTING:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				if (np->rxopt.bits.srcrt)
 					put_cmsg(msg, SOL_IPV6, IPV6_RTHDR, len, ptr);
 				break;
 			case IPPROTO_AH:
 				nexthdr = ptr[0];
 				len = (ptr[1] + 2) << 2;
+				if (ptr + len > skb_tail_pointer(skb))
+					return;
 				break;
 			default:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				break;
 			}
 
@@ -705,19 +731,31 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 	}
 	if (np->rxopt.bits.ohopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
 		u8 *ptr = nh + sizeof(struct ipv6hdr);
-		put_cmsg(msg, SOL_IPV6, IPV6_2292HOPOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292HOPOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.odstopts && opt->dst0) {
 		u8 *ptr = nh + opt->dst0;
-		put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.osrcrt && opt->srcrt) {
 		struct ipv6_rt_hdr *rthdr = (struct ipv6_rt_hdr *)(nh + opt->srcrt);
-		put_cmsg(msg, SOL_IPV6, IPV6_2292RTHDR, (rthdr->hdrlen+1) << 3, rthdr);
+		u16 len = ipv6_get_exthdr_len(skb, (u8 *)rthdr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292RTHDR, len, rthdr);
 	}
 	if (np->rxopt.bits.odstopts && opt->dst1) {
 		u8 *ptr = nh + opt->dst1;
-		put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.rxorigdstaddr) {
 		struct sockaddr_in6 sin6;
-- 
2.47.3



