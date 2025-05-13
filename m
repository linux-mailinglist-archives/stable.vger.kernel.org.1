Return-Path: <stable+bounces-144256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B3FAB5CD1
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA363B91F5
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B14D20E032;
	Tue, 13 May 2025 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epfg+M4U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EAC8479
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162256; cv=none; b=L+r/3/LPKY1f0B9j9maFqmRL8gtFX3uEbzP5WWF+2fzfM43uMpOqrl4YhNY3y+22y0bF0n2QmAvSJHSITFrhwebAOzj25hcwBHypXdDj2l0rmKlx5QDHJKjI+HK66UyC7xZAZgxLejWmCuBj8f224Wz1YovCh4nB337g/GazoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162256; c=relaxed/simple;
	bh=TOk28GiZ+wMrUT55FBy+plYDxZIYzX9uHwU/UZvFgQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4/fje72XZHwh4D66fx0rCS6D8uhSV4exPBf8wbQBV/GHqdewaW7BUBOq9wcs2Q7/0L4gfRlKGsdpR+1GnXe3fxThVEuq/qBW6YADt9QE7jNcJKU231e7B70P6B1cwvgD3cHYCkqphmANu47pYqBkAkNdvqrTj8KOFeOXG0tEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epfg+M4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02039C4CEE4;
	Tue, 13 May 2025 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162254;
	bh=TOk28GiZ+wMrUT55FBy+plYDxZIYzX9uHwU/UZvFgQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epfg+M4UTMfE5DmkLzeLqbYGeTLKtoEmD//C6Kt+wiREKnm4Ei6WBT77wtWQ4MakT
	 j/oMKQ92YoAK2XvVbFF3Zeya7I+XN1d1R9YT+jGg9e9plmYYPZVBItitSKti80n0pW
	 e+8+XNKlJ4TLODCkM5awOKVk/vSbP/57HQWGPVo2dVAzr9PxjhbbLI2CIBYnpTKcUO
	 vC1VZzsOLERIpBTftgdgMCNg3XIBPqlQNammuG9u5ajRGp/iGwV9ka6TxcysehPYgm
	 1cBpIDIJn0DM1FE4h4jKnVy8lX/704l8WgnA1P24IVu0kvgmOZKtRlCmiwENSDkwCI
	 jF/pGbgxBkN2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 02/14] x86/speculation: Simplify and make CALL_NOSPEC consistent
Date: Tue, 13 May 2025 14:50:51 -0400
Message-Id: <20250513122905-2753821e7b9a48d8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512-its-5-15-v1-2-6a536223434d@linux.intel.com>
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
1:  cfceff8526a42 ! 1:  0851139dfb8e2 x86/speculation: Simplify and make CALL_NOSPEC consistent
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

