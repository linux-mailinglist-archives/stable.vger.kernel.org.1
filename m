Return-Path: <stable+bounces-195144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE75C6C7F5
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 04:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3215F4F2302
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287712620E5;
	Wed, 19 Nov 2025 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWQQi2ji"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174621D3CC
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520985; cv=none; b=Tg5YAGjSdbtdK0z7OP49nigcjFM+6Je8e0rg+c+u1kXYysQIZ0E2k2u4gNOCOqwE3qIeYFK7pqgi6WNmekuDJ6sjBhuZXZPtN5lO8K/pk3O5rmoWdicPPjoy+VY6+MbQh5mgKkT4HnTilWDo7dCn30368Dczq+yTWwKKzcFmK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520985; c=relaxed/simple;
	bh=IHxPFpaCKzA3BinTQEiv6ymFIj5RusDtbTm+YNMb+BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEYTfJE2czBGXoxZw7NqjoyM0NHLISz2sXuQfoXazEolEqV2otGrY++a3HusKB0NyIGq7Q22MzGhds+Ci+b0VeuDRBKxcauYieE8p59U/DmmNeGyz6UDDAPqFTvroDMPLWgWNe8v9cxyx5qbSz+FxMhoDoBzwBPVLzAIYnNpCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWQQi2ji; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so8361957a12.3
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 18:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763520982; x=1764125782; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOMJS2JDPGL93B19O1WVoKfDxgEhOzXhZGq1xHqsZnM=;
        b=FWQQi2jiPzCv5szbMkvqCBlCN6buxCdVzoQ5CRf/TxHDx2zp0BlX1uQwma+ti/KvCL
         9pQ/KeeukTY3MdH8TcyzKYw3LOVxRB93/R3tPWFzWJVw5XaGX4UR7sHOTUgaVJiSd9CO
         56Wvg3nqndVng49bWD593311NmM9p5tMum+boc+eOUiqiZbKMi6i9XPWPK9ifkRFAaff
         iU4CI2TKFt+se55BtfapG4gswHVEqeb+Xd1iRiHV1R+rm87jExyY+nFLTfSxTqA/5cy9
         Au+590nG+hFE0PeyTIVPN89ayoUb3NCZQ7PK9cS0rzNVwvNZBNjYIOVouuW32FdlZAMP
         m0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520982; x=1764125782;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOMJS2JDPGL93B19O1WVoKfDxgEhOzXhZGq1xHqsZnM=;
        b=LmWgYpFduyHdi1bO8dRSL3tF7IEKhAFgwKxDG6wXTIptY50RvefZzlvRjKQDlFb/bl
         gIUeSqGH06JNzbOkhyxRjYQJsS/95EsvXjc7r7m5qFj/DovPkyg7dZ65VSug03oFbm7T
         zZ/eBEN8vLZyTolbpk7T/BDd0roWetAsOQDQtDhrAEQQYFySB/YWuHANAl0PwDpKdvIO
         8PYlL+QjgVNX5E8n1KHRSLGnFrbntJt8Qw4m4AvaS6A6j7mrmIg6zk3cYmnt2owiD80/
         RZdIN3XqY7Kpam6o6accT/sXjWNdNmbXl185QtmBLrx2oazsZwccH1NkWooWld7taUK+
         xa1g==
X-Forwarded-Encrypted: i=1; AJvYcCVpJLQd+acS3g1NUI96ApjPLo9j6VC3K1SEvMSBCzRg+HUr03zEwX7JtAHN7tUDp89bvzyY7ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrQs5qcLjUEI/sV4nRzncf71nHp/z/fMKjn5xnZJJROYecVBU
	ftNEHvSLnukw48+oJpoT8IVuJ5oPOf9EpuXDmqEKH4hhWn8d7hds6nEf
X-Gm-Gg: ASbGncuRj17MmJ0+ZBif/URDtEEjMrOToUlaUu0vMkwx7hBHw2Kptp4kUIZcYMrsPuE
	qTfAt8riprpqiQkmrjxC2/i+x/vFPWP2Uie6M3J8IH1+V9kpwAexbPLrNgyZbPgXyKIcQ1Y3jEI
	oCtc8uEAG2Ms7Jav/+UlCbHRbNqGebRhYlSaDHN0MsJYxday31ETSRwQDLApU+9RYglPNZH13kO
	eKAVPRz0Bd4bzgkSFmrYqSRsKmeIBavZ5x6hGsIolzF9JirlaBAOGrS0ZX4B1uAXP/h+wk1Ci3h
	NsMv61unoyZEKIDFOlQx8NjaPPi3+r1c6cP1ViaSoqfz+jvcwR8KFkxO1WTFgdB4ck38JT9rcqY
	E6Yww4gBIYkZvqj8Yqe1oPa+UMygSQy/p9B8j8vMJTUlZHdNjw2Yf6zJXasLocq8Q+3y2wCPt77
	q3+1Ng98UmaWtIMV3zBMwlx5wo
X-Google-Smtp-Source: AGHT+IGhi0w+JwGlUyZXuVhv4DA2Q1T9H6BZyMqMXOqXaCAUEVNLYLkyX2a8mYzeJt6dtljhrtrfDg==
X-Received: by 2002:a05:6402:35cd:b0:640:a9fb:3464 with SMTP id 4fb4d7f45d1cf-64350e06e93mr16239028a12.7.1763520981972;
        Tue, 18 Nov 2025 18:56:21 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a497fc5sm14029203a12.22.2025.11.18.18.56.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Nov 2025 18:56:20 -0800 (PST)
Date: Wed, 19 Nov 2025 02:56:20 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when
 splitting shmem folio in swap cache
Message-ID: <20251119025620.mnumfajqrojfzv6l@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <A5303358-5FA3-4412-89B2-FF51DA759E28@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5303358-5FA3-4412-89B2-FF51DA759E28@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Nov 18, 2025 at 09:32:05PM -0500, Zi Yan wrote:
>On 18 Nov 2025, at 20:26, Wei Yang wrote:
>
>> Commit c010d47f107f ("mm: thp: split huge page to any lower order
>> pages") introduced an early check on the folio's order via
>> mapping->flags before proceeding with the split work.
>>
>> This check introduced a bug: for shmem folios in the swap cache, the
>> mapping pointer can be NULL. Accessing mapping->flags in this state
>> leads directly to a NULL pointer dereference.
>>
>> This commit fixes the issue by moving the check for mapping != NULL
>> before any attempt to access mapping->flags.
>>
>> This fix necessarily changes the return value from -EBUSY to -EINVAL
>> when mapping is NULL. After reviewing current callers, they do not
>> differentiate between these two error codes, making this change safe.
>>
>> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: <stable@vger.kernel.org>
>>
>> ---
>>
>> This patch is based on current mm-new, latest commit:
>>
>>     056b93566a35 mm/vmalloc: warn only once when vmalloc detect invalid gfp flags
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
>>     mm: thp: split huge page to any lower order pages
>>
>> commit 6a50c9b512f7734bc356f4bd47885a6f7c98491a
>> Author: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> Date:   Fri Jun 7 17:40:48 2024 +0800
>>
>>     mm: huge_memory: fix misused mapping_large_folio_support() for anon folios
>
>This is a hot fix to commit c010d47f107f, so the backport should end
>at this point.
>
>>
>> commit 9b2f764933eb5e3ac9ebba26e3341529219c4401
>> Author: Zi Yan <ziy@nvidia.com>
>> Date:   Wed Jan 22 11:19:27 2025 -0500
>>
>>     mm/huge_memory: allow split shmem large folio to any lower order
>>
>> commit 58729c04cf1092b87aeef0bf0998c9e2e4771133
>> Author: Zi Yan <ziy@nvidia.com>
>> Date:   Fri Mar 7 12:39:57 2025 -0500
>>
>>     mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
>> ---
>>  mm/huge_memory.c | 68 +++++++++++++++++++++++++-----------------------
>>  1 file changed, 35 insertions(+), 33 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 7c69572b6c3f..8701c3eef05f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3696,29 +3696,42 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>>  				"Cannot split to order-1 folio");
>>  		if (new_order == 1)
>>  			return false;
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
>> +		const struct address_space *mapping = folio->mapping;
>> +
>> +		/* Truncated ? */
>> +		/*
>> +		 * TODO: add support for large shmem folio in swap cache.
>> +		 * When shmem is in swap cache, mapping is NULL and
>> +		 * folio_test_swapcache() is true.
>> +		 */
>> +		if (!mapping)
>>  			return false;
>> +
>> +		if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
>> +			if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>> +			    !mapping_large_folio_support(folio->mapping)) {
>
>folio->mapping can just be mapping here. The above involved commits would
>mostly need separate backport patches, so keeping folio->mapping
>as the original code does not make backporting easier.
>

Thanks, I think you are right. I tried to keep the foot print small for
backport. But it seems not benefit much.

@Andrew

If an updated version is necessary, please let me know.

>> +				/*
>> +				 * We can always split a folio down to a
>> +				 * single page (new_order == 0) uniformly.
>> +				 *
>> +				 * For any other scenario
>> +				 *   a) uniform split targeting a large folio
>> +				 *      (new_order > 0)
>> +				 *   b) any non-uniform split
>> +				 * we must confirm that the file system
>> +				 * supports large folios.
>> +				 *
>> +				 * Note that we might still have THPs in such
>> +				 * mappings, which is created from khugepaged
>> +				 * when CONFIG_READ_ONLY_THP_FOR_FS is
>> +				 * enabled. But in that case, the mapping does
>> +				 * not actually support large folios properly.
>> +				 */
>> +				VM_WARN_ONCE(warns,
>> +					"Cannot split file folio to non-0 order");
>> +				return false;
>> +			}
>>  		}
>>  	}
>>
>> @@ -3965,17 +3978,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>
>>  		mapping = folio->mapping;
>>
>> -		/* Truncated ? */
>> -		/*
>> -		 * TODO: add support for large shmem folio in swap cache.
>> -		 * When shmem is in swap cache, mapping is NULL and
>> -		 * folio_test_swapcache() is true.
>> -		 */
>> -		if (!mapping) {
>> -			ret = -EBUSY;
>> -			goto out;
>> -		}
>> -
>>  		min_order = mapping_min_folio_order(folio->mapping);
>>  		if (new_order < min_order) {
>>  			ret = -EINVAL;
>> -- 
>> 2.34.1
>
>Otherwise, LGTM. Thank you for fixing the issue.
>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

