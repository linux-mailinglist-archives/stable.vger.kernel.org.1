Return-Path: <stable+bounces-204748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABE0CF3712
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 13:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12EFA30239E2
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 12:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234EF33A6E8;
	Mon,  5 Jan 2026 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WKY2vGG0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53ED33A6E7
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613983; cv=none; b=m+E+9+VI6+p29GSiW71mMYhchzavZ7adJnhGR+9HQuWvY1hPf0D9TycjnRrDLz/9D5qY04NWn5MRHIhCPKxZDyloRRKaxXxBE/id+et9PN/XzjSNsXATeR5y8V6ZC6x1mUh71b2AgTBh4j5tmRnEUNkQ8ofymdWSdaEgvguLER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613983; c=relaxed/simple;
	bh=v9+ra3IA3pfGvqZpOq81SLvQxLq7k2p7h3rw9GEcieQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rzQtL9SBd7YBAYgn4MTRSvT/VDF1TFGPjVHmZ+unMmt+ST7XcZVTmwTQ9F1INM/wiXJYKTSKYgYs//YTzT3exsRPhH2Tkl2KZk2Q78Xt6vVDHtSHriFZtHAirGZK4Mw8H/1Fa3pF0ilZHMqWLhOUwI38XIcX5Kkv2lfKsii3oro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WKY2vGG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA5CC116D0;
	Mon,  5 Jan 2026 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767613982;
	bh=v9+ra3IA3pfGvqZpOq81SLvQxLq7k2p7h3rw9GEcieQ=;
	h=Subject:To:Cc:From:Date:From;
	b=WKY2vGG074CvbdSpFP+cu9x+lLw+4fhb/ZqA8GwT/DJxhWjtGujG+zopWqYKRkyUO
	 lanI9SXVSz/N/8e2EP1vaPEj5LX2wEjMIfArtJIpJrFiLb4leI0vhGQrJAxQQON/gS
	 UvUNCaGWm1WQII5bjzzGnAzHS+GoJlQgN10WT/2s=
Subject: FAILED: patch "[PATCH] gve: defer interrupt enabling until NAPI registration" failed to apply to 6.12-stable tree
To: nktgrg@google.com,hramamurthy@google.com,jordanrhee@google.com,joshwash@google.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:52:59 +0100
Message-ID: <2026010559-clock-gore-94e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3d970eda003441f66551a91fda16478ac0711617
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010559-clock-gore-94e2@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d970eda003441f66551a91fda16478ac0711617 Mon Sep 17 00:00:00 2001
From: Ankit Garg <nktgrg@google.com>
Date: Fri, 19 Dec 2025 10:29:45 +0000
Subject: [PATCH] gve: defer interrupt enabling until NAPI registration

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
Link: https://patch.msgid.link/20251219102945.2193617-1-hramamurthy@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index a7a088a77f37..7eb64e1e4d85 100644
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
index ace9b8698021..b53b7fcdcdaf 100644
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


