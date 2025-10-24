Return-Path: <stable+bounces-189240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD287C06DE8
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 17:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B4584ECE93
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 15:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759853218B8;
	Fri, 24 Oct 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnAun89p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36A21A447
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318499; cv=none; b=dEkozUBnwkHffFE/QJs05A0x9XXx4uhyH2j3JluY9UEf5COSBeCLpF1F+26B3b2HTlscx7woHdKuvP6o8eOtwVL23K5o9Ns8Vy8SBa1Es5Jazu/Zk7uuXPToPrh+vw7kA1SN1abFgNN9dUGGd1z6Sz+SpGvgA0+LgLIX2wpWqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318499; c=relaxed/simple;
	bh=Gg1nmF2BIwqahLlAKHrDdQElBJulqFj/VnBEXgD8/+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YytsLMcPeKkYyTNe/ZCBSSNTjT9M+kf/I5ClGRz2T4lXBhgyRulfvAvaIAoKewDp1Qul5Fh81RbUU+fk598OEPw6ia6mcTyHPDY7qcExta/kvrIG+N2A7jlt2qqcuqcJHVBG4i0a4nab9Dq+HaAklqOYSthOKbXt1Fw50aoFovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnAun89p; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso2138836a91.3
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761318497; x=1761923297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5kuodqL1XE4BwxT+c9wdfrA/FtLyiL1+q+ub9Uk7uI=;
        b=EnAun89pyTrJgxUFpbSTXx5Ja0hCXY4VfC5cLjuy6BnooYgt3rzZQ7kLk68XB0izhd
         ye0SZYQEePaCpVdBz0NRQlTuPYv3diej4wK3hdnteLODYSQkmAtu8zzUl/z1YxGCD4sf
         WNQoA0c3NrWR5ZQ79via0RgcTn2n+GiBqLPRZ5uz+9dufaf/myzDtERHXCo3sB/79b0G
         AQ1ttweGxr2lVCF4t8scwINDrrhVaJ9/x7wMu2yEOx4l4LwSNRtaIvz0DjrvWz9qWUzU
         gIN8mGUyTwDyOeJ6Ew0MIOvERF41bIjcYKCHsA+3RjXWzSWVReIir15JX5EQ1S+VrJ65
         8NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318497; x=1761923297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5kuodqL1XE4BwxT+c9wdfrA/FtLyiL1+q+ub9Uk7uI=;
        b=KYb1cbKNpPZInAlm8sOVQZIEFeTUjaf5vHeWNgknTLWL+fGsNmJYz1Pjkv8+681szn
         kaN6jZK1Ii9Ox/HtzJX9rJDtbcivkfzVBRSf/5jwCRkqKjmCEuyg/WY5eqM98Etj5TpG
         8oYH4lITaZ5TDmF8HmTdPP8K9OioV9oo2DK4xSEZaI26kQkqcxO9qWfMDmaLpAeImZv8
         C/irEdQHfuSQQwcEWXoo1//XdTgijw/HzfYmseKn/BqlCNRqgJ3U0942WnLa3zXqfKKG
         g7CkxKmACKFP9BQ35JN6DVLeUPtUFGEOF6Jt1Yt+W6+PxPvebv6tOcO4GBqq8xUxrxVC
         LcYw==
X-Forwarded-Encrypted: i=1; AJvYcCUlmgc0vMB/Ur1Dv102yNW45vf+y6GSh52pixAev4V0B48gvJLyBN1a05xsJkKawd9YLhE7Is8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ucIEkq7bknfZcc2iqLKWZ5C/JC0vv5K1gzQrCBuEF+Ou1NyB
	YhrSmwrIAHkNy4fq3bvtwNX9eaz+7fbzl19rgiGuqjq9H85AoeZwLe3j
X-Gm-Gg: ASbGncsZLiS1Zy6voE2iduMZuxqv1Z5/7Op0FDMouBr/BwfvErNj+gR+etkgIVuHyXC
	hn2D8H3YwbXzz9GgriJsIJDkTWth4oeObje0DsfiltKJOLpOcX8O7APEdFtgZa7cGmDgnHmok/l
	Bc+gEOowprASXJqgDFV4i70sWuocuwBLcyNjexDzKfnUt6EDNS3Kx3Nwg3d0VLtboLJ3RMdGKg0
	aX2xtS4/39Caq0N4yIPvW9gqXxwRDUhGgK9okdDr3Oz0U6V44x/Oug3YTdtqY2rD/0cyOEbI/ZR
	ZZ9ak7Ma2JLni6BQVgyjRYe7xKuuIYqrinMKnhCmYivAf4LKQM0C1K36sa9P9vCIM7Rm/c2uwnJ
	qqEPow+Tkii3YxYBHvWlDywRcMrlnYFUYOJeY7Gv/4cPNmtOiI/UTPbHNOUp8IxTm/Y6LzfUAsm
	zzs2nxY0Zhrqa7acwnalUldWmR
X-Google-Smtp-Source: AGHT+IEIvsCPeZId5sB7KWJU1zEUO/VQOzw5rKKQ7D/ehXSXh4dGRIiEaa8KnJaPfgpC64pTh/Lipg==
X-Received: by 2002:a17:90b:4f:b0:33b:bf8d:6172 with SMTP id 98e67ed59e1d1-33bcf92aae9mr35463946a91.34.1761318496553;
        Fri, 24 Oct 2025 08:08:16 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:4deb:2cfc:5afd:7727])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33dfb1db6aasm5934227a91.0.2025.10.24.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:08:16 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v5] virtio-net: fix received length check in big packets
Date: Fri, 24 Oct 2025 22:06:49 +0700
Message-ID: <20251024150649.22906-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), when guest gso is off, the allocated size for big
packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
negotiated MTU. The number of allocated frags for big packets is stored
in vi->big_packets_num_skbfrags.

Because the host announced buffer length can be malicious (e.g. the host
vhost_net driver's get_rx_bufs is modified to announce incorrect
length), we need a check in virtio_net receive path. Currently, the
check is not adapted to the new change which can lead to NULL page
pointer dereference in the below while loop when receiving length that
is larger than the allocated one.

This commit fixes the received length check corresponding to the new
change.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v5:
- Move the length check to receive_big
- Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
Changes in v4:
- Remove unrelated changes, add more comments
- Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
Changes in v3:
- Convert BUG_ON to WARN_ON_ONCE
- Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
Changes in v2:
- Remove incorrect give_pages call
- Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..2c3f544add5e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		goto ok;
 	}
 
-	/*
-	 * Verify that we can indeed put this data into a skb.
-	 * This is here to handle cases when the device erroneously
-	 * tries to receive more than is possible. This is usually
-	 * the case of a broken device.
-	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
-		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
-		dev_kfree_skb(skb);
-		return NULL;
-	}
 	BUG_ON(offset >= PAGE_SIZE);
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
@@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
-	struct sk_buff *skb =
-		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
+	struct sk_buff *skb;
+
+	/* Make sure that len does not exceed the allocated size in
+	 * add_recvbuf_big.
+	 */
+	if (unlikely(len > vi->big_packets_num_skbfrags * PAGE_SIZE)) {
+		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
+			 dev->name, len,
+			 vi->big_packets_num_skbfrags * PAGE_SIZE);
+		goto err;
+	}
 
+	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 	if (unlikely(!skb))
 		goto err;
-- 
2.43.0


