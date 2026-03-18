Return-Path: <stable+bounces-226966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPUtE4dDumljTgIAu9opvQ
	(envelope-from <stable+bounces-226966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:17:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2682B6467
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B51BA305093B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBFD36214D;
	Wed, 18 Mar 2026 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNhhNDAi"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79FE243376
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814615; cv=none; b=gq0NByeo75m4U0P1tVxfLl+vLPxE8o25qMjE1nWniZgIK0tHX2t37s7Ul3PGfgtKS8M82dsOVRr2/Hh2biU/cWf1jz1JNIk6DwFgXYgnC8DFex2yTwipBMrpuMKGplAM2uD9X3V89ZmeLlimIpjGJ30PwFXfjRYWWlopG5mM4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814615; c=relaxed/simple;
	bh=0P/HhXaIZHVp9qjmL/0dO1b2rfXAZHkCTBXE0PKnwuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjpCk1/q39LsDg3v5Lw8twdJyUimElinjZoL6ui0e4IgaE8+yfakZq0xJg2AYW7TLzN2dspy7v61kpBQVkyLj7BgzjQdqZuQBH/7SG/pqHKmO4AfcsytkqqgRxa/1nYjmfu+q79sLmPKcG5TvKM095IfUBNuWBRTjnh/GHUj5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNhhNDAi; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <268abf39-9cd6-412e-b3ec-32fb8fea1684@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773814602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0RHFhfIi8eQ/zhOmgjp0C3T+zZS/NNRXu1jd6CQgfE=;
	b=MNhhNDAiders9o4vuBDcAzvePbJoit8K5gvmIIoWdlrp50PwJUf+0ccBSLX2+cpGB8NFP4
	q1IE+M08MhKV/wICLwdON7tPKo7DOZuhgUdxjertAyMvibX1pkaVxZJD6ZB0/U/tNF1tC/
	S6nRQOHgMwvohBfj+W6iF4mBoPPNYjg=
Date: Wed, 18 Mar 2026 14:16:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/pagewalk: fix race between concurrent split and
 refault
To: mboone@akamai.com, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 stable@vger.kernel.org
References: <20260317-pagewalk-check-pmd-refault-v1-1-f699a010f2b3@akamai.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260317-pagewalk-check-pmd-refault-v1-1-f699a010f2b3@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226966-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: BA2682B6467
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Max,

On 3/17/26 10:03 PM, Max Boone via B4 Relay wrote:
> From: Max Boone <mboone@akamai.com>
> 
> The splitting of a PUD entry in walk_pud_range() can race with
> a concurrent thread refaulting the PUD leaf entry causing it to
> try walking a PMD range that has disappeared.
> 
> An example and reproduction of this is to try reading numa_maps of
> a process while VFIO-PCI is setting up DMA (specifically the
> vfio_pin_pages_remote call) on a large BAR for that process.
> 
> This will trigger a kernel BUG:
> vfio-pci 0000:03:00.0: enabling device (0000 -> 0002)
> BUG: unable to handle page fault for address: ffffa23980000000
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> ...
> RIP: 0010:walk_pgd_range+0x3b5/0x7a0
> Code: 8d 43 ff 48 89 44 24 28 4d 89 ce 4d 8d a7 00 00 20 00 48 8b 4c 24
> 28 49 81 e4 00 00 e0 ff 49 8d 44 24 ff 48 39 c8 4c 0f 43 e3 <49> f7 06
>     9f ff ff ff 75 3b 48 8b 44 24 20 48 8b 40 28 48 85 c0 74
> RSP: 0018:ffffac23e1ecf808 EFLAGS: 00010287
> RAX: 00007f44c01fffff RBX: 00007f4500000000 RCX: 00007f44ffffffff
> RDX: 0000000000000000 RSI: 000ffffffffff000 RDI: ffffffff93378fe0
> RBP: ffffac23e1ecf918 R08: 0000000000000004 R09: ffffa23980000000
> R10: 0000000000000020 R11: 0000000000000004 R12: 00007f44c0200000
> R13: 00007f44c0000000 R14: ffffa23980000000 R15: 00007f44c0000000
> FS:  00007fe884739580(0000) GS:ffff9b7d7a9c0000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffa23980000000 CR3: 000000c0650e2005 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   __walk_page_range+0x195/0x1b0
>   walk_page_vma+0x62/0xc0
>   show_numa_map+0x12b/0x3b0
>   seq_read_iter+0x297/0x440
>   seq_read+0x11d/0x140
>   vfs_read+0xc2/0x340
>   ksys_read+0x5f/0xe0
>   do_syscall_64+0x68/0x130
>   ? get_page_from_freelist+0x5c2/0x17e0
>   ? mas_store_prealloc+0x17e/0x360
>   ? vma_set_page_prot+0x4c/0xa0
>   ? __alloc_pages_noprof+0x14e/0x2d0
>   ? __mod_memcg_lruvec_state+0x8d/0x140
>   ? __lruvec_stat_mod_folio+0x76/0xb0
>   ? __folio_mod_stat+0x26/0x80
>   ? do_anonymous_page+0x705/0x900
>   ? __handle_mm_fault+0xa8d/0x1000
>   ? __count_memcg_events+0x53/0xf0
>   ? handle_mm_fault+0xa5/0x360
>   ? do_user_addr_fault+0x342/0x640
>   ? arch_exit_to_user_mode_prepare.constprop.0+0x16/0xa0
>   ? irqentry_exit_to_user_mode+0x24/0x100
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fe88464f47e
> Code: c0 e9 b6 fe ff ff 50 48 8d 3d be 07 0b 00 e8 69 01 02 00 66 0f 1f
> 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00
>     f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> RSP: 002b:00007ffe6cd9a9b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fe88464f47e
> RDX: 0000000000020000 RSI: 00007fe884543000 RDI: 0000000000000003
> RBP: 00007fe884543000 R08: 00007fe884542010 R09: 0000000000000000
> R10: fffffffffffffbc5 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
>   </TASK>
> 
> Fix this by validating the PUD entry in walk_pmd_range() using a stable
> snapshot (pudp_get()). If the PUD is not present or is a leaf, retry the
> walk via ACTION_AGAIN instead of descending further. This mirrors the
> retry logic in walk_pmd_range().
> 
> Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
> Cc: stable@vger.kernel.org
> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Max Boone <mboone@akamai.com>
> ---
>   mm/pagewalk.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index a94c401ab..c74b4d800 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -97,6 +97,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>   static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>   			  struct mm_walk *walk)
>   {
> +	pud_t pudval = pudp_get(pud);
>   	pmd_t *pmd;
>   	unsigned long next;
>   	const struct mm_walk_ops *ops = walk->ops;
> @@ -105,6 +106,18 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>   	int err = 0;
>   	int depth = real_depth(3);
>   
> +	/*
> +	 * For PTE handling, pte_offset_map_lock() takes care of checking
> +	 * whether there actually is a page table. But it also has to be
> +	 * very careful about concurrent page table reclaim. If we spot a PMD
> +	 * table, it cannot go away, so we can just walk it. However, if we find
> +	 * something else, we have to retry.
> +	 */
> +	if (!pud_present(pudval) || pud_leaf(pudval)) {
> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
> +
>   	pmd = pmd_offset(pud, addr);
>   	do {
>   again:
> @@ -218,12 +231,13 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>   		else if (pud_leaf(*pud) || !pud_present(*pud))
>   			continue; /* Nothing to do. */

Why not check pudval directly here? Like the following:

		if (pud_leaf(*pud) || !pud_present(*pud))
			goto again;

>   
> -		if (pud_none(*pud))
> -			goto again;
> -
>   		err = walk_pmd_range(pud, addr, next, walk);
>   		if (err)
>   			break;
> +
> +		if (walk->action == ACTION_AGAIN)
> +			goto again;
> +
>   	} while (pud++, addr = next, addr != end);
>   
>   	return err;
> 
> ---
> base-commit: b4f0dd314b39ea154f62f3bd3115ed0470f9f71e
> change-id: 20260317-pagewalk-check-pmd-refault-de8f14fbe6a5
> 
> Best regards,


