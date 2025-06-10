Return-Path: <stable+bounces-152304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 179C3AD3B91
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C35E172E6B
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4461D90C8;
	Tue, 10 Jun 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvhRjXwO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED9153598
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566726; cv=none; b=BHZRtAOwyYOhHCo4NmluSJSHGGZ1Qp8sXQSak8nGQam5pScHgaK12vbrDuK94dkMuBTIYRIwk4Mymo0hNq0te9d7bdAaVhiNv77vlknlmr6xwi9DG5co2MMLyzEtlX/SPTp/+RK0Mw8R3e9vM6tyfFc8H4EO2f9lX/bfcUBWVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566726; c=relaxed/simple;
	bh=4xR3jN+xn5h+mD8c/C5YCDnydGtoQ5psjhiVacBmlSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8sLRv5m0Y4esGlDevuGxQkdhC1O/9wv6FeMuIvStrDBlNpEWyYJHmk6bPzMOq/RU6dXlbyquEhCeSJVbKgtv8gDwsQLYPPNelc+NyW/CUCkfAi+YgKMxinIESwkMncMyxhqEK3uZGdpl75bRCC1HpA6d2HAhcfPRdG9O7JcRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvhRjXwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3869C4CEED;
	Tue, 10 Jun 2025 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749566726;
	bh=4xR3jN+xn5h+mD8c/C5YCDnydGtoQ5psjhiVacBmlSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvhRjXwOUKGSK84uXwXXSMiu6M89Irgv75dUcGygfud5PXwjSG7wEKfyemza4szIb
	 +zgO6AlyX/zKmaB/21TAQMiZ4q9RnYqRZcEo4SSSMKe1vjBsNN1MvY6mY3Z1fRwjmz
	 HUpc4mHDZSMspjqZmUSWw+QMN/N0TUXnhPoxvoHE8/H/8uSBNmrTN1tdwZfLFBDgD6
	 7gZrGsGr/KXF1si70BfkODlAcuO7KXTjyeUMzegC5gOs+IvgTXTUlc+exbEJO5vZFB
	 zqHmpdZRsFR2cZ399l/18GLHODpMivkCAZe/biDOLuqoWuDiJvWQLRC9boV0A6zBjf
	 TGnB2Bz+hHzuw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hao Luo <haoluo@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH stable linux-5.10.y v1 3/8] bpf: Replace RET_XXX_OR_NULL with RET_XXX | PTR_MAYBE_NULL
Date: Tue, 10 Jun 2025 14:43:58 +0000
Message-ID: <20250610144407.95865-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610144407.95865-1-puranjay@kernel.org>
References: <20250610144407.95865-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Luo <haoluo@google.com>

commit 3c4807322660d4290ac9062c034aed6b87243861 upstream.

We have introduced a new type to make bpf_ret composable, by
reserving high bits to represent flags.

One of the flag is PTR_MAYBE_NULL, which indicates a pointer
may be NULL. When applying this flag to ret_types, it means
the returned value could be a NULL pointer. This patch
switches the qualified arg_types to use this flag.
The ret_types changed in this patch include:

1. RET_PTR_TO_MAP_VALUE_OR_NULL
2. RET_PTR_TO_SOCKET_OR_NULL
3. RET_PTR_TO_TCP_SOCK_OR_NULL
4. RET_PTR_TO_SOCK_COMMON_OR_NULL
5. RET_PTR_TO_ALLOC_MEM_OR_NULL
6. RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL
7. RET_PTR_TO_BTF_ID_OR_NULL

This patch doesn't eliminate the use of these names, instead
it makes them aliases to 'RET_PTR_TO_XXX | PTR_MAYBE_NULL'.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/bpf/20211217003152.48334-4-haoluo@google.com
Cc: stable@vger.kernel.org # 5.10.x
---
 include/linux/bpf.h   | 20 +++++++++++-------
 kernel/bpf/helpers.c  |  2 +-
 kernel/bpf/verifier.c | 49 +++++++++++++++++++++++--------------------
 3 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 55d6bf94e6eb..ce0ff9e78263 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -343,16 +343,22 @@ enum bpf_return_type {
 	RET_INTEGER,			/* function returns integer */
 	RET_VOID,			/* function doesn't return anything */
 	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
-	RET_PTR_TO_MAP_VALUE_OR_NULL,	/* returns a pointer to map elem value or NULL */
-	RET_PTR_TO_SOCKET_OR_NULL,	/* returns a pointer to a socket or NULL */
-	RET_PTR_TO_TCP_SOCK_OR_NULL,	/* returns a pointer to a tcp_sock or NULL */
-	RET_PTR_TO_SOCK_COMMON_OR_NULL,	/* returns a pointer to a sock_common or NULL */
-	RET_PTR_TO_ALLOC_MEM_OR_NULL,	/* returns a pointer to dynamically allocated memory or NULL */
-	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
-	RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a valid memory or a btf_id or NULL */
+	RET_PTR_TO_SOCKET,		/* returns a pointer to a socket */
+	RET_PTR_TO_TCP_SOCK,		/* returns a pointer to a tcp_sock */
+	RET_PTR_TO_SOCK_COMMON,		/* returns a pointer to a sock_common */
+	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated memory */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
+	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
 	__BPF_RET_TYPE_MAX,
 
+	/* Extended ret_types. */
+	RET_PTR_TO_MAP_VALUE_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_MAP_VALUE,
+	RET_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
+	RET_PTR_TO_TCP_SOCK_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
+	RET_PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
+	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
+	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
+
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
 	 */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 238a51daefa4..60ae9fcd9473 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -653,7 +653,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 	.func		= bpf_per_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 	.arg2_type	= ARG_ANYTHING,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fdcb42fe4303..2df320c6e641 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5555,6 +5555,7 @@ static int check_reference_leak(struct bpf_verifier_env *env)
 static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn_idx)
 {
 	const struct bpf_func_proto *fn = NULL;
+	enum bpf_return_type ret_type;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
 	bool changes_data;
@@ -5666,13 +5667,13 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 
 	/* update return register (already marked as written above) */
-	if (fn->ret_type == RET_INTEGER) {
+	ret_type = fn->ret_type;
+	if (ret_type == RET_INTEGER) {
 		/* sets type to SCALAR_VALUE */
 		mark_reg_unknown(env, regs, BPF_REG_0);
-	} else if (fn->ret_type == RET_VOID) {
+	} else if (ret_type == RET_VOID) {
 		regs[BPF_REG_0].type = NOT_INIT;
-	} else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL ||
-		   fn->ret_type == RET_PTR_TO_MAP_VALUE) {
+	} else if (base_type(ret_type) == RET_PTR_TO_MAP_VALUE) {
 		/* There is no offset yet applied, variable or fixed */
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		/* remember map_ptr, so that check_map_access()
@@ -5685,28 +5686,27 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 			return -EINVAL;
 		}
 		regs[BPF_REG_0].map_ptr = meta.map_ptr;
-		if (fn->ret_type == RET_PTR_TO_MAP_VALUE) {
+		if (type_may_be_null(ret_type)) {
+			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
+		} else {
 			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
 			if (map_value_has_spin_lock(meta.map_ptr))
 				regs[BPF_REG_0].id = ++env->id_gen;
-		} else {
-			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
 		}
-	} else if (fn->ret_type == RET_PTR_TO_SOCKET_OR_NULL) {
+	} else if (base_type(ret_type) == RET_PTR_TO_SOCKET) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_SOCKET_OR_NULL;
-	} else if (fn->ret_type == RET_PTR_TO_SOCK_COMMON_OR_NULL) {
+	} else if (base_type(ret_type) == RET_PTR_TO_SOCK_COMMON) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_SOCK_COMMON_OR_NULL;
-	} else if (fn->ret_type == RET_PTR_TO_TCP_SOCK_OR_NULL) {
+	} else if (base_type(ret_type) == RET_PTR_TO_TCP_SOCK) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK_OR_NULL;
-	} else if (fn->ret_type == RET_PTR_TO_ALLOC_MEM_OR_NULL) {
+	} else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_MEM_OR_NULL;
 		regs[BPF_REG_0].mem_size = meta.mem_size;
-	} else if (fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL ||
-		   fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID) {
+	} else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
 		const struct btf_type *t;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
@@ -5725,30 +5725,33 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 				return -EINVAL;
 			}
 			regs[BPF_REG_0].type =
-				fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
-				PTR_TO_MEM : PTR_TO_MEM_OR_NULL;
+				(ret_type & PTR_MAYBE_NULL) ?
+				PTR_TO_MEM_OR_NULL : PTR_TO_MEM;
 			regs[BPF_REG_0].mem_size = tsize;
 		} else {
 			regs[BPF_REG_0].type =
-				fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
-				PTR_TO_BTF_ID : PTR_TO_BTF_ID_OR_NULL;
+				(ret_type & PTR_MAYBE_NULL) ?
+				PTR_TO_BTF_ID_OR_NULL : PTR_TO_BTF_ID;
 			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
 		}
-	} else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL) {
+	} else if (base_type(ret_type) == RET_PTR_TO_BTF_ID) {
 		int ret_btf_id;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type = PTR_TO_BTF_ID_OR_NULL;
+		regs[BPF_REG_0].type = (ret_type & PTR_MAYBE_NULL) ?
+					PTR_TO_BTF_ID_OR_NULL :
+					PTR_TO_BTF_ID;
 		ret_btf_id = *fn->ret_btf_id;
 		if (ret_btf_id == 0) {
-			verbose(env, "invalid return type %d of func %s#%d\n",
-				fn->ret_type, func_id_name(func_id), func_id);
+			verbose(env, "invalid return type %u of func %s#%d\n",
+				base_type(ret_type), func_id_name(func_id),
+				func_id);
 			return -EINVAL;
 		}
 		regs[BPF_REG_0].btf_id = ret_btf_id;
 	} else {
-		verbose(env, "unknown return type %d of func %s#%d\n",
-			fn->ret_type, func_id_name(func_id), func_id);
+		verbose(env, "unknown return type %u of func %s#%d\n",
+			base_type(ret_type), func_id_name(func_id), func_id);
 		return -EINVAL;
 	}
 
-- 
2.47.1


