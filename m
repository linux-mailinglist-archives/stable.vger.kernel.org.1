Return-Path: <stable+bounces-203068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D4ACCF5EE
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7ABC3028F68
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D08530E836;
	Fri, 19 Dec 2025 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4W7ybIM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890B30E0C5
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140191; cv=none; b=A5xWibY5tC3RdT9Aeh12MQMZdAWuXeGgUQDYkK/8zC45QTxW4gAJEp8UZpAYs7ANDNBuwwbgdTpVK9zM5nZg2j1sQDLs7a7sLehNyBSDi0TaaqJUWWlXyqeoE+O4d08VSxKWo6y5+vNYbiotq7XQaR2Y47SSAZeB9zBdwpabu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140191; c=relaxed/simple;
	bh=5RUwCxMu/x0Lv/xsgkABYEtrsD4Cglq2dz70ONw5tKE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EkD9pWUp1QPgZ60E8UNu0jL4OPtxYUlsxcy+lFe1KmW/rAxSLfvIQQ8/WfPGyldcnt1ElwnEnNZQTvx25+fjYGyxd4M5WbAkGY3eVWE4ntLqlYlOG0b7hkicHvMRG2loG4yAbFMOCHabJIUNiKAJlTF9oan9MCkxeu4qUVobF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4W7ybIM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7f66686710fso4553261b3a.3
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 02:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766140189; x=1766744989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CPnMN21hkuWV6M5NPiQ6Mq5kBe5QGW1oqNlB0D78CCk=;
        b=U4W7ybIM/KmgTBN9E/dbpgOeTSwzSrvBdMwVcwmLn31fveFkIScVZqISQpCzEQUNQa
         2bcz2ZOA20WXQmuffjjiIE1SY9QCop7LZCwroA1InRDjHr5W2m/yf4nW+L1va8jVkjYG
         8/vYFjbaFYtl5nGmjVS+SqXM8iduysTFh4m/VgYMcAvn+sWCIQYwcqUBd4xg+u2uB3wU
         ttMAv/hUmNCMIRktAgNpp4CN6AzixFIV77QoqckSpqM67K6LhhpFRidSjilqCiIv7OLk
         JFQfTrnUe120hKATRh8iXzzcsvMODnKbwjEr5O4Cu1Y6iXnHEDFQp2MGm64lcV1TRkKm
         y1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766140189; x=1766744989;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPnMN21hkuWV6M5NPiQ6Mq5kBe5QGW1oqNlB0D78CCk=;
        b=LSD16ciA9mKOq7JOd+LJv9zqKGkbmw9vjqg/xLYbQD/Bq2VqG/owLCG5Cl0E2RwjSo
         mhcLTV964XSIFySLOQ1MW4csg+HpdOBiUis3Ndt8wOFtgIbbO/mdsxkw2dkIQXhd1dhq
         +1hU7NPPIwEacE/L6m9prGLjkls8ElYqPVhoGNJSn/MLCKrXNsnlFcKOlssDjP6TevCA
         uAUKxP78VIdiz05Ar16d4SPg5FJT66sQiC7FsqM4R3EdnRTVOh5btOLZ6hI8Ma4AR3bN
         RRRVENpWhkcqF29iBFxCFoaMbm73bZKSvfsZnGD/AsK9CXEYULWUX2/mSA4G3UV10sNd
         s/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP1oO4kxi+FeJF4h9t18QBfRMjURUPeUTsxt6B4NrmKjsXAC39Wt5zegbgePxeYq5UQAYhExc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSrmQC7xxHoiYYjRwW2+1zO+ocoA/isa9awCYKpxRA5cMDBLB
	x9ctJkdL5mzvVrA1fp41FblgLa0NxzD3hnUEw6nAo9ju67PuSGdgFuwdPLSYd0IizNJ6w5fRa36
	n6GnFHG0GXvj6KOmidmnZNa+KeA==
X-Google-Smtp-Source: AGHT+IGTpOEyBNcdwffdHywVPgqfMK+AgSgFJg6iOJhyg/Huv9qcPu6xzZECaDxlEdyyIlF78GFOHipb62bO6ryyqg==
X-Received: from pfbll12.prod.google.com ([2002:a05:6a00:728c:b0:7fd:f3e9:5a0a])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ac0c:b0:7f7:3c0f:5785 with SMTP id d2e1a72fcca58-7ff646f9429mr2356650b3a.2.1766140188824;
 Fri, 19 Dec 2025 02:29:48 -0800 (PST)
Date: Fri, 19 Dec 2025 10:29:45 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219102945.2193617-1-hramamurthy@google.com>
Subject: [PATCH net] gve: defer interrupt enabling until NAPI registration
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, pkaligineedi@google.com, sdf@fomichev.me, 
	jordanrhee@google.com, nktgrg@google.com, shailend@google.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Currently, interrupts are automatically enabled immediately upon
request. This allows interrupt to fire before the associated NAPI
context is fully initialized and cause failures like below:

[    0.946369] Call Trace:
[    0.946369]  <IRQ>
[    0.946369]  __napi_poll+0x2a/0x1e0
[    0.946369]  net_rx_action+0x2f9/0x3f0
[    0.946369]  handle_softirqs+0xd6/0x2c0
[    0.946369]  ? handle_edge_irq+0xc1/0x1b0
[    0.946369]  __irq_exit_rcu+0xc3/0xe0
[    0.946369]  common_interrupt+0x81/0xa0
[    0.946369]  </IRQ>
[    0.946369]  <TASK>
[    0.946369]  asm_common_interrupt+0x22/0x40
[    0.946369] RIP: 0010:pv_native_safe_halt+0xb/0x10

Use the `IRQF_NO_AUTOEN` flag when requesting interrupts to prevent auto
enablement and explicitly enable the interrupt in NAPI initialization
path (and disable it during NAPI teardown).

This ensures that interrupt lifecycle is strictly coupled with
readiness of NAPI context.

Cc: stable@vger.kernel.org
Fixes: 1dfc2e46117e ("gve: Refactor napi add and remove functions")
Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c  | 2 +-
 drivers/net/ethernet/google/gve/gve_utils.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5a74760..96adbbe 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -558,7 +558,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		block->priv = priv;
 		err = request_irq(priv->msix_vectors[msix_idx].vector,
 				  gve_is_gqi(priv) ? gve_intr : gve_intr_dqo,
-				  0, block->name, block);
+				  IRQF_NO_AUTOEN, block->name, block);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to receive msix vector %d\n", i);
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index ace9b86..b53b7fc 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -112,11 +112,13 @@ void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 
 	netif_napi_add_locked(priv->dev, &block->napi, gve_poll);
 	netif_napi_set_irq_locked(&block->napi, block->irq);
+	enable_irq(block->irq);
 }
 
 void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+	disable_irq(block->irq);
 	netif_napi_del_locked(&block->napi);
 }
-- 
2.52.0.322.g1dd061c0dc-goog


