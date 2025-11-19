Return-Path: <stable+bounces-195167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C3C6E6C3
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 13:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9354738526D
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99669346FB0;
	Wed, 19 Nov 2025 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxpcOhHC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793BC33C51A
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555010; cv=none; b=CYRppNeulqP9hmQHWL6uONrxp30tYurgWQIfrFmVHkxOY7pjw+ZLsSt4gm5y8QgbsJo3GnsYWPaa88TIL/rqNgRmf+IPZXtPkWrgAhSbYmRWrbLnZ7zwwn1j8GL0wosnjzbG0/cUFqpI5zrv1loo4gM7XfPaYg18LMK7Wjg2fLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555010; c=relaxed/simple;
	bh=9JoknXF+GCB5r2ZDRzdJMfHGGzgdS5PJQVsMGgeSAVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krqySU0ybxz2/xKzbQxgu3rQB7zTR3U5MY0hsuvdHcq7Y7ux/eutjv6FZT+2zWMuxkev1rutRhOWs7h6tLi3GZCVkfDYpCyOAWtsu7TCBRefyxeVVH0R5bW+LvGrX5hOITezmSR2mTCD9p83vP5CXvOqMql2SHtiMkcBKgiJ5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxpcOhHC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so8973686a12.3
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 04:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763555007; x=1764159807; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0XrMI668P3tvkUw9AIKNvZgD+A366ogSw2G82hvgsQ=;
        b=mxpcOhHCBXmGiR2vU5LnAqIsx9Xio/Z1fLLfHsmY65IgqXfleQijE6L8a728wA89kD
         ElMIs7XTMjd5taR3vn0c6B2MYV1kXLsoVqsO5w0cXFawOsjIXlC3qFxPKcvZUVZqSK2p
         6CU2qm3YDpo0DOHPNC5t49OHnDKFMMHUsSiBGpDyriuLgu8PETzhBRI3SkO18S6DvH8U
         /d9f1FhkZOW1iJVB+Rlk//0g9FPZxFhH8PlcYXXaFbGx4/9VQNO6d4pkZVmVwByBVbiy
         9dY4lxjtSqnhIDi5tVHWc8qwd1TFVnKB0gkh0s7koC3rEkgpHUGAck6DPUBKpiUyCZPx
         6nXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555007; x=1764159807;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0XrMI668P3tvkUw9AIKNvZgD+A366ogSw2G82hvgsQ=;
        b=LPHkjIbT3ppL1fQCAV3YbdwPzaOg7MGyJsT1P26FCqE4Oj36WXwDMvAdaniqsIqcQQ
         4S7idlt4V6RvO6tz5FfoQVMFABF2HXu8TswF+4lgd9mEZGe9B8M+Ejbd3G9AxjfX87zD
         HAcu9VCgjEyQwPx3YPuOetkRuDU598BIwF78ZsjADuHq4vn3p+vh8b+15/n7mkL/2qPT
         30U7CZzje9yiNpnEgTVCKNq6FP74LTHF+CTxx4qykcHtvhl9uwEb1RcIVLqq1XpRfnGZ
         BXKVoBEPPSW+W50K02KUGgEPh1hOqgrbQfyFlQyxpE9JmOVbD1+ulKvKzl15ykkWQc+H
         FSig==
X-Forwarded-Encrypted: i=1; AJvYcCVyY9CiyWNKv4j9pe2P4LPFW/YVr+u7DGgfg3N6kP45VmoyCz9fxuwMQx740HthqB+pmLNwphU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0d+DFfxtaj433vRZzCjRuDUuHhn4+XxtZgxwT/t7wAASY7g0
	sO/ypfue9TlM94dYxyd3tKl0Kjmuu3Mbv8C0Ne8TNFkanG+2YPq4KRRQ
X-Gm-Gg: ASbGncswdVCNMjVF1r80ljWnyr+KGYLDnQvhBJNY/zeNC6k7oLT8nO786LRn/D/U+v8
	HOGj1Jibp8E3KteXU3V/pGeiDbhYJf1C+axt6S5Sx4b0oej3QxKwjxznHXrMGqZleBlfG8pEcKb
	a+M6kpHadndS1vo0WkMqs694MKDf1xY7uOA9k/pXCMYqqupm/O1I8eGgbj5F/SVTU+owsUVjAgJ
	NGmTGQzX+6GzLj+xZKc5lDJGE9jEtbFKXYwX7K/lATHGHSu+LFi3CbWVVzVJwOqHXHuOsunT76+
	hGmeWkWk5UtqadMIqEt7jOWLhVdpHB9wvDky0g8AjkZn5pHrpB0ElyXkWkpaPdPxzhd29xGdrN2
	sjvTwVF3N7xD6EaClCU7BSaD1qGY/G5GPtVrjZDnE4fBQU8LOW5gmhv0C5Ks6naNBIZbLpdR5p2
	qBz3k1Y/ip81wz9g==
X-Google-Smtp-Source: AGHT+IHO5qH2kvjDZsWGJ+LB4SI840TAY6gesExXlHdFvqNMJ5imJmko/oI81ui1fW31BN4OO9lsZg==
X-Received: by 2002:a05:6402:848:b0:640:b814:bb81 with SMTP id 4fb4d7f45d1cf-64350ebd23dmr19750606a12.32.1763555006504;
        Wed, 19 Nov 2025 04:23:26 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-644f13ff4d4sm5729151a12.12.2025.11.19.04.23.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Nov 2025 04:23:26 -0800 (PST)
Date: Wed, 19 Nov 2025 12:23:25 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when
 splitting shmem folio in swap cache
Message-ID: <20251119122325.cxolq3kalokhlvop@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Nov 19, 2025 at 09:57:58AM +0100, David Hildenbrand (Red Hat) wrote:
>On 19.11.25 02:26, Wei Yang wrote:
>> Commit c010d47f107f ("mm: thp: split huge page to any lower order
>> pages") introduced an early check on the folio's order via
>> mapping->flags before proceeding with the split work.
>> 
>> This check introduced a bug: for shmem folios in the swap cache, the
>> mapping pointer can be NULL. Accessing mapping->flags in this state
>> leads directly to a NULL pointer dereference.
>
>Under which circumstances would that be the case? Only for large shmem folios
>in the swapcache or also for truncated folios? So I'd assume this
>would also affect truncated folios and we should spell that out here?
>

Sorry I don't mention it for my uncertainty.

Will add it.

>> 
>> This commit fixes the issue by moving the check for mapping != NULL
>> before any attempt to access mapping->flags.
>> 
>> This fix necessarily changes the return value from -EBUSY to -EINVAL
>> when mapping is NULL. After reviewing current callers, they do not
>> differentiate between these two error codes, making this change safe.
>
>The doc of __split_huge_page_to_list_to_order() would now be outdated and has
>to be updated.
>
>Also, take a look at s390_wiggle_split_folio(): returning -EINVAL instead of
>-EBUSY will make a difference on concurrent truncation. -EINVAL will be
>propagated and make the operation fail, while -EBUSY will be translated to
>-EAGAIN and the caller will simply lookup the folio again and retry.
>

Oops, I missed this case.

I will rescan users.

>So I think we should try to keep truncation return -EBUSY. For the shmem
>case, I think it's ok to return -EINVAL. I guess we can identify such folios
>by checking for folio_test_swapcache().
>

Hmm... Don't get how to do this nicely.

Looks we can't do it in folio_split_supported().

Or change folio_split_supported() return error code directly?

>
>Probably worth mentioning that this was identified by code inspection?
>

Agree.

>> 
>> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: <stable@vger.kernel.org>
>
>Hmm, what would this patch look like when based on current upstream? We'd
>likely want to get that upstream asap.
>

This depends whether we want it on top of [1].

Current upstream doesn't have it [1] and need to fix it in two places.

Andrew mention prefer a fixup version in [2]. 

[1]: lkml.kernel.org/r/20251106034155.21398-1-richard.weiyang@gmail.com
[2]: lkml.kernel.org/r/20251118140658.9078de6aab719b2308996387@linux-foundation.org

>> 
>> ---
>> 
>> This patch is based on current mm-new, latest commit:
>> 
>>      056b93566a35 mm/vmalloc: warn only once when vmalloc detect invalid gfp flags
>> 
>> Backport note:
>> 
>> Current code evolved from original commit with following four changes.
>> We should do proper adjustment respectively on backporting.
>> 
>> commit c010d47f107f609b9f4d6a103b6dfc53889049e9
>> Author: Zi Yan <ziy@nvidia.com>
>> Date:   Mon Feb 26 15:55:33 2024 -0500
>> 
>>      mm: thp: split huge page to any lower order pages
>> 
>> commit 6a50c9b512f7734bc356f4bd47885a6f7c98491a
>> Author: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> Date:   Fri Jun 7 17:40:48 2024 +0800
>> 
>>      mm: huge_memory: fix misused mapping_large_folio_support() for anon folios
>> 
>> commit 9b2f764933eb5e3ac9ebba26e3341529219c4401
>> Author: Zi Yan <ziy@nvidia.com>
>> Date:   Wed Jan 22 11:19:27 2025 -0500
>> 
>>      mm/huge_memory: allow split shmem large folio to any lower order
>> 
>> commit 58729c04cf1092b87aeef0bf0998c9e2e4771133
>> Author: Zi Yan <ziy@nvidia.com>
>> Date:   Fri Mar 7 12:39:57 2025 -0500
>> 
>>      mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
>> ---
>>   mm/huge_memory.c | 68 +++++++++++++++++++++++++-----------------------
>>   1 file changed, 35 insertions(+), 33 deletions(-)
>> 
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 7c69572b6c3f..8701c3eef05f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3696,29 +3696,42 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>>   				"Cannot split to order-1 folio");
>>   		if (new_order == 1)
>>   			return false;
>> -	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
>> -		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>> -		    !mapping_large_folio_support(folio->mapping)) {
>> -			/*
>> -			 * We can always split a folio down to a single page
>> -			 * (new_order == 0) uniformly.
>> -			 *
>> -			 * For any other scenario
>> -			 *   a) uniform split targeting a large folio
>> -			 *      (new_order > 0)
>> -			 *   b) any non-uniform split
>> -			 * we must confirm that the file system supports large
>> -			 * folios.
>> -			 *
>> -			 * Note that we might still have THPs in such
>> -			 * mappings, which is created from khugepaged when
>> -			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
>> -			 * case, the mapping does not actually support large
>> -			 * folios properly.
>> -			 */
>> -			VM_WARN_ONCE(warns,
>> -				"Cannot split file folio to non-0 order");
>> +	} else {
>
>
>Why not simply
>
>} else if (!folio->mapping) {
>	/*
>	 * Truncated?
>	...
>	return false;
>} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
>...
>

Ah, just not spot this :-(

>> +		const struct address_space *mapping = folio->mapping;
>> +
>> +		/* Truncated ? */
>> +		/*
>> +		 * TODO: add support for large shmem folio in swap cache.
>> +		 * When shmem is in swap cache, mapping is NULL and
>> +		 * folio_test_swapcache() is true.
>> +		 */
>
>While at it, can we merge the two comments into something, like:
>
>/*
> * If there is no mapping that the folio was truncated and we cannot
> * split.
> *
> * TODO: large shmem folio in the swap cache also don't currently have a
> * mapping but folio_test_swapcache() is true for them.
> */
>

Sure.

>-- 
>Cheers
>
>David

-- 
Wei Yang
Help you, Help me

