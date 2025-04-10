Return-Path: <stable+bounces-132143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430EEA848F6
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75049C0547
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6521EDA0B;
	Thu, 10 Apr 2025 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo07hDT+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D41EC018
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300417; cv=none; b=Oks2nkPEGXBRXF4Nc4uZ0Q/tzS+TXVi8GbQMcc5YioxZK5KvsxQ5ZmUCZuNlbGYQTIbvguOsK7xxe528tVMAMa0jk90PvtbLXt0xr2IJ9YsEYimcKttyXU2EQMZpm2G1XnwuERNJz3K5X77dBE7J1YMm7UtUlYBqjF+FHN+WxL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300417; c=relaxed/simple;
	bh=LryRdxGkt466/X/0dEZuLkx4fVO1ITfHCbp1J3Cy/dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijUu/l8kd8JNgNbHdwe8ZBk9LubXG46IAne7vpFxIs2nQvcwQWT6qlal4LLbLy008jZ9/R5hZcMWdFo6F66rGKbrmJgWTrsSZarZiQcRP3/w/G6MDvi0QC1TQ50xcycLHde3+yzq/O8QxnIUPfHQQwVZZH63u9v4+ysf8KrFRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo07hDT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BAEC4CEDD;
	Thu, 10 Apr 2025 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300417;
	bh=LryRdxGkt466/X/0dEZuLkx4fVO1ITfHCbp1J3Cy/dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mo07hDT+gd4zgDxydVKUmqHyhzKwYQ2l1G5tfhl/k1lQ/jW3J3bmavHQc1M/UXd6J
	 IwqXq50uV5Iv8o7v6db1wpVpV+1E6jBFwDMhkzcJqhPNnBej0cQcvMXEgtXM7SECXv
	 ybRh1iu02Z81aMUCnpLYCRpCWIpOnAjjPY9z9zms6JhwuJBrEaYbXpYVQPs7590JUo
	 sHS7myhIKzdTt2DK3au94vGqHPoP/iOpQVaFFFRhiKk10H6PjXDq2neKUSR8YpxtZh
	 Z6lmRXyB2qd/a0832PJIQRcBzuluCS8ZLJD9qWJ+QquzOrymLAVcjSBYyPuVGAR1Ej
	 eFiYmFv5pegiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	vannapurve@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
Date: Thu, 10 Apr 2025 11:53:35 -0400
Message-Id: <20250409233229-83aa147302465a90@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408125645.3856166-1-vannapurve@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  22cc5ca5de52b ! 1:  5fca555be7cc5 x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
    @@ Commit message
         Cc: Josh Poimboeuf <jpoimboe@redhat.com>
         Cc: stable@kernel.org
         Link: https://lore.kernel.org/r/20250228014416.3925664-2-vannapurve@google.com
    +    (cherry picked from commit 22cc5ca5de52bbfc36a7d4a55323f91fb4492264)
     
      ## arch/x86/include/asm/irqflags.h ##
     @@ arch/x86/include/asm/irqflags.h: static __always_inline void native_local_irq_restore(unsigned long flags)
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
| stable/linux-6.13.y       |  Success    |  Success   |

