Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18DF7B3D37
	for <lists+stable@lfdr.de>; Sat, 30 Sep 2023 02:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjI3AV0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 20:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjI3AVW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 20:21:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B2A1B1;
        Fri, 29 Sep 2023 17:21:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B86C433C9;
        Sat, 30 Sep 2023 00:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696033278;
        bh=BSUZA57osnHSNzmJFxR97q/FwRLuJjLaKY9ObMoJjEg=;
        h=Date:To:From:Subject:From;
        b=paTJW44DdKZ5/2EYMcN1HdArtLXpKGUf3D48w5cDhGLt0J8TqDBEXfbvd/6XGgilj
         c1rwZlMWLJK8m3Ma1ROB5wjlGqtVCooh46fxRy4FHZxoGR1YxVSVIiEXmvhQzrXWpR
         V2p3MI3iJf53rFIbEssVbO2Go/nqsC2N47zRuA7g=
Date:   Fri, 29 Sep 2023 17:21:17 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        pedro.falcato@gmail.com, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] maple_tree-add-mas_underflow-and-mas_overflow-states.patch removed from -mm tree
Message-Id: <20230930002118.58B86C433C9@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states
has been removed from the -mm tree.  Its filename was
     maple_tree-add-mas_underflow-and-mas_overflow-states.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states
Date: Thu, 21 Sep 2023 14:12:36 -0400

When updating the maple tree iterator to avoid rewalks, an issue was
introduced when shifting beyond the limits.  This can be seen by trying to
go to the previous address of 0, which would set the maple node to
MAS_NONE and keep the range as the last entry.

Subsequent calls to mas_find() would then search upwards from mas->last
and skip the value at mas->index/mas->last.  This showed up as a bug in
mprotect which skips the actual VMA at the current range after attempting
to go to the previous VMA from 0.

Since MAS_NONE may already be set when searching for a value that isn't
contained within a node, changing the handling of MAS_NONE in mas_find()
would make the code more complicated and error prone.  Furthermore, there
was no way to tell which limit was hit, and thus which action to take
(next or the entry at the current range).

This solution is to add two states to track what happened with the
previous iterator action.  This allows for the expected behaviour of the
next command to return the correct item (either the item at the range
requested, or the next/previous).

Tests are also added and updated accordingly.

Link: https://lkml.kernel.org/r/20230921181236.509072-3-Liam.Howlett@oracle.com
Link: https://gist.github.com/heatd/85d2971fae1501b55b6ea401fbbe485b
Link: https://lore.kernel.org/linux-mm/20230921181236.509072-1-Liam.Howlett@oracle.com/
Fixes: 39193685d585 ("maple_tree: try harder to keep active node with mas_prev()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
Closes: https://gist.github.com/heatd/85d2971fae1501b55b6ea401fbbe485b
Closes: https://bugs.archlinux.org/task/79656
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/maple_tree.h |    2 
 lib/maple_tree.c           |  221 +++++++++++++++++++++++++----------
 lib/test_maple_tree.c      |   87 +++++++++++--
 3 files changed, 237 insertions(+), 73 deletions(-)

--- a/include/linux/maple_tree.h~maple_tree-add-mas_underflow-and-mas_overflow-states
+++ a/include/linux/maple_tree.h
@@ -428,6 +428,8 @@ struct ma_wr_state {
 #define MAS_ROOT	((struct maple_enode *)5UL)
 #define MAS_NONE	((struct maple_enode *)9UL)
 #define MAS_PAUSE	((struct maple_enode *)17UL)
+#define MAS_OVERFLOW	((struct maple_enode *)33UL)
+#define MAS_UNDERFLOW	((struct maple_enode *)65UL)
 #define MA_ERROR(err) \
 		((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
 
--- a/lib/maple_tree.c~maple_tree-add-mas_underflow-and-mas_overflow-states
+++ a/lib/maple_tree.c
@@ -256,6 +256,22 @@ bool mas_is_err(struct ma_state *mas)
 	return xa_is_err(mas->node);
 }
 
+static __always_inline bool mas_is_overflow(struct ma_state *mas)
+{
+	if (unlikely(mas->node == MAS_OVERFLOW))
+		return true;
+
+	return false;
+}
+
+static __always_inline bool mas_is_underflow(struct ma_state *mas)
+{
+	if (unlikely(mas->node == MAS_UNDERFLOW))
+		return true;
+
+	return false;
+}
+
 static inline bool mas_searchable(struct ma_state *mas)
 {
 	if (mas_is_none(mas))
@@ -4415,10 +4431,13 @@ no_entry:
  *
  * @mas: The maple state
  * @max: The minimum starting range
+ * @empty: Can be empty
+ * @set_underflow: Set the @mas->node to underflow state on limit.
  *
  * Return: The entry in the previous slot which is possibly NULL
  */
-static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
+static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
+			   bool set_underflow)
 {
 	void *entry;
 	void __rcu **slots;
@@ -4435,7 +4454,6 @@ retry:
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
-again:
 	if (mas->min <= min) {
 		pivot = mas_safe_min(mas, pivots, mas->offset);
 
@@ -4443,9 +4461,10 @@ again:
 			goto retry;
 
 		if (pivot <= min)
-			return NULL;
+			goto underflow;
 	}
 
+again:
 	if (likely(mas->offset)) {
 		mas->offset--;
 		mas->last = mas->index - 1;
@@ -4457,7 +4476,7 @@ again:
 		}
 
 		if (mas_is_none(mas))
-			return NULL;
+			goto underflow;
 
 		mas->last = mas->max;
 		node = mas_mn(mas);
@@ -4474,10 +4493,19 @@ again:
 	if (likely(entry))
 		return entry;
 
-	if (!empty)
+	if (!empty) {
+		if (mas->index <= min)
+			goto underflow;
+
 		goto again;
+	}
 
 	return entry;
+
+underflow:
+	if (set_underflow)
+		mas->node = MAS_UNDERFLOW;
+	return NULL;
 }
 
 /*
@@ -4567,10 +4595,13 @@ no_entry:
  * @mas: The maple state
  * @max: The maximum starting range
  * @empty: Can be empty
+ * @set_overflow: Should @mas->node be set to overflow when the limit is
+ * reached.
  *
  * Return: The entry in the next slot which is possibly NULL
  */
-static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
+static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
+			   bool set_overflow)
 {
 	void __rcu **slots;
 	unsigned long *pivots;
@@ -4589,22 +4620,22 @@ retry:
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
-again:
 	if (mas->max >= max) {
 		if (likely(mas->offset < data_end))
 			pivot = pivots[mas->offset];
 		else
-			return NULL; /* must be mas->max */
+			goto overflow;
 
 		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 			goto retry;
 
 		if (pivot >= max)
-			return NULL;
+			goto overflow;
 	}
 
 	if (likely(mas->offset < data_end)) {
 		mas->index = pivots[mas->offset] + 1;
+again:
 		mas->offset++;
 		if (likely(mas->offset < data_end))
 			mas->last = pivots[mas->offset];
@@ -4616,8 +4647,11 @@ again:
 			goto retry;
 		}
 
-		if (mas_is_none(mas))
+		if (WARN_ON_ONCE(mas_is_none(mas))) {
+			mas->node = MAS_OVERFLOW;
 			return NULL;
+			goto overflow;
+		}
 
 		mas->offset = 0;
 		mas->index = mas->min;
@@ -4636,12 +4670,20 @@ again:
 		return entry;
 
 	if (!empty) {
-		if (!mas->offset)
-			data_end = 2;
+		if (mas->last >= max)
+			goto overflow;
+
+		mas->index = mas->last + 1;
+		/* Node cannot end on NULL, so it's safe to short-cut here */
 		goto again;
 	}
 
 	return entry;
+
+overflow:
+	if (set_overflow)
+		mas->node = MAS_OVERFLOW;
+	return NULL;
 }
 
 /*
@@ -4651,17 +4693,20 @@ again:
  *
  * Set the @mas->node to the next entry and the range_start to
  * the beginning value for the entry.  Does not check beyond @limit.
- * Sets @mas->index and @mas->last to the limit if it is hit.
+ * Sets @mas->index and @mas->last to the range, Does not update @mas->index and
+ * @mas->last on overflow.
  * Restarts on dead nodes.
  *
  * Return: the next entry or %NULL.
  */
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
-	if (mas->last >= limit)
+	if (mas->last >= limit) {
+		mas->node = MAS_OVERFLOW;
 		return NULL;
+	}
 
-	return mas_next_slot(mas, limit, false);
+	return mas_next_slot(mas, limit, false, true);
 }
 
 /*
@@ -4837,7 +4882,7 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
-	if (mas_is_none(mas) || mas_is_paused(mas) || mas_is_ptr(mas))
+	if (!mas_is_active(mas) || !mas_is_start(mas))
 		mas->node = MAS_START;
 retry:
 	entry = mas_state_walk(mas);
@@ -5294,14 +5339,22 @@ static inline void mte_destroy_walk(stru
 
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 {
-	if (mas_is_start(wr_mas->mas))
-		return;
+	if (!mas_is_active(wr_mas->mas)) {
+		if (mas_is_start(wr_mas->mas))
+			return;
 
-	if (unlikely(mas_is_paused(wr_mas->mas)))
-		goto reset;
+		if (unlikely(mas_is_paused(wr_mas->mas)))
+			goto reset;
 
-	if (unlikely(mas_is_none(wr_mas->mas)))
-		goto reset;
+		if (unlikely(mas_is_none(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_overflow(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_underflow(wr_mas->mas)))
+			goto reset;
+	}
 
 	/*
 	 * A less strict version of mas_is_span_wr() where we allow spanning
@@ -5595,8 +5648,25 @@ static inline bool mas_next_setup(struct
 {
 	bool was_none = mas_is_none(mas);
 
-	if (mas_is_none(mas) || mas_is_paused(mas))
+	if (unlikely(mas->last >= max)) {
+		mas->node = MAS_OVERFLOW;
+		return true;
+	}
+
+	if (mas_is_active(mas))
+		return false;
+
+	if (mas_is_none(mas) || mas_is_paused(mas)) {
+		mas->node = MAS_START;
+	} else if (mas_is_overflow(mas)) {
+		/* Overflowed before, but the max changed */
 		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas)) {
+		mas->node = MAS_START;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+	}
 
 	if (mas_is_start(mas))
 		*entry = mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
@@ -5615,6 +5685,7 @@ static inline bool mas_next_setup(struct
 
 	if (mas_is_none(mas))
 		return true;
+
 	return false;
 }
 
@@ -5637,7 +5708,7 @@ void *mas_next(struct ma_state *mas, uns
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false);
+	return mas_next_slot(mas, max, false, true);
 }
 EXPORT_SYMBOL_GPL(mas_next);
 
@@ -5660,7 +5731,7 @@ void *mas_next_range(struct ma_state *ma
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true);
+	return mas_next_slot(mas, max, true, true);
 }
 EXPORT_SYMBOL_GPL(mas_next_range);
 
@@ -5691,18 +5762,31 @@ EXPORT_SYMBOL_GPL(mt_next);
 static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
-	if (mas->index <= min)
-		goto none;
+	if (unlikely(mas->index <= min)) {
+		mas->node = MAS_UNDERFLOW;
+		return true;
+	}
 
-	if (mas_is_none(mas) || mas_is_paused(mas))
+	if (mas_is_active(mas))
+		return false;
+
+	if (mas_is_overflow(mas)) {
 		mas->node = MAS_START;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+	}
 
-	if (mas_is_start(mas)) {
-		mas_walk(mas);
-		if (!mas->index)
-			goto none;
+	if (mas_is_none(mas) || mas_is_paused(mas)) {
+		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas)) {
+		/* underflowed before but the min changed */
+		mas->node = MAS_START;
 	}
 
+	if (mas_is_start(mas))
+		mas_walk(mas);
+
 	if (unlikely(mas_is_ptr(mas))) {
 		if (!mas->index)
 			goto none;
@@ -5747,7 +5831,7 @@ void *mas_prev(struct ma_state *mas, uns
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, false);
+	return mas_prev_slot(mas, min, false, true);
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
@@ -5770,7 +5854,7 @@ void *mas_prev_range(struct ma_state *ma
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, true);
+	return mas_prev_slot(mas, min, true, true);
 }
 EXPORT_SYMBOL_GPL(mas_prev_range);
 
@@ -5828,24 +5912,35 @@ EXPORT_SYMBOL_GPL(mas_pause);
 static inline bool mas_find_setup(struct ma_state *mas, unsigned long max,
 		void **entry)
 {
-	*entry = NULL;
+	if (mas_is_active(mas)) {
+		if (mas->last < max)
+			return false;
+
+		return true;
+	}
 
-	if (unlikely(mas_is_none(mas))) {
+	if (mas_is_paused(mas)) {
 		if (unlikely(mas->last >= max))
 			return true;
 
-		mas->index = mas->last;
+		mas->index = ++mas->last;
 		mas->node = MAS_START;
-	} else if (unlikely(mas_is_paused(mas))) {
+	} else if (mas_is_none(mas)) {
 		if (unlikely(mas->last >= max))
 			return true;
 
+		mas->index = mas->last;
 		mas->node = MAS_START;
-		mas->index = ++mas->last;
-	} else if (unlikely(mas_is_ptr(mas)))
-		goto ptr_out_of_range;
+	} else if (mas_is_overflow(mas) || mas_is_underflow(mas)) {
+		if (mas->index > max) {
+			mas->node = MAS_OVERFLOW;
+			return true;
+		}
 
-	if (unlikely(mas_is_start(mas))) {
+		mas->node = MAS_START;
+	}
+
+	if (mas_is_start(mas)) {
 		/* First run or continue */
 		if (mas->index > max)
 			return true;
@@ -5895,7 +5990,7 @@ void *mas_find(struct ma_state *mas, uns
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false);
+	return mas_next_slot(mas, max, false, false);
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
@@ -5913,13 +6008,13 @@ EXPORT_SYMBOL_GPL(mas_find);
  */
 void *mas_find_range(struct ma_state *mas, unsigned long max)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_setup(mas, max, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true);
+	return mas_next_slot(mas, max, true, false);
 }
 EXPORT_SYMBOL_GPL(mas_find_range);
 
@@ -5934,26 +6029,36 @@ EXPORT_SYMBOL_GPL(mas_find_range);
 static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
-	*entry = NULL;
-
-	if (unlikely(mas_is_none(mas))) {
-		if (mas->index <= min)
-			goto none;
+	if (mas_is_active(mas)) {
+		if (mas->index > min)
+			return false;
 
-		mas->last = mas->index;
-		mas->node = MAS_START;
+		return true;
 	}
 
-	if (unlikely(mas_is_paused(mas))) {
+	if (mas_is_paused(mas)) {
 		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
 			return true;
 		}
 		mas->node = MAS_START;
 		mas->last = --mas->index;
+	} else if (mas_is_none(mas)) {
+		if (mas->index <= min)
+			goto none;
+
+		mas->last = mas->index;
+		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas) || mas_is_overflow(mas)) {
+		if (mas->last <= min) {
+			mas->node = MAS_UNDERFLOW;
+			return true;
+		}
+
+		mas->node = MAS_START;
 	}
 
-	if (unlikely(mas_is_start(mas))) {
+	if (mas_is_start(mas)) {
 		/* First run or continue */
 		if (mas->index < min)
 			return true;
@@ -6004,13 +6109,13 @@ none:
  */
 void *mas_find_rev(struct ma_state *mas, unsigned long min)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_rev_setup(mas, min, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, false);
+	return mas_prev_slot(mas, min, false, false);
 
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
@@ -6030,13 +6135,13 @@ EXPORT_SYMBOL_GPL(mas_find_rev);
  */
 void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_rev_setup(mas, min, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, true);
+	return mas_prev_slot(mas, min, true, false);
 }
 EXPORT_SYMBOL_GPL(mas_find_range_rev);
 
--- a/lib/test_maple_tree.c~maple_tree-add-mas_underflow-and-mas_overflow-states
+++ a/lib/test_maple_tree.c
@@ -2166,7 +2166,7 @@ static noinline void __init next_prev_te
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 5);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
 
 	mas.index = 0;
 	mas.last = 5;
@@ -2917,6 +2917,7 @@ static noinline void __init check_empty_
  *		exists	MAS_NONE	active		range
  *		exists	active		active		range
  *		DNE	active		active		set to last range
+ *		ERANGE	active		MAS_OVERFLOW	last range
  *
  * Function	ENTRY	Start		Result		index & last
  * mas_prev()
@@ -2945,6 +2946,7 @@ static noinline void __init check_empty_
  *		any	MAS_ROOT	MAS_NONE	0
  *		exists	active		active		range
  *		DNE	active		active		last range
+ *		ERANGE	active		MAS_UNDERFLOW	last range
  *
  * Function	ENTRY	Start		Result		index & last
  * mas_find()
@@ -2955,7 +2957,7 @@ static noinline void __init check_empty_
  *		DNE	MAS_START	MAS_NONE	0
  *		DNE	MAS_PAUSE	MAS_NONE	0
  *		DNE	MAS_ROOT	MAS_NONE	0
- *		DNE	MAS_NONE	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	1
  *				if index ==  0
  *		exists	MAS_START	MAS_ROOT	0
  *		exists	MAS_PAUSE	MAS_ROOT	0
@@ -2967,7 +2969,7 @@ static noinline void __init check_empty_
  *		DNE	MAS_START	active		set to max
  *		exists	MAS_PAUSE	active		range
  *		DNE	MAS_PAUSE	active		set to max
- *		exists	MAS_NONE	active		range
+ *		exists	MAS_NONE	active		range (start at last)
  *		exists	active		active		range
  *		DNE	active		active		last range (max < last)
  *
@@ -2992,7 +2994,7 @@ static noinline void __init check_empty_
  *		DNE	MAS_START	active		set to min
  *		exists	MAS_PAUSE	active		range
  *		DNE	MAS_PAUSE	active		set to min
- *		exists	MAS_NONE	active		range
+ *		exists	MAS_NONE	active		range (start at index)
  *		exists	active		active		range
  *		DNE	active		active		last range (min > index)
  *
@@ -3039,10 +3041,10 @@ static noinline void __init check_state_
 	mtree_store_range(mt, 0, 0, ptr, GFP_KERNEL);
 
 	mas_lock(&mas);
-	/* prev: Start -> none */
+	/* prev: Start -> underflow*/
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
 
 	/* prev: Start -> root */
 	mas_set(&mas, 10);
@@ -3069,7 +3071,7 @@ static noinline void __init check_state_
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.node != MAS_NONE);
 
-	/* next: start -> none */
+	/* next: start -> none*/
 	mas_set(&mas, 10);
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, mas.index != 1);
@@ -3268,25 +3270,46 @@ static noinline void __init check_state_
 	MT_BUG_ON(mt, mas.last != 0x2500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* next:active -> active out of range*/
+	/* next:active -> active beyond data */
 	entry = mas_next(&mas, 0x2999);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x2501);
 	MT_BUG_ON(mt, mas.last != 0x2fff);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* Continue after out of range*/
+	/* Continue after last range ends after max */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* next:active -> active out of range*/
+	/* next:active -> active continued */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next:active -> overflow  */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x3501);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+
+	/* next:overflow -> overflow  */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+
+	/* prev:overflow -> active  */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr3);
+	MT_BUG_ON(mt, mas.index != 0x3000);
+	MT_BUG_ON(mt, mas.last != 0x3500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
 	/* next: none -> active, skip value at location */
@@ -3307,11 +3330,46 @@ static noinline void __init check_state_
 	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev:active -> active out of range*/
+	/* prev:active -> active spanning end range */
+	entry = mas_prev(&mas, 0x0100);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:active -> underflow */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* prev:underflow -> underflow */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* next:underflow -> active */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:first value -> underflow */
+	entry = mas_prev(&mas, 0x1000);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* find:underflow -> first value */
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
 	/* prev: pause ->active */
@@ -3325,14 +3383,14 @@ static noinline void __init check_state_
 	MT_BUG_ON(mt, mas.last != 0x2500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev:active -> active out of range*/
+	/* prev:active -> active spanning min */
 	entry = mas_prev(&mas, 0x1600);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1FFF);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev: active ->active, continue*/
+	/* prev: active ->active, continue */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
@@ -3379,7 +3437,7 @@ static noinline void __init check_state_
 	MT_BUG_ON(mt, mas.last != 0x2FFF);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* find: none ->active */
+	/* find: overflow ->active */
 	entry = mas_find(&mas, 0x5000);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
@@ -3778,7 +3836,6 @@ static int __init maple_tree_seed(void)
 	check_empty_area_fill(&tree);
 	mtree_destroy(&tree);
 
-
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_state_handling(&tree);
 	mtree_destroy(&tree);
_

Patches currently in -mm which might be from Liam.Howlett@oracle.com are

mm-mempolicy-fix-set_mempolicy_home_node-previous-vma-pointer.patch
mmap-fix-vma_iterator-in-error-path-of-vma_merge.patch
mmap-fix-error-paths-with-dup_anon_vma.patch
mmap-add-clarifying-comment-to-vma_merge-code.patch
radix-tree-test-suite-fix-allocation-calculation-in-kmem_cache_alloc_bulk.patch

