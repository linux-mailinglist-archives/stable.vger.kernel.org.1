Return-Path: <stable+bounces-106224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7F19FD834
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 00:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1786C1642FF
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 23:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1917155352;
	Fri, 27 Dec 2024 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3TvHvrW8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707885626
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735341347; cv=none; b=StH71EhMkhNYwsxm0lYDUzpCaiZfzRjtAX6FUp6jFsnnH31kwpPo/sFCpyrxfq3ECZxCqbispOTX8KXlgDLAD4kMxAN1r/YJPvkLJtIr39XLnbarwDno5ScWbz/g1e5vyj1DBWau6vhpOE/XoVYEw/2Jzja+MCnYPWcjcP1/WHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735341347; c=relaxed/simple;
	bh=i1QBFjgTS0T6ShVTSrbJwyEnTv6x/n8xJ1vOd3nwAZU=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JriPn8ZwWCxdrU/w5MZ4OixA0fsRR08GircWR7Bev5QQ6gxXxYBj23LsHwxmk7r8MauMf51GMvsQCV6zkepI9kWN33UzK1bnDqrvjYGG5Ei2RlDcxVEr9LHnJgsYFVdCXJrcgaMvQWb4FhtO9yyjiBUk6TjZ4EeHcMHGhdmF5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3TvHvrW8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2efc4196ca0so9771514a91.2
        for <stable@vger.kernel.org>; Fri, 27 Dec 2024 15:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735341345; x=1735946145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pYN9ztGBOKvJNFzrcQMWsC4rhR3Yt3k6FRUdi+tvDCY=;
        b=3TvHvrW8JfIPyoce8mgJQ6uCnojZ2FM96SOITfzVSs0e2Iup4SMcez/yTTJW3vy3gc
         Lo5YCTr+3FmIPZhepFi4zceEu9tVg+HDCriZQLPE2kSDQoXqtyl7EYzDQgFyxJBEw2Ql
         7RtKB+9H/m4DX1mhSz9yrE6sceNEyEiqW2dg3b09Olzr/ECTz1q/jx5f7CIIbbGmVIqe
         gmgBTXbaL4UoqlfTT0LRsNbGYe6mg6lbxXwPsWo/UQUYMmwddeKfgRgNFdjKKgNRdE1h
         ve6a9ag0UzLIe407j7yGqzKrWAByxzkn9u8I1spcaEwbEIrBUY7DsZjUoxDrfa0w6BK+
         YSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735341345; x=1735946145;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYN9ztGBOKvJNFzrcQMWsC4rhR3Yt3k6FRUdi+tvDCY=;
        b=aHQYSR6iylJuLWdt5xJQKs7oPwNKhnhkxKmaZkssaQR/FKm1cLTeY896ZtXCLOPosE
         BOa2BijM8ta4IoHdJoNe2S0crSYElgB5c63KfFlOvIlYyBys51LjBB4SNMxg56ir4xS4
         JPGFl4J3jDivH9OL27G7SE7BiM6sCRb7AKRQWkLRErlni0HojMK5KTKGb49KP4t1sWIx
         QGLB5eilfY5TMxl+U9vFbAuUU+FqiPKBcMcfoW7bQq0ohw31fj7dPpBeaoS4fciuomET
         bY5Of7VZQTAQM6SsKJP03sI0iXsvGChxqYNsBQxdA99NGCNGUTzPAi2FEhr58O6PArtd
         bYJg==
X-Forwarded-Encrypted: i=1; AJvYcCUZS6tCTk1VOu1QyHV1svZXkuMjeAUvGDN35xfqy/qsomF4D7v253p2JKj9RmUOfBFHU6mg3hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCOyQ8ym4y9Sl348Oq1OsMzEVmbpAV8Y3Q9kQ14decdwRH0ts
	eXd5nHrsIMfnDUY9/5w+foS3mgO6VJWlBDwNZEoRMFVw/ON1HKDHjI2GGowGRsBlcoQZREEO1eE
	kMi0em+nq6ngAUYo7HbpDMA==
X-Google-Smtp-Source: AGHT+IGYAECDHJ4KsM8Z6EpTiSh3tBGqcEn9YutEFxQ53dQTWNAXX4rILEOQyv0ufEIHQKSHvStzVsVLF+tXsGrdJA==
X-Received: from pfwy41.prod.google.com ([2002:a05:6a00:1ca9:b0:724:f17d:ebd7])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2c86:b0:725:cfa3:bc76 with SMTP id d2e1a72fcca58-72abdd4f2a7mr46778692b3a.4.1735341345609;
 Fri, 27 Dec 2024 15:15:45 -0800 (PST)
Date: Fri, 27 Dec 2024 23:15:44 +0000
In-Reply-To: <diqzwmfxrrg8.fsf@ackerleytng-ctop.c.googlers.com> (message from
 Ackerley Tng on Wed, 18 Dec 2024 14:33:43 +0000)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzed1ssonz.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH 1/7] mm/hugetlb: Fix avoid_reserve to allow taking folio
 from subpool
From: Ackerley Tng <ackerleytng@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: peterx@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	riel@surriel.com, leitao@debian.org, akpm@linux-foundation.org, 
	muchun.song@linux.dev, osalvador@suse.de, roman.gushchin@linux.dev, 
	nao.horiguchi@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> <snip>
>
> I'll go over the rest of your patches and dig into the meaning of `avoid_reserve`.

Yes, after looking into this more deeply, I agree that avoid_reserve
means avoiding the reservations in the resv_map rather than reservations
in the subpool or hstate.

Here's more detail of what's going on in the reproducer that I wrote as I
reviewed Peter's patch:

1. On fallocate(), allocate page A
2. On mmap(), set up a vma without VM_MAYSHARE since MAP_PRIVATE was requested
3. On faulting *buf = 1, allocate a new page B, copy A to B because the mmap request was MAP_PRIVATE
4. On fork, prep for COW by marking page as read only. Both parent and child share B.
5. On faulting *buf = 2 (write fault), allocate page C, copy B to C
    + B belongs to the child, C belongs to the parent
    + C is owned by the parent
6. Child exits, B is freed
7. On munmap(), C is freed
8. On unlink(), A is freed

When C was allocated in the parent (owns MAP_PRIVATE page, doing a copy on
write), spool->rsv_hpages was decreased but h->resv_huge_pages was not. This is
the root of the bug.

We should decrement h->resv_huge_pages if a reserved page from the subpool was
used, instead of whether avoid_reserve or vma_has_reserves() is set. If
avoid_reserve is set, the subpool shouldn't be checked for a reservation, so we
won't be decrementing h->resv_huge_pages anyway.

I agree with Peter's fix as a whole (the entire patch series).

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>

---

Some definitions which might be helpful:

+ h->resv_huge_pages indicates number of reserved pages globally.
    + This number increases when pages are reserved
    + This number decreases when reserved pages are allocated, or when pages are unreserved
+ spool->rsv_hpages indicates number of reserved pages in this subpool.
    + This number increases when pages are reserved
    + This number decreases when reserved pages are allocated, or when pages are unreserved
+ h->resv_huge_pages should be the sum of all subpools' spool->rsv_hpages.

More details on the flow in alloc_hugetlb_folio() which might be helpful:

hugepage_subpool_get_pages() returns "the number of pages by which the global
pools must be adjusted (upward)". This return value is never negative other than
errors. (hugepage_subpool_get_pages() always gets called with a positive delta).

Specifically in alloc_hugetlb_folio(), the return value is either 0 or 1 (other
than errors).

If the return value is 0, the subpool had enough reservations and so we should
decrement h->resv_huge_pages.

If the return value is 1, it means that this subpool did not have any more
reserved hugepages, and we need to get a page from the global
hstate. dequeue_hugetlb_folio_vma() will get us a page that was already
allocated.

In dequeue_hugetlb_folio_vma(), if the vma doesn't have enough reserves for 1
page, and there are no available_huge_pages() left, we quit dequeueing since we
will need to allocate a new page. If we want to avoid_reserve, that means we
don't want to use the vma's reserves in resv_map, we also check
available_huge_pages(). If there are available_huge_pages(), we go on to dequeue
a page.

Then, we determine whether to decrement h->resv_huge_pages. We should decrement
if a reserved page from the subpool was used, instead of whether avoid_reserve
or vma_has_reserves() is set.

In the case where a surplus page needs to be allocated, the surplus page isn't
and doesn't need to be associated with a subpool, so no subpool hugepage number
tracking updates are required. h->resv_huge_pages still has to be updated... is
this where h->resv_huge_pages can go negative?

