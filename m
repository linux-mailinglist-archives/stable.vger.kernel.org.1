Return-Path: <stable+bounces-216305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOsKMNuUj2nNRgEAu9opvQ
	(envelope-from <stable+bounces-216305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:17:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46098139933
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 579B0300647D
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA7826FA6F;
	Fri, 13 Feb 2026 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYRqBAtT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E5327F754
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017431; cv=none; b=W07TyHMfKmT9qpfyXzsTqxrFOaMpHGfQy9/HEKIyXTLBUa+q9ben12llKICsDnrZhKsPcPe+DR1trjfYdmdHMOHxyTUz4oGqMIey1YnUMhz+7+tj+7eVnVYOn9OJN0RFhRMPP169KS+HPCDgOEZo6i/V/pPBdKknJ2zu0a8TPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017431; c=relaxed/simple;
	bh=1QarCqsvrLiiUcx/hYvbS7KydT/t5WsKE+8t9O+94JU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kTgePMsk65nsGmhvYrKPF7HWqi2Ilr9LzKrBM3HkzGQCQ0PeHw03in4Y6y11danSLo0kVHdla94vzYQVxpQGyn+hyw2sPfkCCOdPY4S4NS6oqTa/7TZFfUQEYl5bqSZqR+JL0HagvpoCnWFJjSwejCjrMx0fkoOr1MoixjrdCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYRqBAtT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-824b3532298so870942b3a.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771017429; x=1771622229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRF1LF1zKKuGagxgAhQ9/NwU5dWQFckN4Kl1ULPagRU=;
        b=gYRqBAtTf+u4ykDc26RVZJ7RA29I96cDbkPluM5BRUsMl26YAMULdnwJdcJDkQH7hL
         /OavpwVmOM7ALXmVdsoz//t1HFgfAja4ssIWZei8j5R3XsNYmorus8WWa/m7wl6B/39F
         zGTYUDqQcl1uUeogpC0xNt1DA73O2oV1P9PS8e4D4zM0ExYHlQimgvosXdeSzVj8lTkN
         wN73GwDLH2T+9VXKDixDBIZq3uKYNpUhkWswGeD0EDk9i7XB+504i3q2U5AZCAubD6AA
         Kf84kceQU/B2r32SNzccbtr93sfzxqbDjWWsxcYbGbaZSiDvK8A8KmwdwVR6DKcda7iP
         D6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771017429; x=1771622229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRF1LF1zKKuGagxgAhQ9/NwU5dWQFckN4Kl1ULPagRU=;
        b=uDbd73auJwaJC23tqS2HU1pegW/uX+BEjHnyeQvNaVScMV17MaKlq23HHoRwaDawhw
         7vufW0r5p6au6f9P0mzK7Sz5owsN/zi3JVXv46lNpLr8lRFGGOcwoMQO8BI4lWVWWlWz
         Wp0o2DL4V4gSbEMo1kGqVuWsIKJxi6gIcP3C6/Jm/UCi7t4i9bSF9dwkKwLpwdmhGq/9
         lFLaJ3OJLvgu19VeTNc8+vWWjv8Rlrrn6TMM1cQ7ckOjYPOz1Yr0X4vpMWlN8KFWcCQK
         lUcbr/ma6rTcTWab76i5tFZMCvRNIdTxIHE2uFJ80KGQYpZebSXI+W7mF96M505AejJN
         WnGA==
X-Gm-Message-State: AOJu0Ywy8xcrnrSJ4PP9ZN2fjI1qf3D7nrk8xTSMkucdiUkwJWAvMcrc
	DyDPcX7B2iaEqqYfzq/ahgIu8P+6jqzZoS7bLPaVZydO9yw8vqZOGTVznNQ9VKrIdPIfHFNF7Xu
	nEP59fpsfi579rMGLk4mWUFGzVnsEu3gHlRmJu3KTmZLQcuqV9ZHNK6cOdn273Na4CTNZEAfruO
	01h1rbZSbZq0eJZpRAwXWsQTHM41nVLGtGjj4a1Esu+QEJuYg=
X-Received: from pfbde18.prod.google.com ([2002:a05:6a00:4692:b0:7b8:909:1a1a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1d9c:b0:824:a8ec:ed51 with SMTP id d2e1a72fcca58-824c94defa9mr2794231b3a.27.1771017428235;
 Fri, 13 Feb 2026 13:17:08 -0800 (PST)
Date: Fri, 13 Feb 2026 13:17:00 -0800
In-Reply-To: <20260213211702.447894-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213211702.447894-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260213211702.447894-2-joshwash@google.com>
Subject: [PATCH 5.15.y] gve: defer interrupt enabling until NAPI registration
From: Joshua Washington <joshwash@google.com>
To: stable@vger.kernel.org
Cc: Ankit Garg <nktgrg@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216305-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 46098139933
X-Rspamd-Action: no action

From: Ankit Garg <nktgrg@google.com>

[ Upstream commit 3d970eda003441f66551a91fda16478ac0711617 ]

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
Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20251219102945.2193617-1-hramamurthy@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---

Note: This patch has been modified form the original to re-introduce the
irq member to struct gve_notify_block, which was introuduced in commit
9a5e0776d11f ("gve: Avoid rescheduling napi if on wrong cpu").

---
 drivers/net/ethernet/google/gve/gve.h      | 1 +
 drivers/net/ethernet/google/gve/gve_main.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 822bdaff66f6..b0a371037d21 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -441,6 +441,7 @@ struct gve_notify_block {
 	struct gve_priv *priv;
 	struct gve_tx_ring *tx; /* tx rings on this block */
 	struct gve_rx_ring *rx; /* rx rings on this block */
+	u32 irq;
 } ____cacheline_aligned;
 
 /* Tracks allowed and current queue settings */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index a8fb51e77fea..d8cbc9ca1700 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -339,9 +339,10 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		snprintf(block->name, sizeof(block->name), "%s-ntfy-block.%d",
 			 name, i);
 		block->priv = priv;
+		block->irq = priv->msix_vectors[msix_idx].vector;
 		err = request_irq(priv->msix_vectors[msix_idx].vector,
 				  gve_is_gqi(priv) ? gve_intr : gve_intr_dqo,
-				  0, block->name, block);
+				  IRQF_NO_AUTOEN, block->name, block);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to receive msix vector %d\n", i);
@@ -502,6 +503,7 @@ static void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 
 	netif_napi_add(priv->dev, &block->napi, gve_poll,
 		       NAPI_POLL_WEIGHT);
+	enable_irq(block->irq);
 }
 
 static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
@@ -509,6 +511,7 @@ static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
 	netif_napi_del(&block->napi);
+	disable_irq(block->irq);
 }
 
 static int gve_register_qpls(struct gve_priv *priv)
-- 
2.53.0.273.g2a3d683680-goog


