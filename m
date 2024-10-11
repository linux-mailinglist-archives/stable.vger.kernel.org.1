Return-Path: <stable+bounces-83444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E78F99A3B7
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D669E1F253ED
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D90C212F13;
	Fri, 11 Oct 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NCF+0ZvP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFFE209662
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649064; cv=none; b=KRvQvo8rNG/MvjjRdaX3kFJGKpE4V18QeKzgo8V7MY0fFxjnltjvUJz39l4Xb1qve2ZNCrIJ3RPEhwzyTvV9vm4CGU40V8vtp5ovaE3d2WLbPYnQQtr896VcvrkHgPY7vle5uFkseLpYkVEk+xeXfHRZvAMAxogJpGAfGJccovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649064; c=relaxed/simple;
	bh=eO62LU8SoD1YfaUuQEvmxDbXmclSlnyio751UBysGvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gJCEQxes7ZVxQm25UnhoFFpXGuG9Z3yNa5njM3e4beo0ICZC2PxGCaxGmygicW9uJXQasx9/qkKf6Bj7BP4PCSrqmCph3X/li6HcZwhVwG5FBDTl6mK+D9bMzyaw2WJewBOH9h8pQbUGNQRsloqgzglv2dbWi4wtjTu4z3np9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NCF+0ZvP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9950d27234so283558666b.1
        for <stable@vger.kernel.org>; Fri, 11 Oct 2024 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728649061; x=1729253861; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YmRhYjgKFlXwHdCjp7CMmqDJ+gSj4F4GENuDhEWENZk=;
        b=NCF+0ZvPSNQu++EfG9IMtYHGoQoCfSad4cKoTIf9/OdS+A49vx4jpwnxe6QIgV4huA
         0ADUz73Spw/dYQMPQD0cLoWGiNXRnSod+3dxIAY7gSrKMahlURpmB/TxEfm+kD9uqQCp
         y9Hx8eAyPy0XEY3TC8rKhkxyzexchuHpM8BWORyEXRuoyeKvJigATRG1wER2cO6SWoUF
         yH54wvU+56Jc77Kz45tYmbXwY/TvWlUH758d4/jbFGe3cwHZOgDUl2g2rDIl5iCYvnWH
         NiP0L+iQEzHM3tsrBhJ7h4Uj66psg6EobBbsRPfA+6UOHEug4O0k8tZ8tmXMUe8cWrae
         PV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728649061; x=1729253861;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmRhYjgKFlXwHdCjp7CMmqDJ+gSj4F4GENuDhEWENZk=;
        b=F7+4GUgUjWt47OYRp7NEJ45l7r6MtsZK3A2TB+Vg1hdQaOvgTLidxQuagGI887qoQ5
         /XA81kScM8HUhvegujPIAaTIRIHQYC/uLhG69v1iVlY1yPOGfbEoe6ZKIIQkd7NXtF0u
         RX5yxTB09b0hVHjcENQrKNUcfLd9H7speWG1t3/Bid44c4WQAgioQr+VrV8Y4gEYvile
         xZdOWHvGnkRmDGJOE0lki+06rMS2nMNomTKVkWWxbyqNdcag4V7/dwtiq1mN/b3rFZdt
         qpFunRu5JGNYakkzxAcKjEfsmzDy35/eObLNhko9t4GfnO/2jwZm8sS1CRf64RcWKxon
         Hxmw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Y90tRilfEkPucNMiOkftPikhyC6oknvhjYGTtnKZ5bmsQmOUO8I2RjxdzyoSiDEtmVFi4Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM23NBgv9hojnzxg9mgvNjpAtgf1Ax2BDNya/2BU91VgpDsWw5
	lVE8yf60HqUalgnF6HFsoViPkVOHd86sjqcm2Z+9u1NOMc9T/mpOZdbIgquo4ZQuJr6Gv4q3nlq
	V
X-Google-Smtp-Source: AGHT+IHU0QNA+MmfpW76pz3Kn9cahurQK/twSOi5kFjPmPf5N0OSv0hj4JKUVaQsxLIaBgR+2Cg5DA==
X-Received: by 2002:a17:907:f15b:b0:a99:7b6f:c8a7 with SMTP id a640c23a62f3a-a99b9582f23mr210085066b.46.1728649061069;
        Fri, 11 Oct 2024 05:17:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:1d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f29cdsm205928466b.210.2024.10.11.05.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 05:17:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 11 Oct 2024 14:17:30 +0200
Subject: [PATCH net v2] udp: Compute L4 checksum as usual when not
 segmenting the skb
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-uso-swcsum-fixup-v2-1-6e1ddc199af9@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAFkXCWcC/3WNwQqDMBBEf0X23C2JEZGe+h/FQ0w2NaBGskZbx
 H9vyL3Hmce8OYEpemJ4VCdE2j37sORQ3yowo17ehN7mDLWoGymkwMQB+TCcZnT+k1bU1LWqU4N
 QwkKerZEyKMoXLLRBn8vR8xbit9zssqD/xl2iRN0qN1ihG9mYp5lCsm7Ske4mzNBf1/UDAgdBj
 LoAAAA=
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Ivan Babrou <ivan@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1

If:

  1) the user requested USO, but
  2) there is not enough payload for GSO to kick in, and
  3) the egress device doesn't offer checksum offload, then

we want to compute the L4 checksum in software early on.

In the case when we are not taking the GSO path, but it has been requested,
the software checksum fallback in skb_segment doesn't get a chance to
compute the full checksum, if the egress device can't do it. As a result we
end up sending UDP datagrams with only a partial checksum filled in, which
the peer will discard.

Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
Reported-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Fix typo in patch description
- Link to v1: https://lore.kernel.org/r/20241010-uso-swcsum-fixup-v1-1-a63fbd0a414c@cloudflare.com
---
 net/ipv4/udp.c | 4 +++-
 net/ipv6/udp.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8accbf4cb295..2849b273b131 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -951,8 +951,10 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
 			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
 								 cork->gso_size);
+
+			/* Don't checksum the payload, skb will get segmented */
+			goto csum_partial;
 		}
-		goto csum_partial;
 	}
 
 	if (is_udplite)  				 /*     UDP-Lite      */
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 52dfbb2ff1a8..0cef8ae5d1ea 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1266,8 +1266,10 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
 			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
 								 cork->gso_size);
+
+			/* Don't checksum the payload, skb will get segmented */
+			goto csum_partial;
 		}
-		goto csum_partial;
 	}
 
 	if (is_udplite)


