Return-Path: <stable+bounces-61871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F193D27B
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 13:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC67B20E2F
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80FF17A59A;
	Fri, 26 Jul 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtaUU4XK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5D13C661
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994031; cv=none; b=R61DP3dtuH/oVWAtU8Mew1YqEbWuQca9fyvtFQFofLJxcqt5Fb+c0oH+W3HMof+0KE3tm4ct3OlWDjB42HUzXq1VgS9PfSu8MxyzJS5wS/DqwUOP/unx0wxO7sLAvs9e5nz1gvRa1Vj2GQko/as/IGng6OICaHHonsR0TUULsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994031; c=relaxed/simple;
	bh=O5MNgArh+mfOt1V96h/SJPUKxwwzNyWNAR2UAVk6SLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAVhrhlyabN3mJolvajJj9Wzi8+n/dYtElboVv9yWUHQWGqBIvWHPzC+XsTD/mRmvCIogvXeFFsYjxT3qt27FUsYuGgqMTIWddgMpOeCwNVlvqixAqSV0TlNCRL/K4h7qHOlUZ5g5WtV1zdvpmxNEL9oOc/2NnxEcaB64eBxOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtaUU4XK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721994028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z9W4fCXHZLsuKvpJAknnxn3nFMLROe+4dC/A5o70zs8=;
	b=YtaUU4XKtIKosUNOuQv7XPaKWtvSroHT3Gl+xR0+RAQR0ftqW9XuW5G0Rs/srcuBRgs03S
	VVcG51ROHUktm9xZosHJ99YqlfbEa/vqaWbWMkdyuE2+S7PbA4oFqM4oTD1hahdqtkTrFx
	TsiLR9QzpzwR+0FysAs0i+/lyL5K/QI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-hSRJ4XgwPMK74YEU0Q9_ZQ-1; Fri, 26 Jul 2024 07:40:27 -0400
X-MC-Unique: hSRJ4XgwPMK74YEU0Q9_ZQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280fb8f919so843165e9.2
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 04:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721994026; x=1722598826;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9W4fCXHZLsuKvpJAknnxn3nFMLROe+4dC/A5o70zs8=;
        b=X3ExCpn5YtOT9YUBXkutaaiNh0wIfMwTdxnCi/nr2HK6oMBf0zFbS+3/4n8uXDdRDS
         6MTCFpTBUlaXO+nr5WqU5WDZiUCfj/SHydhy7MxeCS+APtZ99O7r7CnJXxAQUFvA+Foo
         sR6QFtLzv6dJsTZpkFJWtV91Iv7APQ/EcL7mdtWZ5KEHTUGdc+GIMx794o6vQ15aion7
         zY9V0nix+xJ5oxiN71r/aMciiVa6DWVXIW8ej8xe1YGS9Osg+W5PsrpzicswgX5XCWqZ
         QVLx0ZhIpFNT8rlDwdxo3Eq7b82jYZL1vgxAFxk2nfSX6KPzvEnSjJho9lBWF5pnkV1i
         wSmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEAOkE6QZ8SO9ARedgFmWpD538Tw0OPVqStqjSeel+oAHBXaqe/6Y86AUrNMYPaI/u22Imul56xdYcuLGLo0G9cOdeOiuJ
X-Gm-Message-State: AOJu0YzMDgifBZHcxyAJCtsmExL3qm/3pAx+B6PXiaiDMpHPJi/z7i2g
	iVw+NzOgw+/0DWOWq3jnmSleH1CMHMylPLeoaB+iXfslmswyT/848jipitNsvbCFnspmaKeigUs
	kLZB868Xd23mGe47VVtiQ9CVXudwbD2oB/yQEYZRn5oYVSfr82P0Qtg==
X-Received: by 2002:a05:600c:1992:b0:426:6edf:4f41 with SMTP id 5b1f17b1804b1-42806b6ac8cmr37205585e9.8.1721994025801;
        Fri, 26 Jul 2024 04:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgl94whsKPfUXPsCnpPydAjXBqs0giDp4B8ysW5dywTehWcDefUQf5Heh/eubrQleUN7MuTA==
X-Received: by 2002:a05:600c:1992:b0:426:6edf:4f41 with SMTP id 5b1f17b1804b1-42806b6ac8cmr37205345e9.8.1721994025299;
        Fri, 26 Jul 2024 04:40:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:a600:7ca0:23b3:d48a:97c7? (p200300cbc713a6007ca023b3d48a97c7.dip0.t-ipconnect.de. [2003:cb:c713:a600:7ca0:23b3:d48a:97c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428029e32fesm89997455e9.25.2024.07.26.04.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 04:40:24 -0700 (PDT)
Message-ID: <1bbfcc7f-f222-45a5-ac44-c5a1381c596d@redhat.com>
Date: Fri, 26 Jul 2024 13:40:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-3-david@redhat.com>
 <0067dfe6-b9a6-4e98-9eef-7219299bfe58@linux.alibaba.com>
 <c16a731f-1029-4ede-bbea-af2218c566d1@redhat.com>
 <4439d559-5acf-4688-a1ad-7626bf027027@linux.alibaba.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4439d559-5acf-4688-a1ad-7626bf027027@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.07.24 11:38, Baolin Wang wrote:
> 
> 
> On 2024/7/26 16:04, David Hildenbrand wrote:
>> On 26.07.24 04:33, Baolin Wang wrote:
>>>
>>>
>>> On 2024/7/26 02:39, David Hildenbrand wrote:
>>>> We recently made GUP's common page table walking code to also walk
>>>> hugetlb VMAs without most hugetlb special-casing, preparing for the
>>>> future of having less hugetlb-specific page table walking code in the
>>>> codebase. Turns out that we missed one page table locking detail: page
>>>> table locking for hugetlb folios that are not mapped using a single
>>>> PMD/PUD.
>>>>
>>>> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
>>>> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
>>>> page tables, will perform a pte_offset_map_lock() to grab the PTE table
>>>> lock.
>>>>
>>>> However, hugetlb that concurrently modifies these page tables would
>>>> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
>>>> locks would differ. Something similar can happen right now with hugetlb
>>>> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
>>>>
>>>> Let's make huge_pte_lockptr() effectively uses the same PT locks as any
>>>> core-mm page table walker would.
>>>
>>> Thanks for raising the issue again. I remember fixing this issue 2 years
>>> ago in commit fac35ba763ed ("mm/hugetlb: fix races when looking up a
>>> CONT-PTE/PMD size hugetlb page"), but it seems to be broken again.
>>>
>>
>> Ah, right! We fixed it by rerouting to hugetlb code that we then removed :D
>>
>> Did we have a reproducer back then that would make my live easier?
> 
> I don't have any reproducers right now. I remember I added some ugly
> hack code (adding delay() etc.) in kernel to analyze this issue, and not
> easy to reproduce. :(

Hah!

I tried with 32MB without luck -- migration simply takes too long. 64KB
did the trick within seconds!


On a VM with 2 vNUMA nodes, after reserving a bunch of 64KiB hugetlb pages:

# numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
node 0 size: 64439 MB
node 0 free: 64097 MB
node 1 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
node 1 size: 64205 MB
node 1 free: 63809 MB
node distances:
node   0   1
   0:  10  20
   1:  20  10
# echo 100  > /sys/kernel/mm/hugepages/hugepages-64kB/nr_hugepagespages-64kB/nr_hugepagesepages-64kB/nr_hugepages
# gcc reproducer.c -o reproducer -O3 -lnuma -lpthread
# ./reproducer
[ 3105.936100] ------------[ cut here ]------------
[ 3105.939323] WARNING: CPU: 31 PID: 2732 at mm/gup.c:142 try_grab_folio+0x11c/0x188
[ 3105.944634] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables qrtr sunrpc vfat fat ext4 mbcache jbd2 virtio_net net_failover failover virtio_balloon dimlib loop dm_multipath nfnetlink zram xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_blk virtio_console virtio_mmio dm_mirror dm_region_hash dm_log dm_mod fuse
[ 3105.974841] CPU: 31 PID: 2732 Comm: reproducer Not tainted 6.10.0-64.eln141.aarch64 #1
[ 3105.980406] Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-4.fc40 05/24/2024
[ 3105.986185] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 3105.991108] pc : try_grab_folio+0x11c/0x188
[ 3105.994013] lr : follow_page_pte+0xd8/0x430
[ 3105.996986] sp : ffff80008eafb8f0
[ 3105.999346] x29: ffff80008eafb900 x28: ffffffe8d481f380 x27: 00f80001207cff43
[ 3106.004414] x26: 0000000000000001 x25: 0000000000000000 x24: ffff80008eafba48
[ 3106.009520] x23: 0000ffff9372f000 x22: ffff7a54459e2000 x21: ffff7a546c1aa978
[ 3106.014529] x20: ffffffe8d481f3c0 x19: 0000000000610041 x18: 0000000000000001
[ 3106.019506] x17: 0000000000000001 x16: ffffffffffffffff x15: 0000000000000000
[ 3106.024494] x14: ffffb85477fdfe08 x13: 0000ffff9372ffff x12: 0000000000000000
[ 3106.029469] x11: 1fffef4a88a96be1 x10: ffff7a54454b5f0c x9 : ffffb854771b12f0
[ 3106.034324] x8 : 0008000000000000 x7 : ffff7a546c1aa980 x6 : 0008000000000080
[ 3106.038902] x5 : 00000000001207cf x4 : 0000ffff9372f000 x3 : ffffffe8d481f000
[ 3106.043420] x2 : 0000000000610041 x1 : 0000000000000001 x0 : 0000000000000000
[ 3106.047957] Call trace:
[ 3106.049522]  try_grab_folio+0x11c/0x188
[ 3106.051996]  follow_pmd_mask.constprop.0.isra.0+0x150/0x2e0
[ 3106.055527]  follow_page_mask+0x1a0/0x2b8
[ 3106.058118]  __get_user_pages+0xf0/0x348
[ 3106.060647]  faultin_page_range+0xb0/0x360
[ 3106.063651]  do_madvise+0x340/0x598
...



# cat reproducer.c
#include <stdio.h>
#include <sys/mman.h>
#include <linux/mman.h>
#include <errno.h>
#include <string.h>
#include <numaif.h>
#include <pthread.h>

#define SIZE_64KB (64 * 1024ul)

static void *thread_fn(void *arg)
{
         char *mem = arg;

         /* Let GUP go crazy on the page without grabbing a reference. */
         while (1) {
                 if (madvise(mem, SIZE_64KB, MADV_POPULATE_WRITE)) {
                         fprintf(stderr, "madvise() failed: %d\n", errno);
                 }
         }
}

int main(void)
{
         pthread_t thread;
         unsigned int i;
         char *mem;

         mem = mmap(0, SIZE_64KB, PROT_READ|PROT_WRITE,
                    MAP_ANON|MAP_PRIVATE|MAP_HUGETLB|MAP_HUGE_64KB, -1, 0);
         if (mem == MAP_FAILED) {
                 fprintf(stderr, "mmap() failed: %d\n", errno);
                 return -1;
         }

         memset(mem, 0, SIZE_64KB);

         pthread_create(&thread, NULL, thread_fn, mem);

         /* Migrate it back and forth between two nodes. */
         for (i = 0; ; i++) {
                 void *pages[1] = { mem, };
                 int nodes[1] = { i % 2, };
                 int status[1] = { 0 };

                 if (move_pages(0, 1, pages, nodes, status, MPOL_MF_MOVE_ALL))
                         fprintf(stderr, "move_pages failed: %d\n", errno);
                 if (status[0] != nodes[0])
                         printf("migration failed\n");
         }
         return 0;
}


-- 
Cheers,

David / dhildenb


