Return-Path: <stable+bounces-182072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF83BAD0C4
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E66188AC31
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6B3002BD;
	Tue, 30 Sep 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFUrFLmD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F1224AF0
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238721; cv=none; b=Fi+CXfLb6fHdux53MhnhYIzbxc8rpE+X98MFhN4RHwjlyZL5MEt0N8KE2TkMB6XKDS/bjJagyxdubV2tW/BMZf9Op1ixiJVS5OCFkZQEyUwVbVJ/3R4QNXM9bjM8KsKVl7f/kGv7NRcTGa51IDaNG/wLpHyBkJ1fvCQuw5+lrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238721; c=relaxed/simple;
	bh=nFDIf6ZOaLzvtYTOh0avXQKAMxMMJt//QR2HPBc6+YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZ2UT38xKNd4X4ha393pPKdAAWZcaWOX1XNEUoqjkvf+6+jL3zFGg1s1dZabFKok0E1mvMZ8YvBsyNfq+KRV94yjWxQNYcoo3mue0z9VJftddbE2a0SAVHCetMf3MV6rA5U9/jv5hJl0uXMUzUP2q2DP6DmRn0HFAHtJUnzX6xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFUrFLmD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759238717; x=1790774717;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nFDIf6ZOaLzvtYTOh0avXQKAMxMMJt//QR2HPBc6+YE=;
  b=fFUrFLmDtX53H9Fz/6P4scIySS5m5981+2J2n4UFUZfGzFzZeP3yWSFd
   tWxE5nBpgbZNLkTJ16Lg+lk7KpYonH2/18+wU2uqUNZPbHjG8cMT8SPkV
   et7GWN4qznXGQsWREZTs5II9Va03PJCKHDmLWvPjSjnZyPUsGbYOH2jPk
   phUOo6pnYpMjrcheOFwrSTYRmwjgSVWpxblPMwb776jVWlSW1vGXAeAlg
   exxZ0T+I4kwHjCcjyyXtIvH0S3J0F+Eo5Xf17HecXOzvcYO0RSHsOHS1v
   av4diUqtgPDj3R9Fd9ZmiTuQ3q10VwqDHlFizI1XF0RD0q/N3OpDngwcA
   g==;
X-CSE-ConnectionGUID: r+fnxreETVq0cGm1SOfX5g==
X-CSE-MsgGUID: Yb4U/RwYRFmD76qb2CHPMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72113016"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="72113016"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 06:25:17 -0700
X-CSE-ConnectionGUID: 6wQD1NsPSZ2G6ZpG3xuvHA==
X-CSE-MsgGUID: /hdPGoFtR1uDIoaqB4nA1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178483486"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 30 Sep 2025 06:25:15 -0700
Received: by black.igk.intel.com (Postfix, from userid 1058)
	id 2430695; Tue, 30 Sep 2025 15:25:14 +0200 (CEST)
From: Niklas Neronin <niklas.neronin@linux.intel.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mathias.nyman@linux.intel.com,
	Niklas Neronin <niklas.neronin@linux.intel.com>,
	Wolfgang Walter <linux@stwm.de>
Subject: [PATCH] Revert "usb: xhci: remove option to change a default ring's TRB cycle bit"
Date: Tue, 30 Sep 2025 15:22:51 +0200
Message-ID: <20250930132251.945081-1-niklas.neronin@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert 9b28ef1e4cc0 [ Upstream commit e1b0fa863907 ], it causes regression
in 6.12.49 stable, no issues in upstream.

Commit 9b28ef1e4cc0 ("usb: xhci: remove option to change a default ring's
TRB cycle bit") introduced a regression in 6.12.49 stable kernel.
The original commit was never intended for stable kernels, but was added
as a dependency for commit a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer
ring after several reconnects").

Since this commit is more of an optimization, revert it and solve the
dependecy by modifying one line in xhci_dbc_ring_init(). Specifically,
commit a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer ring after several
reconnects") moved function call xhci_initialize_ring_info() into a
separate function. To resolve the dependency, the arguments for this
function call are also reverted.

Closes: https://lore.kernel.org/stable/01b8c8de46251cfaad1329a46b7e3738@stwm.de/
Tested-by: Wolfgang Walter <linux@stwm.de>
Cc: stable@vger.kernel.org # v6.12.49
Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c |  2 +-
 drivers/usb/host/xhci-mem.c    | 50 ++++++++++++++++++----------------
 drivers/usb/host/xhci.c        |  2 +-
 drivers/usb/host/xhci.h        |  6 ++--
 4 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 1fcc9348dd43..123506681ef0 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -458,7 +458,7 @@ static void xhci_dbc_ring_init(struct xhci_ring *ring)
 		trb->link.segment_ptr = cpu_to_le64(ring->first_seg->dma);
 		trb->link.control = cpu_to_le32(LINK_TOGGLE | TRB_TYPE(TRB_LINK));
 	}
-	xhci_initialize_ring_info(ring);
+	xhci_initialize_ring_info(ring, 1);
 }
 
 static int xhci_dbc_reinit_ep_rings(struct xhci_dbc *dbc)
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index c9694526b157..f0ed38da6a0c 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -27,12 +27,14 @@
  * "All components of all Command and Transfer TRBs shall be initialized to '0'"
  */
 static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
+					       unsigned int cycle_state,
 					       unsigned int max_packet,
 					       unsigned int num,
 					       gfp_t flags)
 {
 	struct xhci_segment *seg;
 	dma_addr_t	dma;
+	int		i;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 
 	seg = kzalloc_node(sizeof(*seg), flags, dev_to_node(dev));
@@ -54,6 +56,11 @@ static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
 			return NULL;
 		}
 	}
+	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs */
+	if (cycle_state == 0) {
+		for (i = 0; i < TRBS_PER_SEGMENT; i++)
+			seg->trbs[i].link.control = cpu_to_le32(TRB_CYCLE);
+	}
 	seg->num = num;
 	seg->dma = dma;
 	seg->next = NULL;
@@ -131,14 +138,6 @@ static void xhci_link_rings(struct xhci_hcd *xhci, struct xhci_ring *ring,
 
 	chain_links = xhci_link_chain_quirk(xhci, ring->type);
 
-	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs */
-	if (ring->cycle_state == 0) {
-		xhci_for_each_ring_seg(ring->first_seg, seg) {
-			for (int i = 0; i < TRBS_PER_SEGMENT; i++)
-				seg->trbs[i].link.control |= cpu_to_le32(TRB_CYCLE);
-		}
-	}
-
 	next = ring->enq_seg->next;
 	xhci_link_segments(ring->enq_seg, first, ring->type, chain_links);
 	xhci_link_segments(last, next, ring->type, chain_links);
@@ -288,7 +287,8 @@ void xhci_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring)
 	kfree(ring);
 }
 
-void xhci_initialize_ring_info(struct xhci_ring *ring)
+void xhci_initialize_ring_info(struct xhci_ring *ring,
+			       unsigned int cycle_state)
 {
 	/* The ring is empty, so the enqueue pointer == dequeue pointer */
 	ring->enqueue = ring->first_seg->trbs;
@@ -302,7 +302,7 @@ void xhci_initialize_ring_info(struct xhci_ring *ring)
 	 * New rings are initialized with cycle state equal to 1; if we are
 	 * handling ring expansion, set the cycle state equal to the old ring.
 	 */
-	ring->cycle_state = 1;
+	ring->cycle_state = cycle_state;
 
 	/*
 	 * Each segment has a link TRB, and leave an extra TRB for SW
@@ -317,6 +317,7 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 					struct xhci_segment **first,
 					struct xhci_segment **last,
 					unsigned int num_segs,
+					unsigned int cycle_state,
 					enum xhci_ring_type type,
 					unsigned int max_packet,
 					gfp_t flags)
@@ -327,7 +328,7 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 
 	chain_links = xhci_link_chain_quirk(xhci, type);
 
-	prev = xhci_segment_alloc(xhci, max_packet, num, flags);
+	prev = xhci_segment_alloc(xhci, cycle_state, max_packet, num, flags);
 	if (!prev)
 		return -ENOMEM;
 	num++;
@@ -336,7 +337,8 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 	while (num < num_segs) {
 		struct xhci_segment	*next;
 
-		next = xhci_segment_alloc(xhci, max_packet, num, flags);
+		next = xhci_segment_alloc(xhci, cycle_state, max_packet, num,
+					  flags);
 		if (!next)
 			goto free_segments;
 
@@ -361,8 +363,9 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
  * Set the end flag and the cycle toggle bit on the last segment.
  * See section 4.9.1 and figures 15 and 16.
  */
-struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int num_segs,
-				  enum xhci_ring_type type, unsigned int max_packet, gfp_t flags)
+struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
+		unsigned int num_segs, unsigned int cycle_state,
+		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags)
 {
 	struct xhci_ring	*ring;
 	int ret;
@@ -380,7 +383,7 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int num_segs,
 		return ring;
 
 	ret = xhci_alloc_segments_for_ring(xhci, &ring->first_seg, &ring->last_seg, num_segs,
-					   type, max_packet, flags);
+					   cycle_state, type, max_packet, flags);
 	if (ret)
 		goto fail;
 
@@ -390,7 +393,7 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int num_segs,
 		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
 			cpu_to_le32(LINK_TOGGLE);
 	}
-	xhci_initialize_ring_info(ring);
+	xhci_initialize_ring_info(ring, cycle_state);
 	trace_xhci_ring_alloc(ring);
 	return ring;
 
@@ -418,8 +421,8 @@ int xhci_ring_expansion(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	struct xhci_segment	*last;
 	int			ret;
 
-	ret = xhci_alloc_segments_for_ring(xhci, &first, &last, num_new_segs, ring->type,
-					   ring->bounce_buf_len, flags);
+	ret = xhci_alloc_segments_for_ring(xhci, &first, &last, num_new_segs, ring->cycle_state,
+					   ring->type, ring->bounce_buf_len, flags);
 	if (ret)
 		return -ENOMEM;
 
@@ -629,7 +632,8 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 
 	for (cur_stream = 1; cur_stream < num_streams; cur_stream++) {
 		stream_info->stream_rings[cur_stream] =
-			xhci_ring_alloc(xhci, 2, TYPE_STREAM, max_packet, mem_flags);
+			xhci_ring_alloc(xhci, 2, 1, TYPE_STREAM, max_packet,
+					mem_flags);
 		cur_ring = stream_info->stream_rings[cur_stream];
 		if (!cur_ring)
 			goto cleanup_rings;
@@ -970,7 +974,7 @@ int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
 	}
 
 	/* Allocate endpoint 0 ring */
-	dev->eps[0].ring = xhci_ring_alloc(xhci, 2, TYPE_CTRL, 0, flags);
+	dev->eps[0].ring = xhci_ring_alloc(xhci, 2, 1, TYPE_CTRL, 0, flags);
 	if (!dev->eps[0].ring)
 		goto fail;
 
@@ -1453,7 +1457,7 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 
 	/* Set up the endpoint ring */
 	virt_dev->eps[ep_index].new_ring =
-		xhci_ring_alloc(xhci, 2, ring_type, max_packet, mem_flags);
+		xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
 	if (!virt_dev->eps[ep_index].new_ring)
 		return -ENOMEM;
 
@@ -2262,7 +2266,7 @@ xhci_alloc_interrupter(struct xhci_hcd *xhci, unsigned int segs, gfp_t flags)
 	if (!ir)
 		return NULL;
 
-	ir->event_ring = xhci_ring_alloc(xhci, segs, TYPE_EVENT, 0, flags);
+	ir->event_ring = xhci_ring_alloc(xhci, segs, 1, TYPE_EVENT, 0, flags);
 	if (!ir->event_ring) {
 		xhci_warn(xhci, "Failed to allocate interrupter event ring\n");
 		kfree(ir);
@@ -2468,7 +2472,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 		goto fail;
 
 	/* Set up the command ring to have one segments for now. */
-	xhci->cmd_ring = xhci_ring_alloc(xhci, 1, TYPE_COMMAND, 0, flags);
+	xhci->cmd_ring = xhci_ring_alloc(xhci, 1, 1, TYPE_COMMAND, 0, flags);
 	if (!xhci->cmd_ring)
 		goto fail;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3970ec831b8c..abbf89e82d01 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -769,7 +769,7 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
 		seg->trbs[TRBS_PER_SEGMENT - 1].link.control &= cpu_to_le32(~TRB_CYCLE);
 	}
 
-	xhci_initialize_ring_info(ring);
+	xhci_initialize_ring_info(ring, 1);
 	/*
 	 * Reset the hardware dequeue pointer.
 	 * Yes, this will need to be re-written after resume, but we're paranoid
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index b2aeb444daaf..b4fa8e7e4376 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1803,12 +1803,14 @@ void xhci_slot_copy(struct xhci_hcd *xhci,
 int xhci_endpoint_init(struct xhci_hcd *xhci, struct xhci_virt_device *virt_dev,
 		struct usb_device *udev, struct usb_host_endpoint *ep,
 		gfp_t mem_flags);
-struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int num_segs,
+struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
+		unsigned int num_segs, unsigned int cycle_state,
 		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags);
 void xhci_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring);
 int xhci_ring_expansion(struct xhci_hcd *xhci, struct xhci_ring *ring,
 		unsigned int num_trbs, gfp_t flags);
-void xhci_initialize_ring_info(struct xhci_ring *ring);
+void xhci_initialize_ring_info(struct xhci_ring *ring,
+			unsigned int cycle_state);
 void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		unsigned int ep_index);
-- 
2.50.1


