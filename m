Return-Path: <stable+bounces-105107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EAB9F5D78
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 04:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA321889D02
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 03:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9E13C83D;
	Wed, 18 Dec 2024 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="OWkEei1Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702C1369AA
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492586; cv=none; b=UGm/yWvHqA0hlgsXoyrdbrxFaozfmY0NjlOlq4RaS2nN9bT8P/Nd70GiOaMsHGMnwSYj5068g2Sx66vSB6F1qS8l6vCY2TTLijWrcPUbYyKXTarjFt8/n0KT0XRqb3bpAdM9SiQeSAV5PGn9B452q2fRAvhN4HVM4VwujR9cVWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492586; c=relaxed/simple;
	bh=JZNne1Ljk1aucbGiboAmdbjERrcH99Z/foyj+6vyjWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxslSyubTOCL7ies4F5RTpuEDFnJhbLF8ab/nNYJk0wjmERBi5T/K0b25hzoKiYVg6CJrguirB3hH1A/u7/3qOY1U+/qaU7kNe6GIsAXsu8auv4/wKTa8478uj8QmEkORmfvvPyJlJDcZX/m4LVhBMU+319xHzaCYV0hckDoDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=OWkEei1Q; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b85d5cc39eso121436985a.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 19:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1734492582; x=1735097382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8sFCiqrsFhJd77PzvN7YCxoQJN0smUXicUyoUHy76rU=;
        b=OWkEei1QrHr2ubqx2fM9Zl9kZgVtYUBa/FuAxaLexBdWKMgKWOPiht8ZfqoRDC3h1U
         nfMEOuVxgnatM/gal85K7VfaMpiuO6qs4bfSGZHnkf5RM9RB4S3Hmb5t0akUdp+g1r7c
         w/Vb+LE7f3rytcEaa2cQW5iL4jA1+o0kshTS0n6cO1rASjC22s3GX6B1ZAkUtAaTgeQj
         +gB94Ye1ClE0yG025hwXpCnjB/5urkNNPmTia9dcoMEzWNrqVz8rItXBVqmdm1e43W+C
         ++Er0g0gWXSulYCxNsWyXx4lfxPViocj+1ZUr6vIjkbFlGzw7OhDWOS7QqHKjhL3WBr6
         u1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492582; x=1735097382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sFCiqrsFhJd77PzvN7YCxoQJN0smUXicUyoUHy76rU=;
        b=ZW42WJDAU2rbgZ6M2JsI2y9EJRsZgF7xLggBGw3jkgD5ftHxo2UgfZs51JYR3GuRaG
         FkDVv9t0kpuorFsxXQHAQu2DTgujSEGNi5D6WBm1Gg5yUhgHJ5zNWpWxNeyBqZEQzhRP
         GAzhETaJMARgEI7s+3kpdN0QP2HYbD6v4SNeI4lRBBizNM8kS1py18HNdg6ss7BGNa4p
         dzGLR7Q0V2NY1XKwcHaRxvJPjbngX7e99o7q5+oHcAGhAJsR34Oe9a1+IRxAWosD5T3E
         6Z7pOKl4eGTWPjOX6VRROj2oSbCtzuUzGhv089p6BW7oc0U509hZ98Dl5/qrMOm9MAb9
         3OgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRE3qnUx59TfAloe4NQHh1SqJZwfwOLif24/RsM7Ni5GKwZReSxC2ufoCfuDz3CErfHbCijxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt26Qx55wz4cqiDPmJP/tGTEkDoKKwcLEnEhok6gGAQ7I+YZWa
	QbvrFZQQ+DyFBq3NYRJXa1tQBpA+Pl2d3qpoyUEx7yNlZTt3+FFUvdrqvu3I6O0=
X-Gm-Gg: ASbGncsuoXnqRR9BGZR32uoLiA8fQOLIjc3/2rwMoNX1QIIAdSuzMQp6qt10HKVIm3+
	JjdefNHLx4uV3whCMHmQG1DQ0LWH/5pGA+PgpJ9rQ+tEr+dMIlFhi58dJZjY7JPnEnZou6yV2cS
	9Kf3nDG9iPAkNYtr8OL522z05h2lE/Uy9AFVy5NbuJmaqgHHBdvhysO/p6uLxEEzQvUHLj9ZO4R
	qGoIac2IS8mu7dYNchlYyvbEEqOQRLB3OSGhuhxPfhKwwu8ZvZDek4=
X-Google-Smtp-Source: AGHT+IFeMqWNmRUmKohC9SEkTzUoRaAT605wLZjWlCNLlwn/7mHLCzbu8bekeFz0ggKtPGUhsoEIYA==
X-Received: by 2002:a05:620a:4608:b0:7b6:77f3:b1b0 with SMTP id af79cd13be357-7b86375aa84mr228883485a.24.1734492582351;
        Tue, 17 Dec 2024 19:29:42 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047f3568sm380762285a.64.2024.12.17.19.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:29:40 -0800 (PST)
Date: Tue, 17 Dec 2024 22:29:36 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ge Yang <yangge1116@126.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
	vbabka@suse.cz, liuzixing@hygon.cn
Subject: Re: [PATCH V7] mm, compaction: don't use ALLOC_CMA for unmovable
 allocations
Message-ID: <20241218032936.GB37530@cmpxchg.org>
References: <1734436004-1212-1-git-send-email-yangge1116@126.com>
 <20241217155551.GA37530@cmpxchg.org>
 <93cf1aee-70df-426f-a3c0-1db8068bd59a@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93cf1aee-70df-426f-a3c0-1db8068bd59a@126.com>

On Wed, Dec 18, 2024 at 10:15:06AM +0800, Ge Yang wrote:
> 
> 
> 在 2024/12/17 23:55, Johannes Weiner 写道:
> > Hello Yangge,
> > 
> > On Tue, Dec 17, 2024 at 07:46:44PM +0800, yangge1116@126.com wrote:
> >> From: yangge <yangge1116@126.com>
> >>
> >> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
> >> in __compaction_suitable()") allow compaction to proceed when free
> >> pages required for compaction reside in the CMA pageblocks, it's
> >> possible that __compaction_suitable() always returns true, and in
> >> some cases, it's not acceptable.
> >>
> >> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
> >> of memory. I have configured 16GB of CMA memory on each NUMA node,
> >> and starting a 32GB virtual machine with device passthrough is
> >> extremely slow, taking almost an hour.
> >>
> >> During the start-up of the virtual machine, it will call
> >> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
> >> Long term GUP cannot allocate memory from CMA area, so a maximum
> >> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
> >> machine memory. Since there is 16G of free CMA memory on the NUMA
> >> node, watermark for order-0 always be met for compaction, so
> >> __compaction_suitable() always returns true, even if the node is
> >> unable to allocate non-CMA memory for the virtual machine.
> >>
> >> For costly allocations, because __compaction_suitable() always
> >> returns true, __alloc_pages_slowpath() can't exit at the appropriate
> >> place, resulting in excessively long virtual machine startup times.
> >> Call trace:
> >> __alloc_pages_slowpath
> >>      if (compact_result == COMPACT_SKIPPED ||
> >>          compact_result == COMPACT_DEFERRED)
> >>          goto nopage; // should exit __alloc_pages_slowpath() from here
> >>
> >> Other unmovable alloctions, like dma_buf, which can be large in a
> >> Linux system, are also unable to allocate memory from CMA, and these
> >> allocations suffer from the same problems described above. In order
> >> to quickly fall back to remote node, we should remove ALLOC_CMA both
> >> in __compaction_suitable() and __isolate_free_page() for unmovable
> >> alloctions. After this fix, starting a 32GB virtual machine with
> >> device passthrough takes only a few seconds.
> > 
> > The symptom is obviously bad, but I don't understand this fix.
> > 
> > The reason we do ALLOC_CMA is that, even for unmovable allocations,
> > you can create space in non-CMA space by moving migratable pages over
> > to CMA space. This is not a property we want to lose. But I also don't
> > see how it would interfere with your scenario.
> 
> The __alloc_pages_slowpath() function was originally intended to exit at 
> place 1, but due to __compaction_suitable() always returning true, it 
> results in __alloc_pages_slowpath() exiting at place 2 instead. This 
> ultimately leads to a significantly longer execution time for 
> __alloc_pages_slowpath().
> 
> Call trace:
>   __alloc_pages_slowpath
>        if (compact_result == COMPACT_SKIPPED ||
>           compact_result == COMPACT_DEFERRED)
>            goto nopage; // place 1
>        __alloc_pages_direct_reclaim() // Reclaim is very expensive
>        __alloc_pages_direct_compact()
>        if (gfp_mask & __GFP_NORETRY)
>            goto nopage; // place 2
> 
> Every time memory allocation goes through the above slower process, it 
> ultimately leads to significantly longer virtual machine startup times.

I still don't follow. Why do you want the allocation to fail?

The changelog says this is in order to fall back quickly to other
nodes. But there is a full node walk in get_page_from_freelist()
before the allocator even engages reclaim. There is something missing
from the story still.

But regardless - surely you can see that we can't make the allocator
generally weaker on large requests just because they happen to be
optional in your specific case?

> > There is the compaction_suitable() check in should_compact_retry(),
> > but that only applies when COMPACT_SKIPPED. IOW, it should only happen
> > when compaction_suitable() just now returned false. IOW, a race
> > condition. Which is why it's also not subject to limited retries.
> > 
> > What's the exact condition that traps the allocator inside the loop?
> The should_compact_retry() function was not executed, and the slow here 
> was mainly due to the execution of __alloc_pages_direct_reclaim().

Ok.

