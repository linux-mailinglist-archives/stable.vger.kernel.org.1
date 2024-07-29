Return-Path: <stable+bounces-62342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510CC93EABF
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 03:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7355A1C21457
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B522BD04;
	Mon, 29 Jul 2024 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SvjsPqgu"
X-Original-To: stable@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039333716D;
	Mon, 29 Jul 2024 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217752; cv=none; b=EhkKEPNiHYdlk3eh8TvoraXD78YMT9BiYxVdyS0ng5wuptoIksIhAUxTyc+Zhbcwjww3zaZmeToqpzSOuafcQpDMHL+5aWYdViiW2ciWGaWcL4ioiO124/v53mEasBgzSgCzhAhW0j1Vi9TVBYHXv7nLPuVSRz99U15Az3P59hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217752; c=relaxed/simple;
	bh=tsctK+uNaUOswom06wy1nzNb8fNcI0erEHBQKEH0YG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTrT+SqcbKwL2kgi0mKVLPlG13BDBIPZCj49+RtEQGZ+XCajjK2To4334AfFrL4BwwlhEi7S2eDMwCQzKK8Rj2b4JGBWXmYYgPywGu7Me+q2TYd1ip262vLJeNenJm4P3A3ebpYeMLPmZZqOj4nLUm5uDtUTu7jpnxl/Ioy0nX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SvjsPqgu; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722217741; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v03Ob2sLScSBvjP5hXFQSN21DJsV2m0NROeoya7TkgA=;
	b=SvjsPqguN31KjKtHLP4Lot37O5FDfupQiVhkqaxy0O6pgv9Xx/nAuDAgCd3BC7TqsX+wGMVjxZq5u7vbp2sTr0mWXontW7PRrRc7mAx5aCr6va+zMzkHwM+Cw59iZe1m/now5802b6+WogYwQCePl3rJx3AFhTPk5DsdEdJkpYg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0WBSgas8_1722217739;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBSgas8_1722217739)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 09:49:00 +0800
Message-ID: <2a9fa612-875e-4210-9cd5-a984e9e5cbf7@linux.alibaba.com>
Date: Mon, 29 Jul 2024 09:48:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-3-david@redhat.com>
 <0067dfe6-b9a6-4e98-9eef-7219299bfe58@linux.alibaba.com>
 <c16a731f-1029-4ede-bbea-af2218c566d1@redhat.com>
 <4439d559-5acf-4688-a1ad-7626bf027027@linux.alibaba.com>
 <1bbfcc7f-f222-45a5-ac44-c5a1381c596d@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1bbfcc7f-f222-45a5-ac44-c5a1381c596d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/26 19:40, David Hildenbrand wrote:
> On 26.07.24 11:38, Baolin Wang wrote:
>>
>>
>> On 2024/7/26 16:04, David Hildenbrand wrote:
>>> On 26.07.24 04:33, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/7/26 02:39, David Hildenbrand wrote:
>>>>> We recently made GUP's common page table walking code to also walk
>>>>> hugetlb VMAs without most hugetlb special-casing, preparing for the
>>>>> future of having less hugetlb-specific page table walking code in the
>>>>> codebase. Turns out that we missed one page table locking detail: page
>>>>> table locking for hugetlb folios that are not mapped using a single
>>>>> PMD/PUD.
>>>>>
>>>>> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
>>>>> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it 
>>>>> walks the
>>>>> page tables, will perform a pte_offset_map_lock() to grab the PTE 
>>>>> table
>>>>> lock.
>>>>>
>>>>> However, hugetlb that concurrently modifies these page tables would
>>>>> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
>>>>> locks would differ. Something similar can happen right now with 
>>>>> hugetlb
>>>>> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
>>>>>
>>>>> Let's make huge_pte_lockptr() effectively uses the same PT locks as 
>>>>> any
>>>>> core-mm page table walker would.
>>>>
>>>> Thanks for raising the issue again. I remember fixing this issue 2 
>>>> years
>>>> ago in commit fac35ba763ed ("mm/hugetlb: fix races when looking up a
>>>> CONT-PTE/PMD size hugetlb page"), but it seems to be broken again.
>>>>
>>>
>>> Ah, right! We fixed it by rerouting to hugetlb code that we then 
>>> removed :D
>>>
>>> Did we have a reproducer back then that would make my live easier?
>>
>> I don't have any reproducers right now. I remember I added some ugly
>> hack code (adding delay() etc.) in kernel to analyze this issue, and not
>> easy to reproduce. :(
> 
> Hah!
> 
> I tried with 32MB without luck -- migration simply takes too long. 64KB
> did the trick within seconds!
> 
> 
> On a VM with 2 vNUMA nodes, after reserving a bunch of 64KiB hugetlb pages:
> 
> # numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
> node 0 size: 64439 MB
> node 0 free: 64097 MB
> node 1 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
> node 1 size: 64205 MB
> node 1 free: 63809 MB
> node distances:
> node   0   1
>    0:  10  20
>    1:  20  10
> # echo 100  > 
> /sys/kernel/mm/hugepages/hugepages-64kB/nr_hugepagespages-64kB/nr_hugepagesepages-64kB/nr_hugepages
> # gcc reproducer.c -o reproducer -O3 -lnuma -lpthread
> # ./reproducer
> [ 3105.936100] ------------[ cut here ]------------
> [ 3105.939323] WARNING: CPU: 31 PID: 2732 at mm/gup.c:142 
> try_grab_folio+0x11c/0x188
> [ 3105.944634] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill 
> ip_set nf_tables qrtr sunrpc vfat fat ext4 mbcache jbd2 virtio_net 
> net_failover failover virtio_balloon dimlib loop dm_multipath nfnetlink 
> zram xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_blk 
> virtio_console virtio_mmio dm_mirror dm_region_hash dm_log dm_mod fuse
> [ 3105.974841] CPU: 31 PID: 2732 Comm: reproducer Not tainted 
> 6.10.0-64.eln141.aarch64 #1
> [ 3105.980406] Hardware name: QEMU KVM Virtual Machine, BIOS 
> edk2-20240524-4.fc40 05/24/2024
> [ 3105.986185] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [ 3105.991108] pc : try_grab_folio+0x11c/0x188
> [ 3105.994013] lr : follow_page_pte+0xd8/0x430
> [ 3105.996986] sp : ffff80008eafb8f0
> [ 3105.999346] x29: ffff80008eafb900 x28: ffffffe8d481f380 x27: 
> 00f80001207cff43
> [ 3106.004414] x26: 0000000000000001 x25: 0000000000000000 x24: 
> ffff80008eafba48
> [ 3106.009520] x23: 0000ffff9372f000 x22: ffff7a54459e2000 x21: 
> ffff7a546c1aa978
> [ 3106.014529] x20: ffffffe8d481f3c0 x19: 0000000000610041 x18: 
> 0000000000000001
> [ 3106.019506] x17: 0000000000000001 x16: ffffffffffffffff x15: 
> 0000000000000000
> [ 3106.024494] x14: ffffb85477fdfe08 x13: 0000ffff9372ffff x12: 
> 0000000000000000
> [ 3106.029469] x11: 1fffef4a88a96be1 x10: ffff7a54454b5f0c x9 : 
> ffffb854771b12f0
> [ 3106.034324] x8 : 0008000000000000 x7 : ffff7a546c1aa980 x6 : 
> 0008000000000080
> [ 3106.038902] x5 : 00000000001207cf x4 : 0000ffff9372f000 x3 : 
> ffffffe8d481f000
> [ 3106.043420] x2 : 0000000000610041 x1 : 0000000000000001 x0 : 
> 0000000000000000
> [ 3106.047957] Call trace:
> [ 3106.049522]  try_grab_folio+0x11c/0x188
> [ 3106.051996]  follow_pmd_mask.constprop.0.isra.0+0x150/0x2e0
> [ 3106.055527]  follow_page_mask+0x1a0/0x2b8
> [ 3106.058118]  __get_user_pages+0xf0/0x348
> [ 3106.060647]  faultin_page_range+0xb0/0x360
> [ 3106.063651]  do_madvise+0x340/0x598
> ...
> 
> 
> 
> # cat reproducer.c
> #include <stdio.h>
> #include <sys/mman.h>
> #include <linux/mman.h>
> #include <errno.h>
> #include <string.h>
> #include <numaif.h>
> #include <pthread.h>
> 
> #define SIZE_64KB (64 * 1024ul)
> 
> static void *thread_fn(void *arg)
> {
>          char *mem = arg;
> 
>          /* Let GUP go crazy on the page without grabbing a reference. */
>          while (1) {
>                  if (madvise(mem, SIZE_64KB, MADV_POPULATE_WRITE)) {
>                          fprintf(stderr, "madvise() failed: %d\n", errno);
>                  }
>          }
> }
> 
> int main(void)
> {
>          pthread_t thread;
>          unsigned int i;
>          char *mem;
> 
>          mem = mmap(0, SIZE_64KB, PROT_READ|PROT_WRITE,
>                     MAP_ANON|MAP_PRIVATE|MAP_HUGETLB|MAP_HUGE_64KB, -1, 0);
>          if (mem == MAP_FAILED) {
>                  fprintf(stderr, "mmap() failed: %d\n", errno);
>                  return -1;
>          }
> 
>          memset(mem, 0, SIZE_64KB);
> 
>          pthread_create(&thread, NULL, thread_fn, mem);
> 
>          /* Migrate it back and forth between two nodes. */
>          for (i = 0; ; i++) {
>                  void *pages[1] = { mem, };
>                  int nodes[1] = { i % 2, };
>                  int status[1] = { 0 };
> 
>                  if (move_pages(0, 1, pages, nodes, status, 
> MPOL_MF_MOVE_ALL))
>                          fprintf(stderr, "move_pages failed: %d\n", errno);
>                  if (status[0] != nodes[0])
>                          printf("migration failed\n");
>          }
>          return 0;
> }

Great! Thanks for creating the reproducer (I will also try it if I find 
some time).

