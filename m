Return-Path: <stable+bounces-216898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oh3ZAPfGlGn4HgIAu9opvQ
	(envelope-from <stable+bounces-216898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:52:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE414FBEF
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 799153039F48
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9877F37756F;
	Tue, 17 Feb 2026 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHrNUZ0o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E2377562
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357938; cv=none; b=dw5fiBxUvKA/lfTxb5hN2aADJP2YL5r8UXFkDIpFAN943Ob7qmB9DoFugin2jqx2c2rCGynw/PQf34xCA8Ku4sdLmQW3ddFdNDg4RhRazQDHzbJ/LqtM2qggE3gnVPP1RkLpDrxoz6zi4JScOj8ve8pUS4dEilOXy2zJhW4y6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357938; c=relaxed/simple;
	bh=VAW7x/orn0Huy1YPMtPk3NZT1Exwl+gFPT2lNA8f6u8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UARTPWL8eVZEZwx5AXEkvl0GqpzNwGRbw1mRq1mzfRzGbKOfadVkGEugIHkEQ4/WsDy8s2Dg1paVWYg5yZBebBosBroP3N7U1VLN7Gy2Sm/p9bDRlOQsOPd0Mv8Q7Ss26p6knOImzBm88hRj3KfHnT3Pfm6ZV14GXs2pwIq0Jbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cHrNUZ0o; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ad147cdf07so39653845ad.2
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771357937; x=1771962737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIA4TK+EsNVXqdzbzcC79ZPWkysGWEOBK8gataHwNFU=;
        b=cHrNUZ0oKVq0H/hVcbYt5aFVdyn1hReUqZTrCDXfOjJVj+7WCesuFGQsI7MacE3XXm
         MdBjz/2awP7uvxTUipf8dhyP+7KP9blqcPJY1rTvmp3lunYJ7DLpvGXNysraGgS2d/Oz
         nJUzqSrPcMf+EUsayLeH5Af2oAod59l8IXrmCRO2DxgaqiFsUAnwKBsT0TNsHSmEg0qx
         kSN6ZIyA/jbJKudXN1BOcwdlmPGj2b0cx1D7sme3apZ+h/WwEzqq0ZMd3LwzGuCZOS0j
         Byn6SX22XgYKDeraEdM/q9f1XUWtmcHVZfR9W2OcF3foP7egpsix+z0mKF6i8vPmGFGe
         dFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357937; x=1771962737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIA4TK+EsNVXqdzbzcC79ZPWkysGWEOBK8gataHwNFU=;
        b=Yt4NgXSp7EFwAO+pivsBAFRvlS5d2/mCa4UIkWFFjv+Ayx+MH3L8Tn36us/Kpy6sCd
         l8AJm1cJQcUOQJaL2E2aQXFWvsgMRRgVb2Tid1pYiGn2WMNBjLJU0HRe1q19UT3SG03v
         xZSCH0Foac7lxfAthUCGRquCDRYeYfeqrjsjgF7XVpgwukxqXW12tBjW2hD/DBe5kWq/
         rVM6M2NWqQJUig2jWfYxZ8Cqv0TiSMhL7tlnH7jEhVk/Kx0ldgiswN5HykbRCH+6QlyA
         93goaE8fNott/h5jTleu/O2srvrAo0yz9eq2s4hP76101XuMpkpFK9ctbfXjM4cZE2+z
         E7sA==
X-Gm-Message-State: AOJu0Yx6TgGdj9jg0wki/1UDJjA3aBZOeV3/sAYoWXsuU2kt3pkxg+Ts
	n0npRN/C1ciGObT32A6us4PvRGKxOk9dmttS5oyadg92ENvYq4cnHdmNpIf0qWQLLKo+0ykO0Og
	5TG+0wQWU+uNKLdIohz93U0ywsNLFBMctk7Ti2ZuxouXaj+aV34cFaybP8uWmYnSg6iihid7jmK
	aMWzjBi03KtyYEcRqElH2CMEsuhtrOx438mvgL8TPMjEP0Idc=
X-Received: from plmo18.prod.google.com ([2002:a17:903:18d2:b0:2a8:759b:173d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8c6:b0:2a9:4998:6636 with SMTP id d9443c01a7336-2ad1745d452mr126992585ad.20.1771357936243;
 Tue, 17 Feb 2026 11:52:16 -0800 (PST)
Date: Tue, 17 Feb 2026 11:52:07 -0800
In-Reply-To: <20260217195207.1449764-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217195207.1449764-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217195207.1449764-4-joshwash@google.com>
Subject: [PATCH v2 6.6.y] gve: defer interrupt enabling until NAPI registration
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-216898-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pci:email]
X-Rspamd-Queue-Id: 96DE414FBEF
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
index d59e28c86775..f6e43cf96a46 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -585,6 +585,7 @@ struct gve_notify_block {
 	struct gve_priv *priv;
 	struct gve_tx_ring *tx; /* tx rings on this block */
 	struct gve_rx_ring *rx; /* rx rings on this block */
+	u32 irq;
 };

 /* Tracks allowed and current queue settings */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index b2c648fe3875..08f444ee10c7 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -407,9 +407,10 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		snprintf(block->name, sizeof(block->name), "gve-ntfy-blk%d@pci:%s",
 			 i, pci_name(priv->pdev));
 		block->priv = priv;
+		block->irq = priv->msix_vectors[msix_idx].vector;
 		err = request_irq(priv->msix_vectors[msix_idx].vector,
 				  gve_is_gqi(priv) ? gve_intr : gve_intr_dqo,
-				  0, block->name, block);
+				  IRQF_NO_AUTOEN, block->name, block);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to receive msix vector %d\n", i);
@@ -575,6 +576,7 @@ static void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];

 	netif_napi_add(priv->dev, &block->napi, gve_poll);
+	enable_irq(block->irq);
 }

 static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
@@ -582,6 +584,7 @@ static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];

 	netif_napi_del(&block->napi);
+	disable_irq(block->irq);
 }

 static int gve_register_xdp_qpls(struct gve_priv *priv)
--
2.53.0.273.g2a3d683680-goog


