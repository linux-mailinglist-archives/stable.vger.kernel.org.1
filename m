Return-Path: <stable+bounces-154735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7115BADFCEE
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 07:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF323B5B69
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 05:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A782417DE;
	Thu, 19 Jun 2025 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PZiAzfrI"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866824167E
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 05:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750310794; cv=none; b=WnInlrVG/VlA+yModg0Hdl4LoMXnCBgm9w80c8EHmJ+KQj7ZF/4D8gASq5sFeGWovYPVnY1QSCBUNjcpSlmOJ07f7iVf3wo0bZoJtB3MSXO3v3hxQ2tNigJdHXIKC+yl8AKCZbPcUz5S8MF/MgV7HCQkM8aCb8L2BO3upIv8RhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750310794; c=relaxed/simple;
	bh=0BLwI2N7nJP8Ze1RF35MGrsTxGWtAubop0nYM/fE2kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0rkAUtwv24hiHpUXMka/9brA4DlIy+PBZsKcx2wAgZ0wZp8KrFxbb+Mdd8qjMFgEd6uKQ0LYsR1hu1WhrfeEoda+61fRwCcNlruBq7yyhrGeR2WtXDSzwa7mZ0DRIZidLfs39ZMsWEAi7zgw1tuXyOZyzrhl8H2ksUx5MI4VRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PZiAzfrI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RlZFLvXph5bwxM9eWI8WxpzsD7skURZfWfh6Pz0HV9g=; b=PZiAzfrIU7U47Jkp87hoikP54k
	2qub9G9RKRRyun2YoHeg3b4uCugE2nkhJVygrLy0nkneUSGGlm3xclKTMsR4mACO4wUw2m/8rjWBg
	1HytwPrifHYdTHYqWQkGed6f97CgtBgtxAs9Ia7KG+9Wj2emx4xf/be1RhhdBE3bao6uTodht4LSJ
	KDZ17a+pxMz0YGok3VAobMM9q2qrNxm8JSSqVnToxUaUgE56r1/hdCIh/858rp+7hvQ/su3FpqSw+
	fUYkXRa9iRdAoAqxZfnMrijpZXLzJgj2llV28YXMrq2BprAEmQGnzTNEkoZjfYY8fnQVFk6rinqAk
	+7w3/UuA==;
Received: from 106-64-161-0.adsl.fetnet.net ([106.64.161.0] helo=[192.168.238.43])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uS7mp-005OEO-3K; Thu, 19 Jun 2025 07:26:07 +0200
Message-ID: <c6eed86d-9a79-4845-8289-e9b24c46b88a@igalia.com>
Date: Thu, 19 Jun 2025 13:25:59 +0800
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
Content-Language: en-US
From: Gavin Guo <gavinguo@igalia.com>
In-Reply-To: <f903c761-8399-04f3-0f32-475b365177fb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/25 11:30, Hugh Dickins wrote:
> On Mon, 16 Jun 2025, Gavin Guo wrote:
> 
>> [ Upstream commit be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7 ]
>>
>> When migrating a THP, concurrent access to the PMD migration entry during
>> a deferred split scan can lead to an invalid address access, as
>> illustrated below.  To prevent this invalid access, it is necessary to
>> check the PMD migration entry and return early.  In this context, there is
>> no need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
>> equality of the target folio.  Since the PMD migration entry is locked, it
>> cannot be served as the target.
>>
>> Mailing list discussion and explanation from Hugh Dickins: "An anon_vma
>> lookup points to a location which may contain the folio of interest, but
>> might instead contain another folio: and weeding out those other folios is
>> precisely what the "folio != pmd_folio((*pmd)" check (and the "risk of
>> replacing the wrong folio" comment a few lines above it) is for."
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
>> Link: https://lkml.kernel.org/r/20250421113536.3682201-1-gavinguo@igalia.com
>> Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
>> Link: https://lore.kernel.org/all/20250418085802.2973519-1-gavinguo@igalia.com/
>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Hugh Dickins <hughd@google.com>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Cc: Florent Revest <revest@google.com>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> [gavin: backport the migration checking logic to __split_huge_pmd]
>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>> ---
>>   mm/huge_memory.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 9139da4baa39..bcefc17954d6 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2161,7 +2161,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>   	VM_BUG_ON(freeze && !page);
>>   	if (page) {
>>   		VM_WARN_ON_ONCE(!PageLocked(page));
>> -		if (page != pmd_page(*pmd))
>> +		if (is_pmd_migration_entry(*pmd) || page != pmd_page(*pmd))
>>   			goto out;
>>   	}
>>   
>> @@ -2196,7 +2196,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>   		}
>>   		if (PageMlocked(page))
>>   			clear_page_mlock(page);
>> -	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
>> +	} else if (!pmd_devmap(*pmd))
>>   		goto out;
> 
> I'm sorry, Gavin, but this 5.15 and the 5.10 and 5.4 backports look wrong
> to me, because here you drop the is_pmd_migration_entry(*pmd) condition,
> but if !page then that has not been checked earlier (this check here is
> specifically allowing a pmd migration entry to proceed to the split).
> 
> Hugh

Hi Hugh,

Thank you again for the review.

Regarding the 5.4/5.10/5.15. How do you think about the following changes?

@@ -2327,6 +2327,8 @@ void __split_huge_pmd(struct vm_area_struct *vma, 
pmd_t *pmd,
         mmu_notifier_invalidate_range_start(&range);
         ptl = pmd_lock(vma->vm_mm, pmd);

+       if (is_pmd_migration_entry(*pmd))
+               goto out;
         /*
          * If caller asks to setup a migration entries, we need a page 
to check
          * pmd against. Otherwise we can end up replacing wrong page.
@@ -2369,7 +2371,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, 
pmd_t *pmd,
                 }
                 if (PageMlocked(page))
                         clear_page_mlock(page);
-       } else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
+       } else if (!pmd_devmap(*pmd) )
                 goto out;
         __split_huge_pmd_locked(vma, pmd, range.start, freeze);
  out:

There is still an access, page = pmd_page(*pmd), inside the if(!page). 
I'm not sure if pmd could be a migration entry when the page is NULL. To 
avoid this as well, maybe just goto out directly in the beginning?

> 
>>   	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
>>   out:
>>
>> base-commit: 1c700860e8bc079c5c71d73c55e51865d273943c
>> -- 
>> 2.43.0


