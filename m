Return-Path: <stable+bounces-134865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2276A9530B
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BF118951ED
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238D189F3F;
	Mon, 21 Apr 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NvnrrWqB"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7250126C1E;
	Mon, 21 Apr 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745246909; cv=none; b=AHpcatf+/UHFEBD5/f7kJuL9Ls4x/eOXg3u0XPQowFUudlcV9GqzQaiLH8rOH5gca8GJZyBg4UE2w/wX392f7XXvkswv+d/bJDHe8+UpuFyKO6RMknfVynnc0uilGTG31N7cPwxn9VMU5xy8eZC2BxkBeeHjx7n5OuYTY6GUmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745246909; c=relaxed/simple;
	bh=7aAMJZ+iym1p8+ko8GobuLt++Nib0/HQSbNLT3Cv0QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJlG+5HFnWA+GjMgeBn3UHEnxgGgXSEz6COZVjR8hl/7pu/p3StN3kjRJQjpwxx2v4vXbkx1EXHK4Z50iwhNUSm21y5dA710hD5gbU4vMqR59rBpj/B3wlu7tui4+vlqSDk01PHC4+mQzNSd1YL9C6l7Ayk56R38QqNsSGJY60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NvnrrWqB; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kwVVw2CqIRRe0Myaq1Inek1FYVeiqCcyjpy3VoSZ7XY=; b=NvnrrWqB8J2UENYzRduUt5rh6M
	HGubS1PYlulbA5D5rAiOfo5eEOVjSt0k0FezS2GHeKNRMQG+Q/qT36/9PFNAPYRGKgesNiduV+q8U
	dHbX9zEbmfh3b76m2sOvd9WaroSythbTkir+oi8DcbJBSA+djJb/IwbjJ7ZdUMgdcs89+/g03spFO
	op/X/nag1CXf9JVZYWjltWttrSKsRdhd6pukWfNDSrzTrzk8O+ukOtZwVOdJMfQX5wyCqZaUE5HLU
	JCp3piW6Z0xrJ7XnJjol2mYYwBqcAK193GBTIWr0eF50Znfrhs2NIbD8rV2ESfB379bx0AA2JSpWa
	N5u9F5PQ==;
Received: from 114-44-233-154.dynamic-ip.hinet.net ([114.44.233.154] helo=[192.168.1.104])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u6sRA-0060Jw-Ve; Mon, 21 Apr 2025 16:47:57 +0200
Message-ID: <f845502f-87b2-4eec-aa2f-1d62f21bf479@igalia.com>
Date: Mon, 21 Apr 2025 22:47:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
To: Gavin Shan <gshan@redhat.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, akpm@linux-foundation.org
Cc: willy@infradead.org, ziy@nvidia.com, linmiaohe@huawei.com,
 hughd@google.com, revest@google.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250418085802.2973519-1-gavinguo@igalia.com>
 <b1312600-1855-406c-9249-c7426f3a7324@redhat.com>
 <e66af83a-f628-4c5b-8d48-aa6a5d4b4948@redhat.com>
Content-Language: en-US
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <e66af83a-f628-4c5b-8d48-aa6a5d4b4948@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/19/25 07:53, Gavin Shan wrote:
> Hi Gavin,
> 
> On 4/18/25 8:42 PM, David Hildenbrand wrote:
>> On 18.04.25 10:58, Gavin Guo wrote:
>>> When migrating a THP, concurrent access to the PMD migration entry
>>> during a deferred split scan can lead to a invalid address access, as
>>> illustrated below. To prevent this page fault, it is necessary to check
>>> the PMD migration entry and return early. In this context, there is no
>>> need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
>>> equality of the target folio. Since the PMD migration entry is locked,
>>> it cannot be served as the target.
>>>
>>> Mailing list discussion and explanation from Hugh Dickins:
>>> "An anon_vma lookup points to a location which may contain the folio of
>>> interest, but might instead contain another folio: and weeding out those
>>> other folios is precisely what the "folio != pmd_folio((*pmd)" check
>>> (and the "risk of replacing the wrong folio" comment a few lines above
>>> it) is for."
>>>
>>> BUG: unable to handle page fault for address: ffffea60001db008
>>> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3- 
>>> debian-1.16.3-2 04/01/2014
>>> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
>>> Call Trace:
>>> <TASK>
>>> try_to_migrate_one+0x28c/0x3730
>>> rmap_walk_anon+0x4f6/0x770
>>> unmap_folio+0x196/0x1f0
>>> split_huge_page_to_list_to_order+0x9f6/0x1560
>>> deferred_split_scan+0xac5/0x12a0
>>> shrinker_debugfs_scan_write+0x376/0x470
>>> full_proxy_write+0x15c/0x220
>>> vfs_write+0x2fc/0xcb0
>>> ksys_write+0x146/0x250
>>> do_syscall_64+0x6a/0x120
>>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> The bug is found by syzkaller on an internal kernel, then confirmed on
>>> upstream.
>>>
>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common 
>>> path")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Acked-by: Hugh Dickins <hughd@google.com>
>>> Acked-by: Zi Yan <ziy@nvidia.com>
>>> Link: https://lore.kernel.org/all/20250414072737.1698513-1- 
>>> gavinguo@igalia.com/
>>> ---
>>> V1 -> V2: Add explanation from Hugh and correct the wording from page
>>> fault to invalid address access.
>>>
>>>   mm/huge_memory.c | 18 ++++++++++++++----
>>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>>
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> 
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2a47682d1ab7..0cb9547dcff2 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct 
>>> vm_area_struct *vma, pmd_t *pmd,
>>>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned 
>>> long address,
>>>                  pmd_t *pmd, bool freeze, struct folio *folio)
>>>   {
>>> +    bool pmd_migration = is_pmd_migration_entry(*pmd);
>>> +
>>>       VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>>>       VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>>>       VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>>> @@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct 
>>> vm_area_struct *vma, unsigned long address,
>>>        * require a folio to check the PMD against. Otherwise, there
>>>        * is a risk of replacing the wrong folio.
>>>        */
>>> -    if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>>> -        is_pmd_migration_entry(*pmd)) {
>>> -        if (folio && folio != pmd_folio(*pmd))
>>> -            return;
>>> +    if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
>>> +        if (folio) {
>>> +            /*
>>> +             * Do not apply pmd_folio() to a migration entry; and
>>> +             * folio lock guarantees that it must be of the wrong
>>> +             * folio anyway.
>>> +             */
>>> +            if (pmd_migration)
>>> +                return;
>>> +            if (folio != pmd_folio(*pmd))
>>> +                return;
>>
>> Nit: just re-reading, I would have simply done
>>
>> if (pmd_migration || folio != pmd_folio(*pmd)
>>      return;
>>
>> Anyway, this will hopefully get cleaned up soon either way, so I don't 
>> particularly mind. :)
>>
> 
> If v3 is needed to fix Zi's comments (commit log improvement), it can be 
> improved
> slightly based on David's suggestion, to avoid another nested if 
> statement. Otherwise,
> it's fine since it needs to be cleaned up soon.
> 
>      /*
>       * Do not apply pmd_folio() to a migration entry, and folio lock
>       * guarantees that it must be of the wrong folio anyway.
>       */
>      if (folio && (pmd_migration || folio != pmd_filio(*pmd))
>          return;
> 
> Thanks,
> Gavin
> 
> 

Gavin, thank you for the review as well. I submitted v3 including your 
suggestion with David's indentation idea and Zi's commit log fix.

