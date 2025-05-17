Return-Path: <stable+bounces-144681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E43ABAA39
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F024A5103
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EB51F417F;
	Sat, 17 May 2025 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUvI/8kw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028BF35979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487305; cv=none; b=QpChvqVZweSKD74PIVX3rtGUE1lfGzRMUEW8cCbaMXMHjqQuA3tSGLsWmrvU2QrzcRWc5O4MaZnRpp8TNleBGgSxFVCzG0eJnpr6OaOwrOpKC4tnEbjG44WRPc6mk9nP0Pwn2UHt8RhNSGTLinW+ZRAzBGvJQM1zgFRtl9MBBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487305; c=relaxed/simple;
	bh=MAqILwmzxGtp4hBkJnJBdJJ3RN2+kGwXOnJIdp0zhz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4lQOz7MVkKBBfgJMTdDAngRd+TkuWk21bZ83NjnV1t4cbBhkxsmasQmORhT9y/zsVc8FELN0RVZDN9M1oD3wcR3+7A3lrAIIZUJMOg9d+MxeGQ7rq7zmEuXoswqK1FNZYwVt1eC/ue+jN9PbqZRWGcL/TrHVur3bWvV/c7aMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUvI/8kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABC4C4CEE3;
	Sat, 17 May 2025 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487304;
	bh=MAqILwmzxGtp4hBkJnJBdJJ3RN2+kGwXOnJIdp0zhz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUvI/8kwdKVMZFvZsQJm9U5se64nEO4KvPVBIiUbsCEFROyLPFPym8fJ/IVj+pNq+
	 w9E7e2pAKQVUqSPf74pIJFGHjYsxyenQHJq0disXkcZ8HW4CKyZT8FeeeJchJfb38I
	 tz3Mf+5vHsUcsiKVgzKY5Ay0RAi5C3zKQX3B6OAXwbJ+0ET+5Ag5zKKQHQAZ1TwyYc
	 NkHxKB+cXkH4LLHmp8CXxv8TLFVT75a4Il8EeMbpSlk30r0JEh51x+MQ0LFQ2wMo9C
	 CRqvxCQC7CwUW5WJJbjJHZGRNRIJKjELxD27l3rPAmY4ysTe6bkzm3+IdnlRItfJm5
	 PikDVJuuk416g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 01/16] x86,nospec: Simplify {JMP,CALL}_NOSPEC
Date: Sat, 17 May 2025 09:08:22 -0400
Message-Id: <20250516212024-7cb18dbd2ddae55f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-1-16fcdaaea544@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 09d09531a51a24635bc3331f56d92ee7092f5516

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Peter Zijlstra<peterz@infradead.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  09d09531a51a2 ! 1:  c6ae69642e75d x86,nospec: Simplify {JMP,CALL}_NOSPEC
    @@ Metadata
      ## Commit message ##
         x86,nospec: Simplify {JMP,CALL}_NOSPEC
     
    +    commit 09d09531a51a24635bc3331f56d92ee7092f5516 upstream.
    +
         Have {JMP,CALL}_NOSPEC generate the same code GCC does for indirect
         calls and rely on the objtool retpoline patching infrastructure.
     
    @@ Commit message
         compiler generated retpolines are not.
     
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/include/asm/nospec-branch.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

