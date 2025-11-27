Return-Path: <stable+bounces-197077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5675C8D9A6
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 10:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E5D3A845B
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C993A322524;
	Thu, 27 Nov 2025 09:42:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048E253F05
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764236578; cv=none; b=fcnoZPLwWMI1T2faFasDjes8WGrdmJ/snxLJAjDfVcb0b91wkaV32o5UDqpECXngGEDHNbhlCcfRQdUHOmXSks2Q+gRIve0hu6mulZ/OwmfsKC+Qw2O2SmvUN7oAaswk+Lk//Vkbc2qCUUyA0INY2NoES1Yz4GIAWWusrh4KAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764236578; c=relaxed/simple;
	bh=7EZ24EPjZ7MqsUV1Mf5MNxZkXv9u5pbTSYLKNgD+uJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svHoIU+luWD84PHFT6w8z6Gg+cdZpqdcMJj5JJ6d7CJv5Nw8b6K1pg9IeRz8VxjTDd05PCWnoWSa6+FhiD8UX3XgjidqaX6WLya9TM1S5WnVxXTW9Jn9SV1U2MkkTV4t7eX1StlGdvTzDwi+1Y1B6az5KRm2lP3t7PmtIGBcgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-210-203-096.092.210.pools.vodafone-ip.de ([92.210.203.96] helo=martin-debian-3.kaiser.cx)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1vOYWa-0005k7-2f;
	Thu, 27 Nov 2025 10:42:52 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: stable@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] maple_tree: fix tracepoint string pointers
Date: Thu, 27 Nov 2025 10:42:37 +0100
Message-ID: <20251127094237.1844183-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2025112053-undefined-canning-8643@gregkh>
References: <2025112053-undefined-canning-8643@gregkh>
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
index 59f83ece2024..e4b68b19ae9a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -64,6 +64,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/maple_tree.h>
 
+#define TP_FCT tracepoint_string(__func__)
+
 #define MA_ROOT_PARENT 1
 
 /*
@@ -2949,7 +2951,7 @@ static inline void mas_rebalance(struct ma_state *mas,
 	MA_STATE(l_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(r_mas, mas->tree, mas->index, mas->last);
 
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 
 	/*
 	 * Rebalancing occurs if a node is insufficient.  Data is rebalanced
@@ -3314,7 +3316,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	MA_STATE(prev_l_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(prev_r_mas, mas->tree, mas->index, mas->last);
 
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 	mas->depth = mas_mt_height(mas);
 
 	mast.l = &l_mas;
@@ -3487,7 +3489,7 @@ static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
 			return false;
 	}
 
-	trace_ma_write(__func__, wr_mas->mas, wr_mas->r_max, entry);
+	trace_ma_write(TP_FCT, wr_mas->mas, wr_mas->r_max, entry);
 	return true;
 }
 
@@ -3721,7 +3723,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	 * of data may happen.
 	 */
 	mas = wr_mas->mas;
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 
 	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		return mas_new_root(mas, wr_mas->entry);
@@ -3858,7 +3860,7 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
 	} else {
 		memcpy(wr_mas->node, newnode, sizeof(struct maple_node));
 	}
-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, 0, wr_mas->entry);
 	mas_update_gap(mas);
 	mas->end = new_end;
 	return;
@@ -3903,7 +3905,7 @@ static inline void mas_wr_slot_store(struct ma_wr_state *wr_mas)
 		return;
 	}
 
-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, 0, wr_mas->entry);
 	/*
 	 * Only update gap when the new entry is empty or there is an empty
 	 * entry in the original two ranges.
@@ -4024,7 +4026,7 @@ static inline void mas_wr_append(struct ma_wr_state *wr_mas,
 		mas_update_gap(mas);
 
 	mas->end = new_end;
-	trace_ma_write(__func__, mas, new_end, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, new_end, wr_mas->entry);
 	return;
 }
 
@@ -4038,7 +4040,7 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 {
 	struct maple_big_node b_node;
 
-	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, wr_mas->mas, 0, wr_mas->entry);
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
 	mas_commit_b_node(wr_mas, &b_node);
@@ -5418,7 +5420,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 	int request;
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	trace_ma_write(__func__, mas, 0, entry);
+	trace_ma_write(TP_FCT, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 	if (MAS_WARN_ON(mas, mas->index > mas->last))
 		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
@@ -5518,7 +5520,7 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 	}
 
 store:
-	trace_ma_write(__func__, mas, 0, entry);
+	trace_ma_write(TP_FCT, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
 	mas_destroy(mas);
@@ -6320,7 +6322,7 @@ void *mtree_load(struct maple_tree *mt, unsigned long index)
 	MA_STATE(mas, mt, index, index);
 	void *entry;
 
-	trace_ma_read(__func__, &mas);
+	trace_ma_read(TP_FCT, &mas);
 	rcu_read_lock();
 retry:
 	entry = mas_start(&mas);
@@ -6363,7 +6365,7 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 	MA_STATE(mas, mt, index, last);
 	int ret = 0;
 
-	trace_ma_write(__func__, &mas, 0, entry);
+	trace_ma_write(TP_FCT, &mas, 0, entry);
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return -EINVAL;
 
@@ -6586,7 +6588,7 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
 	void *entry = NULL;
 
 	MA_STATE(mas, mt, index, index);
-	trace_ma_op(__func__, &mas);
+	trace_ma_op(TP_FCT, &mas);
 
 	mtree_lock(mt);
 	entry = mas_erase(&mas);
@@ -6924,7 +6926,7 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	unsigned long copy = *index;
 #endif
 
-	trace_ma_read(__func__, &mas);
+	trace_ma_read(TP_FCT, &mas);
 
 	if ((*index) > max)
 		return NULL;
-- 
2.43.7


