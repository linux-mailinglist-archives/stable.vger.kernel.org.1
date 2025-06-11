Return-Path: <stable+bounces-152426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70F3AD56CD
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CC61BC5FAA
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37BD28936E;
	Wed, 11 Jun 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+HvW/sv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CDA281358
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647769; cv=none; b=EMH5hOJj7GgdPEjGgWrYqO4X+X2xbNMPSFP5+WEnIbkuH2djNtfaHb7oa7G8yeVYUoTQQKBxe+Isexrb26EdiWMfwLGA+ccslW6eZpvjjsWP9G6APBsJ9u45FZZQfiMtjncnB99RNn383Rrm2635/gvpyxeZSZSYt9WLTsJxEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647769; c=relaxed/simple;
	bh=4VrlbjBb8oNV7IVwKHlOxouo7FF/XyBuK9q3EA8iCM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C21jN8N76sGv4C0SNdiJhAvhtMVHwPL+/a3nUsxGlbBKe2eh6RvvzI7pHGJvDSEipXRe1eqONMz2P8IEVs6fTdCCgV79FVxA7fUbJ9GQdqKNIMl9XAFNqCsffdYyEK04eAuK4LcdXwWYKsXeC61ISaDOHwEUtK9mMBan1VF2u2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+HvW/sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A162C4CEEE;
	Wed, 11 Jun 2025 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749647769;
	bh=4VrlbjBb8oNV7IVwKHlOxouo7FF/XyBuK9q3EA8iCM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+HvW/svlWgoVXaAqYY5FHpP6sojTmduhmk3aUYcoc+KoetrCAGqEkkNmuy/7oV7X
	 9/39UDcChO8j+OwDodVCDXGq3xrbOemkuJAm7GnzOiCZswf0k4CYUOgi4SkqqOw4do
	 cQDkmMLWs2jWecYkcqqVOKs9QE/OVQxdSq5xPxhlwcV3gL9CxPD+YwMTVFC6B04B6J
	 YZYocygM9hH2HQDfE/H0tVb8FL0Yt7f8pvraUJ5Dizurk1jAjVelRZKVAll7NY9/2z
	 JrHYBwA85xLppBSwPDHLmjXasep4iTokXaLw3VtJHeNpCPLmkCUodAoMP0KNRWDsvn
	 TE96GJ00mVJsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	puranjay@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable linux-5.10.y v1 4/8] bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL
Date: Wed, 11 Jun 2025 09:16:07 -0400
Message-Id: <20250610174002-a41a8297bb42651b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250610144407.95865-5-puranjay@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
ℹ️ This is part 4/8 of a series
❌ Build failures detected
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: c25b2ae136039ffa820c26138ed4a5e5f3ab3841

WARNING: Author mismatch between patch and upstream commit:
Backport author: Puranjay Mohan<puranjay@kernel.org>
Commit author: Hao Luo<haoluo@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 8d38cde47a7e)

Found fixes commits:
45ce4b4f9009 bpf: Fix crash due to out of bounds access into reg2btf_ids.

Note: The patch differs from the upstream commit:
---
1:  c25b2ae136039 ! 1:  f9aec68f75333 bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL
    @@ Metadata
      ## Commit message ##
         bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL
     
    +    commit c25b2ae136039ffa820c26138ed4a5e5f3ab3841 upstream.
    +
         We have introduced a new type to make bpf_reg composable, by
         allocating bits in the type to represent flags.
     
    @@ Commit message
         7. PTR_TO_RDONLY_BUF_OR_NULL
         8. PTR_TO_RDWR_BUF_OR_NULL
     
    +    [puranjay: backport notes
    +     There was a reg_type_may_be_null() in adjust_ptr_min_max_vals() in
    +     5.10.x, but didn't exist in the upstream commit. This backport
    +     converted that reg_type_may_be_null() to type_may_be_null() as well.]
    +
         Signed-off-by: Hao Luo <haoluo@google.com>
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
         Link: https://lore.kernel.org/r/20211217003152.48334-5-haoluo@google.com
    +    Cc: stable@vger.kernel.org # 5.10.x
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: enum bpf_reg_type {
    @@ include/linux/bpf.h: enum bpf_reg_type {
      	CONST_PTR_TO_MAP,	 /* reg points to struct bpf_map */
      	PTR_TO_MAP_VALUE,	 /* reg points to map element value */
     -	PTR_TO_MAP_VALUE_OR_NULL,/* points to map elem value or NULL */
    -+	PTR_TO_MAP_KEY,		 /* reg points to a map element key */
      	PTR_TO_STACK,		 /* reg == frame_pointer + offset */
      	PTR_TO_PACKET_META,	 /* skb->data - meta_len */
      	PTR_TO_PACKET,		 /* reg points to skb->data */
    @@ include/linux/bpf.h: enum bpf_reg_type {
      	PTR_TO_RDWR_BUF,	 /* reg points to a read/write buffer */
     -	PTR_TO_RDWR_BUF_OR_NULL, /* reg points to a read/write buffer or NULL */
      	PTR_TO_PERCPU_BTF_ID,	 /* reg points to a percpu kernel variable */
    - 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
    --	PTR_TO_MAP_KEY,		 /* reg points to a map element key */
      	__BPF_REG_TYPE_MAX,
      
     +	/* Extended reg_types. */
    @@ include/linux/bpf.h: enum bpf_reg_type {
     +	PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
     +	PTR_TO_TCP_SOCK_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
     +	PTR_TO_BTF_ID_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_BTF_ID,
    -+	PTR_TO_MEM_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_MEM,
     +
      	/* This must be the last entry. Its purpose is to ensure the enum is
      	 * wide enough to hold the higher bits reserved for bpf_type_flag.
    @@ include/linux/bpf_verifier.h
      /* Liveness marks, used for registers and spilled-regs (in stack slots).
       * Read marks propagate upwards until they find a write mark; they record that
     @@ include/linux/bpf_verifier.h: struct bpf_verifier_env {
    - 	/* Same as scratched_regs but for stack slots */
    - 	u64 scratched_stack_slots;
    - 	u32 prev_log_len, prev_insn_print_len;
    + 	u32 peak_states;
    + 	/* longest register parentage chain walked for liveness marking */
    + 	u32 longest_mark_read_walk;
     +	/* buffer used in reg_type_str() to generate reg_type string */
     +	char type_str_buf[TYPE_STR_BUF_LEN];
      };
    @@ kernel/bpf/verifier.c: static bool reg_may_point_to_spin_lock(const struct bpf_r
      }
      
      static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
    -@@ kernel/bpf/verifier.c: static bool is_cmpxchg_insn(const struct bpf_insn *insn)
    - 	       insn->imm == BPF_CMPXCHG;
    +@@ kernel/bpf/verifier.c: static bool is_ptr_cast_function(enum bpf_func_id func_id)
    + 		func_id == BPF_FUNC_skc_to_tcp_request_sock;
      }
      
     -/* string representation of 'enum bpf_reg_type' */
    @@ kernel/bpf/verifier.c: static bool is_cmpxchg_insn(const struct bpf_insn *insn)
     -	[PTR_TO_RDONLY_BUF_OR_NULL] = "rdonly_buf_or_null",
     -	[PTR_TO_RDWR_BUF]	= "rdwr_buf",
     -	[PTR_TO_RDWR_BUF_OR_NULL] = "rdwr_buf_or_null",
    --	[PTR_TO_FUNC]		= "func",
    --	[PTR_TO_MAP_KEY]	= "map_key",
     -};
     +/* string representation of 'enum bpf_reg_type'
     + *
    @@ kernel/bpf/verifier.c: static bool is_cmpxchg_insn(const struct bpf_insn *insn)
     +		[PTR_TO_MEM]		= "mem",
     +		[PTR_TO_RDONLY_BUF]	= "rdonly_buf",
     +		[PTR_TO_RDWR_BUF]	= "rdwr_buf",
    -+		[PTR_TO_FUNC]		= "func",
    -+		[PTR_TO_MAP_KEY]	= "map_key",
     +	};
     +
     +	if (type & PTR_MAYBE_NULL) {
    @@ kernel/bpf/verifier.c: static void print_verifier_state(struct bpf_verifier_env
     -			    t == PTR_TO_PERCPU_BTF_ID)
     +			if (base_type(t) == PTR_TO_BTF_ID ||
     +			    base_type(t) == PTR_TO_PERCPU_BTF_ID)
    - 				verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
    + 				verbose(env, "%s", kernel_type_name(reg->btf_id));
      			verbose(env, "(id=%d", reg->id);
      			if (reg_type_may_be_refcounted_or_null(t))
     @@ kernel/bpf/verifier.c: static void print_verifier_state(struct bpf_verifier_env *env,
    @@ kernel/bpf/verifier.c: static void print_verifier_state(struct bpf_verifier_env
      			if (type_is_pkt_pointer(t))
      				verbose(env, ",r=%d", reg->range);
     -			else if (t == CONST_PTR_TO_MAP ||
    --				 t == PTR_TO_MAP_KEY ||
     -				 t == PTR_TO_MAP_VALUE ||
     -				 t == PTR_TO_MAP_VALUE_OR_NULL)
     +			else if (base_type(t) == CONST_PTR_TO_MAP ||
    -+				 base_type(t) == PTR_TO_MAP_KEY ||
     +				 base_type(t) == PTR_TO_MAP_VALUE)
      				verbose(env, ",ks=%d,vs=%d",
      					reg->map_ptr->key_size,
    @@ kernel/bpf/verifier.c: static void print_verifier_state(struct bpf_verifier_env
      			if (t == SCALAR_VALUE && reg->precise)
      				verbose(env, "P");
      			if (t == SCALAR_VALUE && tnum_is_const(reg->var_off))
    -@@ kernel/bpf/verifier.c: static void mark_reg_known_zero(struct bpf_verifier_env *env,
    - 
    - static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
    - {
    --	switch (reg->type) {
    --	case PTR_TO_MAP_VALUE_OR_NULL: {
    -+	if (base_type(reg->type) == PTR_TO_MAP_VALUE) {
    - 		const struct bpf_map *map = reg->map_ptr;
    - 
    - 		if (map->inner_map_meta) {
    -@@ kernel/bpf/verifier.c: static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
    - 		} else {
    - 			reg->type = PTR_TO_MAP_VALUE;
    - 		}
    --		break;
    --	}
    --	case PTR_TO_SOCKET_OR_NULL:
    --		reg->type = PTR_TO_SOCKET;
    --		break;
    --	case PTR_TO_SOCK_COMMON_OR_NULL:
    --		reg->type = PTR_TO_SOCK_COMMON;
    --		break;
    --	case PTR_TO_TCP_SOCK_OR_NULL:
    --		reg->type = PTR_TO_TCP_SOCK;
    --		break;
    --	case PTR_TO_BTF_ID_OR_NULL:
    --		reg->type = PTR_TO_BTF_ID;
    --		break;
    --	case PTR_TO_MEM_OR_NULL:
    --		reg->type = PTR_TO_MEM;
    --		break;
    --	case PTR_TO_RDONLY_BUF_OR_NULL:
    --		reg->type = PTR_TO_RDONLY_BUF;
    --		break;
    --	case PTR_TO_RDWR_BUF_OR_NULL:
    --		reg->type = PTR_TO_RDWR_BUF;
    --		break;
    --	default:
    --		WARN_ONCE(1, "unknown nullable register type");
    -+		return;
    - 	}
    -+
    -+	reg->type &= ~PTR_MAYBE_NULL;
    - }
    - 
    - static bool reg_is_pkt_pointer(const struct bpf_reg_state *reg)
     @@ kernel/bpf/verifier.c: static int mark_reg_read(struct bpf_verifier_env *env,
      			break;
      		if (parent->live & REG_LIVE_DONE) {
    @@ kernel/bpf/verifier.c: static int mark_reg_read(struct bpf_verifier_env *env,
      				parent->var_off.value, parent->off);
      			return -EFAULT;
      		}
    -@@ kernel/bpf/verifier.c: static int mark_chain_precision_stack(struct bpf_verifier_env *env, int spi)
    +@@ kernel/bpf/verifier.c: static int mark_chain_precision_stack_frame(struct bpf_verifier_env *env, int fr
      
      static bool is_spillable_regtype(enum bpf_reg_type type)
      {
    @@ kernel/bpf/verifier.c: static bool is_spillable_regtype(enum bpf_reg_type type)
      	case PTR_TO_PERCPU_BTF_ID:
      	case PTR_TO_MEM:
     -	case PTR_TO_MEM_OR_NULL:
    - 	case PTR_TO_FUNC:
    - 	case PTR_TO_MAP_KEY:
      		return true;
    + 	default:
    + 		return false;
     @@ kernel/bpf/verifier.c: static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
      		 */
      		*reg_type = info.reg_type;
      
    --		if (*reg_type == PTR_TO_BTF_ID || *reg_type == PTR_TO_BTF_ID_OR_NULL) {
    -+		if (base_type(*reg_type) == PTR_TO_BTF_ID) {
    - 			*btf = info.btf;
    +-		if (*reg_type == PTR_TO_BTF_ID || *reg_type == PTR_TO_BTF_ID_OR_NULL)
    ++		if (base_type(*reg_type) == PTR_TO_BTF_ID)
      			*btf_id = info.btf_id;
    - 		} else {
    + 		else
    + 			env->insn_aux_data[insn_idx].ctx_field_size = info.ctx_field_size;
     @@ kernel/bpf/verifier.c: static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
      	}
      
    @@ kernel/bpf/verifier.c: static int check_mem_access(struct bpf_verifier_env *env,
      				 */
      				regs[value_regno].subreg_def = DEF_NOT_SUBREG;
     -				if (reg_type == PTR_TO_BTF_ID ||
    --				    reg_type == PTR_TO_BTF_ID_OR_NULL) {
    -+				if (base_type(reg_type) == PTR_TO_BTF_ID) {
    - 					regs[value_regno].btf = btf;
    +-				    reg_type == PTR_TO_BTF_ID_OR_NULL)
    ++				if (base_type(reg_type) == PTR_TO_BTF_ID)
      					regs[value_regno].btf_id = btf_id;
    - 				}
    + 			}
    + 			regs[value_regno].type = reg_type;
     @@ kernel/bpf/verifier.c: static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
      	} else if (type_is_sk_pointer(reg->type)) {
      		if (t == BPF_WRITE) {
    @@ kernel/bpf/verifier.c: static int check_mem_access(struct bpf_verifier_env *env,
      		return -EACCES;
      	}
      
    -@@ kernel/bpf/verifier.c: static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
    +@@ kernel/bpf/verifier.c: static int check_xadd(struct bpf_verifier_env *env, int insn_idx, struct bpf_ins
      	    is_sk_reg(env, insn->dst_reg)) {
    - 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
    + 		verbose(env, "BPF_XADD stores into R%d %s is not allowed\n",
      			insn->dst_reg,
     -			reg_type_str[reg_state(env, insn->dst_reg)->type]);
     +			reg_type_str(env, reg_state(env, insn->dst_reg)->type));
    @@ kernel/bpf/verifier.c: static int check_helper_mem_access(struct bpf_verifier_en
      		return -EACCES;
      	}
      }
    -@@ kernel/bpf/verifier.c: int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
    - 	if (register_is_null(reg))
    - 		return 0;
    - 
    --	if (reg_type_may_be_null(reg->type)) {
    -+	if (type_may_be_null(reg->type)) {
    - 		/* Assuming that the register contains a value check if the memory
    - 		 * access is safe. Temporarily save and restore the register's state as
    - 		 * the conversion shouldn't be visible to a caller.
     @@ kernel/bpf/verifier.c: static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
      			goto found;
      	}
    @@ kernel/bpf/verifier.c: static int check_reg_type(struct bpf_verifier_env *env, u
      	return -EACCES;
      
      found:
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    +@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
      {
      	const struct bpf_func_proto *fn = NULL;
      	enum bpf_return_type ret_type;
     +	enum bpf_type_flag ret_flag;
      	struct bpf_reg_state *regs;
      	struct bpf_call_arg_meta meta;
    - 	int insn_idx = *insn_idx_p;
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    + 	bool changes_data;
    +@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
      
      	/* update return register (already marked as written above) */
      	ret_type = fn->ret_type;
    @@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env
      	if (ret_type == RET_INTEGER) {
      		/* sets type to SCALAR_VALUE */
      		mark_reg_unknown(env, regs, BPF_REG_0);
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    +@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
    + 			return -EINVAL;
      		}
      		regs[BPF_REG_0].map_ptr = meta.map_ptr;
    - 		regs[BPF_REG_0].map_uid = meta.map_uid;
     -		if (type_may_be_null(ret_type)) {
     -			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
     -		} else {
    @@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env
      		regs[BPF_REG_0].mem_size = meta.mem_size;
      	} else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
      		const struct btf_type *t;
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    +@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
      					tname, PTR_ERR(ret));
      				return -EINVAL;
      			}
    @@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env
     -				(ret_type & PTR_MAYBE_NULL) ?
     -				PTR_TO_BTF_ID_OR_NULL : PTR_TO_BTF_ID;
     +			regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
    - 			regs[BPF_REG_0].btf = meta.ret_btf;
      			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
      		}
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    + 	} else if (base_type(ret_type) == RET_PTR_TO_BTF_ID) {
      		int ret_btf_id;
      
      		mark_reg_known_zero(env, regs, BPF_REG_0);
     -		regs[BPF_REG_0].type = (ret_type & PTR_MAYBE_NULL) ?
    --						     PTR_TO_BTF_ID_OR_NULL :
    --						     PTR_TO_BTF_ID;
    +-					PTR_TO_BTF_ID_OR_NULL :
    +-					PTR_TO_BTF_ID;
     +		regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
      		ret_btf_id = *fn->ret_btf_id;
      		if (ret_btf_id == 0) {
      			verbose(env, "invalid return type %u of func %s#%d\n",
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    +@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
      		return -EINVAL;
      	}
      
    @@ kernel/bpf/verifier.c: static int adjust_ptr_min_max_vals(struct bpf_verifier_en
      		/* smin_val represents the known value */
      		if (known && smin_val == 0 && opcode == BPF_ADD)
     @@ kernel/bpf/verifier.c: static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
    - 		fallthrough;
    - 	case PTR_TO_PACKET_END:
    - 	case PTR_TO_SOCKET:
    --	case PTR_TO_SOCKET_OR_NULL:
    - 	case PTR_TO_SOCK_COMMON:
    --	case PTR_TO_SOCK_COMMON_OR_NULL:
    - 	case PTR_TO_TCP_SOCK:
    --	case PTR_TO_TCP_SOCK_OR_NULL:
      	case PTR_TO_XDP_SOCK:
    + reject:
      		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
     -			dst, reg_type_str[ptr_reg->type]);
     +			dst, reg_type_str(env, ptr_reg->type));
      		return -EACCES;
      	default:
    +-		if (reg_type_may_be_null(ptr_reg->type))
    ++		if (type_may_be_null(ptr_reg->type))
    + 			goto reject;
      		break;
    + 	}
     @@ kernel/bpf/verifier.c: static void mark_ptr_or_null_reg(struct bpf_func_state *state,
      				 struct bpf_reg_state *reg, u32 id,
      				 bool is_null)
    @@ kernel/bpf/verifier.c: static void mark_ptr_or_null_reg(struct bpf_func_state *s
     -	if (reg_type_may_be_null(reg->type) && reg->id == id &&
     +	if (type_may_be_null(reg->type) && reg->id == id &&
      	    !WARN_ON_ONCE(!reg->id)) {
    - 		/* Old offset (both fixed and variable parts) should
    - 		 * have been known-zero, because we don't allow pointer
    + 		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
    + 				 !tnum_equals_const(reg->var_off, 0) ||
    +@@ kernel/bpf/verifier.c: static void mark_ptr_or_null_reg(struct bpf_func_state *state,
    + 		}
    + 		if (is_null) {
    + 			reg->type = SCALAR_VALUE;
    +-		} else if (reg->type == PTR_TO_MAP_VALUE_OR_NULL) {
    ++			/* We don't need id and ref_obj_id from this point
    ++			 * onwards anymore, thus we should better reset it,
    ++			 * so that state pruning has chances to take effect.
    ++			 */
    ++			reg->id = 0;
    ++			reg->ref_obj_id = 0;
    ++
    ++			return;
    ++		}
    ++
    ++		if (base_type(reg->type) == PTR_TO_MAP_VALUE) {
    + 			const struct bpf_map *map = reg->map_ptr;
    + 
    + 			if (map->inner_map_meta) {
    +@@ kernel/bpf/verifier.c: static void mark_ptr_or_null_reg(struct bpf_func_state *state,
    + 			} else {
    + 				reg->type = PTR_TO_MAP_VALUE;
    + 			}
    +-		} else if (reg->type == PTR_TO_SOCKET_OR_NULL) {
    +-			reg->type = PTR_TO_SOCKET;
    +-		} else if (reg->type == PTR_TO_SOCK_COMMON_OR_NULL) {
    +-			reg->type = PTR_TO_SOCK_COMMON;
    +-		} else if (reg->type == PTR_TO_TCP_SOCK_OR_NULL) {
    +-			reg->type = PTR_TO_TCP_SOCK;
    +-		} else if (reg->type == PTR_TO_BTF_ID_OR_NULL) {
    +-			reg->type = PTR_TO_BTF_ID;
    +-		} else if (reg->type == PTR_TO_MEM_OR_NULL) {
    +-			reg->type = PTR_TO_MEM;
    +-		} else if (reg->type == PTR_TO_RDONLY_BUF_OR_NULL) {
    +-			reg->type = PTR_TO_RDONLY_BUF;
    +-		} else if (reg->type == PTR_TO_RDWR_BUF_OR_NULL) {
    +-			reg->type = PTR_TO_RDWR_BUF;
    ++		} else {
    ++			reg->type &= ~PTR_MAYBE_NULL;
    + 		}
    +-		if (is_null) {
    +-			/* We don't need id and ref_obj_id from this point
    +-			 * onwards anymore, thus we should better reset it,
    +-			 * so that state pruning has chances to take effect.
    +-			 */
    +-			reg->id = 0;
    +-			reg->ref_obj_id = 0;
    +-		} else if (!reg_may_point_to_spin_lock(reg)) {
    ++
    ++		if (!reg_may_point_to_spin_lock(reg)) {
    + 			/* For not-NULL ptr, reg->ref_obj_id will be reset
    + 			 * in release_reference().
    + 			 *
     @@ kernel/bpf/verifier.c: static int check_cond_jmp_op(struct bpf_verifier_env *env,
      	 */
      	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_K &&
    @@ kernel/bpf/verifier.c: static int check_cond_jmp_op(struct bpf_verifier_env *env
      		/* Mark all identical registers in each branch as either
      		 * safe or unknown depending R == 0 or R != 0 conditional.
      		 */
    -@@ kernel/bpf/verifier.c: static int check_return_code(struct bpf_verifier_env *env)
    - 		/* enforce return zero from async callbacks like timer */
    - 		if (reg->type != SCALAR_VALUE) {
    - 			verbose(env, "In async callback the register R0 is not a known value (%s)\n",
    --				reg_type_str[reg->type]);
    -+				reg_type_str(env, reg->type));
    - 			return -EINVAL;
    - 		}
    - 
     @@ kernel/bpf/verifier.c: static int check_return_code(struct bpf_verifier_env *env)
      	if (is_subprog) {
      		if (reg->type != SCALAR_VALUE) {
    @@ kernel/bpf/verifier.c: static bool regsafe(struct bpf_verifier_env *env, struct
      		if (env->explore_alu_limits)
      			return false;
     @@ kernel/bpf/verifier.c: static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
    + 			return false;
      		}
    - 	case PTR_TO_MAP_KEY:
      	case PTR_TO_MAP_VALUE:
     +		/* a PTR_TO_MAP_VALUE could be safe to use as a
     +		 * PTR_TO_MAP_VALUE_OR_NULL into the same map.
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Failed    |

Build Errors:
Build error:
    kernel/trace/trace_events_synth.c: In function 'synth_event_reg':
    kernel/trace/trace_events_synth.c:847:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      847 |         int ret = trace_event_reg(call, type, data);
          |         ^~~
    In file included from ./include/linux/kernel.h:15,
                     from ./include/linux/list.h:9,
                     from ./include/linux/module.h:12,
                     from net/ipv4/inet_hashtables.c:12:
    net/ipv4/inet_hashtables.c: In function 'inet_ehash_locks_alloc':
    ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
          |                                   ^~
    ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
       26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
       36 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/minmax.h:52:25: note: in expansion of macro '__careful_cmp'
       52 | #define max(x, y)       __careful_cmp(x, y, >)
          |                         ^~~~~~~~~~~~~
    net/ipv4/inet_hashtables.c:946:19: note: in expansion of macro 'max'
      946 |         nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
          |                   ^~~
    In file included from ./include/linux/kernel.h:15,
                     from ./include/linux/list.h:9,
                     from ./include/linux/kobject.h:19,
                     from ./include/linux/of.h:17,
                     from ./include/linux/clk-provider.h:9,
                     from drivers/clk/qcom/clk-rpmh.c:6:
    drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
    ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
          |                                   ^~
    ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
       26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
       36 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
       45 | #define min(x, y)       __careful_cmp(x, y, <)
          |                         ^~~~~~~~~~~~~
    drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
      273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
          |                     ^~~
    drivers/firmware/efi/mokvar-table.c: In function 'efi_mokvar_table_init':
    drivers/firmware/efi/mokvar-table.c:107:23: warning: unused variable 'size' [-Wunused-variable]
      107 |         unsigned long size;
          |                       ^~~~
    In file included from <command-line>:
    drivers/net/ethernet/netronome/nfp/bpf/verifier.c: In function 'nfp_bpf_check_helper_call':
    ././include/linux/compiler_types.h:309:45: error: call to '__compiletime_assert_1821' declared with attribute error: BUILD_BUG_ON failed: NFP_BPF_SCALAR_VALUE != SCALAR_VALUE || NFP_BPF_MAP_VALUE != PTR_TO_MAP_VALUE || NFP_BPF_STACK != PTR_TO_STACK || NFP_BPF_PACKET_DATA != PTR_TO_PACKET
      309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
          |                                             ^
    ././include/linux/compiler_types.h:290:25: note: in definition of macro '__compiletime_assert'
      290 |                         prefix ## suffix();                             \
          |                         ^~~~~~
    ././include/linux/compiler_types.h:309:9: note: in expansion of macro '_compiletime_assert'
      309 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
          |         ^~~~~~~~~~~~~~~~~~~
    ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
          |                                     ^~~~~~~~~~~~~~~~~~
    ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
          |         ^~~~~~~~~~~~~~~~
    drivers/net/ethernet/netronome/nfp/bpf/verifier.c:234:17: note: in expansion of macro 'BUILD_BUG_ON'
      234 |                 BUILD_BUG_ON(NFP_BPF_SCALAR_VALUE != SCALAR_VALUE ||
          |                 ^~~~~~~~~~~~
    make[5]: *** [scripts/Makefile.build:286: drivers/net/ethernet/netronome/nfp/bpf/verifier.o] Error 1
    make[5]: Target '__build' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:503: drivers/net/ethernet/netronome/nfp] Error 2
    make[4]: Target '__build' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:503: drivers/net/ethernet/netronome] Error 2
    make[3]: Target '__build' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: drivers/net/ethernet] Error 2
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: drivers/net] Error 2
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1852: drivers] Error 2
    make: Target '__all' not remade because of errors.

