Return-Path: <stable+bounces-198052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF0C9A876
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 08:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 236DA4E2C62
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 07:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C883016F1;
	Tue,  2 Dec 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HixWft7Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11B2F7ABF
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661451; cv=none; b=Ijmneu1jCPLM3FE353yQjDEMQ2yR1SPYEHGe2BhrLTU15S26EOg4Ug7yYgIRZWV1dDLawDo+LWHeWZI2PgdhbbuDj+D4YU9m120GerbNJ5y8jPc98hNDfupNRvHS4LQERspnpQvWwxnOdnxCKUGBLWQHozM1h0TrA7h6bU0k/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661451; c=relaxed/simple;
	bh=AS49m0YE7R/aAXE/s2nIFxVf95SUgcHreGJIBCx4Ltk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S18kkHEhh1rw/Wf74OnL2BPQO/r+U7kZusiwQVjRGK4NJy6ONwbWoQkab3qqry9CRgHeiLY3SqgFeeEwMRip+tLdiUD5SnnCOn3J4PxTzZKLptTa4uD1rSrFp04sq99iVJV/YUPqaldv63nXe6rfBvkPy5zoOt05+drdu70bWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HixWft7Z; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so52188945e9.3
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 23:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764661448; x=1765266248; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSXovCUpj4gy/T32A4kPsvembC//OZ7tkk4dj26MmvQ=;
        b=HixWft7ZiKXlTjBgvj2sKCCdwHVnaeLpxVz5SBbmp9Uc6+QihjAjLGQawJZguaLIKn
         ItD5Z/HDql5z22GDy50hkBFvNtGwqR8wCd2pmaLkAcCagboFotahuROtkgZmGHc/10B/
         npWgwc9nprnkccU742Ngzn8PK7j55eCuKSSbmWPeiOxlxQGwXg/QmEG9MazSOCgjd95N
         NMFp2GkBGswbK4xJeZby56RLAgBh5Ol8qH7V97mnVMjyLdJcvJVbPlA9BAVSV38/7ypU
         UcJ2mIoynMqAl3yhvjQEQc1zaP1BFnYYcvDvnsoi83E5l/IbwxFrAXC/7dXNqEX5yg6g
         NFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764661448; x=1765266248;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSXovCUpj4gy/T32A4kPsvembC//OZ7tkk4dj26MmvQ=;
        b=QS3lUkiyElfPAgnuIro1xHhzbYS4nuABfWmYjbIzDgdbVyiJmMFdynHByM6+jGONoN
         eRSiKiVrCUvl6LSUbkSUAZQnKPOdYYWmsa5Ex2jRA6cruf+AHjq0h74Ccg3GpWiV4tcc
         UDJm4skqmExHzAw0XrFBjcs/6pL+G6gA2Nr1jD6BP6P7tOV9ws26b2mMiHL7s1+yZBXt
         f9tMVkAT1jszTkYl1VZ3M2UQEQDDeWplqYvWTZF9GO1Bi2rvJiD/Yi1XtZnzEyyoKtty
         0Lhap5c/87+tLmCRvx4Hh18iQz0we2jLlVURKGz6WG/mWW28hzOx/ELEGKW6fZb/eGYp
         dyMw==
X-Gm-Message-State: AOJu0YzwHVQy+QQ+lEpqvgG92SxkgtMzMEMfZ25gmPoGn+m9YeDp4sBk
	7neUpJ3yQh0o3rfpPwAoKzWtJ/tmxrrdZKrrVJlBuDrCH8EWhFxinZD4xqN9cPOH
X-Gm-Gg: ASbGncsUVNuHJL0VVuAdKyL36d1eBkl9ZrNQGO32R6pY3X/bdL3+ByPBGY2ybJwgpii
	wyvKxG8IdWVZsn1WspECHZ3vfqoRfSGNLW2E8IiG+r0enNBfnzNFBEuj4EW534Fp+xQJBNogF6Y
	RZywTta29sejId82PuMal8r1ZaAJUUa4zADUgg+YAba277JyHu7mumwgZ6Y0h7jiuaDV8zmQ/U4
	+TDP8tnwBVHGrXVuIyUsVogMEJiWdVIMgUllG1AMIo0l4vthetbPthXiPdfdNT7cFUuLBBCzxGn
	OcdukVKesdOCksqYFrPP/lO9rKyAJChaWKRiyz+5XYYmXA5jt8yCKJtgNbPC68an1gFPcubMYzm
	aJ5rrGZS/I5C0EWRPWzQFcchqQRdfZ9XHyYTcca6Mw2Yf8Z7dFN1AkYg9DS+hmAb82bdPISvdMZ
	2QIa6kgq5U3Q==
X-Google-Smtp-Source: AGHT+IHrHXEZqgTMGR9Wlmw0bf5MAUp74lZ8riC3jSj4egp0SLuPIi45Ji4Ie1W9qVG8I0ZXPv4plw==
X-Received: by 2002:a05:600c:a01:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-477c111d3camr434071055e9.14.1764661447620;
        Mon, 01 Dec 2025 23:44:07 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add4b46sm357059465e9.4.2025.12.01.23.44.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Dec 2025 23:44:07 -0800 (PST)
Date: Tue, 2 Dec 2025 07:44:06 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/huge_memory: fix NULL pointer deference when
 splitting folio
Message-ID: <20251202074406.jponflt3xzvlqtj6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <2025120102-geranium-elevator-ca86@gregkh>
 <20251201221818.1285944-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201221818.1285944-1-sashal@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Dec 01, 2025 at 05:18:18PM -0500, Sasha Levin wrote:
>From: Wei Yang <richard.weiyang@gmail.com>
>
>[ Upstream commit cff47b9e39a6abf03dde5f4f156f841b0c54bba0 ]
>
>Commit c010d47f107f ("mm: thp: split huge page to any lower order pages")
>introduced an early check on the folio's order via mapping->flags before
>proceeding with the split work.
>
>This check introduced a bug: for shmem folios in the swap cache and
>truncated folios, the mapping pointer can be NULL.  Accessing
>mapping->flags in this state leads directly to a NULL pointer dereference.
>
>This commit fixes the issue by moving the check for mapping != NULL before
>any attempt to access mapping->flags.
>
>Link: https://lkml.kernel.org/r/20251119235302.24773-1-richard.weiyang@gmail.com
>Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Cc: <stable@vger.kernel.org>
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>[ applied fix to split_huge_page_to_list_to_order() instead of __folio_split() ]
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> mm/huge_memory.c | 17 ++++++++++-------
> 1 file changed, 10 insertions(+), 7 deletions(-)
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index d68a22c729fb3..2065374c7e9e6 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3404,6 +3404,16 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> 	if (new_order >= folio_order(folio))
> 		return -EINVAL;
> 
>+	/*
>+	 * Folios that just got truncated cannot get split. Signal to the
>+	 * caller that there was a race.
>+	 *
>+	 * TODO: this will also currently refuse shmem folios that are in the
>+	 * swapcache.
>+	 */
>+	if (!is_anon && !folio->mapping)
>+		return -EBUSY;
>+

Looks good, thanks.

> 	if (is_anon) {
> 		/* order-1 is not supported for anonymous THP. */
> 		if (new_order == 1) {
>@@ -3466,13 +3476,6 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> 		gfp_t gfp;
> 
> 		mapping = folio->mapping;
>-
>-		/* Truncated ? */
>-		if (!mapping) {
>-			ret = -EBUSY;
>-			goto out;
>-		}
>-
> 		min_order = mapping_min_folio_order(folio->mapping);
> 		if (new_order < min_order) {
> 			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
>-- 
>2.51.0

-- 
Wei Yang
Help you, Help me

