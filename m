Return-Path: <stable+bounces-74080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A70D9721D3
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 20:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334CAB2265E
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D5B189903;
	Mon,  9 Sep 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B68+7Tik"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD858189510;
	Mon,  9 Sep 2024 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906317; cv=none; b=LeUsP145nvCLyjlStbkPqVUOFeuTPZDSLJ+Dzz2JE9NmU2bq7KPOo/3E/rLqTk7cnERWWLtShcSInfwc3D0d4DmMMW2bpayYfddRgTk5nZqb+7lp3e+Goi6PicPxNNyjpjATkwEq3Bf7q+bv/FRbG7ZVvMv/kSwLQ9eS2e4bJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906317; c=relaxed/simple;
	bh=Ts/Ac+zGB36ykU/Dq1exHp12pcr0yZ5WbwSmbQyya9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8dps/Lay2pUmgHKj/e6ni6tHVRIWDT3NLf077Q04mkL87MKzvTi9eFJpt4g5HySi20G2Hb3jodqNLtkl9DA2xjEAkHaFtzRtcWjj3SZt+TpRZJ82Kk24qKo7lz101esmo/j9nGYCI1eEycQw32bKVBwoJxoeUOojeQF5sCMHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B68+7Tik; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99fd4ea26so192317385a.1;
        Mon, 09 Sep 2024 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725906315; x=1726511115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnPu7TX7C3KTRthKNKCdbYSD8w6NB8k+65H1weyCIvA=;
        b=B68+7TikYM1nv3OFjJrr5q4+Ztuj9JGqQnnV6xG34i9j0jET6DPHAsuVUj2WQenAOU
         w7wuUkcapUNgh7TkYTRnNzVr1jtgABrH+hTBwm7AxI99GqqjDCpXVULQ+a/xZ01Ad7e3
         UT6zG4MhDWovnycrfAHdWtDUxfpcgG5MnPRV9Ze/4qnNpcAeDitRRomkadMkzXTaoCv2
         emcQSPE5bhf/Hfa13AktEwcxc+GHo8TBhwriucOZbrjpvx9pION7zv6KgpyP5JwxaSGE
         4BsLEFd1srqWJPsuFdd0I5s9lwb4/la29gXwiX9OVvNnAgRiOmv12tBde42mAPvOqaOR
         CZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725906315; x=1726511115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnPu7TX7C3KTRthKNKCdbYSD8w6NB8k+65H1weyCIvA=;
        b=uII1Eg2N/mY643T5EmZA3+9as9+E8SJsVfIG3tjrR8G6zdFKBTpgtFS4JuJtzvsiOg
         BJFQ8XrOV1sZxibhrgXAC3wTMubuMmX+5Okm1yGyT7zk3vkkgXPrHWC0VpU5zQmrc3we
         XK0IIpFoIrPMqcuslWBCWao+kkWt7WCF3r2ih1sxuEADM5dh4JPoCmhMUjR3xsqhGM4k
         yC6XXS7MYoFwOuSfgnaYaBOzsmrYsn/sAJb6qn0oSTdEQTcBLMQzk2PkRVkz7mHnbrsP
         OjrZsnQ9n9mrE4nQ8aIgtVs0KbXfaWvB+vO1Z5eqz7OGhIWwFDJyQdmjEj6/qyMagXEL
         PVpQ==
X-Gm-Message-State: AOJu0Yz2N+Am5yU1rK5tI5EPDzEPdPFv4i2ZEi5VRv7V1mkop1hCy6QS
	hfr+P3z9mhm0fcU9DuXe1F2ojyLbsasSvQiyb4SLGQSvaHGoQmvWVw00SQ==
X-Google-Smtp-Source: AGHT+IHRPwH5l1L/OckqnB+sOIu0Tf1VjIgCVsP+1q9FVX2DFYm7SzY+9FSeC2KeIZ4f/CilDSm8xA==
X-Received: by 2002:a05:622a:5d2:b0:458:a70:d9b5 with SMTP id d75a77b69052e-4581f4753b7mr91610491cf.15.1725906314676;
        Mon, 09 Sep 2024 11:25:14 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e9b231sm22539071cf.47.2024.09.09.11.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 11:25:14 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	christian@theune.cc,
	mathieu.tortuyaux@gmail.com,
	Yan Zhai <yan@cloudflare.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 3/4] gso: fix dodgy bit handling for GSO_UDP_L4
Date: Mon,  9 Sep 2024 14:22:47 -0400
Message-ID: <20240909182506.270136-4-willemdebruijn.kernel@gmail.com>
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

From: Yan Zhai <yan@cloudflare.com>

[ Upstream commit 9840036786d90cea11a90d1f30b6dc003b34ee67 ]

Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
packets.") checks DODGY bit for UDP, but for packets that can be fed
directly to the device after gso_segs reset, it actually falls through
to fragmentation:

https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com/

This change restores the expected behavior of GSO_UDP_L4 packets.

Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

[5.15 stable: clean backport]
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp_offload.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index c61268849948a..f0bc91af94d7c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -272,13 +272,20 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	__sum16 check;
 	__be16 newlen;
 
-	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
-
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
 		return ERR_PTR(-EINVAL);
 
+	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
+		/* Packet is from an untrusted source, reset gso_segs. */
+		skb_shinfo(gso_skb)->gso_segs = DIV_ROUND_UP(gso_skb->len - sizeof(*uh),
+							     mss);
+		return NULL;
+	}
+
+	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
+		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+
 	skb_pull(gso_skb, sizeof(*uh));
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
-- 
2.46.0.598.g6f2099f65c-goog


