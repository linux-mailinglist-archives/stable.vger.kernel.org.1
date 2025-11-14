Return-Path: <stable+bounces-194785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ABBC5CC3D
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 12:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304EB3A58B1
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7098314A80;
	Fri, 14 Nov 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfgtP7iO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0D3101C5
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118426; cv=none; b=Q57FIFA3b8N5tvOnWqan5blCVNex9MagNsrBgT5P1CnTd6i5uxoNbNtxVVFsTyJy8LF/TFCgu+P3pg5Y2Dorcx733DCKxhiqS6Ln3DnwY/aU+4D43AU+wtcsei4vDSP0sXN4SkNr5MIdC0yVJ5BS9yH5kSvJ6on7ky878mnqeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118426; c=relaxed/simple;
	bh=Ld25Z6bV94GxcOfQ4cSv39KO4Zh49TFp9Q2zSOzNfAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdyr07yiXHhopxkptgyhTuuS0J7Gtr4dWCNT6/foTBE899e7f9fBuTdMVceH1soy5310p7JLhL68ksknW+RaZqy0uM7/rqj9A/XRmkbHepRB/42DL9iNim69OOToWPNvWCzR3WjO3hrqpPOrG0Ms4M75irO4iTRo8LqRBhq7iUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfgtP7iO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C34BC4CEF5;
	Fri, 14 Nov 2025 11:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763118424;
	bh=Ld25Z6bV94GxcOfQ4cSv39KO4Zh49TFp9Q2zSOzNfAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nfgtP7iOLYmEMkJL2Rb/c6ZvDDySgHClSdxhBjinmvfGgWvK26v5Yss6zoUP2dfKV
	 QSYkpYYtCgHkiacxtGvne/V2KdtHk/kmy9cVGrwDyfyIyx1UKP6c3TqrUExIJwV6xa
	 Yg8+J+8m7hzJu94XYaqjBxtMWpPZZXDICBXVCzDRxPLiKmAsB0P3V3E9qhUHIh65RZ
	 7g+zwwLyXMJlt4ZaFdBQCjUWiZiyKR0xdkuqvAcSQI7Vo4PndGOILhzCdZvNnAsFmd
	 DCBmwpTis3enR+FHtxeU8D/cQ2ClcZ6unhbG0xVC2v4uenqNTW9P02+MO7pVxAJvoM
	 0SCXy2/NJmuZg==
Message-ID: <ac8d7137-3819-4a75-9dd3-fb3d2259ebe4@kernel.org>
Date: Fri, 14 Nov 2025 12:06:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 6.1.y 0/2] Fix bad pmd due to race between
 change_prot_numa() and THP migration
To: Harry Yoo <harry.yoo@oracle.com>, stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 jane.chu@oracle.com, jannh@google.com, kas@kernel.org, lance.yang@linux.dev,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, npache@redhat.com,
 pfalcato@suse.de, ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com
References: <20251111071101.680906-1-harry.yoo@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251111071101.680906-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.11.25 08:10, Harry Yoo wrote:
> # TL;DR
> 
> previous discussion: https://lore.kernel.org/linux-mm/b41ea29e-6b48-4f64-859c-73be095453ae@redhat.com/
> 
> A "bad pmd" error occurs due to race condition between
> change_prot_numa() and THP migration. The mainline kernel does not have
> this bug as commit 670ddd8cdc fixes the race condition. 6.1.y, 5.15.y,
> 5.10.y, 5.4.y are affected by this bug.
> 
> Fixing this in -stable kernels is tricky because pte_map_offset_lock()
> has different semantics in pre-6.5 and post-6.5 kernels. I am trying to
> backport the same mechanism we have in the mainline kernel.
> Since the code looks bit different due to different semantics of
> pte_map_offset_lock(), it'd be best to get this reviewed by MM folks.
> 
> # Testing
> 
> I verified that the bug described below is not reproduced anymore
> (on a downstream kernel) after applying this patch series. It used to
> trigger in few days of intensive numa balancing testing, but it survived
> 2 weeks with this applied.
> 
> # Bug Description
> 
> It was reported that a bad pmd is seen when automatic NUMA
> balancing is marking page table entries as prot_numa:
>      
>    [2437548.196018] mm/pgtable-generic.c:50: bad pmd 00000000af22fc02(dffffffe71fbfe02)
>    [2437548.235022] Call Trace:
>    [2437548.238234]  <TASK>
>    [2437548.241060]  dump_stack_lvl+0x46/0x61
>    [2437548.245689]  panic+0x106/0x2e5
>    [2437548.249497]  pmd_clear_bad+0x3c/0x3c
>    [2437548.253967]  change_pmd_range.isra.0+0x34d/0x3a7
>    [2437548.259537]  change_p4d_range+0x156/0x20e
>    [2437548.264392]  change_protection_range+0x116/0x1a9
>    [2437548.269976]  change_prot_numa+0x15/0x37
>    [2437548.274774]  task_numa_work+0x1b8/0x302
>    [2437548.279512]  task_work_run+0x62/0x95
>    [2437548.283882]  exit_to_user_mode_loop+0x1a4/0x1a9
>    [2437548.289277]  exit_to_user_mode_prepare+0xf4/0xfc
>    [2437548.294751]  ? sysvec_apic_timer_interrupt+0x34/0x81
>    [2437548.300677]  irqentry_exit_to_user_mode+0x5/0x25
>    [2437548.306153]  asm_sysvec_apic_timer_interrupt+0x16/0x1b
> 
> This is due to a race condition between change_prot_numa() and
> THP migration because the kernel doesn't check is_swap_pmd() and
> pmd_trans_huge() atomically:
> 
> change_prot_numa()                      THP migration
> ======================================================================
> - change_pmd_range()
> -> is_swap_pmd() returns false,
> meaning it's not a PMD migration
> entry.
> 				  - do_huge_pmd_numa_page()
> 				  -> migrate_misplaced_page() sets
> 				     migration entries for the THP.
> - change_pmd_range()
> -> pmd_none_or_clear_bad_unless_trans_huge()
> -> pmd_none() and pmd_trans_huge() returns false
> - pmd_none_or_clear_bad_unless_trans_huge()
> -> pmd_bad() returns true for the migration entry!
> 
> The upstream commit 670ddd8cdcbd ("mm/mprotect: delete
> pmd_none_or_clear_bad_unless_trans_huge()") closes this race condition
> by checking is_swap_pmd() and pmd_trans_huge() atomically.
> 
> # Backporting note
> 
> commit a79390f5d6a7 ("mm/mprotect: use long for page accountings and retval")
> is backported to return an error code (negative value) in
> change_pte_range().
> 
> Unlike the mainline, pte_offset_map_lock() does not check if the pmd
> entry is a migration entry or a hugepage; acquires PTL unconditionally
> instead of returning failure. Therefore, it is necessary to keep the
> !is_swap_pmd() && !pmd_trans_huge() && !pmd_devmap() checks in
> change_pmd_range() before acquiring the PTL.
> 
> After acquiring the lock, open-code the semantics of
> pte_offset_map_lock() in the mainline kernel; change_pte_range() fails
> if the pmd value has changed. This requires adding pmd_old parameter
> (pmd_t value that is read before calling the function) to
> change_pte_range().

Looks reasonable to me, so I assume the backporting diff makes sense.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

