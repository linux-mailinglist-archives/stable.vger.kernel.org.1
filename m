Return-Path: <stable+bounces-144679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD1ABAA37
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FD19E1113
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0731F91C5;
	Sat, 17 May 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHe4p/49"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB8155393
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487300; cv=none; b=GOZRWmFxPww3yBCQec0r0DlYsCTEVNUGNm2QwfIh8ewjIrYHQjtpKELLowFoWiKnIDs89sEbLN7yjKFmn+8jK5eJoaYzOfgFOKFC2uBsi5fl5ANc5YA4f5U1Nb//8+mW6z2dUX6pVetAiqIx2Sk+fyJFJOo+jsC3V2TDrG4OVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487300; c=relaxed/simple;
	bh=hE5XdGQdOopNPlgcWexS3aqHHIpPhKspI41BiqMyNOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1c8H814NMxXMIpGcTioP2NEiXmijWx9dU3Q15XDPYMH2AVhF2bDJva70Ad6pSaaRi178eTp43PtsPp7UikB49yuBPUwAThdC5kosZEzbij4pLnCZfRaVrsXl5DDQWh4F001bVhY+Ih3857R1XVugpEEudumqPvhTBiYDBMFyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHe4p/49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3937CC4CEE9;
	Sat, 17 May 2025 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487300;
	bh=hE5XdGQdOopNPlgcWexS3aqHHIpPhKspI41BiqMyNOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHe4p/49PQbP/qFF0S4ljorzSlQ/ek4RmUjvT6H0jUA2RNH4SEfniyBQgY3SLHpd3
	 IAZPTkx31Ziu7asOG1ZteYSsZD8PV100bdKvDfsHndOHSDpVuUcCxLXQxl4/Y+6I9D
	 fUs8lcFtIOXvKaKLO31A+cydOfhvhp1FRubq7e1pyALaW6xTQVtz35eVQ1iNs3jTRi
	 sXvJreTOZmyU3S+OUyg6Pn6K6Oj28N5CVZ+8YEBiBGn56ExbGPtdwIMI4e2jrH/jfv
	 g3SbYSfWmY/HF5IVKSQoNcK2tSExlQSoTwJDrMlyZ0aTpSJml4J2reItQIpxtkosck
	 DUXNO4bNt2N8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 04/16] x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
Date: Sat, 17 May 2025 09:08:19 -0400
Message-Id: <20250516213242-5bf905acca84582a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-4-16fcdaaea544@linux.intel.com>
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
6.12.y | Present (different SHA1: 02a1d6e26129)
6.6.y | Present (different SHA1: 8149e4bc5b6a)
6.1.y | Present (different SHA1: 84e06e948fc5)

Note: The patch differs from the upstream commit:
---
1:  c8c81458863ab ! 1:  31b985df4b5be x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
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

