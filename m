Return-Path: <stable+bounces-154752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76638AE0112
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F8F1797D1
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5F265CAB;
	Thu, 19 Jun 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2XeD07T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744D26563C
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323750; cv=none; b=kpkB0nDLMkeuWLEDnNqs5ulTu0g3J+18Ehv7FCG0PuSf6c7fmyJ8eRajkCTK+3ITXuGEz6rMFh/zfUI23fqcCg6dOisYXr0B3j8RDn2Q2QyXf3RutppCYA7BEtjaCvTHxybzV4z9h8tLOMoIFvS/vQU87bYq/IrFmd+wwsMzXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323750; c=relaxed/simple;
	bh=Eq7JMVkFOR15MBVj3zBQoUL8/lwR/TNJjfiTI0eWv20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKfD+ktgTtc3JNH6kMy2TTA2tzh2ClxOpfxdhmfmqiLBUNi0Pmn2ZH3pM3TN2yEfITHHrVayUvS364EsyGjHJgT0Ho/TXS7KDGNipdJL+iMGThs4M6SSd3YQebeVXQc89MLFHX/Crqd3YUMWecsK8mKew46XNpbs+2w+T8EVtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2XeD07T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2277C4CEEA;
	Thu, 19 Jun 2025 09:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323750;
	bh=Eq7JMVkFOR15MBVj3zBQoUL8/lwR/TNJjfiTI0eWv20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2XeD07TTXXg2GHM4XRJm63bZqVL/AkOvwA1wsM9NLu08hNi1NgVIQgiL1miGtGuK
	 lLXx8xl1EBUUf/hCgxPLwOkJGMcpzYIJx0Uv3oqYwcED7FY4S8mc642jcPVgIPGeds
	 yP9+YVmS5N5/+HtCuGlzeaa4eSkAl/Jgxy/p//mQcMh+pM8E/G+Gdz/cf3mFeqtKAa
	 WqBk2wNHNur5XdXo9Ju130y47exDYvF0Epze/jH9lJW+Zy74ll29CrfL0IZm2ZnPn2
	 fcW7+QvNjJBHMv/ynvDnt4/IV45FF7bOx7d7qMCRgmebHUEGRyzzkt4F8wjstYzl9N
	 HRRs36eUxskrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 13/16] x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()
Date: Thu, 19 Jun 2025 05:02:28 -0400
Message-Id: <20250618183937-54a6bf3e25215dc7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-13-3e925a1512a1@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 4c4eb3ecc91f4fee6d6bf7cfbc1e21f2e38d19ff

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Thomas Gleixner<tglx@linutronix.de>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 05e85d376720)
5.15.y | Present (different SHA1: 4ad2d3c4d3cc)

Note: The patch differs from the upstream commit:
---
1:  4c4eb3ecc91f4 ! 1:  67491352c079b x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()
    @@ Metadata
      ## Commit message ##
         x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()
     
    +    commit 4c4eb3ecc91f4fee6d6bf7cfbc1e21f2e38d19ff upstream.
    +
         Instead of resetting permissions all over the place when freeing module
         memory tell the vmalloc code to do so. Avoids the exercise for the next
         upcoming user.
    @@ Commit message
         Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Link: https://lore.kernel.org/r/20220915111143.406703869@infradead.org
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/kernel/ftrace.c ##
     @@ arch/x86/kernel/ftrace.c: create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
    @@ arch/x86/kernel/module.c: void *module_alloc(unsigned long size)
      
      	p = __vmalloc_node_range(size, MODULE_ALIGN,
     -				    MODULES_VADDR + get_module_load_offset(),
    --				    MODULES_END, gfp_mask,
    --				    PAGE_KERNEL, VM_DEFER_KMEMLEAK, NUMA_NO_NODE,
    +-				    MODULES_END, GFP_KERNEL,
    +-				    PAGE_KERNEL, 0, NUMA_NO_NODE,
     -				    __builtin_return_address(0));
     +				 MODULES_VADDR + get_module_load_offset(),
    -+				 MODULES_END, gfp_mask, PAGE_KERNEL,
    -+				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
    -+				 NUMA_NO_NODE, __builtin_return_address(0));
    -+
    - 	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
    ++				 MODULES_END, GFP_KERNEL, PAGE_KERNEL,
    ++				 VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
    ++				 __builtin_return_address(0));
    + 	if (p && (kasan_module_alloc(p, size) < 0)) {
      		vfree(p);
      		return NULL;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

