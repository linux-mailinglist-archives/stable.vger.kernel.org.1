Return-Path: <stable+bounces-119695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF66A46478
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C942F17B4EA
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864222371F;
	Wed, 26 Feb 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qc/39WMl"
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABC35968;
	Wed, 26 Feb 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583376; cv=none; b=QEnZC6F2zUon0TDW6B/nJp0S9Zzy5adcI3LDUDk8P6U3XeORD8z1EP7qOsZedAbfX8XhLig6N6aZPFrXJwlqhKe7wIXORDeUp5uPpEJp1REKERGd2P/xPhY46P/PXQbWZnzmZwnSaca/Rve7FTL4EE26I17ZUihbnJJ260GAfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583376; c=relaxed/simple;
	bh=/1VhLFSzTVSbRM0WhjJSkEojp6ksoateovN2MovVNWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zt7+j9Hl+SseqMBkuXV/FHUa0JWw5UvXg+/95V5A8EOo4cAJC3vBg+T6IiaivcQ5lzmSxyf7JdAn2a4opbOPtRot4OwbqSLXu/2prajYY9KSlCOZRtcs+TvwRjQCVxd3ckWZZGIO21RdVLIvp79dyjjDBFIhLPETJKT0V4qrF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qc/39WMl; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740583361; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bP9nSFdQETXvwlDryZ3TLOQHArbJ0X52SeLxUUzWmC8=;
	b=qc/39WMlN9VIDBsqNgsWIE/r9l/otpV0ppE8ICpzG9OsOGfqpBnQeVdgY7xhe3b4X9Hh/WHKZL2xESGUGbCTdPEcv+wJs0I/ZiBWS4+IT0rf2PxECfm9rYWpdUByTHhpsFooLjy+eennzfrApE+fVnRoa/02gYzD9wVYWsT1uHQ=
Received: from 30.39.248.98(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQJBj1w_1740583040 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Feb 2025 23:17:21 +0800
Message-ID: <1a1bd8ed-1204-4ca4-82ed-cdba689c06c5@linux.alibaba.com>
Date: Wed, 26 Feb 2025 23:17:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix finish_fault() handling for large folios
To: Brian Geffon <bgeffon@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, Marek Maslanka <mmaslanka@google.com>
References: <20250226114815.758217-1-bgeffon@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250226114815.758217-1-bgeffon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/26 19:48, Brian Geffon wrote:
> When handling faults for anon shmem finish_fault() will attempt to install
> ptes for the entire folio. Unfortunately if it encounters a single
> non-pte_none entry in that range it will bail, even if the pte that
> triggered the fault is still pte_none. When this situation happens the
> fault will be retried endlessly never making forward progress.
> 
> This patch fixes this behavior and if it detects that a pte in the range
> is not pte_none it will fall back to setting just the pte for the
> address that triggered the fault.

Could you describe in detail how this situation occurs? How is the none 
pte inserted within the range of the large folio? Because we have checks 
in shmem to determine if a large folio is suitable.

Anyway, if we find the pte_range_none() is false, we can fallback to 
per-page fault as the following code shows (untested), which seems more 
simple?

diff --git a/mm/memory.c b/mm/memory.c
index a8196ae72e9a..8a2a9fda5410 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5219,7 +5219,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
         bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
                       !(vma->vm_flags & VM_SHARED);
         int type, nr_pages;
-       unsigned long addr = vmf->address;
+       unsigned long addr;
+       bool fallback_per_page = false;
+
+
+fallback:
+       addr = vmf->address;

         /* Did we COW the page? */
         if (is_cow)
@@ -5258,7 +5263,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
          * approach also applies to non-anonymous-shmem faults to avoid
          * inflating the RSS of the process.
          */
-       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
+       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))
+           || unlikely(fallback_per_page)) {
                 nr_pages = 1;
         } else if (nr_pages > 1) {
                 pgoff_t idx = folio_page_idx(folio, page);
@@ -5294,9 +5300,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
                 ret = VM_FAULT_NOPAGE;
                 goto unlock;
         } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
-               update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
-               ret = VM_FAULT_NOPAGE;
-               goto unlock;
+               fallback_per_page = true;
+               pte_unmap_unlock(vmf->pte, vmf->ptl);
+               goto fallback;
         }

         folio_ref_add(folio, nr_pages - 1);

> 
> Cc: stable@vger.kernel.org
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>
> Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
> Reported-by: Marek Maslanka <mmaslanka@google.com>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>   mm/memory.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index b4d3d4893267..32de626ec1da 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5258,9 +5258,22 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   		ret = VM_FAULT_NOPAGE;
>   		goto unlock;
>   	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> -		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
> -		ret = VM_FAULT_NOPAGE;
> -		goto unlock;
> +		/*
> +		 * We encountered a set pte, let's just try to install the
> +		 * pte for the original fault if that pte is still pte none.
> +		 */
> +		pgoff_t idx = (vmf->address - addr) / PAGE_SIZE;
> +
> +		if (!pte_none(ptep_get_lockless(vmf->pte + idx))) {
> +			update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
> +			ret = VM_FAULT_NOPAGE;
> +			goto unlock;
> +		}
> +
> +		vmf->pte = vmf->pte + idx;
> +		page = folio_page(folio, idx);
> +		addr = vmf->address;
> +		nr_pages = 1;
>   	}
>   
>   	folio_ref_add(folio, nr_pages - 1);

