Return-Path: <stable+bounces-144239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BDAAB5CBC
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935B64A4E56
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576E2BF964;
	Tue, 13 May 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAZIz6jb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A498479
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162183; cv=none; b=P4CRq2HTYL+QU07vVfL8xb2Uw5W7rXht/HUX9wmuhNHpRRngRNVF69eVveUH9WJZGIJS3AuX9XEFdLLQ8vHZODghEWgLu50iPrnOgXTwEOgw2Tnzdr3w9dBqOREcJOA1cPo2Rmno13sWiDeseVkgrr0v8mynqwCO0lUhz3VJtjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162183; c=relaxed/simple;
	bh=LQqXJ9iTeCjoSg1Ps4KYz9FyXj5lCzYSei8eQ48KZjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcRlwJBL7vlzyt/zPgmLp4W2w9im34TF6+1k8Q+fRfTU19EmJtAZCjEmknhG3O0aDkUqGTekNCW5o4Ewy5V2KqOcnQR8J+qJ1kbARDwT4aQCWRyPs+zrTPDk/XZ0Gh1b6DZLwz2AlL2jG7D4YpRCZms1Baz2KXNW0obsj9J0Djo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAZIz6jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2076C4CEE4;
	Tue, 13 May 2025 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162183;
	bh=LQqXJ9iTeCjoSg1Ps4KYz9FyXj5lCzYSei8eQ48KZjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAZIz6jbVR5LxsfgXQ4QLRrqSq8EvIyogldVup7e0AWe3lAJH9S6hYWwUFYtnyI6P
	 k5sA9paj1nkd3zXy3FiQ8CfUO2XCeFXjcotjCeuz5h4nwfWiXZCtHhvQ5m0cI6a0Hb
	 +dXO1fLtQpJqLAQatuxYSbj17kEpRJ3YEqUYOMQxZhPBz4xIpn+ovqzbHfD9ikTCP2
	 Hu9A29k2C7hTgI5eEYhIu7QmrEc1sTfjni9nez0soY3UAckkl/sZeoMolSMIRfquLc
	 y2tXIhjLJ5Fklk1mbkiGr0QEnCQd2oG4fEzC5y/DE7B1kzPogRjhMepM0PVLCb+8Hr
	 FshDxs+qOtvWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] bpf, arm64: Fix address emission with tag-based KASAN enabled
Date: Tue, 13 May 2025 14:49:39 -0400
Message-Id: <20250513112427-b766217841f10d25@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513064511.1282935-2-bin.lan.cn@windriver.com>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a552e2ef5fd1a ! 1:  f5313793f7e10 bpf, arm64: Fix address emission with tag-based KASAN enabled
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
| stable/linux-6.6.y        |  Success    |  Success   |

