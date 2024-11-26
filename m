Return-Path: <stable+bounces-95505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FA29D9292
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 08:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1635166C47
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798BB194123;
	Tue, 26 Nov 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PCf5QTGJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07F1885B8
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606642; cv=none; b=N8yM4wfmSZSB4tUbEX14PGiFqF1tZghqCVzS04M83FeS708209xqRStD5FR8RBpf8XYR6iEoR4CTA/iYEEwBljHCY8TkRhRGOaMleAQUmPfi6OgNcDPCWF2DIf9FDi3pMWmBisWGRt2RABWuBowwI+q6Im9abOWwiNR8eOkLI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606642; c=relaxed/simple;
	bh=Cn9xM6dNLQDxFNPH/btjrzn9QaxDZJkQjPQ/w1P6hlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOhDdqTUiotYDmSEH9+Xux9+/uzxUXfRHHuGxmWMpiDoY8KrFhdPAoxqPibnU0LWqrPf1dYGdjcvkQ9grvlHWZLhSBBxd6Sc5tpDQsLwiLV/JHLfvHiT+gV1ENYRNApclOzEjch+XD+yp2hyT7fa4oTBP2BN/FNfi72fFGgS5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PCf5QTGJ; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-53de579f775so2341525e87.2
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 23:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732606637; x=1733211437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cUQoohJ7HrilwIMZX4suxr4Qp5/Yg5uzALCcAuWo9PM=;
        b=PCf5QTGJiwPvNe6kIis/zoZjmfdClPUYZdMOVZaAa5w+0jZAukN0p9kZn5b0dKVjZc
         xNNEkXDk/Kj1Vp9R6UECe2L5lYAzFe3ap5IX5qESALgUVDqMNbdjDumkeJkg3wLJ18n/
         ikZErNQsO6Q8MjFDb1SU3n3e/SW84dFSyWOJ7OapO5wbrLWL2nTdijMn8zq3OpDbr83+
         OYpchIpQgyxbMv2zey00CteF8mVbww72PmTYLB9tcO6G5z9Hs9NWZl7nFlBxG+Jj3TjM
         7KP7rKtEN6l+7ukthYmkaMPbLTTuqAmw0ktP0mDlxdLVw5izWFP75CqaoajRc0SZQERF
         bp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732606637; x=1733211437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUQoohJ7HrilwIMZX4suxr4Qp5/Yg5uzALCcAuWo9PM=;
        b=tl/z0JS8HKi3OxMn0mJE69Z3PK4zjkGJZfiJgbrGBtlSatuHlaAVvc4mLjkyaf5PDO
         pRa5RcvDjh6UwV+FN700EmADxZlQy0ckq8n7YQ0gbrV27fMRk3Kfy/Ay1BwJAnGvTW74
         Mv8wOLdwTTnkXiPoQSqrKr6zFscscbyeWbn+lFK6vECnIv3QFOmMFkUdGIJ8fiMaW2h5
         HGceseUPti+LZr8ZjyRojNajj5PhZO/F/gDqQA6lms2JCEPMw62ce0+qSHT1NWF8KIyB
         6EAIum2hmZ/QVTdSUOwiB1o0cMoL1rd/bXGHBqgZa18jRHKcS5qncgOs1FXyujH4oZ1L
         6O4Q==
X-Gm-Message-State: AOJu0Yx+nnXkGCXAB02lwzNUbiiayMF0VYQwL59g/Tgy6D0CTaGsMhyO
	EpJZMGhMZ2cIGnoOW8jqx4psrY1GcpCg61IH/84TpKom6kMVfM0CR9hkJ4vZL6T0E1W5OXvzW1R
	up/hK83Tepl4=
X-Gm-Gg: ASbGncsjdGxnm6FuCQOgKKino6p/mWjHGZKH2lUWR9hS+AGMJxQxVAaLgjDGiC/QN1p
	6R42go54gkdOli8wL2fds0YlorIRFv75Az0G4JqcBlN4GwTEdmUEvHEMPUA3zt+KlrIpPpxg6uY
	1Yh8L+xTzcovHhasFjujUkxS1mej2NOZIoQLau/jOjYpcd6RoscUL/S7bcks9rcbi9V7XIlabsu
	QxXl4IC5oP5xNBw1IdE15KIy5XkHiVYE2V+4CQsRfOC6QDw5Os=
X-Google-Smtp-Source: AGHT+IF2Kse3z2n6GPuit/wDa2S4kNBI0/sTJ9v5LkQzd6w/9rYR3UdEoxZeOAAb8keEqQrMQo68CA==
X-Received: by 2002:a05:6512:1051:b0:53d:ed47:3017 with SMTP id 2adb3069b0e04-53ded473079mr407625e87.12.1732606636713;
        Mon, 25 Nov 2024 23:37:16 -0800 (PST)
Received: from localhost ([2401:e180:8862:3816:fe6:d915:4a82:dfc1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbd6ef748csm7369005a12.49.2024.11.25.23.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:37:16 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6] bpf: support non-r10 register spill/fill to/from stack in precision tracking
Date: Tue, 26 Nov 2024 15:37:07 +0800
Message-ID: <20241126073710.852888-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 41f6f64e6999a837048b1bd13a2f8742964eca6b ]

Use instruction (jump) history to record instructions that performed
register spill/fill to/from stack, regardless if this was done through
read-only r10 register, or any other register after copying r10 into it
*and* potentially adjusting offset.

To make this work reliably, we push extra per-instruction flags into
instruction history, encoding stack slot index (spi) and stack frame
number in extra 10 bit flags we take away from prev_idx in instruction
history. We don't touch idx field for maximum performance, as it's
checked most frequently during backtracking.

This change removes basically the last remaining practical limitation of
precision backtracking logic in BPF verifier. It fixes known
deficiencies, but also opens up new opportunities to reduce number of
verified states, explored in the subsequent patches.

There are only three differences in selftests' BPF object files
according to veristat, all in the positive direction (less states).

File                                    Program        Insns (A)  Insns (B)  Insns  (DIFF)  States (A)  States (B)  States (DIFF)
--------------------------------------  -------------  ---------  ---------  -------------  ----------  ----------  -------------
test_cls_redirect_dynptr.bpf.linked3.o  cls_redirect        2987       2864  -123 (-4.12%)         240         231    -9 (-3.75%)
xdp_synproxy_kern.bpf.linked3.o         syncookie_tc       82848      82661  -187 (-0.23%)        5107        5073   -34 (-0.67%)
xdp_synproxy_kern.bpf.linked3.o         syncookie_xdp      85116      84964  -152 (-0.18%)        5162        5130   -32 (-0.62%)

Note, I avoided renaming jmp_history to more generic insn_hist to
minimize number of lines changed and potential merge conflicts between
bpf and bpf-next trees.

Notice also cur_hist_entry pointer reset to NULL at the beginning of
instruction verification loop. This pointer avoids the problem of
relying on last jump history entry's insn_idx to determine whether we
already have entry for current instruction or not. It can happen that we
added jump history entry because current instruction is_jmp_point(), but
also we need to add instruction flags for stack access. In this case, we
don't want to entries, so we need to reuse last added entry, if it is
present.

Relying on insn_idx comparison has the same ambiguity problem as the one
that was fixed recently in [0], so we avoid that.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231110002638.4168352-3-andrii@kernel.org/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231205184248.1502704-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
This is a backport to fix CVE-2023-52920[1]

1: https://lore.kernel.org/linux-cve-announce/2024110518-CVE-2023-52920-17f6@gregkh/
---
 include/linux/bpf_verifier.h                  |  33 +++-
 kernel/bpf/verifier.c                         | 175 ++++++++++--------
 .../bpf/progs/verifier_subprog_precision.c    |  23 ++-
 .../testing/selftests/bpf/verifier/precise.c  |  38 ++--
 4 files changed, 170 insertions(+), 99 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 92919d52f7e1..cb8e97665eaa 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -319,12 +319,34 @@ struct bpf_func_state {
 	struct bpf_stack_state *stack;
 };
 
-struct bpf_idx_pair {
-	u32 prev_idx;
-	u32 idx;
+#define MAX_CALL_FRAMES 8
+
+/* instruction history flags, used in bpf_jmp_history_entry.flags field */
+enum {
+	/* instruction references stack slot through PTR_TO_STACK register;
+	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES is 8)
+	 * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512,
+	 * 8 bytes per slot, so slot index (spi) is [0, 63])
+	 */
+	INSN_F_FRAMENO_MASK = 0x7, /* 3 bits */
+
+	INSN_F_SPI_MASK = 0x3f, /* 6 bits */
+	INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
+
+	INSN_F_STACK_ACCESS = BIT(9), /* we need 10 bits total */
+};
+
+static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);
+static_assert(INSN_F_SPI_MASK + 1 >= MAX_BPF_STACK / 8);
+
+struct bpf_jmp_history_entry {
+	u32 idx;
+	/* insn idx can't be bigger than 1 million */
+	u32 prev_idx : 22;
+	/* special flags, e.g., whether insn is doing register stack spill/load */
+	u32 flags : 10;
 };
 
-#define MAX_CALL_FRAMES 8
 /* Maximum number of register states that can exist at once */
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)
 struct bpf_verifier_state {
@@ -407,7 +429,7 @@ struct bpf_verifier_state {
 	 * For most states jmp_history_cnt is [0-3].
 	 * For loops can go up to ~40.
 	 */
-	struct bpf_idx_pair *jmp_history;
+	struct bpf_jmp_history_entry *jmp_history;
 	u32 jmp_history_cnt;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
@@ -640,6 +662,7 @@ struct bpf_verifier_env {
 		int cur_stack;
 	} cfg;
 	struct backtrack_state bt;
+	struct bpf_jmp_history_entry *cur_hist_ent;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4f19a091571b..5ca02af3a872 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1762,8 +1762,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	int i, err;
 
 	dst_state->jmp_history = copy_array(dst_state->jmp_history, src->jmp_history,
-					    src->jmp_history_cnt, sizeof(struct bpf_idx_pair),
-					    GFP_USER);
+					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
+					  GFP_USER);
 	if (!dst_state->jmp_history)
 		return -ENOMEM;
 	dst_state->jmp_history_cnt = src->jmp_history_cnt;
@@ -3397,6 +3397,21 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 	return __check_reg_arg(env, state->regs, regno, t);
 }
 
+static int insn_stack_access_flags(int frameno, int spi)
+{
+	return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
+}
+
+static int insn_stack_access_spi(int insn_flags)
+{
+	return (insn_flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK;
+}
+
+static int insn_stack_access_frameno(int insn_flags)
+{
+	return insn_flags & INSN_F_FRAMENO_MASK;
+}
+
 static void mark_jmp_point(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].jmp_point = true;
@@ -3408,28 +3423,51 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
 }
 
 /* for any branch, call, exit record the history of jmps in the given state */
-static int push_jmp_history(struct bpf_verifier_env *env,
-			    struct bpf_verifier_state *cur)
+static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
+			    int insn_flags)
 {
 	u32 cnt = cur->jmp_history_cnt;
-	struct bpf_idx_pair *p;
+	struct bpf_jmp_history_entry *p;
 	size_t alloc_size;
 
-	if (!is_jmp_point(env, env->insn_idx))
+	/* combine instruction flags if we already recorded this instruction */
+	if (env->cur_hist_ent) {
+		/* atomic instructions push insn_flags twice, for READ and
+		 * WRITE sides, but they should agree on stack slot
+		 */
+		WARN_ONCE((env->cur_hist_ent->flags & insn_flags) &&
+			  (env->cur_hist_ent->flags & insn_flags) != insn_flags,
+			  "verifier insn history bug: insn_idx %d cur flags %x new flags %x\n",
+			  env->insn_idx, env->cur_hist_ent->flags, insn_flags);
+		env->cur_hist_ent->flags |= insn_flags;
 		return 0;
+	}
 
 	cnt++;
 	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
 	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
 	if (!p)
 		return -ENOMEM;
-	p[cnt - 1].idx = env->insn_idx;
-	p[cnt - 1].prev_idx = env->prev_insn_idx;
 	cur->jmp_history = p;
+
+	p = &cur->jmp_history[cnt - 1];
+	p->idx = env->insn_idx;
+	p->prev_idx = env->prev_insn_idx;
+	p->flags = insn_flags;
 	cur->jmp_history_cnt = cnt;
+	env->cur_hist_ent = p;
+
 	return 0;
 }
 
+static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_state *st,
+						        u32 hist_end, int insn_idx)
+{
+	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx == insn_idx)
+		return &st->jmp_history[hist_end - 1];
+	return NULL;
+}
+
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
  * Return -ENOENT if we exhausted all instructions within given state.
@@ -3591,9 +3629,14 @@ static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
 	return bt->reg_masks[bt->frame] & (1 << reg);
 }
 
+static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 frame, u32 slot)
+{
+	return bt->stack_masks[frame] & (1ull << slot);
+}
+
 static inline bool bt_is_slot_set(struct backtrack_state *bt, u32 slot)
 {
-	return bt->stack_masks[bt->frame] & (1ull << slot);
+	return bt_is_frame_slot_set(bt, bt->frame, slot);
 }
 
 /* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
@@ -3647,7 +3690,7 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
  *   - *was* processed previously during backtracking.
  */
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
-			  struct backtrack_state *bt)
+			  struct bpf_jmp_history_entry *hist, struct backtrack_state *bt)
 {
 	const struct bpf_insn_cbs cbs = {
 		.cb_call	= disasm_kfunc_name,
@@ -3660,7 +3703,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 	u8 mode = BPF_MODE(insn->code);
 	u32 dreg = insn->dst_reg;
 	u32 sreg = insn->src_reg;
-	u32 spi, i;
+	u32 spi, i, fr;
 
 	if (insn->code == 0)
 		return 0;
@@ -3723,20 +3766,15 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		 * by 'precise' mark in corresponding register of this state.
 		 * No further tracking necessary.
 		 */
-		if (insn->src_reg != BPF_REG_FP)
+		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
 			return 0;
-
 		/* dreg = *(u64 *)[fp - off] was a fill from the stack.
 		 * that [fp - off] slot contains scalar that needs to be
 		 * tracked with precision
 		 */
-		spi = (-insn->off - 1) / BPF_REG_SIZE;
-		if (spi >= 64) {
-			verbose(env, "BUG spi %d\n", spi);
-			WARN_ONCE(1, "verifier backtracking bug");
-			return -EFAULT;
-		}
-		bt_set_slot(bt, spi);
+		spi = insn_stack_access_spi(hist->flags);
+		fr = insn_stack_access_frameno(hist->flags);
+		bt_set_frame_slot(bt, fr, spi);
 	} else if (class == BPF_STX || class == BPF_ST) {
 		if (bt_is_reg_set(bt, dreg))
 			/* stx & st shouldn't be using _scalar_ dst_reg
@@ -3745,17 +3783,13 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 */
 			return -ENOTSUPP;
 		/* scalars can only be spilled into stack */
-		if (insn->dst_reg != BPF_REG_FP)
+		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
 			return 0;
-		spi = (-insn->off - 1) / BPF_REG_SIZE;
-		if (spi >= 64) {
-			verbose(env, "BUG spi %d\n", spi);
-			WARN_ONCE(1, "verifier backtracking bug");
-			return -EFAULT;
-		}
-		if (!bt_is_slot_set(bt, spi))
+		spi = insn_stack_access_spi(hist->flags);
+		fr = insn_stack_access_frameno(hist->flags);
+		if (!bt_is_frame_slot_set(bt, fr, spi))
 			return 0;
-		bt_clear_slot(bt, spi);
+		bt_clear_frame_slot(bt, fr, spi);
 		if (class == BPF_STX)
 			bt_set_reg(bt, sreg);
 	} else if (class == BPF_JMP || class == BPF_JMP32) {
@@ -3799,10 +3833,14 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					WARN_ONCE(1, "verifier backtracking bug");
 					return -EFAULT;
 				}
-				/* we don't track register spills perfectly,
-				 * so fallback to force-precise instead of failing */
-				if (bt_stack_mask(bt) != 0)
-					return -ENOTSUPP;
+				/* we are now tracking register spills correctly,
+				 * so any instance of leftover slots is a bug
+				 */
+				if (bt_stack_mask(bt) != 0) {
+					verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
+					WARN_ONCE(1, "verifier backtracking bug (subprog leftover stack slots)");
+					return -EFAULT;
+				}
 				/* propagate r1-r5 to the caller */
 				for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
 					if (bt_is_reg_set(bt, i)) {
@@ -3827,8 +3865,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				WARN_ONCE(1, "verifier backtracking bug");
 				return -EFAULT;
 			}
-			if (bt_stack_mask(bt) != 0)
-				return -ENOTSUPP;
+			if (bt_stack_mask(bt) != 0) {
+				verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
+				WARN_ONCE(1, "verifier backtracking bug (callback leftover stack slots)");
+				return -EFAULT;
+			}
 			/* clear r1-r5 in callback subprog's mask */
 			for (i = BPF_REG_1; i <= BPF_REG_5; i++)
 				bt_clear_reg(bt, i);
@@ -4265,6 +4306,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
 		u32 history = st->jmp_history_cnt;
+		struct bpf_jmp_history_entry *hist;
 
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_idx %d \n",
@@ -4328,7 +4370,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				err = 0;
 				skip_first = false;
 			} else {
-				err = backtrack_insn(env, i, subseq_idx, bt);
+				hist = get_jmp_hist_entry(st, history, i);
+				err = backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err == -ENOTSUPP) {
 				mark_all_scalars_precise(env, env->cur_state);
@@ -4381,22 +4424,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
 			for_each_set_bit(i, mask, 64) {
 				if (i >= func->allocated_stack / BPF_REG_SIZE) {
-					/* the sequence of instructions:
-					 * 2: (bf) r3 = r10
-					 * 3: (7b) *(u64 *)(r3 -8) = r0
-					 * 4: (79) r4 = *(u64 *)(r10 -8)
-					 * doesn't contain jmps. It's backtracked
-					 * as a single block.
-					 * During backtracking insn 3 is not recognized as
-					 * stack access, so at the end of backtracking
-					 * stack slot fp-8 is still marked in stack_mask.
-					 * However the parent state may not have accessed
-					 * fp-8 and it's "unallocated" stack space.
-					 * In such case fallback to conservative.
-					 */
-					mark_all_scalars_precise(env, env->cur_state);
-					bt_reset(bt);
-					return 0;
+					verbose(env, "BUG backtracking (stack slot %d, total slots %d)\n",
+						i, func->allocated_stack / BPF_REG_SIZE);
+					WARN_ONCE(1, "verifier backtracking bug (stack slot out of bounds)");
+					return -EFAULT;
 				}
 
 				if (!is_spilled_scalar_reg(&func->stack[i])) {
@@ -4561,7 +4592,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg = NULL;
-	u32 dst_reg = insn->dst_reg;
+	int insn_flags = insn_stack_access_flags(state->frameno, spi);
 
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
@@ -4599,17 +4630,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
-		if (dst_reg != BPF_REG_FP) {
-			/* The backtracking logic can only recognize explicit
-			 * stack slot address like [fp - 8]. Other spill of
-			 * scalar via different register has to be conservative.
-			 * Backtrack from here and mark all registers as precise
-			 * that contributed into 'reg' being a constant.
-			 */
-			err = mark_chain_precision(env, value_regno);
-			if (err)
-				return err;
-		}
 		save_register_state(state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
@@ -4621,6 +4641,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type = SCALAR_VALUE;
 		save_register_state(state, spi, &fake_reg, size);
+		insn_flags = 0; /* not a register spill */
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
@@ -4666,9 +4687,12 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 		/* Mark slots affected by this stack write. */
 		for (i = 0; i < size; i++)
-			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] =
-				type;
+			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] = type;
+		insn_flags = 0; /* not a register spill */
 	}
+
+	if (insn_flags)
+		return push_jmp_history(env, env->cur_state, insn_flags);
 	return 0;
 }
 
@@ -4857,6 +4881,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE;
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
+	int insn_flags = insn_stack_access_flags(reg_state->frameno, spi);
 
 	stype = reg_state->stack[spi].slot_type;
 	reg = &reg_state->stack[spi].spilled_ptr;
@@ -4902,12 +4927,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					return -EACCES;
 				}
 				mark_reg_unknown(env, state->regs, dst_regno);
+				insn_flags = 0; /* not restoring original register state */
 			}
 			state->regs[dst_regno].live |= REG_LIVE_WRITTEN;
-			return 0;
-		}
-
-		if (dst_regno >= 0) {
+		} else if (dst_regno >= 0) {
 			/* restore register state from stack */
 			copy_register_state(&state->regs[dst_regno], reg);
 			/* mark reg as written since spilled pointer state likely
@@ -4943,7 +4966,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 		if (dst_regno >= 0)
 			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
+		insn_flags = 0; /* we are not restoring spilled register */
 	}
+	if (insn_flags)
+		return push_jmp_history(env, env->cur_state, insn_flags);
 	return 0;
 }
 
@@ -7027,7 +7053,6 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
-
 	return 0;
 }
 
@@ -16773,7 +16798,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * the precision needs to be propagated back in
 			 * the current state.
 			 */
-			err = err ? : push_jmp_history(env, cur);
+			if (is_jmp_point(env, env->insn_idx))
+				err = err ? : push_jmp_history(env, cur, 0);
 			err = err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -16997,6 +17023,9 @@ static int do_check(struct bpf_verifier_env *env)
 		u8 class;
 		int err;
 
+		/* reset current history entry on each new instruction */
+		env->cur_hist_ent = NULL;
+
 		env->prev_insn_idx = prev_insn_idx;
 		if (env->insn_idx >= insn_cnt) {
 			verbose(env, "invalid insn idx %d insn_cnt %d\n",
@@ -17036,7 +17065,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (is_jmp_point(env, env->insn_idx)) {
-			err = push_jmp_history(env, state);
+			err = push_jmp_history(env, state, 0);
 			if (err)
 				return err;
 		}
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index f61d623b1ce8..f87365f7599b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -541,11 +541,24 @@ static __u64 subprog_spill_reg_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-/* precision backtracking can't currently handle stack access not through r10,
- * so we won't be able to mark stack slot fp-8 as precise, and so will
- * fallback to forcing all as precise
- */
-__msg("mark_precise: frame0: falling back to forcing all scalars precise")
+__msg("10: (0f) r1 += r7")
+__msg("mark_precise: frame0: last_idx 10 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r7 stack= before 9: (bf) r1 = r8")
+__msg("mark_precise: frame0: regs=r7 stack= before 8: (27) r7 *= 4")
+__msg("mark_precise: frame0: regs=r7 stack= before 7: (79) r7 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: parent state regs= stack=-8:  R0_w=2 R6_w=1 R8_rw=map_value(map=.data.vals,ks=4,vs=16) R10=fp0 fp-8_rw=P1")
+__msg("mark_precise: frame0: last_idx 18 first_idx 0 subseq_idx 7")
+__msg("mark_precise: frame0: regs= stack=-8 before 18: (95) exit")
+__msg("mark_precise: frame1: regs= stack= before 17: (0f) r0 += r2")
+__msg("mark_precise: frame1: regs= stack= before 16: (79) r2 = *(u64 *)(r1 +0)")
+__msg("mark_precise: frame1: regs= stack= before 15: (79) r0 = *(u64 *)(r10 -16)")
+__msg("mark_precise: frame1: regs= stack= before 14: (7b) *(u64 *)(r10 -16) = r2")
+__msg("mark_precise: frame1: regs= stack= before 13: (7b) *(u64 *)(r1 +0) = r2")
+__msg("mark_precise: frame1: regs=r2 stack= before 6: (85) call pc+6")
+__msg("mark_precise: frame0: regs=r2 stack= before 5: (bf) r2 = r6")
+__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
+__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
+__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 1")
 __naked int subprog_spill_into_parent_stack_slot_precise(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 0d84dd1f38b6..8a2ff81d8350 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -140,10 +140,11 @@
 	.result = REJECT,
 },
 {
-	"precise: ST insn causing spi > allocated_stack",
+	"precise: ST zero to stack insn is supported",
 	.insns = {
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
+	/* not a register spill, so we stop precision propagation for R4 here */
 	BPF_ST_MEM(BPF_DW, BPF_REG_3, -8, 0),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
 	BPF_MOV64_IMM(BPF_REG_0, -1),
@@ -157,11 +158,11 @@
 	mark_precise: frame0: last_idx 4 first_idx 2\
 	mark_precise: frame0: regs=r4 stack= before 4\
 	mark_precise: frame0: regs=r4 stack= before 3\
-	mark_precise: frame0: regs= stack=-8 before 2\
-	mark_precise: frame0: falling back to forcing all scalars precise\
-	force_precise: frame0: forcing r0 to be precise\
 	mark_precise: frame0: last_idx 5 first_idx 5\
-	mark_precise: frame0: parent state regs= stack=:",
+	mark_precise: frame0: parent state regs=r0 stack=:\
+	mark_precise: frame0: last_idx 4 first_idx 2\
+	mark_precise: frame0: regs=r0 stack= before 4\
+	5: R0=-1 R4=0",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
@@ -169,6 +170,8 @@
 	"precise: STX insn causing spi > allocated_stack",
 	.insns = {
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
+	/* make later reg spill more interesting by having somewhat known scalar */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xff),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, -8),
@@ -179,18 +182,21 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "mark_precise: frame0: last_idx 6 first_idx 6\
+	.errstr = "mark_precise: frame0: last_idx 7 first_idx 7\
 	mark_precise: frame0: parent state regs=r4 stack=:\
-	mark_precise: frame0: last_idx 5 first_idx 3\
-	mark_precise: frame0: regs=r4 stack= before 5\
-	mark_precise: frame0: regs=r4 stack= before 4\
-	mark_precise: frame0: regs= stack=-8 before 3\
-	mark_precise: frame0: falling back to forcing all scalars precise\
-	force_precise: frame0: forcing r0 to be precise\
-	force_precise: frame0: forcing r0 to be precise\
-	force_precise: frame0: forcing r0 to be precise\
-	force_precise: frame0: forcing r0 to be precise\
-	mark_precise: frame0: last_idx 6 first_idx 6\
+	mark_precise: frame0: last_idx 6 first_idx 4\
+	mark_precise: frame0: regs=r4 stack= before 6: (b7) r0 = -1\
+	mark_precise: frame0: regs=r4 stack= before 5: (79) r4 = *(u64 *)(r10 -8)\
+	mark_precise: frame0: regs= stack=-8 before 4: (7b) *(u64 *)(r3 -8) = r0\
+	mark_precise: frame0: parent state regs=r0 stack=:\
+	mark_precise: frame0: last_idx 3 first_idx 3\
+	mark_precise: frame0: regs=r0 stack= before 3: (55) if r3 != 0x7b goto pc+0\
+	mark_precise: frame0: regs=r0 stack= before 2: (bf) r3 = r10\
+	mark_precise: frame0: regs=r0 stack= before 1: (57) r0 &= 255\
+	mark_precise: frame0: parent state regs=r0 stack=:\
+	mark_precise: frame0: last_idx 0 first_idx 0\
+	mark_precise: frame0: regs=r0 stack= before 0: (85) call bpf_get_prandom_u32#7\
+	mark_precise: frame0: last_idx 7 first_idx 7\
 	mark_precise: frame0: parent state regs= stack=:",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
-- 
2.47.0


