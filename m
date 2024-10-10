Return-Path: <stable+bounces-83349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E429985AD
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 14:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65401C23BB6
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 12:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3621C5788;
	Thu, 10 Oct 2024 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SNR2YilX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000E1C4600
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562525; cv=none; b=Kqu5rYgjx2T8Zym/aNINBGT8KedUtQFsh6pkXOr4KUMVT56x+6oX0gI52odwY6P+NF15bNbwWYPqHhj34ZRO3hqRThP0q2P6PDhW5iJMtHbIxvDdEAr8aUD95DrY4i99ESEE1AcrjrmCkh5a02USCTVRdiWdJZNocWtLZkGCNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562525; c=relaxed/simple;
	bh=k6jsV6eAAVGv1vneV2uvgUaEC9QP+DZwtAFnnsCcVIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NVb7QRt388bWBOyDPtQGvNycVSCYZV5A9LND/82LEFz0Gr+NzYWhWdK9eRH44U5JVPx+NsVFIRMhHzdNo1E3cJtcEpK9cWjvEqIr4f9NV9e7giaCwB5rMqdaqGqYkPKGShnx//zWgRIYo0qij89CeGXLgbmxvL0JsyXEOBkWeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SNR2YilX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a994c322aefso361241166b.1
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728562521; x=1729167321; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTB4CA8vPwZAJs193fATKbyWYbE+AvklNbOy23zkFao=;
        b=SNR2YilX0kcskFfPT/WpiRWBoHFaZR9h0pQ5H2K+epnJ2KFAzDeG4KPYIYaEck2a9x
         bzHX/KEiEAqPIkvPmgirKgdXze57/5U/hQI6n35iqGZGx8mrvh1ZjiNgPUsqDZSWdIfH
         iNd2a6jGX5abss29uq7+3vXF30GZd0k3xYo+7IY/Kk6bKy2B0+knt8JXVz2eMkBAgSDV
         utpnLuFZw7ipyRITIn3JsLDpHAud70aZ59zzVeCyYOTkb/QhkvfEePtPRCxSsY65g/ik
         hYY3L8V9n0YL+9P9Lwsi/rR4EW7kVVfTy8ZZ7N5HHCnABdNHnt9sACkBCoirrCw2DWIe
         hQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728562521; x=1729167321;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTB4CA8vPwZAJs193fATKbyWYbE+AvklNbOy23zkFao=;
        b=gf7J+AnsnybMYV2dQ+chfcQGVBAO4AttDJdoVJK9eYnj06elEC1py1X3kseOiMdzCV
         opXtx56bbAn1SjpNLKeuoqtQ1l3hQh40RKoXWujge/zxHB3KVq+sdZ7vkAMU1ZeHOGV9
         XpINlTUmOwBd4q9VwKcchXr1Y3bHDwc56R+QPWZ2y5KgXAYFvguTKJ5gQuq83qNYZs+6
         wBferSZaG6mfHvR7/LIvSw7tfwvEAP86RnIeBkCJ6Q5NtMgvDzVemH/34aXfXDTlhm7w
         iBO+cLKcRe9l6AQG9s6r/x96Pva0T7kMSsLu9vz9vbBCQiIuNZDhlrsG6UFs/ZVoHXik
         T7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUpZfD/7ivMy293w5EztOMhouUUb6m/FxvK8xmgdTjbaiol123CwNQDeLXiLRP+KAYtBQue6Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAhs/YRKX9CZ3oq6DSndWvhwz70fU4OXYYdBkgIdCK6evK5D8X
	72+WVawU3GOVM3mfwybwPTnG8KHokmrRHLHFB2qOHrz195W9GmMehuyOj3lDCoc=
X-Google-Smtp-Source: AGHT+IF57luNcC9P/84mWhp6q5rJF2Tq5Fu0EA3TARlpVPUCGQaKnGN/HFqjTdzJWhB9rZanKuPxCA==
X-Received: by 2002:a17:907:3f07:b0:a99:5587:2a1f with SMTP id a640c23a62f3a-a99a11087b9mr321198666b.15.1728562521056;
        Thu, 10 Oct 2024 05:15:21 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:1d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dcd03sm81776466b.174.2024.10.10.05.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:15:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Oct 2024 14:14:53 +0200
Subject: [PATCH net] udp: Compute L4 checksum as usual when not segmenting
 the skb
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-uso-swcsum-fixup-v1-1-a63fbd0a414c@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIADzFB2cC/x2MQQ5AMBAAvyJ7tslWRcRXxIFa7EFJV5GIv2scJ
 5OZB5SDsEKTPRD4FJXNJzB5Bm7p/cwoY2IoqCgNGcKoG+rlNK44yR137LmubG0HsjRCyvbASfz
 LFjwf0L3vB1GTAVpnAAAA
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Ivan Babrou <ivan@cloudflare.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

If:

  1) the user requested USO, but
  2) there is not enough payload for GSO to kick in, and
  3) the egress device doesn't offer checksum offload, then

we want to compute the L4 checksum in software early on.

In the case when we taking the GSO path, but it has been requested, the
software checksum fallback in skb_segment doesn't get a chance to compute
the full checksum, if the egress device can't do it. As a result we end up
sending UDP datagrams with only a partial checksum filled in, which the
peer will discard.

Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
Reported-by: Ivan Babrou <ivan@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Cc: stable@vger.kernel.org
---
This shouldn't have fallen through the cracks. I clearly need to extend the
net/udpgso selftests further to cover the whole TX path for software
USO+csum case. I will follow up with that but I wanted to get the fix out
in the meantime. Apologies for the oversight.
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


