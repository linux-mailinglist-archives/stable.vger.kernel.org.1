Return-Path: <stable+bounces-98909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED24B9E6469
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 03:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5131698B6
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 02:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8849613C677;
	Fri,  6 Dec 2024 02:49:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D84C9A;
	Fri,  6 Dec 2024 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453396; cv=none; b=P2kcS/3ngdn09DnWTaKNT2qOmTPCXqdyTEXq97ryn2yhIXs1Yoe9pnnpzJge47VFzSFNSIvBtBuPBq0sC6kL4eVr066/byIQoIEuTQ49OLacHjXDOMQZVY0EqNT+Ep3a7/6GNZJVob9Wjt7fqLwvsLp7OnKn8RVXZ4tENWjTQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453396; c=relaxed/simple;
	bh=LaQW0ppd/Don9fm3kf876MvIkSbgfOpuuYUBYFkKTGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T1QESrw+Ql4F1gDZW2aCG92kgDSvfNRtM4c7a3T5UxvFb6Q9dUQnEMJIFwl5i5LSjVyxyx9zkf8j+WEgnRB9Sfepe3GQ54k5Bg831cpvGFADRP6B0WFv2SD/Vi2Ll87b9b0DzJGcTYvMDtSuzeqF6fazyvi0zjh/z0So/Vqq3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y4G1w1Xz4z1JDjw;
	Fri,  6 Dec 2024 10:49:40 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 952361A0188;
	Fri,  6 Dec 2024 10:49:49 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Dec 2024 10:49:48 +0800
Message-ID: <f8713870-51c1-41ff-b4b2-9e7d9bb657b1@huawei.com>
Date: Fri, 6 Dec 2024 10:49:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Respect mmap hint address when aligning for THP
To: Kalesh Singh <kaleshsingh@google.com>
CC: <kernel-team@android.com>, <android-mm@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Yang Shi
	<yang@os.amperecomputing.com>, Rik van Riel <riel@surriel.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, Minchan Kim
	<minchan@kernel.org>, Hans Boehm <hboehm@google.com>, Lokesh Gidra
	<lokeshgidra@google.com>, <stable@vger.kernel.org>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann
 Horn <jannh@google.com>, Yang Shi <shy828301@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20241118214650.3667577-1-kaleshsingh@google.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20241118214650.3667577-1-kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/11/19 5:46, Kalesh Singh wrote:
> Commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") updated __get_unmapped_area() to align the start address
> for the VMA to a PMD boundary if CONFIG_TRANSPARENT_HUGEPAGE=y.
> 
> It does this by effectively looking up a region that is of size,
> request_size + PMD_SIZE, and aligning up the start to a PMD boundary.
> 
> Commit 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignment
> on 32 bit") opted out of this for 32bit due to regressions in mmap base
> randomization.
> 
> Commit d4148aeab412 ("mm, mmap: limit THP alignment of anonymous
> mappings to PMD-aligned sizes") restricted this to only mmap sizes that
> are multiples of the PMD_SIZE due to reported regressions in some
> performance benchmarks -- which seemed mostly due to the reduced spatial
> locality of related mappings due to the forced PMD-alignment.
> 
> Another unintended side effect has emerged: When a user specifies an mmap
> hint address, the THP alignment logic modifies the behavior, potentially
> ignoring the hint even if a sufficiently large gap exists at the requested
> hint location.
> 
> Example Scenario:
> 
> Consider the following simplified virtual address (VA) space:
> 
>      ...
> 
>      0x200000-0x400000 --- VMA A
>      0x400000-0x600000 --- Hole
>      0x600000-0x800000 --- VMA B
> 
>      ...
> 
> A call to mmap() with hint=0x400000 and len=0x200000 behaves differently:
> 
>    - Before THP alignment: The requested region (size 0x200000) fits into
>      the gap at 0x400000, so the hint is respected.
> 
>    - After alignment: The logic searches for a region of size
>      0x400000 (len + PMD_SIZE) starting at 0x400000.
>      This search fails due to the mapping at 0x600000 (VMA B), and the hint
>      is ignored, falling back to arch_get_unmapped_area[_topdown]().
> 
> In general the hint is effectively ignored, if there is any
> existing mapping in the below range:
> 
>       [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)
> 
> This changes the semantics of mmap hint; from ""Respect the hint if a
> sufficiently large gap exists at the requested location" to "Respect the
> hint only if an additional PMD-sized gap exists beyond the requested size".
> 
> This has performance implications for allocators that allocate their heap
> using mmap but try to keep it "as contiguous as possible" by using the
> end of the exisiting heap as the address hint. With the new behavior
> it's more likely to get a much less contiguous heap, adding extra
> fragmentation and performance overhead.
> 
> To restore the expected behavior; don't use thp_get_unmapped_area_vmflags()
> when the user provided a hint address, for anonymous mappings.
> 
> Note: As, Yang Shi, pointed out: the issue still remains for filesystems
> which are using thp_get_unmapped_area() for their get_unmapped_area() op.
> It is unclear what worklaods will regress for if we ignore THP alignment
> when the hint address is provided for such file backed mappings -- so this
> fix will be handled separately.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Hans Boehm <hboehm@google.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> 
> Changes in v2:
>    - Clarify the handling of file backed mappings, as highlighted by Yang
>    - Collect Vlastimil's and Rik's Reviewed-by's
> 
>   mm/mmap.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 79d541f1502b..2f01f1a8e304 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -901,6 +901,7 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>   	if (get_area) {
>   		addr = get_area(file, addr, len, pgoff, flags);
>   	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> +		   && !addr /* no hint */

Hello, any update about this patch?

And another question about efa7df3e3bb5 ("mm: align larger anonymous
mappings on THP boundaries"), it said that align anon mapping, but the
code does enable file mapping too, for fs without get_unmapped_area and
enable CONFIG_TRANSPARENT_HUGEPAGE, we always try
thp_get_unmapped_area_vmflags(), right?


  if (file) {
          if (file->f_op->get_unmapped_area)
                  get_area = file->f_op->get_unmapped_area;
  }
  ...
  if (get_area) {
          addr = get_area(file, addr, len, pgoff, flags);
  } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
             && !addr /* no hint */
             && IS_ALIGNED(len, PMD_SIZE)) {
          /* Ensures that larger anonymous mappings are THP aligned. */
          addr = thp_get_unmapped_area_vmflags();
  } else {
          addr = mm_get_unmapped_area_vmflags();
  }

Should we limit it to not call thp_get_unmapped_area_vmflags() for file?

diff --git a/mm/mmap.c b/mm/mmap.c
index 16f8e8be01f8..854fe240d27d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -894,6 +894,7 @@ __get_unmapped_area(struct file *file, unsigned long 
addr, unsigned long len,
                 addr = get_area(file, addr, len, pgoff, flags);
         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
                    && !addr /* no hint */
+                  && !file
                    && IS_ALIGNED(len, PMD_SIZE)) {
                 /* Ensures that larger anonymous mappings are THP 
aligned. */
                 addr = thp_get_unmapped_area_vmflags(file, addr, len,


Thanks


>   		   && IS_ALIGNED(len, PMD_SIZE)) {
>   		/* Ensures that larger anonymous mappings are THP aligned. */
>   		addr = thp_get_unmapped_area_vmflags(file, addr, len,
> 
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> --
> 2.47.0.338.g60cca15819-goog
> 
> 


