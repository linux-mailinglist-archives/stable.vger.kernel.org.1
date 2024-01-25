Return-Path: <stable+bounces-15745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D853D83B5F4
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E9D28925F
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4D388;
	Thu, 25 Jan 2024 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl+DtG4k"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912937FB
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141788; cv=none; b=SYc+O1nzNP+Df/rUuWeNgOXefPtAwLKpsCD9DmyvAlwPDMEA76e+fU6HuQGxo9nN9bAqGAI6opg80By553mCJnwgh+ZFfvUmWw7oCD7q1Ed3cFek1+Sj0xOrY8oqci0Y83RCcaJEr8bvsfPGj/4kN8sd9po3aQNsRiYmTKB5yj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141788; c=relaxed/simple;
	bh=LeuzaIZoR9ekByNGTPsUurms3DYgOC9QdKnzT6sNrGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbqc+7BM4TJdHHiz+X3MTbxGVe0+qHop7zYmXekJNxxQ31HUdmw8a1ZhpYAJjwg9mAOtCxLP8cnuWYv6EWjX3+enwqmsJh3UN0WusomYaUIdEdWI5ViNz3gdtAH6UORmWCizvmz1FvBRKYuMuNFNt1BX3oqSry4BzqFeNB48kUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl+DtG4k; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40eccccfce0so9399085e9.1
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141784; x=1706746584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CsG4NazJewx04Sbj+tGIbYfCTtsZz3JLRJ1IUIbj10=;
        b=nl+DtG4kUElsUpbH4b+MpEDf+R3EZhxFhDKRiuzB7tDI+MgmrAGYODL87LfpdAcjQF
         o/aArn58SMf7wNBR+qiau7nUzb3QsqFWxkm7TcrfyQXyW/8JLLA2E/5PTPhrQQdKAF5V
         Y6dFauvuzhVO2isXBXIqdfZbELB5Y7ulgAv8PWzBdWCzpfBSxLKwJTXfREhorpaR9Y41
         w5hq+oqC092o096puqthR8DQOO+lbpPn61J8DCusWouuELKp10Mro8aU5X/bdZEUOCln
         LtKEWXUzPSO21axAM2xp1qpNYa3cY1Ky39+4HzZpi8mmtldECOafm3rxM9HO0Ja5jLlv
         RT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141784; x=1706746584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CsG4NazJewx04Sbj+tGIbYfCTtsZz3JLRJ1IUIbj10=;
        b=adJGxvlSTHDxYwio5lKSw1U9hPzN7OmBCxKNYdqgB13TnexqC3Qu/1Lfnn3IQQcVeO
         xRlHLd/BZFkIl9skM66Mmxc6wzO36+YKJthCFTEeKDBJNOCIt2RZBlnDUZffhH1fHM0t
         SZPzJd23QPgiOPBMIn3jpE7/BBbTxnXDBJb9rfS52AYRDr4pRa/fIeBhiPaai1KFigRp
         ihlYzYv+3l3wSvxxs0S8hGgKLwO04naVzRiAFd8LyrRa5wk43588OauXFQzWEVsxMOHQ
         BkZ3Oi4y628WKSvfYD2yrGAWsKLERihDY+gZMqIeRqeQxaEv0tTcDpsRCI/L0fgKECVF
         X0Vw==
X-Gm-Message-State: AOJu0Yxd6uAJbnSszHG2p6bIT7aN+JfFGeNyZGtb/xDovE69BjHmF/1C
	A0RAkzwez00CFNVeyq1CZgxiI1K28I+4ucr4Y+SoHLTqLNTxqB2OodAMyo/G
X-Google-Smtp-Source: AGHT+IH2ApwAWDWs73wsnDwueq74qGhEEgcVWaHpH8rWPsiUojq+jcC6jVHhQyyaqvcJgGflf+hlOw==
X-Received: by 2002:a05:600c:46d4:b0:40e:52eb:2996 with SMTP id q20-20020a05600c46d400b0040e52eb2996mr14082wmo.8.1706141784148;
        Wed, 24 Jan 2024 16:16:24 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:23 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: stable@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	mykolal@fb.com,
	gregkh@linuxfoundation.org,
	mat.gienieczko@tum.de,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH 6.6.y 05/17] bpf: correct loop detection for iterators convergence
Date: Thu, 25 Jan 2024 02:15:42 +0200
Message-ID: <20240125001554.25287-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125001554.25287-1-eddyz87@gmail.com>
References: <20240125001554.25287-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 2a0992829ea3 ]

It turns out that .branches > 0 in is_state_visited() is not a
sufficient condition to identify if two verifier states form a loop
when iterators convergence is computed. This commit adds logic to
distinguish situations like below:

 (I)            initial       (II)            initial
                  |                             |
                  V                             V
     .---------> hdr                           ..
     |            |                             |
     |            V                             V
     |    .------...                    .------..
     |    |       |                     |       |
     |    V       V                     V       V
     |   ...     ...               .-> hdr     ..
     |    |       |                |    |       |
     |    V       V                |    V       V
     |   succ <- cur               |   succ <- cur
     |    |                        |    |
     |    V                        |    V
     |   ...                       |   ...
     |    |                        |    |
     '----'                        '----'

For both (I) and (II) successor 'succ' of the current state 'cur' was
previously explored and has branches count at 0. However, loop entry
'hdr' corresponding to 'succ' might be a part of current DFS path.
If that is the case 'succ' and 'cur' are members of the same loop
and have to be compared exactly.

Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Co-developed-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231024000917.12153-6-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  15 +++
 kernel/bpf/verifier.c        | 207 ++++++++++++++++++++++++++++++++++-
 2 files changed, 218 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 57d76ef9036f..33992ea42124 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -372,10 +372,25 @@ struct bpf_verifier_state {
 	struct bpf_active_lock active_lock;
 	bool speculative;
 	bool active_rcu_lock;
+	/* If this state was ever pointed-to by other state's loop_entry field
+	 * this flag would be set to true. Used to avoid freeing such states
+	 * while they are still in use.
+	 */
+	bool used_as_loop_entry;
 
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
 	u32 last_insn_idx;
+	/* If this state is a part of states loop this field points to some
+	 * parent of this state such that:
+	 * - it is also a member of the same states loop;
+	 * - DFS states traversal starting from initial state visits loop_entry
+	 *   state before this state.
+	 * Used to compute topmost loop entry for state loops.
+	 * State loops might appear because of open coded iterators logic.
+	 * See get_loop_entry() for more information.
+	 */
+	struct bpf_verifier_state *loop_entry;
 	/* jmp history recorded from first to last.
 	 * backtracking is using it to go from last to first.
 	 * For most states jmp_history_cnt is [0-3].
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 175d611d7d80..6658f6750715 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1764,6 +1764,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
 	dst_state->dfs_depth = src->dfs_depth;
+	dst_state->used_as_loop_entry = src->used_as_loop_entry;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -1806,11 +1807,176 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
 	return true;
 }
 
+/* Open coded iterators allow back-edges in the state graph in order to
+ * check unbounded loops that iterators.
+ *
+ * In is_state_visited() it is necessary to know if explored states are
+ * part of some loops in order to decide whether non-exact states
+ * comparison could be used:
+ * - non-exact states comparison establishes sub-state relation and uses
+ *   read and precision marks to do so, these marks are propagated from
+ *   children states and thus are not guaranteed to be final in a loop;
+ * - exact states comparison just checks if current and explored states
+ *   are identical (and thus form a back-edge).
+ *
+ * Paper "A New Algorithm for Identifying Loops in Decompilation"
+ * by Tao Wei, Jian Mao, Wei Zou and Yu Chen [1] presents a convenient
+ * algorithm for loop structure detection and gives an overview of
+ * relevant terminology. It also has helpful illustrations.
+ *
+ * [1] https://api.semanticscholar.org/CorpusID:15784067
+ *
+ * We use a similar algorithm but because loop nested structure is
+ * irrelevant for verifier ours is significantly simpler and resembles
+ * strongly connected components algorithm from Sedgewick's textbook.
+ *
+ * Define topmost loop entry as a first node of the loop traversed in a
+ * depth first search starting from initial state. The goal of the loop
+ * tracking algorithm is to associate topmost loop entries with states
+ * derived from these entries.
+ *
+ * For each step in the DFS states traversal algorithm needs to identify
+ * the following situations:
+ *
+ *          initial                     initial                   initial
+ *            |                           |                         |
+ *            V                           V                         V
+ *           ...                         ...           .---------> hdr
+ *            |                           |            |            |
+ *            V                           V            |            V
+ *           cur                     .-> succ          |    .------...
+ *            |                      |    |            |    |       |
+ *            V                      |    V            |    V       V
+ *           succ                    '-- cur           |   ...     ...
+ *                                                     |    |       |
+ *                                                     |    V       V
+ *                                                     |   succ <- cur
+ *                                                     |    |
+ *                                                     |    V
+ *                                                     |   ...
+ *                                                     |    |
+ *                                                     '----'
+ *
+ *  (A) successor state of cur   (B) successor state of cur or it's entry
+ *      not yet traversed            are in current DFS path, thus cur and succ
+ *                                   are members of the same outermost loop
+ *
+ *                      initial                  initial
+ *                        |                        |
+ *                        V                        V
+ *                       ...                      ...
+ *                        |                        |
+ *                        V                        V
+ *                .------...               .------...
+ *                |       |                |       |
+ *                V       V                V       V
+ *           .-> hdr     ...              ...     ...
+ *           |    |       |                |       |
+ *           |    V       V                V       V
+ *           |   succ <- cur              succ <- cur
+ *           |    |                        |
+ *           |    V                        V
+ *           |   ...                      ...
+ *           |    |                        |
+ *           '----'                       exit
+ *
+ * (C) successor state of cur is a part of some loop but this loop
+ *     does not include cur or successor state is not in a loop at all.
+ *
+ * Algorithm could be described as the following python code:
+ *
+ *     traversed = set()   # Set of traversed nodes
+ *     entries = {}        # Mapping from node to loop entry
+ *     depths = {}         # Depth level assigned to graph node
+ *     path = set()        # Current DFS path
+ *
+ *     # Find outermost loop entry known for n
+ *     def get_loop_entry(n):
+ *         h = entries.get(n, None)
+ *         while h in entries and entries[h] != h:
+ *             h = entries[h]
+ *         return h
+ *
+ *     # Update n's loop entry if h's outermost entry comes
+ *     # before n's outermost entry in current DFS path.
+ *     def update_loop_entry(n, h):
+ *         n1 = get_loop_entry(n) or n
+ *         h1 = get_loop_entry(h) or h
+ *         if h1 in path and depths[h1] <= depths[n1]:
+ *             entries[n] = h1
+ *
+ *     def dfs(n, depth):
+ *         traversed.add(n)
+ *         path.add(n)
+ *         depths[n] = depth
+ *         for succ in G.successors(n):
+ *             if succ not in traversed:
+ *                 # Case A: explore succ and update cur's loop entry
+ *                 #         only if succ's entry is in current DFS path.
+ *                 dfs(succ, depth + 1)
+ *                 h = get_loop_entry(succ)
+ *                 update_loop_entry(n, h)
+ *             else:
+ *                 # Case B or C depending on `h1 in path` check in update_loop_entry().
+ *                 update_loop_entry(n, succ)
+ *         path.remove(n)
+ *
+ * To adapt this algorithm for use with verifier:
+ * - use st->branch == 0 as a signal that DFS of succ had been finished
+ *   and cur's loop entry has to be updated (case A), handle this in
+ *   update_branch_counts();
+ * - use st->branch > 0 as a signal that st is in the current DFS path;
+ * - handle cases B and C in is_state_visited();
+ * - update topmost loop entry for intermediate states in get_loop_entry().
+ */
+static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_state *st)
+{
+	struct bpf_verifier_state *topmost = st->loop_entry, *old;
+
+	while (topmost && topmost->loop_entry && topmost != topmost->loop_entry)
+		topmost = topmost->loop_entry;
+	/* Update loop entries for intermediate states to avoid this
+	 * traversal in future get_loop_entry() calls.
+	 */
+	while (st && st->loop_entry != topmost) {
+		old = st->loop_entry;
+		st->loop_entry = topmost;
+		st = old;
+	}
+	return topmost;
+}
+
+static void update_loop_entry(struct bpf_verifier_state *cur, struct bpf_verifier_state *hdr)
+{
+	struct bpf_verifier_state *cur1, *hdr1;
+
+	cur1 = get_loop_entry(cur) ?: cur;
+	hdr1 = get_loop_entry(hdr) ?: hdr;
+	/* The head1->branches check decides between cases B and C in
+	 * comment for get_loop_entry(). If hdr1->branches == 0 then
+	 * head's topmost loop entry is not in current DFS path,
+	 * hence 'cur' and 'hdr' are not in the same loop and there is
+	 * no need to update cur->loop_entry.
+	 */
+	if (hdr1->branches && hdr1->dfs_depth <= cur1->dfs_depth) {
+		cur->loop_entry = hdr;
+		hdr->used_as_loop_entry = true;
+	}
+}
+
 static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	while (st) {
 		u32 br = --st->branches;
 
+		/* br == 0 signals that DFS exploration for 'st' is finished,
+		 * thus it is necessary to update parent's loop entry if it
+		 * turned out that st is a part of some loop.
+		 * This is a part of 'case A' in get_loop_entry() comment.
+		 */
+		if (br == 0 && st->parent && st->loop_entry)
+			update_loop_entry(st->parent, st->loop_entry);
+
 		/* WARN_ON(br > 1) technically makes sense here,
 		 * but see comment in push_stack(), hence:
 		 */
@@ -16270,10 +16436,11 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl, **pprev;
-	struct bpf_verifier_state *cur = env->cur_state, *new;
+	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
 	int i, j, n, err, states_cnt = 0;
 	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx);
 	bool add_new_state = force_new_state;
+	bool force_exact;
 
 	/* bpf progs typically have pruning point every 4 instructions
 	 * http://vger.kernel.org/bpfconf2019.html#session-1
@@ -16368,8 +16535,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					 */
 					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
 					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
-					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE)
+					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
+						update_loop_entry(cur, &sl->state);
 						goto hit;
+					}
 				}
 				goto skip_inf_loop_check;
 			}
@@ -16400,7 +16569,36 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				add_new_state = false;
 			goto miss;
 		}
-		if (states_equal(env, &sl->state, cur, false)) {
+		/* If sl->state is a part of a loop and this loop's entry is a part of
+		 * current verification path then states have to be compared exactly.
+		 * 'force_exact' is needed to catch the following case:
+		 *
+		 *                initial     Here state 'succ' was processed first,
+		 *                  |         it was eventually tracked to produce a
+		 *                  V         state identical to 'hdr'.
+		 *     .---------> hdr        All branches from 'succ' had been explored
+		 *     |            |         and thus 'succ' has its .branches == 0.
+		 *     |            V
+		 *     |    .------...        Suppose states 'cur' and 'succ' correspond
+		 *     |    |       |         to the same instruction + callsites.
+		 *     |    V       V         In such case it is necessary to check
+		 *     |   ...     ...        if 'succ' and 'cur' are states_equal().
+		 *     |    |       |         If 'succ' and 'cur' are a part of the
+		 *     |    V       V         same loop exact flag has to be set.
+		 *     |   succ <- cur        To check if that is the case, verify
+		 *     |    |                 if loop entry of 'succ' is in current
+		 *     |    V                 DFS path.
+		 *     |   ...
+		 *     |    |
+		 *     '----'
+		 *
+		 * Additional details are in the comment before get_loop_entry().
+		 */
+		loop_entry = get_loop_entry(&sl->state);
+		force_exact = loop_entry && loop_entry->branches > 0;
+		if (states_equal(env, &sl->state, cur, force_exact)) {
+			if (force_exact)
+				update_loop_entry(cur, loop_entry);
 hit:
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
@@ -16449,7 +16647,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * speed up verification
 			 */
 			*pprev = sl->next;
-			if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE) {
+			if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE &&
+			    !sl->state.used_as_loop_entry) {
 				u32 br = sl->state.branches;
 
 				WARN_ONCE(br,
-- 
2.43.0


