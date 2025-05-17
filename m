Return-Path: <stable+bounces-144673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7726ABAA31
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C0F9E0F44
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2D61F4717;
	Sat, 17 May 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQUjrENk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD035979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487290; cv=none; b=UKTcctdyzBnduCz9kxpXV1duiTnQuEGuWzstMb4+HW2dlekXXnqyflsNQLzZyg+cl5qHLyVEaftfMuwmmnwHrzu/KW9SFCPd4cxdRYL06eQ3eP2gl2XIsSBkl9fJJAS+iywasiXojeLHNG1RItFnzZXRLu7M+GoKKky2se8GftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487290; c=relaxed/simple;
	bh=+tLk4Ln/zEDLukQZ3huppC6QgB2EZ6BlskJHFm2Gjlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJAyr8zK+sYG/3rQWLBZGx6kNdx6gyVlBrjo6uxJ+/NI8HCMhTEpzax9P01YMb30n+Ww9aulphEMX92h3qSCe5PXYawZ5ko+BWtkfMTL4eyjDhqBWPtc+Rzd9Wr2I3pBnNcrCxaUPYWeytGy64sUlqYWURQSGxI59NILQz3ze9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQUjrENk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA837C4CEE3;
	Sat, 17 May 2025 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487289;
	bh=+tLk4Ln/zEDLukQZ3huppC6QgB2EZ6BlskJHFm2Gjlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQUjrENkWnqYoZoK673Ga8/gMtrEMfH/H7NspUkBixHgqqiOmXsCNx2a9DkdrRVO1
	 KPNkOJaO3h0+Oulq8WwSSWa+AfoNA2WlgRv25ZTfm1vs80uT/s7LfYAVTnarhpN5/t
	 JnxQMl8rKt1IQRtR4gcPpiaQpS4E7yCRUXxeWucCzMDHANoz1ObjLfuEDKvAeeX0F9
	 13iSiM1CaUIKnnrw08PTHR/pAGu6y0ORPgvFMznfE1HaDG31OsHSDN20XFOVUf88D8
	 hM7nT24aPB0xJDHj+gvoqt7tV2Cw6CwzEiYg4dMLhALkPE6ZC4iwMxPDoT6KeiQt/d
	 cCzQMtb/mH6SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 13/16] x86/its: Align RETs in BHB clear sequence to avoid thunking
Date: Sat, 17 May 2025 09:08:07 -0400
Message-Id: <20250516220840-ca864d29a5d9e5e1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-13-16fcdaaea544@linux.intel.com>
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

The upstream commit SHA1 provided is correct: f0cd7091cc5a032c8870b4285305d9172569d126

Status in newer kernel trees:
6.14.y | Present (different SHA1: bd83f74dcbb9)
6.12.y | Present (different SHA1: 56aabf26bac5)
6.6.y | Present (different SHA1: fb3103513d53)
6.1.y | Present (different SHA1: 31e4ffa249de)

Note: The patch differs from the upstream commit:
---
1:  f0cd7091cc5a0 ! 1:  fde65bafa97bf x86/its: Align RETs in BHB clear sequence to avoid thunking
    @@ Metadata
      ## Commit message ##
         x86/its: Align RETs in BHB clear sequence to avoid thunking
     
    +    commit f0cd7091cc5a032c8870b4285305d9172569d126 upstream.
    +
         The software mitigation for BHI is to execute BHB clear sequence at syscall
         entry, and possibly after a cBPF program. ITS mitigation thunks RETs in the
         lower half of the cacheline. This causes the RETs in the BHB clear sequence
    @@ arch/x86/entry/entry_64.S: SYM_CODE_END(rewind_stack_and_make_dead)
     + * Target Selection, rather than taking the slowpath via its_return_thunk.
       */
      SYM_FUNC_START(clear_bhb_loop)
    - 	ANNOTATE_NOENDBR
    + 	push	%rbp
     @@ arch/x86/entry/entry_64.S: SYM_FUNC_START(clear_bhb_loop)
      	call	1f
      	jmp	5f
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

