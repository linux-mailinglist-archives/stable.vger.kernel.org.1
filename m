Return-Path: <stable+bounces-154859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF0DAE117B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222E74A31EA
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 03:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A727A1DC997;
	Fri, 20 Jun 2025 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ju9I0YQ8"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A921BE86E
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750388468; cv=none; b=q7ATamlzJfGH7T18myVeubErJZgoROk6C03Fu4VhJky3tfm0llGegnCmPu9jHLDyZZHfb1gkpgn0ZgEzf24bgralTjvz3oG40ZKIRj2fjV8kHJJujFRM0ZhjqyHlWPodrinO0wPZuPO5g3RnpW5bcFs/C8OQ/gZ05z/UVnZsMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750388468; c=relaxed/simple;
	bh=4a0bmLFeTK0aaibt4RewKrAtW5Wtj1Q0n7jVE5iKfzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sn6h9HhyJfKnjKoG3VsLxxKJDfbWb3oLvZKchucgitB6LGxfn8MjzLUy4NCMJcrnI+5IXI69E19A1TChVwAPYCljR2MF8nvrouzVxXKNzeESzSZmEjg4mX5hf2PEWup+EQtLNH2m8JWDCtPXuwmG62dF9SU8649b0Mv2ewg/3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ju9I0YQ8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5MEiQjyk/LIBJVsQLxcou3bFWP07C8raGOjZkKtLHkU=; b=ju9I0YQ8tsYLdZ44UKO6jKIfhk
	5V/C0nLpLtXbYAvpdp9essauba2ML7SRJSN4TqOeqycseRLQk8Or9iiBiXpvIYsuJe3BoFy2EKAk/
	5lLsKwTjSJQctiR/zDRCjEGGYn13OQLpkCpx4zfAPdZGl1CXLPZeCetVvZC+Bl84yUT6UA4a8M+Hi
	fbVQVyaz4RTdUy2S4aCBVA8zOcLZlAxiuh9ZeqbB9qIFhDK7/FFI8h26FxDcyua0O4iuqKTmCWbeU
	7SCcswZhjdB6/o+PFCpJkbdFJZrVr+huPXUZbReYiZ0lsNg32OlmCQteaU99Hxzqk1Ps9QuAgKIOJ
	KFgZtW6A==;
Received: from 106-64-160-204.adsl.fetnet.net ([106.64.160.204] helo=[192.168.238.43])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uSRzb-005oT9-7g; Fri, 20 Jun 2025 05:00:39 +0200
Message-ID: <aa32c9cd-9dac-4982-8484-ea11c1a003f1@igalia.com>
Date: Fri, 20 Jun 2025 11:00:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Gavin Shan <gshan@redhat.com>, Florent Revest <revest@google.com>,
 Matthew Wilcox <willy@infradead.org>, Miaohe Lin <linmiaohe@huawei.com>,
 stable@vger.kernel.org
References: <2025051204-tidal-lake-6ae7@gregkh>
 <20250616024203.1783486-1-gavinguo@igalia.com>
 <f903c761-8399-04f3-0f32-475b365177fb@google.com>
 <c6eed86d-9a79-4845-8289-e9b24c46b88a@igalia.com>
 <1993fdd9-656a-6c25-fb83-cb2993bc18eb@google.com>
Content-Language: en-US
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <1993fdd9-656a-6c25-fb83-cb2993bc18eb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/25 04:17, Hugh Dickins wrote:
> On Thu, 19 Jun 2025, Gavin Guo wrote:
>> On 6/19/25 11:30, Hugh Dickins wrote:
>>> On Mon, 16 Jun 2025, Gavin Guo wrote:
>>>
>>>> [ Upstream commit be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7 ]
>>>>
>>>> When migrating a THP, concurrent access to the PMD migration entry during
>>>> a deferred split scan can lead to an invalid address access, as
>>>> illustrated below.  To prevent this invalid access, it is necessary to
>>>> check the PMD migration entry and return early.  In this context, there is
>>>> no need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
>>>> equality of the target folio.  Since the PMD migration entry is locked, it
>>>> cannot be served as the target.
>>>>
>>>> Mailing list discussion and explanation from Hugh Dickins: "An anon_vma
>>>> lookup points to a location which may contain the folio of interest, but
>>>> might instead contain another folio: and weeding out those other folios is
>>>> precisely what the "folio != pmd_folio((*pmd)" check (and the "risk of
>>>> replacing the wrong folio" comment a few lines above it) is for."
>>>>
>>>> BUG: unable to handle page fault for address: ffffea60001db008
>>>> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
>>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>>> 1.16.3-debian-1.16.3-2 04/01/2014
>>>> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
>>>> Call Trace:
>>>> <TASK>
>>>> try_to_migrate_one+0x28c/0x3730
>>>> rmap_walk_anon+0x4f6/0x770
>>>> unmap_folio+0x196/0x1f0
>>>> split_huge_page_to_list_to_order+0x9f6/0x1560
>>>> deferred_split_scan+0xac5/0x12a0
>>>> shrinker_debugfs_scan_write+0x376/0x470
>>>> full_proxy_write+0x15c/0x220
>>>> vfs_write+0x2fc/0xcb0
>>>> ksys_write+0x146/0x250
>>>> do_syscall_64+0x6a/0x120
>>>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>
>>>> The bug is found by syzkaller on an internal kernel, then confirmed on
>>>> upstream.
>>>>
>>>> Link: https://lkml.kernel.org/r/20250421113536.3682201-1-gavinguo@igalia.com
>>>> Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
>>>> Link: https://lore.kernel.org/all/20250418085802.2973519-1-gavinguo@igalia.com/
>>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
>>>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Acked-by: Hugh Dickins <hughd@google.com>
>>>> Acked-by: Zi Yan <ziy@nvidia.com>
>>>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>>> Cc: Florent Revest <revest@google.com>
>>>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>> [gavin: backport the migration checking logic to __split_huge_pmd]
>>>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>>>> ---
>>>>    mm/huge_memory.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 9139da4baa39..bcefc17954d6 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2161,7 +2161,7 @@ void __split_huge_pmd(struct vm_area_struct *vma,
>>>> pmd_t *pmd,
>>>>     VM_BUG_ON(freeze && !page);
>>>>     if (page) {
>>>>    		VM_WARN_ON_ONCE(!PageLocked(page));
>>>> -		if (page != pmd_page(*pmd))
>>>> +		if (is_pmd_migration_entry(*pmd) || page != pmd_page(*pmd))
>>>>     		goto out;
>>>>     }
>>>>    @@ -2196,7 +2196,7 @@ void __split_huge_pmd(struct vm_area_struct *vma,
>>>> pmd_t *pmd,
>>>>      }
>>>>      if (PageMlocked(page))
>>>>    			clear_page_mlock(page);
>>>> -	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
>>>> +	} else if (!pmd_devmap(*pmd))
>>>>      goto out;
>>>
>>> I'm sorry, Gavin, but this 5.15 and the 5.10 and 5.4 backports look wrong
>>> to me, because here you drop the is_pmd_migration_entry(*pmd) condition,
>>> but if !page then that has not been checked earlier (this check here is
>>> specifically allowing a pmd migration entry to proceed to the split).
>>>
>>> Hugh
>>
>> Hi Hugh,
>>
>> Thank you again for the review.
>>
>> Regarding the 5.4/5.10/5.15. How do you think about the following changes?
> 
> I think you are going way off track with the following changes.
> 
> The first hunk of your backport (the pmd_page line) was fine, it was the
> second hunk (the pmd_devmap line) that I objected to: that second hunk
> should just be deleted, to make no change on the pmd_devmap line.
> 
> Maybe you're misreading that pmd_devmap line, it is easy to get lost
> in its ! and parentheses.

Got it. I'll just go ahead removing the second hunk and submit the patch 
soon.

> 
>>
>> @@ -2327,6 +2327,8 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t
>> *pmd,
>>          mmu_notifier_invalidate_range_start(&range);
>>          ptl = pmd_lock(vma->vm_mm, pmd);
>>
>> +       if (is_pmd_migration_entry(*pmd))
>> +               goto out;
> 
> No.  In general, __split_huge_pmd_locked() works on pmd migration entries;
> the bug you are fixing is not with pmd migration entries as such, but with
> applying pmd_page(*pmd) when *pmd is a migration entry.

Yeah, you are correct. Maybe I was thinking too much. When I modified 
the code, I recalled that the folio lock theory you mentioned in the 
upstream discussion that when migration happens the folio lock is taken 
and in this split path, it's impossible to take the same lock and the 
folio must be the same. If it's not the same, it could be the symptom of 
the reverse mapping behavior and we just skip it.

However, I would stop the discussion here without sprawling the logic 
and focusing on fixing the pmd_page(*pmd) problem.

> 
> I do not recall offhand how important it is that __split_huge_pmd_locked()
> should apply to pmd migration entries (when page here is NULL), and I do
> not wish to spend time researching that: maybe it's just an optimization,
> or maybe it's essential on some path.  What is clear is that this bugfix
> backport should not be making any change to that behaviour.

Agreed.

> 
>>          /*
>>           * If caller asks to setup a migration entries, we need a page to
>> check
>>           * pmd against. Otherwise we can end up replacing wrong page.
>> @@ -2369,7 +2371,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t
>> *pmd,
>>                  }
>>                  if (PageMlocked(page))
>>                          clear_page_mlock(page);
>> -       } else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
>> +       } else if (!pmd_devmap(*pmd) )
>>                  goto out;
>>          __split_huge_pmd_locked(vma, pmd, range.start, freeze);
>>   out:
>>
>> There is still an access, page = pmd_page(*pmd), inside the if(!page). I'm not
>> sure if pmd could be a migration entry when the page is NULL. To avoid this as
>> well, maybe just goto out directly in the beginning?
> 
> No.  The other pmd_page(*pmd) is inside a pmd_trans_huge(*pmd) block,
> so it's safe, *pmd cannot be a migration entry there.  (Though admittedly
> I have to check rather carefully, because, at least in the x86 case,
> pmd_trans_huge(*pmd) does not guarantee that the present bit is set.)

Looks good to me. Thank you for reviewing the logic.

> 
> Hugh
> 
>>
>>>
>>>>    	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
>>>>    out:
>>>>
>>>> base-commit: 1c700860e8bc079c5c71d73c55e51865d273943c
>>>> -- 
>>>> 2.43.0


