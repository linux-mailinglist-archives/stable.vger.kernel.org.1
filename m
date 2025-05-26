Return-Path: <stable+bounces-146367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8569AC3FF7
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 14:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CAF1899ECC
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6051820B7FD;
	Mon, 26 May 2025 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XU7TKfiF"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A2202F67;
	Mon, 26 May 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748264325; cv=none; b=aCFEWv696YLIgMICyB4UM7RPd7JHe5e86zIAFNyzdC+WjGDWPy3kWCtqV1/LEGxkKK3fnQic5kEGTIwr4RqcStFpocLf6dUH8CffTFDetUmZTtHCjKanngkeLCYMhQXkHpx/m+uGj+SqmE/dP67k9kVh/5K5pPDQtrepSxaI8bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748264325; c=relaxed/simple;
	bh=FY0A/TjeKRfa3jafZucOEnoK+zBI13FR9Zk5vBbfQ6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovPoIbjtJg0YlYyXJwlbj2tYY9MuNsZ/kTnROKdLVNj6g4pbkZIspAf2o6YA/9/RoTpsEQNcHJRukXzfh8Ihj1Rzpl12GNSOUPcpKEzR5IULjXDw/ArYMLGnqdCk3KE1TvNlGW9dhGmilctdFGAcmg+8nsTTPzW5G/r+LO1k2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=XU7TKfiF; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=RLHE9Le6NF75ZsPlx3fNwcmUymScAZDzdvtqbAL6Mfs=;
	b=XU7TKfiFiuL1fGPhY6ABmQ6j+7wDr56dmQAeGwYNvHSP8vqxxNDluffM5TcIDg
	el+lujO2r+3L0HCuO1nOxifO/XCwKQkyh1RVGL/ZqCXQ00xrUyvVzTgYmaB6Lzl1
	NIkl4MKq2aNvp1eOH7QXAwmc7HeX6UppGTzsnSPpy59PU=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3H+RWZTRoPeG8Ag--.41321S2;
	Mon, 26 May 2025 20:57:59 +0800 (CST)
Message-ID: <07b7d4fd-c600-4de1-aea4-037e148da79b@126.com>
Date: Mon, 26 May 2025 20:57:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <d405ba61-0002-4663-8ab7-ab728049d8a3@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <d405ba61-0002-4663-8ab7-ab728049d8a3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H+RWZTRoPeG8Ag--.41321S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF43Jw15WryxGFWxWr18Grg_yoWrCry7pr
	yUGFs8KrWkJryDAr4xJr15Jr1qkrWqvF48XFWxKrnrAFnxJw1DGr1qqr1jqa1rArZ7JF4x
	tF4vqa1vvF1UGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjoGQUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiigJZG2g0ZJcRGgAAsu



在 2025/5/26 20:41, David Hildenbrand 写道:
> On 22.05.25 05:22, yangge1116@126.com wrote:
>> From: Ge Yang <yangge1116@126.com>
>>
>> A kernel crash was observed when replacing free hugetlb folios:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000028
>> PGD 0 P4D 0
>> Oops: Oops: 0000 [#1] SMP NOPTI
>> CPU: 28 UID: 0 PID: 29639 Comm: test_cma.sh Tainted 6.15.0-rc6-zp #41 
>> PREEMPT(voluntary)
>> RIP: 0010:alloc_and_dissolve_hugetlb_folio+0x1d/0x1f0
>> RSP: 0018:ffffc9000b30fa90 EFLAGS: 00010286
>> RAX: 0000000000000000 RBX: 0000000000342cca RCX: ffffea0043000000
>> RDX: ffffc9000b30fb08 RSI: ffffea0043000000 RDI: 0000000000000000
>> RBP: ffffc9000b30fb20 R08: 0000000000001000 R09: 0000000000000000
>> R10: ffff88886f92eb00 R11: 0000000000000000 R12: ffffea0043000000
>> R13: 0000000000000000 R14: 00000000010c0200 R15: 0000000000000004
>> FS:  00007fcda5f14740(0000) GS:ffff8888ec1d8000(0000) 
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000028 CR3: 0000000391402000 CR4: 0000000000350ef0
>> Call Trace:
>> <TASK>
>>   replace_free_hugepage_folios+0xb6/0x100
>>   alloc_contig_range_noprof+0x18a/0x590
>>   ? srso_return_thunk+0x5/0x5f
>>   ? down_read+0x12/0xa0
>>   ? srso_return_thunk+0x5/0x5f
>>   cma_range_alloc.constprop.0+0x131/0x290
>>   __cma_alloc+0xcf/0x2c0
>>   cma_alloc_write+0x43/0xb0
>>   simple_attr_write_xsigned.constprop.0.isra.0+0xb2/0x110
>>   debugfs_attr_write+0x46/0x70
>>   full_proxy_write+0x62/0xa0
>>   vfs_write+0xf8/0x420
>>   ? srso_return_thunk+0x5/0x5f
>>   ? filp_flush+0x86/0xa0
>>   ? srso_return_thunk+0x5/0x5f
>>   ? filp_close+0x1f/0x30
>>   ? srso_return_thunk+0x5/0x5f
>>   ? do_dup2+0xaf/0x160
>>   ? srso_return_thunk+0x5/0x5f
>>   ksys_write+0x65/0xe0
>>   do_syscall_64+0x64/0x170
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> There is a potential race between __update_and_free_hugetlb_folio()
>> and replace_free_hugepage_folios():
>>
>> CPU1                              CPU2
>> __update_and_free_hugetlb_folio   replace_free_hugepage_folios
>>                                      folio_test_hugetlb(folio)
>>                                      -- It's still hugetlb folio.
>>
>>    __folio_clear_hugetlb(folio)
>>    hugetlb_free_folio(folio)
>>                                      h = folio_hstate(folio)
>>                                      -- Here, h is NULL pointer
>>
>> When the above race condition occurs, folio_hstate(folio) returns
>> NULL, and subsequent access to this NULL pointer will cause the
>> system to crash. To resolve this issue, execute folio_hstate(folio)
>> under the protection of the hugetlb_lock lock, ensuring that
>> folio_hstate(folio) does not return NULL.
>>
>> Fixes: 04f13d241b8b ("mm: replace free hugepage folios after migration")
>> Signed-off-by: Ge Yang <yangge1116@126.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   mm/hugetlb.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 3d3ca6b..6c2e007 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2924,12 +2924,20 @@ int replace_free_hugepage_folios(unsigned long 
>> start_pfn, unsigned long end_pfn)
>>       while (start_pfn < end_pfn) {
>>           folio = pfn_folio(start_pfn);
>> +
>> +        /*
>> +         * The folio might have been dissolved from under our feet, 
>> so make sure
>> +         * to carefully check the state under the lock.
>> +         */
>> +        spin_lock_irq(&hugetlb_lock);
>>           if (folio_test_hugetlb(folio)) {
>>               h = folio_hstate(folio);
>>           } else {
>> +            spin_unlock_irq(&hugetlb_lock);
>>               start_pfn++;
>>               continue;
>>           }
>> +        spin_unlock_irq(&hugetlb_lock);
> 
> As mentioned elsewhere, this will grab the hugetlb_lock for each and 
> every pfn in the range if there are no hugetlb folios (common case).
> 
> That should certainly *not* be done.
> 
> In case we see !folio_test_hugetlb(), we should just move on.
> 

The main reason for acquiring the hugetlb_lock here is to obtain a valid 
hstate, as the alloc_and_dissolve_hugetlb_folio() function requires 
hstate as a parameter. This approach is indeed not performance-friendly. 
However, in the patch available at 
https://lore.kernel.org/lkml/1747987559-23082-1-git-send-email-yangge1116@126.com/, 
all these operations will be removed.


