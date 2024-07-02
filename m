Return-Path: <stable+bounces-56559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC29244F0
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED1C1F2155D
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04B1BE85B;
	Tue,  2 Jul 2024 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPUKe8uT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0291BE223;
	Tue,  2 Jul 2024 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940587; cv=none; b=OVJuBf1Rg6FDg7xXvZDieTgKbqZ9icOzlz0n+7GtszqP9AzLY6vCZ1U9UAc4h6Hl3mRoKoVreC2l8OnLubJSqBcxUmWT4Z1eXU34Cg1NWt1RoyRn407Dhj07rl1rBUbPcfnO94d9WTIGHDoaeulhhIXJExvmasla17FlZWRXUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940587; c=relaxed/simple;
	bh=qrKrshO4c3GgVVppMV2SRAMS+AlbNNyPV7tYkGz8tdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6JCNBuQ/Dx6j6fd5gJJyG2fuKohWpyAy33hAh7vYESx/BKQtMCGZp9EWo+PU2G7EkreoeqEwDexFZ6pVXiF5y6drbD/+MBGhAhVfqpdaXMfhAORwBSrPiWI2JwNB4n2tGJBtfhAJfBa/DPSWruX+Ild57f78W5U99PYkkKpv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPUKe8uT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBF3C116B1;
	Tue,  2 Jul 2024 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940587;
	bh=qrKrshO4c3GgVVppMV2SRAMS+AlbNNyPV7tYkGz8tdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPUKe8uTMK1EDmFN2gbzfMFwAMJRi84m+D/9Gm+e3magA79rL42XmtFXPjz2SbFTB
	 BBpxWw71ML3ySStHyfUPNbu1kRJW8RStaKONCJdIzwhp/PWH5RJOCVuUiyER9j66Px
	 AYg+EciskJACE7dhtkCKwPHl67lp+7ls8LDchtBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 6.9 200/222] bcachefs: btree_gc can now handle unknown btrees
Date: Tue,  2 Jul 2024 19:03:58 +0200
Message-ID: <20240702170251.629218295@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kent Overstreet <kent.overstreet@linux.dev>

commit 088d0de81220a74d7d553febb81656927f10bb16 upstream.

Compatibility fix - we no longer have a separate table for which order
gc walks btrees in, and special case the stripes btree directly.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/bcachefs/bcachefs.h       |   44 ---------------------------------------
 fs/bcachefs/btree_gc.c       |   15 ++++++-------
 fs/bcachefs/btree_gc.h       |   48 +++++++++++++++++++------------------------
 fs/bcachefs/btree_gc_types.h |   29 +++++++++++++++++++++++++
 fs/bcachefs/ec.c             |    2 -
 5 files changed, 60 insertions(+), 78 deletions(-)
 create mode 100644 fs/bcachefs/btree_gc_types.h

--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -455,6 +455,7 @@ enum bch_time_stats {
 };
 
 #include "alloc_types.h"
+#include "btree_gc_types.h"
 #include "btree_types.h"
 #include "btree_node_scan_types.h"
 #include "btree_write_buffer_types.h"
@@ -485,49 +486,6 @@ enum bch_time_stats {
 
 struct btree;
 
-enum gc_phase {
-	GC_PHASE_NOT_RUNNING,
-	GC_PHASE_START,
-	GC_PHASE_SB,
-
-	GC_PHASE_BTREE_stripes,
-	GC_PHASE_BTREE_extents,
-	GC_PHASE_BTREE_inodes,
-	GC_PHASE_BTREE_dirents,
-	GC_PHASE_BTREE_xattrs,
-	GC_PHASE_BTREE_alloc,
-	GC_PHASE_BTREE_quotas,
-	GC_PHASE_BTREE_reflink,
-	GC_PHASE_BTREE_subvolumes,
-	GC_PHASE_BTREE_snapshots,
-	GC_PHASE_BTREE_lru,
-	GC_PHASE_BTREE_freespace,
-	GC_PHASE_BTREE_need_discard,
-	GC_PHASE_BTREE_backpointers,
-	GC_PHASE_BTREE_bucket_gens,
-	GC_PHASE_BTREE_snapshot_trees,
-	GC_PHASE_BTREE_deleted_inodes,
-	GC_PHASE_BTREE_logged_ops,
-	GC_PHASE_BTREE_rebalance_work,
-	GC_PHASE_BTREE_subvolume_children,
-
-	GC_PHASE_PENDING_DELETE,
-};
-
-struct gc_pos {
-	enum gc_phase		phase;
-	struct bpos		pos;
-	unsigned		level;
-};
-
-struct reflink_gc {
-	u64		offset;
-	u32		size;
-	u32		refcount;
-};
-
-typedef GENRADIX(struct reflink_gc) reflink_gc_table;
-
 struct io_count {
 	u64			sectors[2][BCH_DATA_NR];
 };
--- a/fs/bcachefs/btree_gc.c
+++ b/fs/bcachefs/btree_gc.c
@@ -1080,8 +1080,7 @@ fsck_err:
 
 static inline int btree_id_gc_phase_cmp(enum btree_id l, enum btree_id r)
 {
-	return  (int) btree_id_to_gc_phase(l) -
-		(int) btree_id_to_gc_phase(r);
+	return cmp_int(gc_btree_order(l), gc_btree_order(r));
 }
 
 static int bch2_gc_btrees(struct bch_fs *c, bool initial, bool metadata_only)
@@ -1126,7 +1125,7 @@ static void mark_metadata_sectors(struct
 			min_t(u64, bucket_to_sector(ca, b + 1), end) - start;
 
 		bch2_mark_metadata_bucket(c, ca, b, type, sectors,
-					  gc_phase(GC_PHASE_SB), flags);
+					  gc_phase(GC_PHASE_sb), flags);
 		b++;
 		start += sectors;
 	} while (start < end);
@@ -1155,14 +1154,14 @@ static void bch2_mark_dev_superblock(str
 		b = ca->journal.buckets[i];
 		bch2_mark_metadata_bucket(c, ca, b, BCH_DATA_journal,
 					  ca->mi.bucket_size,
-					  gc_phase(GC_PHASE_SB), flags);
+					  gc_phase(GC_PHASE_sb), flags);
 	}
 }
 
 static void bch2_mark_superblocks(struct bch_fs *c)
 {
 	mutex_lock(&c->sb_lock);
-	gc_pos_set(c, gc_phase(GC_PHASE_SB));
+	gc_pos_set(c, gc_phase(GC_PHASE_sb));
 
 	for_each_online_member(c, ca)
 		bch2_mark_dev_superblock(c, ca, BTREE_TRIGGER_GC);
@@ -1773,7 +1772,7 @@ int bch2_gc(struct bch_fs *c, bool initi
 	if (ret)
 		goto out;
 again:
-	gc_pos_set(c, gc_phase(GC_PHASE_START));
+	gc_pos_set(c, gc_phase(GC_PHASE_start));
 
 	bch2_mark_superblocks(c);
 
@@ -1800,7 +1799,7 @@ again:
 		 */
 		bch_info(c, "Second GC pass needed, restarting:");
 		clear_bit(BCH_FS_need_another_gc, &c->flags);
-		__gc_pos_set(c, gc_phase(GC_PHASE_NOT_RUNNING));
+		__gc_pos_set(c, gc_phase(GC_PHASE_not_running));
 
 		bch2_gc_stripes_reset(c, metadata_only);
 		bch2_gc_alloc_reset(c, metadata_only);
@@ -1827,7 +1826,7 @@ out:
 
 	percpu_down_write(&c->mark_lock);
 	/* Indicates that gc is no longer in progress: */
-	__gc_pos_set(c, gc_phase(GC_PHASE_NOT_RUNNING));
+	__gc_pos_set(c, gc_phase(GC_PHASE_not_running));
 
 	bch2_gc_free(c);
 	percpu_up_write(&c->mark_lock);
--- a/fs/bcachefs/btree_gc.h
+++ b/fs/bcachefs/btree_gc.h
@@ -3,6 +3,7 @@
 #define _BCACHEFS_BTREE_GC_H
 
 #include "bkey.h"
+#include "btree_gc_types.h"
 #include "btree_types.h"
 
 int bch2_check_topology(struct bch_fs *);
@@ -35,38 +36,17 @@ int bch2_gc_thread_start(struct bch_fs *
 /* Position of (the start of) a gc phase: */
 static inline struct gc_pos gc_phase(enum gc_phase phase)
 {
-	return (struct gc_pos) {
-		.phase	= phase,
-		.pos	= POS_MIN,
-		.level	= 0,
-	};
-}
-
-static inline int gc_pos_cmp(struct gc_pos l, struct gc_pos r)
-{
-	return  cmp_int(l.phase, r.phase) ?:
-		bpos_cmp(l.pos, r.pos) ?:
-		cmp_int(l.level, r.level);
-}
-
-static inline enum gc_phase btree_id_to_gc_phase(enum btree_id id)
-{
-	switch (id) {
-#define x(name, v, ...) case BTREE_ID_##name: return GC_PHASE_BTREE_##name;
-	BCH_BTREE_IDS()
-#undef x
-	default:
-		BUG();
-	}
+	return (struct gc_pos) { .phase	= phase, };
 }
 
-static inline struct gc_pos gc_pos_btree(enum btree_id id,
+static inline struct gc_pos gc_pos_btree(enum btree_id btree,
 					 struct bpos pos, unsigned level)
 {
 	return (struct gc_pos) {
-		.phase	= btree_id_to_gc_phase(id),
-		.pos	= pos,
+		.phase	= GC_PHASE_btree,
+		.btree	= btree,
 		.level	= level,
+		.pos	= pos,
 	};
 }
 
@@ -91,6 +71,22 @@ static inline struct gc_pos gc_pos_btree
 	return gc_pos_btree(id, SPOS_MAX, BTREE_MAX_DEPTH);
 }
 
+static inline int gc_btree_order(enum btree_id btree)
+{
+	if (btree == BTREE_ID_stripes)
+		return -1;
+	return btree;
+}
+
+static inline int gc_pos_cmp(struct gc_pos l, struct gc_pos r)
+{
+	return   cmp_int(l.phase, r.phase) ?:
+		 cmp_int(gc_btree_order(l.btree),
+			 gc_btree_order(r.btree)) ?:
+		-cmp_int(l.level, r.level) ?:
+		 bpos_cmp(l.pos, r.pos);
+}
+
 static inline bool gc_visited(struct bch_fs *c, struct gc_pos pos)
 {
 	unsigned seq;
--- /dev/null
+++ b/fs/bcachefs/btree_gc_types.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_BTREE_GC_TYPES_H
+#define _BCACHEFS_BTREE_GC_TYPES_H
+
+#include <linux/generic-radix-tree.h>
+
+enum gc_phase {
+	GC_PHASE_not_running,
+	GC_PHASE_start,
+	GC_PHASE_sb,
+	GC_PHASE_btree,
+};
+
+struct gc_pos {
+	enum gc_phase		phase:8;
+	enum btree_id		btree:8;
+	u16			level;
+	struct bpos		pos;
+};
+
+struct reflink_gc {
+	u64		offset;
+	u32		size;
+	u32		refcount;
+};
+
+typedef GENRADIX(struct reflink_gc) reflink_gc_table;
+
+#endif /* _BCACHEFS_BTREE_GC_TYPES_H */
--- a/fs/bcachefs/ec.c
+++ b/fs/bcachefs/ec.c
@@ -880,7 +880,7 @@ static int __ec_stripe_mem_alloc(struct
 	if (!genradix_ptr_alloc(&c->stripes, idx, gfp))
 		return -BCH_ERR_ENOMEM_ec_stripe_mem_alloc;
 
-	if (c->gc_pos.phase != GC_PHASE_NOT_RUNNING &&
+	if (c->gc_pos.phase != GC_PHASE_not_running &&
 	    !genradix_ptr_alloc(&c->gc_stripes, idx, gfp))
 		return -BCH_ERR_ENOMEM_ec_stripe_mem_alloc;
 



