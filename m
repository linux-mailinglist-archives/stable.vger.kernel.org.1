Return-Path: <stable+bounces-95540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAC59D9A85
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F043A282751
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195251D63E2;
	Tue, 26 Nov 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHlUKPJT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32D1D63DB
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635557; cv=none; b=rQj708dhusoIDqRG+bRwNLoawN+j0RtbvvDGm1Ca6zdXtPGPsOhyIBeY26HsUDc+XU2sw+cR9aAj8qLz1Oa0BaGN12zYyMEnlcb3LUnuWWwkzBqAkO2Gl+OPCTcDxI3rUu6O/70WOVRTjrG6VdCSCWHnXN+bt4ByHlyLyo0adBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635557; c=relaxed/simple;
	bh=FMG5MoZ3x9padZfPMWDcfh9kmX9++Yngm1tZRR7xhNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpnG1VMQnwSNyTOMGWka67kYNvoZPHFNasniQXwbILu4Awq6mnuyc3i7hS0NfT6FUfG5bxRM9rR9Rw/E+MpTfqHQGI61TWwe5ZkQOmbmaZP1gs+Up+fVxMFMIqtkGL1TIbrgxukgPgRrUzUM84b58NKckyrAOWefCQWiWgl6xnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHlUKPJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EA0C4CECF;
	Tue, 26 Nov 2024 15:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635557;
	bh=FMG5MoZ3x9padZfPMWDcfh9kmX9++Yngm1tZRR7xhNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHlUKPJTQ3qK+M0WcGYMYHNv7lLg2nzhAdNlyoR92a+WwiiajpN7kjv69jh6mjfMJ
	 cxr4bXgZIb2wQ/ixQyDyinXu45amW4ATvHcVz1R+R1WkK8sOfAvD1GEdlTIDY7WsBL
	 JG2pm2JK7dwVap82SiOed1qPPFXqoNZizrF8zDOigjvvlNljr92dhF9ULIcZ/1e1/+
	 k0oJPP1EpM7z2JIaLwRlTonQ7X+lTPTJ9/B8067Wa9ocS3cLkZQKsnC4/yp1YHO6gX
	 1/uaDa2usERyrJ5S2d761X2w9Wlf01TgvlsBg/3eBvQyAUXT6zSwMkw/JcweGvCm2o
	 Z1PVVdOh4kELg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6] bpf: support non-r10 register spill/fill to/from stack in precision tracking
Date: Tue, 26 Nov 2024 10:39:15 -0500
Message-ID: <20241126075632-be499156a5fd715b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126073710.852888-1-shung-hsi.yu@suse.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 41f6f64e6999a837048b1bd13a2f8742964eca6b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Commit author: Andrii Nakryiko <andrii@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 07:52:30.766472571 -0500
+++ /tmp/tmp.7irZGMTZjf	2024-11-26 07:52:30.758385650 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 41f6f64e6999a837048b1bd13a2f8742964eca6b ]
+
 Use instruction (jump) history to record instructions that performed
 register spill/fill to/from stack, regardless if this was done through
 read-only r10 register, or any other register after copying r10 into it
@@ -46,23 +48,29 @@
 Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
 Link: https://lore.kernel.org/r/20231205184248.1502704-2-andrii@kernel.org
 Signed-off-by: Alexei Starovoitov <ast@kernel.org>
+Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
+---
+This is a backport to fix CVE-2023-52920[1]
+
+1: https://lore.kernel.org/linux-cve-announce/2024110518-CVE-2023-52920-17f6@gregkh/
 ---
- include/linux/bpf_verifier.h                  |  31 +++-
+ include/linux/bpf_verifier.h                  |  33 +++-
  kernel/bpf/verifier.c                         | 175 ++++++++++--------
  .../bpf/progs/verifier_subprog_precision.c    |  23 ++-
  .../testing/selftests/bpf/verifier/precise.c  |  38 ++--
- 4 files changed, 169 insertions(+), 98 deletions(-)
+ 4 files changed, 170 insertions(+), 99 deletions(-)
 
 diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
-index 3378cc753061e..bada59812e003 100644
+index 92919d52f7e1..cb8e97665eaa 100644
 --- a/include/linux/bpf_verifier.h
 +++ b/include/linux/bpf_verifier.h
-@@ -325,12 +325,34 @@ struct bpf_func_state {
- 	int allocated_stack;
+@@ -319,12 +319,34 @@ struct bpf_func_state {
+ 	struct bpf_stack_state *stack;
  };
  
 -struct bpf_idx_pair {
 -	u32 prev_idx;
+-	u32 idx;
 +#define MAX_CALL_FRAMES 8
 +
 +/* instruction history flags, used in bpf_jmp_history_entry.flags field */
@@ -84,7 +92,7 @@
 +static_assert(INSN_F_SPI_MASK + 1 >= MAX_BPF_STACK / 8);
 +
 +struct bpf_jmp_history_entry {
- 	u32 idx;
++	u32 idx;
 +	/* insn idx can't be bigger than 1 million */
 +	u32 prev_idx : 22;
 +	/* special flags, e.g., whether insn is doing register stack spill/load */
@@ -95,7 +103,7 @@
  /* Maximum number of register states that can exist at once */
  #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)
  struct bpf_verifier_state {
-@@ -413,7 +435,7 @@ struct bpf_verifier_state {
+@@ -407,7 +429,7 @@ struct bpf_verifier_state {
  	 * For most states jmp_history_cnt is [0-3].
  	 * For loops can go up to ~40.
  	 */
@@ -104,7 +112,7 @@
  	u32 jmp_history_cnt;
  	u32 dfs_depth;
  	u32 callback_unroll_depth;
-@@ -656,6 +678,7 @@ struct bpf_verifier_env {
+@@ -640,6 +662,7 @@ struct bpf_verifier_env {
  		int cur_stack;
  	} cfg;
  	struct backtrack_state bt;
@@ -113,10 +121,10 @@
  	u32 subprog_cnt;
  	/* number of instructions analyzed by the verifier */
 diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
-index 1ed39665f8021..9bc16dc664659 100644
+index 4f19a091571b..5ca02af3a872 100644
 --- a/kernel/bpf/verifier.c
 +++ b/kernel/bpf/verifier.c
-@@ -1355,8 +1355,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
+@@ -1762,8 +1762,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
  	int i, err;
  
  	dst_state->jmp_history = copy_array(dst_state->jmp_history, src->jmp_history,
@@ -127,7 +135,7 @@
  	if (!dst_state->jmp_history)
  		return -ENOMEM;
  	dst_state->jmp_history_cnt = src->jmp_history_cnt;
-@@ -3221,6 +3221,21 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
+@@ -3397,6 +3397,21 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
  	return __check_reg_arg(env, state->regs, regno, t);
  }
  
@@ -149,7 +157,7 @@
  static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
  {
  	env->insn_aux_data[idx].jmp_point = true;
-@@ -3232,28 +3247,51 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
+@@ -3408,28 +3423,51 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
  }
  
  /* for any branch, call, exit record the history of jmps in the given state */
@@ -207,7 +215,7 @@
  /* Backtrack one insn at a time. If idx is not at the top of recorded
   * history then previous instruction came from straight line execution.
   * Return -ENOENT if we exhausted all instructions within given state.
-@@ -3415,9 +3453,14 @@ static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
+@@ -3591,9 +3629,14 @@ static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
  	return bt->reg_masks[bt->frame] & (1 << reg);
  }
  
@@ -223,7 +231,7 @@
  }
  
  /* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
-@@ -3471,7 +3514,7 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
+@@ -3647,7 +3690,7 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
   *   - *was* processed previously during backtracking.
   */
  static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
@@ -232,7 +240,7 @@
  {
  	const struct bpf_insn_cbs cbs = {
  		.cb_call	= disasm_kfunc_name,
-@@ -3484,7 +3527,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
+@@ -3660,7 +3703,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
  	u8 mode = BPF_MODE(insn->code);
  	u32 dreg = insn->dst_reg;
  	u32 sreg = insn->src_reg;
@@ -241,7 +249,7 @@
  
  	if (insn->code == 0)
  		return 0;
-@@ -3545,20 +3588,15 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
+@@ -3723,20 +3766,15 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
  		 * by 'precise' mark in corresponding register of this state.
  		 * No further tracking necessary.
  		 */
@@ -266,7 +274,7 @@
  	} else if (class == BPF_STX || class == BPF_ST) {
  		if (bt_is_reg_set(bt, dreg))
  			/* stx & st shouldn't be using _scalar_ dst_reg
-@@ -3567,17 +3605,13 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
+@@ -3745,17 +3783,13 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
  			 */
  			return -ENOTSUPP;
  		/* scalars can only be spilled into stack */
@@ -289,7 +297,7 @@
  		if (class == BPF_STX)
  			bt_set_reg(bt, sreg);
  	} else if (class == BPF_JMP || class == BPF_JMP32) {
-@@ -3621,10 +3655,14 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
+@@ -3799,10 +3833,14 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
  					WARN_ONCE(1, "verifier backtracking bug");
  					return -EFAULT;
  				}
@@ -308,7 +316,7 @@
  				/* propagate r1-r5 to the caller */
  				for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
  					if (bt_is_reg_set(bt, i)) {
-@@ -3649,8 +3687,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
+@@ -3827,8 +3865,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
  				WARN_ONCE(1, "verifier backtracking bug");
  				return -EFAULT;
  			}
@@ -322,7 +330,7 @@
  			/* clear r1-r5 in callback subprog's mask */
  			for (i = BPF_REG_1; i <= BPF_REG_5; i++)
  				bt_clear_reg(bt, i);
-@@ -4087,6 +4128,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
+@@ -4265,6 +4306,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
  	for (;;) {
  		DECLARE_BITMAP(mask, 64);
  		u32 history = st->jmp_history_cnt;
@@ -330,7 +338,7 @@
  
  		if (env->log.level & BPF_LOG_LEVEL2) {
  			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_idx %d \n",
-@@ -4150,7 +4192,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
+@@ -4328,7 +4370,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
  				err = 0;
  				skip_first = false;
  			} else {
@@ -340,7 +348,7 @@
  			}
  			if (err == -ENOTSUPP) {
  				mark_all_scalars_precise(env, env->cur_state);
-@@ -4203,22 +4246,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
+@@ -4381,22 +4424,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
  			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
  			for_each_set_bit(i, mask, 64) {
  				if (i >= func->allocated_stack / BPF_REG_SIZE) {
@@ -367,16 +375,16 @@
  				}
  
  				if (!is_spilled_scalar_reg(&func->stack[i])) {
-@@ -4391,7 +4422,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
+@@ -4561,7 +4592,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
  	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
  	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
  	struct bpf_reg_state *reg = NULL;
 -	u32 dst_reg = insn->dst_reg;
 +	int insn_flags = insn_stack_access_flags(state->frameno, spi);
  
- 	err = grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
- 	if (err)
-@@ -4432,17 +4463,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
+ 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
+ 	 * so it's aligned access and [off, off + size) are within stack limits
+@@ -4599,17 +4630,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
  	mark_stack_slot_scratched(env, spi);
  	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
  	    !register_is_null(reg) && env->bpf_capable) {
@@ -394,7 +402,7 @@
  		save_register_state(state, spi, reg, size);
  		/* Break the relation on a narrowing spill. */
  		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
-@@ -4454,6 +4474,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
+@@ -4621,6 +4641,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
  		__mark_reg_known(&fake_reg, insn->imm);
  		fake_reg.type = SCALAR_VALUE;
  		save_register_state(state, spi, &fake_reg, size);
@@ -402,7 +410,7 @@
  	} else if (reg && is_spillable_regtype(reg->type)) {
  		/* register containing pointer is being spilled into stack */
  		if (size != BPF_REG_SIZE) {
-@@ -4499,9 +4520,12 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
+@@ -4666,9 +4687,12 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
  
  		/* Mark slots affected by this stack write. */
  		for (i = 0; i < size; i++)
@@ -417,7 +425,7 @@
  	return 0;
  }
  
-@@ -4694,6 +4718,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
+@@ -4857,6 +4881,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
  	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE;
  	struct bpf_reg_state *reg;
  	u8 *stype, type;
@@ -425,7 +433,7 @@
  
  	stype = reg_state->stack[spi].slot_type;
  	reg = &reg_state->stack[spi].spilled_ptr;
-@@ -4739,12 +4764,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
+@@ -4902,12 +4927,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
  					return -EACCES;
  				}
  				mark_reg_unknown(env, state->regs, dst_regno);
@@ -440,7 +448,7 @@
  			/* restore register state from stack */
  			copy_register_state(&state->regs[dst_regno], reg);
  			/* mark reg as written since spilled pointer state likely
-@@ -4780,7 +4803,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
+@@ -4943,7 +4966,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
  		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
  		if (dst_regno >= 0)
  			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
@@ -451,7 +459,7 @@
  	return 0;
  }
  
-@@ -6940,7 +6966,6 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
+@@ -7027,7 +7053,6 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
  			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
  	if (err)
  		return err;
@@ -459,7 +467,7 @@
  	return 0;
  }
  
-@@ -16910,7 +16935,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
+@@ -16773,7 +16798,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
  			 * the precision needs to be propagated back in
  			 * the current state.
  			 */
@@ -469,7 +477,7 @@
  			err = err ? : propagate_precision(env, &sl->state);
  			if (err)
  				return err;
-@@ -17135,6 +17161,9 @@ static int do_check(struct bpf_verifier_env *env)
+@@ -16997,6 +17023,9 @@ static int do_check(struct bpf_verifier_env *env)
  		u8 class;
  		int err;
  
@@ -479,7 +487,7 @@
  		env->prev_insn_idx = prev_insn_idx;
  		if (env->insn_idx >= insn_cnt) {
  			verbose(env, "invalid insn idx %d insn_cnt %d\n",
-@@ -17174,7 +17203,7 @@ static int do_check(struct bpf_verifier_env *env)
+@@ -17036,7 +17065,7 @@ static int do_check(struct bpf_verifier_env *env)
  		}
  
  		if (is_jmp_point(env, env->insn_idx)) {
@@ -489,10 +497,10 @@
  				return err;
  		}
 diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
-index 0dfe3f8b69acf..eba98fab2f545 100644
+index f61d623b1ce8..f87365f7599b 100644
 --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
 +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
-@@ -589,11 +589,24 @@ static __u64 subprog_spill_reg_precise(void)
+@@ -541,11 +541,24 @@ static __u64 subprog_spill_reg_precise(void)
  
  SEC("?raw_tp")
  __success __log_level(2)
@@ -523,7 +531,7 @@
  {
  	asm volatile (
 diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
-index 0d84dd1f38b6b..8a2ff81d83508 100644
+index 0d84dd1f38b6..8a2ff81d8350 100644
 --- a/tools/testing/selftests/bpf/verifier/precise.c
 +++ b/tools/testing/selftests/bpf/verifier/precise.c
 @@ -140,10 +140,11 @@
@@ -597,3 +605,6 @@
  	mark_precise: frame0: parent state regs= stack=:",
  	.result = VERBOSE_ACCEPT,
  	.retval = -1,
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

