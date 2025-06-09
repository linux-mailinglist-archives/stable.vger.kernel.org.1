Return-Path: <stable+bounces-151973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484EAD16DD
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EE4169068
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E322459EE;
	Mon,  9 Jun 2025 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUavVAIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FFF2459C9
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436476; cv=none; b=rpdZ6Ja/hUAaDS4MMwbwL9YU34dqamB5hYXmL25vZkhPRSoWynTeW9Tnndj+aqHMgqnZXODpLizECQ8MjUDBuaInFJBhmyXD/1G/4yZlo0vpIRxYrEsQe+5+pSKFARHDMmNbX6dcsXNTvF2QGRS9RmDW0hqlT1Iuk9l7hhEMd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436476; c=relaxed/simple;
	bh=vK13c+a/Rh7TWqebsrLL5siBKx70fpCk6bXEbYZQcJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5jNM+PBVqWOx8DgM8nBycbn8Q5TQ1omhlLRA6qSQZ02UH///6ol7P657EaksrGlQMewO8BChpH1/Vb7deVZp1uhFF1yyuLLtwAVqM3xeW8fOOg/K9/r+deW5dCaMJBM3MhlquW4snkkajtylOJDk3olrB4ow+dwqKCRyWjTNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUavVAIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B67C4CEF0;
	Mon,  9 Jun 2025 02:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436476;
	bh=vK13c+a/Rh7TWqebsrLL5siBKx70fpCk6bXEbYZQcJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUavVAIB6WcAPjmKwQcVAfE7hhe5eJwZlLMIqv4ZO2lt+1V+KQq8mpV82oMOaEsq/
	 fzXya4Hps0CEOs7udTks2pgAzj9aaMhTntJX5BM12v2Sbddz1RLroqpsXr6/yfabNZ
	 3rOc082u+dt0pNYbQUVn6dvP82JCCwvKaJrFIuw/6q1yNMMHCc+9ApjhB2leI4Gzqd
	 /YpUbfZmq6eBf4GDes+AdOTHk4BeygdaMcKFxwuI61/dg77OuIhg5F6ks2qxAMr1lo
	 5T8d+C+K3lDXNqqd1s+FwcLTPiYhjlXjoyWg0P/sCsvZnrtGrr50TAEmJTxchvKREj
	 hKKuE1RgwBZSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 3/9] arm64: insn: Add support for encoding DSB
Date: Sun,  8 Jun 2025 22:34:34 -0400
Message-Id: <20250608151904-818b187a7549905b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607153535.3613861-4-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 63de8abd97ddb9b758bd8f915ecbd18e1f1a87a0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: James Morse<james.morse@arm.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 1e1963205784)
6.12.y | Present (different SHA1: 2a3915e86187)
6.6.y | Present (different SHA1: 054fc98d691a)
6.1.y | Present (different SHA1: cc0b8e148c33)

Note: The patch differs from the upstream commit:
---
1:  63de8abd97ddb ! 1:  97289ab86ac0c arm64: insn: Add support for encoding DSB
    @@ Metadata
      ## Commit message ##
         arm64: insn: Add support for encoding DSB
     
    +    [ Upstream commit 63de8abd97ddb9b758bd8f915ecbd18e1f1a87a0 ]
    +
         To generate code in the eBPF epilogue that uses the DSB instruction,
         insn.c needs a heler to encode the type and domain.
     
    @@ Commit message
     
         Signed-off-by: James Morse <james.morse@arm.com>
         Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/insn.h ##
     @@ arch/arm64/include/asm/insn.h: u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
    @@ arch/arm64/include/asm/insn.h: u32 aarch64_insn_gen_cas(enum aarch64_insn_regist
      #endif
      u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type);
     +u32 aarch64_insn_gen_dsb(enum aarch64_insn_mb_type type);
    - u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
    - 			 enum aarch64_insn_system_register sysreg);
      
    + s32 aarch64_get_branch_offset(u32 insn);
    + u32 aarch64_set_branch_offset(u32 insn, s32 offset);
     
      ## arch/arm64/lib/insn.c ##
     @@
    @@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_extr(enum aarch64_insn_variant varia
      	insn = aarch64_insn_get_dmb_value();
      	insn &= ~GENMASK(11, 8);
     @@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
    + 
      	return insn;
      }
    - 
    ++
     +u32 aarch64_insn_gen_dsb(enum aarch64_insn_mb_type type)
     +{
     +	u32 opt, insn;
    @@ arch/arm64/lib/insn.c: u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
     +
     +	return insn;
     +}
    -+
    - u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
    - 			 enum aarch64_insn_system_register sysreg)
    - {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

