Return-Path: <stable+bounces-195168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C0C6E87C
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 13:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5199A2BA3D
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456F9354ACA;
	Wed, 19 Nov 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8KskhMj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C73559C9
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556155; cv=none; b=Yx2q8xRfh/EzXjOWD00Vqq8eiw7hUe/h4XYk96/rM7J3oPWha6HyxHVyfI9jyspszk4LBXXXz19UhGNovaqAjgPV3hB0s7Gz0BjSo8zwqz8+ySZ9S+acAz+I2jn2JPrm2rV3A5WMiKvyjxyruSgR+Hi1/J9o30SKGZ83x3M9Hrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556155; c=relaxed/simple;
	bh=yTgDk7QXvahzmc9LavkNrG1uAjfvwm3fbj+Z9gt1EC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaJsPNqxfFHnPCo1itO/mKtqj41RQRk3kYfe5VOkkP7vDWRfCDKGDLhRhzluJJJeaJMI7mmAOk4apbW3+8cY1OmRwhnjGQKYsrb04FXKWTE1ELhOvAI9Hw1P23bnE5dOJHiNvjmREIQaPxtXqtVvkQ2xO9MmWcmIMMHF1k0XQ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8KskhMj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b737cd03d46so611853066b.0
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 04:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763556150; x=1764160950; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGVPQs0raG+cv5Og0jXtjlAYiYTgCHb1gAaNgqguMEk=;
        b=c8KskhMjjDTiZ5SggBzq603QDvgX+YmgUV8WfV85ttsQPSr3+xsLJkZretJv7uRNUs
         X768oLxqAh/q2vjT7h2JAJOcO/bIy2X6t+WGM0nilqg4SLVzuobw74rUjy+2YIAaoCJu
         p+EorUNzCWMkicYHltRthpu0TNjIsRzP/D/S1D4+rXfS/XPqsTA301p6UMCn/NNub/Zd
         +7pGTj0nPp71ziImH4L18JiSXTyqGDFoK/ofDM3vTpNUITvFBiQqPzI2kAuVOVk86V7h
         Iw9h6I4fVx/uGDiTnr1gVlrjC78BhDd/tpwbK8AkoLa/W+adHfoE5q9/0JpqEq2sTtRI
         lMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763556150; x=1764160950;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGVPQs0raG+cv5Og0jXtjlAYiYTgCHb1gAaNgqguMEk=;
        b=Ag7C7Ef6dd6/GVYYvODZnNKibuPWCve3ugSMew6+ICKb1WZ0ZLnxDNkWrg+jI5yDtq
         vTL6TltcPVWfM2XuMMWQPM6SLnb2udkIGZQqEhxXFvrtqEYKYqTTValAmF2KM3iwX/rn
         suqRCt2U7jWJ9goQO9OU+Zss8SclSfTLCE2t5vikCzFJVRlMUX9lL0j/TJ06ciDtH3Li
         s2JNQnVy3yW/Ng7CY8J0UCT5k2p8Go2Y+OTR03U99acTzv29ioGgGXHxX/j8xFtnVDDU
         T88hv/NXe1lMVbCUQx3nGzC+X3djfEadcnsYt7yk/xzJXBiBwaN8WVvmLlmVt7Pcp0jq
         QFng==
X-Forwarded-Encrypted: i=1; AJvYcCWe+JSoof5jojWWCNlAZJCrPMdJ3Gco877zFQeyos+VeVSuOXIcDxCOIfiLUfsR/9W42rXAyiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSllmPZIE+fJfq7FkI2FWRGmZfyoC+nLDVY8xZV44mCKybkl9k
	DzzQPAgwmWKz/g/Pncz67yXaMRV2ap2bAavntRUCeLcEHqrXoCz1mFEc
X-Gm-Gg: ASbGnct7unqMznocKM5FS35bojzuAfFy6H/sIWKIBjNWfUinGghm2m8HoJ1aWJ0+WsZ
	sgpMyHFJef5mfyd0SE2MYe2wVKkql62QYmjVM74LXkJtoBhNC7NFEO4k88EZz5lqJZjyfPjuHhQ
	gU60C667CMfeVwTUDOhW/vKKONtWlbNvSIHdGLVMdOvRyfTogjvvaXfm3Vf5G+679XH5awunKUa
	YxqqwLr+yJREVNjPrtQ1bZEOvXbl1glxLNVQ3sD4NPUA4xo8sfWpqQIR63tzQ75CS4y+bh+2q6C
	p0VvwkcI2fcvYVn6kH7xknPMC3IXnheXH14hQi0kr2hJ31c+KMxp8q53Wi/aOgPAf0gHn1TnTLB
	JBz7ZdmIrujtff9/puomrvs8r/eSXdhX130yxYnfWZyknExecfOWAZyMjVU72RWtXvUkWK/+A7b
	JpDEKI8Z96kyzt4a30ohAYGeHM
X-Google-Smtp-Source: AGHT+IEN++hzFc6qM5M79F8zkm6+1UULklUVoadEco8d4VARLzqMb8To7qTtpf6EO2mbe1PlKSkrNg==
X-Received: by 2002:a17:907:7252:b0:b70:af3d:e97b with SMTP id a640c23a62f3a-b73678ade45mr2126745266b.17.1763556149881;
        Wed, 19 Nov 2025 04:42:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734ff75e4fsm1611291566b.12.2025.11.19.04.42.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Nov 2025 04:42:29 -0800 (PST)
Date: Wed, 19 Nov 2025 12:42:29 +0000
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
Message-ID: <20251119124229.e4cpozqapmfeqykr@master>
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
>So I think we should try to keep truncation return -EBUSY. For the shmem
>case, I think it's ok to return -EINVAL. I guess we can identify such folios
>by checking for folio_test_swapcache().
>

I come up a draft:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7c69572b6c3f..3e140fa1ca13 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3696,6 +3696,18 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
                                "Cannot split to order-1 folio");
                if (new_order == 1)
                        return -EINVAL;
+       } else if (!folio->mapping) {
+               /*
+                * If there is no mapping that the folio was truncated and we
+                * cannot split.
+                *
+                * TODO: large shmem folio in the swap cache also don't
+                * currently have a mapping but folio_test_swapcache() is true
+                * for them.
+                */
+               if (folio_test_swapcache(folio))
+                       return -EINVAL;
+               return -EBUSY;
        } else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
                if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
                    !mapping_large_folio_support(folio->mapping)) {
@@ -3931,8 +3943,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
        if (new_order >= old_order)
                return -EINVAL;
 
-       if (!folio_split_supported(folio, new_order, split_type, /* warn = */ true))
-               return -EINVAL;
+       ret = folio_split_supported((folio, new_order, split_type, /* warn = */ true));
+       if (ret)
+               return ret;
 
        is_hzp = is_huge_zero_folio(folio);
        if (is_hzp) {

Not sure I get your point correctly.

-- 
Wei Yang
Help you, Help me

