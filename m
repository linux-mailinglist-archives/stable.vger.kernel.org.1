Return-Path: <stable+bounces-213238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF/dJkb2gWljNAMAu9opvQ
	(envelope-from <stable+bounces-213238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 14:21:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F05D2D9D8D
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 14:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 999DA3013D66
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94BD350A33;
	Tue,  3 Feb 2026 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gflWpeyT"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DA349AEC
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124826; cv=none; b=WmD6N15h+KHV6a3hj2xCmozGCF+sr5yhAieXzjLfgY1vGnMleWQL0xLus/V9gj7u0fQcr3s12ZHRsLj7az0UPc5NbhXY5yv+IsmMTqGhX7U14uzKvGhGhfoBY0TqylM37vNNhrXhF1dJTal9P5zbgEoY7Gwx2OmDD5v5C8sOHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124826; c=relaxed/simple;
	bh=gpmVifp1NSkiLysZJfdg+0tRVOPN+/dD02W3+R1uBRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCYXt0nQOIjB+Bcb/0MPccXD7YTH0UpvZ6GcCucYEUFn/Ek/GpI4Wm9uOT3pwLkK5wn6UT+BykLEceLb/GxrY+E8UFuhwC21BdfOivQiGdUumvqCabK8a7Wj+ghSSpdVRlNjefybZkEFoPJGXyoueoanGaRYatElnSFvW/Vqy6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gflWpeyT; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770124820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCN/KXyaNLhPpDlNl5DFscQc8m92nKiFKj5UwfM91fw=;
	b=gflWpeyT9Lg77R9MOVQpSaX2p7Yr7DDMp8uR0kDuSKgWLkV5MBAkSMKiSBE5kxGEvgAWNJ
	wP5vrTOVmc9aillHtjQEfC7arApsydjdQSRvrUm6z3N11eBctkialSeMbUsyV5+2QA6gfo
	2EbOJTvieIp+5IqsUg88j2MSspz99Jc=
From: Lance Yang <lance.yang@linux.dev>
To: ziy@nvidia.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	gavinguo@igalia.com,
	gshan@redhat.com,
	harry.yoo@oracle.com,
	jannh@google.com,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	richard.weiyang@gmail.com,
	riel@surriel.com,
	stable@vger.kernel.org,
	vbabka@suse.cz,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when split huge pmd for shared thp
Date: Tue,  3 Feb 2026 21:20:06 +0800
Message-ID: <20260203132006.66958-1-lance.yang@linux.dev>
In-Reply-To: <4D8CC775-A86C-4D80-ADB3-6F5CD0FF9330@nvidia.com>
References: <4D8CC775-A86C-4D80-ADB3-6F5CD0FF9330@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213238-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,linux.alibaba.com,kernel.org,igalia.com,redhat.com,google.com,kvack.org,gmail.com,surriel.com,vger.kernel.org,suse.cz,linux.dev];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: F05D2D9D8D
X-Rspamd-Action: no action


On Sun, Feb 01, 2026 at 09:20:35AM -0500, Zi Yan wrote:
>On 1 Feb 2026, at 8:04, Gavin Guo wrote:
>
>> On 2/1/26 11:39, Zi Yan wrote:
>>> On 31 Jan 2026, at 21:09, Wei Yang wrote:
>>>
>>>> On Fri, Jan 30, 2026 at 09:44:10PM -0500, Zi Yan wrote:
>>>>> On 30 Jan 2026, at 18:00, Wei Yang wrote:
>>>>>
>>>>>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
>>>>>> split_huge_pmd_locked()") return false unconditionally after
>>>>>> split_huge_pmd_locked() which may fail early during try_to_migrate() for
>>>>>> shared thp. This will lead to unexpected folio split failure.
>>>>>>
>>>>>> One way to reproduce:
>>>>>>
>>>>>>      Create an anonymous thp range and fork 512 children, so we have a
>>>>>>      thp shared mapped in 513 processes. Then trigger folio split with
>>>>>>      /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>>>>>>      order 0.
>>>>>>
>>>>>> Without the above commit, we can successfully split to order 0.
>>>>>> With the above commit, the folio is still a large folio.
>>>>>>
>>>>>> The reason is the above commit return false after split pmd
>>>>>> unconditionally in the first process and break try_to_migrate().
>>>>>
>>>>> The reasoning looks good to me.
>>>>>
>>>>>>
>>>>>> The tricky thing in above reproduce method is current debugfs interface
>>>>>> leverage function split_huge_pages_pid(), which will iterate the whole
>>>>>> pmd range and do folio split on each base page address. This means it
>>>>>> will try 512 times, and each time split one pmd from pmd mapped to pte
>>>>>> mapped thp. If there are less than 512 shared mapped process,
>>>>>> the folio is still split successfully at last. But in real world, we
>>>>>> usually try it for once.
>>>>>>
>>>>>> This patch fixes this by removing the unconditional false return after
>>>>>> split_huge_pmd_locked(). Later, we may introduce a true fail early if
>>>>>> split_huge_pmd_locked() does fail.
>>>>>>
>>>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>>>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
>>>>>> Cc: Gavin Guo <gavinguo@igalia.com>
>>>>>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>> Cc: <stable@vger.kernel.org>
>>>>>> ---
>>>>>>   mm/rmap.c | 1 -
>>>>>>   1 file changed, 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index 618df3385c8b..eed971568d65 100644
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>>>>   			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>>>   				split_huge_pmd_locked(vma, pvmw.address,
>>>>>>   						      pvmw.pmd, true);
>>>>>> -				ret = false;
>>>>>>   				page_vma_mapped_walk_done(&pvmw);
>>>>>>   				break;
>>>>>>   			}
>>>>>
>>>>> How about the patch below? It matches the pattern of set_pmd_migration_entry() below.
>>>>> Basically, continue if the operation is successful, break otherwise.
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 618df3385c8b..83cc9d98533e 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -2448,9 +2448,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>>> 			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>> 				split_huge_pmd_locked(vma, pvmw.address,
>>>>> 						      pvmw.pmd, true);
>>>>> -				ret = false;
>>>>> -				page_vma_mapped_walk_done(&pvmw);
>>>>> -				break;
>>>>> +				continue;
>>>>> 			}
>>>>
>>>> Per my understanding if @freeze is trur, split_huge_pmd_locked() may "fail" as
>>>> the comment says:
>>>>
>>>> 		 * Without "freeze", we'll simply split the PMD, propagating the
>>>> 		 * PageAnonExclusive() flag for each PTE by setting it for
>>>> 		 * each subpage -- no need to (temporarily) clear.
>>>> 		 *
>>>> 		 * With "freeze" we want to replace mapped pages by
>>>> 		 * migration entries right away. This is only possible if we
>>>> 		 * managed to clear PageAnonExclusive() -- see
>>>> 		 * set_pmd_migration_entry().
>>>> 		 *
>>>> 		 * In case we cannot clear PageAnonExclusive(), split the PMD
>>>> 		 * only and let try_to_migrate_one() fail later.
>>>>
>>>> While currently we don't return the status of split_huge_pmd_locked() to
>>>> indicate whether it does replaced PMD with migration entries successfully. So
>>>> we are not sure this operation succeed.
>>>
>>> This is the right reasoning. This means to properly handle it, split_huge_pmd_locked()
>>> needs to return whether it inserts migration entries or not when freeze is true.
>>>
>>>>
>>>> Another difference from set_pmd_migration_entry() is split_huge_pmd_locked()
>>>> would change the page table from PMD mapped to PTE mapped.
>>>> page_vma_mapped_walk() can handle it now for (pvmw->pmd && !pvmw->pte), but I
>>>> am not sure this is what we expected. For example, in try_to_unmap_one(), we
>>>> use page_vma_mapped_walk_restart() after pmd splitted.
>>>>
>>>> So I prefer just remove the "ret = false" for a fix. Not sure this is
>>>> reasonable to you.
>>>>
>>>> I am thinking two things after this fix:
>>>>
>>>>    * add one similar test in selftests
>>>>    * let split_huge_pmd_locked() return value to indicate freeze is degrade to
>>>>      !freeze, and fail early on try_to_migrate() like the thp migration branch
>>>>
>>>> Look forward your opinion on whether it worth to do it.
>>>
>>> This is not the right fix, neither was mine above. Because before commit 60fbb14396d5,
>>> the code handles PAE properly. If PAE is cleared, PMD is split into PTEs and each
>>> PTE becomes a migration entry, page_vma_mapped_walk(&pvmw) returns false,
>>> and try_to_migrate_one() returns true. If PAE is not cleared, PMD is split into PTEs
>>> and each PTE is not a migration entry, inside while (page_vma_mapped_walk(&pvmw)),
>>> PAE will be attempted to get cleared again and it will fail again, leading to
>>> try_to_migrate_one() returns false. After commit 60fbb14396d5, no matter PAE is
>>> cleared or not, try_to_migrate_one() always returns false. It causes folio split
>>> failures for shared PMD THPs.
>>>
>>> Now with your fix (and mine above), no matter PAE is cleared or not, try_to_migrate_one()
>>> always returns true. It just flips the code to a different issue. So the proper fix
>>> is to let split_huge_pmd_locked() returns whether it inserts migration entries or not
>>> and do the same pattern as THP migration code path.
>>
>> How about aligning with the try_to_unmap_one()? The behavior would be the same before applying the commit 60fbb14396d5:
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 7b9879ef442d..0c96f0883013 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2333,9 +2333,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>                         if (flags & TTU_SPLIT_HUGE_PMD) {
>>                                 split_huge_pmd_locked(vma, pvmw.address,
>>                                                       pvmw.pmd, true);
>> -                               ret = false;
>> -                               page_vma_mapped_walk_done(&pvmw);
>> -                               break;
>> +                               flags &= ~TTU_SPLIT_HUGE_PMD;
>> +                               page_vma_mapped_walk_restart(&pvmw);
>> +                               continue;
>>                         }
>>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>                         pmdval = pmdp_get(pvmw.pmd);
>
>Yes, it works and definitely needs a comment like "After split_huge_pmd_locked(), restart
>the walk to detect PageAnonExclusive handling failure in __split_huge_pmd_locked()".
>The change is good for backporting, but an additional patch to fix it properly by adding
>a return value to split_huge_pmd_locked() is also necessary.

Right. IIUC, after split_huge_pmd_locked() we always have 512 PTEs: either
migration entries, or present PTEs with PageAnonExclusive still set.

And try_to_migrate_one() doesn't use PVMW_MIGRATION. So when we restart the
walk we're either seeing migration — then map_pte/check_pte() won't match,
we hit not_found() and leave the loop with ret still true.

Or we see present (with PageAnonExclusive still set) — then we drop into
the normal PTE path, call folio_try_share_anon_rmap_pte() again, and set
ret=false when it fails.

Cheers,
Lance

