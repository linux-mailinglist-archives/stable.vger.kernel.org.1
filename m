Return-Path: <stable+bounces-216306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLpyE/SUj2nNRgEAu9opvQ
	(envelope-from <stable+bounces-216306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:17:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4761139941
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D38304300E
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057829ACFC;
	Fri, 13 Feb 2026 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRy3SJkj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10128850B
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017432; cv=none; b=RhfgkZILYUdNMMhgmZjIID/03W0fzpykQ780AAQ/rqM8qXkZlp6CI5OxWzmsiUg3t6NS1S3Hme5xlTkggl1A4t19vy1s7j2IICXHx3q+peyytQQI7CAJMN17rDIaC7TLlcwvMlClXAdIvcPaN81vr1SAG1ynGUDHlV4yqb2dwpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017432; c=relaxed/simple;
	bh=LcspL2cQqhNrNn5Pn5PdqdqRA92NKKWrASTxKy9nnm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ABmQjtw3E17JVVt17ZTsRq4LPetagUFxbTEbohStZHf1+pxRYxfaZGthCGgfoU3q/6Qkw7Wte2+emoXYbs8TURzNllsm0v8vUF15H8Chnci3Ace05mlfducwcR1OS7hXrdv1s4H80Sp4pkHuq8fWC3I6XRFfuTLZylpdFz+2jvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRy3SJkj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aae146bab0so17716915ad.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 13:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771017430; x=1771622230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6wUlVaHN4DyXfE+c1DWn8YHn25O3vNML1qmDPEOEBwI=;
        b=MRy3SJkjhUblx4H9ZeRElYhSC1fW5/W9tdVWoLlKGDGtNjBOdXDbVj6zUeQR5IcbBp
         0nZj21AGLeWOvsl/MQr25iUgbdSUNakCoDzTT1wY0sP24m9zeVlKBo6EJhESkDECeB3o
         Q8dUf7Pm5P/BxKjQKoq98w5O8Do6s1E9EgJcFhRkeuCenXgRZznu4Mu419oywnGbA9CM
         aDi5D8yZWXUbU7CCLpz8ipr6eXmJtvT2+jNockAt71O4F1ZJEJ97FXOYCEy/gUx6NrOj
         wUSKvhHpUJM5XZaR91+e0tlojZYakSqIFTh9X1vsW3fSXjpmD/W/+MhwoQ9H/iAnpd8L
         HbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771017430; x=1771622230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wUlVaHN4DyXfE+c1DWn8YHn25O3vNML1qmDPEOEBwI=;
        b=e7W2GUejy9coTw73WdHRv5/FdFVFlzdUsb109IFbVHm3OSqynE6R4QnQEf/DfnKra8
         dd7z6y2Q41KWYHx5tgX0kgshnd2Tt4nZV8zLIDh9sS5Ot+rMJJWS/VaKUMyhz0DPckNw
         FnzVaIE1FQCU1rJ0og3VDJa+AorJ2d6OIZT9crdDwucG5BTSNtiP1h40sHYLcvYCDXCC
         NC0MTQTOkL8zqfWXXVd1hRhDeypfKndxqGd1a4jH6CdlAl5Z1u/mkcO2gnX9IcUIeatI
         w2/EXLcMW4owgSSxalRrn4YVfvHQ96s7tjfERC/4XcuE2hXEEFUooeyRu5Jr5aVV6Orf
         Z+qg==
X-Gm-Message-State: AOJu0YyC5GOMmSba+vTaM3/Qx2Qu01P5LnOXu8VzGQOkWsfu85VOcRFl
	zdbRWTr1MirShGO1d/7LWjF426sz9C6d0rf2qr+zQMZc9cj7uSq9a17HB8TZAz+bpIQF41Q3n2P
	R2PR7P/SgF2SBR/trJZh7/hJeMeVynN+NzsllPnOgi6pSOjQ1HQLVdyLuobUman+vDxiJDs7edg
	hXMKHYwV5NKetZ8vwrZ8kPnMJChoJy+4qz9TlZQPymSmN9nRQ=
X-Received: from pgcq30.prod.google.com ([2002:a63:751e:0:b0:c63:4841:c45c])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9987:b0:35b:b97f:7bd2 with SMTP id adf61e73a8af0-3946c799826mr3360520637.10.1771017429966;
 Fri, 13 Feb 2026 13:17:09 -0800 (PST)
Date: Fri, 13 Feb 2026 13:17:01 -0800
In-Reply-To: <20260213211702.447894-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213211702.447894-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260213211702.447894-3-joshwash@google.com>
Subject: [PATCH 6.1.y] gve: defer interrupt enabling until NAPI registration
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-216306-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: D4761139941
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
index 458149a77ebe..c5e1312b9283 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -450,6 +450,7 @@ struct gve_notify_block {
 	struct gve_priv *priv;
 	struct gve_tx_ring *tx; /* tx rings on this block */
 	struct gve_rx_ring *rx; /* rx rings on this block */
+	u32 irq;
 };
 
 /* Tracks allowed and current queue settings */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 963c76e4aa5d..209e9526a6fd 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -353,9 +353,10 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
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
@@ -521,6 +522,7 @@ static void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
 	netif_napi_add(priv->dev, &block->napi, gve_poll);
+	enable_irq(block->irq);
 }
 
 static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
@@ -528,6 +530,7 @@ static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
 	netif_napi_del(&block->napi);
+	disable_irq(block->irq);
 }
 
 static int gve_register_qpls(struct gve_priv *priv)
-- 
2.53.0.273.g2a3d683680-goog


