Return-Path: <stable+bounces-253992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKsADmR7Emom0AYAu9opvQ
	(envelope-from <stable+bounces-253992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 06:15:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50E5C15D7
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 06:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80B49301CC6E
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76B2F0C62;
	Sun, 24 May 2026 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlxaEvFH"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A62EB84E
	for <stable@vger.kernel.org>; Sun, 24 May 2026 04:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779596103; cv=none; b=RKddKOnMbBmqrEnUNf4eqg35fc7GvApIlk0LanR8Z3l0MvK+r12MODCaeng+jUviYRuVbPlxiamA+vcE5Uzx620VjbBrCO9WuUHRRuQDAyASNa+/vS0bFi5/yBZfH5YC7Yu1OT2tvlyqfXYLqalKLQdK7wgEkYP4e7QadGGMpMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779596103; c=relaxed/simple;
	bh=v4DChmgMIqD3sZi1XmOFJENUOy5EXRWJZ12xfigMG7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVJ4MzdUFvirmfx9ebCAUBygpiLqJ5gz+e758v26S/FQqYh6f04YSx/oyFlc5HpMiax92y/GNUEndANZBGuyxoPqMRwl2iKFWsOBPQC62Ko+Df3q6oJXCLxAsgQ/KgZvJoFbQWH0jMzAo14kZNR5AEOIZZY5USoFDgOvhN0GktA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlxaEvFH; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3042dffd80bso5047428eec.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 21:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779596101; x=1780200901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwSfiLD9EYXQoGMlXF6ksbJb1icrnEewPT1OiamEXy0=;
        b=TlxaEvFHfj6/n4plGucsUMLGMakiJZVOfZLNfxT9k48hEA/tKV1ZCSkLYNDcbl+9fO
         /0yiowUtLdyhdXseoc4hHiSXRcsZoPrelerpqqQ5LWfXFCLSc245y7vLtwbgoaf1XgP1
         Ruy0sJxcL/I9v/l+R4oZTno9j2xDp2092sXfaX5sAUS1apovgDMWJT0APkU/FrQ4qerw
         T+2vmnEWvd9dt6yLaSH+gBEztHk0C7XFKhRH40BPlRlO2kVYAmv+LUIjeDqJsaDjayGe
         BWL3ZMvkd/6t0mPq7dAUzHw1LzxLk5cnnnqCHlsEFPrdkSnmtHkqHzSPpcxsHIts0x5q
         7WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779596101; x=1780200901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwSfiLD9EYXQoGMlXF6ksbJb1icrnEewPT1OiamEXy0=;
        b=PwXjYwNXXHb/V3OYSKZY2VGBWbhWIFolh49fWjTFZnPgWqcfqPRFjxgkqbPY8sNLdZ
         Mnvg+JZmHHMxUZy5o64RMmCO9tfk1VPAdsvh0f8hAHilrapqgZ0wIOqr7RRrxrpns3vg
         gheCnVzV13/TP1Y1f36BLhqPqn/kzO9xam3y5YR03jD+4CSIg3TkMxElaYwVlpJtV2hc
         hRG2xxG6DObSnbQKnhCQHqgy9pGfTIMmXPf/61JbjoW7wcUCl7Il/3ctuiHbdr16jLMf
         r2AFTNqxgcCLHU4122ubFErI3i2mb9JSDmnOwVnhSitatY3stGjv+ZNe69Fv6E8iu3Qn
         BG4g==
X-Forwarded-Encrypted: i=1; AFNElJ/FFqbkuOnJqDtTyOC9cZ6+gx5s54H+BTNa+sxLg2lp2egFzBFusgCuT6urVM4ve6ZPHVjy0aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjcNAKBe5F+DdYlFT4N1MWGWWxWo0cvhnApFbMNRi3KZYGvyX
	QSzoV2DYgNpIRbm6uvOyT7WG+nKiqgMXcuy0WAfmM4DM49dpU8AntAXO
X-Gm-Gg: Acq92OEt68mjA7ZudyiA79fn1VepTQpin18foGTgucvl6xjv5R1xUax1YouDokmfoEW
	kNRUcbuMA1GVJFR3GoY16YpP94q2xgvd/BgC/BQJfUOtjwI1jpQX4uhsqZaNu8JD2ARJZQJpXIl
	dDdRp0ALgvpJtDvmH49rujLxod77EVI/n0dtHg6LbAJu/FsmXiUtiD3FloDxuM00zVKrrc9FZxZ
	hj3kohqouid62I7kTFDGbHxjuYvKJ6uxYQoc/G4H71YcIgs+TUY7/K9WPDs+XU0JQ0KGYn2wdxG
	NQBjR+nYDOOnoKuhIeAu4NcFFOpDEFck2Fn5RXDAKar+KOugkdn95O8udA6Dq0K7kZdTtPpcFMv
	oLgxB4iCdu1de6MARu62Z7cKGM6x7fMMZ2QIWLFGw+mXaeP27yqYYUW7qZ1+jwWQ/F03sC5JIhr
	uqKDD/1wVOmBCVqmZX10UT7GY/zmSPsbNn0jNgI3WFW4oY
X-Received: by 2002:a05:7301:6588:b0:2d3:2983:c87c with SMTP id 5a478bee46e88-3044904e0a8mr4828426eec.1.1779596101041;
        Sat, 23 May 2026 21:15:01 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245d6aesm4522133eec.26.2026.05.23.21.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 21:15:00 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	fw@strlen.de,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 2/4] ipv4: ipmr: clamp ip_hdrlen against skb_headlen in ipmr_cache_report
Date: Sun, 24 May 2026 12:14:36 +0800
Message-ID: <20260524041442.2432071-3-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524041442.2432071-1-tpluszz77@gmail.com>
References: <20260524041442.2432071-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,gmail.com,kernel.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-253992-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EB50E5C15D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipmr_cache_report() copies ip_hdrlen(pkt) bytes from pkt->data into
a freshly allocated 128-byte skb that is delivered to userspace via
the mrouted IGMP raw socket and via igmpmsg_netlink_event:

  const int ihl = ip_hdrlen(pkt);
  ...
  skb_put(skb, ihl);
  skb_copy_to_linear_data(skb, pkt->data, ihl);

ip_rcv_core() validates iph->ihl and pskb_may_pull()s ihl*4 bytes at
parse time.  An nftables PRE_ROUTING payload write reachable from an
unprivileged user namespace can flip the ihl nibble from 5 to 15
between parse and ipmr_cache_report().  When the original skb is
non-linear (received via a NIC driver that uses paged frags), only
the parse-time ihl*4 = 20 bytes are in the linear region; the
consumer copies 60 bytes, and the extra 40 bytes are read from
skb_shared_info or adjacent slab memory and queued back to userspace,
a kernel heap-content infoleak.  PoC observation: recvfrom on the
mroute socket returns 28 bytes without mutation, 68 bytes with
mutation (40 extra bytes leaked).

Clamp ihl against skb_headlen(pkt) so only bytes actually present
in the linear region are copied.

Cc: stable@vger.kernel.org
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/ipv4/ipmr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 2628cd3a93a68..b40f3dd8f650f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1056,7 +1056,7 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
-	const int ihl = ip_hdrlen(pkt);
+	const int ihl = min_t(int, ip_hdrlen(pkt), skb_headlen(pkt));
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
 	struct igmpmsg *msg;
-- 
2.47.3


