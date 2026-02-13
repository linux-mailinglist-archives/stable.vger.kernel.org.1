Return-Path: <stable+bounces-216304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKVWMeyUj2nNRgEAu9opvQ
	(envelope-from <stable+bounces-216304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:17:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B913993A
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AF77302DB79
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47FF29A33E;
	Fri, 13 Feb 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmy3t6nM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5D28853A
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017428; cv=none; b=nYJJNgpxUvKsO0hngh4xFHgVsieRG93B2wkJCBn4nmkeQWU4gVNgDOK1lMRtHLpqVTY63RDTH5Fnz3WIK/upOTaLpehfnqxmE+nH0tVLVisEBWu1ME/4S1rPoCjWZDUhkZT0cA9GelA2plPcDocrSSd7EQ2pjbsWZeus5h5BcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017428; c=relaxed/simple;
	bh=BcBu20CYHHvz4PgzxGZ40LwrtfUNXv2aHSBdgYTSqIA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aZSTINsLvN+w2fboAMoJvTh+kET62S1rADEuDhvDZnpjJaxTBeE0CwZNsi8ws7hqdHTypCInUfAFW4jAJQRgw+vJF6KBUFEiuCmqD4fdijM1Yvp+yZSBo4wUzdH1FJqJjQjzFMv8wKzE6AB4ZKu5Zg0fGshYkvX7Ep/edHY8U68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmy3t6nM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a9638b0422so9745095ad.3
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 13:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771017427; x=1771622227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uFhLQOW+oDG1DGHKJ3//wmhKqj6J9jbEWhK8t2aymxM=;
        b=lmy3t6nMyZ+fgrIk9GV17OefVO6I0lb2cpOCs5uDgA8Wo5vNMRVdrjasJsQemSPy2f
         eIvMI/UPj21QfGozHgg6P1N1so2q00J93jz+fp4fi3sLRMBINdex1kEIv8q3lIvUAn2r
         iivunWzqjz2uRc8OP4JRq9MevHLgTl0mNYFBHit6helrBMV7vlp/02PPcG8UElJ8yJCs
         sUOZYTbJT/3aUrKVo6lYPn/Aw8AyLmMQB7gSaqUXy9lzIxCA/JuCaLykvNURlOtHZCRn
         E9AiKeciZs10mObXharwJgAlpyCCz5ciluGqdH3e5ATO9mTNWXpFqv5vUhkTnnEQdutl
         qPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771017427; x=1771622227;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFhLQOW+oDG1DGHKJ3//wmhKqj6J9jbEWhK8t2aymxM=;
        b=QbVG2dXgAAPhcgk5i98xazz9yWRNjK70B5y6ieD1T1gtPp62kVjBOyJFXBxy+OAcBo
         9/GrFCjhKHrD2Q3c5mQ7rEEoECggn3ltco+BsVGjt85EKKR+E6h/L7x6P/TMMBh/lBgq
         2I9ZkWjVaGR4ianFjwT52MkMfN4NFLV+UXzJNMtmMiYcsRIyYCglXZWsm88SaLqKBIXZ
         vUDHVcSw49pwUZH7kdCGWlwJR1z0HXC5ip0u9ufr4DRzl/PROu56C7qdO3pWk6hu/X0H
         GMkRvZ+0ziSGvDhHduGIkITiIj7Y4gYh9YmUuz2T0V7SkMHMLMFslSLRTsuvMkWYMnkE
         W37A==
X-Gm-Message-State: AOJu0YxB4x84IXAK3oP7qVm1ZpWm5Cri2IKpDKeA397z+0xFUMK1oO9M
	aUQwGVtI56dNj5hwj/jZXV1G9Gyo07Kjx1OzBvkuq1t2ANaK5WEHa6OWf1VcviEnJfRzQVvOGfK
	jcMCWzFohHW1SnmvKbpM5HHOwGRuoEGdTTr76k8M0KjpOP/LypXj7tFuG9lgndvzc3s9sEvtdkH
	flyIUq4g2Q/TIaHeqdPsMgZtgP6ZNCPkZ1VbCxgHlisHY1zfI=
X-Received: from plgb3.prod.google.com ([2002:a17:902:d503:b0:2aa:d670:bf3b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70d:b0:2aa:d34d:a805 with SMTP id d9443c01a7336-2ad1748af8fmr7520985ad.27.1771017426332;
 Fri, 13 Feb 2026 13:17:06 -0800 (PST)
Date: Fri, 13 Feb 2026 13:16:59 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260213211702.447894-1-joshwash@google.com>
Subject: [PATCH 5.10.y] gve: defer interrupt enabling until NAPI registration
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-216304-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 2E2B913993A
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


