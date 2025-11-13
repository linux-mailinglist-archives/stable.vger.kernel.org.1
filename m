Return-Path: <stable+bounces-194667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C4362C56928
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 10:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EC77343CF7
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF92D8378;
	Thu, 13 Nov 2025 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZpXHuIo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D652D63EF;
	Thu, 13 Nov 2025 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025635; cv=none; b=VVATJT41MiKLBMk+BJG2vDoUbI/M+LLW197LOY8NP/gu3mY1hXqgg4PRPxVzAH3IOZ+JByWvDE603W7OaTIsjVSesyO6yi2dH0VTrwcl9iA0psdHXI6ZJ/gJtfIwy62zQydiF6EQ7GjXM1usU2OZwU19j/o1CvS8QkTEZ/nyGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025635; c=relaxed/simple;
	bh=qWeXKefTr39Z8QEjwx9tm3gjalzsAeVjEjzYhlbwRLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGV1vPXahWJn+H45yT9UpHcCzo3CXjxWte6LAqq2m1iBNGnrpXSoQ1jnvbSVHaqQP14FcckD+HreZj4ZfUyhN3RgOZdwdeBNZ4ObZykSzUTCcXAlCLUrbOdUCzPOTQeI+bKjUAw9UgyU8p8Zm+Tw0Om5mFmq4ii+2zIuIQQA2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZpXHuIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318D1C4CEF8;
	Thu, 13 Nov 2025 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763025635;
	bh=qWeXKefTr39Z8QEjwx9tm3gjalzsAeVjEjzYhlbwRLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mZpXHuIo3H0Egv1WBvo4ABjZoXf/Ci7KeFuiEV49hQKzupIZa+lZL1qvjl0IQWK/U
	 XmdIh5Wq8FVW4cGmedobTnlvmkjd1HEW2nvPphS6oepn5iJ46yxyc0WxGxl5Xarigv
	 FMYNO98+W8LvaWJcsQu+XKL48ez4hWlQk++JZ1IMAIiQzv9EED9p3oxHBf5bOTx6AL
	 rmKTRVIfQSRH5jstDjYuz97FgVmoKmqh0QWlpaKnduUGQP0b6pevGQlycLr/cFy7OW
	 VEVwCKkKnDimgS7OIxx7OeylF/s3pEFfHWbgdRjUwOnUtuO1P5XTXFM3jHt0vBLERe
	 LMHvQqEW79YUQ==
Message-ID: <6d104efa-0686-4621-aba1-3ce17ef85391@kernel.org>
Date: Thu, 13 Nov 2025 10:20:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memfd: fix information leak in hugetlb folios
To: Deepanshu Kartikey <kartikey406@gmail.com>, hughd@google.com,
 baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
 muchun.song@linux.dev, osalvador@suse.de
Cc: kraxel@redhat.com, airlied@redhat.com, jgg@ziepe.ca, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, vivek.kasireddy@intel.com,
 syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20251112145034.2320452-1-kartikey406@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251112145034.2320452-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.25 15:50, Deepanshu Kartikey wrote:
> When allocating hugetlb folios for memfd, three initialization steps
> are missing:
> 
> 1. Folios are not zeroed, leading to kernel memory disclosure to userspace
> 2. Folios are not marked uptodate before adding to page cache
> 3. hugetlb_fault_mutex is not taken before hugetlb_add_to_page_cache()
> 
> The memfd allocation path bypasses the normal page fault handler
> (hugetlb_no_page) which would handle all of these initialization steps.
> This is problematic especially for udmabuf use cases where folios are
> pinned and directly accessed by userspace via DMA.
> 
> Fix by matching the initialization pattern used in hugetlb_no_page():
> - Zero the folio using folio_zero_user() which is optimized for huge pages
> - Mark it uptodate with folio_mark_uptodate()
> - Take hugetlb_fault_mutex before adding to page cache to prevent races
> 
> The folio_zero_user() change also fixes a potential security issue where
> uninitialized kernel memory could be disclosed to userspace through
> read() or mmap() operations on the memfd.
> 
> Reported-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/20251112031631.2315651-1-kartikey406@gmail.com/ [v1]
> Closes: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Cc: stable@vger.kernel.org
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Tested-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> 
> v1 -> v2:
> - Use folio_zero_user() instead of folio_zero_range() (optimized for huge pages)
> - Add folio_mark_uptodate() before adding to page cache
> - Add hugetlb_fault_mutex locking around hugetlb_add_to_page_cache()
> - Add Fixes: tag and Cc: stable for backporting
> - Add Suggested-by: tags for Oscar and David
> ---
>   mm/memfd.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 1d109c1acf21..d32eef58d154 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -96,9 +96,36 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>   						    NULL,
>   						    gfp_mask);
>   		if (folio) {
> +			u32 hash;
> +
> +			/*
> +			 * Zero the folio to prevent information leaks to userspace.
> +			 * Use folio_zero_user() which is optimized for huge/gigantic
> +			 * pages. Pass 0 as addr_hint since this is not a faulting path
> +			 *  and we don't have a user virtual address yet.
> +			 */
> +			folio_zero_user(folio, 0);

Staring at hugetlbfs_fallocate(), we see, to pass the offset within the 
file.

I think it shouldn't make a difference here (I don't see how the offset 
in the file would be better than 0: it's in both cases not the user 
address).

> +
> +			/*
> +			 * Mark the folio uptodate before adding to page cache,
> +			 * as required by filemap.c and other hugetlb paths.
> +			 */
> +			__folio_mark_uptodate(folio);

Personally, I'd drop this comment as it is really just doing what we do 
everywhere else :)

Hoping we can factor that out into hugetlb code properly.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

