Return-Path: <stable+bounces-41250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE738AFAE6
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911691C23B20
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C31014AD3B;
	Tue, 23 Apr 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YlYHSqr8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59B143895;
	Tue, 23 Apr 2024 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908780; cv=none; b=gC8xW5jTrD1PHc9gpe5jZWU/ZLYwPtVW8Erwx76sm1RczCqJEkvD0TEKbd/EOCSWKMD/iTckGH252q+1B7rq/yEts/Rlf5s9Ajmq6N3MtX2Sor5YJPwLMqf6uUJcDisErRyp0JdzGT01imLOCE8xwStdZy4+M1d8X5xgOwXIPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908780; c=relaxed/simple;
	bh=UcGgZjzbaiVO7XpSmx17tosa79ZtiPxm3QBqmGxf2rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4O8D3ZhFjArTPChcEG1NqChCAOA7zEjmri2EKsx3wAazrKcXDZ3wmf0RhqXbMd0D/p0bgMSBr7Ldl+mNCiWuKcCZARwzNcJi6ZecOMxfbPfE0mLLG7Qe9vMSmhZ6aPE8kZzDokKjxyGY8OgVeccGo/WacCKZhqEBPzOI3qEaGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YlYHSqr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B246DC116B1;
	Tue, 23 Apr 2024 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908779;
	bh=UcGgZjzbaiVO7XpSmx17tosa79ZtiPxm3QBqmGxf2rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YlYHSqr8dsAojUYHkBgUk/NgP1z77MGGhx0miHsyMPIb2DOYhhmXk0/JQOnMSaHCG
	 hlwSWU0f56sBaeu+PZtqUXMPlRJkTxLyaFmQgmS1uvVsGPEFMPgsJFKQ/ABSj1nD3N
	 FiX7m1dsRvb3l2chOex17czqyCm1Gi5VLv9ETZi8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Edward Liaw <edliaw@google.com>
Subject: [PATCH 5.15 07/71] bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support
Date: Tue, 23 Apr 2024 14:39:20 -0700
Message-ID: <20240423213844.374218660@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: <20240423213844.122920086@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

commit 3363bd0cfbb80dfcd25003cd3815b0ad8b68d0ff upstream.

Allow passing PTR_TO_CTX, if the kfunc expects a matching struct type,
and punt to PTR_TO_MEM block if reg->type does not fall in one of
PTR_TO_BTF_ID or PTR_TO_SOCK* types. This will be used by future commits
to get access to XDP and TC PTR_TO_CTX, and pass various data (flags,
l4proto, netns_id, etc.) encoded in opts struct passed as pointer to
kfunc.

For PTR_TO_MEM support, arguments are currently limited to pointer to
scalar, or pointer to struct composed of scalars. This is done so that
unsafe scenarios (like passing PTR_TO_MEM where PTR_TO_BTF_ID of
in-kernel valid structure is expected, which may have pointers) are
avoided. Since the argument checking happens basd on argument register
type, it is not easy to ascertain what the expected type is. In the
future, support for PTR_TO_MEM for kfunc can be extended to serve other
usecases. The struct type whose pointer is passed in may have maximum
nesting depth of 4, all recursively composed of scalars or struct with
scalars.

Future commits will add negative tests that check whether these
restrictions imposed for kfunc arguments are duly rejected by BPF
verifier or not.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20211217015031.1278167-4-memxor@gmail.com
Signed-off-by: Edward Liaw <edliaw@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/btf.c |   93 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 20 deletions(-)

--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5447,6 +5447,46 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_M
 #endif
 };
 
+/* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
+static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
+					const struct btf *btf,
+					const struct btf_type *t, int rec)
+{
+	const struct btf_type *member_type;
+	const struct btf_member *member;
+	u32 i;
+
+	if (!btf_type_is_struct(t))
+		return false;
+
+	for_each_member(i, t, member) {
+		const struct btf_array *array;
+
+		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
+		if (btf_type_is_struct(member_type)) {
+			if (rec >= 3) {
+				bpf_log(log, "max struct nesting depth exceeded\n");
+				return false;
+			}
+			if (!__btf_type_is_scalar_struct(log, btf, member_type, rec + 1))
+				return false;
+			continue;
+		}
+		if (btf_type_is_array(member_type)) {
+			array = btf_type_array(member_type);
+			if (!array->nelems)
+				return false;
+			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
+			if (!btf_type_is_scalar(member_type))
+				return false;
+			continue;
+		}
+		if (!btf_type_is_scalar(member_type))
+			return false;
+	}
+	return true;
+}
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
@@ -5455,6 +5495,7 @@ static int btf_check_func_arg_match(stru
 	enum bpf_prog_type prog_type = env->prog->type == BPF_PROG_TYPE_EXT ?
 		env->prog->aux->dst_prog->type : env->prog->type;
 	struct bpf_verifier_log *log = &env->log;
+	bool is_kfunc = btf_is_kernel(btf);
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
@@ -5507,7 +5548,20 @@ static int btf_check_func_arg_match(stru
 
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
-		if (btf_is_kernel(btf)) {
+		if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+			/* If function expects ctx type in BTF check that caller
+			 * is passing PTR_TO_CTX.
+			 */
+			if (reg->type != PTR_TO_CTX) {
+				bpf_log(log,
+					"arg#%d expected pointer to ctx, but got %s\n",
+					i, btf_type_str(t));
+				return -EINVAL;
+			}
+			if (check_ctx_reg(env, reg, regno))
+				return -EINVAL;
+		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
+			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
 			const struct btf_type *reg_ref_t;
 			const struct btf *reg_btf;
 			const char *reg_ref_tname;
@@ -5523,14 +5577,9 @@ static int btf_check_func_arg_match(stru
 			if (reg->type == PTR_TO_BTF_ID) {
 				reg_btf = reg->btf;
 				reg_ref_id = reg->btf_id;
-			} else if (reg2btf_ids[base_type(reg->type)]) {
+			} else {
 				reg_btf = btf_vmlinux;
 				reg_ref_id = *reg2btf_ids[base_type(reg->type)];
-			} else {
-				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s but R%d is not a pointer to btf_id\n",
-					func_name, i,
-					btf_type_str(ref_t), ref_tname, regno);
-				return -EINVAL;
 			}
 
 			reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id,
@@ -5546,22 +5595,24 @@ static int btf_check_func_arg_match(stru
 					reg_ref_tname);
 				return -EINVAL;
 			}
-		} else if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
-			/* If function expects ctx type in BTF check that caller
-			 * is passing PTR_TO_CTX.
-			 */
-			if (reg->type != PTR_TO_CTX) {
-				bpf_log(log,
-					"arg#%d expected pointer to ctx, but got %s\n",
-					i, btf_type_str(t));
-				return -EINVAL;
-			}
-			if (check_ctx_reg(env, reg, regno))
-				return -EINVAL;
 		} else if (ptr_to_mem_ok) {
 			const struct btf_type *resolve_ret;
 			u32 type_size;
 
+			if (is_kfunc) {
+				/* Permit pointer to mem, but only when argument
+				 * type is pointer to scalar, or struct composed
+				 * (recursively) of scalars.
+				 */
+				if (!btf_type_is_scalar(ref_t) &&
+				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0)) {
+					bpf_log(log,
+						"arg#%d pointer type %s %s must point to scalar or struct with scalar\n",
+						i, btf_type_str(ref_t), ref_tname);
+					return -EINVAL;
+				}
+			}
+
 			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
 			if (IS_ERR(resolve_ret)) {
 				bpf_log(log,
@@ -5574,6 +5625,8 @@ static int btf_check_func_arg_match(stru
 			if (check_mem_reg(env, reg, regno, type_size))
 				return -EINVAL;
 		} else {
+			bpf_log(log, "reg type unsupported for arg#%d %sfunction %s#%d\n", i,
+				is_kfunc ? "kernel " : "", func_name, func_id);
 			return -EINVAL;
 		}
 	}
@@ -5623,7 +5676,7 @@ int btf_check_kfunc_arg_match(struct bpf
 			      const struct btf *btf, u32 func_id,
 			      struct bpf_reg_state *regs)
 {
-	return btf_check_func_arg_match(env, btf, func_id, regs, false);
+	return btf_check_func_arg_match(env, btf, func_id, regs, true);
 }
 
 /* Convert BTF of a function into bpf_reg_state if possible



