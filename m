Return-Path: <stable+bounces-144234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E92DDAB5CAE
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A466B19E8246
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136172BEC5A;
	Tue, 13 May 2025 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkGAqs9j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9F1B3950
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162162; cv=none; b=FBdVZgzlmtSbEDXP8z4C0u1xdGxkEBfPNQ0hYMmHgqYfW2SuaJR5OMkNku1Ur/7imWetuTjtK72tM2y6AZqRBZzdeDuUTuVhB7j25uhoG1QtBmoTecA6aU3hMuisvzr+LAven0Qe0CQq9jet15KMglfYZBR3PRWRbSwl0TGP6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162162; c=relaxed/simple;
	bh=zDOvyGCpSJOEcVXhRO0OLaEUhlGRK10GWzepJscwoNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlQL6miLbyBOLtOpErK5SYZS6rqwRqFPLxMrJKoAtx+5sRfxOX7WjUR097EOkq37218K33QPO84Qjz/S0N+kNWck1v8FvEQJi6NucKbb4DKJvTWt1TN3gJts4o79laNOg6FYc1BjoR9mFe6HBm0fFLHvJU1pNxn2o2VjwUU+WuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkGAqs9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ACFC4CEEB;
	Tue, 13 May 2025 18:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162162;
	bh=zDOvyGCpSJOEcVXhRO0OLaEUhlGRK10GWzepJscwoNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LkGAqs9jmca/hmFGMbyNKsjuO3e+Ks0crutCeEYWIUTnsXS536KRQeNJYZyNBWTJW
	 lw+If+axdMgwTICx90carTwrOKo/ClTcWIurwxl5B8rsh56nnYZ+j88x9QAfTQ32xx
	 9UWH5ta8bAmHrWg7Agy/msWJMaoLRL+rzxz7BhyslV0c9uFyNcWgQu1wuhCDEt3XY0
	 EF42HRLXbUb6AYspow9Gcdt3lmAwcdhTxr2C8E+B6Zo3ieZ6i4+leSaycTxzzs4otN
	 523SnbIMybz81pjIkxfIuEnDC8T5LsFy1kBBnPx/d2ZZ86h1ZAZiKGkp+TVypqmV8a
	 dPBXFRKzS0gkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 03/14] x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
Date: Tue, 13 May 2025 14:49:18 -0400
Message-Id: <20250513124531-37bde6c403e48a7d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512-its-5-15-v1-3-6a536223434d@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 052040e34c08428a5a388b85787e8531970c0c67

Status in newer kernel trees:
6.14.y | Present (different SHA1: 9af9ad85ac44)
6.12.y | Present (different SHA1: 2d3bf48b14d4)
6.6.y | Present (different SHA1: 4dc248983ca5)
6.1.y | Present (different SHA1: fe6577881bf4)

Note: The patch differs from the upstream commit:
---
1:  052040e34c084 ! 1:  70b69b6a93bdd x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
    @@ Metadata
      ## Commit message ##
         x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
     
    +    commit 052040e34c08428a5a388b85787e8531970c0c67 upstream.
    +
         Retpoline mitigation for spectre-v2 uses thunks for indirect branches. To
         support this mitigation compilers add a CS prefix with
         -mindirect-branch-cs-prefix. For an indirect branch in asm, this needs to
    @@ arch/x86/include/asm/nospec-branch.h
       */
      .macro __CS_PREFIX reg:req
      	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
    -@@ arch/x86/include/asm/nospec-branch.h: static inline void call_depth_return_thunk(void) {}
    +@@ arch/x86/include/asm/nospec-branch.h: extern retpoline_thunk_t __x86_indirect_thunk_array[];
      
      #ifdef CONFIG_X86_64
      
    @@ arch/x86/include/asm/nospec-branch.h: static inline void call_depth_return_thunk
     +
      /*
       * Inline asm uses the %V modifier which is only in newer GCC
    -  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
    +  * which is ensured when CONFIG_RETPOLINE is defined.
       */
    - #ifdef CONFIG_MITIGATION_RETPOLINE
    + #ifdef CONFIG_RETPOLINE
     -#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
     +#define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
     +			"call __x86_indirect_thunk_%V[thunk_target]\n"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

