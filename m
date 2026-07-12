Return-Path: <stable+bounces-273495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sDbTJfWTU2oKcAMAu9opvQ
	(envelope-from <stable+bounces-273495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 15:17:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAFA744C55
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 15:17:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=jhlBoNmp;
	dmarc=pass (policy=none) header.from=arm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273495-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273495-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CDCA301F9A1
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035562E9EC7;
	Sun, 12 Jul 2026 13:17:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644EE1A239A;
	Sun, 12 Jul 2026 13:17:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783862254; cv=none; b=Dzy/j79ximraAzykYsFg+av5H8FYBrNFUhN3p/NlTa4k2+VVlJ0FAorCjwqLkQWISbL2Sg+Nfmc6txsjsgaymVZ8cOyLV8MBMJRav8dqQe572mB953wWrIBcHnVclo3lzNu+0vdHHvMpZVpQQ4gd+sfC7cxazhoGT2ByYpmUGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783862254; c=relaxed/simple;
	bh=Hcs/GzepDdIetzHjiaaCoZ2JnUmYACvmukBnUhnWH7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDUhz0z0fTZq6+xPDNML96vKkowhFUoLurjBfxhAAKHsATFfeqMQv27Jq0ugMZWzzSzkn8y4fIT9fz+9gw5tPERrrWN6BiDnNXiw+0IJWzTqoxStTz+AIadSARVbhIVoV/yww3h5L6qLRaN94fRSMmeGsYfHoYtGxWIwxzZClYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jhlBoNmp; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F7191684;
	Sun, 12 Jul 2026 06:17:19 -0700 (PDT)
Received: from [10.163.128.224] (unknown [10.163.128.224])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 296AC3F85F;
	Sun, 12 Jul 2026 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783862243; bh=Hcs/GzepDdIetzHjiaaCoZ2JnUmYACvmukBnUhnWH7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jhlBoNmp4V+xpb5NnhaUMiVCTOtAElGvdQk7fmpFrcS3v0g3VNy1OuWqR8pPZ36kN
	 Xun5IY8YwezHpllvFoP1/LKdzEH5CvNT0edOT6q7i7+wR+IdF2iMKGDqrG9dMx+IDw
	 FKr3DEZcQp7SsjUU3ircfCWMmXgwcGC/xv4PruhA=
Message-ID: <72e034d9-adcd-4302-93eb-96326846199c@arm.com>
Date: Sun, 12 Jul 2026 18:47:12 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-hotfixes v2 1/4] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
To: Lorenzo Stoakes <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: David Carlier <devnexen@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-1-ad134cc3a12a@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260712-series-vmap-race-fix-v2-1-ad134cc3a12a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273495-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:kas@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:ryan.roberts@arm.com,m:devnexen@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,linux-foundation.org,google.com,infradead.org,linux.dev,suse.com,gmail.com,hpe.com,linux.intel.com,redhat.com,alien8.de,zytor.com,arm.com];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,fd95a72470f5a44e464c];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBAFA744C55



On 12/07/26 4:12 pm, Lorenzo Stoakes wrote:
> Currently there is a nasty race between ptdump and vmap when attempting to
> map a huge P4D, PMD or PUD entry.
> 
> ptdump is invoked by arch code to walk kernel or EFI page tables, either to
> output it for debugging purposes, or to assert that there are no
> W+X (i.e. executable writable pages) exposed in these ranges.
> 
> The feature is enabled generally via CONFIG_PTDUMP (whose implementation is
> in mm/ptdump.c), and expose a debugfs interface for it if
> CONFIG_PTDUMP_DEBUGFS is defined.
> 
> If CONFIG_PTDUMP is enabled, then /sys/kernel/debug/check_wx_pages is
> enabled which checks kernel ranges to perform the W+X check. If
> CONFIG_DEBUG_WX is enabled, this is done on boot.
> 
> (Note that arm32 implements its own page table walker and uses
> CONFIG_ARM_DEBUG_WX and CONFIG_ARM_PTDUMP_DEBUGFS for this.)
> 
> The EFI implementations vary by architecture, but are not relevant to the
> bug, as the issue is when kernel page ranges are walked.
> 
> ptdump_walk_pgd() holds both the mem hotplug lock and the mmap write lock
> before invoking walk_page_range_debug(), however this runs into an issue
> with vmalloc ranges.
> 
> When vmap maps a P4D, PUD or a PMD sized range and encounters an existing
> P4d/PUD/PMD entry pointing to a PUD/PMD/PTE page table, it invokes
> vmap_try_huge_[p4d,pud,pmd]() to try to convert it to a huge page table
> mapping if possible.
> 
> However, when it does this, it holds no meaningful locks against other
> kernel page table walkers, invoking [p4d,pud,pmd]_free_[pud,pmd,pte]_page()
> which calls pagetable_free() and pagetable_free_kernel() in
> turn (pte_fragment_free() for powerpc).
> 
> This means that a use-after-free becomes possible if the ptdump page table
> walker happens to be walking a PUD, PMD or PTE page table after it has been
> freed.
> 
> Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> tables"), if CONFIG_ASYNC_KERNEL_PGTABLE_FREE is set,
> pagetable_free_kernel() will batch the page table freeing operation,
> otherwise it frees the page table directly.
> 
> While the KASAN report that syzbot highlighted indicated that the issue
> arose in a workqueue introduced by this change, this is coincidental and
> the commit did not alter the race which has existed for quite some time.
> 
> This patch resolves the issue by simply having
> vmap_try_huge_[p4d,pud,pmd]() hold the mmap read lock on init_mm while
> invoking [p4d,pud,pmd]_free_[pud,pmd,pte]_page() and
> [p4d,pud,pmd]_set_huge().
> 
> This way, page table walkers either observe a newly promoted huge
> P4D/PUD/PMD leaf entry or the prior PUD/PMD/PTE entry and never get passed
> a dangling pointer, whether the page is freed asynchronously or not.
> 
> All other kernel page table walkers that touch vmalloc ranges either
> exclusively own the memory walked or acquire the mmap lock, so this
> correctly excludes those walkers.
> 
> We acquire the mmap read lock as a trylock, as this is an optimisation that
> is permitted not to succeed, a race is very unlikely, and doing so
> eliminates latency sleeping on the lock would have otherwise caused.
> 
> We also define a guard class for mmap_read_trylock() so we can use
> cleanup.h to make the scope handling cleaner in the implementation.
> 
> One wrinkle here is commit fa93b45fd397 ("arm64: Enable vmalloc-huge with
> ptdump"), which addresses the issue for arm64 only by explicitly acquiring
> the mmap read lock on kernel page table freeing should a concurrent ptdump
> be in progress.
> 
> This is problematic as vmap may acquire the mmap read lock prior to ptdump
> attempting to acquire an mmap write lock, leading to a deadlock when the
> mmap read lock is slept upon on page table freeing due to rwsem
> anti-starvation.
> 
> We work around this by predicating the mmap lock being taken on
> !CONFIG_ARM64 for the time being.
> 
> With this patch applied, a follow up will partially revert commit
> fa93b45fd397 ("arm64: Enable vmalloc-huge with ptdump") and at that stage
> remove the arm64 ifdeffery.
> 
> We also update walk_page_range_debug() to assert the mmap write lock
> unconditionally and update the comment here to reflect this change.
> 
> The issue has existed as long as ptdump was available and vmap freed page
> tables when promoting to a huge leaf entry, that is, since commit
> b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table") for
> huge ioremap, and commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc
> mappings") for huge vmalloc.
> 
> Since the former is the earlier of the two we choose that for our Fixes
> tag.
> 
> This patch is based on work by David Carlier (linked), with gratitude!
> 
> Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a287988.39669fcc.33b062.00a0.GAE@google.com/T/
> Link: https://lore.kernel.org/linux-mm/20260706203128.162335-1-devnexen@gmail.com/
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
Reviewed-by: Dev Jain <dev.jain@arm.com>



