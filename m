Return-Path: <stable+bounces-78561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DA998C44D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABB1B223F4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1281CB53A;
	Tue,  1 Oct 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a41g3W32"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103CE1C6F54;
	Tue,  1 Oct 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803080; cv=none; b=ROEbgYpI3iORtMbplG+hIJ+BMU7rOdmbU49HJzpSRoxBZJHFGwAR59DwiNkzNbF9B1KYddVMLHJzg6GTy57dyOAXiEFPT5k0CjcUQBGVZfBeKmWkNOAP+8Hsml8/gkkOLR9NqbLi01K7gPeOzHX22Jqvihe6ePYJXm7U1WOEuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803080; c=relaxed/simple;
	bh=lnkQV2K24nseJignN+AR3Y8VuDdcOEW5Th76AN/3fIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/CQjx4xb6l9idV9xGBeF4PRlsxccfdoK48teLO69M4WG9p0By60EJpjQIbMO3YhVzQAbYgKG8Cz9JykF6W8Ni5dj5bVKh8OxGAMn3u4PbhYM0OycON3MSakQceIOrDz/lJZgdPaJOliA2RhpGWlwa8BrJzc7LFB8MSWXQBEwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a41g3W32; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45821ebb4e6so48661701cf.2;
        Tue, 01 Oct 2024 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727803078; x=1728407878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dL2+jAlecroOKNLX5C3sYaHHGi+H+0q2TzNV+QlzKqk=;
        b=a41g3W32uqGkWYO+V97YOJuogD7R6yfaBGdl0+GeGfvwJT0/bfw1AcBMPlOvjPPjjQ
         Y8H2IuL4d+nyT2SvcaOpGn+/j4aFJdOflHLf+9GLQUeezGjZLDEVAdrNsk4Zuu7nVOcU
         k48ljw+OothBjRPKXxu3sKWqO5apuRlNYM1OG3xpakOpVkztSaXtGlng/wOMRV9SxO3M
         IEP6UxlxuDKHxvgmcH+0DRaAriCT7shq0lusbjPCeys8Ej2VLMsS+CI/c3/mTD9aeq1a
         FLtTNQFO7znGC4UX01BIiJT586DNnT2fIMAcaxj4BtPTTHy+qrIU/xjJStipO5sIKo73
         fYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803078; x=1728407878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dL2+jAlecroOKNLX5C3sYaHHGi+H+0q2TzNV+QlzKqk=;
        b=QM943qgySnCnv5LM37ohfJ0dPxLko8HnTCERd8K5nnbQjTvrWv+D/aaD/aWQe8+Fx9
         gzoogV9VnPqd+lTSHN0QVJgRZMSEAgPY0nM5z3nJPENUaMG0CsTJP/ewXXeAWuuvkFQs
         +WwIXG9L9fAS+46WzgkH/AC4KQyoyqzu4GhLz44RBwUpELoPluijRvqBjhLFbXCnOXPr
         aEix7r+Y1rvC9zCsFeEsNqUN4ZwDMyKqUvPDH4aOqjdVVyW72aZXHW5AehrzO4J+f/SS
         r3Lhihp4P1VkGBr1zg/8RQdNX7hMdgXkb/uzHwqzAfpwByxfwsWW8rpfqJhkM1gw297K
         kG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6IJJ6UjycSKnQK7HShPzqpUqb7HfXw6MNC8p3RK5U0JRvNbta2XW7wxBo3hlIUdg+EMx4aCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ksIQw0AVQK45UAvWp+UiKMZx3UmLCSLZBO79tQq6WRoRVm2C
	4wTQ7y9TSWvqfqQrdN9oAx1er2tgNCzo4lWyg7K0fnRpPeZTZJBhAQmWtA==
X-Google-Smtp-Source: AGHT+IHspYBcPYnEwwKA/jY0nLvmGsuUwW/p8mdWZwnL0t18eBZVCPbq+8dq6XAdrDfgIi2PXxLPZA==
X-Received: by 2002:ac8:580a:0:b0:458:23fc:1473 with SMTP id d75a77b69052e-45d80562129mr5281811cf.56.1727803077763;
        Tue, 01 Oct 2024 10:17:57 -0700 (PDT)
Received: from willemb.c.googlers.com.com (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2f2264sm47679021cf.56.2024.10.01.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 10:17:56 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	maze@google.com,
	shiming.cheng@mediatek.com,
	daniel@iogearbox.net,
	lena.wang@mediatek.com,
	herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2] gso: fix udp gso fraglist segmentation after pull from frag_list
Date: Tue,  1 Oct 2024 13:17:46 -0400
Message-ID: <20241001171752.107580-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

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

---

v1->v2
  - update Fixes tag to point to udp specific patch
  - reinit uh->check to pseudo csum as required by CHECKSUM_PARTIAL
---
 net/ipv4/udp_offload.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

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
 
-- 
2.46.1.824.gd892dcdcdd-goog


