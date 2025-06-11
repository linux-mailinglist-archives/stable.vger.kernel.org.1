Return-Path: <stable+bounces-152425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BECAD56C3
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9FD3A7668
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD828850F;
	Wed, 11 Jun 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty8PM4H2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EFD284B36
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647767; cv=none; b=XMuUB8GsDS0YVqZkZNUEKIZMm+oL8b2UEE+KqwqlYCfqFuGQxQGRv9qmGG9Dq+cpIeNWL5jIds1z8G8jnLIeNu+C/L6hwwukPtRP4ly6EdCzAikcn0ExIHVEwWryNVXRT+S+m3mWLSx1JpZCvjjNifZZY5PtNltcIGDTFkfkLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647767; c=relaxed/simple;
	bh=x6p17aCP9nAeRV8ezd4QEa2x3QuIrWZ7K1WHUYnUd6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hX7T9IvEjuTu8jM+DyukMrTvQzGAYb/YVwK11i+eG/2JVuapEQL+ieXA96S0pD6TuCkU8zkrcJrcTuHs3ySE17A1TKwHmYY284ubdCiLrIHyPd1nC2mJR5jPeVZM2Fiod65TvpCKWyAaF2XVa/8ssLMIeHTTtO8zlURV230S64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty8PM4H2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92180C4CEEE;
	Wed, 11 Jun 2025 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749647767;
	bh=x6p17aCP9nAeRV8ezd4QEa2x3QuIrWZ7K1WHUYnUd6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ty8PM4H2jqz7eVTevE8NUOAQUdoNNk+OEcI3t9g3QCkoPyNC5h0Oc07JHC7NtYmIo
	 Pk7eQV0LQEYp/RAGH4lW/y0AvsCJQPyMYjHH0sckGD084vd9y9alNhK0g9fZa9NHny
	 HFyVG0hAxqs5BcH75NL4M9Jz1laUWlKhnfR/fcnRd58rYAF796nGDaCK5QbaK32Lfc
	 9n3Z9BVQz0p/ErYA2VWWI3dqbvnNWgBRfEb4cSqyAl0eky9b/tABQUREUjTt0qCLKr
	 PpcfshutoKvxW0xSno4S6UcoXmLO4qJRDoxMugHfCPGPVZMy9ecCCyTHx9MEySp+YO
	 kDNNXq+7rJp1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable linux-5.10.y v1 1/8] bpf: Introduce composable reg, ret and arg types.
Date: Wed, 11 Jun 2025 09:16:05 -0400
Message-Id: <20250610165605-0d8fabc4a4ee9ec5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250610144407.95865-2-puranjay@kernel.org>
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

The upstream commit SHA1 provided is correct: d639b9d13a39cf15639cbe6e8b2c43eb60148a73

WARNING: Author mismatch between patch and upstream commit:
Backport author: Puranjay Mohan<puranjay@kernel.org>
Commit author: Hao Luo<haoluo@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: a76020980b9f)

Note: The patch differs from the upstream commit:
---
1:  d639b9d13a39c ! 1:  b9a913ca98c49 bpf: Introduce composable reg, ret and arg types.
    @@ Metadata
      ## Commit message ##
         bpf: Introduce composable reg, ret and arg types.
     
    +    commit d639b9d13a39cf15639cbe6e8b2c43eb60148a73 upstream.
    +
         There are some common properties shared between bpf reg, ret and arg
         values. For instance, a value may be a NULL pointer, or a pointer to
         a read-only memory. Previously, to express these properties, enumeration
    @@ Commit message
     
         Signed-off-by: Hao Luo <haoluo@google.com>
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
         Link: https://lore.kernel.org/bpf/20211217003152.48334-2-haoluo@google.com
    +    Cc: stable@vger.kernel.org # 5.10.x
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: bool bpf_map_meta_equal(const struct bpf_map *meta0,
    @@ include/linux/bpf.h: bool bpf_map_meta_equal(const struct bpf_map *meta0,
      enum bpf_arg_type {
      	ARG_DONTCARE = 0,	/* unused argument in helper function */
     @@ include/linux/bpf.h: enum bpf_arg_type {
    - 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
    - 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
    + 	ARG_PTR_TO_BTF_ID_SOCK_COMMON,	/* pointer to in-kernel sock_common or bpf-mirrored bpf_sock */
    + 	ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
      	__BPF_ARG_TYPE_MAX,
     +
     +	/* This must be the last entry. Its purpose is to ensure the enum is
    @@ include/linux/bpf.h: enum bpf_arg_type {
      /* type of values returned from helper functions */
      enum bpf_return_type {
     @@ include/linux/bpf.h: enum bpf_return_type {
    + 	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
      	RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a valid memory or a btf_id or NULL */
      	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
    - 	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
     +	__BPF_RET_TYPE_MAX,
     +
     +	/* This must be the last entry. Its purpose is to ensure the enum is
    @@ include/linux/bpf.h: enum bpf_return_type {
      /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF programs
       * to in-kernel helper functions and for adjusting imm32 field in BPF_CALL
     @@ include/linux/bpf.h: enum bpf_reg_type {
    - 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
    - 	PTR_TO_MAP_KEY,		 /* reg points to a map element key */
    - 	__BPF_REG_TYPE_MAX,
    + 	PTR_TO_RDWR_BUF,	 /* reg points to a read/write buffer */
    + 	PTR_TO_RDWR_BUF_OR_NULL, /* reg points to a read/write buffer or NULL */
    + 	PTR_TO_PERCPU_BTF_ID,	 /* reg points to a percpu kernel variable */
    ++	__BPF_REG_TYPE_MAX,
     +
     +	/* This must be the last entry. Its purpose is to ensure the enum is
     +	 * wide enough to hold the higher bits reserved for bpf_type_flag.
    @@ include/linux/bpf.h: enum bpf_reg_type {
     
      ## include/linux/bpf_verifier.h ##
     @@ include/linux/bpf_verifier.h: int bpf_check_attach_target(struct bpf_verifier_log *log,
    + 			    u32 btf_id,
      			    struct bpf_attach_target_info *tgt_info);
    - void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
      
     +#define BPF_BASE_TYPE_MASK	GENMASK(BPF_BASE_TYPE_BITS - 1, 0)
     +
    @@ include/linux/bpf_verifier.h: int bpf_check_attach_target(struct bpf_verifier_lo
     +{
     +	return type & ~BPF_BASE_TYPE_MASK;
     +}
    - 
    ++
      #endif /* _LINUX_BPF_VERIFIER_H */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

