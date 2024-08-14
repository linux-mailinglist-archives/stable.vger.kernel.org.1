Return-Path: <stable+bounces-67682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBDA952104
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8509B1C21087
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484CF1BBBCD;
	Wed, 14 Aug 2024 17:25:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5B111A1;
	Wed, 14 Aug 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656307; cv=none; b=FbfYM1Xpqn67XAPGcVJZ1uoE2WXy1TgBf1RHNK6KSVfOvEnqi2AyBx69i0kXt5GcISXrvOl54cg0GvLkT5L3fMSvm6YNCJiMb5whMAHcf0HHcKp06WFJfe9k/mT5tNAPxbCv3jL/YB7hNNkPKsHjOu2JdY79Cay1hGZ2+3MBZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656307; c=relaxed/simple;
	bh=Z3uLl1tvie8RHOYfT6GE5r9VjtWSZ+RqULeYciisB4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGmIOgAlhrcQsf9qFP+DW3UnGps6ERqXIkb1jCjgD68NWcEeSNFRdhLLtVIyGc0jbpam0rcsljnaTP09CqUBYiVvPAzdAp0KAAKwO1bYUfsxZx5jRFM3tniKZsZeepMNdJUVyr6wv9UqZ6DmYuHD95/Y2UgMblCjmt0ewGb9X8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WkZrb1fnlz9sRy;
	Wed, 14 Aug 2024 19:25:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jxUP_fGYFpiT; Wed, 14 Aug 2024 19:25:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WkZrb0QPfz9sRs;
	Wed, 14 Aug 2024 19:25:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F20568B775;
	Wed, 14 Aug 2024 19:25:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id TDpg8Vpdl9oq; Wed, 14 Aug 2024 19:25:02 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4CC9B8B764;
	Wed, 14 Aug 2024 19:25:02 +0200 (CEST)
Message-ID: <a5127803-238a-4bcb-b518-718c85e63a23@csgroup.eu>
Date: Wed, 14 Aug 2024 19:25:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 James Houghton <jthoughton@google.com>, stable@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Muchun Song <muchun.song@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20240731122103.382509-1-david@redhat.com> <ZqpQILQ7A_7qTvtq@x1n>
 <2b0131cf-d066-44ba-96d9-a611448cbaf9@redhat.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <2b0131cf-d066-44ba-96d9-a611448cbaf9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 31/07/2024 à 18:33, David Hildenbrand a écrit :
> On 31.07.24 16:54, Peter Xu wrote:
>> On Wed, Jul 31, 2024 at 02:21:03PM +0200, David Hildenbrand wrote:
>>> We recently made GUP's common page table walking code to also walk 
>>> hugetlb
>>> VMAs without most hugetlb special-casing, preparing for the future of
>>> having less hugetlb-specific page table walking code in the codebase.
>>> Turns out that we missed one page table locking detail: page table 
>>> locking
>>> for hugetlb folios that are not mapped using a single PMD/PUD.
>>>
>>> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
>>> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
>>> page tables, will perform a pte_offset_map_lock() to grab the PTE table
>>> lock.
>>>
>>> However, hugetlb that concurrently modifies these page tables would
>>> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
>>> locks would differ. Something similar can happen right now with hugetlb
>>> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
>>>
>>> This issue can be reproduced [1], for example triggering:
>>>
>>> [ 3105.936100] ------------[ cut here ]------------
>>> [ 3105.939323] WARNING: CPU: 31 PID: 2732 at mm/gup.c:142 
>>> try_grab_folio+0x11c/0x188
>>> [ 3105.944634] Modules linked in: [...]
>>> [ 3105.974841] CPU: 31 PID: 2732 Comm: reproducer Not tainted 
>>> 6.10.0-64.eln141.aarch64 #1
>>> [ 3105.980406] Hardware name: QEMU KVM Virtual Machine, BIOS 
>>> edk2-20240524-4.fc40 05/24/2024
>>> [ 3105.986185] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
>>> BTYPE=--)
>>> [ 3105.991108] pc : try_grab_folio+0x11c/0x188
>>> [ 3105.994013] lr : follow_page_pte+0xd8/0x430
>>> [ 3105.996986] sp : ffff80008eafb8f0
>>> [ 3105.999346] x29: ffff80008eafb900 x28: ffffffe8d481f380 x27: 
>>> 00f80001207cff43
>>> [ 3106.004414] x26: 0000000000000001 x25: 0000000000000000 x24: 
>>> ffff80008eafba48
>>> [ 3106.009520] x23: 0000ffff9372f000 x22: ffff7a54459e2000 x21: 
>>> ffff7a546c1aa978
>>> [ 3106.014529] x20: ffffffe8d481f3c0 x19: 0000000000610041 x18: 
>>> 0000000000000001
>>> [ 3106.019506] x17: 0000000000000001 x16: ffffffffffffffff x15: 
>>> 0000000000000000
>>> [ 3106.024494] x14: ffffb85477fdfe08 x13: 0000ffff9372ffff x12: 
>>> 0000000000000000
>>> [ 3106.029469] x11: 1fffef4a88a96be1 x10: ffff7a54454b5f0c x9 : 
>>> ffffb854771b12f0
>>> [ 3106.034324] x8 : 0008000000000000 x7 : ffff7a546c1aa980 x6 : 
>>> 0008000000000080
>>> [ 3106.038902] x5 : 00000000001207cf x4 : 0000ffff9372f000 x3 : 
>>> ffffffe8d481f000
>>> [ 3106.043420] x2 : 0000000000610041 x1 : 0000000000000001 x0 : 
>>> 0000000000000000
>>> [ 3106.047957] Call trace:
>>> [ 3106.049522]  try_grab_folio+0x11c/0x188
>>> [ 3106.051996]  follow_pmd_mask.constprop.0.isra.0+0x150/0x2e0
>>> [ 3106.055527]  follow_page_mask+0x1a0/0x2b8
>>> [ 3106.058118]  __get_user_pages+0xf0/0x348
>>> [ 3106.060647]  faultin_page_range+0xb0/0x360
>>> [ 3106.063651]  do_madvise+0x340/0x598
>>>
>>> Let's make huge_pte_lockptr() effectively use the same PT locks as any
>>> core-mm page table walker would. Add ptep_lockptr() to obtain the PTE
>>> page table lock using a pte pointer -- unfortunately we cannot convert
>>> pte_lockptr() because virt_to_page() doesn't work with kmap'ed page
>>> tables we can have with CONFIG_HIGHPTE.
>>>
>>> Take care of PTE tables possibly spanning multiple pages, and take 
>>> care of
>>> CONFIG_PGTABLE_LEVELS complexity when e.g., PMD_SIZE == PUD_SIZE. For
>>> example, with CONFIG_PGTABLE_LEVELS == 2, core-mm would detect
>>> with hugepagesize==PMD_SIZE pmd_leaf() and use the pmd_lockptr(), which
>>> would end up just mapping to the per-MM PT lock.
>>>
>>> There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
>>> folio being mapped using two PTE page tables.  While hugetlb wants to 
>>> take
>>> the PMD table lock, core-mm would grab the PTE table lock of one of both
>>> PTE page tables.  In such corner cases, we have to make sure that both
>>> locks match, which is (fortunately!) currently guaranteed for 8xx as it
>>> does not support SMP and consequently doesn't use split PT locks.
>>>
>>> [1] 
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F1bbfcc7f-f222-45a5-ac44-c5a1381c596d%40redhat.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf91a0b3cdcab46c7bd6108dcb17e9454%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638580404425532305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=%2FQ4QFqbyThojISHACwzxCdtYbgwc4JsMIP%2Bmx4PneOk%3D&reserved=0
>>>
>>> Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic 
>>> follow_page_mask code")
>>> Reviewed-by: James Houghton <jthoughton@google.com>
>>> Cc: <stable@vger.kernel.org>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Muchun Song <muchun.song@linux.dev>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> Nitpick: I wonder whether some of the lines can be simplified if we write
>> it downwards from PUD, like,
>>
>> huge_pte_lockptr()
>> {
>>          if (size >= PUD_SIZE)
>>             return pud_lockptr(...);
>>          if (size >= PMD_SIZE)
>>             return pmd_lockptr(...);
>>          /* Sub-PMD only applies to !CONFIG_HIGHPTE, see 
>> pte_alloc_huge() */
>>          WARN_ON(IS_ENABLED(CONFIG_HIGHPTE));
>>          return ptep_lockptr(...);
>> }
> 
> Let me think about it. For PUD_SIZE == PMD_SIZE instead of like core-mm
> calling pmd_lockptr we'd call pud_lockptr().

I guess it is only when including asm-generic/pgtable-nopmd.h

Otherwise you should have more than one entry in the PMD table so 
PMD_SIZE would always be smaller than PUD_SIZE, wouldn't it ?

So maybe some simplification could be done, like having pud_lock() a nop 
in that case ?


Christophe

