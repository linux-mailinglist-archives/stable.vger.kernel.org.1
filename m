Return-Path: <stable+bounces-144238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CCDAB5CB7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA78719E828F
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FA1E521A;
	Tue, 13 May 2025 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kADOG+tB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49122BE0FB
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162179; cv=none; b=NOHKBIbp6CA96MUMBw/+D6hdUUKrhiTT5J0ihRh94tn4TI1L89T/XrZoF7v04r+4L199acDtEjalX9dBrTNbOgMinCdUgaEIrWw8w/m3Yu6k6SOOoCbDb/xUmr/fzWa1Rd+qI/cTUeI580YsdsJid1UiOe0tqEa2OPYvw0sUEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162179; c=relaxed/simple;
	bh=wS4MhvyQW/3xPKZMbA6vtb8AHWUWgWGfyeXe6lI6rKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZ1Uq5hUo1KF/Za872HNNYg6gWN3vAioQ5QaG0MmDZl/zFTKL3Y+yWYAmxkHEAUXXcUj31BoFpk/pJR0TxgvYcnlWktlKVA7xMPZKGnKNTillw4wNEZ1aO2+7HcXCj1tFcvPNnHwuJeKp6RMX0xbqO5blc5+m3w4ejPwJngXCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kADOG+tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAFEC4CEE4;
	Tue, 13 May 2025 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162178;
	bh=wS4MhvyQW/3xPKZMbA6vtb8AHWUWgWGfyeXe6lI6rKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kADOG+tBEV8P4zsWxakYUbxbn7sKd61bs18vmspt5lS1mT9gYbgogVs4v+2+XoONf
	 z6OPN/dwOxXyvvCkP6aGRamQSXZUTnwYwAxs5s+GASFCCPSxerwqFx20UKGxJDAnGP
	 UOiZiu5oumAdinztCFyb6Eib8+24Eqky7SyZSU9EbDM3962AxTpvXr6PIvD9jffK0v
	 uybgYRdqAq+0VpqJtSnuFkF1wSSjOjOJ9mP5lbKZdXNXphtGncf0FzGdbOwI4BmHtW
	 qkUXpRnAK/8jIlvRurnF8kDfb37tYMvCWGSFyi++n2YupSYn0LtJey+rOdaU0q3bGW
	 Cj9ybdJwqQ1ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] bpf, arm64: Fix address emission with tag-based KASAN enabled
Date: Tue, 13 May 2025 14:49:35 -0400
Message-Id: <20250513115716-278036272181a9f0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513064308.1281656-2-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: a552e2ef5fd1a6c78267cd4ec5a9b49aa11bbb1c

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Peter Collingbourne<pcc@google.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  a552e2ef5fd1a ! 1:  c1cc7847f8445 bpf, arm64: Fix address emission with tag-based KASAN enabled
    @@ Metadata
      ## Commit message ##
         bpf, arm64: Fix address emission with tag-based KASAN enabled
     
    +    [ Upstream commit a552e2ef5fd1a6c78267cd4ec5a9b49aa11bbb1c ]
    +
         When BPF_TRAMP_F_CALL_ORIG is enabled, the address of a bpf_tramp_image
         struct on the stack is passed during the size calculation pass and
         an address on the heap is passed during code generation. This may
    @@ Commit message
         Acked-by: Xu Kuohai <xukuohai@huawei.com>
         Link: https://linux-review.googlesource.com/id/I1496f2bc24fba7a1d492e16e2b94cf43714f2d3c
         Link: https://lore.kernel.org/bpf/20241018221644.3240898-1-pcc@google.com
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
     -		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
     +		/* for the first pass, assume the worst case */
     +		if (!ctx->image)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

