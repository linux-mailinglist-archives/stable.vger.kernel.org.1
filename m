Return-Path: <stable+bounces-216897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCuFDPXGlGnCHgIAu9opvQ
	(envelope-from <stable+bounces-216897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:52:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A454614FBE8
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55EAB30429AD
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73B376BCC;
	Tue, 17 Feb 2026 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDLOkOE8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BF3783CB
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357936; cv=none; b=E7Gb4rMqS/Gpy0wqRlkSvqvw9QAXCJqW9t0dGfft2tPZWTrzE0bvE+79pcbr42DaR2B9/WIaynk8xqZ6df3DmB0M9XUx2F0f75ZF6nZZBDEE4QN2k+HrAddhsB6CYolxHeBbJwdZBtxZlQnXZVYgmBgBAgehxI1qFL5lvb8rG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357936; c=relaxed/simple;
	bh=3a3ILtgEFv/rqdzbhJSEF5eTFuT3doIi6/a3KoE5wMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nrl6kYW0meH6xir0CVdDFzl/Bl5+wIV10lrT7UItmgkQ4dZNU/henCzL7Nl49NuGN7IZ4Yvt3UBq8+aEgCh4sqH1xlCnwRmrb//5cyeN5pKg5dZBvBvHGBrlmCmI6gdsADMV1EdO6OINOMdu7/FGyYaSwHUUal9nF0DFFTRC4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDLOkOE8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ab0b2e804cso57617585ad.3
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771357935; x=1771962735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9pVbNx2nDpQEXdEb0NUK6ofNX1vMVUT/2xqnV0hFCI=;
        b=rDLOkOE8cm48aDtI58+Og2Fz5joX9xpaziZdgQX7z9EVSA8Xpc/a04UQlCbL2ryXRq
         eORJuA4YlpixM8fTQ8Z5gyoH4T7mAMLvqXA5Ob1FCKRQ0DUPasrheKF7Equ6iSWUUisN
         C/kVXblDECMrYe6P9BTlPa1Zwyv1klr6XT9k1FxB6MRmh0z40NWP2AEii4COQBQb/g4Q
         DT9IQR8yxW+ILrH/+Zrv5jJ+YKN02hi69FVzHAnU2iYS4p7Db9M1nvieoWA2Sit1CIAY
         wRgsqDwLnmqCk9ulvk5MqJcnRUg/FEt0C7hdSNe9y+a55evFziEtPyRBqfyFtfjpPs1k
         gMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357935; x=1771962735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9pVbNx2nDpQEXdEb0NUK6ofNX1vMVUT/2xqnV0hFCI=;
        b=EDULCMhdrSipmp5ofXjib0QWY6d2sdGerzsWB+BcUHBZg8ryU05fR61reWCJi3RsbZ
         R8w+vhPPcXDWcnuAIhnvDo+GPZus/RgJ6xoum6OExzQIkwnzCJPBkQ1M5AWyNseWynZp
         vXhiJbMDHoYxC5d9/cQifbkwTii9njIx49eyYh0qKyD7yU9m1nFjOpUPJYHS+cPdCN+P
         ffC+xNutjQdIBT4AF1EWeGxMal5P94kvcchJU3BaYOZIwU+W1cgHDWXdSilLOqV4je3p
         VQNUPPtncNPBwX84zZGqsg6Qxjajf0M7N88bbeW7gxtFeMqzuDA8uLY6e6V1RkK5FPWv
         tOTg==
X-Gm-Message-State: AOJu0Yyo7j89nKBaGuJob4nBq8P2ACYRahrY1hIEg2HjcixF9kkM7rEr
	J8BT0fwBUiEuwOY+6XwWORe1RDJAeZSUsBYbtSV833uxG4q7e90y2HROq/C2kuycweA5mRoApZA
	/WZGSm/jhkALSqAjfsIgW2f7toYwhWxKD+4htK8w8WFH2z9u85z3f5lU/NGqmLW7q2PwB5YGBOq
	dUSDMvcl4zF9/WhaekTMbaEPg2jhZY/IeJGBvsHS1TjTGPWS4=
X-Received: from plsb18.prod.google.com ([2002:a17:902:b612:b0:2a9:5b22:1459])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:fb0:b0:2a9:4870:9606 with SMTP id d9443c01a7336-2ab505ca1b6mr132860125ad.42.1771357934452;
 Tue, 17 Feb 2026 11:52:14 -0800 (PST)
Date: Tue, 17 Feb 2026 11:52:06 -0800
In-Reply-To: <20260217195207.1449764-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217195207.1449764-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217195207.1449764-3-joshwash@google.com>
Subject: [PATCH v2 6.1.y] gve: defer interrupt enabling until NAPI registration
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-216897-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: A454614FBE8
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


