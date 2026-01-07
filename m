Return-Path: <stable+bounces-206227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7947ED002E6
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 22:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C06C30039CC
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8462868A7;
	Wed,  7 Jan 2026 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="GRT6GfwD"
X-Original-To: stable@vger.kernel.org
Received: from mail46.out.titan.email (mail46.out.titan.email [3.66.115.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145C3246E8
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.66.115.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821738; cv=none; b=glpSv3Cv7322eP3VmeXU5q1LQTyvSsQRQpklEDCGDHTigCOcJp1U7rj2GRLhPGb+arGD2zXpXbgziArzT5Vl4/WLfgsQ36rVspxsPRtPYUGRg0UC9q7705gpkNvJVDTBul0q84WvljfCIozbL8wNZtpQC0qdhwcIx8vTFHPUYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821738; c=relaxed/simple;
	bh=f064EZ0dqGRVg3dkxlUTLTwy1SIOsSTpUSYzFm4tCpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxU0Qq1qxpwO7POXSzRpGMF+fVuXCq+xpdfvm8MVmzCK3AyMGkWw3VT1wgWOPJBPyky1KmWyc06K2nr99utNcVEi578eheiuqROPx1idT9kA9AIsHtYXjVmXveKNcQ/oaVeO9mgWYvrCg+UVfUyyuRO0Bwe3IWtUE+s0PBmf7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=GRT6GfwD; arc=none smtp.client-ip=3.66.115.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4dmgsD0gw6z4vxF;
	Wed,  7 Jan 2026 21:19:28 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=3Gsude5bCr/12iFzuhvBklS0UCcOFjMel4nHpQJlVUA=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=date:cc:subject:references:from:to:message-id:mime-version:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1767820768; v=1;
	b=GRT6GfwDFe8MjeAHbU3WKrjHJH5MTG7P8YHkSbQMBx54D0v53MuQJdCG5+JS3kgyrGD8/SK4
	0xIJuW6Q/2GJUf4qzG63maVHTQrzpMu5pRc9JTwzGkn0K8keeQZYXtRxc5kaz5DUiUGKzH0QJU5
	uxSEYB1hDcy8bRcRj6eAeiQk=
Received: from techsingularity.net (ip-84-203-20-110.broadband.digiweb.ie [84.203.20.110])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4dmgsB4LfWz4vxD;
	Wed,  7 Jan 2026 21:19:26 +0000 (UTC)
Date: Wed, 7 Jan 2026 21:19:20 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH mm-hotfixes] mm/page_alloc: prevent pcp corruption with
 SMP=n
Message-ID: <h33pscn2orhpb5dapttmo4vy4s3drfsjaahmjp4arsjjfngzno@bzbacqjvfe6r>
References: <20260105-fix-pcp-up-v1-1-5579662d2071@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20260105-fix-pcp-up-v1-1-5579662d2071@suse.cz>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1767820767945683141.1240.1245684775781968541@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=d4QPyQjE c=1 sm=1 tr=0 ts=695ecddf
	a=ycgmuL0lqxUANBz+XI9aLQ==:117 a=ycgmuL0lqxUANBz+XI9aLQ==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
	a=JfrnYn6hAAAA:8 a=R_Myd5XaAAAA:8 a=MC9sqzVPiPx8m3HZA18A:9
	a=PUjeQqilurYA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=L2g4Dz8VuBQ37YGmWQah:22

On Mon, Jan 05, 2026 at 04:08:56PM +0100, Vlastimil Babka wrote:
> The kernel test robot has reported:
> 
>  BUG: spinlock trylock failure on UP on CPU#0, kcompactd0/28
>   lock: 0xffff888807e35ef0, .magic: dead4ead, .owner: kcompactd0/28, .owner_cpu: 0
>  CPU: 0 UID: 0 PID: 28 Comm: kcompactd0 Not tainted 6.18.0-rc5-00127-ga06157804399 #1 PREEMPT  8cc09ef94dcec767faa911515ce9e609c45db470
>  Call Trace:
>   <IRQ>
>   __dump_stack (lib/dump_stack.c:95)
>   dump_stack_lvl (lib/dump_stack.c:123)
>   dump_stack (lib/dump_stack.c:130)
>   spin_dump (kernel/locking/spinlock_debug.c:71)
>   do_raw_spin_trylock (kernel/locking/spinlock_debug.c:?)
>   _raw_spin_trylock (include/linux/spinlock_api_smp.h:89 kernel/locking/spinlock.c:138)
>   __free_frozen_pages (mm/page_alloc.c:2973)
>   ___free_pages (mm/page_alloc.c:5295)
>   __free_pages (mm/page_alloc.c:5334)
>   tlb_remove_table_rcu (include/linux/mm.h:? include/linux/mm.h:3122 include/asm-generic/tlb.h:220 mm/mmu_gather.c:227 mm/mmu_gather.c:290)
>   ? __cfi_tlb_remove_table_rcu (mm/mmu_gather.c:289)
>   ? rcu_core (kernel/rcu/tree.c:?)
>   rcu_core (include/linux/rcupdate.h:341 kernel/rcu/tree.c:2607 kernel/rcu/tree.c:2861)
>   rcu_core_si (kernel/rcu/tree.c:2879)
>   handle_softirqs (arch/x86/include/asm/jump_label.h:36 include/trace/events/irq.h:142 kernel/softirq.c:623)
>   __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:725)
>   irq_exit_rcu (kernel/softirq.c:741)
>   sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052)
>   </IRQ>
>   <TASK>
>  RIP: 0010:_raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:95 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
>   free_pcppages_bulk (mm/page_alloc.c:1494)
>   drain_pages_zone (include/linux/spinlock.h:391 mm/page_alloc.c:2632)
>   __drain_all_pages (mm/page_alloc.c:2731)
>   drain_all_pages (mm/page_alloc.c:2747)
>   kcompactd (mm/compaction.c:3115)
>   kthread (kernel/kthread.c:465)
>   ? __cfi_kcompactd (mm/compaction.c:3166)
>   ? __cfi_kthread (kernel/kthread.c:412)
>   ret_from_fork (arch/x86/kernel/process.c:164)
>   ? __cfi_kthread (kernel/kthread.c:412)
>   ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
>   </TASK>
> 
> Matthew has analyzed the report and identified that in drain_page_zone()
> we are in a section protected by spin_lock(&pcp->lock) and then get an
> interrupt that attempts spin_trylock() on the same lock. The code is
> designed to work this way without disabling IRQs and occasionally fail
> the trylock with a fallback. However, the SMP=n spinlock implementation
> assumes spin_trylock() will always succeed, and thus it's normally a
> no-op. Here the enabled lock debugging catches the problem, but
> otherwise it could cause a corruption of the pcp structure.
> 
> The problem has been introduced by commit 574907741599 ("mm/page_alloc:
> leave IRQs enabled for per-cpu page allocations"). The pcp locking
> scheme recognizes the need for disabling IRQs to prevent nesting
> spin_trylock() sections on SMP=n, but the need to prevent the nesting in
> spin_lock() has not been recognized. Fix it by introducing local
> wrappers that change the spin_lock() to spin_lock_iqsave() with SMP=n
> and use them in all places that do spin_lock(&pcp->lock).
> 

Bah, correct.

> Fixes: 574907741599 ("mm/page_alloc: leave IRQs enabled for per-cpu page allocations")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202512101320.e2f2dd6f-lkp@intel.com
> Analyzed-by: Matthew Wilcox <willy@infradead.org>
> Link: https://lore.kernel.org/all/aUW05pyc9nZkvY-1@casper.infradead.org/
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> This fix is intentionally made self-contained and not trying to expand
> upon the existing pcp[u]_spin() helpers. This is to make stable
> backports easier due to recent cleanups to that helpers.
> 
> We could follow up with a proper helpers integration going forward.
> However I think the assumptions SMP=n of the spinlock UP implementation
> are just wrong. It should be valid to do a spin_lock() without disabling
> irq's and rely on a nested spin_trylock() to fail. I will thus try
> proposing the remove the UP implementation first. It should be within
> the current trend of removing stuff that's optimized for a minority
> configuration if it makes maintainability of the majority worse.
> (c.f. recent scheduler SMP=n removal)

It would be fair. Maybe it'll take a performance hit because from a
maintenance perspective, it would be preferable. It's true that
spin_trylock within a lock protected region on UP is somewhat bogus, but
not impossible either. Even if the resulting code is buggy anyway, it
would be preferable to fail early than hide.

> ---
>  mm/page_alloc.c | 45 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 8 deletions(-)
> 

With or without the renaming on top;

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks.

-- 
Mel Gorman
SUSE Labs

