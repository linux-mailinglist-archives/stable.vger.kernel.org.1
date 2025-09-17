Return-Path: <stable+bounces-180396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F4B7FBD8
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 16:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8630517BCAE
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3CE220F34;
	Wed, 17 Sep 2025 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjR2IXSs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90021D599
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117643; cv=none; b=o7FsddS3yrgDkMgsMTCmYewhhy9YGPY4yITmwA6xXP+Xl/AgxFS7CidDp7/heARwqfeuklzvkZtXfAVJP9clgtRkAuGcyPSHGY5HZ+071e6maROTPvNBAagYj0jiH6MQEDvTMB5FNfZGxjnLd8W1k7W+8LT5GAd6jbYZQBM8Xqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117643; c=relaxed/simple;
	bh=PsJmXLFPtFaxAFkqDAFUEJ9SXLDvVVwfaiWpC3mFbrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2lNdgbrRGq2Gmi4dtY05T4mDP90MpBUZwMQPD94ywZKW3xfuWfhhy99GTiVy/QlTA6z19a+8UjHleprgYovomj+46oXhkK2d9+BGQY4YmPQsdwAAYKV5DsCHGCQMBaJLdroxR6Qjmhvx1cBdHxusSCVYeOGXcq0QtwnNpYcKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjR2IXSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B08C4CEE7;
	Wed, 17 Sep 2025 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758117642;
	bh=PsJmXLFPtFaxAFkqDAFUEJ9SXLDvVVwfaiWpC3mFbrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjR2IXSsPRzieYsecpxV7ck4J/XB7oYNg+Wg0HykDQAoAJwOBMQDv0tQz+tz0TrIh
	 0niv7ZzFHZsWNCD0Zfz7aiTrklpJagBpiYqsOpfeBILBgSGY4IOnkLvMnUiDaBFpbq
	 Z3tVDzH/bncyKI0sG712aevI8qvQZJUQ4+/vS7HXzSzTM0qHk0S+aasC0Yfv6tC9wZ
	 1Og9xhSt8Yutc5BGnoFbm06Hj8EMy3K2U0qjDTwNBppJE13Z0bL4RkKJLcqXC0EgSk
	 FdetGw+DizQjkZIeqx2ESggbBPyPDP8Uqn8U7MHo7n3DSzwAAfu3XpHH399o7tR0mE
	 LwniYOK0aHfRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] xhci: dbc: decouple endpoint allocation from initialization
Date: Wed, 17 Sep 2025 10:00:39 -0400
Message-ID: <20250917140040.569374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091706-savings-chatroom-9c46@gregkh>
References: <2025091706-savings-chatroom-9c46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 220a0ffde02f962c13bc752b01aa570b8c65a37b ]

Decouple allocation of endpoint ring buffer from initialization
of the buffer, and initialization of endpoint context parts from
from the rest of the contexts.

It allows driver to clear up and reinitialize endpoint rings
after disconnect without reallocating everything.

This is a prerequisite for the next patch that prevents the transfer
ring from filling up with cancelled (no-op) TRBs if a debug cable is
reconnected several times without transferring anything.

Cc: stable@vger.kernel.org
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250902105306.877476-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.c | 71 ++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 4346a316c77ab..f3b114155cbed 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -86,13 +86,34 @@ static u32 xhci_dbc_populate_strings(struct dbc_str_descs *strings)
 	return string_length;
 }
 
+static void xhci_dbc_init_ep_contexts(struct xhci_dbc *dbc)
+{
+	struct xhci_ep_ctx      *ep_ctx;
+	unsigned int		max_burst;
+	dma_addr_t		deq;
+
+	max_burst               = DBC_CTRL_MAXBURST(readl(&dbc->regs->control));
+
+	/* Populate bulk out endpoint context: */
+	ep_ctx                  = dbc_bulkout_ctx(dbc);
+	deq                     = dbc_bulkout_enq(dbc);
+	ep_ctx->ep_info         = 0;
+	ep_ctx->ep_info2        = dbc_epctx_info2(BULK_OUT_EP, 1024, max_burst);
+	ep_ctx->deq             = cpu_to_le64(deq | dbc->ring_out->cycle_state);
+
+	/* Populate bulk in endpoint context: */
+	ep_ctx                  = dbc_bulkin_ctx(dbc);
+	deq                     = dbc_bulkin_enq(dbc);
+	ep_ctx->ep_info         = 0;
+	ep_ctx->ep_info2        = dbc_epctx_info2(BULK_IN_EP, 1024, max_burst);
+	ep_ctx->deq             = cpu_to_le64(deq | dbc->ring_in->cycle_state);
+}
+
 static void xhci_dbc_init_contexts(struct xhci_dbc *dbc, u32 string_length)
 {
 	struct dbc_info_context	*info;
-	struct xhci_ep_ctx	*ep_ctx;
 	u32			dev_info;
-	dma_addr_t		deq, dma;
-	unsigned int		max_burst;
+	dma_addr_t		dma;
 
 	if (!dbc)
 		return;
@@ -106,20 +127,8 @@ static void xhci_dbc_init_contexts(struct xhci_dbc *dbc, u32 string_length)
 	info->serial		= cpu_to_le64(dma + DBC_MAX_STRING_LENGTH * 3);
 	info->length		= cpu_to_le32(string_length);
 
-	/* Populate bulk out endpoint context: */
-	ep_ctx			= dbc_bulkout_ctx(dbc);
-	max_burst		= DBC_CTRL_MAXBURST(readl(&dbc->regs->control));
-	deq			= dbc_bulkout_enq(dbc);
-	ep_ctx->ep_info		= 0;
-	ep_ctx->ep_info2	= dbc_epctx_info2(BULK_OUT_EP, 1024, max_burst);
-	ep_ctx->deq		= cpu_to_le64(deq | dbc->ring_out->cycle_state);
-
-	/* Populate bulk in endpoint context: */
-	ep_ctx			= dbc_bulkin_ctx(dbc);
-	deq			= dbc_bulkin_enq(dbc);
-	ep_ctx->ep_info		= 0;
-	ep_ctx->ep_info2	= dbc_epctx_info2(BULK_IN_EP, 1024, max_burst);
-	ep_ctx->deq		= cpu_to_le64(deq | dbc->ring_in->cycle_state);
+	/* Populate bulk in and out endpoint contexts: */
+	xhci_dbc_init_ep_contexts(dbc);
 
 	/* Set DbC context and info registers: */
 	lo_hi_writeq(dbc->ctx->dma, &dbc->regs->dccp);
@@ -421,6 +430,23 @@ dbc_alloc_ctx(struct device *dev, gfp_t flags)
 	return ctx;
 }
 
+static void xhci_dbc_ring_init(struct xhci_ring *ring)
+{
+	struct xhci_segment *seg = ring->first_seg;
+
+	/* clear all trbs on ring in case of old ring */
+	memset(seg->trbs, 0, TRB_SEGMENT_SIZE);
+
+	/* Only event ring does not use link TRB */
+	if (ring->type != TYPE_EVENT) {
+		union xhci_trb *trb = &seg->trbs[TRBS_PER_SEGMENT - 1];
+
+		trb->link.segment_ptr = cpu_to_le64(ring->first_seg->dma);
+		trb->link.control = cpu_to_le32(LINK_TOGGLE | TRB_TYPE(TRB_LINK));
+	}
+	xhci_initialize_ring_info(ring, 1);
+}
+
 static struct xhci_ring *
 xhci_dbc_ring_alloc(struct device *dev, enum xhci_ring_type type, gfp_t flags)
 {
@@ -449,15 +475,10 @@ xhci_dbc_ring_alloc(struct device *dev, enum xhci_ring_type type, gfp_t flags)
 
 	seg->dma = dma;
 
-	/* Only event ring does not use link TRB */
-	if (type != TYPE_EVENT) {
-		union xhci_trb *trb = &seg->trbs[TRBS_PER_SEGMENT - 1];
-
-		trb->link.segment_ptr = cpu_to_le64(dma);
-		trb->link.control = cpu_to_le32(LINK_TOGGLE | TRB_TYPE(TRB_LINK));
-	}
 	INIT_LIST_HEAD(&ring->td_list);
-	xhci_initialize_ring_info(ring, 1);
+
+	xhci_dbc_ring_init(ring);
+
 	return ring;
 dma_fail:
 	kfree(seg);
-- 
2.51.0


