Return-Path: <stable+bounces-166730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89E1B1CA1C
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751BF3B51A6
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E610529A303;
	Wed,  6 Aug 2025 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDJHqOQC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359E28A41C
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499371; cv=none; b=GhIxL8pzwhnXVT6IQNO7zhZhdO8/MFVW9meYSs0Z+2iH7IjIaLDkvThkqTMuty7TAz1qa7OgH4W8ioE5tlMsrvcESxkPEW5KGtcwdF+thC6WDb6FvsbgQpYVM+1eKGX1oBR1wbMtewQPmKoz48k8vzZu/mJyBi1hmmufRzjNTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499371; c=relaxed/simple;
	bh=YA2xMm6GZPpLepmZMpJHF6c54ioYllFRdsNz97VVNgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6FpA0AalNBKrVhRYavSKaRwW7Rl7NxA5TnaxzhA78IZd/AmsA9Pg5d8c9monTUy/LKBJZfzZIDxkdslceI0TMVSbSkTZWr+0wvrt/3jUsI9qzI2IOZvUqYvKvoXmWwOxJM3F94+mHMfK5XEGChMFqCIiLhEuA7igbHniAdvlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDJHqOQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754499369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=caRxOupOwvLDE4AxnGKjW2rkeHCX/7D6A5vP6Lpr8sU=;
	b=jDJHqOQCmg/7dsVikCkHwB8nlPG5jR+4pTIH0uYVTSgmcsR/mdZ7vOUNE9xJj0ZwbiiGYe
	cKlAP/cnTEgcXOfYwYFU6LoGyRj2NETEGU2qKOfX5o40VVWVv0A1wkT9F/ACgbCftTwQoU
	1RqU5z8S7mBthNcAwJT4679OaTSQHyc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-QKxOj7NaODOkTKrjoyJfAA-1; Wed, 06 Aug 2025 12:56:07 -0400
X-MC-Unique: QKxOj7NaODOkTKrjoyJfAA-1
X-Mimecast-MFC-AGG-ID: QKxOj7NaODOkTKrjoyJfAA_1754499367
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70e7f66cd58so475007b3.1
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 09:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754499367; x=1755104167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caRxOupOwvLDE4AxnGKjW2rkeHCX/7D6A5vP6Lpr8sU=;
        b=YuHqeYV465aIOqWx4xNU6kSWKUDJKX4KOV7ntt/z589+/mtBOoL8INaKLU6z+rzeiK
         iQgPlxoucZBqg3+v70XuF6fx9aOntWBJdYoVrFQ734dz0fiGja8TpWqHENKdYVFRoU2P
         Kykc79vBwrc2MBYP+T9u6eIkSn/79PGTXKh5yRkeKiJkJ9u+2/W/gWy5oLtPUjKrP95E
         0j4LH4A8tI51U6zG14rit55bIGHQ/dD9MWjjzVJ+zgrAMYrGhxRqhf2FV6WIWgMPOOOF
         ZG+WDD7Fn72kAes3D8aMbZCqGuzUGdIQGW1eXs7tar+ytpxjwCmToef6YdBcGgRtCGJM
         vhow==
X-Forwarded-Encrypted: i=1; AJvYcCVyMwmZdZrI6f4XFCQx3CRzJyTbmj4yWL3jHfFGZ7QyL6CiX8rNK5dFLrVlm09Ytr+jCoBCR+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgY4ANAf4hBcXy/OUHZPt0lvmeW0aCRjwjTx/vik/Vy/qGvk7X
	g8WmtGRJ9ck1spiN/gAd7Ku9Q8ZtltzvFG0lGwh8oZ+AECVUE8qyRjvWgFoTyLlonkouBdGpcPn
	fvXBulHMqhNpOaoI7gQStXUSfPP/FhNbgTKVB8jONnPma5pi7DjO5lzkvOA==
X-Gm-Gg: ASbGncuW7Ph9FPUkiyyxAxd4vR4//sFrH7MgIbiXkoeGwBb9+0/85IjzoubHFZDjyC3
	HxqKMg2rq9QPg+Upmd0GHtQ7O3E+dTm8ugIG06zOtfPyz5gTX55+OB0civrt52HkD7FL2onAwV8
	opb8g0/qUGQKr3/A9g6LNjEJyfZRAKXQMwlU0tSmUWEK+ogyr/cgks6eJrXuYbV0FWdOlkTX3yv
	2WfmX/5L+5Q60H35dcZD+ITL+NY3VoZkUAZ4EObXH9GJe84W2LOulr1wr2HqBufNBIF/CJxArUx
	aGB2PWIvfgoQHNkgUnC42PB8IRVywLYIgT6sF9b3xkXlYQTS068Wd9DCLMg4svsqBQnkYVCF1vr
	wy/one/4hDRCH1Zr3tViPcA==
X-Received: by 2002:a05:690c:3588:b0:71b:6ad2:d10d with SMTP id 00721157ae682-71bc9710de2mr45651867b3.11.1754499366756;
        Wed, 06 Aug 2025 09:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQh+vw6wvMh/Vx0bRJhyUZIPHP4wgxRJuDS2ljLQE7fUIxuqSyVdyg6fKn8o5oDzXI3s/eew==
X-Received: by 2002:a05:690c:3588:b0:71b:6ad2:d10d with SMTP id 00721157ae682-71bc9710de2mr45651537b3.11.1754499366296;
        Wed, 06 Aug 2025 09:56:06 -0700 (PDT)
Received: from x1.local (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ba7634498sm18397677b3.58.2025.08.06.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:56:05 -0700 (PDT)
Date: Wed, 6 Aug 2025 12:56:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, aarcange@redhat.com,
	lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] userfaultfd: fix a crash in UFFDIO_MOVE with some
 non-present PMDs
Message-ID: <aJOJI-YZ0TTxEzV9@x1.local>
References: <20250806154015.769024-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806154015.769024-1-surenb@google.com>

On Wed, Aug 06, 2025 at 08:40:15AM -0700, Suren Baghdasaryan wrote:
> When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it

The migration entry can appear with/without ALLOW_SRC_HOLES, right?  Maybe
drop this line?

If we need another repost, the subject can further be tailored to mention
migration entry too rather than non-present.  IMHO that's clearer on
explaining the issue this patch is fixing (e.g. a valid transhuge THP can
also have present bit cleared).

> encounters a non-present PMD (migration entry), it proceeds with folio
> access even though the folio is not present. Add the missing check and

IMHO "... even though folio is not present" is pretty vague.  Maybe
"... even though it's a swap entry"?  Fundamentally it's because of the
different layouts of normal THP v.s. a swap entry, hence pmd_folio() should
not be used on top of swap entries.

> let split_huge_pmd() handle migration entries.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org
> ---
> Changes since v2 [1]
> - Updated the title and changelog, per David Hildenbrand
> - Removed extra checks for non-present not-migration PMD entries,
> per Peter Xu
> 
> [1] https://lore.kernel.org/all/20250731154442.319568-1-surenb@google.com/
> 
>  mm/userfaultfd.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 5431c9dd7fd7..116481606be8 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>  			/* Check if we can move the pmd without splitting it. */
>  			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
>  			    !pmd_none(dst_pmdval)) {
> -				struct folio *folio = pmd_folio(*src_pmd);
> -
> -				if (!folio || (!is_huge_zero_folio(folio) &&
> -					       !PageAnonExclusive(&folio->page))) {
> -					spin_unlock(ptl);
> -					err = -EBUSY;
> -					break;
> +				/* Can be a migration entry */
> +				if (pmd_present(*src_pmd)) {
> +					struct folio *folio = pmd_folio(*src_pmd);
> +
> +					if (!folio || (!is_huge_zero_folio(folio) &&
> +						       !PageAnonExclusive(&folio->page))) {
> +						spin_unlock(ptl);
> +						err = -EBUSY;
> +						break;
> +					}
>  				}

The change itself looks all correct, thanks.  If you agree with above
commit message / subject updates, feel free to take this after some
amendment of the commit message:

Reviewed-by: Peter Xu <peterx@redhat.com>

>  
>  				spin_unlock(ptl);
> 
> base-commit: 8e7e0c6d09502e44aa7a8fce0821e042a6ec03d1
> -- 
> 2.50.1.565.gc32cd1483b-goog
> 

-- 
Peter Xu


