Return-Path: <stable+bounces-144431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5044AAB7691
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCBF8C597D
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2BD2951A6;
	Wed, 14 May 2025 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwC5xhyY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C91F866B
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253638; cv=none; b=exRCgxxB6o7+CVHiYp8VVUXNyhg5pOogPdkrZFltsSlhxJJ825CP414s5dhRahYagg2wDqLgfYdJVmPUXDRBKt21ceKPiV3tbuIAYr+WRrvjCrWr+DZWH4x2Lh1pgpz1AjZ561+J61z22h8ME3Y8L5uKbe7gk/ALbkfi6RAa74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253638; c=relaxed/simple;
	bh=5aOwRtnVBJuASelNUVirkIxo2ONLErq/z7z/tSJHh6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbfaHC16RPW6DtK2UE/RGcJyWDWJpuwu/XXcCpwOngycleINEFgJAnIaR9M5lwHIYKmQJBBsRreEL/J/x1rlu9KwSDj39rp/Bny/mqYYmofKksxGrlbYTpF7W1HCAK3N4o4MdO5Iab5DQwTb05SPnYAtP2vLWu2o8/mM0bPRd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwC5xhyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6308C4CEE3;
	Wed, 14 May 2025 20:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253637;
	bh=5aOwRtnVBJuASelNUVirkIxo2ONLErq/z7z/tSJHh6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwC5xhyYcIo1dIg/FfADKDiSsn0+V2q5ioyLz4Jkwv2ggdawcZDKsb38MbK8g+p67
	 R1SHMM95YHVSpvvLljSFS7LCgcEQnYMjd0bkNZ98IQMdQn4KyBee3VjivFmZxaWh/n
	 2SIig1GhFjYE58ol37aHtzIIDk2CaQpMx0e3Z5E/IfvXLpbD9M2PMBv0N7vBGDYmuz
	 HGP4NdIvlQ9ox1YE+cT+pzlrAphzA5nXskQvIB9ULtHfzBhnVGEPslnNDEyyjAhyTy
	 qBm8sIC4fxzdgeKzTJFejcNNB4XekGq+Z4wZ8lbd4tGeUF/vwBW54T5sHKfIa6PjnH
	 RTqDc+Z6dA2xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 04/14] x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
Date: Wed, 14 May 2025 16:13:54 -0400
Message-Id: <20250514110442-a668a0453065d3fc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-4-90690efdc7e0@linux.intel.com>
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
1:  c8c81458863ab ! 1:  ec70e9654b27d x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
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

