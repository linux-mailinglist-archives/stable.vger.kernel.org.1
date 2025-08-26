Return-Path: <stable+bounces-172919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E902B3536D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 07:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10469172D30
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 05:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880F22ED15D;
	Tue, 26 Aug 2025 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB7Lme5P"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E011CA9;
	Tue, 26 Aug 2025 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186736; cv=none; b=tYZHE+u92eOKRgboVGU9yPQS5EUn4UtqwxoNoV+Ww3YcmF0AJ5tvilyfOfkcWvaZrd8ewC0nk+C+f1zw8a9ew7ZmqXxaZrvJopeDjtXJkqVPt8J1faFuEOPpU93KJdR26J4cW8JBzL9AtMPhugTBIvwUTibmU6Yo4dlARYOpHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186736; c=relaxed/simple;
	bh=fkEI3+r7fkyCvE6gJngNZ+Zm3/fQ8nxEzZgG4A1l2I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPMHcs5y+diGAI5hft9EBtoY4FQphEpMpm/iT8VuOVUbVEikkP7UPNeIotCGJZbx8dAb2btNQJfmzOuOfwzzvc5dN9Qsmira0IyyW0YBXK1ajuFsgtQqz3jGCgo0mio/p5R6iFW+3OlTCduceZDNJG38joaRtC06Qjaw0f20mIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BB7Lme5P; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24458272c00so60601745ad.3;
        Mon, 25 Aug 2025 22:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756186734; x=1756791534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Axk4UMbWJGlYVE8LjjJYFMnLZB/ZM8rZIyTcTh59eoY=;
        b=BB7Lme5PwH/P7dyvtRCeQuP6LHy5RosuwE/pN2nLHEt9B48HIZ98viX8WlNBTZdgJx
         Q7vgLAsTB3TlBtXOAuuFveQIYG4mFXdyTwTtfLknh7b3HbxG75hFfR2Vh8TBmvyCGszG
         oRywDG8C76cPmVVlutESFmX7L+vo++9zHslNT+68tt9LodV9Hu4cFim9UR2HlHYVHLbR
         SJ0Ia4GflUKhtp/RSBwvU8WPNje9F2bK613aF20vXVUsUK5cs46uzzi0dP2iqxo1Cc+P
         HN9/xWTnch/8iDZXfQqdYv+1c+xbATtpwl3Gf2oyucfEeolZO9SRnPinsx24UCMkoigM
         ci4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756186734; x=1756791534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Axk4UMbWJGlYVE8LjjJYFMnLZB/ZM8rZIyTcTh59eoY=;
        b=NDcfJd1XqqbP6d15TQB7wEd6UYh+c+dNnVpBVp/NBfkpNRHhgkn39+PimHTGD9sQXQ
         swWbGcb+T/wcz+VmSved7jqvR6MaHKkM1H8qzHby7r9W80zEZZZuFZuObahISI/XxGWK
         R4AbHHIgVQbvEdtoSmUY7IrwiNJ7nVPOnW0ntGJhTVDDfC2AhOWinkROiYfRoV4NIitQ
         RcTxNMO8BHVUkTrVrxFh9sDpLk9DPk94YjJK9QHutO8ZiGoTfOxzxJLJrlMok/AnH+4N
         QwoZp29sfiMEBfTSQKPvdkqggPXTXd+oBeAOmoS/R5vA1G7EwfDkYMctGhOvy1Q5rGEG
         aHTA==
X-Forwarded-Encrypted: i=1; AJvYcCW6i6eGtWxTxit30COyvAH91HP3gbXHKWAuzIOKJQZKIxt2Q/aIiiYREKEmd0mH7TF70RXfSg/p@vger.kernel.org, AJvYcCXAqeruvUBPQW6zO5zFGjGTHJyvuCpeLKGLTM1/JQARAlXeCE6W3rr03nI1/QIahiBBsF4GQauJ040DX6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJprlPn+sSVla5BQ9mtS0bbD41V6+YFLzK1Sx+CrlrLFn4IiL
	T5p2ulV8JTgMowL3Rm03KCHDseKtaRLZ2Xe1VGhRIqVIORdYsAiuaV6Ve9QZqstFRSv04eikXKo
	laE3L+Az0JR7R6awIo11EBOTNiqLbGHs=
X-Gm-Gg: ASbGncteGuWAh+4vxTMqfkkHRVJ7ohET36qVpckYa0+T6myN2VDCKPXRboPn8HYWG2Z
	NdUhlZTDhOXKCkatj3EAPmJIOoiKpA/HmTzD9uLkYbysNGgGF6Wt0MZ/62ye0r7H8hoW3peTC1B
	GpY6rjo801JyJo0Nbi9D5ZO5YGTTn7gG51hI6KRjWOiKKcBSMjg0FTXiIMc+nvJqzM8X9BKuuy4
	CwHKty1cg==
X-Google-Smtp-Source: AGHT+IF4WuKBgonA7wU0ychyL9+0BwzHp/2OyDxJKY+LcRtfGkh/0Hes5UCWFkbHCHBvEeIsWBm5YuUo9FxCtDtnwqo=
X-Received: by 2002:a17:902:d54a:b0:246:eac1:50cf with SMTP id
 d9443c01a7336-246eac1548cmr69886865ad.12.1756186733913; Mon, 25 Aug 2025
 22:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823182115.1193563-1-aha310510@gmail.com>
In-Reply-To: <20250823182115.1193563-1-aha310510@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 26 Aug 2025 14:38:46 +0900
X-Gm-Features: Ac12FXzfcd38LF-GMC-8K74D550K73mNo7BnkYALEHmVGNLD52tzBppBnZCL1DI
Message-ID: <CAO9qdTF1OZRX0mbcG9hQy8m32RvrZaEBa0EWpDREBjfBSqrrYg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hugetlb: add missing hugetlb_lock in __unmap_hugepage_range()
To: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com, 
	akpm@linux-foundation.org
Cc: leitao@debian.org, sidhartha.kumar@oracle.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Jeongjun Park <aha310510@gmail.com> wrote:
>
> When restoring a reservation for an anonymous page, we need to check to
> freeing a surplus. However, __unmap_hugepage_range() causes data race
> because it reads h->surplus_huge_pages without the protection of
> hugetlb_lock.
>
> And adjust_reservation is a boolean variable that indicates whether
> reservations for anonymous pages in each folio should be restored.
> Therefore, it should be initialized to false for each round of the loop.
> However, this variable is not initialized to false except when defining
> the current adjust_reservation variable.
>
> This means that once adjust_reservation is set to true even once within
> the loop, reservations for anonymous pages will be restored
> unconditionally in all subsequent rounds, regardless of the folio's state.
>
> To fix this, we need to add the missing hugetlb_lock, unlock the
> page_table_lock earlier so that we don't lock the hugetlb_lock inside the
> page_table_lock lock, and initialize adjust_reservation to false on each
> round within the loop.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=417aeb05fd190f3a6da9
> Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Sorry, I forgot to add the reviewed-by tag.

> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
> v2: Fix issues with changing the page_table_lock unlock location and initializing adjust_reservation
> - Link to v1: https://lore.kernel.org/all/20250822055857.1142454-1-aha310510@gmail.com/
> ---
>  mm/hugetlb.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 753f99b4c718..eed59cfb5d21 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5851,7 +5851,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>         spinlock_t *ptl;
>         struct hstate *h = hstate_vma(vma);
>         unsigned long sz = huge_page_size(h);
> -       bool adjust_reservation = false;
> +       bool adjust_reservation;
>         unsigned long last_addr_mask;
>         bool force_flush = false;
>
> @@ -5944,6 +5944,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>                                         sz);
>                 hugetlb_count_sub(pages_per_huge_page(h), mm);
>                 hugetlb_remove_rmap(folio);
> +               spin_unlock(ptl);
>
>                 /*
>                  * Restore the reservation for anonymous page, otherwise the
> @@ -5951,14 +5952,16 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>                  * If there we are freeing a surplus, do not set the restore
>                  * reservation bit.
>                  */
> +               adjust_reservation = false;
> +
> +               spin_lock_irq(&hugetlb_lock);
>                 if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
>                     folio_test_anon(folio)) {
>                         folio_set_hugetlb_restore_reserve(folio);
>                         /* Reservation to be adjusted after the spin lock */
>                         adjust_reservation = true;
>                 }
> -
> -               spin_unlock(ptl);
> +               spin_unlock_irq(&hugetlb_lock);
>
>                 /*
>                  * Adjust the reservation for the region that will have the
> --

