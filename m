Return-Path: <stable+bounces-144223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11373AB5CA9
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D8864A00
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5042BF3E9;
	Tue, 13 May 2025 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKcZzXSB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7FB748F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162115; cv=none; b=Ln+2EXF4//SzAIR7xA+slGnbNEF0f6wqSzjf/vTEMLa5KIVIOf503KobvgEWelDZtUd+EE9PepOoaE4UsXYd9dA7YGoQF1GUHVVad/KNW+suhbgg0lNRUUdk29AYsdZY01gGsf5nVpEKrb4s6vKzcj3dW/muK773ds65mHPyLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162115; c=relaxed/simple;
	bh=hpVT3/T6Ng9SBNyg9WOI9YxTatfoYjw6sU6dyB+70IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFL0NILLYDeT70rej72oss5M2UYO8IjWmAZfFp/9wJIP6HMtxMj41EdG5iL76p4Er44vkq00cXsUa4wdTKQ1g8cmZr2deDbKAk9lcTReuXxjD/Mw2opjpxg0kQoE6HIyAC6v39Av16n8QIqqpCI2A1XQYxcv1wRyPITk1tIEpqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKcZzXSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC30CC4CEE4;
	Tue, 13 May 2025 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162115;
	bh=hpVT3/T6Ng9SBNyg9WOI9YxTatfoYjw6sU6dyB+70IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKcZzXSBMqWAdoOUzsCGisvB3vDINQV0cpJPielYdc0MX9I8zTC+lDtxYzl2zdzjP
	 a7eF5hCD2MojJVXxytBLZk9xTD/BJD0Kijhf5BAUq2FaL5+i6AiVnC75MdTU2NJp0T
	 yhVUlxeGff5bLwpU5/F237NShluAbqdPpkutX0fsnA2NLA808D79Qbm7G3FP/atucx
	 vAxWpGma2CGWD0DGm4O5cBPZpTel7ponY5seoVxg7T5PiwgpgyYKzdvae5gUYryke2
	 NoycInb5I4ZXKFNbncWBMNggBG6sGlEx23FyGMlKEziebFt3NAYdQRAoL0TZcYJY9B
	 ysrXk+AvWiTgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 04/14] x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
Date: Tue, 13 May 2025 14:48:29 -0400
Message-Id: <20250513130157-b8f5ddbfeb23be29@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512-its-5-15-v1-4-6a536223434d@linux.intel.com>
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

The upstream commit SHA1 provided is correct: c8c81458863ab686cda4fe1e603fccaae0f12460

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Present (different SHA1: d6b1113648df)
6.6.y | Present (different SHA1: 5951dc648325)
6.1.y | Present (different SHA1: 1bb5fcee287e)

Note: The patch differs from the upstream commit:
---
1:  c8c81458863ab ! 1:  2398ad5af76ca x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
    @@ Metadata
      ## Commit message ##
         x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
     
    +    commit c8c81458863ab686cda4fe1e603fccaae0f12460 upstream.
    +
         Commit:
     
           010c4a461c1d ("x86/speculation: Simplify and make CALL_NOSPEC consistent")
     
    -    added an #ifdef CONFIG_MITIGATION_RETPOLINE around the CALL_NOSPEC definition.
    -    This is not required as this code is already under a larger #ifdef.
    +    added an #ifdef CONFIG_RETPOLINE around the CALL_NOSPEC definition. This is
    +    not required as this code is already under a larger #ifdef.
     
         Remove the extra #ifdef, no functional change.
     
         vmlinux size remains same before and after this change:
     
    -     CONFIG_MITIGATION_RETPOLINE=y:
    +     CONFIG_RETPOLINE=y:
               text       data        bss         dec        hex    filename
           25434752    7342290    2301212    35078254    217406e    vmlinux.before
           25434752    7342290    2301212    35078254    217406e    vmlinux.after
     
    -     # CONFIG_MITIGATION_RETPOLINE is not set:
    +     # CONFIG_RETPOLINE is not set:
               text       data        bss         dec        hex    filename
           22943094    6214994    1550152    30708240    1d49210    vmlinux.before
           22943094    6214994    1550152    30708240    1d49210    vmlinux.after
     
    +      [ pawan: s/CONFIG_MITIGATION_RETPOLINE/CONFIG_RETPOLINE/ ]
    +
         Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
         Signed-off-by: Ingo Molnar <mingo@kernel.org>
         Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
         Link: https://lore.kernel.org/r/20250320-call-nospec-extra-ifdef-v1-1-d9b084d24820@linux.intel.com
     
      ## arch/x86/include/asm/nospec-branch.h ##
    -@@ arch/x86/include/asm/nospec-branch.h: static inline void call_depth_return_thunk(void) {}
    +@@ arch/x86/include/asm/nospec-branch.h: extern retpoline_thunk_t __x86_indirect_thunk_array[];
       * Inline asm uses the %V modifier which is only in newer GCC
    -  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
    +  * which is ensured when CONFIG_RETPOLINE is defined.
       */
    --#ifdef CONFIG_MITIGATION_RETPOLINE
    +-#ifdef CONFIG_RETPOLINE
      #define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
      			"call __x86_indirect_thunk_%V[thunk_target]\n"
     -#else
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

