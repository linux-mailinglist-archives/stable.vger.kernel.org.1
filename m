Return-Path: <stable+bounces-216896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFKrL/HGlGnCHgIAu9opvQ
	(envelope-from <stable+bounces-216896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:52:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7614FBD9
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C230230151C1
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1665937757D;
	Tue, 17 Feb 2026 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGq6IDeB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DF37756F
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357934; cv=none; b=K+1TJOyMaBIhxlOgmGUFQi6zmJ8urP/NeDGpsQzH+oOJ2SbMjatbEy1tNRrox3PAGFQxsqfswbcmWIhkMw+9Rriqmfs+XUoRppylCEE6WuUlGGAiEz1HZlXhljvz+I/2GQaAtBcV/L0CZ8GjGmYYfMGVvAV0C+i93tNFbgqD2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357934; c=relaxed/simple;
	bh=SVG8i7ehnf8Sh3CUxVbwiZ2JC04QQz27yXdjfT5/0ME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GwdGQmdPUOOjKvJr7bxYbXbAIz3E5yUwgyIQaFbldcuZeXht1owNawVI+178x4Kn0yIP3/6dE3DgzibvuL36sQNXBN6MhZNaaOR2N1cz/s8JFN2GxuBd7oncViPauWfWZ+eaEVpP8jFjqE5ZNHzJwAM9gjfv7Dokt9r0GXIgOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGq6IDeB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6e78c4aa50so1118480a12.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 11:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771357933; x=1771962733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNEMtbLKXUQx9GCb6azC6KXcHMyMlEXcuSKlA/96JpY=;
        b=MGq6IDeB3eVo17xgiCWZmss28nC6S/BJlrl7H/fa/g6E3vat7dSj7ImsvHhNw1n3su
         5I7G8XY/UMO/K49lCZRzIE6RDP6JyKXh3t1CgI8B55o00pIcxbrfr7+SHS6IgpC0ESr5
         B5DcCdL56Wmng4aJWfaWYKvet/q89xJkk54DMzUaRIvwtEszMSOQJkTLJ4Ab2CPLV5tK
         Hc7Z1jFg8+/8zIc6qdqMDVGNpGrhCMaKs/aDWejJHwRV9jgrmyDj9CmqCAabHFagNYng
         97p3s9vwcn5AB8LGYZ22TK2A7d0leLGNL+DRxmPHOYra2WhC21DRAoEjaWz8is3XqiUq
         B0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357933; x=1771962733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNEMtbLKXUQx9GCb6azC6KXcHMyMlEXcuSKlA/96JpY=;
        b=fV/2lH34MekeWYj95Mpv/by/dxex71w8gv0dRrX4xQmPMMs0puet9j7mIb3MglFUam
         uFK+JHz8vqt4X96iqa06+3eAl2SopZqwRpBVfOkncs8ECkUBwiTU7PkDGqcD2s2Xw6D4
         zanRk+e+eJfVhP0LbDG266qupA8RKGPAbUS0q/1YugqxabxZGUcFau4WCIUe/r2CQEQ5
         e/PsjCkkLpBCBtaiY27TTyGwwAVVzQLO1Sz7MCJQ0f08u4AE0+Pjl7/tF4kbr/ju24Uu
         Bf9lUE5UYdbrIO8P6vmBtc8mo+n5T7bhQCci7z1ycBzuwm0gAKlVL9GYCc3ahK5qrDUS
         5TIg==
X-Gm-Message-State: AOJu0Yx0NQxRTQ0Sp5fNOKP99cNwnv1uZrsoMYUEBJ1kldJHEwK/Y/RQ
	B1FLeTrKvsxm/jLGhudNVlXj7UxGz1PLx6FeTm4D7rcflb9CU79zuGb/CSb3jyDP2OxePZ89HFO
	QD0/fHW+n8teJddw9lDP8zTKXVmbPzEQDOJzukePzBbxC2HUbQwSRdGp/fWJ2rNa9ueDcB9PYmb
	VBk6zBD5NILXZUHGCR10n9H8hwm6I9i1mqQ5smKj5kWDkLMOw=
X-Received: from pfua6.prod.google.com ([2002:a05:6a00:11c6:b0:824:b4f6:5f0d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4d0f:b0:35d:ce99:cc23 with SMTP id adf61e73a8af0-3946c86516amr14738046637.49.1771357932551;
 Tue, 17 Feb 2026 11:52:12 -0800 (PST)
Date: Tue, 17 Feb 2026 11:52:05 -0800
In-Reply-To: <20260217195207.1449764-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217195207.1449764-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217195207.1449764-2-joshwash@google.com>
Subject: [PATCH v2 5.15.y] gve: defer interrupt enabling until NAPI registration
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
	TAGGED_FROM(0.00)[bounces-216896-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61F7614FBD9
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
[ modified to re-introduce the irq member to struct gve_notify_block,
  which was introuduced in commit 9a5e0776d11f ("gve: Avoid rescheduling
  napi if on wrong cpu"). ]
Signed-off-by: Joshua Washington <joshwash@google.com>
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


