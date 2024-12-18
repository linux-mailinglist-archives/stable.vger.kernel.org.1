Return-Path: <stable+bounces-105170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F9F9F689A
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743C31896618
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F91F2C27;
	Wed, 18 Dec 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+Yyk9kx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD2A1F12FE
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532427; cv=none; b=SiZqLKvGAxAEieqZRY3F2jMGsTK+LlzARSZmqfACWV2jpChX3w7E+0eNy3NnNLGu3kOJ8NpFoF/GxM+FfWFdYOV6Ddofde8v/BE4DHUVpaCJJ/Cx4O2RbOtoUmAPbX9Hv2OAV0O4dSGEj42tPG6qRm/DU1/w/JO119i5Oq9LXjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532427; c=relaxed/simple;
	bh=RHQS28DewYvPrfKfUtYt9opzdVXkf+mdojI6I2d9kGM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=HvyO9cPP6tq4aqbhAOuCGyghZSpDV6k+TYKL5AcLPrOCJLqOF0xla6aJG1cWYLaYSbCKwP6jmXxC2gXIjoy5FT9FFR+HWsjpF8yS9Nj5PM4nLyoWmMrlLeTgiW0o9BKN5YmcQRzBcOssxYlfL6kXrnzHntbWuGGpbumF/BjfirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+Yyk9kx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-801c27e67a6so7145618a12.2
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 06:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734532425; x=1735137225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8/xJoyb6w1jlu83wNixggt1n56YUBqKQLkNI4Qu0JN0=;
        b=M+Yyk9kxIccWc6sqWYYxXT/3LjgsaaMi1Hwm/pZSn9pClKOaI+9CGPXPxC9hEJ4d4x
         oA74LGmGrt16wg+MY1VUdQDyDrYmtmmOoqmUQkBA9+HfTnsW0z0JXYSHQt2Kjw1lRR39
         RlyLBFyaiQZQoe7pDjxTSZziebR2pTXNOzFvc5W5Z+xvlH1oEKUpLt6U7qhy76bSS1eI
         VtgaRxE9kt1Hg7YaSeelwMgSt++qjFr2PB6HUkfiqTRwFuSs+8sTIz2fzDQkDAMEyzrM
         P7cMCGhGiQc1NOwNAunMFsUAiBxF+FEjlRYycLnoStb8mDvmrq9pJypfDvXGWHEJcdgN
         +9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734532425; x=1735137225;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/xJoyb6w1jlu83wNixggt1n56YUBqKQLkNI4Qu0JN0=;
        b=HK9K5N+6SiWvQYxicZn7rrdUPOvGZXbIuPRhE3lgr2klOGFlpIzHZ4mHbGtvbPhuhY
         I1tBgR9j5w2xZ+y+Sc102GOjjAalSDTTa/WI9o3vG8R4SvuZDZgVHlReVySXoj3SiKnx
         Pz27TfRtbr4R+5jm8zxNxbwwnCPzfdol87GWupTpBZINEQV1XUTM+mLyx7igK4jw9uCh
         5ow9UMPMBs1wo4BlWRrkc7d7ZFjIJ5XupSfWWqlyCqhALk6Kbbo+5hsulUD3iS9Uxhcx
         IcBSLTQ61gcFM5mMSf8RZy0KllpJ+nROzdqIRhD38UQWLiVYJHtM6PMEm5BSkKkiSmlV
         l+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVItlIh6qziJL8+eyjJ4QCI4o2jf1iurGRgO2vesB+rQLgM+4vSpffAQQXGRno3KvrGqDDKtqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWUUaQF62WaOoWwBcYYDI/dS3o3+jALWVnzeRbJTpcO+QA2XDE
	FyunReUy1gQWeQFTFh1Bxd7CjH1B/0agNlVvSbiFH489Re52apvg1OxFR3fXYyIAijb5C/o7t9/
	LvezinQmIfGYLQ7fsqPOGUA==
X-Google-Smtp-Source: AGHT+IHUufAPpS8l99EymNtFz8RildaHB41w/vA8gIWEPkTGuh9C6vPrLPov88ikvfsgvPhCy2mT/3z8ZivBiOEJVw==
X-Received: from pfbeb1.prod.google.com ([2002:a05:6a00:4c81:b0:725:ceac:b47e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a104:b0:1e1:3970:d75a with SMTP id adf61e73a8af0-1e5b45f9e04mr4817391637.9.1734532425565;
 Wed, 18 Dec 2024 06:33:45 -0800 (PST)
Date: Wed, 18 Dec 2024 14:33:43 +0000
In-Reply-To: <20241201212240.533824-2-peterx@redhat.com> (message from Peter
 Xu on Sun,  1 Dec 2024 16:22:34 -0500)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzwmfxrrg8.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH 1/7] mm/hugetlb: Fix avoid_reserve to allow taking folio
 from subpool
From: Ackerley Tng <ackerleytng@google.com>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com, 
	leitao@debian.org, akpm@linux-foundation.org, peterx@redhat.com, 
	muchun.song@linux.dev, osalvador@suse.de, roman.gushchin@linux.dev, 
	nao.horiguchi@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Peter Xu <peterx@redhat.com> writes:

> Since commit 04f2cbe35699 ("hugetlb: guarantee that COW faults for a
> process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed"),
> avoid_reserve was introduced for a special case of CoW on hugetlb private
> mappings, and only if the owner VMA is trying to allocate yet another
> hugetlb folio that is not reserved within the private vma reserved map.
>
> Later on, in commit d85f69b0b533 ("mm/hugetlb: alloc_huge_page handle areas
> hole punched by fallocate"), alloc_huge_page() enforced to not consume any
> global reservation as long as avoid_reserve=true.  This operation doesn't
> look correct, because even if it will enforce the allocation to not use
> global reservation at all, it will still try to take one reservation from
> the spool (if the subpool existed).  Then since the spool reserved pages
> take from global reservation, it'll also take one reservation globally.
>
> Logically it can cause global reservation to go wrong.
>
> I wrote a reproducer below

Thank you so much for looking into this!

> <snip>

I was able to reproduce this using your
reproducer. /sys/kernel/mm/hugepages/hugepages-2048kB/resv_hugepages
is not decremented even after the reproducer exits.

  # sysctl vm.nr_hugepages=16 
  vm.nr_hugepages = 16
  # mkdir ./hugetlb-pool
  # mount -t hugetlbfs -o min_size=8M,pagesize=2M none ./hugetlb-pool
  # for i in $(seq 16); do ./a.out hugetlb-pool/test; cat /sys/kernel/mm/hugepages/hugepages-2048kB/resv_hugepages; done
  5
  6
  7
  8
  9
  10
  11
  12
  13
  14
  15
  16
  16
  16
  16
  16
  # 

I'll go over the rest of your patches and dig into the meaning of `avoid_reserve`.

