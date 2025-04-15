Return-Path: <stable+bounces-132714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1040A8997E
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 12:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37A317D328
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0601F3BBC;
	Tue, 15 Apr 2025 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="n0lbMLyC"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2345A79B;
	Tue, 15 Apr 2025 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711666; cv=none; b=qzFob0SA8W0Of6x2+y3lFPBeapBRntGDtRKbpTnJLgCuNSC+ib/XANqc9ecqKSfIjq/aRIaVqrqqn1GtCDnYsed732HfOOID0KPsjzSOfJJiYwXU1BCgXS1CtT6krrA+2nTpuUkueb91rTvS5kvAMBSWYw76+0iRDWZnn/nhXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711666; c=relaxed/simple;
	bh=PRa/dH9p8ZidJruhQ+47fsS/a2MLpzOjHTQByEXXWUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShHefO+roCTioS9ZmpDZxFn3xg9INKCVbq/OopcEi7Kl+2Dso6AdDxPfOvHADKeDWmTAAUOIsGMzMddpZBjML/kXTGrHI5St6+CjdrB+htsg8t83LIFl+cLsRkXojfb5IiM4K2qD/9XxJ9XNA5dUh17GUfW3AJIWc89yW3KhhSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=n0lbMLyC; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vlK0Dri62mGNQqlwhnFyUcr4Z53lx2/utirBchiSPQk=; b=n0lbMLyCyPBW5L12MKsE+9Fdau
	zeTIKDPA3rcAVYyr1VM4FvZh1LCWGdGBIeyXjl3p7RFi9O9ip7bucIQqTKZXwZqct0JwCm0RkonPU
	izOQl8Dy2rzDbx4NYaHlSIchvVPabaUy7+n3HkeIkseg5kiAFA/yB0dMJK7jHGVNDE2gvLa8rA1du
	oRCYRnalyT8b1xjP7PcYf4gXMMX8dGZPC1JrtK8qLTvknUzxXjQqltjaEdH9+Yw31Y6o/YF4cn/FJ
	fiPowjR21wyHFcWCPDIZ7HHHSJs7v8nzf6/thGntL4P9Mli6lgzfjbFtTeLpBWTtvoHZwyZLfm6Pr
	yvjzt4YQ==;
Received: from 27-53-107-160.adsl.fetnet.net ([27.53.107.160] helo=[192.168.220.43])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u4dCD-00GtGI-OH; Tue, 15 Apr 2025 12:07:14 +0200
Message-ID: <83629774-981b-44cb-a106-d549f1a43db9@igalia.com>
Date: Tue, 15 Apr 2025 18:07:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix dereferencing invalid pmd migration
 entry
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
 linmiaohe@huawei.com, hughd@google.com, revest@google.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
References: <20250414072737.1698513-1-gavinguo@igalia.com>
 <A049A15F-1287-4943-8EE4-833CEEC4F988@nvidia.com>
Content-Language: en-US
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <A049A15F-1287-4943-8EE4-833CEEC4F988@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Zi-Yan,

Thank you for the comment!

On 4/15/25 00:50, Zi Yan wrote:
> On 14 Apr 2025, at 3:27, Gavin Guo wrote:
> 
>> When migrating a THP, concurrent access to the PMD migration entry
>> during a deferred split scan can lead to a page fault, as illustrated
> 
> It is an access violation, right? Because pmd_folio(*pmd_migration_entry)
> does not return a folio address. Page fault made this sounded like not
> a big issue.

Right, pmd_folio(*pmd_migration_entry) is defined with the following
macro:

#define pmd_folio(pmd) page_folio(pmd_page(pmd))

page_folio will eventually access compound_head:

static __always_inline unsigned long _compound_head(const struct page *page)
{
         unsigned long head = READ_ONCE(page->compound_head);
         ...
}

However, given the invalid access address starting with 0xffffea
(ffffea60001db008) which is the base address of the struct page. It
indicates that the page address calculated from pmd_page is invalid
during the THP migration where the pmd migration entry has been set up
in set_pmd_migration_entry, for example:

do_mbind
   migrate_pages
     migrate_pages_sync
       migration_pages_batch
         migrate_folio_unmap
           try_to_migrate
             try_to_migrate_one
               rmap_walk_anon
                 set_pmd_migration_entry
                   set_pmd_at

> 
>> below. To prevent this page fault, it is necessary to check the PMD
>> migration entry and return early. In this context, there is no need to
>> use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the equality
>> of the target folio. Since the PMD migration entry is locked, it cannot
>> be served as the target.
> 
> You mean split_huge_pmd_address() locks the PMD page table, so that
> page migration cannot proceed, or the THP is locked by migration,
> so that it cannot be split? The sentence is a little confusing to me.

During the THP migration, the THP folio is locked (folio_trylock). When
this THP folio is identified as partially-mapped and inserted into the
deferred split queue, the system then scans the queue and attempts to
split the folio when memory is under pressure or through the sysfs debug
interface. Since the migrated folio remained locked, during the
deferred_split_scan, the folio_trylock fails with the migrated folio. As
a result, the folio passed to split_huge_pmd_locked ends up being
unequal to the folio referenced by the pmd migration entry, indicating
the pmd migration folio cannot be the target for splitting and needs to
return.

An alternative approach is similar to the following:

+       swp_entry_t entry;
+       struct folio *dst;
         if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
             is_pmd_migration_entry(*pmd)) {
-               if (folio && folio != pmd_folio(*pmd))
-                       return;
+               if (folio) {
+                       if (is_pmd_migration_entry(*pmd)) {
+                               entry = pmd_to_swp_entry(*pmd);
+                               dst = pfn_swap_entry_folio(entry);
+                       } else
+                               dst = pmd_folio(*pmd);
+
+                       if (folio != dst)
+                               return
+               }
                 __split_huge_pmd_locked(vma, pmd, address, freeze);

However, this extra effort to translate the pmd migration folio is
unnecessary. Any ideas of exceptions?

> 
>>
>> BUG: unable to handle page fault for address: ffffea60001db008
>> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
>> Call Trace:
>> <TASK>
>> try_to_migrate_one+0x28c/0x3730
>> rmap_walk_anon+0x4f6/0x770
>> unmap_folio+0x196/0x1f0
>> split_huge_page_to_list_to_order+0x9f6/0x1560
>> deferred_split_scan+0xac5/0x12a0
>> shrinker_debugfs_scan_write+0x376/0x470
>> full_proxy_write+0x15c/0x220
>> vfs_write+0x2fc/0xcb0
>> ksys_write+0x146/0x250
>> do_syscall_64+0x6a/0x120
>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> The bug is found by syzkaller on an internal kernel, then confirmed on
>> upstream.
>>
>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>> ---
>>   mm/huge_memory.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2a47682d1ab7..0cb9547dcff2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>>   			   pmd_t *pmd, bool freeze, struct folio *folio)
>>   {
>> +	bool pmd_migration = is_pmd_migration_entry(*pmd);
>> +
>>   	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>>   	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>>   	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>> @@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>>   	 * require a folio to check the PMD against. Otherwise, there
>>   	 * is a risk of replacing the wrong folio.
>>   	 */
>> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>> -	    is_pmd_migration_entry(*pmd)) {
>> -		if (folio && folio != pmd_folio(*pmd))
>> -			return;
>> +	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
>> +		if (folio) {
>> +			/*
>> +			 * Do not apply pmd_folio() to a migration entry; and
>> +			 * folio lock guarantees that it must be of the wrong
>> +			 * folio anyway.
> 
> Why does the folio lock imply it is a wrong folio?

As explained above.

> 
>> +			 */
>> +			if (pmd_migration)
>> +				return;
>> +			if (folio != pmd_folio(*pmd))
>> +				return;
>> +		}
> 
> Why not just
> 
> if (folio && pmd_migration)
> 	return;
> 
> if (pmd_trans_huge() …) {
> 	…
> }
> ?

Do you mean to implement as follows?

if (folio && pmd_migration)
         return;

if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
         if (folio && folio != pmd_folio(*pmd))
                 return;
}

if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration)
         __split_huge_pmd_locked(vma, pmd, address, freeze);

To match the current upstream logic, when folio is null, no matter the
condition is either pmd_trans_huge, pmd_devmap, or pmd_migration, the
__split_huge_pmd_locked must be always executed. Given that, the
__split_huge_pmd_locked cannot be put inside if condition for trans_huge
and devmap. Likewise, the __split_huge_pmd_locked cannot be called
directly without wrapping the if condition checks. What happens if this
is not a pmd entry? This will be invoked unconditionally.

The original implementation consolidates all the logic into one large if
statement with nested if condition check. However, it's more robust and
clear. The second one simplifies the structure and can rule out the
pmd_migration earlier and doesn't have the big if condition. However,
it's trickier and needs extra care and maintenance.

> 
> Thanks.
> 
> Best Regards,
> Yan, Zi

Thanks!

