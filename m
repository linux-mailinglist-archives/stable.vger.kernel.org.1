Return-Path: <stable+bounces-195171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D2C6ECD2
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7B7022EA12
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C93636402A;
	Wed, 19 Nov 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN0oy1eA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6435A959
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558082; cv=none; b=YPFEbz00rHkJ4yK7Asaph6EOS9IaL9wuLFwyRIoOylNm/Me1LLgZ3qoXEqXCgm9oPLeXi6t8GauBo7vsCwroXJFKWX5AcaTTPN+41u6aRgefKBRLDYO90JzD4eXXgY69h6JPGe/0nTWdeIbcCeEzusXaI7JppJNmgWwl9fUmA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558082; c=relaxed/simple;
	bh=cYMCiqaeY/iMjLpOvVfh/jpGsVYzPCw9Ts9Z90j7jes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0+IY5dWPX5rl8BMHwtPHBcVvW2Y8wbvxg4XI6sbJKPo4/+vHVZVqf9ZCigctgGiARNBZ5uTtribbbOGg0FOXkUls6RG5hMSCBIylpY7cApXFvvL36f4ZTrPqCRurXZbST+u2g4WD4VknZxjhfXoJofV+eoVPJqX1/e0PHoCEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DN0oy1eA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b727f452fffso147955266b.1
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 05:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763558072; x=1764162872; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRF+ue/Id9ldgZPTyrJqrSqz6d2mMp+yZHF4xezoixc=;
        b=DN0oy1eAfTohPEc6uanAqoAha37NdcUlm2y31LfJctGPBsgDcI8VUHHwxWEWf7GgkZ
         sKytPJD27VbSptuVoU703UYkZ+EsuzwPcUgSGks1mTc428NZDNcLzBgxSR34S6Voiwh3
         U+GJA6F9dfQ2UdEyaNVF5BIxwMK56G525gJw+6OpRjOamFMrypApoEXoOJd6ppZkVkpX
         jXsAX40OU+Ak0rsh2nf30/O8sk4e7LmQ/CcDMVmJZf8hHn39tq901YSDJOc2TKOksAdS
         0+SuPC/v5Aa6bRwPyLitUmaPENXS6FAXFGhpLT5+5BoX4LSHzB+9k8tLC3IHismx6nVq
         wtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763558072; x=1764162872;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRF+ue/Id9ldgZPTyrJqrSqz6d2mMp+yZHF4xezoixc=;
        b=wqyF2mxYiO6tVJ+BuSzkONd++RRmgJ6IRLISdgBZlJWuziOBcX7N3YXjmAx5GM6VwK
         ZSbXvWyy33eJgJ6XyZmAE1p0IV8fcy0maREJtxGtPSVlw9iKJkTC6nY1MaD9RLCAEusY
         21jmeL/6totld3lBq/rx2QncSqmLkUwF7QtdeeGOmf6arPELjJLteUepG84AsyAV3TMk
         qzzLQ+l2WulymYxbL4A0KCtXkfxzFdym+si/hpsq9q7zG7/9c+rufDo0LdaZ5CQjyY1k
         CLZK/gVWt7pp0I2MVUbFsQDC5OvWU4DtjPNg9ettAjnlyuwt2y5FqsG/nWHemvR4IaV+
         0y9A==
X-Forwarded-Encrypted: i=1; AJvYcCVD7ytYS6OGkFcajrm0KLM1YwXr6s6j7USV6njqYZAKz3WlCf8ku7kU6E5eq+N8Sl14YVlKrM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/vKh3jycysYovEDgaRXwNQfAH+rC2Z1M0GoiWa43p+ZXSFq7
	DOQN91b3JnmQSwFTfd4/cKdI1aCh2IJgwJkDdoCMxMVrCbxBHela+Rqi
X-Gm-Gg: ASbGncvmtH5U1QUjEYZCey4hHbwB5+7AcV9Q3gPkZP0VMqrlKdu8gw54qvrRNOIsEeg
	QL7iFR4e0dd94XTMGIihu3xruYhTFBRpRtV5YVvbXHDG04eyRgqF+SQiEhW52LLgFPN2bWEb29o
	7zPZQB+99w5/nsoqhoT1iyLApP3RRdg99LYEiGUJwUuWIdHPzGsCS6P40/ovSwr+WEd1ob+NOZK
	61Jpon3Q3sdvNy2AkiZ+1k+m8Ws6M0i1O5PN9nGhk0NAO2yhiTXssSa4iJ5l4QU/i4NfA/yBf3o
	kwZJlK5adO7RIHVhp5iuoDAeAZsbqUl5f4V3JdH40iSOgBneEJrMk5LNLWZS3CEIhsydn7WqW4G
	U3GvNZQDggJQdp3mAq8Manb1RETac7li1QwVg/dBi3VoFDmnO+kuM7KhBwj0Y1hvBvUicODK1vd
	Jc5EeAkcWRdAaCu5aXN2LBfPYy
X-Google-Smtp-Source: AGHT+IE4FtaAmTPc8nlPuMZkbBbMHwWd3hGOnt5zgEOovXAqLkOxf/D6wSnvJsL5jecKKropYCT3DA==
X-Received: by 2002:a17:907:7e9d:b0:b72:84bd:88f3 with SMTP id a640c23a62f3a-b7638d4b9bfmr251787466b.11.1763558071974;
        Wed, 19 Nov 2025 05:14:31 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed80f0sm1624937366b.66.2025.11.19.05.14.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Nov 2025 05:14:31 -0800 (PST)
Date: Wed, 19 Nov 2025 13:14:31 +0000
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
Message-ID: <20251119131431.gzr77o24cnnt3o34@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
 <20251119122325.cxolq3kalokhlvop@master>
 <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Nov 19, 2025 at 01:54:45PM +0100, David Hildenbrand (Red Hat) wrote:
>
>> 
>> > So I think we should try to keep truncation return -EBUSY. For the shmem
>> > case, I think it's ok to return -EINVAL. I guess we can identify such folios
>> > by checking for folio_test_swapcache().
>> > 
>> 
>> Hmm... Don't get how to do this nicely.
>> 
>> Looks we can't do it in folio_split_supported().
>> 
>> Or change folio_split_supported() return error code directly?
>
>
>On upstream, I would do something like the following (untested):
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 2f2a521e5d683..33fc3590867e2 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3524,6 +3524,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>                                "Cannot split to order-1 folio");
>                if (new_order == 1)
>                        return false;
>+       } else if (folio_test_swapcache(folio)) {
>+               /* TODO: support shmem folios that are in the swapcache. */
>+               return false;
>        } else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>            !mapping_large_folio_support(folio->mapping)) {
>                /*
>@@ -3556,6 +3559,9 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>                                "Cannot split to order-1 folio");
>                if (new_order == 1)
>                        return false;
>+       } else if (folio_test_swapcache(folio)) {
>+               /* TODO: support shmem folios that are in the swapcache. */
>+               return false;
>        } else  if (new_order) {
>                if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>                    !mapping_large_folio_support(folio->mapping)) {
>@@ -3619,6 +3625,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>        if (folio != page_folio(split_at) || folio != page_folio(lock_at))
>                return -EINVAL;
>+       /*
>+        * Folios that just got truncated cannot get split. Signal to the
>+        * caller that there was a race.
>+        *
>+        * TODO: support shmem folios that are in the swapcache.
>+        */
>+       if (!is_anon && !folio->mapping && !folio_test_swapcache(folio))
>+               return -EBUSY;
>+
>        if (new_order >= folio_order(folio))
>                return -EINVAL;
>@@ -3659,17 +3674,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>                gfp_t gfp;
>                mapping = folio->mapping;
>-
>-               /* Truncated ? */
>-               /*
>-                * TODO: add support for large shmem folio in swap cache.
>-                * When shmem is in swap cache, mapping is NULL and
>-                * folio_test_swapcache() is true.
>-                */
>-               if (!mapping) {
>-                       ret = -EBUSY;
>-                       goto out;
>-               }
>+               VM_WARN_ON_ONCE_FOLIO(!mapping, folio);
>                min_order = mapping_min_folio_order(folio->mapping);
>                if (new_order < min_order) {
>
>
>So rule out the truncated case earlier, leaving only the swapcache check to be handled
>later.
>
>Thoughts?
>

Cleaner, will test this first.

>> 
>> > 
>> > Probably worth mentioning that this was identified by code inspection?
>> > 
>> 
>> Agree.
>> 
>> > > 
>> > > Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>> > > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> > > Cc: Zi Yan <ziy@nvidia.com>
>> > > Cc: <stable@vger.kernel.org>
>> > 
>> > Hmm, what would this patch look like when based on current upstream? We'd
>> > likely want to get that upstream asap.
>> > 
>> 
>> This depends whether we want it on top of [1].
>> 
>> Current upstream doesn't have it [1] and need to fix it in two places.
>> 
>> Andrew mention prefer a fixup version in [2].
>> 
>> [1]: lkml.kernel.org/r/20251106034155.21398-1-richard.weiyang@gmail.com
>> [2]: lkml.kernel.org/r/20251118140658.9078de6aab719b2308996387@linux-foundation.org
>
>As we will want to backport this patch, likely we want to have it apply on current master.
>
>Bur Andrew can comment what he prefers in this case of a stable fix.
>

Yep, I will prepare patch both for current master and current mm-new.

And wait for Andrew's order.

>-- 
>Cheers
>
>David

-- 
Wei Yang
Help you, Help me

