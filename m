Return-Path: <stable+bounces-144671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E33B6ABAA2F
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E021B63B5B
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608191E1A3B;
	Sat, 17 May 2025 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1iCfchZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140235979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487286; cv=none; b=NI27UN1EemdRQKV8Pi7jcGLxtT5kD6cnRGNMYSoTDngx3WocHPQ1Hjsd+yCXGahDIM/zPO0/ib4q+iRARA8OMLgCphu2l/aEAxsysHUSKevwJbyFQdu9X+afV6ncx7mEHZOjFYcy1lpIPcMNKVu6D/kyXp6tvxJGcHkszVaaBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487286; c=relaxed/simple;
	bh=ChAIv5qddxcxMrZVZwpwXz8UOZZjQaXt3qZS9vus/uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1WGPlx5+bvb/V5+dkiJOVkMHESYWaa5FCDO/rUyWXfDlxfRQH6h6xBt56oVsMUW1ErNJZtuVrPZ/CnFm5CxZJjFULWr9kOy7Od/zh8GWW6PI0lHzfiLBtlZHRYWJrzHtPLikIJnOQLhw5I9Y6iKkp362ljE9cRq276Yb23rhJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1iCfchZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FACFC4CEE3;
	Sat, 17 May 2025 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487285;
	bh=ChAIv5qddxcxMrZVZwpwXz8UOZZjQaXt3qZS9vus/uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1iCfchZ4PLDcxMHla2PZZhTg7slJ2QPzpMZXwtSIXNgXyTBuT1Rf5OiDWQg8neXs
	 Vo2wIcFU7X2HY3GwCCjxoDgzk4hex+V9lNE5DuHZ1aR6IxsH/HlSEifsC1oVO1yR12
	 pJ5aRcnehbjRvj/DVD0xHg/Q7KW4fxIWsaxTjpJQaJXBDsUOFaPrBdsxKy8jTmRrSn
	 +PRsbhUY2M2b+9HU2QDBQyfQ+ePqHuof4YRYgJ99zqcCYRy2Uqia6F3NNc0Kzu8+cx
	 6YKlqYJYDiJBEM3DEuwUlkVW/DOVq+ezBXov8AB5KRn3KqEzV1XhiRS6942U13UOBj
	 vASmZ3IHHJpmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 02/16] x86/speculation: Simplify and make CALL_NOSPEC consistent
Date: Sat, 17 May 2025 09:08:03 -0400
Message-Id: <20250516212425-49b09642bb00be4a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-2-16fcdaaea544@linux.intel.com>
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

The upstream commit SHA1 provided is correct: cfceff8526a426948b53445c02bcb98453c7330d

Status in newer kernel trees:
6.14.y | Present (different SHA1: 010c4a461c1d)
6.12.y | Present (different SHA1: ca16a0acacd7)
6.6.y | Present (different SHA1: ffe12f8aa62c)
6.1.y | Present (different SHA1: 7f6da764325a)

Note: The patch differs from the upstream commit:
---
1:  cfceff8526a42 ! 1:  cf7360bfe0353 x86/speculation: Simplify and make CALL_NOSPEC consistent
    @@ Metadata
      ## Commit message ##
         x86/speculation: Simplify and make CALL_NOSPEC consistent
     
    +    commit cfceff8526a426948b53445c02bcb98453c7330d upstream.
    +
         CALL_NOSPEC macro is used to generate Spectre-v2 mitigation friendly
         indirect branches. At compile time the macro defaults to indirect branch,
         and at runtime those can be patched to thunk based mitigations.
    @@ Commit message
         calls.
     
         Make CALL_NOSPEC consistent with the rest of the kernel, default to
    -    retpoline thunk at compile time when CONFIG_MITIGATION_RETPOLINE is
    +    retpoline thunk at compile time when CONFIG_RETPOLINE is
         enabled.
     
    +      [ pawan: s/CONFIG_MITIGATION_RETPOLINE/CONFIG_RETPOLINE/ ]
    +
         Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
         Signed-off-by: Ingo Molnar <mingo@kernel.org>
         Cc: Andrew Cooper <andrew.cooper3@citrix.com
    @@ Commit message
         Link: https://lore.kernel.org/r/20250228-call-nospec-v3-1-96599fed0f33@linux.intel.com
     
      ## arch/x86/include/asm/nospec-branch.h ##
    -@@ arch/x86/include/asm/nospec-branch.h: static inline void call_depth_return_thunk(void) {}
    +@@ arch/x86/include/asm/nospec-branch.h: extern retpoline_thunk_t __x86_indirect_thunk_array[];
       * Inline asm uses the %V modifier which is only in newer GCC
    -  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
    +  * which is ensured when CONFIG_RETPOLINE is defined.
       */
     -# define CALL_NOSPEC						\
     -	ALTERNATIVE_2(						\
    @@ arch/x86/include/asm/nospec-branch.h: static inline void call_depth_return_thunk
     -	ANNOTATE_RETPOLINE_SAFE					\
     -	"call *%[thunk_target]\n",				\
     -	X86_FEATURE_RETPOLINE_LFENCE)
    -+#ifdef CONFIG_MITIGATION_RETPOLINE
    ++#ifdef CONFIG_RETPOLINE
     +#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
     +#else
     +#define CALL_NOSPEC	"call *%[thunk_target]\n"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

