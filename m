Return-Path: <stable+bounces-188916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B7BFAAB1
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D9018C7EC0
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979752FD1BF;
	Wed, 22 Oct 2025 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a2eq5ARI"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C52FC873;
	Wed, 22 Oct 2025 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119257; cv=none; b=jBD51zTYxgnl3fL+sGR66l1krZvOom0tiNde9vJ2iH5mGJq3LgQiNRNRSks9BRHssV969q2yYx2JDErZZEYfOmFW7nuw4N8F6xv9TdTJkule3ZDYy4NrVoJQiTDHvSjRz170ehtfv5v5I1CmuyPtr4rsm+AhM6rf2YbAf46P8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119257; c=relaxed/simple;
	bh=J8lI3pRi+FHOLMgixx/WcXitesh7xzPj+PHBZicAT/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+2EblIL7ksKUzEbAmfjc06KePgIOFSgR0pdQ5ykX0EKOoQsiDC869hQ7GwZotuRJGJjCq/5ifZ2PV0XzLVkPpN5Lx66DXtMqlfa8915v5X2Ezbw8iO7yS4qVT76X7/fAvEg6RhtZ5ZC1Y/S09RD7uaAAXWo2LfN+uisXsgagPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a2eq5ARI; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761119251; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H+qvTFZ8jw1vc9BmwmZE7CbJfZv05rrBieJVcIWZoxI=;
	b=a2eq5ARIDi1BZcTm1e4rsd/klmSJk6cSJX88TcThxDqkgUybKtSVyuifFHNoWfWxzA+zznO8yxLK+TwAuYOfxnI4rCQJABfG/B/37Birq3mGklkEsVqe9MfqGGLDCpC7RBsyzsrro7sQ/brBUNPhjxzM2JRg05h4+9wjPllkFbY=
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wqm-W--_1761119248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 15:47:28 +0800
Message-ID: <6d67cbbf-a609-491e-a0c3-a3d5fd782966@linux.alibaba.com>
Date: Wed, 22 Oct 2025 15:47:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem: fix THP allocation size check and fallback
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Dev Jain <dev.jain@arm.com>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251021190436.81682-1-ryncsn@gmail.com>
 <65f4dd0b-2bc2-4345-86c2-630a91fcfa39@linux.alibaba.com>
 <CAMgjq7D_G=5bJe_Uj11sHV2qCyu-Z-3PZu7QuZyPEhuFiE63wQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7D_G=5bJe_Uj11sHV2qCyu-Z-3PZu7QuZyPEhuFiE63wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/22 13:48, Kairui Song wrote:
> On Wed, Oct 22, 2025 at 9:25 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2025/10/22 03:04, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> There are some problems with the code implementations of THP fallback.
>>> suitable_orders could be zero, and calling highest_order on a zero value
>>> returns an overflowed size. And the order check loop is updating the
>>> index value on every loop which may cause the index to be aligned by a
>>> larger value while the loop shrinks the order.
>>
>> No, this is not true. Although ‘suitable_orders’ might be 0, it will not
>> enter the ‘while (suitable_orders)’ loop, and ‘order’ will not be used
>> (this is also how the highest_order() function is used in other places).
> 
> Maybe I shouldn't mix the trivial issue with the real issue here,
> sorry, my bad, I was in a hurry :P.
> I mean if suitable_orders is zero we should just skip calling the
> highest_order since that returns a negative value. It's not causing an
> issue though, but redundant.

I think compiler can optimize this(?).

>>> And it forgot to try order
>>> 0 after the final loop.
>>
>> This is also not true. We will fallback to order 0 allocation in
>> shmem_get_folio_gfp() if large order allocation fails.
> 
> I thought after the fix, we can simplify the code, and maybe reduce
> the call to shmem_alloc_and_add_folio to only one so it will be
> inlined by the compiler.
> 
> On second thought some more changes are needed to respect the
> huge_gfp. Maybe I should send a series to split the hot fix with clean
> ups.

Yes, I've considered simplifying this, but it would require more 
changes, making it less readable compared to how it is now. Of course, 
if you have a better approach, feel free to try cleaning it up in 
another thread.

> But here the index being modified during the loop do need a fix I
> think, so, for the fix part, we just need:
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 29e1eb690125..e89ae4dd6859 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1895,10 +1895,11 @@ static struct folio
> *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>                  order = highest_order(suitable_orders);
>                  while (suitable_orders) {
>                          pages = 1UL << order;
> -                       index = round_down(index, pages);
> -                       folio = shmem_alloc_folio(gfp, order, info, index);
> -                       if (folio)
> +                       folio = shmem_alloc_folio(gfp, order, info,
> round_down(index, pages));
> +                       if (folio) {
> +                               index = round_down(index, pages);
>                                  goto allocated;
> +                       }
> 
>                          if (pages == HPAGE_PMD_NR)
>                                  count_vm_event(THP_FILE_FALLBACK);

Good catch. I've fixed one similar issue with commit 4cbf320b1500 ("mm: 
shmem: fix incorrect aligned index when checking conflicts"), but I 
missed this part. Please resend the bugfix patch with a correct commit 
message and remove the cleanup changes.

