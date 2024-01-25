Return-Path: <stable+bounces-15743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0683B5F2
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82F11F22A7E
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9638C;
	Thu, 25 Jan 2024 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6l+gMbC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498C193
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141786; cv=none; b=knmazoFyun3BkWtjPKdUsosDJWp1QZy8QAuRMR7F2HJdhezAG2SvvVt5K0MXDgOzgiAXCgaRHncpTKmgfOg/dQgCs9IacSypgJYvtQoZrBaU3mhrXutzymlPKGRaOgQuT+3AwOsV9Fh5yrIsO2Fg7d97R+gMY23r2sAAQy5Ppu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141786; c=relaxed/simple;
	bh=veleZmotogmSjQlBHt4TWmGfzDTmH+Xb7PxOv9UQuSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieR7t0kRI4BFBp7yj2bfb/qBFDSbzl9vP+6htMVWk9irgxdFmWflZVKtcL8p3M9u2iNcVUb/0SMi8IJ9Bo6nuK+yD3crsaGsRTWyqKvOigAXJiUGusD87g7wK2gQjm3W7h6bjHJjiZB0s7K0a2TEuNQPPs59xEWIviIei5XDT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6l+gMbC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so7396646a12.2
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141781; x=1706746581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJGSnDYRra/svkD9Qkm+35uWlbWyPserwiXfGMpcFXQ=;
        b=m6l+gMbCHQhvO/5BCGvjmGLNjjeXEqFpBkwD8Nu/X0+InoUbTGRzg26jfg2not5Z4T
         JHXRjDdR0bDzkc2GuGaGGfSJ2fqWlISReI4tZVB3G8b0DNHvAIkMmX24basPgGVg8oCB
         Hxvf5RELtiL5m5sH88a+VsmENeBKSOmUDTrDBqmX/2Ta4gMB1UI90O1nxTd1rvB3e6kH
         PtdbYAFKh+3VfduyE/frIQunsR1/TEbMgITLzaIreZuBTVz04vzo6NU5ZCMaAphtZEn9
         2/y1xdJQ7t1dpawT9qXnPIcrN3nosTe4wtPd7ETjlr9PNZE4+WPfysHJz1NNk1thQ6me
         X+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141781; x=1706746581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJGSnDYRra/svkD9Qkm+35uWlbWyPserwiXfGMpcFXQ=;
        b=JPYMmH/TTmnD9MrP9/qCyRtplAkvbd4r0X56qEg+An5D7KA8WMaHbYE8TR2i28ti+T
         fgec/Qy1o/IcYyE4YIMxigz2w6QcOLauM6UYqq3nB5foJodf7TYEgIq8qxfXoNt9S4An
         1ybuRhlxxEFZMPqqC4F1DGY6Ml207XaP9jWE7B2Knd27KCzs7NND+Ae10OkKPOuqrEkJ
         Dxi8Zrc1+1EC4gwjguT5z8mwYL0t16cM2YTYe7dAwW5XWcg3ae64k1sGNuZ49x4ghTY8
         iio/UCmnoocYuexiM3nUGyy4RyJgynD0j9NCGZ2/nRlm5T7o0KODgbOJFzBHf9AU7s1X
         +ZMg==
X-Gm-Message-State: AOJu0YzpZM88IkZ6YLjROiQaS5e8LZwWRRP8Un2fWfBHsoDvMTLgRmhV
	+YW4C4XzvyWG/0fQExd0JjeDTO7rYMkNZcqvVgqEteJUuIoDEsg9W9hzLzB6
X-Google-Smtp-Source: AGHT+IG5c7X49cZRx1fb4IooKXd/5JwX7m0/VPmstacF5le1RieLKVLd2c7bRfmS9B4U1sv7zeGMBw==
X-Received: by 2002:a17:906:1ccf:b0:a28:4bf8:a16f with SMTP id i15-20020a1709061ccf00b00a284bf8a16fmr33337ejh.136.1706141781180;
        Wed, 24 Jan 2024 16:16:21 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:20 -0800 (PST)
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
Subject: [PATCH 6.6.y 03/17] bpf: exact states comparison for iterator convergence checks
Date: Thu, 25 Jan 2024 02:15:40 +0200
Message-ID: <20240125001554.25287-4-eddyz87@gmail.com>
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

[ Upstream commit 2793a8b015f7 ]

Convergence for open coded iterators is computed in is_state_visited()
by examining states with branches count > 1 and using states_equal().
states_equal() computes sub-state relation using read and precision marks.
Read and precision marks are propagated from children states,
thus are not guaranteed to be complete inside a loop when branches
count > 1. This could be demonstrated using the following unsafe program:

     1. r7 = -16
     2. r6 = bpf_get_prandom_u32()
     3. while (bpf_iter_num_next(&fp[-8])) {
     4.   if (r6 != 42) {
     5.     r7 = -32
     6.     r6 = bpf_get_prandom_u32()
     7.     continue
     8.   }
     9.   r0 = r10
    10.   r0 += r7
    11.   r8 = *(u64 *)(r0 + 0)
    12.   r6 = bpf_get_prandom_u32()
    13. }

Here verifier would first visit path 1-3, create a checkpoint at 3
with r7=-16, continue to 4-7,3 with r7=-32.

Because instructions at 9-12 had not been visitied yet existing
checkpoint at 3 does not have read or precision mark for r7.
Thus states_equal() would return true and verifier would discard
current state, thus unsafe memory access at 11 would not be caught.

This commit fixes this loophole by introducing exact state comparisons
for iterator convergence logic:
- registers are compared using regs_exact() regardless of read or
  precision marks;
- stack slots have to have identical type.

Unfortunately, this is too strict even for simple programs like below:

    i = 0;
    while(iter_next(&it))
      i++;

At each iteration step i++ would produce a new distinct state and
eventually instruction processing limit would be reached.

To avoid such behavior speculatively forget (widen) range for
imprecise scalar registers, if those registers were not precise at the
end of the previous iteration and do not match exactly.

This a conservative heuristic that allows to verify wide range of
programs, however it precludes verification of programs that conjure
an imprecise value on the first loop iteration and use it as precise
on the second.

Test case iter_task_vma_for_each() presents one of such cases:

        unsigned int seen = 0;
        ...
        bpf_for_each(task_vma, vma, task, 0) {
                if (seen >= 1000)
                        break;
                ...
                seen++;
        }

Here clang generates the following code:

<LBB0_4>:
      24:       r8 = r6                          ; stash current value of
                ... body ...                       'seen'
      29:       r1 = r10
      30:       r1 += -0x8
      31:       call bpf_iter_task_vma_next
      32:       r6 += 0x1                        ; seen++;
      33:       if r0 == 0x0 goto +0x2 <LBB0_6>  ; exit on next() == NULL
      34:       r7 += 0x10
      35:       if r8 < 0x3e7 goto -0xc <LBB0_4> ; loop on seen < 1000

<LBB0_6>:
      ... exit ...

Note that counter in r6 is copied to r8 and then incremented,
conditional jump is done using r8. Because of this precision mark for
r6 lags one state behind of precision mark on r8 and widening logic
kicks in.

Adding barrier_var(seen) after conditional is sufficient to force
clang use the same register for both counting and conditional jump.

This issue was discussed in the thread [1] which was started by
Andrew Werner <awerner32@gmail.com> demonstrating a similar bug
in callback functions handling. The callbacks would be addressed
in a followup patch.

[1] https://lore.kernel.org/bpf/97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com/

Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Co-developed-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231024000917.12153-4-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

[ Summary of the conflicts and their resolutions ]

Original patch contained a change to test case
tools/testing/selftests/bpf/progs/iters_task_vma.c
this change was dropped.

The test case was added by the following commit:
e0e1a7a5fc37 ("selftests/bpf: Add tests for open-coded task_vma iter")
Which is not a selected for porting to 6.6.y at the moment.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/verifier.c        | 218 ++++++++++++++++++++++++++++++-----
 2 files changed, 188 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b6e58dab8e27..57d76ef9036f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -383,6 +383,7 @@ struct bpf_verifier_state {
 	 */
 	struct bpf_idx_pair *jmp_history;
 	u32 jmp_history_cnt;
+	u32 dfs_depth;
 };
 
 #define bpf_get_spilled_reg(slot, frame)				\
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 499a6ae515b4..175d611d7d80 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1763,6 +1763,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
+	dst_state->dfs_depth = src->dfs_depth;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -7573,6 +7574,81 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 	return 0;
 }
 
+/* Look for a previous loop entry at insn_idx: nearest parent state
+ * stopped at insn_idx with callsites matching those in cur->frame.
+ */
+static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
+						  struct bpf_verifier_state *cur,
+						  int insn_idx)
+{
+	struct bpf_verifier_state_list *sl;
+	struct bpf_verifier_state *st;
+
+	/* Explored states are pushed in stack order, most recent states come first */
+	sl = *explored_state(env, insn_idx);
+	for (; sl; sl = sl->next) {
+		/* If st->branches != 0 state is a part of current DFS verification path,
+		 * hence cur & st for a loop.
+		 */
+		st = &sl->state;
+		if (st->insn_idx == insn_idx && st->branches && same_callsites(st, cur) &&
+		    st->dfs_depth < cur->dfs_depth)
+			return st;
+	}
+
+	return NULL;
+}
+
+static void reset_idmap_scratch(struct bpf_verifier_env *env);
+static bool regs_exact(const struct bpf_reg_state *rold,
+		       const struct bpf_reg_state *rcur,
+		       struct bpf_idmap *idmap);
+
+static void maybe_widen_reg(struct bpf_verifier_env *env,
+			    struct bpf_reg_state *rold, struct bpf_reg_state *rcur,
+			    struct bpf_idmap *idmap)
+{
+	if (rold->type != SCALAR_VALUE)
+		return;
+	if (rold->type != rcur->type)
+		return;
+	if (rold->precise || rcur->precise || regs_exact(rold, rcur, idmap))
+		return;
+	__mark_reg_unknown(env, rcur);
+}
+
+static int widen_imprecise_scalars(struct bpf_verifier_env *env,
+				   struct bpf_verifier_state *old,
+				   struct bpf_verifier_state *cur)
+{
+	struct bpf_func_state *fold, *fcur;
+	int i, fr;
+
+	reset_idmap_scratch(env);
+	for (fr = old->curframe; fr >= 0; fr--) {
+		fold = old->frame[fr];
+		fcur = cur->frame[fr];
+
+		for (i = 0; i < MAX_BPF_REG; i++)
+			maybe_widen_reg(env,
+					&fold->regs[i],
+					&fcur->regs[i],
+					&env->idmap_scratch);
+
+		for (i = 0; i < fold->allocated_stack / BPF_REG_SIZE; i++) {
+			if (!is_spilled_reg(&fold->stack[i]) ||
+			    !is_spilled_reg(&fcur->stack[i]))
+				continue;
+
+			maybe_widen_reg(env,
+					&fold->stack[i].spilled_ptr,
+					&fcur->stack[i].spilled_ptr,
+					&env->idmap_scratch);
+		}
+	}
+	return 0;
+}
+
 /* process_iter_next_call() is called when verifier gets to iterator's next
  * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'll refer
  * to it as just "iter_next()" in comments below.
@@ -7614,25 +7690,47 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
  * is some statically known limit on number of iterations (e.g., if there is
  * an explicit `if n > 100 then break;` statement somewhere in the loop).
  *
- * One very subtle but very important aspect is that we *always* simulate NULL
- * condition first (as the current state) before we simulate non-NULL case.
- * This has to do with intricacies of scalar precision tracking. By simulating
- * "exit condition" of iter_next() returning NULL first, we make sure all the
- * relevant precision marks *that will be set **after** we exit iterator loop*
- * are propagated backwards to common parent state of NULL and non-NULL
- * branches. Thanks to that, state equivalence checks done later in forked
- * state, when reaching iter_next() for ACTIVE iterator, can assume that
- * precision marks are finalized and won't change. Because simulating another
- * ACTIVE iterator iteration won't change them (because given same input
- * states we'll end up with exactly same output states which we are currently
- * comparing; and verification after the loop already propagated back what
- * needs to be **additionally** tracked as precise). It's subtle, grok
- * precision tracking for more intuitive understanding.
+ * Iteration convergence logic in is_state_visited() relies on exact
+ * states comparison, which ignores read and precision marks.
+ * This is necessary because read and precision marks are not finalized
+ * while in the loop. Exact comparison might preclude convergence for
+ * simple programs like below:
+ *
+ *     i = 0;
+ *     while(iter_next(&it))
+ *       i++;
+ *
+ * At each iteration step i++ would produce a new distinct state and
+ * eventually instruction processing limit would be reached.
+ *
+ * To avoid such behavior speculatively forget (widen) range for
+ * imprecise scalar registers, if those registers were not precise at the
+ * end of the previous iteration and do not match exactly.
+ *
+ * This is a conservative heuristic that allows to verify wide range of programs,
+ * however it precludes verification of programs that conjure an
+ * imprecise value on the first loop iteration and use it as precise on a second.
+ * For example, the following safe program would fail to verify:
+ *
+ *     struct bpf_num_iter it;
+ *     int arr[10];
+ *     int i = 0, a = 0;
+ *     bpf_iter_num_new(&it, 0, 10);
+ *     while (bpf_iter_num_next(&it)) {
+ *       if (a == 0) {
+ *         a = 1;
+ *         i = 7; // Because i changed verifier would forget
+ *                // it's range on second loop entry.
+ *       } else {
+ *         arr[i] = 42; // This would fail to verify.
+ *       }
+ *     }
+ *     bpf_iter_num_destroy(&it);
  */
 static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 				  struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st;
+	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
 	struct bpf_reg_state *cur_iter, *queued_iter;
 	int iter_frameno = meta->iter.frameno;
@@ -7650,6 +7748,19 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 	}
 
 	if (cur_iter->iter.state == BPF_ITER_STATE_ACTIVE) {
+		/* Because iter_next() call is a checkpoint is_state_visitied()
+		 * should guarantee parent state with same call sites and insn_idx.
+		 */
+		if (!cur_st->parent || cur_st->parent->insn_idx != insn_idx ||
+		    !same_callsites(cur_st->parent, cur_st)) {
+			verbose(env, "bug: bad parent state for iter next call");
+			return -EFAULT;
+		}
+		/* Note cur_st->parent in the call below, it is necessary to skip
+		 * checkpoint created for cur_st by is_state_visited()
+		 * right at this instruction.
+		 */
+		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
 		/* branch out active iter state */
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
 		if (!queued_st)
@@ -7658,6 +7769,8 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
 		queued_iter->iter.depth++;
+		if (prev_st)
+			widen_imprecise_scalars(env, prev_st, queued_st);
 
 		queued_fr = queued_st->frame[queued_st->curframe];
 		mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
@@ -15568,8 +15681,11 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
-		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap)
+		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap, bool exact)
 {
+	if (exact)
+		return regs_exact(rold, rcur, idmap);
+
 	if (!(rold->live & REG_LIVE_READ))
 		/* explored state didn't use this */
 		return true;
@@ -15686,7 +15802,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_idmap *idmap)
+		      struct bpf_func_state *cur, struct bpf_idmap *idmap, bool exact)
 {
 	int i, spi;
 
@@ -15699,7 +15815,12 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 
 		spi = i / BPF_REG_SIZE;
 
-		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)) {
+		if (exact &&
+		    old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
+		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
+			return false;
+
+		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ) && !exact) {
 			i += BPF_REG_SIZE - 1;
 			/* explored state didn't use this */
 			continue;
@@ -15749,7 +15870,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * return false to continue verification of this path
 			 */
 			if (!regsafe(env, &old->stack[spi].spilled_ptr,
-				     &cur->stack[spi].spilled_ptr, idmap))
+				     &cur->stack[spi].spilled_ptr, idmap, exact))
 				return false;
 			break;
 		case STACK_DYNPTR:
@@ -15831,16 +15952,16 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur)
+			      struct bpf_func_state *cur, bool exact)
 {
 	int i;
 
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (!regsafe(env, &old->regs[i], &cur->regs[i],
-			     &env->idmap_scratch))
+			     &env->idmap_scratch, exact))
 			return false;
 
-	if (!stacksafe(env, old, cur, &env->idmap_scratch))
+	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
 		return false;
 
 	if (!refsafe(old, cur, &env->idmap_scratch))
@@ -15849,17 +15970,23 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	return true;
 }
 
+static void reset_idmap_scratch(struct bpf_verifier_env *env)
+{
+	env->idmap_scratch.tmp_id_gen = env->id_gen;
+	memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map));
+}
+
 static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *old,
-			 struct bpf_verifier_state *cur)
+			 struct bpf_verifier_state *cur,
+			 bool exact)
 {
 	int i;
 
 	if (old->curframe != cur->curframe)
 		return false;
 
-	env->idmap_scratch.tmp_id_gen = env->id_gen;
-	memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map));
+	reset_idmap_scratch(env);
 
 	/* Verification state from speculative execution simulation
 	 * must never prune a non-speculative execution one.
@@ -15889,7 +16016,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 	for (i = 0; i <= old->curframe; i++) {
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
-		if (!func_states_equal(env, old->frame[i], cur->frame[i]))
+		if (!func_states_equal(env, old->frame[i], cur->frame[i], exact))
 			return false;
 	}
 	return true;
@@ -16144,7 +16271,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl, **pprev;
 	struct bpf_verifier_state *cur = env->cur_state, *new;
-	int i, j, err, states_cnt = 0;
+	int i, j, n, err, states_cnt = 0;
 	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx);
 	bool add_new_state = force_new_state;
 
@@ -16199,9 +16326,33 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * It's safe to assume that iterator loop will finish, taking into
 			 * account iter_next() contract of eventually returning
 			 * sticky NULL result.
+			 *
+			 * Note, that states have to be compared exactly in this case because
+			 * read and precision marks might not be finalized inside the loop.
+			 * E.g. as in the program below:
+			 *
+			 *     1. r7 = -16
+			 *     2. r6 = bpf_get_prandom_u32()
+			 *     3. while (bpf_iter_num_next(&fp[-8])) {
+			 *     4.   if (r6 != 42) {
+			 *     5.     r7 = -32
+			 *     6.     r6 = bpf_get_prandom_u32()
+			 *     7.     continue
+			 *     8.   }
+			 *     9.   r0 = r10
+			 *    10.   r0 += r7
+			 *    11.   r8 = *(u64 *)(r0 + 0)
+			 *    12.   r6 = bpf_get_prandom_u32()
+			 *    13. }
+			 *
+			 * Here verifier would first visit path 1-3, create a checkpoint at 3
+			 * with r7=-16, continue to 4-7,3. Existing checkpoint at 3 does
+			 * not have read or precision mark for r7 yet, thus inexact states
+			 * comparison would discard current state with r7=-32
+			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur)) {
+				if (states_equal(env, &sl->state, cur, true)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
 					int spi;
@@ -16224,7 +16375,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
-			    states_equal(env, &sl->state, cur) &&
+			    states_equal(env, &sl->state, cur, false) &&
 			    !iter_active_depths_differ(&sl->state, cur)) {
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
@@ -16249,7 +16400,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				add_new_state = false;
 			goto miss;
 		}
-		if (states_equal(env, &sl->state, cur)) {
+		if (states_equal(env, &sl->state, cur, false)) {
 hit:
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
@@ -16288,8 +16439,12 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		 * to keep checking from state equivalence point of view.
 		 * Higher numbers increase max_states_per_insn and verification time,
 		 * but do not meaningfully decrease insn_processed.
+		 * 'n' controls how many times state could miss before eviction.
+		 * Use bigger 'n' for checkpoints because evicting checkpoint states
+		 * too early would hinder iterator convergence.
 		 */
-		if (sl->miss_cnt > sl->hit_cnt * 3 + 3) {
+		n = is_force_checkpoint(env, insn_idx) && sl->state.branches > 0 ? 64 : 3;
+		if (sl->miss_cnt > sl->hit_cnt * n + n) {
 			/* the state is unlikely to be useful. Remove it to
 			 * speed up verification
 			 */
@@ -16363,6 +16518,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 	cur->parent = new;
 	cur->first_insn_idx = insn_idx;
+	cur->dfs_depth = new->dfs_depth + 1;
 	clear_jmp_history(cur);
 	new_sl->next = *explored_state(env, insn_idx);
 	*explored_state(env, insn_idx) = new_sl;
-- 
2.43.0


