Return-Path: <stable+bounces-188864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4148BBF99A5
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 03:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39143AF19E
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B491EB193;
	Wed, 22 Oct 2025 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w6L5g+CS"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF92A1AA;
	Wed, 22 Oct 2025 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096324; cv=none; b=BnAVRdQmPXVLPq3guAdXbmxs19CZ4yklzlTAF1rrv7F3vyuAUoamwyACfH5BFzpmyrKDYAQfjK5MA5b7omtk7sK49TvitCqwgwbqvXn0npodG5YDjNYh4RWGT1Vzwh4e65/WfWahWjpXF7i6BHYVQw2yN/pk7Plwy3jGqlH0+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096324; c=relaxed/simple;
	bh=mUjnV054ob0edU5HqryO2gPg+ZqCRgPXhtkdvjywWzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toBfSZOS+iQ19zgWrVNlPCCf9TrJikDcMJv+NCj/OgCt5kIjuL0TXbjO9MTOHrqA8mJhPOxcPWGpKtR34VWyihsvSXyD/SEfEaWNtngR0FJ+fWlqt5qdd2fFf/1lehE+OjZ7lvj0rXSwaRbcjA6bVtIq9qN5VNI3M9RkOEuqJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w6L5g+CS; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761096312; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mMBGLFybuvXPMK2gINIMRD6FATE14CDq9nXmqTlEp6I=;
	b=w6L5g+CSpDmTK0lGQZ8vQhX9tSx4IrSWgy/kHQT0Ps0qtuwwu9xjodx7533htnW0Kicq8G3d9vtvU4ZlanxrVS/SaRXUQEJn4/8peBzsqr8WQzLKKYQkkqlTCA1qn1jZmVXuvM8f7LBOQlHxy3IiHE2L2Et03Z6X3E7jhWsxWas=
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqkgTKQ_1761096310 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 09:25:10 +0800
Message-ID: <65f4dd0b-2bc2-4345-86c2-630a91fcfa39@linux.alibaba.com>
Date: Wed, 22 Oct 2025 09:25:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem: fix THP allocation size check and fallback
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Dev Jain <dev.jain@arm.com>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 stable@vger.kernel.org
References: <20251021190436.81682-1-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251021190436.81682-1-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/22 03:04, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> There are some problems with the code implementations of THP fallback.
> suitable_orders could be zero, and calling highest_order on a zero value
> returns an overflowed size. And the order check loop is updating the
> index value on every loop which may cause the index to be aligned by a
> larger value while the loop shrinks the order. 

No, this is not true. Although ‘suitable_orders’ might be 0, it will not 
enter the ‘while (suitable_orders)’ loop, and ‘order’ will not be used 
(this is also how the highest_order() function is used in other places).

> And it forgot to try order
> 0 after the final loop.

This is also not true. We will fallback to order 0 allocation in 
shmem_get_folio_gfp() if large order allocation fails.

> This is usually fine because shmem_add_to_page_cache ensures the shmem
> mapping is still sane, but it might cause many potential issues like
> allocating random folios into the random position in the map or return
> -ENOMEM by accident. This triggered some strange userspace errors [1],
> and shouldn't have happened in the first place.

I tested tmpfs with swap on ZRAM in the mm-new branch, and no issues 
were encountered. However, it is worth mentioning that, after the commit 
69e0a3b49003 ("mm: shmem: fix the strategy for the tmpfs 'huge=' 
options"), tmpfs may consume more memory (because we no longer allocate 
large folios based on the write size), which might cause your test case 
to run out of memory (OOM) and trigger some errors. You may need to 
adjust your swap size or memcg limit.

> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
> Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   mm/shmem.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b50ce7dbc84a..25303711f123 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1824,6 +1824,9 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
>   	unsigned long pages;
>   	int order;
>   
> +	if (!orders)
> +		return 0;
> +
>   	if (vma) {
>   		orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>   		if (!orders)
> @@ -1888,27 +1891,28 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>   	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>   		orders = 0;
>   
> -	if (orders > 0) {
> -		suitable_orders = shmem_suitable_orders(inode, vmf,
> -							mapping, index, orders);
> +	suitable_orders = shmem_suitable_orders(inode, vmf,
> +						mapping, index, orders);
>   
> +	if (suitable_orders) {
>   		order = highest_order(suitable_orders);
> -		while (suitable_orders) {
> +		do {
>   			pages = 1UL << order;
> -			index = round_down(index, pages);
> -			folio = shmem_alloc_folio(gfp, order, info, index);
> -			if (folio)
> +			folio = shmem_alloc_folio(gfp, order, info, round_down(index, pages));
> +			if (folio) {
> +				index = round_down(index, pages);
>   				goto allocated;
> +			}
>   
>   			if (pages == HPAGE_PMD_NR)
>   				count_vm_event(THP_FILE_FALLBACK);
>   			count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
>   			order = next_order(&suitable_orders, order);
> -		}
> -	} else {
> -		pages = 1;
> -		folio = shmem_alloc_folio(gfp, 0, info, index);
> +		} while (suitable_orders);
>   	}
> +
> +	pages = 1;
> +	folio = shmem_alloc_folio(gfp, 0, info, index);
>   	if (!folio)
>   		return ERR_PTR(-ENOMEM);
>   


