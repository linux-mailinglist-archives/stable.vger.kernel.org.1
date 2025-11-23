Return-Path: <stable+bounces-196612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 400FDC7DB6E
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 06:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10E5134200D
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 05:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6CA1F936;
	Sun, 23 Nov 2025 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bf8AUtje"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06884231A3B
	for <stable@vger.kernel.org>; Sun, 23 Nov 2025 05:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763874206; cv=none; b=emsBvnZeQ6o19E8wsm4gzp1iwGGpbeu8XZjpPOv5FPgbaw9YLDz4Z8mqik2/U+GBIDfZF5mFUZk+SaBbKa5QwxouDERPcENk5gl9eV/AsNd9Jw4sGcL8j2J+6EZ/klhOypaOxXjvsWdwbZGpfyhE75B4rENjYuLcKME1gDs1h4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763874206; c=relaxed/simple;
	bh=gdnznlunf6V5kJ+8LSE7ZGeoNWFAAJMEujQuX0gkHb8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hnfVamItgI+mYysHKH5qlmPesPeHEM2lc+ISskpeFhGL5YuPQxm1sbSQW4xdQrxDN01DGCT+9KlwBl+a/C6XZPtrazwsnvEoWaTQ0oqroOJMyVUh69vcGgmc7Qrm3njeD/16zWgG7MjMXff4Wr5/i9sLqCAuMMT7n/ahQxeYNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bf8AUtje; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78a8bed470bso15718437b3.0
        for <stable@vger.kernel.org>; Sat, 22 Nov 2025 21:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763874201; x=1764479001; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AybJ5UMIELXHMKkOiZS4P/7hCmalbEtDzgzlu8wV6aE=;
        b=bf8AUtje1kLC0p00Yw2weKihIYOZhHj1MKo81OeBvqhNSW5/Q+ptEX6SYROR8KHpsJ
         Nd9VXswF2DjB4jCeatq1Kddc91DUSGV7/vSbE1ejAXktneNSS9ac2BD1oC2jM0zkw+1i
         1Bv2kO0fy1Afdtu8tteKLMDnlXcqVoE5Gi5Hr+GPLKT+mNeiNvL9XmLTHKyV0jsYcMXY
         azYlZrMrZerhGD0QaasYpAsVqK3FRVOSxYDt0cxsXW5Kmq4q/T8rKHTXeQqy3vH1Fe/t
         mvlh5muTRxJstdEThPETaZUuO2vaPKYemyJKimzYed42Q5dljNXgHIOkP4eiypBdTE4i
         0GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763874201; x=1764479001;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AybJ5UMIELXHMKkOiZS4P/7hCmalbEtDzgzlu8wV6aE=;
        b=UJaUh13NHp95cYeJYImYiOECJraXYDZTAVx7uGigDQI9URf8RtyTBeuZdNi8vONAvt
         3AEMlzsWUc//OxlivqmHBL8p2ckVM3iRKHLTmZUQIGBm+PfqFp2+8W8Yeptg4mBYYyp3
         PDAecOh+Zr75dOxlBGSFHCsaV5+6zbjLi5MZXl+FZa9ORw5WijaFA8dlFxGZXicu8aeO
         9aleKSgky6SiLmmTErO3ub60jY+SqaYF5jaanfkcY9nf9vXkpjZ2DzWqMn9AIhEhXo9+
         R56a1l3S0lcawu89Q0v5n6I5RcJH7+pt9DKxDuxnvfrvpZWmjED4y2Lohro26ycedcgY
         tSuw==
X-Forwarded-Encrypted: i=1; AJvYcCXJEEHMLAwidFCHw1luEwrrwgNA5drXzmxRbsZCkh1C42NfGEIzLZecJCaJpJPkeP2TwcKYr6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQPI4knUjJV3toTvLMmOtDxgKiGLPNYJfWssjfuMx0it5ezWW
	5DYEmoR7NqrKzdEev52Zop/jcmmTwqfggblMuNqjjQgd1shCClIm5OlxK7giwCPCFA==
X-Gm-Gg: ASbGncvWA//eSbhKztIx0/oVsONEZ1ARFo5MomKpIILJ6ph6RZRlGmPpIz/A2X7sFfh
	fxIee/UUk6+Ddgiqboqe59Hc1i0f6C6etCYBqS8WMm9L3Sert6hhoxXWUgu1qTETyx6alV0sbwl
	a6drMof9hGyNFFlaNS7Ch1ZF5Ru7Q9+sr+ms6PGGPuIudS0k+v4gr93/cPKFFDI9fBbsn2D3trd
	vMvYkeRhli+7WlFAeLIqrR/YHWnoVlaSyfCoOCLFDbtIi22V+Ka6QcFs/ipc3j3WfU9JanwFQf5
	Uneq1Oxpvq1BTH+R8vEH0ysRLnHO4tThNMdgvloj7czdJAt7bVDzzwq0yA30l3eRSV5mK4ajdso
	0n3lxecKwBpmVeeUIqwmDm7SS1Uq1CL8M0vZFFQgSgfvikRvUB+/arMvKDad1UJViuqyzt1+sAm
	6M6v8m90K2SnRQUZt5SwDxRv/kydr5Dvt2O/KloZ3ueuay0UBuqbG8s0JGnGJ0KIyFQkGNDyw=
X-Google-Smtp-Source: AGHT+IEGYdrSAwd7pdkxvSFlcS2lnDuIFTNgH1d7JgF0TaanuJjWvyfi2Xk5mNvHe9lUCvVeN+6cmA==
X-Received: by 2002:a05:690c:3391:b0:787:c18a:189a with SMTP id 00721157ae682-78a8b47adedmr122662667b3.14.1763874200410;
        Sat, 22 Nov 2025 21:03:20 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a799410e5sm31505917b3.48.2025.11.22.21.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 21:03:18 -0800 (PST)
Date: Sat, 22 Nov 2025 21:03:07 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
    Deepanshu Kartikey <kartikey406@gmail.com>
cc: hughd@google.com, baolin.wang@linux.alibaba.com, david@redhat.com, 
    muchun.song@linux.dev, osalvador@suse.de, kraxel@redhat.com, 
    airlied@redhat.com, jgg@ziepe.ca, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, vivek.kasireddy@intel.com, 
    syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/memfd: fix information leak in hugetlb folios
In-Reply-To: <20251112145034.2320452-1-kartikey406@gmail.com>
Message-ID: <a4319c8a-4e81-00de-f184-844348d85681@google.com>
References: <20251112145034.2320452-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Nov 2025, Deepanshu Kartikey wrote:

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

Acked-by: Hugh Dickins <hughd@google.com>

Sorry if you were all waiting on a Ack from me.  We're agreed that
the comment above __folio_mark_uptodate() could be deleted, and that
it would be much better if this code can be moved to a shared home
in hugetlb later on; but for now it's more urgent to get this patch
into hotfixes and on to Linus - please Andrew.

Thanks!
Hugh

> ---
> 
> v1 -> v2:
> - Use folio_zero_user() instead of folio_zero_range() (optimized for huge pages)
> - Add folio_mark_uptodate() before adding to page cache
> - Add hugetlb_fault_mutex locking around hugetlb_add_to_page_cache()
> - Add Fixes: tag and Cc: stable for backporting
> - Add Suggested-by: tags for Oscar and David
> ---
>  mm/memfd.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 1d109c1acf21..d32eef58d154 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -96,9 +96,36 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>  						    NULL,
>  						    gfp_mask);
>  		if (folio) {
> +			u32 hash;
> +
> +			/*
> +			 * Zero the folio to prevent information leaks to userspace.
> +			 * Use folio_zero_user() which is optimized for huge/gigantic
> +			 * pages. Pass 0 as addr_hint since this is not a faulting path
> +			 *  and we don't have a user virtual address yet.
> +			 */
> +			folio_zero_user(folio, 0);
> +
> +			/*
> +			 * Mark the folio uptodate before adding to page cache,
> +			 * as required by filemap.c and other hugetlb paths.
> +			 */
> +			__folio_mark_uptodate(folio);
> +
> +			/*
> +			 * Serialize hugepage allocation and instantiation to prevent
> +			 * races with concurrent allocations, as required by all other
> +			 * callers of hugetlb_add_to_page_cache().
> +			 */
> +			hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
> +			mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +
>  			err = hugetlb_add_to_page_cache(folio,
>  							memfd->f_mapping,
>  							idx);
> +
> +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +
>  			if (err) {
>  				folio_put(folio);
>  				goto err_unresv;
> -- 
> 2.43.0

