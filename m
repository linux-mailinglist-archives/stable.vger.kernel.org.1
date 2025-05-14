Return-Path: <stable+bounces-144442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D78AB76A0
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E631BA67C1
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30915296700;
	Wed, 14 May 2025 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcvaK1TH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402C29617D
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253686; cv=none; b=qDgxRBXYugIu4dyTzHqPRXk35eT6NVU7wphDeVUVU0UWCGmyHWX/K+oD3xRF81CCzawL9BoD4eKjk5qS69xQOFl0xJMIUqX7vfUhyydq6hisUfONR6pcNW1VEpJ6QokVXxsnhVYIskzijSKZ44ds901jF+wKAFUizpmip94tzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253686; c=relaxed/simple;
	bh=QC32h1YVM5SO+La742WjPrET5yaxMI4ogCT5xt974P4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugKZ8zZXcnsH79s3vM5J/KjEXQ3BH76KBullirVPukSKjWT7A2lst0n6/aQbLgt8xCdHbR1fqKpBzJ0q7PbOnclAwo6D4Oq3geuPWr/M5A5P/U+C8Cp4t1TEINL+FPY2i9+oWggs6z++ej/fyS6RWKG49pdDzi2q/RLG7ieqc3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcvaK1TH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F177C4CEE3;
	Wed, 14 May 2025 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253685;
	bh=QC32h1YVM5SO+La742WjPrET5yaxMI4ogCT5xt974P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PcvaK1TH561noanv1O+sFm9D7zJOl8lLWxGbOUSlG9S9XIJMM0qYkbyJ/Mfb5pQ7X
	 SC+HEFyokzQ61yWKwc9t2nK1c+tN+/PXXJIeF6dUEROHbXwfkTp6SLehDstTuQqwr/
	 uJLE4tm9PGjcUL3IBYq63eTnLAPnlGHhLrPSfoF2VgU3e87Hk8qLUjIKFWtAMBtfoK
	 cRNvvrhhzTU6vkufJHopPxp0asSv8T5T42/pFLGu2/em1SEUfm1HBGwAHOv6ZojB1t
	 SQJoyV0mZkjiBJOu6Jumzo9ZD69ohIu0u1cug+1IoFBDa6u7cya76oUmo2v7pZaWC3
	 GxYe53BSHmJLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 02/14] x86/speculation: Simplify and make CALL_NOSPEC consistent
Date: Wed, 14 May 2025 16:14:42 -0400
Message-Id: <20250514105650-e8ba823bdb7dd53a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-2-90690efdc7e0@linux.intel.com>
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
6.12.y | Present (different SHA1: e15232fbbe9b)
6.6.y | Present (different SHA1: af0a7b28d776)
6.1.y | Present (different SHA1: e6b48a590f7f)

Note: The patch differs from the upstream commit:
---
1:  cfceff8526a42 ! 1:  20ca28ff575b3 x86/speculation: Simplify and make CALL_NOSPEC consistent
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

