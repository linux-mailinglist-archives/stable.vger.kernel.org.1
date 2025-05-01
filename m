Return-Path: <stable+bounces-139346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4AFAA631F
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B786B467636
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470F01EDA2B;
	Thu,  1 May 2025 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk0RJcN1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CDA1C1F22
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125463; cv=none; b=W5ycSVlZvpu+LmHpBiSNtb9ZeaaOupsVMb5OKyYvPnVe/ObqrMxmeVREbFWB5CYQKm5wBy1MRYQrPTxfF8GtMRLheFtj6+k837tK5yj5pQQWb4+07NHGu8gl35rmRPhL659FlJP32rl4yVHIPtj4WT1GWoJGagm/jXXtkPxwkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125463; c=relaxed/simple;
	bh=qIIjU77BPzpV3iRTbzfMuNyyhkKyY8mSQGVUTu8N+sM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIyX3a6AoSEylHSUlaBD8w7y/BqAPHHzpqBnpTaVpF94dFTyrNKSmFS8yZSjzMaVs2OLGEdk+Ii3JzQeq2CllkwoYrS0d7o8tcPWpTic1iGNX285GRDU0k2sciGnH6pfGwNDg4HcgERqSMxqsRwx5ETIXUve6kS0O0q4Qnos0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk0RJcN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC87C4CEEF;
	Thu,  1 May 2025 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125462;
	bh=qIIjU77BPzpV3iRTbzfMuNyyhkKyY8mSQGVUTu8N+sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fk0RJcN1dpc13pK2kSBV5e93ddGQw5JL2FTcFKEwdvEo3MsMh1AitxlZ/rXmdqO+a
	 ljlSNkZlmMGS2sfDM1QWqGJ+dJMKH7PEf6p1+K2DwYRvuG8LTmEumzzo43F7sDjm4k
	 8fn98BnlfMy7idAYWthT437BE1TPaRpTC+Xa8P8d8tBSemKn0sNtjxveTOr7XVzvDZ
	 2SEyNgK9bGK25C5lXpIQmbVJVzoe0wJydeENUTblydelTeCVVDx00SCK2NTBmcPeZn
	 wVOHMOTE9ooqjxWRD0U1LQRT2JYU2PWTjR6ZGv0l53wAxkZOc8mbAkw0Ffc4R1Eoqy
	 kDI6bKK0js87g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shung-hsi.yu@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 05/10] bpf: check changes_pkt_data property for extension programs
Date: Thu,  1 May 2025 14:50:57 -0400
Message-Id: <20250501090109-2f92d9df393bdff3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430081955.49927-6-shung-hsi.yu@suse.com>
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
ℹ️ This is part 05/10 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 81f6d0530ba031b5f038a091619bf2ff29568852

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 3846e2bea565)

Found fixes commits:
ac6542ad9275 bpf: fix null dereference when computing changes_pkt_data of prog w/o subprogs

Note: The patch differs from the upstream commit:
---
1:  81f6d0530ba03 ! 1:  9b08cd4de7325 bpf: check changes_pkt_data property for extension programs
    @@ Metadata
      ## Commit message ##
         bpf: check changes_pkt_data property for extension programs
     
    +    commit 81f6d0530ba031b5f038a091619bf2ff29568852 upstream.
    +
         When processing calls to global sub-programs, verifier decides whether
         to invalidate all packet pointers in current state depending on the
         changes_pkt_data property of the global sub-program.
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-6-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    [ shung-hsi.yu: adapt to missing fields in "struct bpf_prog_aux". Context
    +    difference in jit_subprogs() because BPF Exception is not supported. Context
    +    difference in bpf_check() because commit 5b5f51bff1b6 "bpf:
    +    no_caller_saved_registers attribute for helper calls" is not present. ]
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: struct bpf_prog_aux {
    - 	bool is_extended; /* true if extended by freplace program */
    - 	bool jits_use_priv_stack;
    - 	bool priv_stack_requested;
    + 	bool sleepable;
    + 	bool tail_call_reachable;
    + 	bool xdp_has_frags;
     +	bool changes_pkt_data;
    - 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
    - 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
    - 	struct bpf_arena *arena;
    + 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
    + 	const struct btf_type *attach_func_proto;
    + 	/* function name for valid attach_btf_id */
     
      ## kernel/bpf/verifier.c ##
     @@ kernel/bpf/verifier.c: static int check_cfg(struct bpf_verifier_env *env)
    @@ kernel/bpf/verifier.c: static int check_cfg(struct bpf_verifier_env *env)
      err_free:
      	kvfree(insn_state);
     @@ kernel/bpf/verifier.c: static int jit_subprogs(struct bpf_verifier_env *env)
    + 		}
      		func[i]->aux->num_exentries = num_exentries;
      		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
    - 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
     +		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
    - 		if (!i)
    - 			func[i]->aux->exception_boundary = env->seen_exception;
      		func[i] = bpf_int_jit_compile(func[i]);
    + 		if (!func[i]->jited) {
    + 			err = -ENOTSUPP;
     @@ kernel/bpf/verifier.c: int bpf_check_attach_target(struct bpf_verifier_log *log,
      					"Extension programs should be JITed\n");
      				return -EINVAL;
    @@ kernel/bpf/verifier.c: int bpf_check(struct bpf_prog **prog, union bpf_attr *att
     +	if (ret)
     +		goto skip_full_check;
     +
    - 	ret = mark_fastcall_patterns(env);
    - 	if (ret < 0)
    - 		goto skip_full_check;
    + 	ret = do_check_subprogs(env);
    + 	ret = ret ?: do_check_main(env);
    + 
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

