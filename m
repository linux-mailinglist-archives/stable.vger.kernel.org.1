Return-Path: <stable+bounces-229859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLTSAZFzwWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:08:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95F2F97E4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85B1F3037C1E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAE53BBA12;
	Mon, 23 Mar 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NpooZEc5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB037B02A;
	Mon, 23 Mar 2026 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283055; cv=none; b=Fsr0yInn/dZNhhJ9l7cQbALei2jtWUm6suI2c185zy+Xloda3nQYpbM+fvuRVXYYWj3YOnblubQtavfChkQC3FCAJ6ILJzo1GcKLl3uYL/xmBwB4OqdHLXrCtia+6ISV3Ep1QSeGhgsg4Vu3XWQ5YzZ7WEGk2HxparL87FB2b/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283055; c=relaxed/simple;
	bh=kdbzlocChMHC6WqLzvdyoPA/+3DWhCLnvIv1dd5euIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYJGEkwpSAc7wGkzilaWevwr3jGzNqLMgSOVKWR+hHTQAFtBzplHOdo+AAa5/RGLFb11vIYLUfBPZKnLaINWUkEND/a8xh0oE8cGguw14go2R0YKCV2AmiJb87pr/r63RLbUdin80OcqaoKpeIa5GNVyfhtHkO1kUrUC22TaE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NpooZEc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82953C4CEF7;
	Mon, 23 Mar 2026 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283054;
	bh=kdbzlocChMHC6WqLzvdyoPA/+3DWhCLnvIv1dd5euIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpooZEc5xD95CF5AYm5tMs+/CnqUsbRPh47R89Cxi/hT7szF+w8/IkYGd6O/Yaf9q
	 +V0UVmPgJ9SOaQUiglYozRsAAoTCEEpBC7ZfUhXuDwcT+o77jY5cZnK3RHu9PRgakg
	 ht2Flcn/omHGxokGvC3wiK6A5xkAx3jxCn3AfMho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ankit Garg <nktgrg@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1 386/481] gve: defer interrupt enabling until NAPI registration
Date: Mon, 23 Mar 2026 14:46:08 +0100
Message-ID: <20260323134534.549696663@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229859-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6D95F2F97E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ankit Garg <nktgrg@google.com>

commit 3d970eda003441f66551a91fda16478ac0711617 upstream.

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
[ modified to re-introduce the irq member to struct gve_notify_block,
  which was introuduced in commit 9a5e0776d11f ("gve: Avoid rescheduling
  napi if on wrong cpu"). ]
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/google/gve/gve.h      |    1 +
 drivers/net/ethernet/google/gve/gve_main.c |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -450,6 +450,7 @@ struct gve_notify_block {
 	struct gve_priv *priv;
 	struct gve_tx_ring *tx; /* tx rings on this block */
 	struct gve_rx_ring *rx; /* rx rings on this block */
+	u32 irq;
 };
 
 /* Tracks allowed and current queue settings */
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -353,9 +353,10 @@ static int gve_alloc_notify_blocks(struc
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
@@ -521,6 +522,7 @@ static void gve_add_napi(struct gve_priv
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
 	netif_napi_add(priv->dev, &block->napi, gve_poll);
+	enable_irq(block->irq);
 }
 
 static void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
@@ -528,6 +530,7 @@ static void gve_remove_napi(struct gve_p
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
 	netif_napi_del(&block->napi);
+	disable_irq(block->irq);
 }
 
 static int gve_register_qpls(struct gve_priv *priv)



