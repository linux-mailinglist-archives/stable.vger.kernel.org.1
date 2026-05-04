Return-Path: <stable+bounces-243856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODyVLfe6+Gnh0AIAu9opvQ
	(envelope-from <stable+bounces-243856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:27:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E4E4C0AC2
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003443011594
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ABF3E024B;
	Mon,  4 May 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC1pNmR9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F033F5BF
	for <stable@vger.kernel.org>; Mon,  4 May 2026 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908452; cv=none; b=qKeLudJd7SINu5/iJ07B8XlqHLDZ35NOVpXRsQAqL8AD9ZujBuOh3ihONRtd0wFNK4kbTq6FebrkVdI+rT8BILLisZ/ggIKoR3t8LPwcVN49GKWnMR1o3esfXfyq64WTATuYNdpr8lvTbrewPDnaHwKqCqxqKLCBw2QGQmzGm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908452; c=relaxed/simple;
	bh=hO+zym3mTv4R/jUftjLR4dlYFUKwiMbLkRn34MxFFe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajJ20BfR3o8voGkNBJonW5z3QiLea+epRpmqwWQVE80aQYQhCHvgve2CjJYBvSr8LBQc5ikKKy5UxIhuBksBc8Nk+Zxd6SOnlt8oK/dkM9PJ+i+l/ue7PBJKONn2AbEL3UtBWYGNS53TlM8dCRq2/lfh1bpeId6h0+uLIiuizSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC1pNmR9; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so1629599a12.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777908450; x=1778513250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZjvTocBotG8D32T0Fa7dku0HsteTt04rb/ig51a7Kg=;
        b=WC1pNmR9RX5SB5Z3qgYn452e62E+X9OcyDvBz9IWVAGK5znktMG5PUVVOs2Sx4GPjS
         qDdrudwDdUTu4sck6bRobYEwXp1gehgnajwnY5x6F72Vm6rfhqWpq+xG7HWw4Bgjs1XE
         Nh9k8AbvfgUeacEx+VcYPk7eq3jli+lZPvj0iUUFESVe5QAyStk47ku7pgvjTNDjVGi1
         kVvvVJeiL3OM9bEj0E8X+UKrRVfXkSGkXFM65sxGyAOYM1c5CLBqcbn8YiFR6ivO8XQi
         XW9O4nvU312o7Dh5djOWluPDyU515L7S04fIDdOKlNO++t6SeLSFD/cyCXzCgxyZVWrs
         Vi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777908450; x=1778513250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZjvTocBotG8D32T0Fa7dku0HsteTt04rb/ig51a7Kg=;
        b=g+TgThHUhbn+yZTmFijDMjPtQ04k7Lk3HENbr7HUbaRLbTxeURPyhCLvhSzJmqcs0O
         X0qrDRk5vJc3NtrQnrn3ba0ic1+lQpLLPixtyF0Y0rfcAo94MAxDaIs4j7woFTXnd4q2
         UrJe8wUxATXavrEqxaJWiq13rQqfs0uPjnTcviKFGCwfJ6btyKu2xcM1ZHS8gCKsgqVs
         w4Y6jbZwk4GfjEZ41sMtj8bZ6utIOTCZsUHDyeB2Z6o2/5WVbwqIwa0j912Q2xna0kBb
         RsFTCPE0csVrqF0xkNfrYOtLEcG3VyLW0NPYc84IslzuKtj4V7aR7F7JnRw7m6ZUkOQf
         Y5uA==
X-Forwarded-Encrypted: i=1; AFNElJ9hMjGW/pXkWCtOpfXSDUDP1HY04KHoL0d9XK1JczJ34wcb2O2LPtVZHv3aNO3n7FrG2QvLl6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzBunXG+BpYWfqSp1FZLVeKce3DOQvz/pG52K8LJXLVB3WOWb
	cZm9y82GL2cDY7yC+qZAAy2zi0IirAjFg0VBqfLubm62Vrdq28gQGLWj
X-Gm-Gg: AeBDietFMcLu9YKqs33JD7tCtUu8Am9CSvQOX14oKcGA36M3iERr9jop+lnAWCAfPGc
	CoJcUpBcVoWBWwC238LGvEhGZR2rLwK+GJ2y0D9LxOq5b/msbwoqcfu/kbGOVYIrLzfHsOf9lDQ
	4AGlC+geqEt+a5JEkBW3GX4wSkumS6QTmGwhvropZgOrqzfH2ao13bZfIwVJAkRMETdznfBo0Os
	2Iu0jEQSTcfwvUDlOOJdpCY2ozuKEx7cGNjIyVeIIWhyj6LDnYOOXept2yVDBbXnTo3K/nTR5LN
	/SW5sUADH9HM3maPKBqY9CTcGe6+juS3E3opFOpMz38EKbmEmzL/zCcptUY8RwRCsGgjroxmVWY
	71GOg0fB0cwQ0TTmKo+G+JiD8fSHfPd3O8SecaHuLjQhAjn6FWwC/uhHLfNJPYa7GZRySjfiaXq
	MqKGRzYWYBF8hNyv/wxalmIEvk6Ka+HPqtUXrJnVw+QjhVH+PJBT/hns7ZfbMRqpQxjqNBpbvQI
	x06FA9dfG+hy0KZeJPWjqAUB6P3
X-Received: by 2002:a05:6300:48:b0:3a3:c6df:7239 with SMTP id adf61e73a8af0-3a7f1ad0724mr10192618637.10.1777908450288;
        Mon, 04 May 2026 08:27:30 -0700 (PDT)
Received: from localhost.localdomain (114-45-143-162.dynamic-ip.hinet.net. [114.45.143.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbbbd313sm9924766a12.12.2026.05.04.08.27.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 May 2026 08:27:29 -0700 (PDT)
From: HexRabbit <h3xrabbit@gmail.com>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kuan-Ting Chen <h3xrabbit@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] xfrm: esp: avoid in-place decrypt on shared skb frags
Date: Mon,  4 May 2026 23:27:12 +0800
Message-ID: <20260504152712.76305-1-h3xrabbit@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35E4E4C0AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[secunet.com,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-243856-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[h3xrabbit@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Kuan-Ting Chen <h3xrabbit@gmail.com>

MSG_SPLICE_PAGES can attach pages from a pipe directly to an skb. TCP
marks such skbs with SKBFL_SHARED_FRAG after skb_splice_from_iter(),
so later paths that may modify packet data can first make a private
copy. The IPv4/IPv6 datagram append paths did not set this flag when
splicing pages into UDP skbs.

That leaves an ESP-in-UDP packet made from shared pipe pages looking
like an ordinary uncloned nonlinear skb. ESP input then takes the no-COW
fast path for uncloned skbs without a frag_list and decrypts in place
over data that is not owned privately by the skb.

Mark IPv4/IPv6 datagram splice frags with SKBFL_SHARED_FRAG, matching
TCP. Also make ESP input fall back to skb_cow_data() when the flag is
present, so ESP does not decrypt externally backed frags in place.
Private nonlinear skb frags still use the existing fast path.

This intentionally does not change ESP output. In esp_output_head(),
the path that appends the ESP trailer to existing skb tailroom without
calling skb_cow_data() is not reachable for nonlinear skbs:
skb_tailroom() returns zero when skb->data_len is nonzero, while ESP
tailen is positive. Thus ESP output will either use the separate
destination-frag path or fall back to skb_cow_data().

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
Fixes: 7da0dde68486 ("ip, udp: Support MSG_SPLICE_PAGES")
Fixes: 6d8192bd69bb ("ip6, udp6: Support MSG_SPLICE_PAGES")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Reported-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
---
v2:
- Add Fixes tags
- Add stable Cc and Reported-by trailers.

 net/ipv4/esp4.c       | 3 ++-
 net/ipv4/ip_output.c  | 2 ++
 net/ipv6/esp6.c       | 3 ++-
 net/ipv6/ip6_output.c | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6dfc0bcde..6a5febbdb 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -873,7 +873,8 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e4790cc7b..5bcd73cbd 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1233,6 +1233,8 @@ static int __ip_append_data(struct sock *sk,
 			if (err < 0)
 				goto error;
 			copy = err;
+			if (!(flags & MSG_NO_SHARED_FRAGS))
+				skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9f7531373..9c06c5a14 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -915,7 +915,8 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7e92909ab..1f2a33fbe 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1794,6 +1794,8 @@ static int __ip6_append_data(struct sock *sk,
 			if (err < 0)
 				goto error;
 			copy = err;
+			if (!(flags & MSG_NO_SHARED_FRAGS))
+				skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
-- 
2.43.0

