Return-Path: <stable+bounces-179894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D6BB7E12D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243871B21EF2
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ABA31A804;
	Wed, 17 Sep 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLzfBMNx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824631A802
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112740; cv=none; b=XpLu2SM0MSrK0I8B4laoGi342LLCUcrZEPkdf+5damR0VaAhUhgeofsfn9LPR1d6w0uMCxp1fkCDqi44udkmTLqq1Ex7lTRE4oPEUGvtsheKvovHTQ7HuoqXvuU26mkpa3ceFMSZjnoM+GcNyIiQMa3Ufaz91pe9E1NYmpzz6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112740; c=relaxed/simple;
	bh=15drNj+goIo4RFeUw58yLKinIXzzWTKeMqkN63xNKyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJSTIVyxavK9hTtJ0yhzsCeZAj7wfdiErio5KvI8GHILmUvyvLTDVO+Mjm0RY4cCjVeNwowR0OApUPKtYPEKXxjcqkP0ygmSknzO9ngxJO9AMROliVuCiwxxyW5hbqUgctG6QvuxB/DM+fL15+dhhRGot9AvZUgm9oXpXa8qkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLzfBMNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F66C4CEF5;
	Wed, 17 Sep 2025 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758112740;
	bh=15drNj+goIo4RFeUw58yLKinIXzzWTKeMqkN63xNKyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLzfBMNxibELOnSSOrw0sekQBRZl943UxHq9h8N1XORpEm8i+3yXUPBzrBbtYlz+v
	 U2FaC+7XhpaDrjzl5aTtNMLjRHRKtVXduAhpbyKuaXtM3yXjRV6zheRSU7gCrYvDWG
	 Yz16Eh90T+QCBgn9CvTZOnX676RFe67Jh9a53+47WVLDRB2QvtKLjzV2yYNOfW5yxF
	 qvMK+/TrBM0LIFNi5oBEPo7wHlrjSOUMTHMyMRcloOvJE1kessLViY9ZF+Rr6wSOXG
	 rcp1m2oPQHV3BW4zKTWSNwMU2RIviWyOUSEiZpJ5EyM6FT0ZytkttUm+MJQpTVZ1BL
	 KANi6vVaNDjsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] usb: xhci: introduce macro for ring segment list iteration
Date: Wed, 17 Sep 2025 08:38:56 -0400
Message-ID: <20250917123858.513814-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091707-blip-kilometer-4c4c@gregkh>
References: <2025091707-blip-kilometer-4c4c@gregkh>
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
Stable-dep-of: 220a0ffde02f ("xhci: dbc: decouple endpoint allocation from initialization")
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


