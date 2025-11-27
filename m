Return-Path: <stable+bounces-197096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59862C8E5F4
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95DD3AECB8
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A122F74D;
	Thu, 27 Nov 2025 13:05:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0F134CF
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764248722; cv=none; b=WDcDdmBczltYbhs1anAUvzswBvjdYCL+/uG1brbqRRSZSQ394O8R3KwVA8QrDPBTFmjIxJgQR95RVNRt7is3y1AAUAHFogCEiNSKQnyCPitZtdccOTuMw2BD91Pqkv7W/8gy6sPTv7dHQa3zvFAaQRN6NeskvqGeh6t/8urJ6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764248722; c=relaxed/simple;
	bh=f23BOI1jYs+LenWOw//k2RMB1FFVW4UuDJlE55fevpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+9ySYsBlZ+fw9RMGMITYxddd9peAUUcy9LTPJjZlgyzGJ6xc1WMkTbP9bNMQqP3e73yFE80TnbCwQPB7jhSCI5YZLXM4YkxX+so4y+JQFGnozXO0dwVxiE8SMJXG2WQsSsVxXxEr8Jeul98iGn8W5RiBzFXsDPCSDV9hjntDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-210-203-096.092.210.pools.vodafone-ip.de ([92.210.203.96] helo=martin-debian-3.kaiser.cx)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1vObgT-0007LD-0i;
	Thu, 27 Nov 2025 14:05:17 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: stable@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] maple_tree: fix tracepoint string pointers
Date: Thu, 27 Nov 2025 14:05:10 +0100
Message-ID: <20251127130510.1948976-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2025112054-thieving-setback-0708@gregkh>
References: <2025112054-thieving-setback-0708@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maple_tree tracepoints contain pointers to function names. Such a pointer
is saved when a tracepoint logs an event. There's no guarantee that it's
still valid when the event is parsed later and the pointer is dereferenced.

The kernel warns about these unsafe pointers.

	event 'ma_read' has unsafe pointer field 'fn'
	WARNING: kernel/trace/trace.c:3779 at ignore_event+0x1da/0x1e4

Mark the function names as tracepoint_string() to fix the events.

One case that doesn't work without my patch would be trace-cmd record
to save the binary ringbuffer and trace-cmd report to parse it in
userspace.  The address of __func__ can't be dereferenced from
userspace but tracepoint_string will add an entry to
/sys/kernel/tracing/printk_formats

Link: https://lkml.kernel.org/r/20251030155537.87972-1-martin@kaiser.cx
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 91a54090026f84ceffaa12ac53c99b9f162946f6)
---
 lib/maple_tree.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 95fe42835f08..958a610b70ca 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -62,6 +62,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/maple_tree.h>
 
+#define TP_FCT tracepoint_string(__func__)
+
 #define MA_ROOT_PARENT 1
 
 /*
@@ -3165,7 +3167,7 @@ static inline int mas_rebalance(struct ma_state *mas,
 	MA_STATE(l_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(r_mas, mas->tree, mas->index, mas->last);
 
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 
 	/*
 	 * Rebalancing occurs if a node is insufficient.  Data is rebalanced
@@ -3542,7 +3544,7 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	MA_STATE(prev_r_mas, mas->tree, mas->index, mas->last);
 	MA_TOPIARY(mat, mas->tree);
 
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 	mas->depth = mas_mt_height(mas);
 	/* Allocation failures will happen early. */
 	mas_node_count(mas, 1 + mas->depth * 2);
@@ -3786,7 +3788,7 @@ static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
 			return false;
 	}
 
-	trace_ma_write(__func__, wr_mas->mas, piv, entry);
+	trace_ma_write(TP_FCT, wr_mas->mas, piv, entry);
 
 	return true;
 }
@@ -4035,7 +4037,7 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	 * of data may happen.
 	 */
 	mas = wr_mas->mas;
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 
 	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		return mas_new_root(mas, wr_mas->entry);
@@ -4221,7 +4223,7 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
 	} else {
 		memcpy(wr_mas->node, newnode, sizeof(struct maple_node));
 	}
-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, 0, wr_mas->entry);
 	mas_update_gap(mas);
 	return true;
 }
@@ -4276,7 +4278,7 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 	mas->offset++; /* Keep mas accurate. */
 
 done:
-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, 0, wr_mas->entry);
 	mas_update_gap(mas);
 	return true;
 }
@@ -4377,7 +4379,7 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 {
 	struct maple_big_node b_node;
 
-	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, wr_mas->mas, 0, wr_mas->entry);
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
 	mas_commit_b_node(wr_mas, &b_node, wr_mas->node_end);
@@ -5722,7 +5724,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	trace_ma_write(__func__, mas, 0, entry);
+	trace_ma_write(TP_FCT, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 	if (mas->index > mas->last)
 		pr_err("Error %lu > %lu %p\n", mas->index, mas->last, entry);
@@ -5760,7 +5762,7 @@ int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
 	MA_WR_STATE(wr_mas, mas, entry);
 
 	mas_wr_store_setup(&wr_mas);
-	trace_ma_write(__func__, mas, 0, entry);
+	trace_ma_write(TP_FCT, mas, 0, entry);
 retry:
 	mas_wr_store_entry(&wr_mas);
 	if (unlikely(mas_nomem(mas, gfp)))
@@ -5784,7 +5786,7 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 	MA_WR_STATE(wr_mas, mas, entry);
 
 	mas_wr_store_setup(&wr_mas);
-	trace_ma_write(__func__, mas, 0, entry);
+	trace_ma_write(TP_FCT, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	BUG_ON(mas_is_err(mas));
 	mas_destroy(mas);
@@ -6249,7 +6251,7 @@ void *mtree_load(struct maple_tree *mt, unsigned long index)
 	MA_STATE(mas, mt, index, index);
 	void *entry;
 
-	trace_ma_read(__func__, &mas);
+	trace_ma_read(TP_FCT, &mas);
 	rcu_read_lock();
 retry:
 	entry = mas_start(&mas);
@@ -6292,7 +6294,7 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 	MA_STATE(mas, mt, index, last);
 	MA_WR_STATE(wr_mas, &mas, entry);
 
-	trace_ma_write(__func__, &mas, 0, entry);
+	trace_ma_write(TP_FCT, &mas, 0, entry);
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return -EINVAL;
 
@@ -6467,7 +6469,7 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
 	void *entry = NULL;
 
 	MA_STATE(mas, mt, index, index);
-	trace_ma_op(__func__, &mas);
+	trace_ma_op(TP_FCT, &mas);
 
 	mtree_lock(mt);
 	entry = mas_erase(&mas);
@@ -6527,7 +6529,7 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	unsigned long copy = *index;
 #endif
 
-	trace_ma_read(__func__, &mas);
+	trace_ma_read(TP_FCT, &mas);
 
 	if ((*index) > max)
 		return NULL;
-- 
2.43.7


