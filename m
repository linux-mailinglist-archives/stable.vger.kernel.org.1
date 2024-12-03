Return-Path: <stable+bounces-96771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2D9E2ACC
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67DCBBA1779
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415431F7591;
	Tue,  3 Dec 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p9hrABiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F21F6698;
	Tue,  3 Dec 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238546; cv=none; b=A9UBC4mOKeZ6LhYrsXCAzZa4ue4ME6Q18Fmt7so2WYFAQ3s8WXdX3V/h7NqkCi/FUuqX8FVUp85f7gYQmHho5xqSqzjfmhvxSHGTE4ly6paAng7omNnzKTyRBAsXb5KbPTRQg9+rakv+bl73MlmHlBqODfDJrEbyOzuBePCNXEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238546; c=relaxed/simple;
	bh=G0RNR+Hg5vwKVg2zDDKDNJT0/bxd4pAQKIIfkLzA9As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwpzgLlcI3LqvlPy3NLmavtQ3i5Q9wTJH48WVlyygIrAK6ZP9czVIC9NvL9Nt7c+dLVOtfe0Sztw46SFFcDxhfeNXRjA+Yt9xg/bBk8lwLZ5dq8fb6Hb224Vwp+Pf8FQqtG0c/LJ7Kl5Hsd9WsdxKd0Ez2JaAXfOtIIT2uzuzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p9hrABiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FC7C4CED6;
	Tue,  3 Dec 2024 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238545;
	bh=G0RNR+Hg5vwKVg2zDDKDNJT0/bxd4pAQKIIfkLzA9As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9hrABiyHC9g5EJwcU7KHZLIzyAH1li45B3cUVd+p+uYC1XOBzRVj9K9aUvFj2Raa
	 /rZ1AEAHGnYCn8e1fibGFFJM5kEb9pNt3Y0fpjs6P36BZs7uAz0kieHmhW4hw5ag+F
	 +yjGoCWfHV29778OLCWqqBgFkxmODhgjWCSQuQqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Olsa <jolsa@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 315/817] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
Date: Tue,  3 Dec 2024 15:38:07 +0100
Message-ID: <20241203144008.112320435@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit cb4158ce8ec8a5bb528cc1693356a5eb8058094d ]

Arguments to a raw tracepoint are tagged as trusted, which carries the
semantics that the pointer will be non-NULL.  However, in certain cases,
a raw tracepoint argument may end up being NULL. More context about this
issue is available in [0].

Thus, there is a discrepancy between the reality, that raw_tp arguments
can actually be NULL, and the verifier's knowledge, that they are never
NULL, causing explicit NULL checks to be deleted, and accesses to such
pointers potentially crashing the kernel.

To fix this, mark raw_tp arguments as PTR_MAYBE_NULL, and then special
case the dereference and pointer arithmetic to permit it, and allow
passing them into helpers/kfuncs; these exceptions are made for raw_tp
programs only. Ensure that we don't do this when ref_obj_id > 0, as in
that case this is an acquired object and doesn't need such adjustment.

The reason we do mask_raw_tp_trusted_reg logic is because other will
recheck in places whether the register is a trusted_reg, and then
consider our register as untrusted when detecting the presence of the
PTR_MAYBE_NULL flag.

To allow safe dereference, we enable PROBE_MEM marking when we see loads
into trusted pointers with PTR_MAYBE_NULL.

While trusted raw_tp arguments can also be passed into helpers or kfuncs
where such broken assumption may cause issues, a future patch set will
tackle their case separately, as PTR_TO_BTF_ID (without PTR_TRUSTED) can
already be passed into helpers and causes similar problems. Thus, they
are left alone for now.

It is possible that these checks also permit passing non-raw_tp args
that are trusted PTR_TO_BTF_ID with null marking. In such a case,
allowing dereference when pointer is NULL expands allowed behavior, so
won't regress existing programs, and the case of passing these into
helpers is the same as above and will be dealt with later.

Also update the failure case in tp_btf_nullable selftest to capture the
new behavior, as the verifier will no longer cause an error when
directly dereference a raw tracepoint argument marked as __nullable.

  [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20241104171959.2938862-2-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h                           |  6 ++
 kernel/bpf/btf.c                              |  5 +-
 kernel/bpf/verifier.c                         | 79 +++++++++++++++++--
 .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
 4 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb1d3a2fe3339..75b4117454b45 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3436,4 +3436,10 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+static inline bool bpf_prog_is_raw_tp(const struct bpf_prog *prog)
+{
+	return prog->type == BPF_PROG_TYPE_TRACING &&
+	       prog->expected_attach_type == BPF_TRACE_RAW_TP;
+}
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 76afa90814ddb..8608d24369f01 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6534,7 +6534,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (prog_args_trusted(prog))
 		info->reg_type |= PTR_TRUSTED;
 
-	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
+	/* Raw tracepoint arguments always get marked as maybe NULL */
+	if (bpf_prog_is_raw_tp(prog))
+		info->reg_type |= PTR_MAYBE_NULL;
+	else if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
 		info->reg_type |= PTR_MAYBE_NULL;
 
 	if (tgt_prog) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0481915e63c21..b34a358c75e0f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -423,6 +423,25 @@ static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
 	return rec;
 }
 
+static bool mask_raw_tp_reg_cond(const struct bpf_verifier_env *env, struct bpf_reg_state *reg) {
+	return reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL) &&
+	       bpf_prog_is_raw_tp(env->prog) && !reg->ref_obj_id;
+}
+
+static bool mask_raw_tp_reg(const struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	if (!mask_raw_tp_reg_cond(env, reg))
+		return false;
+	reg->type &= ~PTR_MAYBE_NULL;
+	return true;
+}
+
+static void unmask_raw_tp_reg(struct bpf_reg_state *reg, bool result)
+{
+	if (result)
+		reg->type |= PTR_MAYBE_NULL;
+}
+
 static bool subprog_is_global(const struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_func_info_aux *aux = env->prog->aux->func_info_aux;
@@ -6513,6 +6532,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	const char *field_name = NULL;
 	enum bpf_type_flag flag = 0;
 	u32 btf_id = 0;
+	bool mask;
 	int ret;
 
 	if (!env->allow_ptr_leaks) {
@@ -6584,7 +6604,21 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 
 	if (ret < 0)
 		return ret;
-
+	/* For raw_tp progs, we allow dereference of PTR_MAYBE_NULL
+	 * trusted PTR_TO_BTF_ID, these are the ones that are possibly
+	 * arguments to the raw_tp. Since internal checks in for trusted
+	 * reg in check_ptr_to_btf_access would consider PTR_MAYBE_NULL
+	 * modifier as problematic, mask it out temporarily for the
+	 * check. Don't apply this to pointers with ref_obj_id > 0, as
+	 * those won't be raw_tp args.
+	 *
+	 * We may end up applying this relaxation to other trusted
+	 * PTR_TO_BTF_ID with maybe null flag, since we cannot
+	 * distinguish PTR_MAYBE_NULL tagged for arguments vs normal
+	 * tagging, but that should expand allowed behavior, and not
+	 * cause regression for existing behavior.
+	 */
+	mask = mask_raw_tp_reg(env, reg);
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
@@ -6645,8 +6679,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		clear_trusted_flags(&flag);
 	}
 
-	if (atype == BPF_READ && value_regno >= 0)
+	if (atype == BPF_READ && value_regno >= 0) {
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
+		/* We've assigned a new type to regno, so don't undo masking. */
+		if (regno == value_regno)
+			mask = false;
+	}
+	unmask_raw_tp_reg(reg, mask);
 
 	return 0;
 }
@@ -7021,7 +7060,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (base_type(reg->type) == PTR_TO_BTF_ID &&
-		   !type_may_be_null(reg->type)) {
+		   (mask_raw_tp_reg_cond(env, reg) || !type_may_be_null(reg->type))) {
 		err = check_ptr_to_btf_access(env, regs, regno, off, size, t,
 					      value_regno);
 	} else if (reg->type == CONST_PTR_TO_MAP) {
@@ -8685,6 +8724,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
 	int err = 0;
+	bool mask;
 
 	if (arg_type == ARG_DONTCARE)
 		return 0;
@@ -8725,11 +8765,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
+	mask = mask_raw_tp_reg(env, reg);
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
-	if (err)
-		return err;
 
-	err = check_func_arg_reg_off(env, reg, regno, arg_type);
+	err = err ?: check_func_arg_reg_off(env, reg, regno, arg_type);
+	unmask_raw_tp_reg(reg, mask);
 	if (err)
 		return err;
 
@@ -9524,14 +9564,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
 			struct bpf_call_arg_meta meta;
+			bool mask;
 			int err;
 
 			if (register_is_null(reg) && type_may_be_null(arg->arg_type))
 				continue;
 
 			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
+			mask = mask_raw_tp_reg(env, reg);
 			err = check_reg_type(env, regno, arg->arg_type, &arg->btf_id, &meta);
 			err = err ?: check_func_arg_reg_off(env, reg, regno, arg->arg_type);
+			unmask_raw_tp_reg(reg, mask);
 			if (err)
 				return err;
 		} else {
@@ -11836,6 +11879,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		enum bpf_arg_type arg_type = ARG_DONTCARE;
 		u32 regno = i + 1, ref_id, type_size;
 		bool is_ret_buf_sz = false;
+		bool mask = false;
 		int kf_arg_type;
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
@@ -11894,12 +11938,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
+		mask = mask_raw_tp_reg(env, reg);
 		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
 		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
 			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
+			unmask_raw_tp_reg(reg, mask);
 			return -EACCES;
 		}
+		unmask_raw_tp_reg(reg, mask);
 
 		if (reg->ref_obj_id) {
 			if (is_kfunc_release(meta) && meta->ref_obj_id) {
@@ -11957,16 +12004,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
 				break;
 
+			/* Allow passing maybe NULL raw_tp arguments to
+			 * kfuncs for compatibility. Don't apply this to
+			 * arguments with ref_obj_id > 0.
+			 */
+			mask = mask_raw_tp_reg(env, reg);
 			if (!is_trusted_reg(reg)) {
 				if (!is_kfunc_rcu(meta)) {
 					verbose(env, "R%d must be referenced or trusted\n", regno);
+					unmask_raw_tp_reg(reg, mask);
 					return -EINVAL;
 				}
 				if (!is_rcu_reg(reg)) {
 					verbose(env, "R%d must be a rcu pointer\n", regno);
+					unmask_raw_tp_reg(reg, mask);
 					return -EINVAL;
 				}
 			}
+			unmask_raw_tp_reg(reg, mask);
 			fallthrough;
 		case KF_ARG_PTR_TO_CTX:
 		case KF_ARG_PTR_TO_DYNPTR:
@@ -11989,7 +12044,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 		if (is_kfunc_release(meta) && reg->ref_obj_id)
 			arg_type |= OBJ_RELEASE;
+		mask = mask_raw_tp_reg(env, reg);
 		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
+		unmask_raw_tp_reg(reg, mask);
 		if (ret < 0)
 			return ret;
 
@@ -12165,6 +12222,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 			fallthrough;
 		case KF_ARG_PTR_TO_BTF_ID:
+			mask = mask_raw_tp_reg(env, reg);
 			/* Only base_type is checked, further checks are done here */
 			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
 			     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) &&
@@ -12173,9 +12231,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "expected %s or socket\n",
 					reg_type_str(env, base_type(reg->type) |
 							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
+				unmask_raw_tp_reg(reg, mask);
 				return -EINVAL;
 			}
 			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
+			unmask_raw_tp_reg(reg, mask);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13145,7 +13205,7 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
  */
 static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
-				   const struct bpf_reg_state *ptr_reg,
+				   struct bpf_reg_state *ptr_reg,
 				   const struct bpf_reg_state *off_reg)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
@@ -13159,6 +13219,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_sanitize_info info = {};
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
+	bool mask;
 	int ret;
 
 	dst_reg = &regs[dst];
@@ -13185,11 +13246,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	mask = mask_raw_tp_reg(env, ptr_reg);
 	if (ptr_reg->type & PTR_MAYBE_NULL) {
 		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
 			dst, reg_type_str(env, ptr_reg->type));
+		unmask_raw_tp_reg(ptr_reg, mask);
 		return -EACCES;
 	}
+	unmask_raw_tp_reg(ptr_reg, mask);
 
 	switch (base_type(ptr_reg->type)) {
 	case PTR_TO_CTX:
@@ -19330,6 +19394,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		 * for this case.
 		 */
 		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
+		case PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL:
 			if (type == BPF_READ) {
 				if (BPF_MODE(insn->code) == BPF_MEM)
 					insn->code = BPF_LDX | BPF_PROBE_MEM |
diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
index bba3e37f749b8..5aaf2b065f86c 100644
--- a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
+++ b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
@@ -7,7 +7,11 @@
 #include "bpf_misc.h"
 
 SEC("tp_btf/bpf_testmod_test_nullable_bare")
-__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+/* This used to be a failure test, but raw_tp nullable arguments can now
+ * directly be dereferenced, whether they have nullable annotation or not,
+ * and don't need to be explicitly checked.
+ */
+__success
 int BPF_PROG(handle_tp_btf_nullable_bare1, struct bpf_testmod_test_read_ctx *nullable_ctx)
 {
 	return nullable_ctx->len;
-- 
2.43.0




