Return-Path: <stable+bounces-105164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D639F6767
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 14:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABACE189676F
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684461C5CAF;
	Wed, 18 Dec 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/JaCxdu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59E1BEF87
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528871; cv=none; b=O0HrHGbZKFsVeFoMs8PkCl+EHRElrXg3FzWezN101GhMJi30eVeqwmT2m/wtRIyL0+6NqKAiVk8XwAqyje/DiYcgNeT+unGEq0vV+cybqapMm6FldtKoS+ETY2EOB/yWu8rBQFBSRCMqB6OsB/MrYhwIPkVEXeDSplqVyCY+Zo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528871; c=relaxed/simple;
	bh=CvjpZzap2JTZv3aoX0brnCAcyXx3Af2l9Bmavz1WSA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lAZwx7PTdl4i3/DaH4Y8o+apkXfK1yoCX7pl1XzCDZmcM6rTrhGp1coAWRJ/oeFvSo7uUAsEiRVHqvyouxC55r4kz2Xbrt5JbR/MYbzQ2toYFitUnRui/5TN9HJwW/1w5RWS7KmInM/YPQyFpSZqmtjtxJYT6Wxlmcl63Tw+bG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/JaCxdu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728e4e30163so4729708b3a.1
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734528869; x=1735133669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRgIGaGDm4cvXXtjC5u8gCurbHYhRvv9RGqvrTy9ue8=;
        b=0/JaCxduaU21L5RaQx1ihJQkMX1AE95D59KPUyoGVH8hJltOXiXJqNS3vX4009WxH7
         rjpAASdQXLKI/+jO1QdHUfThNL8htyOBJzRrXOoN8z13/4tprvTc1bF+j5iAerBkM/9C
         vDuF04wu1F32nO8QvX/5a6TnWttMCrImbvkysgqaj8VF9dM7SdZVy8EatBls/34C/KTi
         LOCh/CRcBkWUuYrGSuLCdwgT5ImdZYYv3b98OHWzvq6hpkgjZ3vrDkjD0EFDEoC9h+Ov
         f2WchjMngQRtdwc457HC6V/svmX+Vqay5lFNygRpNw4Pg+O9VNyKDEQbx8ODPbox863J
         7SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528869; x=1735133669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRgIGaGDm4cvXXtjC5u8gCurbHYhRvv9RGqvrTy9ue8=;
        b=NUTqTCiLWhYKUVe2JmY5pJNcl3aXk1JtwyKc5FzDY1sJtK5Mq1eN0USbGmbxfMQgWt
         zqGOxZZY/cKIXcVSYKRUzQj2JTQNTo8elDAWVF/SEcEgdyusNtkrHaVXPaIZXzeDYV//
         W9m3tkePSeKIKW0+R4WlRSSlgHSfUEaGE5AGvxyipVyVhw53RGHoSXxe/x7WvjoaIWWS
         EIk5mdDq7n/MJpPYmh+WSDbqoVTgbCnHEQ9vUilXKFbidtDAt3jTg5iYP9XnbZ0NcpUs
         d3yQ+igjFBnJcs/bC3drvwH13J+9bSAQ0p3Ek3YzU+JFSeyJLS/zpKs9zMrU+PFUeDlZ
         I0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCX8GJLjhUoWlaqfwr4D2gt2kapJdJ3M9OnPfIcELznGSLces6kWcTg1+SfU2+miVwByDtMiz0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/S7PAcDd5VDtEyDku+tfceBz1DEC7Z9j48xkiimJMkAFPdeO
	TnfRZHJJbSKG0dVllsMuuqf2LIJUO6AY8CT+QDdglfv32zwbBscTFku50fX3dGWOry1Ifys3Ne2
	eHekvCLnz5tWvYeF/b8XYrFS2tA==
X-Google-Smtp-Source: AGHT+IELVRUurFW8tfDDC0iUwFPiFsqYStc2zOYCPV3iXlkA6nU0se344US+p9bexkbh23hUu3k2oyF3UnV/97X3x9c=
X-Received: from pgeu9.prod.google.com ([2002:a63:a909:0:b0:7ff:d6:4f28])
 (user=pkaligineedi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1013:b0:1e1:e2d9:307 with SMTP id adf61e73a8af0-1e5b487e6e8mr4675360637.33.1734528868845;
 Wed, 18 Dec 2024 05:34:28 -0800 (PST)
Date: Wed, 18 Dec 2024 05:34:12 -0800
In-Reply-To: <20241218133415.3759501-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218133415.3759501-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218133415.3759501-3-pkaligineedi@google.com>
Subject: [PATCH net 2/5] gve: guard XDP xmit NDO on existence of xdp queues
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, shailend@google.com, willemb@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	hramamurthy@google.com, joshwash@google.com, ziweixiao@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

In GVE, dedicated XDP queues only exist when an XDP program is installed
and the interface is up. As such, the NDO XDP XMIT callback should
return early if either of these conditions are false.

In the case of no loaded XDP program, priv->num_xdp_queues=0 which can
cause a divide-by-zero error, and in the case of interface down,
num_xdp_queues remains untouched to persist XDP queue count for the next
interface up, but the TX pointer itself would be NULL.

The XDP xmit callback also needs to synchronize with a device
transitioning from open to close. This synchronization will happen via
the GVE_PRIV_FLAGS_NAPI_ENABLED bit along with a synchronize_net() call,
which waits for any RCU critical sections at call-time to complete.

Fixes: 39a7f4aa3e4a ("gve: Add XDP REDIRECT support for GQI-QPL format")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 3 +++
 drivers/net/ethernet/google/gve/gve_tx.c   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e171ca248f9a..5d7b0cc59959 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1899,6 +1899,9 @@ static void gve_turndown(struct gve_priv *priv)
 
 	gve_clear_napi_enabled(priv);
 	gve_clear_report_stats(priv);
+
+	/* Make sure that all traffic is finished processing. */
+	synchronize_net();
 }
 
 static void gve_turnup(struct gve_priv *priv)
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 83ad278ec91f..852f8c7e39d2 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -837,9 +837,12 @@ int gve_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	struct gve_tx_ring *tx;
 	int i, err = 0, qid;
 
-	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK) || !priv->xdp_prog)
 		return -EINVAL;
 
+	if (!gve_get_napi_enabled(priv))
+		return -ENETDOWN;
+
 	qid = gve_xdp_tx_queue_id(priv,
 				  smp_processor_id() % priv->num_xdp_queues);
 
-- 
2.47.1.613.gc27f4b7a9f-goog


