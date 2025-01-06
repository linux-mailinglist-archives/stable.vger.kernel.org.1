Return-Path: <stable+bounces-107160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3513A02A79
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671C11881836
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2539A146D6B;
	Mon,  6 Jan 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HwRkQjWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94B83A14;
	Mon,  6 Jan 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177635; cv=none; b=kxTsvrJTjpDPSriUwwn99D6lNKO+1UD7oaZwU4QvdJyPUEFOkjI4gj5QMsGAmf/oNEjenIvk+xQnVGAv+BfMnTKhjYEWwLBEynSLMEq4EXzdzKVjD/hhym5qywESSQBUEq5myHz40swyi0TGow1xMOLp7cQcSIWQ4QWzZnkmRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177635; c=relaxed/simple;
	bh=8JNclTmN4/qJLNlboP6mGHIZVivYpv1mezByIArFJ94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/kKw74hZ4G6WFYuCYZ77o5AKs0+vM2SpEWvVx8K8y6xG+QFRE4EkuHMsgKU7GzfuH+87Dku29Gzqam01eZCrkRz9bNa7oqIX9MVvm6eD0p6xME5JmLw+bzeTpNeFTpmJ9onBZe/GE+Jm8YQYl60USkzA0IO18HAU9RLXFyOUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HwRkQjWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC780C4CED2;
	Mon,  6 Jan 2025 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177635;
	bh=8JNclTmN4/qJLNlboP6mGHIZVivYpv1mezByIArFJ94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwRkQjWoWSH8cHCK1fIp4nSdzclHwZnxtTvGW1XMeMduMBjEKMlWy5CNdQFJ1Laxb
	 z7GMBNIGx8X8V5nAb/A9eEF7vVXtgCucL1usChUFGaTqLTqZ2gJjXVCxP9d+6fr0w2
	 7+vXN17aw6N8jt09s80gqacrR8VvJq9PtKb7DX+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Levi Zim <rsworktech@outlook.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 6.6 198/222] Revert "bpf: support non-r10 register spill/fill to/from stack in precision tracking"
Date: Mon,  6 Jan 2025 16:16:42 +0100
Message-ID: <20250106151158.255485255@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Revert commit ecc2aeeaa08a355d84d3ca9c3d2512399a194f29 which is commit
41f6f64e6999a837048b1bd13a2f8742964eca6b upstream.

Levi reported that commit ecc2aeeaa08a ("bpf: support non-r10 register
spill/fill to/from stack in precision tracking") cause eBPF program that
previously loads successfully in stable 6.6 now fails to load, when the
same program also loads successfully in v6.13-rc5.

Revert ecc2aeeaa08a until the problem has been probably figured out and
resolved.

Fixes: ecc2aeeaa08a ("bpf: support non-r10 register spill/fill to/from stack in precision tracking")
Reported-by: Levi Zim <rsworktech@outlook.com>
Link: https://lore.kernel.org/stable/MEYP282MB2312C3C8801476C4F262D6E1C6162@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/bpf_verifier.h                                   |   31 -
 kernel/bpf/verifier.c                                          |  175 ++++------
 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c |   23 -
 tools/testing/selftests/bpf/verifier/precise.c                 |   38 --
 4 files changed, 98 insertions(+), 169 deletions(-)

--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -319,34 +319,12 @@ struct bpf_func_state {
 	struct bpf_stack_state *stack;
 };
 
-#define MAX_CALL_FRAMES 8
-
-/* instruction history flags, used in bpf_jmp_history_entry.flags field */
-enum {
-	/* instruction references stack slot through PTR_TO_STACK register;
-	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES is 8)
-	 * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512,
-	 * 8 bytes per slot, so slot index (spi) is [0, 63])
-	 */
-	INSN_F_FRAMENO_MASK = 0x7, /* 3 bits */
-
-	INSN_F_SPI_MASK = 0x3f, /* 6 bits */
-	INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
-
-	INSN_F_STACK_ACCESS = BIT(9), /* we need 10 bits total */
-};
-
-static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);
-static_assert(INSN_F_SPI_MASK + 1 >= MAX_BPF_STACK / 8);
-
-struct bpf_jmp_history_entry {
+struct bpf_idx_pair {
+	u32 prev_idx;
 	u32 idx;
-	/* insn idx can't be bigger than 1 million */
-	u32 prev_idx : 22;
-	/* special flags, e.g., whether insn is doing register stack spill/load */
-	u32 flags : 10;
 };
 
+#define MAX_CALL_FRAMES 8
 /* Maximum number of register states that can exist at once */
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)
 struct bpf_verifier_state {
@@ -429,7 +407,7 @@ struct bpf_verifier_state {
 	 * For most states jmp_history_cnt is [0-3].
 	 * For loops can go up to ~40.
 	 */
-	struct bpf_jmp_history_entry *jmp_history;
+	struct bpf_idx_pair *jmp_history;
 	u32 jmp_history_cnt;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
@@ -662,7 +640,6 @@ struct bpf_verifier_env {
 		int cur_stack;
 	} cfg;
 	struct backtrack_state bt;
-	struct bpf_jmp_history_entry *cur_hist_ent;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1762,8 +1762,8 @@ static int copy_verifier_state(struct bp
 	int i, err;
 
 	dst_state->jmp_history = copy_array(dst_state->jmp_history, src->jmp_history,
-					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
-					  GFP_USER);
+					    src->jmp_history_cnt, sizeof(struct bpf_idx_pair),
+					    GFP_USER);
 	if (!dst_state->jmp_history)
 		return -ENOMEM;
 	dst_state->jmp_history_cnt = src->jmp_history_cnt;
@@ -3397,21 +3397,6 @@ static int check_reg_arg(struct bpf_veri
 	return __check_reg_arg(env, state->regs, regno, t);
 }
 
-static int insn_stack_access_flags(int frameno, int spi)
-{
-	return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
-}
-
-static int insn_stack_access_spi(int insn_flags)
-{
-	return (insn_flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK;
-}
-
-static int insn_stack_access_frameno(int insn_flags)
-{
-	return insn_flags & INSN_F_FRAMENO_MASK;
-}
-
 static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].jmp_point = true;
@@ -3423,51 +3408,28 @@ static bool is_jmp_point(struct bpf_veri
 }
 
 /* for any branch, call, exit record the history of jmps in the given state */
-static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			    int insn_flags)
+static int push_jmp_history(struct bpf_verifier_env *env,
+			    struct bpf_verifier_state *cur)
 {
 	u32 cnt = cur->jmp_history_cnt;
-	struct bpf_jmp_history_entry *p;
+	struct bpf_idx_pair *p;
 	size_t alloc_size;
 
-	/* combine instruction flags if we already recorded this instruction */
-	if (env->cur_hist_ent) {
-		/* atomic instructions push insn_flags twice, for READ and
-		 * WRITE sides, but they should agree on stack slot
-		 */
-		WARN_ONCE((env->cur_hist_ent->flags & insn_flags) &&
-			  (env->cur_hist_ent->flags & insn_flags) != insn_flags,
-			  "verifier insn history bug: insn_idx %d cur flags %x new flags %x\n",
-			  env->insn_idx, env->cur_hist_ent->flags, insn_flags);
-		env->cur_hist_ent->flags |= insn_flags;
+	if (!is_jmp_point(env, env->insn_idx))
 		return 0;
-	}
 
 	cnt++;
 	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
 	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
 	if (!p)
 		return -ENOMEM;
+	p[cnt - 1].idx = env->insn_idx;
+	p[cnt - 1].prev_idx = env->prev_insn_idx;
 	cur->jmp_history = p;
-
-	p = &cur->jmp_history[cnt - 1];
-	p->idx = env->insn_idx;
-	p->prev_idx = env->prev_insn_idx;
-	p->flags = insn_flags;
 	cur->jmp_history_cnt = cnt;
-	env->cur_hist_ent = p;
-
 	return 0;
 }
 
-static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_state *st,
-						        u32 hist_end, int insn_idx)
-{
-	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx == insn_idx)
-		return &st->jmp_history[hist_end - 1];
-	return NULL;
-}
-
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
  * Return -ENOENT if we exhausted all instructions within given state.
@@ -3629,14 +3591,9 @@ static inline bool bt_is_reg_set(struct
 	return bt->reg_masks[bt->frame] & (1 << reg);
 }
 
-static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 frame, u32 slot)
-{
-	return bt->stack_masks[frame] & (1ull << slot);
-}
-
 static inline bool bt_is_slot_set(struct backtrack_state *bt, u32 slot)
 {
-	return bt_is_frame_slot_set(bt, bt->frame, slot);
+	return bt->stack_masks[bt->frame] & (1ull << slot);
 }
 
 /* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
@@ -3690,7 +3647,7 @@ static bool calls_callback(struct bpf_ve
  *   - *was* processed previously during backtracking.
  */
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
-			  struct bpf_jmp_history_entry *hist, struct backtrack_state *bt)
+			  struct backtrack_state *bt)
 {
 	const struct bpf_insn_cbs cbs = {
 		.cb_call	= disasm_kfunc_name,
@@ -3703,7 +3660,7 @@ static int backtrack_insn(struct bpf_ver
 	u8 mode = BPF_MODE(insn->code);
 	u32 dreg = insn->dst_reg;
 	u32 sreg = insn->src_reg;
-	u32 spi, i, fr;
+	u32 spi, i;
 
 	if (insn->code == 0)
 		return 0;
@@ -3766,15 +3723,20 @@ static int backtrack_insn(struct bpf_ver
 		 * by 'precise' mark in corresponding register of this state.
 		 * No further tracking necessary.
 		 */
-		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
+		if (insn->src_reg != BPF_REG_FP)
 			return 0;
+
 		/* dreg = *(u64 *)[fp - off] was a fill from the stack.
 		 * that [fp - off] slot contains scalar that needs to be
 		 * tracked with precision
 		 */
-		spi = insn_stack_access_spi(hist->flags);
-		fr = insn_stack_access_frameno(hist->flags);
-		bt_set_frame_slot(bt, fr, spi);
+		spi = (-insn->off - 1) / BPF_REG_SIZE;
+		if (spi >= 64) {
+			verbose(env, "BUG spi %d\n", spi);
+			WARN_ONCE(1, "verifier backtracking bug");
+			return -EFAULT;
+		}
+		bt_set_slot(bt, spi);
 	} else if (class == BPF_STX || class == BPF_ST) {
 		if (bt_is_reg_set(bt, dreg))
 			/* stx & st shouldn't be using _scalar_ dst_reg
@@ -3783,13 +3745,17 @@ static int backtrack_insn(struct bpf_ver
 			 */
 			return -ENOTSUPP;
 		/* scalars can only be spilled into stack */
-		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
+		if (insn->dst_reg != BPF_REG_FP)
 			return 0;
-		spi = insn_stack_access_spi(hist->flags);
-		fr = insn_stack_access_frameno(hist->flags);
-		if (!bt_is_frame_slot_set(bt, fr, spi))
+		spi = (-insn->off - 1) / BPF_REG_SIZE;
+		if (spi >= 64) {
+			verbose(env, "BUG spi %d\n", spi);
+			WARN_ONCE(1, "verifier backtracking bug");
+			return -EFAULT;
+		}
+		if (!bt_is_slot_set(bt, spi))
 			return 0;
-		bt_clear_frame_slot(bt, fr, spi);
+		bt_clear_slot(bt, spi);
 		if (class == BPF_STX)
 			bt_set_reg(bt, sreg);
 	} else if (class == BPF_JMP || class == BPF_JMP32) {
@@ -3833,14 +3799,10 @@ static int backtrack_insn(struct bpf_ver
 					WARN_ONCE(1, "verifier backtracking bug");
 					return -EFAULT;
 				}
-				/* we are now tracking register spills correctly,
-				 * so any instance of leftover slots is a bug
-				 */
-				if (bt_stack_mask(bt) != 0) {
-					verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
-					WARN_ONCE(1, "verifier backtracking bug (subprog leftover stack slots)");
-					return -EFAULT;
-				}
+				/* we don't track register spills perfectly,
+				 * so fallback to force-precise instead of failing */
+				if (bt_stack_mask(bt) != 0)
+					return -ENOTSUPP;
 				/* propagate r1-r5 to the caller */
 				for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
 					if (bt_is_reg_set(bt, i)) {
@@ -3865,11 +3827,8 @@ static int backtrack_insn(struct bpf_ver
 				WARN_ONCE(1, "verifier backtracking bug");
 				return -EFAULT;
 			}
-			if (bt_stack_mask(bt) != 0) {
-				verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug (callback leftover stack slots)");
-				return -EFAULT;
-			}
+			if (bt_stack_mask(bt) != 0)
+				return -ENOTSUPP;
 			/* clear r1-r5 in callback subprog's mask */
 			for (i = BPF_REG_1; i <= BPF_REG_5; i++)
 				bt_clear_reg(bt, i);
@@ -4306,7 +4265,6 @@ static int __mark_chain_precision(struct
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
 		u32 history = st->jmp_history_cnt;
-		struct bpf_jmp_history_entry *hist;
 
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_idx %d \n",
@@ -4370,8 +4328,7 @@ static int __mark_chain_precision(struct
 				err = 0;
 				skip_first = false;
 			} else {
-				hist = get_jmp_hist_entry(st, history, i);
-				err = backtrack_insn(env, i, subseq_idx, hist, bt);
+				err = backtrack_insn(env, i, subseq_idx, bt);
 			}
 			if (err == -ENOTSUPP) {
 				mark_all_scalars_precise(env, env->cur_state);
@@ -4424,10 +4381,22 @@ static int __mark_chain_precision(struct
 			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
 			for_each_set_bit(i, mask, 64) {
 				if (i >= func->allocated_stack / BPF_REG_SIZE) {
-					verbose(env, "BUG backtracking (stack slot %d, total slots %d)\n",
-						i, func->allocated_stack / BPF_REG_SIZE);
-					WARN_ONCE(1, "verifier backtracking bug (stack slot out of bounds)");
-					return -EFAULT;
+					/* the sequence of instructions:
+					 * 2: (bf) r3 = r10
+					 * 3: (7b) *(u64 *)(r3 -8) = r0
+					 * 4: (79) r4 = *(u64 *)(r10 -8)
+					 * doesn't contain jmps. It's backtracked
+					 * as a single block.
+					 * During backtracking insn 3 is not recognized as
+					 * stack access, so at the end of backtracking
+					 * stack slot fp-8 is still marked in stack_mask.
+					 * However the parent state may not have accessed
+					 * fp-8 and it's "unallocated" stack space.
+					 * In such case fallback to conservative.
+					 */
+					mark_all_scalars_precise(env, env->cur_state);
+					bt_reset(bt);
+					return 0;
 				}
 
 				if (!is_spilled_scalar_reg(&func->stack[i])) {
@@ -4592,7 +4561,7 @@ static int check_stack_write_fixed_off(s
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg = NULL;
-	int insn_flags = insn_stack_access_flags(state->frameno, spi);
+	u32 dst_reg = insn->dst_reg;
 
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
@@ -4631,6 +4600,17 @@ static int check_stack_write_fixed_off(s
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
+		if (dst_reg != BPF_REG_FP) {
+			/* The backtracking logic can only recognize explicit
+			 * stack slot address like [fp - 8]. Other spill of
+			 * scalar via different register has to be conservative.
+			 * Backtrack from here and mark all registers as precise
+			 * that contributed into 'reg' being a constant.
+			 */
+			err = mark_chain_precision(env, value_regno);
+			if (err)
+				return err;
+		}
 		save_register_state(state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
@@ -4642,7 +4622,6 @@ static int check_stack_write_fixed_off(s
 		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type = SCALAR_VALUE;
 		save_register_state(state, spi, &fake_reg, size);
-		insn_flags = 0; /* not a register spill */
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
@@ -4688,12 +4667,9 @@ static int check_stack_write_fixed_off(s
 
 		/* Mark slots affected by this stack write. */
 		for (i = 0; i < size; i++)
-			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] = type;
-		insn_flags = 0; /* not a register spill */
+			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] =
+				type;
 	}
-
-	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags);
 	return 0;
 }
 
@@ -4882,7 +4858,6 @@ static int check_stack_read_fixed_off(st
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE;
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
-	int insn_flags = insn_stack_access_flags(reg_state->frameno, spi);
 
 	stype = reg_state->stack[spi].slot_type;
 	reg = &reg_state->stack[spi].spilled_ptr;
@@ -4928,10 +4903,12 @@ static int check_stack_read_fixed_off(st
 					return -EACCES;
 				}
 				mark_reg_unknown(env, state->regs, dst_regno);
-				insn_flags = 0; /* not restoring original register state */
 			}
 			state->regs[dst_regno].live |= REG_LIVE_WRITTEN;
-		} else if (dst_regno >= 0) {
+			return 0;
+		}
+
+		if (dst_regno >= 0) {
 			/* restore register state from stack */
 			copy_register_state(&state->regs[dst_regno], reg);
 			/* mark reg as written since spilled pointer state likely
@@ -4967,10 +4944,7 @@ static int check_stack_read_fixed_off(st
 		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 		if (dst_regno >= 0)
 			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
-		insn_flags = 0; /* we are not restoring spilled register */
 	}
-	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags);
 	return 0;
 }
 
@@ -7054,6 +7028,7 @@ static int check_atomic(struct bpf_verif
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
+
 	return 0;
 }
 
@@ -16802,8 +16777,7 @@ hit:
 			 * the precision needs to be propagated back in
 			 * the current state.
 			 */
-			if (is_jmp_point(env, env->insn_idx))
-				err = err ? : push_jmp_history(env, cur, 0);
+			err = err ? : push_jmp_history(env, cur);
 			err = err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -17027,9 +17001,6 @@ static int do_check(struct bpf_verifier_
 		u8 class;
 		int err;
 
-		/* reset current history entry on each new instruction */
-		env->cur_hist_ent = NULL;
-
 		env->prev_insn_idx = prev_insn_idx;
 		if (env->insn_idx >= insn_cnt) {
 			verbose(env, "invalid insn idx %d insn_cnt %d\n",
@@ -17069,7 +17040,7 @@ static int do_check(struct bpf_verifier_
 		}
 
 		if (is_jmp_point(env, env->insn_idx)) {
-			err = push_jmp_history(env, state, 0);
+			err = push_jmp_history(env, state);
 			if (err)
 				return err;
 		}
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -541,24 +541,11 @@ static __u64 subprog_spill_reg_precise(v
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("10: (0f) r1 += r7")
-__msg("mark_precise: frame0: last_idx 10 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r7 stack= before 9: (bf) r1 = r8")
-__msg("mark_precise: frame0: regs=r7 stack= before 8: (27) r7 *= 4")
-__msg("mark_precise: frame0: regs=r7 stack= before 7: (79) r7 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R0_w=2 R6_w=1 R8_rw=map_value(map=.data.vals,ks=4,vs=16) R10=fp0 fp-8_rw=P1")
-__msg("mark_precise: frame0: last_idx 18 first_idx 0 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-8 before 18: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 17: (0f) r0 += r2")
-__msg("mark_precise: frame1: regs= stack= before 16: (79) r2 = *(u64 *)(r1 +0)")
-__msg("mark_precise: frame1: regs= stack= before 15: (79) r0 = *(u64 *)(r10 -16)")
-__msg("mark_precise: frame1: regs= stack= before 14: (7b) *(u64 *)(r10 -16) = r2")
-__msg("mark_precise: frame1: regs= stack= before 13: (7b) *(u64 *)(r1 +0) = r2")
-__msg("mark_precise: frame1: regs=r2 stack= before 6: (85) call pc+6")
-__msg("mark_precise: frame0: regs=r2 stack= before 5: (bf) r2 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 1")
+/* precision backtracking can't currently handle stack access not through r10,
+ * so we won't be able to mark stack slot fp-8 as precise, and so will
+ * fallback to forcing all as precise
+ */
+__msg("mark_precise: frame0: falling back to forcing all scalars precise")
 __naked int subprog_spill_into_parent_stack_slot_precise(void)
 {
 	asm volatile (
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -140,11 +140,10 @@
 	.result = REJECT,
 },
 {
-	"precise: ST zero to stack insn is supported",
+	"precise: ST insn causing spi > allocated_stack",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
-	/* not a register spill, so we stop precision propagation for R4 here */
 	BPF_ST_MEM(BPF_DW, BPF_REG_3, -8, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_MOV64_IMM(BPF_REG_0, -1),
@@ -158,11 +157,11 @@
 	mark_precise: frame0: last_idx 4 first_idx 2\
 	mark_precise: frame0: regs=r4 stack= before 4\
 	mark_precise: frame0: regs=r4 stack= before 3\
+	mark_precise: frame0: regs= stack=-8 before 2\
+	mark_precise: frame0: falling back to forcing all scalars precise\
+	force_precise: frame0: forcing r0 to be precise\
 	mark_precise: frame0: last_idx 5 first_idx 5\
-	mark_precise: frame0: parent state regs=r0 stack=:\
-	mark_precise: frame0: last_idx 4 first_idx 2\
-	mark_precise: frame0: regs=r0 stack= before 4\
-	5: R0=-1 R4=0",
+	mark_precise: frame0: parent state regs= stack=:",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
@@ -170,8 +169,6 @@
 	"precise: STX insn causing spi > allocated_stack",
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	/* make later reg spill more interesting by having somewhat known scalar */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xff),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, -8),
@@ -182,21 +179,18 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "mark_precise: frame0: last_idx 7 first_idx 7\
+	.errstr = "mark_precise: frame0: last_idx 6 first_idx 6\
 	mark_precise: frame0: parent state regs=r4 stack=:\
-	mark_precise: frame0: last_idx 6 first_idx 4\
-	mark_precise: frame0: regs=r4 stack= before 6: (b7) r0 = -1\
-	mark_precise: frame0: regs=r4 stack= before 5: (79) r4 = *(u64 *)(r10 -8)\
-	mark_precise: frame0: regs= stack=-8 before 4: (7b) *(u64 *)(r3 -8) = r0\
-	mark_precise: frame0: parent state regs=r0 stack=:\
-	mark_precise: frame0: last_idx 3 first_idx 3\
-	mark_precise: frame0: regs=r0 stack= before 3: (55) if r3 != 0x7b goto pc+0\
-	mark_precise: frame0: regs=r0 stack= before 2: (bf) r3 = r10\
-	mark_precise: frame0: regs=r0 stack= before 1: (57) r0 &= 255\
-	mark_precise: frame0: parent state regs=r0 stack=:\
-	mark_precise: frame0: last_idx 0 first_idx 0\
-	mark_precise: frame0: regs=r0 stack= before 0: (85) call bpf_get_prandom_u32#7\
-	mark_precise: frame0: last_idx 7 first_idx 7\
+	mark_precise: frame0: last_idx 5 first_idx 3\
+	mark_precise: frame0: regs=r4 stack= before 5\
+	mark_precise: frame0: regs=r4 stack= before 4\
+	mark_precise: frame0: regs= stack=-8 before 3\
+	mark_precise: frame0: falling back to forcing all scalars precise\
+	force_precise: frame0: forcing r0 to be precise\
+	force_precise: frame0: forcing r0 to be precise\
+	force_precise: frame0: forcing r0 to be precise\
+	force_precise: frame0: forcing r0 to be precise\
+	mark_precise: frame0: last_idx 6 first_idx 6\
 	mark_precise: frame0: parent state regs= stack=:",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,



