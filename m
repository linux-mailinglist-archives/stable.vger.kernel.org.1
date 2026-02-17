Return-Path: <stable+bounces-216895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA0tLPHGlGnCHgIAu9opvQ
	(envelope-from <stable+bounces-216895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:52:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F8C14FBD8
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB3853039F47
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102C7376BCC;
	Tue, 17 Feb 2026 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCmOeHtt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34C374191
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357932; cv=none; b=lNpbYgPMqgZf2LiRIF1TPGY70kTbxsRbVQiRZqbGLA3bfzcIpN0ADC6vj+ewqg5F1PIcPZMK444v6WuYJGm9rs13RgYbWoQOaa/hRheUDKsIJJHeA7jdPvDmU046rdQRze/lr/Eim4DWNyP+39U3CO/JM0vRDplgepxWCqu4CDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357932; c=relaxed/simple;
	bh=QAh9ddtq7Dz85rBD9PFL6GeJN+c6Y9Y+BdaHw45ZPqg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MdLp+AqOkQQe87Y9X6jm+DQwwaPPYTh5xdXKwaQBCTsZUgg+qjvyNAObkjW1Blt41TOTCR01iGW3l6syY+Tm41eANixojQEGlSqcv/yiYgDIW1frcrvPewvKCoEyk2bSEaAf6bWk3Zf7V56TN5CDQOeHGYJnk2F5f0IL5LmcKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCmOeHtt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-353c9d644b0so3292738a91.2
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 11:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771357931; x=1771962731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9RgEfztwvOzv5DTDkcz7UxOxV9Y+jclgufzwpjCJLFI=;
        b=QCmOeHttTvTYwIOWH4hHr7fcr8yz0Vc+3isLHSssmzLXZUVxldBl6AepiWIsiuLbS3
         hPArkN+GdXPJ2724Wc+UVKboylB9PghpaJEGQzjWMJVXkynSrTMTpYCnM5yTYQy+8UMx
         Eqngxfd91OevwxbeO+CUycGZmai6FukZvqXShEPNfeEgsWDlrHLHYOVZA8boiNlnkJPA
         dix0GkZYhm69cfaN0+7ZQCB2t/0+TkUIn/hs/57iAnuuScVWqKvigC+9gJ7xe2yyAXKB
         5/0jiy7Mr1z5rji5y/P/AkE5dSRCg2ctPU02UoqAWLTjr+Y+3jFs/wEWBclu244ai6+/
         VEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357931; x=1771962731;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9RgEfztwvOzv5DTDkcz7UxOxV9Y+jclgufzwpjCJLFI=;
        b=sVQ8XFUojK5mMLxXb35Q2TMqAFf/CPJMXlxpd7eP9lAOJdC7hR1Kt+Eev9ASZoM2Dr
         srAF8hT+zcOzz/IlPz6dKwYa8OrPbsPHn31Xw2ay+jJVaQmaB1N/jR/jjBuoggjNHjHF
         7e2bgKTYwA9BX9qAs4OsykzJS2sAgUgElc05WWR6dNYrcWMrmIUI3aGJfkHbeXC0J+nJ
         p3QPNaUIPfDBEWgk/hoJhXX0d7jnBv7SZbd6RVkZWEIjI5r6tgCZSoPlFZtzjMFQrHSP
         1ysL2Vj3fLOIJCgLOmOvOyvvS0r5sUv7GjxiH8sElZ2Uf95SqFDYyUtitXigE/WE/KJn
         FACA==
X-Gm-Message-State: AOJu0Yx5jusPGz3qPNtzrfv0bM18DSnmMRP3DnbdHhbtnFqfKIh7eY3b
	PZu/q3MHqeifgNEhFCcbt5ARMUz8wDqZvM2opYZxk2AF7otm9Jr/IGD5zETMJPrp9zw4gtS/nmJ
	hheo5hreroc1Xvp0bw8+HsJnet9phdbLHhtLlxHP0tBvgTzRgQAodPo7nOUV3v1xlVZjJthHR5O
	dMEj7AntLZIbRroaSZoM39exnr/3AfXkuiQhmhE9WhHAl6ywg=
X-Received: from pjqq8.prod.google.com ([2002:a17:90b:5848:b0:354:9e6b:54af])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5650:b0:34e:63c1:4a08 with SMTP id 98e67ed59e1d1-35844f85d2bmr12053801a91.20.1771357930574;
 Tue, 17 Feb 2026 11:52:10 -0800 (PST)
Date: Tue, 17 Feb 2026 11:52:04 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217195207.1449764-1-joshwash@google.com>
Subject: [PATCH v2 5.10.y] gve: defer interrupt enabling until NAPI registration
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
	TAGGED_FROM(0.00)[bounces-216895-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 13F8C14FBD8
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
index 5c9a4d4362c7..eb63f315a3d7 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -165,6 +165,7 @@ struct gve_notify_block {
 	struct gve_priv *priv;
 	struct gve_tx_ring *tx; /* tx rings on this block */
 	struct gve_rx_ring *rx; /* rx rings on this block */
+	u32 irq;
 } ____cacheline_aligned;

 /* Tracks allowed and current queue settings */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index c22605e69771..7621ea566bb9 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -277,8 +277,9 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		snprintf(block->name, sizeof(block->name), "%s-ntfy-block.%d",
 			 name, i);
 		block->priv = priv;
+		block->irq = priv->msix_vectors[msix_idx].vector;
 		err = request_irq(priv->msix_vectors[msix_idx].vector,
-				  gve_intr, 0, block->name, block);
+				  gve_intr, IRQF_NO_AUTOEN, block->name, block);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to receive msix vector %d\n", i);
@@ -413,6 +414,7 @@ static void gve_add_napi(struct gve_priv *priv, int ntfy_idx)

 	netif_napi_add(priv->dev, &block->napi, gve_napi_poll,
 		       NAPI_POLL_WEIGHT);
+	enable_irq(block->irq);
 }

 static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
@@ -420,6 +422,7 @@ static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];

 	netif_napi_del(&block->napi);
+	disable_irq(block->irq);
 }

 static int gve_register_qpls(struct gve_priv *priv)
--
2.53.0.273.g2a3d683680-goog


