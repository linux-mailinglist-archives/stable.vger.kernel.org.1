Return-Path: <stable+bounces-195303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A87C753DB
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C64CA3069D
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAD5338927;
	Thu, 20 Nov 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOJvxxNa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3732C8B
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654156; cv=none; b=QaANvmmo29sIZYYvd/OB/H3fh1R43EI0Qx25HkVWLxKYr1DFiR7EstcxnJSGTXqH7/PgEpScU1K/rjBVl5Epqykv8tTJrYJFVrllloRX0qTAM+HBEcRS4pzjiaqlQC9PjFJbgRXyPXUEFlUcnID9dWVpNQsdfY32TlgllcNJSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654156; c=relaxed/simple;
	bh=f9ZTI9+oOffDGAEwPVcux6HTyJOfFaLw7mNTsx3syBU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G0vCPYjINoWmAMvOG2iCj+YKr81e788Rw+4nETrSK4afRFQDbf4bHZ+T7M5+JfS9xeUOfSlr7hVFzS/+8j48mIaR0SdvmJX8mtKqvxk6aSK7J5IidYZp2EqfuZzx1gALXos1REwJUQjrCY2BfRLHB1FJKZkhMXE7snw8TGJ1HEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOJvxxNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B52C4CEF1;
	Thu, 20 Nov 2025 15:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763654156;
	bh=f9ZTI9+oOffDGAEwPVcux6HTyJOfFaLw7mNTsx3syBU=;
	h=Subject:To:Cc:From:Date:From;
	b=WOJvxxNag7Cy1ZMSpwNzdT9oVtbHjK9LmGuwSJfOAJjDK7qBSHwv2UP1a0590W+vi
	 cMNn4JfEyutMkxFbLsiNCaveVfaRfJkp4QtrxqNgxa//IlIKmVtVdmhYfmHe3OWRII
	 qrQ4YNNydX0O2GF+sh4gHGHtEMu2OBAazfFp0af8=
Subject: FAILED: patch "[PATCH] maple_tree: fix tracepoint string pointers" failed to apply to 6.12-stable tree
To: martin@kaiser.cx,Liam.Howlett@oracle.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:55:53 +0100
Message-ID: <2025112053-undefined-canning-8643@gregkh>
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
git cherry-pick -x 91a54090026f84ceffaa12ac53c99b9f162946f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112053-undefined-canning-8643@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91a54090026f84ceffaa12ac53c99b9f162946f6 Mon Sep 17 00:00:00 2001
From: Martin Kaiser <martin@kaiser.cx>
Date: Thu, 30 Oct 2025 16:55:05 +0100
Subject: [PATCH] maple_tree: fix tracepoint string pointers

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

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 39bb779cb311..5aa4c9500018 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -64,6 +64,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/maple_tree.h>
 
+#define TP_FCT tracepoint_string(__func__)
+
 /*
  * Kernel pointer hashing renders much of the maple tree dump useless as tagged
  * pointers get hashed to arbitrary values.
@@ -2756,7 +2758,7 @@ static inline void mas_rebalance(struct ma_state *mas,
 	MA_STATE(l_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(r_mas, mas->tree, mas->index, mas->last);
 
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 
 	/*
 	 * Rebalancing occurs if a node is insufficient.  Data is rebalanced
@@ -2997,7 +2999,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	MA_STATE(prev_l_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(prev_r_mas, mas->tree, mas->index, mas->last);
 
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 
 	mast.l = &l_mas;
 	mast.r = &r_mas;
@@ -3172,7 +3174,7 @@ static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
 			return false;
 	}
 
-	trace_ma_write(__func__, wr_mas->mas, wr_mas->r_max, entry);
+	trace_ma_write(TP_FCT, wr_mas->mas, wr_mas->r_max, entry);
 	return true;
 }
 
@@ -3416,7 +3418,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	 * of data may happen.
 	 */
 	mas = wr_mas->mas;
-	trace_ma_op(__func__, mas);
+	trace_ma_op(TP_FCT, mas);
 
 	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		return mas_new_root(mas, wr_mas->entry);
@@ -3552,7 +3554,7 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
 	} else {
 		memcpy(wr_mas->node, newnode, sizeof(struct maple_node));
 	}
-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, 0, wr_mas->entry);
 	mas_update_gap(mas);
 	mas->end = new_end;
 	return;
@@ -3596,7 +3598,7 @@ static inline void mas_wr_slot_store(struct ma_wr_state *wr_mas)
 		mas->offset++; /* Keep mas accurate. */
 	}
 
-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, 0, wr_mas->entry);
 	/*
 	 * Only update gap when the new entry is empty or there is an empty
 	 * entry in the original two ranges.
@@ -3717,7 +3719,7 @@ static inline void mas_wr_append(struct ma_wr_state *wr_mas,
 		mas_update_gap(mas);
 
 	mas->end = new_end;
-	trace_ma_write(__func__, mas, new_end, wr_mas->entry);
+	trace_ma_write(TP_FCT, mas, new_end, wr_mas->entry);
 	return;
 }
 
@@ -3731,7 +3733,7 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 {
 	struct maple_big_node b_node;
 
-	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
+	trace_ma_write(TP_FCT, wr_mas->mas, 0, wr_mas->entry);
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
 	mas_commit_b_node(wr_mas, &b_node);
@@ -5062,7 +5064,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	trace_ma_write(__func__, mas, 0, entry);
+	trace_ma_write(TP_FCT, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 	if (MAS_WARN_ON(mas, mas->index > mas->last))
 		pr_err("Error %lX > %lX " PTR_FMT "\n", mas->index, mas->last,
@@ -5163,7 +5165,7 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 	}
 
 store:
-	trace_ma_write(__func__, mas, 0, entry);
+	trace_ma_write(TP_FCT, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
 	mas_destroy(mas);
@@ -5882,7 +5884,7 @@ void *mtree_load(struct maple_tree *mt, unsigned long index)
 	MA_STATE(mas, mt, index, index);
 	void *entry;
 
-	trace_ma_read(__func__, &mas);
+	trace_ma_read(TP_FCT, &mas);
 	rcu_read_lock();
 retry:
 	entry = mas_start(&mas);
@@ -5925,7 +5927,7 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 	MA_STATE(mas, mt, index, last);
 	int ret = 0;
 
-	trace_ma_write(__func__, &mas, 0, entry);
+	trace_ma_write(TP_FCT, &mas, 0, entry);
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return -EINVAL;
 
@@ -6148,7 +6150,7 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
 	void *entry = NULL;
 
 	MA_STATE(mas, mt, index, index);
-	trace_ma_op(__func__, &mas);
+	trace_ma_op(TP_FCT, &mas);
 
 	mtree_lock(mt);
 	entry = mas_erase(&mas);
@@ -6485,7 +6487,7 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	unsigned long copy = *index;
 #endif
 
-	trace_ma_read(__func__, &mas);
+	trace_ma_read(TP_FCT, &mas);
 
 	if ((*index) > max)
 		return NULL;


