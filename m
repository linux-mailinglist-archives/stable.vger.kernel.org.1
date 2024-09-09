Return-Path: <stable+bounces-74078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A79721CF
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 20:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70657B2287A
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CAF18950F;
	Mon,  9 Sep 2024 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccqul/x5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89C17799F;
	Mon,  9 Sep 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906315; cv=none; b=jMLeNhsqYcFRWr0xGvMQnCD6ZMgDhtrsBQLpsOBeJuXJDLhdqVHHxP3Oud/tg8y20+QVIZnf/guYa0OodHTIwkm4swTAjTaXjIidcikCkMjyFZjmpeZS1JWCqK6r3rfBLntMcR5EKatJ1LZ9TQw9RGZQW1IUzEhemOZtxwk1TCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906315; c=relaxed/simple;
	bh=45l4S9sDOnkZMDqFyTuQSTLHbSwbgq6XZFmuvHeh46c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gc5DErrsbRktwKsnF4CAEkd7PfjHhDfwNel6ntfCzUizI863WMzuk7b41ejEn9gi58GZWw1vyRJqEZ6upGShRcq2NULRIkwTKCe6vG6MThT+d/STyDZfrzpbXpZv3lmdHfwT95WTGFjcZDEPJAKyn7qPIgrTrejd6HGMR2KsnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccqul/x5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45826431d4bso11479231cf.0;
        Mon, 09 Sep 2024 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725906313; x=1726511113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl2h3nH890XCPuBqDE9iWH/23/OUuljwY/dx88x4zZ8=;
        b=ccqul/x5HZ8oLz60fECSsu3lKE0BjcCRgM0VKT2IeonUZ8+6htSLa3rmkH/0tonCO0
         3gULLc7tOsgu2+BvS9Q4/sdPlwpXUj2FGpUBI9n6peHhflnMRlBPb6c5Vbp4FaoNeKVO
         7i+asBfi6Wn2BmpbMzVW7foxpyy6KER72Ygu5ypJaYa6oI/zK21Y+6XAvV9t0T/s4dD0
         XFefP1+AUMshx3MeyrXvi0EmruhqzT2wGvYMbpWBIenDKGFgHkrafRZUPpame6DJzWpQ
         JPnO56sBn0hcHre/PUGL5hcSWMOOvtB67zuU/Qz4HVSC4XGikkwnJuTfpmiBUzEoMqEs
         JtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725906313; x=1726511113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl2h3nH890XCPuBqDE9iWH/23/OUuljwY/dx88x4zZ8=;
        b=mEfM5X4KPfQ4+3XTMwurvOMkZ/bexA8t8MhdtOAiZ51n//plYnWj63INVNHiifl08p
         FHey6vUB/5OSKSMFQ8gmVb+SDXzv3bw+mlhlXE2rZqSgBoCzD/fp407Uhy18xJo1/u+A
         HWazsJuZ5WSkD+egI++O/8uFNiG5C148bzZE2mE5ZmzAD5rTXTFOvnHQGETPluL8PznX
         dAReh+pNEcTvdfE5PCkqsHEl4Pk4NWI2Vxq+GyRROkUzFFpjnuXWiMvygwQ1X5dz+1ON
         qhRIf3h9Jt/TwJ15yu6fg46SwvC06XG9uT+Qh8pYlTjHznSlPjVeBxbmjPdgrue9m7BH
         qALg==
X-Gm-Message-State: AOJu0YxIrDx0Ik35YhFc8bec/Sl1c/g+nt1W5gtG6tNSGgqRCtJCv80t
	PxzsGix74lQO8XlVubCBP2QKHyoT8gleFkpH8o3umzgD+mDvdnv0c4iTEQ==
X-Google-Smtp-Source: AGHT+IECppETEAvkobv6B0BDTmHRUfu7uuGzEj1qNtwc5mmHYJTO3LdekRw/ZQnY12A+1SzyfJYevw==
X-Received: by 2002:a05:622a:2c9:b0:458:3d1b:8de4 with SMTP id d75a77b69052e-4583d1b921emr1405781cf.39.1725906312204;
        Mon, 09 Sep 2024 11:25:12 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e9b231sm22539071cf.47.2024.09.09.11.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 11:25:11 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	christian@theune.cc,
	mathieu.tortuyaux@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com,
	syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 1/4] net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
Date: Mon,  9 Sep 2024 14:22:45 -0400
Message-ID: <20240909182506.270136-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240909182506.270136-1-willemdebruijn.kernel@gmail.com>
References: <20240909182506.270136-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit fc8b2a619469378717e7270d2a4e1ef93c585f7a ]

Syzbot reported two new paths to hit an internal WARNING using the
new virtio gso type VIRTIO_NET_HDR_GSO_UDP_L4.

    RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
    skb len=64521 gso_size=344
and

    RIP: 0010:skb_warn_bad_offload+0x118/0x240 net/core/dev.c:3262

Older virtio types have historically had loose restrictions, leading
to many entirely impractical fuzzer generated packets causing
problems deep in the kernel stack. Ideally, we would have had strict
validation for all types from the start.

New virtio types can have tighter validation. Limit UDP GSO packets
inserted via virtio to the same limits imposed by the UDP_SEGMENT
socket interface:

1. must use checksum offload
2. checksum offload matches UDP header
3. no more segments than UDP_MAX_SEGMENTS
4. UDP GSO does not take modifier flags, notably SKB_GSO_TCP_ECN

Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in vnet header.")
Reported-by: syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/0000000000005039270605eb0b7f@google.com/
Reported-by: syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/0000000000005426680605eb0b9f@google.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

[5.15 stable: clean backport]
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/virtio_net.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 29b19d0a324c7..137357fb6a574 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -3,8 +3,8 @@
 #define _LINUX_VIRTIO_NET_H
 
 #include <linux/if_vlan.h>
+#include <linux/udp.h>
 #include <uapi/linux/tcp.h>
-#include <uapi/linux/udp.h>
 #include <uapi/linux/virtio_net.h>
 
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
@@ -155,9 +155,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		unsigned int nh_off = p_off;
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* UFO may not include transport header in gso_size. */
-		if (gso_type & SKB_GSO_UDP)
+		switch (gso_type & ~SKB_GSO_TCP_ECN) {
+		case SKB_GSO_UDP:
+			/* UFO may not include transport header in gso_size. */
 			nh_off -= thlen;
+			break;
+		case SKB_GSO_UDP_L4:
+			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
+				return -EINVAL;
+			if (skb->csum_offset != offsetof(struct udphdr, check))
+				return -EINVAL;
+			if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
+				return -EINVAL;
+			if (gso_type != SKB_GSO_UDP_L4)
+				return -EINVAL;
+			break;
+		}
 
 		/* Kernel has a special handling for GSO_BY_FRAGS. */
 		if (gso_size == GSO_BY_FRAGS)
-- 
2.46.0.598.g6f2099f65c-goog


