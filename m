Return-Path: <stable+bounces-132162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5E4A8490B
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27F89C36B0
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B91EA7F1;
	Thu, 10 Apr 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="il5eRH6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943CB1E9B38
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300493; cv=none; b=NFc6k4BE/Gld++bjPI6m3aK8YE9eQh+BCwweyO1L9GP6VUTq0wAzQzSPvGgCkhiKYfuRUX18F4R4QyZUIiTL2NGI0WtWNqEz1qworqKTkMzX4X/cKm7WrPALBn2AkoCwae4AC+wqxwzZ+qModsGw2lgc+J2Pisl9pWcR+uolEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300493; c=relaxed/simple;
	bh=c30uI+fhIH60ufdbOcujAuQnhj6X6YVwc9NkZkDdQKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjfQ2H8CVNaQuQbMv8x53izIMCucAQNjNIj81lnS9D/5315Ur+Y/A+AWDYaAqfIQDyobYo1uQUwBdg2CQ/NqXDXrEcL9z3gBoT54KKetuZomvxYdJk/gRcyhsVthirnXgZAQg4QecO8pj7trMLOVVeCc0J1PjxUK0jS77HaZrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il5eRH6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC17C4CEE8;
	Thu, 10 Apr 2025 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300493;
	bh=c30uI+fhIH60ufdbOcujAuQnhj6X6YVwc9NkZkDdQKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=il5eRH6pUxYOUnvyJgsfBqmnQp2IJNAzCPWUE2CFre5jM2sL9G7Z2KFQXj/IGqJe2
	 EiM3PiyxZ+60zSp9ZIzaG7qqz5zLVY7Q+KlyIxn0KothpPKwByPcijjlpn9srZyD6+
	 OqP2NZc0qb+tiB5c1y3ypj1HnsJcoHEelGt8nauQ0t3go1dUl1NkuXMyQfAq4JACDR
	 MRza6eijmE7up/5oJ0soy2BJLDZspEBPjRycMWTBsJ6+lwVAmpbHzu58FF7vdlA8Y7
	 HsBE8Al6wIna4J4YCyaBEj9FRbxKevmCi4R+EhsnUg//YAhW2wLc1bVvD/nukfsRng
	 ILgcIHHxrqt9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	vannapurve@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
Date: Thu, 10 Apr 2025 11:54:50 -0400
Message-Id: <20250410000011-a260576a1eb96719@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408132341.4175633-1-vannapurve@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  22cc5ca5de52b ! 1:  86c675d7f6e8a x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
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
    - {
    - 	native_set_debugreg(regno, val);
    +@@ arch/x86/kernel/paravirt.c: noinstr void pv_native_wbinvd(void)
    + 	native_wbinvd();
      }
    --
    + 
     -static noinstr void pv_native_safe_halt(void)
     -{
     -	native_safe_halt();
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

