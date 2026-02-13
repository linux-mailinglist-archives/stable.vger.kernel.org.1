Return-Path: <stable+bounces-216307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL30EfiUj2nNRgEAu9opvQ
	(envelope-from <stable+bounces-216307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:17:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7108A139948
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 22:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C98F3047074
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED5D295DBD;
	Fri, 13 Feb 2026 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNsJTiwo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB629BDB4
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017434; cv=none; b=dQWjxVyWsc4hiZfY/IcgqxC45jYjTEnQ1SYIH69GuJH2M4eacyGMSWQ4vWZfrD5+fRywATpcuXBhmVo3z3dwCVF5uNH2PH88pJprfVbkUaSeC2FcI8iudLzNsjUFQ8EmoJ1dKre77sECSXbMeTb1RHByIYSn5OF0/myRlygsU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017434; c=relaxed/simple;
	bh=/AyAPYTjZOcfpnEJ0UCdL9gNBBSCghmrCvlRRTrLO4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XnhAsSagcVfXsWJ5GUby9b7WRlkZKb1aiMoMXXkX2YcoDySL+2YK03oD9IH3wd7nXBNkBMMIFjBEEsF8IpMDc+XRByPQKtCT1rY7cYmIhWhZ5XQw/MFPOvb5HpEjXnAFyIXQ1ZIqLxFanbUJVAcThNbb7Y2YrB01ltYReWeFfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNsJTiwo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aae3810558so15468015ad.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 13:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771017432; x=1771622232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5F/DV7qunIfssbGjutTB+45QtR8F7qu6VdmEYtObSU=;
        b=lNsJTiwoM5WQAzyMPa6utZbqdqtPdDA8IQF998wkB3jISCoDpOAqB3Z7MVR+Kl88oG
         AV5kqeGyjgO5m8sU5uNSGLKLfPnd0qMG1fB0NhFMuxPgMwFSJtEdPT8Y8oQRsZGcbXoO
         p9PhcCIL/BNx3FiWIqL3Dq6huSE0nr+UJw9VNxml7O8g4UW0yLcXOa6ZCid4idAVKcQw
         q1QI6j55I/WI4Az4pamBz6CE+K7DJZcDJ5rrD51JqPI1PU59R3248taklmTvBbvhPlrO
         u3Cakh4Wnkhou3044+ybFY1LeP9w03Vx6PiCNlGVESUFj6EaUYJQCJocAxmwHng87Rto
         qYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771017432; x=1771622232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5F/DV7qunIfssbGjutTB+45QtR8F7qu6VdmEYtObSU=;
        b=ZM+UMfGS2A9c/CXY+fbL6ypXoF12fdZOAbM/oWQQW2qIMNKMBtf4Y7iKzLCGeiaQoc
         2w3/HXcF9Nr/1db+eizlvPCXfdNcUVfncUw21iGBxE3G7tlXr+o4GetYTDh1+YI7u5bM
         Xd465MLzzLsrz+slZQvST83rrSMbOtio4g5JuWDoKIKp7/DmnT5g/6z79n0HapNlOTi2
         s+55MJqprLM+kxMp7pIiWRcnWJnR8vPcnHuS2IyuazkWyWpEEcBhlquYkbmF2rJZhcHk
         mq/UWM7GM8CUoANYXn0PCMIqw+PlXqmY3XMs2sLndoS7kpsGNqvECFLdlqaolHI6t1BH
         KmJw==
X-Gm-Message-State: AOJu0YxmgP22dP3yjVoHW7DfZppaqFhFTavkK0dUR7uxBeROfVo94AW1
	sntTfTrkWH/4E/iVwbv8b0JnuiMOR53KMWWbmiBztVjG26tBgzAGMInCrSDYN+D451ZQcU/s8s8
	X4KLkMNABeAXD9otR9Iu8pAEj6gKQDOq1fGiYFP5a3Qp/OMeyLf4AhC8FztdFmvPOJ9wRRJdYuv
	UpSDOtIJ4LkwPhRqYlN0NtGGz8DO1hqFN8QCeOp+Ma1HK6kHo=
X-Received: from plbkn16.prod.google.com ([2002:a17:903:790:b0:2a8:759b:173d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:198e:b0:2a7:afca:fd1d with SMTP id d9443c01a7336-2ab5053ea82mr26408015ad.14.1771017431702;
 Fri, 13 Feb 2026 13:17:11 -0800 (PST)
Date: Fri, 13 Feb 2026 13:17:02 -0800
In-Reply-To: <20260213211702.447894-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213211702.447894-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260213211702.447894-4-joshwash@google.com>
Subject: [PATCH 6.6.y] gve: defer interrupt enabling until NAPI registration
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
	TAGGED_FROM(0.00)[bounces-216307-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,pci:email]
X-Rspamd-Queue-Id: 7108A139948
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


