Return-Path: <stable+bounces-119805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE401A476A7
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFA81887AB4
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6480821D587;
	Thu, 27 Feb 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A9cZCZU8"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAC2563;
	Thu, 27 Feb 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641690; cv=none; b=H2hrIyvpjcvMzX2+MhUKYI0E2DuOi2QJPRhMprDCzGv8yUwu1W6qiSTlRRUZaKphGkIxSc/SYJDdRdEBzdE17KLx+IHwWASLCKlLA9qAs6p6RElNb8trMIV5acZjqs0SgmjIStdqt0VnkJvgHafKE7BN0x0Oc/RlHN2tsRH+/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641690; c=relaxed/simple;
	bh=MPctCNpeqM4MGxYJfYxy7di46Ga/4B+3ltpFQAJC1uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5SeTn2dBORSBv0TsdW2lDnbo8sCeeeY/GOjh1B57p53hkbYhgFSSur1SpmnndG5tHLnH+qpAbaQJqn1K4ilLxhVwEHykcgQtaxXcHcorrr3zXX5aY88yWvpSjmttMPPsP+B1BU+ecadkIBihJfxmAc95W4z6zL0KVmeq+gskWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A9cZCZU8; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740641677; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=W0giOhonOAea6SPXR9+YI4nSj5chl0mPcUFI3Gguhr0=;
	b=A9cZCZU8jWEvDgdat/2IpOdQDV1wWVoe780YnI4f+owxY7lhfvTGYT/8+Wlms516OAybx9ytDqyF5hOvT+Y90celCJ4is45IAFt5osU671+AYq8Z8dm2s8FFXv7zoyQTNOTPJ21slkrEd0N3nHYHVcMbvBTpVi9ezzoXQaiRszE=
Received: from 30.74.144.117(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQLThRT_1740641676 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Feb 2025 15:34:36 +0800
Message-ID: <19624e55-ba41-41e7-ba11-38b6ab3b96e5@linux.alibaba.com>
Date: Thu, 27 Feb 2025 15:34:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix finish_fault() handling for large folios
To: Brian Geffon <bgeffon@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, Marek Maslanka <mmaslanka@google.com>
References: <20250226114815.758217-1-bgeffon@google.com>
 <20250226162341.915535-1-bgeffon@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250226162341.915535-1-bgeffon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/27 00:23, Brian Geffon wrote:
> When handling faults for anon shmem finish_fault() will attempt to install
> ptes for the entire folio. Unfortunately if it encounters a single
> non-pte_none entry in that range it will bail, even if the pte that
> triggered the fault is still pte_none. When this situation happens the
> fault will be retried endlessly never making forward progress.
> 
> This patch fixes this behavior and if it detects that a pte in the range
> is not pte_none it will fall back to setting a single pte.
> 
> Cc: stable@vger.kernel.org
> Cc: Hugh Dickins <hughd@google.com>
> Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reported-by: Marek Maslanka <mmaslanka@google.com>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>   mm/memory.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index b4d3d4893267..b6c467fdbfa4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5183,7 +5183,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>   		      !(vma->vm_flags & VM_SHARED);
>   	int type, nr_pages;
> -	unsigned long addr = vmf->address;
> +	unsigned long addr;
> +	bool needs_fallback = false;
> +
> +fallback:
> +	addr = vmf->address;
>   
>   	/* Did we COW the page? */
>   	if (is_cow)
> @@ -5222,7 +5226,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   	 * approach also applies to non-anonymous-shmem faults to avoid
>   	 * inflating the RSS of the process.
>   	 */
> -	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
> +	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
> +			unlikely(needs_fallback)) {

Nit: can you align the code? Otherwise look good to me.

>   		nr_pages = 1;
>   	} else if (nr_pages > 1) {
>   		pgoff_t idx = folio_page_idx(folio, page);
> @@ -5258,9 +5263,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   		ret = VM_FAULT_NOPAGE;
>   		goto unlock;
>   	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> -		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
> -		ret = VM_FAULT_NOPAGE;
> -		goto unlock;
> +		needs_fallback = true;
> +		pte_unmap_unlock(vmf->pte, vmf->ptl);
> +		goto fallback;
>   	}
>   
>   	folio_ref_add(folio, nr_pages - 1);

