Return-Path: <stable+bounces-179902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63BB7E146
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B011B22945
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855D1EF363;
	Wed, 17 Sep 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne/GfBMe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1831A81C
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112753; cv=none; b=fr2BlF1uN/d1HHXeI3eC013VHB+ssJ5itHrBM0ipkWIjNQJbpUXGrxVzOT6DUI5a6OdADhc0o7LCTYpOgCv8Th79nN+rCobrhrq3VNkEtLhWiEucfSRvANvNn9LjvfsAInmWB2eJtxxfc0weWW5fWJnH0Jxew2YmA3oG5xeal6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112753; c=relaxed/simple;
	bh=WbEVtraOI4NT5tG2tmdmPZREmZI9RVXLn7i5JmjBVUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAAuHXBvv7V4vj3YKu9fdbnukHAfZzP/P53wittLrsvjf2Fp3kgNPD9hdSmpc4THQ5LQ1OSDFSDsOEo9sDQTmYw0MqUgSoqtZ2hJ1txuuh900TW/OB4Wv6o3sUmzWYod52vjCxmKSZ3Hjk7Ke5PyqMUtkKuHWzNQT2iEK492JFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne/GfBMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE1FC4CEFB;
	Wed, 17 Sep 2025 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758112753;
	bh=WbEVtraOI4NT5tG2tmdmPZREmZI9RVXLn7i5JmjBVUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ne/GfBMeV+27JjwXScQ6gP6KJKQSFvNFa/8wyFqyhtEKucZHriC8XS5qr002O5wAp
	 pbmddpf9Mo1fci2eLd8aXaoi3m9aPnR0PLX4F+GQRpKbGWJcOP6pZ2EGonFGjweHYF
	 L98Q72eJqd2H94FYK7LQ7sh1YJNtOdfJ5q7aGgm08lfF4oY3+V+uztcTM1v8O6DM8S
	 SGgnNKcfHTllRh/ClWcRcol3kDybQwpPWGtG69izzBDqX9Leyw+ydu6WlOQ+YtUL1u
	 Nno+B2Dr25l7dGZxTrFz7g72cPasruw3ImrSAGWc9+QpT7JXEcvEnKPvRcQTUE2ib/
	 6Aw3of1Kv+bSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] usb: xhci: remove option to change a default ring's TRB cycle bit
Date: Wed, 17 Sep 2025 08:39:07 -0400
Message-ID: <20250917123909.514131-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123909.514131-1-sashal@kernel.org>
References: <2025091756-glare-cyclic-9298@gregkh>
 <20250917123909.514131-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit e1b0fa863907a61e86acc19ce2d0633941907c8e ]

The TRB cycle bit indicates TRB ownership by the Host Controller (HC) or
Host Controller Driver (HCD). New rings are initialized with 'cycle_state'
equal to one, and all its TRBs' cycle bits are set to zero. When handling
ring expansion, set the source ring cycle bits to the same value as the
destination ring.

Move the cycle bit setting from xhci_segment_alloc() to xhci_link_rings(),
and remove the 'cycle_state' argument from xhci_initialize_ring_info().
The xhci_segment_alloc() function uses kzalloc_node() to allocate segments,
ensuring that all TRB cycle bits are initialized to zero.

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-12-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer ring after several reconnects")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.c |  2 +-
 drivers/usb/host/xhci-mem.c    | 50 ++++++++++++++++------------------
 drivers/usb/host/xhci.c        |  2 +-
 drivers/usb/host/xhci.h        |  6 ++--
 4 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index bdc664ad6a934..74ba99573fd02 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -471,7 +471,7 @@ xhci_dbc_ring_alloc(struct device *dev, enum xhci_ring_type type, gfp_t flags)
 		trb->link.control = cpu_to_le32(LINK_TOGGLE | TRB_TYPE(TRB_LINK));
 	}
 	INIT_LIST_HEAD(&ring->td_list);
-	xhci_initialize_ring_info(ring, 1);
+	xhci_initialize_ring_info(ring);
 	return ring;
 dma_fail:
 	kfree(seg);
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 80b2f946b59fe..bd1a4249212b3 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -27,14 +27,12 @@
  * "All components of all Command and Transfer TRBs shall be initialized to '0'"
  */
 static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
-					       unsigned int cycle_state,
 					       unsigned int max_packet,
 					       unsigned int num,
 					       gfp_t flags)
 {
 	struct xhci_segment *seg;
 	dma_addr_t	dma;
-	int		i;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 
 	seg = kzalloc_node(sizeof(*seg), flags, dev_to_node(dev));
@@ -56,11 +54,6 @@ static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
 			return NULL;
 		}
 	}
-	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs */
-	if (cycle_state == 0) {
-		for (i = 0; i < TRBS_PER_SEGMENT; i++)
-			seg->trbs[i].link.control = cpu_to_le32(TRB_CYCLE);
-	}
 	seg->num = num;
 	seg->dma = dma;
 	seg->next = NULL;
@@ -138,6 +131,14 @@ static void xhci_link_rings(struct xhci_hcd *xhci, struct xhci_ring *ring,
 
 	chain_links = xhci_link_chain_quirk(xhci, ring->type);
 
+	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs */
+	if (ring->cycle_state == 0) {
+		xhci_for_each_ring_seg(ring->first_seg, seg) {
+			for (int i = 0; i < TRBS_PER_SEGMENT; i++)
+				seg->trbs[i].link.control |= cpu_to_le32(TRB_CYCLE);
+		}
+	}
+
 	next = ring->enq_seg->next;
 	xhci_link_segments(ring->enq_seg, first, ring->type, chain_links);
 	xhci_link_segments(last, next, ring->type, chain_links);
@@ -287,8 +288,7 @@ void xhci_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring)
 	kfree(ring);
 }
 
-void xhci_initialize_ring_info(struct xhci_ring *ring,
-			       unsigned int cycle_state)
+void xhci_initialize_ring_info(struct xhci_ring *ring)
 {
 	/* The ring is empty, so the enqueue pointer == dequeue pointer */
 	ring->enqueue = ring->first_seg->trbs;
@@ -302,7 +302,7 @@ void xhci_initialize_ring_info(struct xhci_ring *ring,
 	 * New rings are initialized with cycle state equal to 1; if we are
 	 * handling ring expansion, set the cycle state equal to the old ring.
 	 */
-	ring->cycle_state = cycle_state;
+	ring->cycle_state = 1;
 
 	/*
 	 * Each segment has a link TRB, and leave an extra TRB for SW
@@ -317,7 +317,6 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 					struct xhci_segment **first,
 					struct xhci_segment **last,
 					unsigned int num_segs,
-					unsigned int cycle_state,
 					enum xhci_ring_type type,
 					unsigned int max_packet,
 					gfp_t flags)
@@ -328,7 +327,7 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 
 	chain_links = xhci_link_chain_quirk(xhci, type);
 
-	prev = xhci_segment_alloc(xhci, cycle_state, max_packet, num, flags);
+	prev = xhci_segment_alloc(xhci, max_packet, num, flags);
 	if (!prev)
 		return -ENOMEM;
 	num++;
@@ -337,8 +336,7 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 	while (num < num_segs) {
 		struct xhci_segment	*next;
 
-		next = xhci_segment_alloc(xhci, cycle_state, max_packet, num,
-					  flags);
+		next = xhci_segment_alloc(xhci, max_packet, num, flags);
 		if (!next)
 			goto free_segments;
 
@@ -363,9 +361,8 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
  * Set the end flag and the cycle toggle bit on the last segment.
  * See section 4.9.1 and figures 15 and 16.
  */
-struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
-		unsigned int num_segs, unsigned int cycle_state,
-		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags)
+struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int num_segs,
+				  enum xhci_ring_type type, unsigned int max_packet, gfp_t flags)
 {
 	struct xhci_ring	*ring;
 	int ret;
@@ -383,7 +380,7 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
 		return ring;
 
 	ret = xhci_alloc_segments_for_ring(xhci, &ring->first_seg, &ring->last_seg, num_segs,
-					   cycle_state, type, max_packet, flags);
+					   type, max_packet, flags);
 	if (ret)
 		goto fail;
 
@@ -393,7 +390,7 @@ struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
 		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
 			cpu_to_le32(LINK_TOGGLE);
 	}
-	xhci_initialize_ring_info(ring, cycle_state);
+	xhci_initialize_ring_info(ring);
 	trace_xhci_ring_alloc(ring);
 	return ring;
 
@@ -421,8 +418,8 @@ int xhci_ring_expansion(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	struct xhci_segment	*last;
 	int			ret;
 
-	ret = xhci_alloc_segments_for_ring(xhci, &first, &last, num_new_segs, ring->cycle_state,
-					   ring->type, ring->bounce_buf_len, flags);
+	ret = xhci_alloc_segments_for_ring(xhci, &first, &last, num_new_segs, ring->type,
+					   ring->bounce_buf_len, flags);
 	if (ret)
 		return -ENOMEM;
 
@@ -632,8 +629,7 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 
 	for (cur_stream = 1; cur_stream < num_streams; cur_stream++) {
 		stream_info->stream_rings[cur_stream] =
-			xhci_ring_alloc(xhci, 2, 1, TYPE_STREAM, max_packet,
-					mem_flags);
+			xhci_ring_alloc(xhci, 2, TYPE_STREAM, max_packet, mem_flags);
 		cur_ring = stream_info->stream_rings[cur_stream];
 		if (!cur_ring)
 			goto cleanup_rings;
@@ -974,7 +970,7 @@ int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
 	}
 
 	/* Allocate endpoint 0 ring */
-	dev->eps[0].ring = xhci_ring_alloc(xhci, 2, 1, TYPE_CTRL, 0, flags);
+	dev->eps[0].ring = xhci_ring_alloc(xhci, 2, TYPE_CTRL, 0, flags);
 	if (!dev->eps[0].ring)
 		goto fail;
 
@@ -1457,7 +1453,7 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 
 	/* Set up the endpoint ring */
 	virt_dev->eps[ep_index].new_ring =
-		xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
+		xhci_ring_alloc(xhci, 2, ring_type, max_packet, mem_flags);
 	if (!virt_dev->eps[ep_index].new_ring)
 		return -ENOMEM;
 
@@ -2266,7 +2262,7 @@ xhci_alloc_interrupter(struct xhci_hcd *xhci, unsigned int segs, gfp_t flags)
 	if (!ir)
 		return NULL;
 
-	ir->event_ring = xhci_ring_alloc(xhci, segs, 1, TYPE_EVENT, 0, flags);
+	ir->event_ring = xhci_ring_alloc(xhci, segs, TYPE_EVENT, 0, flags);
 	if (!ir->event_ring) {
 		xhci_warn(xhci, "Failed to allocate interrupter event ring\n");
 		kfree(ir);
@@ -2472,7 +2468,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 		goto fail;
 
 	/* Set up the command ring to have one segments for now. */
-	xhci->cmd_ring = xhci_ring_alloc(xhci, 1, 1, TYPE_COMMAND, 0, flags);
+	xhci->cmd_ring = xhci_ring_alloc(xhci, 1, TYPE_COMMAND, 0, flags);
 	if (!xhci->cmd_ring)
 		goto fail;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index abbf89e82d01a..3970ec831b8ca 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -769,7 +769,7 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
 		seg->trbs[TRBS_PER_SEGMENT - 1].link.control &= cpu_to_le32(~TRB_CYCLE);
 	}
 
-	xhci_initialize_ring_info(ring, 1);
+	xhci_initialize_ring_info(ring);
 	/*
 	 * Reset the hardware dequeue pointer.
 	 * Yes, this will need to be re-written after resume, but we're paranoid
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index b4fa8e7e43763..b2aeb444daaf5 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1803,14 +1803,12 @@ void xhci_slot_copy(struct xhci_hcd *xhci,
 int xhci_endpoint_init(struct xhci_hcd *xhci, struct xhci_virt_device *virt_dev,
 		struct usb_device *udev, struct usb_host_endpoint *ep,
 		gfp_t mem_flags);
-struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
-		unsigned int num_segs, unsigned int cycle_state,
+struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci, unsigned int num_segs,
 		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags);
 void xhci_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring);
 int xhci_ring_expansion(struct xhci_hcd *xhci, struct xhci_ring *ring,
 		unsigned int num_trbs, gfp_t flags);
-void xhci_initialize_ring_info(struct xhci_ring *ring,
-			unsigned int cycle_state);
+void xhci_initialize_ring_info(struct xhci_ring *ring);
 void xhci_free_endpoint_ring(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		unsigned int ep_index);
-- 
2.51.0


