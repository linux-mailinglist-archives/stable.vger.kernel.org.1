Return-Path: <stable+bounces-152422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E1DAD56CB
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69D1188EE44
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC32882B8;
	Wed, 11 Jun 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVOPAUUw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE1284B4A
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647761; cv=none; b=qUmjZFQNaD3FZVR8F9RJwCmYWTgvlpy30frGfg2+AvHdgBbH1taRgxbjrdv0VX5pkibV8MTqY7nN+vEQiCCtb3tIJhY/93L/gZpNcTAHIhzJgvPF4A7P6u1kot5XBkmoAEP9rFj/Wc8KXR7L8GkJdOrVFZ3vYgfqHyQ1BUI+wBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647761; c=relaxed/simple;
	bh=HtqP+OqAoacyG08nu1+Wh3O++UtfM7uISUtEuNMqG8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuljI2QZNXdsb6EH/RMRp8iBrmM25SO0W2Ne2t8lLmSHPTYiKVs3SYR5uZo/qPxGxNRTkNv00/e8Fz3Gy9jgDvCWl7VW5RCtuxu+Dk2QXE8ElymAkc9hk7a/UQdYSDYFRZOX5zeNCs2al9uQSxHI6N9IZjZCNAIV87x0te4VpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVOPAUUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7738EC4CEEE;
	Wed, 11 Jun 2025 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749647760;
	bh=HtqP+OqAoacyG08nu1+Wh3O++UtfM7uISUtEuNMqG8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVOPAUUweyHlBHgGNL/hW1miVSbpu+lf5tzUB2u05PNsFH8Uz4geaEUTyoEve0Uq8
	 P8HdmarIM1qedDUZZht3fF8r3VAE6zVnjZBSe9xF/432WKQujPrMDVs9W7Ws9q3umA
	 +wRcqI+/MaVJNEQl+Do+QbWe6qtzCgZWV31a5jOj9Qz14m9DSeWzvryN/IeXBbEP/O
	 lF76fsvCQ7f7Nvo+Nb2+fVqB3U7spN3UR58BlclZGSWZsU5MGZ8HDnQS+bw1wzDuvT
	 vF2R0Z4b4wPd+KGcXE6FMPIhz5yIxNXuvtaD2juN1zeDP1dRy2taDcqXfR+Vn2OjOY
	 U2i1Kw/WoAMYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable linux-5.10.y v1 2/8] bpf: Replace ARG_XXX_OR_NULL with ARG_XXX | PTR_MAYBE_NULL
Date: Wed, 11 Jun 2025 09:15:59 -0400
Message-Id: <20250610171347-e4a5675789d3a672@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250610144407.95865-3-puranjay@kernel.org>
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

The upstream commit SHA1 provided is correct: 48946bd6a5d695c50b34546864b79c1f910a33c1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Puranjay Mohan<puranjay@kernel.org>
Commit author: Hao Luo<haoluo@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: d58a396fa6c9)

Note: The patch differs from the upstream commit:
---
1:  48946bd6a5d69 ! 1:  4b4f340273f41 bpf: Replace ARG_XXX_OR_NULL with ARG_XXX | PTR_MAYBE_NULL
    @@ Metadata
      ## Commit message ##
         bpf: Replace ARG_XXX_OR_NULL with ARG_XXX | PTR_MAYBE_NULL
     
    +    commit 48946bd6a5d695c50b34546864b79c1f910a33c1 upstream.
    +
         We have introduced a new type to make bpf_arg composable, by
         reserving high bits of bpf_arg to represent flags of a type.
     
    @@ Commit message
     
         Signed-off-by: Hao Luo <haoluo@google.com>
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
         Link: https://lore.kernel.org/bpf/20211217003152.48334-3-haoluo@google.com
    +    Cc: stable@vger.kernel.org # 5.10.x
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: enum bpf_arg_type {
    @@ include/linux/bpf.h: enum bpf_arg_type {
      	ARG_CONST_ALLOC_SIZE_OR_ZERO,	/* number of allocated bytes requested */
      	ARG_PTR_TO_BTF_ID_SOCK_COMMON,	/* pointer to in-kernel sock_common or bpf-mirrored bpf_sock */
      	ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
    - 	ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
    --	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
    -+	ARG_PTR_TO_STACK,	/* pointer to stack */
    - 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
    - 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
      	__BPF_ARG_TYPE_MAX,
      
     +	/* Extended arg_types. */
    @@ include/linux/bpf.h: enum bpf_arg_type {
     +	ARG_PTR_TO_CTX_OR_NULL		= PTR_MAYBE_NULL | ARG_PTR_TO_CTX,
     +	ARG_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
     +	ARG_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
    -+	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
     +
      	/* This must be the last entry. Its purpose is to ensure the enum is
      	 * wide enough to hold the higher bits reserved for bpf_type_flag.
    @@ kernel/bpf/verifier.c: static bool arg_type_may_be_refcounted(enum bpf_arg_type
     -	       type == ARG_PTR_TO_MEM_OR_NULL ||
     -	       type == ARG_PTR_TO_CTX_OR_NULL ||
     -	       type == ARG_PTR_TO_SOCKET_OR_NULL ||
    --	       type == ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
    --	       type == ARG_PTR_TO_STACK_OR_NULL;
    +-	       type == ARG_PTR_TO_ALLOC_MEM_OR_NULL;
     +	return type & PTR_MAYBE_NULL;
      }
      
      /* Determine whether the function releases some resources allocated by another
    -@@ kernel/bpf/verifier.c: static int process_timer_func(struct bpf_verifier_env *env, int regno,
    +@@ kernel/bpf/verifier.c: static int process_spin_lock(struct bpf_verifier_env *env, int regno,
      
      static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
      {
    @@ kernel/bpf/verifier.c: static const struct bpf_reg_types *compatible_reg_types[_
      	[ARG_PTR_TO_INT]		= &int_ptr_types,
      	[ARG_PTR_TO_LONG]		= &int_ptr_types,
      	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
    - 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
    --	[ARG_PTR_TO_STACK_OR_NULL]	= &stack_ptr_types,
    -+	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
    - 	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
    - 	[ARG_PTR_TO_TIMER]		= &timer_types,
    - };
     @@ kernel/bpf/verifier.c: static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
      	const struct bpf_reg_types *compatible;
      	int i, j;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

