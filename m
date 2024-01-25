Return-Path: <stable+bounces-15752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635D83B5FA
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D1428935B
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB17F;
	Thu, 25 Jan 2024 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTgzMt3D"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3814196
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141798; cv=none; b=iMnWEEyJZga2Dus6TZTcLrr+i27HlH4t475aGao/Ws0luI+itIycHwsRqGq6iDe2TG0J1foUPBN7VBI0weuYQ8IcvEOjTosEGWXFQFHTEnF4INULbjPC5PBvQQsRADnVBxjuH/kVp5Gg4t/wI5Y0KJRUKFhn9jph4+bMQb7A9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141798; c=relaxed/simple;
	bh=fhZ8giuy9BLlpKF8fAvLbePzrAvDOqvJERMO8Cy3Nco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVfWaJEV/ceu3WdZLf0n7EN4OEgGmMyLO6V179caq1155wT2XnIjTcJTnksPHr9IBGXgbzQ9mVJtZZqYfK4AjbzsVKnKn0YsgN3wdvmhMK1I7BoZBXjRRwYHLHmwoQN9RbXtsU6qvtRRGN4D3Q1PTB/Pl5YhxZGN9N3RAVL1wuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTgzMt3D; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso617329766b.2
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141793; x=1706746593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP0uREoie0jggcNPsswmDsi1wgDmPEWKLLNEKRB1arY=;
        b=jTgzMt3DcEk4y5/EydJmdnw52zpSu/Goigv7YidydWW4yJywK3N0rjpfiyQ6zmC2Mb
         PA9cBwb/Xw0rGKPxXZ7+NxoqZ3x6Yxvtiu72MTy/q0ODK7a5dGXkuIrF/9rgNIiWyQQK
         ZLhQwt2ETLNpW5204YBjuJ1BdDeBCD8OPHxBvzBZzm0QNG5wgdps5QLMrcoq1k7AA8ez
         eUU3UoHg+CZP4aRTQQd4gxN2ClajUaJq7OVr6csRDDsktqz0AOynZQaxBoKcI1acpU4C
         Wn9y4bnUi9kEQN2y4bTvNW5K3418Ed0XAKdmtWTl1Pg/1YG8PNeLeaoErTmgngp7nzS/
         Sqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141793; x=1706746593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP0uREoie0jggcNPsswmDsi1wgDmPEWKLLNEKRB1arY=;
        b=f5rp5Bze9OF36nRLoL86vIDhzvLBpjl6z1YZGskrldh8og6j/HnensQgNYEzpmbUBw
         UlUXDXACes3QeTxs/XVb7wsz8ywpi4+mrXJgUGWjeH5BUiMx1khk/2hPIhrWBNOWEHTt
         liuacz9R5LPpyKzJ73Jxbrlh3G7D09HAfc+fflFXyQa2gkoUsLEML4RjkY59Vls+L9vm
         Rzr7TwWn+syTYTxQqCqYG5JNbcQarS09xsbpWwsnlHnmbU+bZFci5QDe3ph3+kcv9XOu
         OSmRpW/7RU7pFlHyOURZrWFIUZqUbhF+C/zpjp0yIpkEnekxkWmLI7FFFv5yd1/0yWyQ
         fxyg==
X-Gm-Message-State: AOJu0YwOO0HNU/ybAM0jqOqxIu3wjr+qWsNNkAWi8aV2oMCDgrQYB2jQ
	lW0pqBw/I+I8QgHIB5pYTFNaGzudCbc0c+fiU/OzeejEFqiCnbS0Ir9+B+vb
X-Google-Smtp-Source: AGHT+IEdt5HF9bXHzjM1Zt+g1kGbcEZ5wMOwDicMbVs4emGa5wrrNX83DTIQd92IxTIaj+XdUmS8oA==
X-Received: by 2002:a17:907:c089:b0:a2f:7cb7:433d with SMTP id st9-20020a170907c08900b00a2f7cb7433dmr80057ejc.88.1706141793507;
        Wed, 24 Jan 2024 16:16:33 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:33 -0800 (PST)
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
	Andrew Werner <awerner32@gmail.com>
Subject: [PATCH 6.6.y 12/17] bpf: verify callbacks as if they are called unknown number of times
Date: Thu, 25 Jan 2024 02:15:49 +0200
Message-ID: <20240125001554.25287-13-eddyz87@gmail.com>
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

[ Upstream commit ab5cfac139ab ]

Prior to this patch callbacks were handled as regular function calls,
execution of callback body was modeled exactly once.
This patch updates callbacks handling logic as follows:
- introduces a function push_callback_call() that schedules callback
  body verification in env->head stack;
- updates prepare_func_exit() to reschedule callback body verification
  upon BPF_EXIT;
- as calls to bpf_*_iter_next(), calls to callback invoking functions
  are marked as checkpoints;
- is_state_visited() is updated to stop callback based iteration when
  some identical parent state is found.

Paths with callback function invoked zero times are now verified first,
which leads to necessity to modify some selftests:
- the following negative tests required adding release/unlock/drop
  calls to avoid previously masked unrelated error reports:
  - cb_refs.c:underflow_prog
  - exceptions_fail.c:reject_rbtree_add_throw
  - exceptions_fail.c:reject_with_cp_reference
- the following precision tracking selftests needed change in expected
  log trace:
  - verifier_subprog_precision.c:callback_result_precise
    (note: r0 precision is no longer propagated inside callback and
           I think this is a correct behavior)
  - verifier_subprog_precision.c:parent_callee_saved_reg_precise_with_callback
  - verifier_subprog_precision.c:parent_stack_slot_precise_with_callback

Reported-by: Andrew Werner <awerner32@gmail.com>
Closes: https://lore.kernel.org/bpf/CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com/
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-7-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>

[ Summary of the conflicts and their resolutions ]

There were three conflicts with this patch, all with code related to
implementation of BPF exceptions: the upstream series was developed
after BPF exceptions landed in bpf-next and BPF exceptions are not
selected for porting to 6.6.y at the moment.

All conflicts were resolved by excluding exceptions related parts.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  |   5 +
 kernel/bpf/verifier.c                         | 272 +++++++++++-------
 tools/testing/selftests/bpf/progs/cb_refs.c   |   1 +
 .../bpf/progs/verifier_subprog_precision.c    |  71 ++++-
 4 files changed, 237 insertions(+), 112 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 33992ea42124..f3b9550e8ef9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -399,6 +399,7 @@ struct bpf_verifier_state {
 	struct bpf_idx_pair *jmp_history;
 	u32 jmp_history_cnt;
 	u32 dfs_depth;
+	u32 callback_unroll_depth;
 };
 
 #define bpf_get_spilled_reg(slot, frame)				\
@@ -506,6 +507,10 @@ struct bpf_insn_aux_data {
 	 * this instruction, regardless of any heuristics
 	 */
 	bool force_checkpoint;
+	/* true if instruction is a call to a helper function that
+	 * accepts callback function as a parameter.
+	 */
+	bool calls_callback;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b763424875d..0eb0de55a443 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -542,12 +542,11 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 	return func_id == BPF_FUNC_dynptr_data;
 }
 
-static bool is_callback_calling_kfunc(u32 btf_id);
+static bool is_sync_callback_calling_kfunc(u32 btf_id);
 
-static bool is_callback_calling_function(enum bpf_func_id func_id)
+static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_for_each_map_elem ||
-	       func_id == BPF_FUNC_timer_set_callback ||
 	       func_id == BPF_FUNC_find_vma ||
 	       func_id == BPF_FUNC_loop ||
 	       func_id == BPF_FUNC_user_ringbuf_drain;
@@ -558,6 +557,18 @@ static bool is_async_callback_calling_function(enum bpf_func_id func_id)
 	return func_id == BPF_FUNC_timer_set_callback;
 }
 
+static bool is_callback_calling_function(enum bpf_func_id func_id)
+{
+	return is_sync_callback_calling_function(func_id) ||
+	       is_async_callback_calling_function(func_id);
+}
+
+static bool is_sync_callback_calling_insn(struct bpf_insn *insn)
+{
+	return (bpf_helper_call(insn) && is_sync_callback_calling_function(insn->imm)) ||
+	       (bpf_pseudo_kfunc_call(insn) && is_sync_callback_calling_kfunc(insn->imm));
+}
+
 static bool is_storage_get_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_sk_storage_get ||
@@ -1764,6 +1775,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
 	dst_state->dfs_depth = src->dfs_depth;
+	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
@@ -3605,6 +3617,8 @@ static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
 	}
 }
 
+static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
+
 /* For given verifier state backtrack_insn() is called from the last insn to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
@@ -3780,16 +3794,13 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					return -EFAULT;
 				return 0;
 			}
-		} else if ((bpf_helper_call(insn) &&
-			    is_callback_calling_function(insn->imm) &&
-			    !is_async_callback_calling_function(insn->imm)) ||
-			   (bpf_pseudo_kfunc_call(insn) && is_callback_calling_kfunc(insn->imm))) {
-			/* callback-calling helper or kfunc call, which means
-			 * we are exiting from subprog, but unlike the subprog
-			 * call handling above, we shouldn't propagate
-			 * precision of r1-r5 (if any requested), as they are
-			 * not actually arguments passed directly to callback
-			 * subprogs
+		} else if (is_sync_callback_calling_insn(insn) && idx != subseq_idx - 1) {
+			/* exit from callback subprog to callback-calling helper or
+			 * kfunc call. Use idx/subseq_idx check to discern it from
+			 * straight line code backtracking.
+			 * Unlike the subprog call handling above, we shouldn't
+			 * propagate precision of r1-r5 (if any requested), as they are
+			 * not actually arguments passed directly to callback subprogs
 			 */
 			if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
 				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
@@ -3824,10 +3835,18 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		} else if (opcode == BPF_EXIT) {
 			bool r0_precise;
 
+			/* Backtracking to a nested function call, 'idx' is a part of
+			 * the inner frame 'subseq_idx' is a part of the outer frame.
+			 * In case of a regular function call, instructions giving
+			 * precision to registers R1-R5 should have been found already.
+			 * In case of a callback, it is ok to have R1-R5 marked for
+			 * backtracking, as these registers are set by the function
+			 * invoking callback.
+			 */
+			if (subseq_idx >= 0 && calls_callback(env, subseq_idx))
+				for (i = BPF_REG_1; i <= BPF_REG_5; i++)
+					bt_clear_reg(bt, i);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
-				/* if backtracing was looking for registers R1-R5
-				 * they should have been found already.
-				 */
 				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
 				WARN_ONCE(1, "verifier backtracking bug");
 				return -EFAULT;
@@ -9237,11 +9256,11 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	return err;
 }
 
-static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			     int *insn_idx, int subprog,
-			     set_callee_state_fn set_callee_state_cb)
+static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			      int insn_idx, int subprog,
+			      set_callee_state_fn set_callee_state_cb)
 {
-	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_verifier_state *state = env->cur_state, *callback_state;
 	struct bpf_func_state *caller, *callee;
 	int err;
 
@@ -9249,43 +9268,21 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	err = btf_check_subprog_call(env, subprog, caller->regs);
 	if (err == -EFAULT)
 		return err;
-	if (subprog_is_global(env, subprog)) {
-		if (err) {
-			verbose(env, "Caller passes invalid args into func#%d\n",
-				subprog);
-			return err;
-		} else {
-			if (env->log.level & BPF_LOG_LEVEL)
-				verbose(env,
-					"Func#%d is global and valid. Skipping.\n",
-					subprog);
-			clear_caller_saved_regs(env, caller->regs);
-
-			/* All global functions return a 64-bit SCALAR_VALUE */
-			mark_reg_unknown(env, caller->regs, BPF_REG_0);
-			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
-
-			/* continue with next insn after call */
-			return 0;
-		}
-	}
 
 	/* set_callee_state is used for direct subprog calls, but we are
 	 * interested in validating only BPF helpers that can call subprogs as
 	 * callbacks
 	 */
-	if (set_callee_state_cb != set_callee_state) {
-		if (bpf_pseudo_kfunc_call(insn) &&
-		    !is_callback_calling_kfunc(insn->imm)) {
-			verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
-				func_id_name(insn->imm), insn->imm);
-			return -EFAULT;
-		} else if (!bpf_pseudo_kfunc_call(insn) &&
-			   !is_callback_calling_function(insn->imm)) { /* helper */
-			verbose(env, "verifier bug: helper %s#%d not marked as callback-calling\n",
-				func_id_name(insn->imm), insn->imm);
-			return -EFAULT;
-		}
+	if (bpf_pseudo_kfunc_call(insn) &&
+	    !is_sync_callback_calling_kfunc(insn->imm)) {
+		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
+			func_id_name(insn->imm), insn->imm);
+		return -EFAULT;
+	} else if (!bpf_pseudo_kfunc_call(insn) &&
+		   !is_callback_calling_function(insn->imm)) { /* helper */
+		verbose(env, "verifier bug: helper %s#%d not marked as callback-calling\n",
+			func_id_name(insn->imm), insn->imm);
+		return -EFAULT;
 	}
 
 	if (insn->code == (BPF_JMP | BPF_CALL) &&
@@ -9296,25 +9293,76 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		/* there is no real recursion here. timer callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
-					 *insn_idx, subprog);
+					 insn_idx, subprog);
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
 		callee->async_entry_cnt = caller->async_entry_cnt + 1;
 
 		/* Convert bpf_timer_set_callback() args into timer callback args */
-		err = set_callee_state_cb(env, caller, callee, *insn_idx);
+		err = set_callee_state_cb(env, caller, callee, insn_idx);
 		if (err)
 			return err;
 
+		return 0;
+	}
+
+	/* for callback functions enqueue entry to callback and
+	 * proceed with next instruction within current frame.
+	 */
+	callback_state = push_stack(env, env->subprog_info[subprog].start, insn_idx, false);
+	if (!callback_state)
+		return -ENOMEM;
+
+	err = setup_func_entry(env, subprog, insn_idx, set_callee_state_cb,
+			       callback_state);
+	if (err)
+		return err;
+
+	callback_state->callback_unroll_depth++;
+	return 0;
+}
+
+static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			   int *insn_idx)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state *caller;
+	int err, subprog, target_insn;
+
+	target_insn = *insn_idx + insn->imm + 1;
+	subprog = find_subprog(env, target_insn);
+	if (subprog < 0) {
+		verbose(env, "verifier bug. No program starts at insn %d\n", target_insn);
+		return -EFAULT;
+	}
+
+	caller = state->frame[state->curframe];
+	err = btf_check_subprog_call(env, subprog, caller->regs);
+	if (err == -EFAULT)
+		return err;
+	if (subprog_is_global(env, subprog)) {
+		if (err) {
+			verbose(env, "Caller passes invalid args into func#%d\n", subprog);
+			return err;
+		}
+
+		if (env->log.level & BPF_LOG_LEVEL)
+			verbose(env, "Func#%d is global and valid. Skipping.\n", subprog);
 		clear_caller_saved_regs(env, caller->regs);
+
+		/* All global functions return a 64-bit SCALAR_VALUE */
 		mark_reg_unknown(env, caller->regs, BPF_REG_0);
 		caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
+
 		/* continue with next insn after call */
 		return 0;
 	}
 
-	err = setup_func_entry(env, subprog, *insn_idx, set_callee_state_cb, state);
+	/* for regular function entry setup new frame and continue
+	 * from that frame.
+	 */
+	err = setup_func_entry(env, subprog, *insn_idx, set_callee_state, state);
 	if (err)
 		return err;
 
@@ -9374,22 +9422,6 @@ static int set_callee_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			   int *insn_idx)
-{
-	int subprog, target_insn;
-
-	target_insn = *insn_idx + insn->imm + 1;
-	subprog = find_subprog(env, target_insn);
-	if (subprog < 0) {
-		verbose(env, "verifier bug. No program starts at insn %d\n",
-			target_insn);
-		return -EFAULT;
-	}
-
-	return __check_func_call(env, insn, insn_idx, subprog, set_callee_state);
-}
-
 static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 				       struct bpf_func_state *caller,
 				       struct bpf_func_state *callee,
@@ -9613,6 +9645,11 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			verbose_invalid_scalar(env, r0, &range, "callback return", "R0");
 			return -EINVAL;
 		}
+		if (!calls_callback(env, callee->callsite)) {
+			verbose(env, "BUG: in callback at %d, callsite %d !calls_callback\n",
+				*insn_idx, callee->callsite);
+			return -EFAULT;
+		}
 	} else {
 		/* return to the caller whatever r0 had in the callee */
 		caller->regs[BPF_REG_0] = *r0;
@@ -9630,7 +9667,15 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			return err;
 	}
 
-	*insn_idx = callee->callsite + 1;
+	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
+	 * there function call logic would reschedule callback visit. If iteration
+	 * converges is_state_visited() would prune that visit eventually.
+	 */
+	if (callee->in_callback_fn)
+		*insn_idx = callee->callsite;
+	else
+		*insn_idx = callee->callsite + 1;
+
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "returning from callee:\n");
 		print_verifier_state(env, callee, true);
@@ -10021,24 +10066,24 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 		break;
 	case BPF_FUNC_for_each_map_elem:
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_map_elem_callback_state);
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_map_elem_callback_state);
 		break;
 	case BPF_FUNC_timer_set_callback:
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_timer_callback_state);
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_timer_callback_state);
 		break;
 	case BPF_FUNC_find_vma:
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_find_vma_callback_state);
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_find_vma_callback_state);
 		break;
 	case BPF_FUNC_snprintf:
 		err = check_bpf_snprintf_call(env, regs);
 		break;
 	case BPF_FUNC_loop:
 		update_loop_inline_state(env, meta.subprogno);
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_loop_callback_state);
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_loop_callback_state);
 		break;
 	case BPF_FUNC_dynptr_from_mem:
 		if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE) {
@@ -10117,8 +10162,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		break;
 	}
 	case BPF_FUNC_user_ringbuf_drain:
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_user_ringbuf_callback_state);
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_user_ringbuf_callback_state);
 		break;
 	}
 
@@ -10968,7 +11013,7 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_refcount_acquire_impl];
 }
 
-static bool is_callback_calling_kfunc(u32 btf_id)
+static bool is_sync_callback_calling_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
 }
@@ -11672,6 +11717,21 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
 
+	/* Check the arguments */
+	err = check_kfunc_args(env, &meta, insn_idx);
+	if (err < 0)
+		return err;
+
+	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_rbtree_add_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, meta.func_id);
+			return err;
+		}
+	}
+
 	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 
@@ -11706,10 +11766,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EINVAL;
 	}
 
-	/* Check the arguments */
-	err = check_kfunc_args(env, &meta, insn_idx);
-	if (err < 0)
-		return err;
 	/* In case of release function, we get register number of refcounted
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
@@ -11743,16 +11799,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_rbtree_add_callback_state);
-		if (err) {
-			verbose(env, "kfunc %s#%d failed callback verification\n",
-				func_name, meta.func_id);
-			return err;
-		}
-	}
-
 	for (i = 0; i < CALLER_SAVED_REGS; i++)
 		mark_reg_not_init(env, regs, caller_saved[i]);
 
@@ -15055,6 +15101,15 @@ static bool is_force_checkpoint(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].force_checkpoint;
 }
 
+static void mark_calls_callback(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].calls_callback = true;
+}
+
+static bool calls_callback(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].calls_callback;
+}
 
 enum {
 	DONE_EXPLORING = 0,
@@ -15168,6 +15223,21 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 * async state will be pushed for further exploration.
 			 */
 			mark_prune_point(env, t);
+		/* For functions that invoke callbacks it is not known how many times
+		 * callback would be called. Verifier models callback calling functions
+		 * by repeatedly visiting callback bodies and returning to origin call
+		 * instruction.
+		 * In order to stop such iteration verifier needs to identify when a
+		 * state identical some state from a previous iteration is reached.
+		 * Check below forces creation of checkpoint before callback calling
+		 * instruction to allow search for such identical states.
+		 */
+		if (is_sync_callback_calling_insn(insn)) {
+			mark_calls_callback(env, t);
+			mark_force_checkpoint(env, t);
+			mark_prune_point(env, t);
+			mark_jmp_point(env, t);
+		}
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
@@ -16561,10 +16631,16 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				}
 				goto skip_inf_loop_check;
 			}
+			if (calls_callback(env, insn_idx)) {
+				if (states_equal(env, &sl->state, cur, true))
+					goto hit;
+				goto skip_inf_loop_check;
+			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
 			    states_equal(env, &sl->state, cur, false) &&
-			    !iter_active_depths_differ(&sl->state, cur)) {
+			    !iter_active_depths_differ(&sl->state, cur) &&
+			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
 				verbose(env, "cur state:");
diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
index 76d661b20e87..56c764df8196 100644
--- a/tools/testing/selftests/bpf/progs/cb_refs.c
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -33,6 +33,7 @@ int underflow_prog(void *ctx)
 	if (!p)
 		return 0;
 	bpf_for_each_map_elem(&array_map, cb1, &p, 0);
+	bpf_kfunc_call_test_release(p);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index db6b3143338b..da803cffb5ef 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -119,15 +119,26 @@ __naked int global_subprog_result_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
+/* First simulated path does not include callback body */
 __msg("14: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 14 first_idx 10")
+__msg("mark_precise: frame0: last_idx 14 first_idx 9")
 __msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
 __msg("mark_precise: frame0: regs=r6 stack= before 12: (27) r6 *= 4")
 __msg("mark_precise: frame0: regs=r6 stack= before 11: (25) if r6 > 0x3 goto pc+4")
 __msg("mark_precise: frame0: regs=r6 stack= before 10: (bf) r6 = r0")
-__msg("mark_precise: frame0: parent state regs=r0 stack=:")
-__msg("mark_precise: frame0: last_idx 18 first_idx 0")
-__msg("mark_precise: frame0: regs=r0 stack= before 18: (95) exit")
+__msg("mark_precise: frame0: regs=r0 stack= before 9: (85) call bpf_loop")
+/* State entering callback body popped from states stack */
+__msg("from 9 to 17: frame1:")
+__msg("17: frame1: R1=scalar() R2=0 R10=fp0 cb")
+__msg("17: (b7) r0 = 0")
+__msg("18: (95) exit")
+__msg("returning from callee:")
+__msg("to caller at 9:")
+/* r4 (flags) is always precise for bpf_loop() */
+__msg("frame 0: propagating r4")
+__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r4 stack= before 18: (95) exit")
+__msg("from 18 to 9: safe")
 __naked int callback_result_precise(void)
 {
 	asm volatile (
@@ -233,20 +244,36 @@ __naked int parent_callee_saved_reg_precise_global(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
+/* First simulated path does not include callback body */
 __msg("12: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 12 first_idx 10")
+__msg("mark_precise: frame0: last_idx 12 first_idx 9")
 __msg("mark_precise: frame0: regs=r6 stack= before 11: (bf) r1 = r7")
 __msg("mark_precise: frame0: regs=r6 stack= before 10: (27) r6 *= 4")
+__msg("mark_precise: frame0: regs=r6 stack= before 9: (85) call bpf_loop")
 __msg("mark_precise: frame0: parent state regs=r6 stack=:")
-__msg("mark_precise: frame0: last_idx 16 first_idx 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 16: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 15: (b7) r0 = 0")
-__msg("mark_precise: frame1: regs= stack= before 9: (85) call bpf_loop#181")
+__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
 __msg("mark_precise: frame0: regs=r6 stack= before 8: (b7) r4 = 0")
 __msg("mark_precise: frame0: regs=r6 stack= before 7: (b7) r3 = 0")
 __msg("mark_precise: frame0: regs=r6 stack= before 6: (bf) r2 = r8")
 __msg("mark_precise: frame0: regs=r6 stack= before 5: (b7) r1 = 1")
 __msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
+/* State entering callback body popped from states stack */
+__msg("from 9 to 15: frame1:")
+__msg("15: frame1: R1=scalar() R2=0 R10=fp0 cb")
+__msg("15: (b7) r0 = 0")
+__msg("16: (95) exit")
+__msg("returning from callee:")
+__msg("to caller at 9:")
+/* r4 (flags) is always precise for bpf_loop(),
+ * r6 was marked before backtracking to callback body.
+ */
+__msg("frame 0: propagating r4,r6")
+__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r4,r6 stack= before 16: (95) exit")
+__msg("mark_precise: frame1: regs= stack= before 15: (b7) r0 = 0")
+__msg("mark_precise: frame1: regs= stack= before 9: (85) call bpf_loop")
+__msg("mark_precise: frame0: parent state regs= stack=:")
+__msg("from 16 to 9: safe")
 __naked int parent_callee_saved_reg_precise_with_callback(void)
 {
 	asm volatile (
@@ -373,22 +400,38 @@ __naked int parent_stack_slot_precise_global(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
+/* First simulated path does not include callback body */
 __msg("14: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 14 first_idx 11")
+__msg("mark_precise: frame0: last_idx 14 first_idx 10")
 __msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
 __msg("mark_precise: frame0: regs=r6 stack= before 12: (27) r6 *= 4")
 __msg("mark_precise: frame0: regs=r6 stack= before 11: (79) r6 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: regs= stack=-8 before 10: (85) call bpf_loop")
 __msg("mark_precise: frame0: parent state regs= stack=-8:")
-__msg("mark_precise: frame0: last_idx 18 first_idx 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 18: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 17: (b7) r0 = 0")
-__msg("mark_precise: frame1: regs= stack= before 10: (85) call bpf_loop#181")
+__msg("mark_precise: frame0: last_idx 9 first_idx 0 subseq_idx 10")
 __msg("mark_precise: frame0: regs= stack=-8 before 9: (b7) r4 = 0")
 __msg("mark_precise: frame0: regs= stack=-8 before 8: (b7) r3 = 0")
 __msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r2 = r8")
 __msg("mark_precise: frame0: regs= stack=-8 before 6: (bf) r1 = r6")
 __msg("mark_precise: frame0: regs= stack=-8 before 5: (7b) *(u64 *)(r10 -8) = r6")
 __msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
+/* State entering callback body popped from states stack */
+__msg("from 10 to 17: frame1:")
+__msg("17: frame1: R1=scalar() R2=0 R10=fp0 cb")
+__msg("17: (b7) r0 = 0")
+__msg("18: (95) exit")
+__msg("returning from callee:")
+__msg("to caller at 10:")
+/* r4 (flags) is always precise for bpf_loop(),
+ * fp-8 was marked before backtracking to callback body.
+ */
+__msg("frame 0: propagating r4,fp-8")
+__msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r4 stack=-8 before 18: (95) exit")
+__msg("mark_precise: frame1: regs= stack= before 17: (b7) r0 = 0")
+__msg("mark_precise: frame1: regs= stack= before 10: (85) call bpf_loop#181")
+__msg("mark_precise: frame0: parent state regs= stack=:")
+__msg("from 18 to 10: safe")
 __naked int parent_stack_slot_precise_with_callback(void)
 {
 	asm volatile (
-- 
2.43.0


