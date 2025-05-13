Return-Path: <stable+bounces-144221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA83BAB5CA4
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B2B19E7703
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E492BE0FB;
	Tue, 13 May 2025 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLbtJwLz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D84748F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162106; cv=none; b=VudQrmdIazikJlSxLXFpLBIMiXpax7FeHFWYYD7p8VahdOmdZhMTd89R+yH7hpxqN9bPOzuxcZP2OJu+NWUoMsEKdP5LhhSTU34CCriOJzb1wclTFhnrKmimT+z8WNLahoApBtPtkWMeF5XihpMu3ZO/qHDl4rAbVaZzploJQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162106; c=relaxed/simple;
	bh=jxd9XAtMQaKIhCcKwLxLBkE4yJsTAIyTnh8yRqgIsEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeNvgSyflMAN7K9eyUFMjbmfgRZ7NHsVM7GSVoQ+Ts+eZL0xfUyiLVdNy9M3SRfWLacPhUuNbcEhcUx2EGp47lBPFg20JIKYez89/7b7X5iBbhPWhF4f3Gh/NxkTgF8H3rcp2EMK5emEqhuR7SuGtx5LpD4nG6abZqjtvEFi/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLbtJwLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA24C4CEE4;
	Tue, 13 May 2025 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162106;
	bh=jxd9XAtMQaKIhCcKwLxLBkE4yJsTAIyTnh8yRqgIsEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLbtJwLzNf1PQc9YJc3RlOObrXTFJVzvAdbh+iCkVY9JyRmKIaP6xEzlN3cW4JD4q
	 VphVwZTd+YHr4bEMlXuAUAzXelPedagCVqazITsRlyH0zkTCzHqGQI52Dqmgbbw+lF
	 580qC6XastIclDNTSoBSEpMNgV2HO9Le8xXrN58CZ5FZ6NjeZ7ick8HyBrLG+e/7sc
	 l96GBWeEh418XBMw8OqjRtw8CAHmIGJtaGqcVSMvgP4O+1HyhfRSuHvOleKKFxECVj
	 MGcAL3ETSGenRdky4Txywlq7Z4BM7XMGYnDic1+I7IUQaTyZr2SX1TkBlC6Bwh4aGn
	 eJEQMsuL95DHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bin.lan.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG
Date: Tue, 13 May 2025 14:48:22 -0400
Message-Id: <20250513115256-7b06b93450f52b6f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513064308.1281656-1-bin.lan.cn@windriver.com>
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

Found fixes commits:
a552e2ef5fd1 bpf, arm64: Fix address emission with tag-based KASAN enabled

Note: The patch differs from the upstream commit:
---
1:  19d3c179a3773 ! 1:  5d90fc4a6da2b bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG
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
| stable/linux-6.6.y        |  Success    |  Success   |

