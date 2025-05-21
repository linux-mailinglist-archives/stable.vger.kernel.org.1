Return-Path: <stable+bounces-145876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F273AABF8E4
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF8C17DF39
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A50A1E25F2;
	Wed, 21 May 2025 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjkdCnYg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CDD1E1C09
	for <stable@vger.kernel.org>; Wed, 21 May 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840265; cv=none; b=iQaHn7Q6Japtwhet77OlDAFRSjT1bvZ/ywvrHykabD4xI7Jqy5323PY2vcwTgs6n4Y+ECmYrAHJ/7Ld9JnzEigfSwNz+wb/zx7aji9TBA8CgkELxmkOPxjrESaIVSeZTxDgqOFga89CGZO+teOoOS3enOA7SG4BnXG8GWJQ1yV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840265; c=relaxed/simple;
	bh=MgusqrsP4jQRvN2ZbwgHtJHD9vJReGL/eON2O25Ohe4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DF6nK2+JApXOxBXnYDTMBfC5T0XC213LoAgzWmCOsgvrNPEIKmtDRYihU+pKXNvsYQJyHK+Wdesk5TVv5kS8Nz8bPbPi5c2KZ3VZhfb33mMlJcnFAs781LtLOq2eUIDLrQ+jKKiVu5NTGbGyAuIurUbR7LFir4gyccUJ6i5JsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjkdCnYg; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7352da8fde3so764993a34.1
        for <stable@vger.kernel.org>; Wed, 21 May 2025 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747840263; x=1748445063; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q9i49PuCqE8syzOpxQq46ilt6U5tDrx4U1lPzUK5JhQ=;
        b=GjkdCnYgi1vtn18uDRruBzcSz+qchWx/m3043M98MPbZkkaX0T/0Qkti48oa3P237W
         okgEkX3zrWrmKdm+TrUMYPsdawL/0bQZ2dI2ZzPxt09Sy0WEQJckV9tugHRGD0+vKriq
         maSQ7WEJjW3BJJDn8Zqa3fctpl9mM2fmMy2VwB8QwTdbJhbi/XYnzAsr6A/imWbuyJq7
         d1XN4J1+f1hGXTtrHRuz5DvPtzCrEjJvx3XEEtjMp65bc70UdVo4EiKqQ4O9JXe+3/zS
         CgIEDodR9Onj5o7SNE7mLltNvXWuwsHxUQ2JZn0efRPfW17iz/h17baZOu2iRyKgLt66
         Y9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747840263; x=1748445063;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9i49PuCqE8syzOpxQq46ilt6U5tDrx4U1lPzUK5JhQ=;
        b=kcWu8kzFkxNeLIYhDfOZmqLRWFLvaUEZ4LLTBXI2ZdPoMtCdMn6M6RZdakty67lBad
         /Aet0SecQUZFwst4C0GHI1+x9ukNpjX3/rvqtTFIE0W036+KXkVu0XHYieyOKtA1xpTo
         x7Z/Bv2T3lfO5MnTEuie5uzDj6mCjmdIFkjSK+R4mp/9n59uq8zLgBK/X/2dA29se9LS
         HVeNrlITl8GUMYMPrY3pL8WZfrnGAXnrZ4idU75KgTmQlrehxyd9TNnpq8O1BQhwMs4r
         ZPQsIfniSKdYl5ZSu5XUnwXSzWpBOdDHF4bDscMUnLs7gFdj09yM3o+n33oy8uUSytWt
         RU5A==
X-Forwarded-Encrypted: i=1; AJvYcCXDuwSNDiQ4S3dtL3aF53UQRpS4g2YfumCap2Hh4XmjpSwr4PG1HEas/x0AR949Wp7RoYkT9w4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz67Ox5cUxsrLrDeuvQtA+o16Vosgvo9VUwmNx0mzu+H5RzqIj
	dV0ESObsPuH9P5Mu4mJ626cbIltVQxJ9gXm1+kG6aNMN5VxDqPV6QH+VI/Y6iFVT1g==
X-Gm-Gg: ASbGnctiFbmd+GPVBqCzrbHnvAT8IMelBOWeTLareAfqkOfkbilRhWjJ/6walDm+WMY
	ReoZ98RU+h0mPi1VVDpNZLxIydG45VrR+8OIsoeI/OwpAhFxN0J0CAGU2OJfMIs9ROA+ulq5Esw
	RZnYYw5Vupdh0WVDJ80XAmaA0JSlMjtZCV7frIBICzH+64Ibn11EhCK3Hl7fPu5Pr7F2X2uh4y3
	t/f9wzAK1XBeU83yR4wc4AKzFK7cTOf4Owbn9o8YkINeNjyPlI1mf7HmYQBSNxVWipWTRHa3884
	XGjgJm41MHFvrD9LQDocvnX6/G9ClpEiIpM0RYx7nPyiNNNy0xivY7oCwtJ53Gu2sDFRDzJXPju
	33PNP1QHlEL4ABEeuhn36LzC8hTQgv1cIpOEIKb7ng++WgQ==
X-Google-Smtp-Source: AGHT+IFd0X9cejNLaHAapyuvMyXDy1BdBiZcRkj1K61S3pTev9a+43FMuQ1GnPCmniq9Zk65ksWmaw==
X-Received: by 2002:a05:6830:6404:b0:72a:d54:a780 with SMTP id 46e09a7af769-734f6b61b16mr14246398a34.17.1747840262558;
        Wed, 21 May 2025 08:11:02 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6b60081sm2158746a34.56.2025.05.21.08.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:11:01 -0700 (PDT)
Date: Wed, 21 May 2025 08:10:46 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Gavin Guo <gavinguo@igalia.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev, 
    osalvador@suse.de, akpm@linux-foundation.org, mike.kravetz@oracle.com, 
    kernel-dev@igalia.com, stable@vger.kernel.org, 
    Hugh Dickins <hughd@google.com>, Florent Revest <revest@google.com>, 
    Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
In-Reply-To: <20250521115727.2202284-1-gavinguo@igalia.com>
Message-ID: <30681817-6820-6b43-1f39-065c5f1b3596@google.com>
References: <20250521115727.2202284-1-gavinguo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 21 May 2025, Gavin Guo wrote:
>...
> V1 -> V2
> Suggested-by Oscar Salvador:
>   - Use folio_test_locked to replace the unnecessary parameter passing.
> 
>  mm/hugetlb.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7ae38bfb9096..ed501f134eff 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6226,6 +6226,12 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>  			u32 hash;
>  
>  			folio_put(old_folio);
> +			/*
> +			 * The pagecache_folio needs to be unlocked to avoid
> +			 * deadlock when the child unmaps the folio.
> +			 */
> +			if (pagecache_folio)
> +				folio_unlock(pagecache_folio);
>  			/*
>  			 * Drop hugetlb_fault_mutex and vma_lock before
>  			 * unmapping.  unmapping needs to hold vma_lock
> @@ -6823,8 +6829,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  out_ptl:
>  	spin_unlock(vmf.ptl);
>  
> +	/*
> +	 * hugetlb_wp() might have already unlocked pagecache_folio, so
> +	 * skip it if that is the case.
> +	 */
>  	if (pagecache_folio) {
> -		folio_unlock(pagecache_folio);
> +		if (folio_test_locked(pagecache_folio))
> +			folio_unlock(pagecache_folio);
>  		folio_put(pagecache_folio);
>  	}
>  out_mutex:

NAK!

I have not (and shall not) review V1, but was hoping someone else
would save me from rejecting this V2 idea immediately.

Unless you have a very strong argument why this folio is invisible to
the rest of the world, including speculative accessors like compaction
(and the name "pagecache_folio" suggests very much the reverse): the
pattern of unlocking a lock when you see it locked is like (or worse
than) having no locking at all - it is potentially unlocking someone
else's lock.

Hugh

