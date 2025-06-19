Return-Path: <stable+bounces-154762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1184AE013E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757293B22E2
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D18D2820CD;
	Thu, 19 Jun 2025 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s24m5j8S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A1281363
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323792; cv=none; b=BDqP/rU+wIzTSsu22SzILm3iHVy92GdWhxDFYJCjqaKZc7AfeZoorWvgMPBT5RKFH+ah381X/+jERWSuGiARsmU4JVZPjDWCBdwCx2/h1+7JEQpSDyNkkYvOB7hinEUp687A4ZhRNUx8KKzMZtrj/wMbdzm8qpX7/ZGvFTRy0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323792; c=relaxed/simple;
	bh=JG3hiHiZgLVyT/V+xdkV90nibIJRRamZqu6NMhtSy7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNqVBfhOoK8BeMhes/+PY1fUoFtxEdFn7E+s/Ib7ZXKmum/mBGvdSMzZhdBGUEyLt3usA4Y5rMxf5Ebm7izjPzsnRnjeMi1Zf5Y57yjnfzcrKpVy7d7zUoz1sl5vDLQ/NhAyRyTEx5FU9//qlX757GZq51Y1+KbxRxOf0CUWNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s24m5j8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66486C4CEEA;
	Thu, 19 Jun 2025 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323791;
	bh=JG3hiHiZgLVyT/V+xdkV90nibIJRRamZqu6NMhtSy7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s24m5j8SpdxuG1ck5c9Rrla5a4c1n8m2wQrt1pQ6gQyvFN9H/atVnWXDZjbRA8Uta
	 xFe37mXLXi6QMTVavxi4D+gmIfK5f3RPS1qbo1KUIU1Vu3r85kYyr1dgIIbGKAXACN
	 HxoHBFCGpxKGvbY7Ofor8egXhwqUBAILfTOsKQmcvbpGSdAfkrhI4/THc1jlB6bqYn
	 1Z7g4//55qcPoFE+dBJ3J04N0VRsGWXP0lVFcTjOb6PXIUca0IrB4c8BdRaNhUaPEG
	 e3MmyDwN4GH/DZbb1zeLPIKLihqr4XKSTLZpOHMLDqDHJWPBFMWHQ7bC/vzqWkaNHQ
	 dc730jpudHMUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 08/16] x86/alternatives: Remove faulty optimization
Date: Thu, 19 Jun 2025 05:03:10 -0400
Message-Id: <20250618174718-f9be86a973410496@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-8-3e925a1512a1@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 4ba89dd6ddeca2a733bdaed7c9a5cbe4e19d9124

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Josh Poimboeuf<jpoimboe@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 73c71762fe98)
5.15.y | Present (different SHA1: 498afe80ce3e)

Note: The patch differs from the upstream commit:
---
1:  4ba89dd6ddeca ! 1:  8a0e833b52e48 x86/alternatives: Remove faulty optimization
    @@ Metadata
      ## Commit message ##
         x86/alternatives: Remove faulty optimization
     
    +    commit 4ba89dd6ddeca2a733bdaed7c9a5cbe4e19d9124 upstream.
    +
         The following commit
     
           095b8303f383 ("x86/alternative: Make custom return thunk unconditional")
    @@ Commit message
         Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
         Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
         Link: https://lore.kernel.org/r/16d19d2249d4485d8380fb215ffaae81e6b8119e.1693889988.git.jpoimboe@kernel.org
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/kernel/alternative.c ##
     @@ arch/x86/kernel/alternative.c: void __init_or_module noinline apply_returns(s32 *start, s32 *end)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

