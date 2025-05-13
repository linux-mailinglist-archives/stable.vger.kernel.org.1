Return-Path: <stable+bounces-144236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A2BAB5CB3
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAE119E7E25
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9EB2BF3E9;
	Tue, 13 May 2025 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1ValxdL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288DD1B3950
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162171; cv=none; b=bDP6SNNUKz/UNXPouOR+kpRXAJaIlLcbvBFVASot/F0eEFL6EAGXTudTOXdneMB6U5m3rZKQ2BstkvTIrsRkn4F+ntBpuuKta9Y7lxukIemXzdCw6Vxb9O3vUesGlvkNmdhxsy/S85ek63qGBtc6ASRMke/lL/PRKnCT73vXt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162171; c=relaxed/simple;
	bh=J3YjAS6IwjMvrIIwipr5QIevejqgTcgFvFcfP/ihdlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snI/A0g4qw8Ed67Mbdl5QG8BmAmqa5NvDPR3VKjFk74L6MjbFozY+ExffOP8kXmKW24Prj/poeaS6dNUmIdGx3s+lHkidH3Xk+fY/XmR6GYM/7OTcDVFw+xPfWmbPYCTcv22T+fDeEX/8x8RW1xYcF7fvZ6/kxN9oD4sZDzS2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1ValxdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A523C4CEEB;
	Tue, 13 May 2025 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162171;
	bh=J3YjAS6IwjMvrIIwipr5QIevejqgTcgFvFcfP/ihdlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h1ValxdLybx5KqpEKIxLS4VUvd52OvMeAFAdbCSecfB0OQZAwFLkogtosw+Q3LyN4
	 RHwzuTLC+OO1Q8N0H8voCKtjmqUPYKjeMwqHAjQt3cvtwKkcwRpP7TRstwYGGFrWhX
	 93SbLBXZlBI9UrcBfeVq3fghfRmMsbocLXOjHwi2NtePt+n1zJsQe8tYELXopk9KNM
	 0T5bx4OErgh/YtKVioC1EuMmy3G2u4JqPhHvdSRdEqOvhSmMk7rOknx/Uc/6lKw9/p
	 yzHuNbNvvuWpgKHnZVIIsvGlBikCCmJJWWD+CnD5jgFUWjWx3d85GSrdWeuB+KXaMg
	 2H3XF27WMRMAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bin.lan.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG
Date: Tue, 13 May 2025 14:49:26 -0400
Message-Id: <20250513111935-e09a7b4ae6ee8822@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513064511.1282935-1-bin.lan.cn@windriver.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 19d3c179a37730caf600a97fed3794feac2b197b

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Puranjay Mohan<puranjay@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Found fixes commits:
a552e2ef5fd1 bpf, arm64: Fix address emission with tag-based KASAN enabled

Note: The patch differs from the upstream commit:
---
1:  19d3c179a3773 ! 1:  1aa523ed63730 bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG
    @@ Metadata
      ## Commit message ##
         bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG
     
    +    [ Upstream commit 19d3c179a37730caf600a97fed3794feac2b197b ]
    +
         When BPF_TRAMP_F_CALL_ORIG is set, the trampoline calls
         __bpf_tramp_enter() and __bpf_tramp_exit() functions, passing them
         the struct bpf_tramp_image *im pointer as an argument in R0.
    @@ Commit message
         Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
         Closes: https://lore.kernel.org/all/SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com/
         Link: https://lore.kernel.org/bpf/20240711151838.43469-1-puranjay@kernel.org
    +    [Minor context change fixed.]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## arch/arm64/net/bpf_jit_comp.c ##
     @@ arch/arm64/net/bpf_jit_comp.c: static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
    @@ arch/arm64/net/bpf_jit_comp.c: static int prepare_trampoline(struct jit_ctx *ctx
     @@ arch/arm64/net/bpf_jit_comp.c: static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
      
      	if (flags & BPF_TRAMP_F_CALL_ORIG) {
    - 		im->ip_epilogue = ctx->ro_image + ctx->idx;
    + 		im->ip_epilogue = ctx->image + ctx->idx;
     -		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
     +		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
      		emit_call((const u64)__bpf_tramp_exit, ctx);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

