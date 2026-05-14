Return-Path: <stable+bounces-247249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN1uBrf9BWrFdwIAu9opvQ
	(envelope-from <stable+bounces-247249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:52:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF37544F0F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F0DE301725E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA2233EB10;
	Thu, 14 May 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUu0u3Y9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178CE3195F0
	for <stable@vger.kernel.org>; Thu, 14 May 2026 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777521; cv=none; b=GIBt+UUbJLx0CulkI0/DB9r3ZIo2b4i54fZCjYBDXt42wdVfzhTxrL0oopHERlh/7qsRgwbYOGnN29GuOdFHRzvGV17pDn/xvkNDlyxviOMDuGwJmtGg1g5ikcbigisTg6x/zvkQH33xuIGHZjyUgCFRAECsxlGWxP2SYxso678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777521; c=relaxed/simple;
	bh=VWpmt7ZBipt2gqkQ22zGchyfxEm1SG+l/GA+JXxNTFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHmJpKV9dXyS3awVwkR0sExO3TwQkhryK+qzm6UGh/sYquHsEhdZMUOBvwYjwNz/r6nAHhSuNnGBVczsXOOz3+F+Lynsrw8G9IFsoLSS5NjfHkm+uft8dGTqAM93zhYtagEE4dTlJv8xRsUWUWMk3gUSNSiCCh8vDTskx4vHyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUu0u3Y9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad9a9be502so50624275ad.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777519; x=1779382319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLkhEyS3YOk/ybEPnJJKQINlNol+OlnMGeyHoaMKMO0=;
        b=QUu0u3Y9TYoomQ82R0gBkV9/ncxvxi39Ja03Fjh0kqbItDOH5STrklBxtcdORxiUTI
         WUB+SZDvDtuSPFiLZ4i3EYR4/qwJVQc3yHA1aWdoP+2pwHoaOS+Hse1RG1VPIzmliqJy
         IOXfvJI1AsPCihdzxTRLItQkRCxJ/bkDtWr4l/Ndi/266DF7LCoM0d0vTY9MLNuxSTi8
         lG70Bpb1I1FJHq2vVF/f228i+r6MXza31suupl6EiLzmqzV1S4//FKmagS/uNfCYPXaQ
         U5lD3yBADSLFY3ocS1yrffaosJrCFKAQj1AV4wBdJPfWMq516P1F5JuRx10bU8iSXmqJ
         YMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777519; x=1779382319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLkhEyS3YOk/ybEPnJJKQINlNol+OlnMGeyHoaMKMO0=;
        b=seTVDcVJag4THpvMWM9ZotZ2PEVb+1lAAg+vzXtfMFqWg9ibT7GxlRFblvDqlzAf6f
         Ymyhy3leHQriWaUXh32Nwtk3NnDcFUqSdl+YBkMgnN44+V1nfZmtNp6kOoQkUMo6CP2r
         5WXv50uYrHGrU2V7lvXdn5MSa21u6GaGw75DzmdkMjhL//YrdTOMUJkeH4TKAg8qZzsb
         52bKGMoVVvlOPE17gpe00Y2XvOQUCcN0ceKjIEoN+sJJi8F+AzrSQJKwPc4P1xfdi6MO
         ALdIhR4MbKzCE+9lx1/DLmkRHFeCHdXp8bsXtUPbUQ8cf3n3lX5JYfG7RcF1ZuvIY7NN
         j/UQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4wwYO7naGUkbXWc3JGl3QL8GajttJA9I70ZtbgAzwbN04Vg9spBj6zXu72Sm/Uz2/yjk/pRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZl8JVHAAcjtTusu0rrqhXHoeGsM7OZxOXD1scvSP9xpx8c2+9
	VXz8Tj+5WTMC6YiL2nLfxZLHzwfohXaaoaUoizxGLoO9EMhAWLJ95URj
X-Gm-Gg: Acq92OHiSw3AO4RlS3sk2E4IGS02jNZ26hRHns0VawfSxUEbJjwb1RfzjpbgLbMkaeC
	FNU60GNibpM0+0IoINQOYm0E/TTHQ3zYKROd5tFk1p/M8Y1nwcw+fx3UWfeFufUozn00XXe5o6R
	T0v6HvpSDAVa6s5iZomkynZ3iLwZe1KcvCAS8u8A6/TUeXGuDQzBndThEF24hSgfuuXfgi3s8MM
	Z8eJOCMkGQT7dckR3yVeTcaU5d2pGR8KGGgoieHZ25/0XPgBHEReB2S5+Shjf5FxaitWXJoW/xb
	2OqAh8zXft62PkcVJZM+nE6T6rHiiUQ8fSjLYfuUNfGyrQXRDZcWu2o/duy2Rq3tuYMKmU/7h0g
	HlbuOBSLDdEyDo3n9czBJzsORrWtTIJwBNzFGbY9T9tWkJYHdObUkDiH9I6511bxuIb7o4ZWuCy
	oC30TUidElxSgkRgRKLWeozaDIDw8dpw==
X-Received: by 2002:a17:902:a618:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2bd7e9399f5mr2829825ad.35.1778777519198;
        Thu, 14 May 2026 09:51:59 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:51:58 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/4] ipv4: ipmr: clamp ip_hdrlen against skb_headlen in ipmr_cache_report
Date: Fri, 15 May 2026 00:51:32 +0800
Message-ID: <20260514165139.436961-3-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EF37544F0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-247249-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


