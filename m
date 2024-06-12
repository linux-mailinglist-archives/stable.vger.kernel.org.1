Return-Path: <stable+bounces-50185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7C9047F7
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 02:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06371C221F1
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 00:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D96F137E;
	Wed, 12 Jun 2024 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JaFQLcvU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B932391
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718151431; cv=none; b=Jl2SjhN4k4ZvorqT+57Od4EnQi8n3gAdtqkX97xgKt/TSQGKAQksYyRmkcfTtPENZUkSg0R0cE3esFlWmQwOaPbbZai1KADCRqcTTN0zqvpTI5ybHuWX7QWYNsf+iN6FU0xKK+Etdyi3IPESJfhHxXCRQw7oxRxV8ND7G8O2Az0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718151431; c=relaxed/simple;
	bh=/5CStUD3+h5vLHrk8rbpKIF6eAbRF4CgImyTE/vqojM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bj7sHWg5h5A6J0JIKaJWZHQu0SYollexBs5Ic5bKDEkgF+JepYW+Mg/1TIGw+i8fn3DhbBCOMDJjKNvqXzweHVRiZ9SiCef7IZ/DJES+EgI7APOXNu6aicssbH14g5JmEutXCe3wEtvDCO5FHPABLf8naxhROQpiasR9WbwMcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JaFQLcvU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa7a8147c3so10431714276.3
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 17:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718151429; x=1718756229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NOJsof7BEpZN8Hpp/vHtOuty3r3bM9rd+pyvN7nHOJo=;
        b=JaFQLcvUIcMZ0z3XkemQNaWk4yyBXW9wNM//vgLx9gjtquHce4tNbpkQlown24GPrh
         jzPndxXLTpOSugpLwcwR3P3TFwqoCmwdfDHxQTIY3Uo0IrL3b0mOiOohWCxP6mTggkFk
         dcOm6MTCsPo/jzYMA7ycR/9wtWVaCRe83+TWzOxlRdBOz6YVx0sK3O/QH5bY/xYKGTDa
         Lux6gxmA1wu2xGzZQK97O+5MD1I7izEtCR6893Uu/MTqApmKYqTZwjdgwthtBRAa3M5k
         FMPdHqIopXmvHWkyJHDZJYa3fvgN1u6tVqFKFipWaTh1eh3vIQDy67LZwmIwkq1o20ol
         myqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718151429; x=1718756229;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOJsof7BEpZN8Hpp/vHtOuty3r3bM9rd+pyvN7nHOJo=;
        b=vWo+A7FL2jeMm2wayjhNoEaUNor5m6AI3qAQ+1z/SUO3+ErPWm19BFm9ACQ7KoEe9l
         jt5YpuUCmd3Jpm9fKBN7E3rcKrHi8MF6DuKp632wFmJbFbkuiE0pb3Jsk/QajLNdjB0/
         MYhBDW9Gd15Cu6jwk9d476j3AhgyF6jRvGGSaXmC7q3YFF7NGljdkE7OeOI8+9GSS5NB
         cTwiH9a7VTOb8D41qkM4xFoasIN4sZaEvFOc3mWs1DVvPuzGJm87KvqWOz90cLqdjsea
         KOGcyE01xfI37cnsEqzVi/zdu43ltN2SRQNGT27w6vT6pT1Ttykx7l1U98Dx4z5xTDt2
         Y8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCX3TImJ63Kf00g4SxCY+XwOcQ1jolTMJ1GpvDUYkNF9l6zHWgWxRU1cbljtqfGNpSQmauj9j4haLYPJD1iszUt6QS08RSXL
X-Gm-Message-State: AOJu0Yx1BkjgGS6bD3jzWl1/1vGp/0rXIVR9FBJUHwyyMiWGsZat/8OO
	j6OlVct1F8pxvAPH/DgGgo1UnE16B12pbxVMhngEBvUpXgR+WFWAweFZkXx0ykTVcUu6IXOdRIP
	R4xEG6QkxRUUsCg==
X-Google-Smtp-Source: AGHT+IFj5q7Yo4YsIJsQrLQYOROHj6YJ7et7llRDI8ZMXDiH4h4WLHCf4vHI/re4F+qzmcJAh1iw3DYuY1CbWUQ=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a25:8702:0:b0:dfa:b352:824c with SMTP id
 3f1490d57ef6-dfe66b65314mr59562276.7.1718151428817; Tue, 11 Jun 2024 17:17:08
 -0700 (PDT)
Date: Wed, 12 Jun 2024 00:16:54 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240612001654.923887-1-ziweixiao@google.com>
Subject: [PATCH net] gve: Clear napi->skb before dev_kfree_skb_any()
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, pkaligineedi@google.com, 
	shailend@google.com, hramamurthy@google.com, willemb@google.com, 
	rushilg@google.com, bcf@google.com, csully@google.com, 
	linux-kernel@vger.kernel.org, stable@kernel.org, 
	Ziwei Xiao <ziweixiao@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

gve_rx_free_skb incorrectly leaves napi->skb referencing an skb after it
is freed with dev_kfree_skb_any(). This can result in a subsequent call
to napi_get_frags returning a dangling pointer.

Fix this by clearing napi->skb before the skb is freed.

Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Cc: stable@vger.kernel.org
Reported-by: Shailend Chand <shailend@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index c1c912de59c7..1154c1d8f66f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -647,11 +647,13 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
 	skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
 }
 
-static void gve_rx_free_skb(struct gve_rx_ring *rx)
+static void gve_rx_free_skb(struct napi_struct *napi, struct gve_rx_ring *rx)
 {
 	if (!rx->ctx.skb_head)
 		return;
 
+	if (rx->ctx.skb_head == napi->skb)
+		napi->skb = NULL;
 	dev_kfree_skb_any(rx->ctx.skb_head);
 	rx->ctx.skb_head = NULL;
 	rx->ctx.skb_tail = NULL;
@@ -950,7 +952,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 		err = gve_rx_dqo(napi, rx, compl_desc, complq->head, rx->q_num);
 		if (err < 0) {
-			gve_rx_free_skb(rx);
+			gve_rx_free_skb(napi, rx);
 			u64_stats_update_begin(&rx->statss);
 			if (err == -ENOMEM)
 				rx->rx_skb_alloc_fail++;
@@ -993,7 +995,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 		/* gve_rx_complete_skb() will consume skb if successful */
 		if (gve_rx_complete_skb(rx, napi, compl_desc, feat) != 0) {
-			gve_rx_free_skb(rx);
+			gve_rx_free_skb(napi, rx);
 			u64_stats_update_begin(&rx->statss);
 			rx->rx_desc_err_dropped_pkt++;
 			u64_stats_update_end(&rx->statss);
-- 
2.45.2.505.gda0bf45e8d-goog


