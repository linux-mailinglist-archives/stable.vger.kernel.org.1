Return-Path: <stable+bounces-152433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F2AAD56E1
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B05B188F524
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AAA2882A5;
	Wed, 11 Jun 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiO4f80x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013D24502D
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648280; cv=none; b=qsdmoG8kO6ZbZ7/agQkg4jt/dw9jfFpdc33hq3MKB3dHAKmYDss/hpqtjrj8yfBGfFv3bbvYT47JFseU2JSFj+1uKAk+h+c1QBmpM0wPfbIb32i3Seq97+7yr/6+70OeyZuEeMMfxZrDRNjAgEG9inZ/JX7BpOLQWDlP6GukMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648280; c=relaxed/simple;
	bh=0gApabvuB4YangGILtAL2y4A4cYtnhfvtNf7hUDgh9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJA8NCgn+YyaukLatHQWvc3JwCqTbPhumF99Z+wSkzv4palqTKfFtOZfdxRN3QlwDcrXokBCu6Oeg37Mw4B/Ut1t2HgJUIgcoOZkZyHX+/suJz4gJeazvcLPXjKqknMZaxpVJh7mQ2GvbLuwvEXp2poYQu6bcnJ8NJAZ2UnJt5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiO4f80x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5676FC4CEEE;
	Wed, 11 Jun 2025 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648279;
	bh=0gApabvuB4YangGILtAL2y4A4cYtnhfvtNf7hUDgh9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiO4f80xC4QH3yU4BM5uTIzj1l5RVTX96/D75vs3JixFaHB+OrFGa2vz8suY/rySo
	 Vrz/IfV/UqS4Qsw34LlwwLSBf8iRHNZY4vCIIC4ed1Bi1rL6Ee3TvkfbPv5yh/2Bxb
	 k2k1yuKAhjAMN9tydBCCUFw7yswn2creoPP1IldGeWXh7SUsN3TfIWr4nb07i2mBJG
	 hqus0Xuw8WectdmSaRsBJ/7bVCfRlL9yopBxR8AyyM7c63i/TjWvoHAm1X7L06nbU5
	 tU97tBdDt2fbSHm3q+h0wRWtrdzWwQGWcvXzLfwu+GyYQ8uUs7HZUESGuiuH+qSDTp
	 10W4/LoFJ6soQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable linux-5.10.y v1 3/8] bpf: Replace RET_XXX_OR_NULL with RET_XXX | PTR_MAYBE_NULL
Date: Wed, 11 Jun 2025 09:24:38 -0400
Message-Id: <20250610173125-f759484d94e1658b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250610144407.95865-4-puranjay@kernel.org>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 3c4807322660d4290ac9062c034aed6b87243861

WARNING: Author mismatch between patch and upstream commit:
Backport author: Puranjay Mohan<puranjay@kernel.org>
Commit author: Hao Luo<haoluo@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 3c141c82b958)

Note: The patch differs from the upstream commit:
---
1:  3c4807322660d ! 1:  687af1d867c44 bpf: Replace RET_XXX_OR_NULL with RET_XXX | PTR_MAYBE_NULL
    @@ Metadata
      ## Commit message ##
         bpf: Replace RET_XXX_OR_NULL with RET_XXX | PTR_MAYBE_NULL
     
    +    commit 3c4807322660d4290ac9062c034aed6b87243861 upstream.
    +
         We have introduced a new type to make bpf_ret composable, by
         reserving high bits to represent flags.
     
    @@ Commit message
     
         Signed-off-by: Hao Luo <haoluo@google.com>
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
         Link: https://lore.kernel.org/bpf/20211217003152.48334-4-haoluo@google.com
    +    Cc: stable@vger.kernel.org # 5.10.x
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: enum bpf_return_type {
    @@ include/linux/bpf.h: enum bpf_return_type {
     +	RET_PTR_TO_SOCK_COMMON,		/* returns a pointer to a sock_common */
     +	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated memory */
      	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
    - 	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
    ++	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
      	__BPF_RET_TYPE_MAX,
      
     +	/* Extended ret_types. */
    @@ kernel/bpf/helpers.c: BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
      };
     
      ## kernel/bpf/verifier.c ##
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    - 			     int *insn_idx_p)
    +@@ kernel/bpf/verifier.c: static int check_reference_leak(struct bpf_verifier_env *env)
    + static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn_idx)
      {
      	const struct bpf_func_proto *fn = NULL;
     +	enum bpf_return_type ret_type;
      	struct bpf_reg_state *regs;
      	struct bpf_call_arg_meta meta;
    - 	int insn_idx = *insn_idx_p;
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    + 	bool changes_data;
    +@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
      	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
      
      	/* update return register (already marked as written above) */
    @@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env
      		/* There is no offset yet applied, variable or fixed */
      		mark_reg_known_zero(env, regs, BPF_REG_0);
      		/* remember map_ptr, so that check_map_access()
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    +@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
    + 			return -EINVAL;
      		}
      		regs[BPF_REG_0].map_ptr = meta.map_ptr;
    - 		regs[BPF_REG_0].map_uid = meta.map_uid;
     -		if (fn->ret_type == RET_PTR_TO_MAP_VALUE) {
     +		if (type_may_be_null(ret_type)) {
     +			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
    @@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env
      		const struct btf_type *t;
      
      		mark_reg_known_zero(env, regs, BPF_REG_0);
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    +@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
      				return -EINVAL;
      			}
      			regs[BPF_REG_0].type =
    @@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env
     -				PTR_TO_BTF_ID : PTR_TO_BTF_ID_OR_NULL;
     +				(ret_type & PTR_MAYBE_NULL) ?
     +				PTR_TO_BTF_ID_OR_NULL : PTR_TO_BTF_ID;
    - 			regs[BPF_REG_0].btf = meta.ret_btf;
      			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
      		}
    --	} else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL ||
    --		   fn->ret_type == RET_PTR_TO_BTF_ID) {
    +-	} else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL) {
     +	} else if (base_type(ret_type) == RET_PTR_TO_BTF_ID) {
      		int ret_btf_id;
      
      		mark_reg_known_zero(env, regs, BPF_REG_0);
    --		regs[BPF_REG_0].type = fn->ret_type == RET_PTR_TO_BTF_ID ?
    --						     PTR_TO_BTF_ID :
    --						     PTR_TO_BTF_ID_OR_NULL;
    +-		regs[BPF_REG_0].type = PTR_TO_BTF_ID_OR_NULL;
     +		regs[BPF_REG_0].type = (ret_type & PTR_MAYBE_NULL) ?
    -+						     PTR_TO_BTF_ID_OR_NULL :
    -+						     PTR_TO_BTF_ID;
    ++					PTR_TO_BTF_ID_OR_NULL :
    ++					PTR_TO_BTF_ID;
      		ret_btf_id = *fn->ret_btf_id;
      		if (ret_btf_id == 0) {
     -			verbose(env, "invalid return type %d of func %s#%d\n",
    @@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env
     +				func_id);
      			return -EINVAL;
      		}
    - 		/* current BPF helper definitions are only coming from
    -@@ kernel/bpf/verifier.c: static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
    - 		regs[BPF_REG_0].btf = btf_vmlinux;
      		regs[BPF_REG_0].btf_id = ret_btf_id;
      	} else {
     -		verbose(env, "unknown return type %d of func %s#%d\n",
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

