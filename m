Return-Path: <stable+bounces-144252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC6AB5CCA
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E70172F1C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458BB2BE0FB;
	Tue, 13 May 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIIYnF1r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054638479
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162238; cv=none; b=ecHkgQOwU6iBzjkjyzFf75MrIVhHwDp282nQc5mGN8x3DTOIzNf3AGnejkBaWgel9a1QehISfBRs/lkJCJumyGcoHHOGPiNaqG/DZzihvx0bMhi4EE0rJCowyPXOPM4gGRwQKbZNSGNuDcik6SGXJx7eBCldNkK0hfzgMTgcfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162238; c=relaxed/simple;
	bh=5DLBOkuL4TJIPz7m8Cyp+sUJyKu/lfQjJO/n8sWRtn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYsN+WY8DQR3rc0Yl2dBa57e/CBTttVhc/UkadF0NwpPui0F102H1aifQSil763BGTHCAKbwRVALzrhM2sXP9QAKl/nHwjz3g11zcThwDZQCzMXQb4vatxOAYiKe3VPxcj3DQFiNu/dZSvPETUsb2EEIbT6EtKL6k2zYu4HUtu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIIYnF1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737CDC4CEE4;
	Tue, 13 May 2025 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162237;
	bh=5DLBOkuL4TJIPz7m8Cyp+sUJyKu/lfQjJO/n8sWRtn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIIYnF1ryrBtC8eCPYOJ1oNpdxwq3Xj2Y8GJXZnXKdKR1NK6CkB2LxYTzfNBCzjw4
	 pejiiwaY8Oq6sP2uzy+4wHM+XSvJtyQgkxoe9VZfu3+xMbLKaAE5d64C5xfXSu+2QM
	 71lEnmiOV9O1lnD31CyIzbFwH8AtrRjd//14MYUYbic3+WgPjFokNqt6sNeqW4MJrT
	 7fIPZ8U0WSCvFTU8HSciP8N4g+Bo4GE1+1bt+23p8egq/4bdCephBb44MK+qbVVB02
	 9RAqJnMCYTyMGd8dUsZH82PJWDXRcMPvsoY9rQUZ+fKZg9wLjxfvN+JzPyuK1vRb1o
	 pjcP6+XOdeOLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 13/14] x86/its: Align RETs in BHB clear sequence to avoid thunking
Date: Tue, 13 May 2025 14:50:34 -0400
Message-Id: <20250513141606-f82cf6d584d2cb31@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512-its-5-15-v1-13-6a536223434d@linux.intel.com>
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
6.14.y | Present (different SHA1: 375fe8890b23)
6.12.y | Present (different SHA1: 5eaa60e1baf1)
6.6.y | Present (different SHA1: f17249f8a872)
6.1.y | Present (different SHA1: 724e897203bd)

Note: The patch differs from the upstream commit:
---
1:  f0cd7091cc5a0 ! 1:  4b82567ce6916 x86/its: Align RETs in BHB clear sequence to avoid thunking
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

