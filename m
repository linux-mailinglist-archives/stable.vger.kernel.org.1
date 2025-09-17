Return-Path: <stable+bounces-179900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6188B7E29D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A9B7B58BF
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A731A80A;
	Wed, 17 Sep 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6AZ0/Vx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E81E25EF
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112752; cv=none; b=S1HaXgiwxsvT0GK2WRT/jHS1codgyWgz5qLuHY1m4MR+n6o06HuX85Q5u3SvXO4AC0q9fI0Ld4uYWVJ4yGlmH35CjghJrR7Yz/aMyrPiDnELjRI96mbSAo44PtBGdJvQAPzKTfihuEiTTgWEPpU8G7KG7rZktxQlUqdPEA0ORcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112752; c=relaxed/simple;
	bh=fEecE37pdwKslWFLT4CbMnWzKyAAMUnj887x3FAsP18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5BJ7gQjQJw+nOASy6PkA+D71sK8lxGRTBiimr1UnsifaXcGNWXDfLaq1tyLfuIfpUKdFhbLXuvuynTI0uWQe/KV9VjkTSkt233O6BsAMeHtnzSo+s4JfrIZFWD+exV/w14z5q3ksDj+/vx6t1CYdp1dUZ9rrIFLWGUvytUtrmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6AZ0/Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8592C4CEF0;
	Wed, 17 Sep 2025 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758112752;
	bh=fEecE37pdwKslWFLT4CbMnWzKyAAMUnj887x3FAsP18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6AZ0/VxO1OuM1B5fVXoevUavxcAYfddSiIXs/6z5Ol91UXRs5Lpza3mRR/o7EjzY
	 /rVS9CKtMC9HbJ5N9plxjOfMawjQsMb67b2xxZdl+YZy/RKfKre0xvk/6bvWqW3pYh
	 JVAaMm9iLrWgKz5Pt2/xbs6XmJOP8oE5Jv+RewWSYqeP92FItnUYmw4XOUbEJiCban
	 FgK2uirXYUdVoK/vc+UcVnZyUpNWwQm3wFn3Q9e3AbCvwClKMRChHkn0JnlnqK4gn7
	 mmZCEN8df1OG/orOHBN2Du6tMemqef2ponezv81oJxOSvXY2vmN6i8E2eGYsgvIPRN
	 rrSrvy8kQWSeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] usb: xhci: introduce macro for ring segment list iteration
Date: Wed, 17 Sep 2025 08:39:06 -0400
Message-ID: <20250917123909.514131-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091756-glare-cyclic-9298@gregkh>
References: <2025091756-glare-cyclic-9298@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit 3f970bd06c5295e742ef4f9cf7808a3cb74a6816 ]

Add macro to streamline and standardize the iteration over ring
segment list.

xhci_for_each_ring_seg(): Iterates over the entire ring segment list.

The xhci_free_segments_for_ring() function's while loop has not been
updated to use the new macro. This function has some underlying issues,
and as a result, it will be handled separately in a future patch.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241106101459.775897-11-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer ring after several reconnects")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-debugfs.c |  5 +----
 drivers/usb/host/xhci-mem.c     | 24 +++++++-----------------
 drivers/usb/host/xhci.c         | 20 ++++++++------------
 drivers/usb/host/xhci.h         |  3 +++
 4 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index f8ba15e7c225c..570210e8a8e87 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -214,14 +214,11 @@ static void xhci_ring_dump_segment(struct seq_file *s,
 
 static int xhci_ring_trb_show(struct seq_file *s, void *unused)
 {
-	int			i;
 	struct xhci_ring	*ring = *(struct xhci_ring **)s->private;
 	struct xhci_segment	*seg = ring->first_seg;
 
-	for (i = 0; i < ring->num_segs; i++) {
+	xhci_for_each_ring_seg(ring->first_seg, seg)
 		xhci_ring_dump_segment(s, seg);
-		seg = seg->next;
-	}
 
 	return 0;
 }
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 69188afa52666..80b2f946b59fe 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -224,7 +224,6 @@ static int xhci_update_stream_segment_mapping(
 		struct radix_tree_root *trb_address_map,
 		struct xhci_ring *ring,
 		struct xhci_segment *first_seg,
-		struct xhci_segment *last_seg,
 		gfp_t mem_flags)
 {
 	struct xhci_segment *seg;
@@ -234,28 +233,22 @@ static int xhci_update_stream_segment_mapping(
 	if (WARN_ON_ONCE(trb_address_map == NULL))
 		return 0;
 
-	seg = first_seg;
-	do {
+	xhci_for_each_ring_seg(first_seg, seg) {
 		ret = xhci_insert_segment_mapping(trb_address_map,
 				ring, seg, mem_flags);
 		if (ret)
 			goto remove_streams;
-		if (seg == last_seg)
-			return 0;
-		seg = seg->next;
-	} while (seg != first_seg);
+	}
 
 	return 0;
 
 remove_streams:
 	failed_seg = seg;
-	seg = first_seg;
-	do {
+	xhci_for_each_ring_seg(first_seg, seg) {
 		xhci_remove_segment_mapping(trb_address_map, seg);
 		if (seg == failed_seg)
 			return ret;
-		seg = seg->next;
-	} while (seg != first_seg);
+	}
 
 	return ret;
 }
@@ -267,17 +260,14 @@ static void xhci_remove_stream_mapping(struct xhci_ring *ring)
 	if (WARN_ON_ONCE(ring->trb_address_map == NULL))
 		return;
 
-	seg = ring->first_seg;
-	do {
+	xhci_for_each_ring_seg(ring->first_seg, seg)
 		xhci_remove_segment_mapping(ring->trb_address_map, seg);
-		seg = seg->next;
-	} while (seg != ring->first_seg);
 }
 
 static int xhci_update_stream_mapping(struct xhci_ring *ring, gfp_t mem_flags)
 {
 	return xhci_update_stream_segment_mapping(ring->trb_address_map, ring,
-			ring->first_seg, ring->last_seg, mem_flags);
+			ring->first_seg, mem_flags);
 }
 
 /* XXX: Do we need the hcd structure in all these functions? */
@@ -438,7 +428,7 @@ int xhci_ring_expansion(struct xhci_hcd *xhci, struct xhci_ring *ring,
 
 	if (ring->type == TYPE_STREAM) {
 		ret = xhci_update_stream_segment_mapping(ring->trb_address_map,
-						ring, first, last, flags);
+						ring, first, flags);
 		if (ret)
 			goto free_segments;
 	}
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index d5bcd5475b72b..abbf89e82d01a 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -41,15 +41,15 @@ MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
 static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 {
-	struct xhci_segment *seg = ring->first_seg;
+	struct xhci_segment *seg;
 
 	if (!td || !td->start_seg)
 		return false;
-	do {
+
+	xhci_for_each_ring_seg(ring->first_seg, seg) {
 		if (seg == td->start_seg)
 			return true;
-		seg = seg->next;
-	} while (seg && seg != ring->first_seg);
+	}
 
 	return false;
 }
@@ -764,14 +764,10 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
 	struct xhci_segment *seg;
 
 	ring = xhci->cmd_ring;
-	seg = ring->deq_seg;
-	do {
-		memset(seg->trbs, 0,
-			sizeof(union xhci_trb) * (TRBS_PER_SEGMENT - 1));
-		seg->trbs[TRBS_PER_SEGMENT - 1].link.control &=
-			cpu_to_le32(~TRB_CYCLE);
-		seg = seg->next;
-	} while (seg != ring->deq_seg);
+	xhci_for_each_ring_seg(ring->deq_seg, seg) {
+		memset(seg->trbs, 0, sizeof(union xhci_trb) * (TRBS_PER_SEGMENT - 1));
+		seg->trbs[TRBS_PER_SEGMENT - 1].link.control &= cpu_to_le32(~TRB_CYCLE);
+	}
 
 	xhci_initialize_ring_info(ring, 1);
 	/*
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 67ee2e0499433..b4fa8e7e43763 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1263,6 +1263,9 @@ static inline const char *xhci_trb_type_string(u8 type)
 #define AVOID_BEI_INTERVAL_MIN	8
 #define AVOID_BEI_INTERVAL_MAX	32
 
+#define xhci_for_each_ring_seg(head, seg) \
+	for (seg = head; seg != NULL; seg = (seg->next != head ? seg->next : NULL))
+
 struct xhci_segment {
 	union xhci_trb		*trbs;
 	/* private to HCD */
-- 
2.51.0


