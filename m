Return-Path: <stable+bounces-132147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC21A84907
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245E517FE6F
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86C1EDA28;
	Thu, 10 Apr 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTLjV8Am"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DE1D5AD4
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300427; cv=none; b=u/3U/gQBlFpnYG3cw0eFngjclS6BJWwD1x0cGxirYgofl6KnAoGf1UKQwUNWqpxlt34HlUQtmXz2RimQC18To71xPuIE4NcCpVHSLaQLo6RpCBY+Vb8Fy3pzoHbfZAUhG2SXldEoID/GdBWUIc0KLQSJApxUHFKzsAt/ylRzISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300427; c=relaxed/simple;
	bh=0/L2nrnXNquAxB1v3cRg7V8nsKInERJtJqcUWwvNbl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrrQYH2a9KrbABw2VhSIffy05n/CQGp7llDqd6BxhMyHwZ00njxU160sLw7/P1lM9EJ/t1ckjspu97SNiqIXAD6XEUy3P+cGZPJqhoV+GFgmBT7XMbJvhbfwJEnHa/eO+aSRAv18Iq6SY9cGyp0oLl50D9Oo3Yo4S8BlzG+A49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTLjV8Am; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5687AC4CEDD;
	Thu, 10 Apr 2025 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300426;
	bh=0/L2nrnXNquAxB1v3cRg7V8nsKInERJtJqcUWwvNbl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTLjV8Am8KuuGM3eplV0WAHqEuQ+eBGf6BTarLM96KteMExcDcH92Dk8EPn0zZD5+
	 LN9rAjsedosLwjurawJDzxJEIlUnSKbQnOp05XJfBYNgdDqG1CH5FKcrJwG/vD9ia7
	 VYAZ9CsIkOfRBmksgRALUUDGnrC3oXwoXyY5ocxk+ZZg2ZTNBke1QcLX8G5oc7to26
	 MVgccngiQEy8Kp5CcazrUqILWBPF1L+cM8m8f9gbfZ2CMPko1jImSssJm554/GAbzr
	 lE/Bf9FxviKgb1Sr0XjLmINTlrR8IBJSZNC68Yq4Z5Ay2+ljc8QG0NOHc0bLUBbeYe
	 Z7aehla9C821Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	vannapurve@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
Date: Thu, 10 Apr 2025 11:53:44 -0400
Message-Id: <20250409223005-650d3f9aa8e38023@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408132937.4178015-1-vannapurve@google.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 22cc5ca5de52bbfc36a7d4a55323f91fb4492264

WARNING: Author mismatch between patch and found commit:
Backport author: Vishal Annapurve<vannapurve@google.com>
Commit author: Kirill A. Shutemov<kirill.shutemov@linux.intel.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 263850bf7db9)
6.13.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  22cc5ca5de52b ! 1:  1a8f60a371a74 x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
    @@ Commit message
         Cc: Josh Poimboeuf <jpoimboe@redhat.com>
         Cc: stable@kernel.org
         Link: https://lore.kernel.org/r/20250228014416.3925664-2-vannapurve@google.com
    +    (cherry picked from commit 22cc5ca5de52bbfc36a7d4a55323f91fb4492264)
     
      ## arch/x86/include/asm/irqflags.h ##
    -@@ arch/x86/include/asm/irqflags.h: static __always_inline void native_local_irq_restore(unsigned long flags)
    +@@ arch/x86/include/asm/irqflags.h: static __always_inline void native_halt(void)
      
      #endif
      
    @@ arch/x86/include/asm/paravirt.h: static inline void __write_cr4(unsigned long x)
     -	PVOP_VCALL0(irq.halt);
     -}
     -
    - static inline u64 paravirt_read_msr(unsigned msr)
    - {
    - 	return PVOP_CALL1(u64, cpu.read_msr, msr);
    + extern noinstr void pv_native_wbinvd(void);
    + 
    + static __always_inline void wbinvd(void)
     
      ## arch/x86/include/asm/paravirt_types.h ##
     @@ arch/x86/include/asm/paravirt_types.h: struct pv_irq_ops {
    @@ arch/x86/include/asm/paravirt_types.h: struct pv_irq_ops {
      struct pv_mmu_ops {
     
      ## arch/x86/kernel/paravirt.c ##
    -@@ arch/x86/kernel/paravirt.c: void paravirt_set_sched_clock(u64 (*func)(void))
    - 	static_call_update(pv_sched_clock, func);
    +@@ arch/x86/kernel/paravirt.c: int paravirt_disable_iospace(void)
    + 	return request_resource(&ioport_resource, &reserve_ioports);
      }
      
     +static noinstr void pv_native_safe_halt(void)
    @@ arch/x86/kernel/paravirt.c: void paravirt_set_sched_clock(u64 (*func)(void))
      #ifdef CONFIG_PARAVIRT_XXL
      static noinstr void pv_native_write_cr2(unsigned long val)
      {
    -@@ arch/x86/kernel/paravirt.c: static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
    +@@ arch/x86/kernel/paravirt.c: noinstr void pv_native_wbinvd(void)
      {
    - 	native_set_debugreg(regno, val);
    + 	native_wbinvd();
      }
     -
     -static noinstr void pv_native_safe_halt(void)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

