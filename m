Return-Path: <stable+bounces-103900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D639EFA2E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C08D16914C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D0E2153EC;
	Thu, 12 Dec 2024 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE+1Or+9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D21714BF
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026246; cv=none; b=UUFL4z0seVTO57VXL94BuY5DsSVbVUDqu1ygm/Tjnr91aSmqV1TVBsA++LqD6yG58P1iCXN9Jm0TggSlL37R1lzJObYm9pXtcnR013nJkw38PjOlucpW5CqL7smD7YP49Gi91mB+4o98goKZavcuUeup09vl/uDEbbDCC/h8R4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026246; c=relaxed/simple;
	bh=1SHZDLOSfdbfOZvXRGC9teKE9/GF7f5jfuWdcp63uEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q63UkkH/TBdR7nDilbc8bPCltGhcrPQr9g/lMKuSUr5Pd5OHVivoW3TbIdWCjuoO5BIKrxkZDag09wE2xEw5q7QzX5sgh+PYAYk8Q4no6wcTbJTN7OksBzqvWxSLaDDF0gKpPG8HsEiGIpMJsyJwJkrCjfEjFwWd2ybvLtr6it0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE+1Or+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF7EC4CECE;
	Thu, 12 Dec 2024 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026246;
	bh=1SHZDLOSfdbfOZvXRGC9teKE9/GF7f5jfuWdcp63uEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kE+1Or+9eWjyN2lVBtsRZWezBZd8oev/MyZo4qv74DDwyLqNWqT5fr40KoE+9OUgl
	 eYQWyOsLdS0fMN7PcNDkHnFbNDU0tk1B4p8hGX19uebLgs+WMkcxSCoXBiFIfVpxsK
	 r4cgPQYa570nrqwejuMVTeK377rNKaF2uPbyI+wAnQanMEztDIjMtYI8MDj/3ORHXG
	 5EXBx3SaiSELcWkqnHnRsl4v9XzdP//i3hlrCmwPO/w+PaStYbHEsOrFhkzJqi7jF7
	 FnCYiRMAw0+NDXKflbzNtjcHaC5w24zRv4lhlvoqBR6xAk8H670bH7S7nmvHEl/0mV
	 7XHynwmZ0BTlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] bpf: Fix helper writes to read-only maps
Date: Thu, 12 Dec 2024 12:57:24 -0500
Message-ID: <20241212070249-5708a60f112b0bfe@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241212025950.2920009-1-bin.lan.cn@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 32556ce93bc45c730829083cb60f95a2728ea48b

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Daniel Borkmann <daniel@iogearbox.net>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a2c8dc7e2180)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  32556ce93bc45 ! 1:  902e11e97536c bpf: Fix helper writes to read-only maps
    @@ Metadata
      ## Commit message ##
         bpf: Fix helper writes to read-only maps
     
    +    [ Upstream commit 32556ce93bc45c730829083cb60f95a2728ea48b ]
    +
         Lonial found an issue that despite user- and BPF-side frozen BPF map
         (like in case of .rodata), it was still possible to write into it from
         a BPF program side through specific helpers having ARG_PTR_TO_{LONG,INT}
    @@ Commit message
         Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
         Link: https://lore.kernel.org/r/20240913191754.13290-3-daniel@iogearbox.net
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    [ Resolve merge conflict in include/linux/bpf.h and merge conflict in
    +      kernel/bpf/verifier.c.]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: enum bpf_type_flag {
    - 	/* DYNPTR points to xdp_buff */
    - 	DYNPTR_TYPE_XDP		= BIT(16 + BPF_BASE_TYPE_BITS),
    + 	/* Size is known at compile time. */
    + 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
      
     +	/* Memory must be aligned on some architectures, used in combination with
     +	 * MEM_FIXED_SIZE.
    @@ include/linux/bpf.h: enum bpf_arg_type {
     -	ARG_PTR_TO_LONG,	/* pointer to long */
      	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
      	ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
    - 	ARG_PTR_TO_RINGBUF_MEM,	/* pointer to dynamically reserved ringbuf memory */
    + 	ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
     
      ## kernel/bpf/helpers.c ##
     @@ kernel/bpf/helpers.c: const struct bpf_func_proto bpf_strtol_proto = {
    @@ kernel/bpf/verifier.c: static const struct bpf_reg_types mem_types = {
     -	},
     -};
     -
    - static const struct bpf_reg_types spin_lock_types = {
    - 	.types = {
    - 		PTR_TO_MAP_VALUE,
    + static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
    + static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
    + static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
     @@ kernel/bpf/verifier.c: static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
      	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
      	[ARG_PTR_TO_MEM]		= &mem_types,
    - 	[ARG_PTR_TO_RINGBUF_MEM]	= &ringbuf_mem_types,
    + 	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
     -	[ARG_PTR_TO_INT]		= &int_ptr_types,
     -	[ARG_PTR_TO_LONG]		= &int_ptr_types,
      	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
    @@ kernel/bpf/verifier.c: static int check_func_arg(struct bpf_verifier_env *env, u
     -	}
      	case ARG_PTR_TO_CONST_STR:
      	{
    - 		err = check_reg_const_str(env, reg, regno);
    + 		struct bpf_map *map = reg->map_ptr;
     
      ## kernel/trace/bpf_trace.c ##
     @@ kernel/trace/bpf_trace.c: static const struct bpf_func_proto bpf_get_func_arg_proto = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

